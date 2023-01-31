inherited fmMarketingContact: TfmMarketingContact
  Left = 147
  Top = 114
  HelpContext = 713000
  Caption = 'Marketing Contacts'
  ClientHeight = 484
  ClientWidth = 914
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 147
  ExplicitTop = 114
  ExplicitWidth = 930
  ExplicitHeight = 523
  DesignSize = (
    914
    484)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel6: TBevel [0]
    Left = 818
    Top = 408
    Width = 83
    Height = 61
    HelpContext = 713171
  end
  object Bevel5: TBevel [1]
    Left = 818
    Top = 338
    Width = 83
    Height = 61
    HelpContext = 713172
  end
  inherited lblSkingroupMsg: TLabel
    Top = 484
    Width = 914
    HelpContext = 713013
    ExplicitTop = 484
    ExplicitWidth = 914
  end
  object Label36: TLabel [3]
    Left = 833
    Top = 344
    Width = 55
    Height = 29
    HelpContext = 713012
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Contact is Active'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object DBText1: TDBText [7]
    Left = 758
    Top = 24
    Width = 156
    Height = 38
    Cursor = crHandPoint
    HelpContext = 713014
    Alignment = taCenter
    DataField = 'ConvertedDesc'
    DataSource = dsMarketingContacts
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    OnClick = DBText1Click
  end
  object Label16: TLabel [9]
    Left = 833
    Top = 414
    Width = 55
    Height = 29
    HelpContext = 713173
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Do Not Contact'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object cmdCancel: TDNMSpeedButton [10]
    Left = 814
    Top = 127
    Width = 87
    Height = 27
    HelpContext = 713016
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = cmdCancelClick
  end
  object cmdNew: TDNMSpeedButton [11]
    Left = 814
    Top = 170
    Width = 87
    Height = 27
    Hint = '"Add A New Customer"'
    HelpContext = 713017
    Anchors = [akTop, akRight]
    Caption = 'Ne&w'
    DisableTransparent = False
    Font.Charset = RUSSIAN_CHARSET
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
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = cmdNewClick
  end
  object cmdPrint: TDNMSpeedButton [12]
    Left = 814
    Top = 213
    Width = 87
    Height = 27
    Hint = '"Print This Customer"'
    HelpContext = 713018
    Anchors = [akTop, akRight]
    Caption = 'Prin&t'
    DisableTransparent = False
    Enabled = False
    Font.Charset = RUSSIAN_CHARSET
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
    TabOrder = 4
    AutoDisableParentOnclick = True
    OnClick = cmdPrintClick
  end
  object chkActive: TDBCheckBox [13]
    Left = 854
    Top = 377
    Width = 14
    Height = 15
    HelpContext = 713019
    Anchors = [akRight, akBottom]
    Color = 13303807
    DataField = 'Active'
    DataSource = dsMarketingContacts
    ParentColor = False
    TabOrder = 7
    ValueChecked = 'T'
    ValueUnchecked = 'F'
  end
  object txtCompany: TDBMemo [14]
    Left = 124
    Top = 50
    Width = 633
    Height = 25
    HelpContext = 713020
    TabStop = False
    Alignment = taCenter
    DataField = 'COMPANY'
    DataSource = dsMarketingContacts
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object pnlTitle: TDNMPanel [15]
    Left = 144
    Top = 6
    Width = 593
    Height = 39
    HelpContext = 713021
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 589
      Height = 35
      HelpContext = 713022
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
        Width = 589
        Height = 35
        HelpContext = 713023
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Marketing Contacts'
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
  object mainPage: TPageControl [16]
    Left = 0
    Top = 84
    Width = 806
    Height = 399
    HelpContext = 713024
    ActivePage = Customer_Info
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    TabHeight = 25
    TabOrder = 0
    TabWidth = 267
    OnChange = mainPageChange
    OnChanging = mainPageChanging
    OnResize = mainPageResize
    object Customer_Info: TTabSheet
      HelpContext = 713025
      Caption = 'C&ontact Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 798
        Height = 339
        HelpContext = 713026
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          798
          339)
        object Bevel4: TBevel
          Left = 620
          Top = 5
          Width = 173
          Height = 155
          HelpContext = 713027
        end
        object Bevel23: TBevel
          Left = 347
          Top = 164
          Width = 447
          Height = 165
          HelpContext = 713028
          Anchors = [akLeft, akTop, akBottom]
        end
        object Box70: TBevel
          Left = 348
          Top = 6
          Width = 272
          Height = 155
          HelpContext = 713029
        end
        object Box69: TBevel
          Left = 10
          Top = 7
          Width = 333
          Height = 322
          HelpContext = 713030
        end
        object Label25: TLabel
          Left = 74
          Top = 18
          Width = 56
          Height = 15
          HelpContext = 713031
          Alignment = taRightJustify
          Caption = 'Company:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label27: TLabel
          Left = 76
          Top = 96
          Width = 54
          Height = 15
          HelpContext = 713032
          Alignment = taRightJustify
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
          Left = 69
          Top = 136
          Width = 61
          Height = 15
          HelpContext = 713033
          Alignment = taRightJustify
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
          Left = 69
          Top = 175
          Width = 61
          Height = 15
          HelpContext = 713034
          Alignment = taRightJustify
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
          Left = 365
          Top = 14
          Width = 84
          Height = 15
          HelpContext = 713035
          Alignment = taRightJustify
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
          Left = 381
          Top = 44
          Width = 68
          Height = 15
          HelpContext = 713036
          Alignment = taRightJustify
          Caption = 'Fax Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label178: TLabel
          Left = 364
          Top = 75
          Width = 85
          Height = 15
          HelpContext = 713037
          Alignment = taRightJustify
          Caption = 'Mobile Number'
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
          Left = 395
          Top = 105
          Width = 54
          Height = 15
          HelpContext = 713038
          Alignment = taRightJustify
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
        object Label5: TLabel
          Left = 75
          Top = 294
          Width = 55
          Height = 15
          HelpContext = 713039
          Alignment = taRightJustify
          Caption = 'Employee'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label48: TLabel
          Left = 64
          Top = 215
          Width = 66
          Height = 18
          HelpContext = 713040
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Job Title'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label11: TLabel
          Left = 45
          Top = 57
          Width = 85
          Height = 15
          HelpContext = 713041
          Alignment = taRightJustify
          Caption = 'Company Type:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblRelatedCust: TLabel
          Left = 349
          Top = 168
          Width = 109
          Height = 15
          HelpContext = 713042
          Caption = 'Related Customers'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label9: TLabel
          Left = 39
          Top = 254
          Width = 91
          Height = 18
          HelpContext = 713043
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Employee Size'
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
          Left = 628
          Top = 16
          Width = 74
          Height = 15
          HelpContext = 713044
          Caption = 'Call Priority : '
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
          Left = 628
          Top = 65
          Width = 132
          Height = 15
          HelpContext = 713045
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
        object Label4: TLabel
          Left = 378
          Top = 136
          Width = 71
          Height = 15
          HelpContext = 713046
          Alignment = taRightJustify
          Caption = 'Skype Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblCreatedOn: TLabel
          Left = 628
          Top = 114
          Width = 74
          Height = 15
          HelpContext = 713047
          Alignment = taRightJustify
          Caption = 'Date Created'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object grdRelatedClient: TwwDBGrid
          Left = 353
          Top = 189
          Width = 423
          Height = 135
          HelpContext = 713048
          ControlType.Strings = (
            'ChildCompany;CustomEdit;cboClient;F')
          Selected.Strings = (
            'ChildCompany'#9'42'#9'Company'#9'T')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akBottom]
          Color = clWhite
          DataSource = DSRelatedClients
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          FooterColor = clWhite
          FooterCellColor = clWhite
          object wwIButton2: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            HelpContext = 713001
            AllowAllUp = True
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
            NumGlyphs = 2
            OnClick = wwIButton2Click
          end
        end
        object cboClient: TwwDBLookupCombo
          Left = 479
          Top = 243
          Width = 201
          Height = 23
          HelpContext = 713002
          BiDiMode = bdLeftToRight
          ParentBiDiMode = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ControlType.Strings = (
            'StopCreditImage;ImageIndex;Shrink To Fit')
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'50'#9'Company'#9'F'
            'category'#9'17'#9'Category'#9'F')
          DataField = 'ChildCompany'
          DataSource = DSRelatedClients
          LookupTable = cboClientLookup
          LookupField = 'Company'
          Options = [loColLines, loTitles, loSearchOnBackspace]
          Style = csDropDownList
          ParentFont = False
          TabOrder = 15
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboClientCloseUp
        end
        object DBEdit1: TDBEdit
          Left = 139
          Top = 14
          Width = 190
          Height = 23
          HelpContext = 713049
          AutoSelect = False
          AutoSize = False
          DataField = 'Company'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edtTitle: TDBEdit
          Left = 139
          Top = 92
          Width = 190
          Height = 23
          HelpContext = 713050
          AutoSelect = False
          AutoSize = False
          DataField = 'Title'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object txtContactFirstName: TDBEdit
          Left = 139
          Top = 132
          Width = 190
          Height = 23
          HelpContext = 713051
          AutoSelect = False
          AutoSize = False
          DataField = 'Firstname'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object txtContactSurName: TDBEdit
          Left = 139
          Top = 171
          Width = 190
          Height = 23
          HelpContext = 713052
          AutoSelect = False
          AutoSize = False
          DataField = 'LastName'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object JobTitle: TDBEdit
          Left = 139
          Top = 211
          Width = 190
          Height = 23
          HelpContext = 713053
          AutoSelect = False
          AutoSize = False
          DataField = 'JobTitle'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object cboCompanyType: TwwDBLookupCombo
          Left = 139
          Top = 53
          Width = 190
          Height = 23
          HelpContext = 713054
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          DataField = 'CompanyTypeName'
          DataSource = dsMarketingContacts
          LookupTable = qryCompanyType
          LookupField = 'Name'
          DropDownWidth = 300
          ParentFont = False
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnNotInList = cboCompanyTypeNotInList
        end
        object ContactMOB: TwwDBEdit
          Left = 453
          Top = 71
          Width = 161
          Height = 23
          HelpContext = 713055
          AutoSelect = False
          AutoSize = False
          DataField = 'Mobile'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object ContactFax: TwwDBEdit
          Left = 453
          Top = 40
          Width = 161
          Height = 23
          HelpContext = 713056
          AutoSelect = False
          AutoSize = False
          DataField = 'FaxNumber'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 12
          ParentFont = False
          TabOrder = 9
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object txtContactAltPH: TwwDBEdit
          Left = 453
          Top = 101
          Width = 161
          Height = 23
          HelpContext = 713057
          AutoSelect = False
          AutoSize = False
          DataField = 'AltPhone'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
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
        object cboRep: TwwDBLookupCombo
          Left = 139
          Top = 290
          Width = 190
          Height = 23
          HelpContext = 713058
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'47'#9'EmployeeName'#9#9)
          DataField = 'REpName'
          DataSource = dsMarketingContacts
          LookupTable = qryEmp
          LookupField = 'EmployeeName'
          ParentFont = False
          TabOrder = 7
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboRepCloseUp
          OnEnter = cboenter
        end
        object txtEmpSize: TDBEdit
          Left = 139
          Top = 250
          Width = 190
          Height = 23
          HelpContext = 713059
          AutoSelect = False
          AutoSize = False
          DataField = 'EmployeeSize'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnKeyPress = txtEmpSizeKeyPress
        end
        object ContactPh: TwwDBEdit
          Left = 453
          Top = 10
          Width = 161
          Height = 23
          HelpContext = 713060
          AutoSelect = False
          AutoSize = False
          DataField = 'Phone'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MaxLength = 12
          ParentFont = False
          TabOrder = 8
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object btnNewRelatedCustomer: TDNMSpeedButton
          Left = 715
          Top = 166
          Width = 61
          Height = 21
          Hint = '"Add A New Customer"'
          HelpContext = 713061
          Anchors = [akTop, akRight]
          Caption = 'Add New'
          DisableTransparent = False
          Font.Charset = RUSSIAN_CHARSET
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
          TabOrder = 17
          AutoDisableParentOnclick = True
          OnClick = btnNewRelatedCustomerClick
        end
        object wwDBComboBox1: TwwDBComboBox
          Left = 628
          Top = 32
          Width = 157
          Height = 23
          HelpContext = 713062
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          AutoDropDown = True
          AutoFillDate = False
          DataField = 'CallPriority'
          DataSource = dsMarketingContacts
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
          ItemIndex = 5
          ParentFont = False
          Sorted = False
          TabOrder = 13
          UnboundDataType = wwDefault
          UnboundAlignment = taCenter
        end
        object cboDefaultContactMethod: TwwDBComboBox
          Left = 628
          Top = 81
          Width = 157
          Height = 23
          HelpContext = 713063
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          DataField = 'DefaultContactMethod'
          DataSource = dsMarketingContacts
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
          TabOrder = 14
          UnboundDataType = wwDefault
        end
        object txtSkypename: TDBEdit
          Left = 453
          Top = 132
          Width = 161
          Height = 23
          HelpContext = 713064
          AutoSelect = False
          AutoSize = False
          DataField = 'SkypeName'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object edtCreatedOn: TwwDBDateTimePicker
          Left = 628
          Top = 129
          Width = 86
          Height = 23
          HelpContext = 713065
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          CalendarAttributes.PopupYearOptions.StartYear = 2008
          DataField = 'CreatedOn'
          DataSource = dsMarketingContacts
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 18
        end
      end
    end
    object Address_Info: TTabSheet
      HelpContext = 713066
      Caption = '&Address Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 798
        Height = 339
        HelpContext = 713067
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Box41: TBevel
          Left = 404
          Top = 11
          Width = 318
          Height = 235
          HelpContext = 713068
        end
        object Box83: TBevel
          Left = 76
          Top = 11
          Width = 317
          Height = 235
          HelpContext = 713069
        end
        object Label180: TLabel
          Left = 92
          Top = 72
          Width = 58
          Height = 15
          HelpContext = 713070
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
        object Label38: TLabel
          Left = 491
          Top = 19
          Width = 136
          Height = 18
          HelpContext = 713071
          AutoSize = False
          Caption = 'Postal Address'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label39: TLabel
          Left = 160
          Top = 19
          Width = 104
          Height = 18
          HelpContext = 713072
          AutoSize = False
          Caption = 'Physical Address'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label42: TLabel
          Left = 430
          Top = 43
          Width = 48
          Height = 15
          HelpContext = 713073
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
        object Label78: TLabel
          Left = 102
          Top = 43
          Width = 48
          Height = 15
          HelpContext = 713074
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
        object lblSuburb: TLabel
          Left = 126
          Top = 132
          Width = 24
          Height = 15
          HelpContext = 713075
          Alignment = taRightJustify
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
          Left = 96
          Top = 191
          Width = 54
          Height = 15
          HelpContext = 713076
          Alignment = taRightJustify
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
          Left = 117
          Top = 161
          Width = 33
          Height = 15
          HelpContext = 713077
          Alignment = taRightJustify
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
        object lblBillSuburb: TLabel
          Left = 454
          Top = 132
          Width = 24
          Height = 15
          HelpContext = 713078
          Alignment = taRightJustify
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
        object lblBillState: TLabel
          Left = 445
          Top = 161
          Width = 33
          Height = 15
          HelpContext = 713079
          Alignment = taRightJustify
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
        object lblBillPostcode: TLabel
          Left = 424
          Top = 191
          Width = 54
          Height = 15
          HelpContext = 713080
          Alignment = taRightJustify
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
        object Label6: TLabel
          Left = 420
          Top = 72
          Width = 58
          Height = 15
          HelpContext = 713081
          Alignment = taRightJustify
          Caption = 'Address 2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label7: TLabel
          Left = 106
          Top = 221
          Width = 44
          Height = 15
          HelpContext = 713082
          Alignment = taRightJustify
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
        object Label8: TLabel
          Left = 434
          Top = 221
          Width = 44
          Height = 15
          HelpContext = 713083
          Alignment = taRightJustify
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
        object Label12: TLabel
          Left = 70
          Top = 301
          Width = 80
          Height = 15
          HelpContext = 713084
          Caption = 'Web Address:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label1: TLabel
          Left = 92
          Top = 102
          Width = 58
          Height = 15
          HelpContext = 713085
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
        object Label13: TLabel
          Left = 420
          Top = 102
          Width = 58
          Height = 15
          HelpContext = 713086
          Alignment = taRightJustify
          Caption = 'Address 3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label35: TLabel
          Left = 115
          Top = 261
          Width = 35
          Height = 15
          HelpContext = 713087
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
        object Box76: TBevel
          Left = 404
          Top = 250
          Width = 318
          Height = 39
          HelpContext = 713088
        end
        object Label127: TLabel
          Left = 429
          Top = 261
          Width = 49
          Height = 16
          HelpContext = 713089
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Source:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object BillStreet: TDBEdit
          Left = 490
          Top = 39
          Width = 222
          Height = 23
          HelpContext = 713090
          DataField = 'BillStreet'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object BillState: TDBEdit
          Left = 490
          Top = 157
          Width = 222
          Height = 23
          HelpContext = 713091
          DataField = 'BillState'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object BillPostcode: TDBEdit
          Left = 490
          Top = 187
          Width = 89
          Height = 23
          HelpContext = 713092
          DataField = 'BillPostcode'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
        end
        object BillSuburb: TwwDBLookupCombo
          Left = 490
          Top = 128
          Width = 222
          Height = 23
          HelpContext = 713093
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'City_sub'#9'20'#9'Suburb'#9'T'
            'State'#9'4'#9'State'#9'T'
            'Postcode'#9'10'#9'Postcode'#9'T')
          DataField = 'BillSuburb'
          DataSource = dsMarketingContacts
          LookupTable = qrySuburbs
          LookupField = 'City_sub'
          ParentFont = False
          TabOrder = 11
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = BillSuburbCloseUp
          OnEnter = cboenter
        end
        object BillStreet2: TDBEdit
          Left = 490
          Top = 68
          Width = 222
          Height = 23
          HelpContext = 713094
          DataField = 'BillStreet2'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object BillCountry: TDBEdit
          Left = 490
          Top = 217
          Width = 222
          Height = 23
          HelpContext = 713095
          DataField = 'BillCountry'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object URL: TwwDBRichEdit
          Left = 161
          Top = 297
          Width = 561
          Height = 23
          HelpContext = 713096
          AutoURLDetect = True
          DataField = 'URL'
          DataSource = dsMarketingContacts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HideSelection = False
          ParentFont = False
          PrintJobName = 'Delphi 6'
          TabOrder = 17
          WantReturns = False
          WordWrap = False
          EditorCaption = 'Edit URL'
          EditorPosition.Left = 0
          EditorPosition.Top = 0
          EditorPosition.Width = 0
          EditorPosition.Height = 0
          MeasurementUnits = muInches
          PrintMargins.Top = 1.000000000000000000
          PrintMargins.Bottom = 1.000000000000000000
          PrintMargins.Left = 1.000000000000000000
          PrintMargins.Right = 1.000000000000000000
          PrintHeader.VertMargin = 0.500000000000000000
          PrintHeader.Font.Charset = DEFAULT_CHARSET
          PrintHeader.Font.Color = clWindowText
          PrintHeader.Font.Height = -11
          PrintHeader.Font.Name = 'Tahoma'
          PrintHeader.Font.Style = []
          PrintFooter.VertMargin = 0.500000000000000000
          PrintFooter.Font.Charset = DEFAULT_CHARSET
          PrintFooter.Font.Color = clWindowText
          PrintFooter.Font.Height = -11
          PrintFooter.Font.Name = 'Tahoma'
          PrintFooter.Font.Style = []
          RichEditVersion = 2
          Data = {
            6F0000007B5C727466315C616E73695C616E7369637067313235325C64656666
            307B5C666F6E7474626C7B5C66305C666E696C5C666368617273657430204172
            69616C3B7D7D0D0A5C766965776B696E64345C7563315C706172645C6C616E67
            333038315C667331385C7061720D0A7D0D0A00}
        end
        object BillStreet3: TDBEdit
          Left = 490
          Top = 98
          Width = 222
          Height = 23
          HelpContext = 713097
          DataField = 'BillStreet3'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object Email: TDBEdit
          Left = 161
          Top = 257
          Width = 233
          Height = 23
          HelpContext = 713098
          DataField = 'Email'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object txtCountry: TDBEdit
          Left = 159
          Top = 217
          Width = 222
          Height = 23
          HelpContext = 713099
          AutoSelect = False
          AutoSize = False
          DataField = 'Country'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object Postcode: TDBEdit
          Left = 159
          Top = 187
          Width = 89
          Height = 23
          HelpContext = 713100
          AutoSelect = False
          AutoSize = False
          DataField = 'Postcode'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object State: TDBEdit
          Left = 159
          Top = 157
          Width = 89
          Height = 23
          HelpContext = 713101
          AutoSelect = False
          AutoSize = False
          DataField = 'State'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object Suburb: TwwDBLookupCombo
          Left = 159
          Top = 128
          Width = 222
          Height = 23
          HelpContext = 713102
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'City_sub'#9'24'#9'Suburb'#9'T'
            'State'#9'6'#9'State'#9'T'#9
            'Postcode'#9'6'#9'Postcode'#9'T'#9)
          DataField = 'SUBURB'
          DataSource = dsMarketingContacts
          LookupTable = qrySuburbs
          LookupField = 'City_sub'
          Style = csDropDownList
          DropDownWidth = 350
          ParentFont = False
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = True
          OnCloseUp = SuburbCloseUp
          OnEnter = cboenter
        end
        object txtContactAddress3: TDBEdit
          Left = 159
          Top = 98
          Width = 222
          Height = 23
          HelpContext = 713103
          AutoSelect = False
          AutoSize = False
          DataField = 'Street3'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object txtContactAddress2: TDBEdit
          Left = 159
          Top = 68
          Width = 222
          Height = 23
          HelpContext = 713104
          AutoSelect = False
          AutoSize = False
          DataField = 'Street2'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object txtContactAddress: TDBEdit
          Left = 159
          Top = 39
          Width = 222
          Height = 23
          HelpContext = 713105
          AutoSelect = False
          AutoSize = False
          DataField = 'Street'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object cboSource: TwwDBLookupCombo
          Left = 484
          Top = 257
          Width = 222
          Height = 23
          HelpContext = 713106
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          DataField = 'Source'
          DataSource = dsMarketingContacts
          LookupTable = qryMediaType
          LookupField = 'MediaType'
          Style = csDropDownList
          DropDownWidth = 40
          ParentFont = False
          TabOrder = 16
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = True
          OnEnter = cboenter
        end
        object cmdCopy: TDNMSpeedButton
          Left = 308
          Top = 184
          Width = 72
          Height = 24
          Hint = '"Copy The Bill To Details In To The Physical Address"'
          HelpContext = 713107
          Caption = '>>Cop&y>>'
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
          AutoDisableParentOnclick = True
          OnClick = cmdCopyClick
        end
      end
    end
    object tabFollowUp: TTabSheet
      HelpContext = 713108
      Caption = '&Follow-Up'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 798
        Height = 339
        HelpContext = 713109
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object grdFollowups: TwwDBGrid
          Left = 0
          Top = 0
          Width = 798
          Height = 339
          HelpContext = 713110
          TabStop = False
          ControlType.Strings = (
            'TypeId;CustomEdit;cboFollowUpType;F'
            'EmployeeID;CustomEdit;cboEmployee;F'
            'Done;CheckBox;T;F'
            'ResultTypeId;CustomEdit;cboFollowUpResult;F'
            'EmployeeName;CustomEdit;cboEmployee;F'
            'ResultTypeName;CustomEdit;cboActionType;F'
            'TypeName;CustomEdit;cboFollowUpType;F'
            'ActiontypeName;CustomEdit;cboActionType;F'
            'ActionDate;CustomEdit;edtActionDate;F')
          Selected.Strings = (
            'ActiontypeName'#9'15'#9'Action Type'#9#9
            'ActionDate'#9'12'#9'Action Date'#9#9
            'EmployeeName'#9'15'#9'Employee'#9#9
            'Notes'#9'56'#9'Notes'#9'F'#9
            'Done'#9'4'#9'Done'#9#9)
          MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly, mDisableDialog]
          IniAttributes.Delimiter = ';;'
          TitleColor = 14155775
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alClient
          DataSource = dsLeadLines
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = [dgEnterToTab, dgAllowInsert]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = True
          FooterColor = 14155775
          FooterCellColor = clWhite
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
          object grdFollowupsIButton: TwwIButton
            Left = 0
            Top = 0
            Width = 24
            Height = 19
            HelpContext = 713003
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
            OnClick = grdFollowupsIButtonClick
          end
        end
        object cboActionType: TwwDBLookupCombo
          Left = 25
          Top = 265
          Width = 121
          Height = 23
          HelpContext = 713004
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'ActiontypeName'
          DataSource = dsLeadLines
          LookupTable = qryActionType
          LookupField = 'Id'
          DropDownCount = 11
          TabOrder = 1
          Visible = False
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object cboEmployee: TwwDBLookupCombo
          Left = 328
          Top = 239
          Width = 165
          Height = 23
          HelpContext = 713005
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'40'#9'Employee Name'#9'F')
          DataField = 'EmployeeName'
          DataSource = dsLeadLines
          LookupTable = qryEmployee
          LookupField = 'EmployeeName'
          ParentFont = False
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
        object edtActionDate: TwwDBDateTimePicker
          Left = 336
          Top = 176
          Width = 121
          Height = 23
          HelpContext = 713006
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          CalendarAttributes.PopupYearOptions.NumberColumns = 4
          DataField = 'ActionDate'
          DataSource = dsLeadLines
          Date = 40617.000000000000000000
          Epoch = 1950
          ShowButton = True
          TabOrder = 3
        end
      end
    end
    object Custom_Fields: TTabSheet
      HelpContext = 713111
      Caption = 'Custom Fields'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cmdCustomLabels: TDNMSpeedButton
        Left = 285
        Top = 425
        Width = 87
        Height = 27
        Hint = '"Add A New Customised Field For All Customers"'
        HelpContext = 713112
        Caption = '&Add Labels'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        AutoDisableParentOnclick = True
      end
      object pnlCustFields: TDNMPanel
        Left = 0
        Top = 0
        Width = 798
        Height = 339
        HelpContext = 713113
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Box181: TBevel
          Left = 4
          Top = 52
          Width = 784
          Height = 229
          HelpContext = 713114
        end
        object Label179: TLabel
          Left = 301
          Top = 12
          Width = 193
          Height = 26
          HelpContext = 713115
          AutoSize = False
          Caption = 'Customisable Fields'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Bevel14: TBevel
          Left = 292
          Top = 8
          Width = 206
          Height = 32
          HelpContext = 713116
          Style = bsRaised
        end
        object CUSTLBL1: TLabel
          Left = 122
          Top = 78
          Width = 3
          Height = 15
          HelpContext = 713117
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL2: TLabel
          Left = 122
          Top = 112
          Width = 3
          Height = 15
          HelpContext = 713118
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL3: TLabel
          Left = 122
          Top = 147
          Width = 3
          Height = 15
          HelpContext = 713119
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL4: TLabel
          Left = 122
          Top = 181
          Width = 3
          Height = 15
          HelpContext = 713120
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL5: TLabel
          Left = 122
          Top = 215
          Width = 3
          Height = 15
          HelpContext = 713121
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL6: TLabel
          Left = 123
          Top = 249
          Width = 3
          Height = 15
          HelpContext = 713122
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL7: TLabel
          Left = 374
          Top = 79
          Width = 3
          Height = 15
          HelpContext = 713123
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL8: TLabel
          Left = 374
          Top = 112
          Width = 3
          Height = 15
          HelpContext = 713124
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL9: TLabel
          Left = 374
          Top = 147
          Width = 3
          Height = 15
          HelpContext = 713125
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL10: TLabel
          Left = 374
          Top = 181
          Width = 3
          Height = 15
          HelpContext = 713126
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL11: TLabel
          Left = 374
          Top = 214
          Width = 3
          Height = 15
          HelpContext = 713127
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL12: TLabel
          Left = 374
          Top = 248
          Width = 3
          Height = 15
          HelpContext = 713128
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL13: TLabel
          Left = 649
          Top = 78
          Width = 3
          Height = 15
          HelpContext = 713129
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL14: TLabel
          Left = 649
          Top = 112
          Width = 3
          Height = 15
          HelpContext = 713130
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL15: TLabel
          Left = 649
          Top = 147
          Width = 3
          Height = 15
          HelpContext = 713131
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL16: TLabel
          Left = 649
          Top = 181
          Width = 3
          Height = 15
          HelpContext = 713132
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL17: TLabel
          Left = 649
          Top = 215
          Width = 3
          Height = 15
          HelpContext = 713133
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object CUSTLBL18: TLabel
          Left = 649
          Top = 248
          Width = 3
          Height = 15
          HelpContext = 713134
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object cmdCustomLabelsOld: TDNMSpeedButton
          Left = 347
          Top = 294
          Width = 87
          Height = 27
          Hint = '"Add A New Customised Field For All Employee'#39's"'
          HelpContext = 713135
          Caption = '&Add Labels'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 18
          AutoDisableParentOnclick = True
          OnClick = cmdCustomLabelsOldClick
        end
        object CUSTFLD1: TwwDBComboBox
          Left = 127
          Top = 75
          Width = 130
          Height = 23
          HelpContext = 713136
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD1'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 0
          UnboundDataType = wwDefault
        end
        object CUSTFLD2: TwwDBComboBox
          Left = 127
          Top = 109
          Width = 130
          Height = 23
          HelpContext = 713137
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD2'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 1
          UnboundDataType = wwDefault
        end
        object CUSTFLD3: TwwDBComboBox
          Left = 127
          Top = 144
          Width = 130
          Height = 23
          HelpContext = 713138
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD3'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 2
          UnboundDataType = wwDefault
        end
        object CUSTFLD4: TwwDBComboBox
          Left = 127
          Top = 178
          Width = 130
          Height = 23
          HelpContext = 713139
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD4'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 3
          UnboundDataType = wwDefault
        end
        object CUSTFLD5: TwwDBComboBox
          Left = 127
          Top = 212
          Width = 130
          Height = 23
          HelpContext = 713140
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD5'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 4
          UnboundDataType = wwDefault
        end
        object CUSTFLD10: TwwDBComboBox
          Left = 378
          Top = 178
          Width = 130
          Height = 23
          HelpContext = 713141
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD10'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 9
          UnboundDataType = wwDefault
        end
        object CUSTFLD9: TwwDBComboBox
          Left = 378
          Top = 144
          Width = 130
          Height = 23
          HelpContext = 713142
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD9'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 8
          UnboundDataType = wwDefault
        end
        object CUSTFLD8: TwwDBComboBox
          Left = 378
          Top = 109
          Width = 130
          Height = 23
          HelpContext = 713143
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD8'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 7
          UnboundDataType = wwDefault
        end
        object CUSTFLD7: TwwDBComboBox
          Left = 378
          Top = 75
          Width = 130
          Height = 23
          HelpContext = 713144
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD7'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 6
          UnboundDataType = wwDefault
        end
        object CUSTFLD6: TwwDBComboBox
          Left = 127
          Top = 246
          Width = 130
          Height = 23
          HelpContext = 713145
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD6'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 5
          UnboundDataType = wwDefault
        end
        object CUSTFLD11: TwwDBComboBox
          Left = 378
          Top = 212
          Width = 130
          Height = 23
          HelpContext = 713146
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD11'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 10
          UnboundDataType = wwDefault
        end
        object CUSTFLD12: TwwDBComboBox
          Left = 378
          Top = 245
          Width = 130
          Height = 23
          HelpContext = 713147
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD12'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 11
          UnboundDataType = wwDefault
        end
        object CUSTFLD13: TwwDBComboBox
          Left = 653
          Top = 75
          Width = 130
          Height = 23
          HelpContext = 713148
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD13'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 12
          UnboundDataType = wwDefault
        end
        object CUSTFLD14: TwwDBComboBox
          Left = 653
          Top = 109
          Width = 130
          Height = 23
          HelpContext = 713149
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD14'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 13
          UnboundDataType = wwDefault
        end
        object CUSTFLD15: TwwDBComboBox
          Left = 653
          Top = 144
          Width = 130
          Height = 23
          HelpContext = 713150
          ShowButton = True
          Style = csDropDown
          MapList = False
          AllowClearKey = False
          DataField = 'CUSTFLD15'
          DataSource = dsMarketingContacts
          DropDownCount = 8
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ButtonWidth = -1
          ItemHeight = 0
          ParentFont = False
          Sorted = False
          TabOrder = 14
          UnboundDataType = wwDefault
        end
        object CUSTFLD16: TwwDBDateTimePicker
          Left = 653
          Top = 178
          Width = 130
          Height = 23
          HelpContext = 713151
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'CUSTDATE1'
          DataSource = dsMarketingContacts
          Epoch = 1950
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = True
          TabOrder = 15
        end
        object CUSTFLD17: TwwDBDateTimePicker
          Left = 653
          Top = 212
          Width = 130
          Height = 23
          HelpContext = 713152
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'CUSTDATE2'
          DataSource = dsMarketingContacts
          Epoch = 1950
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = True
          TabOrder = 16
        end
        object CUSTFLD18: TwwDBDateTimePicker
          Left = 653
          Top = 245
          Width = 130
          Height = 23
          HelpContext = 713153
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'CUSTDATE3'
          DataSource = dsMarketingContacts
          Epoch = 1950
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = True
          TabOrder = 17
        end
      end
    end
    object tabContacts: TTabSheet
      HelpContext = 713154
      Caption = 'Co&ntacts'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DNMPanel4: TDNMPanel
        Left = 0
        Top = 0
        Width = 798
        Height = 339
        HelpContext = 713155
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          798
          339)
        object Bevel2: TBevel
          Left = 0
          Top = 8
          Width = 796
          Height = 330
          HelpContext = 713156
          Anchors = [akLeft, akTop, akRight, akBottom]
        end
        object Label10: TLabel
          Left = 31
          Top = 313
          Width = 133
          Height = 15
          HelpContext = 713157
          Anchors = [akLeft, akBottom]
          Caption = 'Show Inactive Contacts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object EditBtn: TDNMSpeedButton
          Left = 421
          Top = 305
          Width = 129
          Height = 27
          HelpContext = 713158
          Anchors = [akBottom]
          Caption = '&Edit'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
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
          OnClick = Openmarketingcontactcontact
        end
        object cmdNewContact: TDNMSpeedButton
          Left = 245
          Top = 305
          Width = 129
          Height = 27
          HelpContext = 713159
          Anchors = [akBottom]
          Caption = '&New'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10485760
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = Openmarketingcontactcontact
        end
        object chkShowAll: TCheckBox
          Left = 9
          Top = 312
          Width = 17
          Height = 17
          HelpContext = 713160
          Anchors = [akLeft, akBottom]
          Caption = 'Show Inactive Contacts'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 3
        end
        object grdContact: TwwDBGrid
          Left = 7
          Top = 20
          Width = 783
          Height = 277
          HelpContext = 713161
          ControlType.Strings = (
            'UseOnRun;CheckBox;T;F'
            'isPrimarycontact;CheckBox;T;F'
            'IsPrimarycontact;CheckBox;T;F')
          Selected.Strings = (
            'ContactName'#9'33'#9'Contact'#9'T'
            'ContactPH'#9'13'#9'Phone'#9'T'
            'ContactAltPH'#9'13'#9'Alt Phone'#9'F'
            'ContactFax'#9'13'#9'Fax'#9'T'
            'ContactMOB'#9'13'#9'Mobile'#9'T'
            'isPrimarycontact'#9'1'#9'Primary Contact?'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clWhite
          DataSource = DSContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnDblClick = grdContactDblClick
          object wwIButton1: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            Hint = 'Click this button to Deactivate the selected contact'
            HelpContext = 713008
            AllowAllUp = True
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
            NumGlyphs = 2
            ParentShowHint = False
            ShowHint = True
            OnClick = wwIButton1Click
          end
        end
      end
    end
    object tabDocuments: TTabSheet
      HelpContext = 713162
      Caption = 'Products / Notes'
      ImageIndex = 6
      object DNMPanel5: TDNMPanel
        Left = 0
        Top = 0
        Width = 798
        Height = 339
        HelpContext = 713163
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          798
          339)
        object Bevel3: TBevel
          Left = 396
          Top = 8
          Width = 398
          Height = 324
          HelpContext = 713164
          Anchors = [akLeft, akTop, akRight, akBottom]
        end
        object Bevel1: TBevel
          Left = 4
          Top = 8
          Width = 391
          Height = 324
          HelpContext = 713165
          Anchors = [akLeft, akTop, akRight, akBottom]
        end
        object Label2: TLabel
          Left = 405
          Top = 12
          Width = 72
          Height = 21
          HelpContext = 713166
          AutoSize = False
          Caption = 'Notes'
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
          Left = 13
          Top = 12
          Width = 77
          Height = 18
          HelpContext = 713167
          AutoSize = False
          Caption = 'Products'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object grdProduct: TwwDBGrid
          Left = 13
          Top = 29
          Width = 372
          Height = 292
          HelpContext = 713009
          ControlType.Strings = (
            'Active;CheckBox;T;F'
            'ProductName;CustomEdit;cboProductR;F')
          Selected.Strings = (
            'ProductName'#9'20'#9'ProductName'#9#9
            'Description'#9'20'#9'Description'#9'F'#9
            'Active'#9'1'#9'Active'#9#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akBottom]
          DataSource = dsMarketingcontactProducts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          OnDblClick = grdProductDblClick
          FooterColor = clWhite
          object wwDBGrid1IButton: TwwIButton
            Left = 0
            Top = 0
            Width = 17
            Height = 22
            HelpContext = 713010
            AllowAllUp = True
            Glyph.Data = {
              26040000424D2604000000000000360000002800000012000000120000000100
              180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
              636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
              7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
              00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
              FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
              000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
              D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
              0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
              FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
              D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
              00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
              00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
              0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
              0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
              FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
              E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
              AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
              FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
              07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
              0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
              0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
              00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
              FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
              FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
              007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
              CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
              0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
              FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
              1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
              C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
              D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
              E0E3FFFFFFFFFFFF0000}
            OnClick = wwDBGrid1IButtonClick
          end
        end
        object DBMemo1: TDBMemo
          Left = 405
          Top = 29
          Width = 381
          Height = 292
          HelpContext = 713168
          TabStop = False
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataField = 'Notes'
          DataSource = dsMarketingContacts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object cboProductR: TERPDbLookupCombo
          Left = 64
          Top = 136
          Width = 65
          Height = 23
          HelpContext = 713011
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ControlType.Strings = (
            'Active;CheckBox;T;F')
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'PARTNAME'#9'15'#9'Product Name'#9'F'
            'Manuf'#9'15'#9'Manuf'#9'F'
            'Type'#9'15'#9'Type'#9'F'
            'Dept'#9'15'#9'Dept'#9'F'
            'PartsDescription'#9'35'#9'Description'#9'F'
            'Active'#9'1'#9'Active'#9'F')
          DataField = 'ProductName'
          DataSource = dsMarketingcontactProducts
          LookupTable = cboProductQry
          LookupField = 'Partname'
          Options = [loTitles]
          ParentFont = False
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboProductRCloseUp
          OnNotInList = cboProductRNotInList
          LookupFormClassName = 'TProductListExpressGUI'
          EditFormClassName = 'TfrmParts'
          LookupFormKeyStringFieldName = 'ProductName'
          LookupComboType = ctProduct
          AllowFullListSearchMode = False
          DisableNotInList = False
          AllowMultipleSelectFromList = False
          OpenListinF6WhenNotinList = False
          DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
          DataIDField = 'ProductID'
          LookupIDField = 'PartsID'
          LookupFieldAlt = 'ProductPrintName'
        end
        object cboPrintProductR: TERPDbLookupCombo
          Left = 72
          Top = 144
          Width = 65
          Height = 23
          HelpContext = 713174
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ControlType.Strings = (
            'Active;CheckBox;T;F')
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'PARTNAME'#9'15'#9'Product Name'#9'F'
            'Manuf'#9'15'#9'Manuf'#9'F'
            'Type'#9'15'#9'Type'#9'F'
            'Dept'#9'15'#9'Dept'#9'F'
            'PartsDescription'#9'35'#9'Description'#9'F'
            'Active'#9'1'#9'Active'#9'F')
          DataField = 'ProductName'
          DataSource = dsMarketingcontactProducts
          LookupTable = cboProductQry
          LookupField = 'Partname'
          Options = [loTitles]
          ParentFont = False
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboProductRCloseUp
          OnNotInList = cboProductRNotInList
          LookupFormClassName = 'TProductListExpressGUI'
          EditFormClassName = 'TfrmParts'
          LookupFormKeyStringFieldName = 'ProductName'
          LookupComboType = ctProduct
          AllowFullListSearchMode = False
          DisableNotInList = False
          AllowMultipleSelectFromList = False
          OpenListinF6WhenNotinList = False
          DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
          DataIDField = 'ProductID'
          LookupIDField = 'PartsID'
          LookupFieldAlt = 'ProductPrintName'
        end
      end
    end
  end
  object btnTelemarketing: TDNMSpeedButton [17]
    Left = 814
    Top = 256
    Width = 87
    Height = 27
    HelpContext = 713169
    Anchors = [akTop, akRight]
    Caption = 'Telemarketing'
    DisableTransparent = False
    Font.Charset = RUSSIAN_CHARSET
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
    AutoDisableParentOnclick = True
    OnClick = btnTelemarketingClick
  end
  object btnLead: TDNMSpeedButton [18]
    Left = 814
    Top = 299
    Width = 87
    Height = 27
    HelpContext = 713170
    Anchors = [akTop, akRight]
    Caption = 'Lead'
    DisableTransparent = False
    Font.Charset = RUSSIAN_CHARSET
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
    AutoDisableParentOnclick = True
    OnClick = btnLeadClick
  end
  object cmdOk: TDNMSpeedButton [19]
    Left = 814
    Top = 84
    Width = 87
    Height = 27
    HelpContext = 713015
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
  object chkDoNotContact: TDBCheckBox [20]
    Left = 854
    Top = 448
    Width = 14
    Height = 15
    HelpContext = 713175
    Anchors = [akRight, akBottom]
    Color = 13303807
    DataField = 'DoNotContact'
    DataSource = dsMarketingContacts
    ParentColor = False
    TabOrder = 10
    ValueChecked = 'T'
    ValueUnchecked = 'F'
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 0
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 132
  end
  inherited MyConnection: TERPConnection
    Left = 105
  end
  inherited DataState: TDataState
    Left = 52
    Top = 8
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    HelpContext = 713016
    Left = 26
  end
  inherited imgsort: TImageList
    Left = 79
    Top = 8
    Bitmap = {
      494C010102007800C80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object dsMarketingContacts: TDataSource
    DataSet = qryMarketingContacts
    Left = 179
    Top = 40
  end
  object qryMarketingContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblmarketingcontacts')
    AfterOpen = qryMarketingContactsAfterOpen
    OnCalcFields = qryMarketingContactsCalcFields
    Left = 150
    Top = 40
    object qryMarketingContactsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblmarketingcontacts.ID'
    end
    object qryMarketingContactsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblmarketingcontacts.GlobalRef'
      Size = 255
    end
    object qryMarketingContactsCompanyTypeName: TWideStringField
      FieldName = 'CompanyTypeName'
      Origin = 'tblmarketingcontacts.CompanyTypeName'
      Size = 255
    end
    object qryMarketingContactsCOMPANY: TWideStringField
      FieldName = 'COMPANY'
      Origin = 'tblmarketingcontacts.COMPANY'
      Size = 255
    end
    object qryMarketingContactsStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblmarketingcontacts.Street'
      Size = 255
    end
    object qryMarketingContactsStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblmarketingcontacts.Street2'
      Size = 255
    end
    object qryMarketingContactsFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblmarketingcontacts.FaxNumber'
      EditMask = '## #### ####;0;_'
      Size = 255
    end
    object qryMarketingContactsPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblmarketingcontacts.Phone'
      EditMask = '## #### ####;0;_'
      Size = 255
    end
    object qryMarketingContactsAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblmarketingcontacts.AltPhone'
      Size = 255
    end
    object qryMarketingContactsMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblmarketingcontacts.Mobile'
      Size = 255
    end
    object qryMarketingContactsSUBURB: TWideStringField
      FieldName = 'SUBURB'
      Origin = 'tblmarketingcontacts.SUBURB'
      Size = 255
    end
    object qryMarketingContactsSTATE: TWideStringField
      FieldName = 'STATE'
      Origin = 'tblmarketingcontacts.STATE'
      Size = 255
    end
    object qryMarketingContactsPOSTCODE: TWideStringField
      FieldName = 'POSTCODE'
      Origin = 'tblmarketingcontacts.POSTCODE'
      Size = 255
    end
    object qryMarketingContactsEmployeeSize: TWideStringField
      FieldName = 'EmployeeSize'
      Origin = 'tblmarketingcontacts.EmployeeSize'
      Size = 255
    end
    object qryMarketingContactsNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblmarketingcontacts.Notes'
      BlobType = ftWideMemo
    end
    object qryMarketingContactsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblmarketingcontacts.Active'
      FixedChar = True
      Size = 1
    end
    object qryMarketingContactsJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Origin = 'tblmarketingcontacts.JobTitle'
      Size = 255
    end
    object qryMarketingContactsTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'tblmarketingcontacts.Title'
      Size = 16
    end
    object qryMarketingContactsFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'tblmarketingcontacts.FirstName'
      Size = 255
    end
    object qryMarketingContactsMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Origin = 'tblmarketingcontacts.MiddleName'
      Size = 255
    end
    object qryMarketingContactsLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblmarketingcontacts.LastName'
      Size = 255
    end
    object qryMarketingContactsEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'tblmarketingcontacts.Email'
      Size = 255
    end
    object qryMarketingContactsCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblmarketingcontacts.Country'
      Size = 255
    end
    object qryMarketingContactsDateEntered: TDateTimeField
      FieldName = 'DateEntered'
      Origin = 'tblmarketingcontacts.DateEntered'
    end
    object qryMarketingContactsEnteredEmpID: TIntegerField
      FieldName = 'EnteredEmpID'
      Origin = 'tblmarketingcontacts.EnteredEmpID'
    end
    object qryMarketingContactsDateOfBirth: TDateField
      FieldName = 'DateOfBirth'
      Origin = 'tblmarketingcontacts.DateOfBirth'
    end
    object qryMarketingContactsDuration: TDateTimeField
      FieldName = 'Duration'
      Origin = 'tblmarketingcontacts.Duration'
    end
    object qryMarketingContactsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblmarketingcontacts.msTimeStamp'
    end
    object qryMarketingContactsSource: TWideStringField
      FieldName = 'Source'
      Origin = 'tblmarketingcontacts.Source'
      Size = 255
    end
    object qryMarketingContactsStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblmarketingcontacts.Street3'
      Size = 255
    end
    object qryMarketingContactsURL: TWideStringField
      FieldName = 'URL'
      Origin = 'tblmarketingcontacts.URL'
      Size = 255
    end
    object qryMarketingContactsBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'tblmarketingcontacts.BillStreet'
      Size = 255
    end
    object qryMarketingContactsBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'tblmarketingcontacts.BillStreet2'
      Size = 255
    end
    object qryMarketingContactsBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'tblmarketingcontacts.BillStreet3'
      Size = 255
    end
    object qryMarketingContactsBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'tblmarketingcontacts.BillSuburb'
      Size = 255
    end
    object qryMarketingContactsBillState: TWideStringField
      FieldName = 'BillState'
      Origin = 'tblmarketingcontacts.BillState'
      Size = 255
    end
    object qryMarketingContactsBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'tblmarketingcontacts.BillPostcode'
      Size = 255
    end
    object qryMarketingContactsBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'tblmarketingcontacts.BillCountry'
      Size = 255
    end
    object qryMarketingContactsREpId: TIntegerField
      FieldName = 'REpId'
      Origin = 'tblmarketingcontacts.REpId'
    end
    object qryMarketingContactsREpName: TWideStringField
      FieldName = 'REpName'
      Origin = 'tblmarketingcontacts.REpName'
      Size = 100
    end
    object qryMarketingContactsMedTypeID: TIntegerField
      FieldName = 'MedTypeID'
      Origin = 'tblmarketingcontacts.MedTypeID'
    end
    object qryMarketingContactsClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblmarketingcontacts.ClientID'
    end
    object qryMarketingContactsCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Origin = 'tblmarketingcontacts.CUSTFLD1'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Origin = 'tblmarketingcontacts.CUSTFLD2'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Origin = 'tblmarketingcontacts.CUSTFLD3'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Origin = 'tblmarketingcontacts.CUSTFLD4'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Origin = 'tblmarketingcontacts.CUSTFLD5'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Origin = 'tblmarketingcontacts.CUSTFLD6'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Origin = 'tblmarketingcontacts.CUSTFLD7'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Origin = 'tblmarketingcontacts.CUSTFLD8'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Origin = 'tblmarketingcontacts.CUSTFLD9'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Origin = 'tblmarketingcontacts.CUSTFLD10'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Origin = 'tblmarketingcontacts.CUSTFLD11'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Origin = 'tblmarketingcontacts.CUSTFLD12'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Origin = 'tblmarketingcontacts.CUSTFLD13'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Origin = 'tblmarketingcontacts.CUSTFLD14'
      Size = 255
    end
    object qryMarketingContactsCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Origin = 'tblmarketingcontacts.CUSTFLD15'
      Size = 255
    end
    object qryMarketingContactsCUSTDATE1: TDateTimeField
      FieldName = 'CUSTDATE1'
      Origin = 'tblmarketingcontacts.CUSTDATE1'
    end
    object qryMarketingContactsCUSTDATE2: TDateTimeField
      FieldName = 'CUSTDATE2'
      Origin = 'tblmarketingcontacts.CUSTDATE2'
    end
    object qryMarketingContactsCUSTDATE3: TDateTimeField
      FieldName = 'CUSTDATE3'
      Origin = 'tblmarketingcontacts.CUSTDATE3'
    end
    object qryMarketingContactsCallPriority: TIntegerField
      FieldName = 'CallPriority'
      Origin = 'tblmarketingcontacts.CallPriority'
    end
    object qryMarketingContactsDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Origin = 'tblmarketingcontacts.DefaultContactMethod'
    end
    object qryMarketingContactsSkypeName: TWideStringField
      FieldName = 'SkypeName'
      Origin = 'tblmarketingcontacts.SkypeName'
      Size = 100
    end
    object qryMarketingContactsConvertedDesc: TStringField
      FieldKind = fkCalculated
      FieldName = 'ConvertedDesc'
      Size = 100
      Calculated = True
    end
    object qryMarketingContactsCreatedOn: TDateTimeField
      FieldName = 'CreatedOn'
      Origin = 'tblmarketingcontacts.CreatedOn'
    end
    object qryMarketingContactsDoNotContact: TWideStringField
      FieldName = 'DoNotContact'
      FixedChar = True
      Size = 1
    end
    object qryMarketingContactsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object qryCompanyType: TERPQuery
    SQL.Strings = (
      'SELECT'
      'ID, Name, TypeCode, Active, IsDefault'
      'FROM tblsimpletypes'
      'WHERE TypeCode = "CompanyType";')
    Left = 295
    Top = 40
  end
  object qrySuburbs: TERPQuery
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Country'
      'FROM tblLocations'
      'Where RegionID= :xRegionID'
      'Order By City_sub;')
    BeforeOpen = qrySuburbsBeforeOpen
    Left = 440
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object qryContactType: TERPQuery
    SQL.Strings = (
      'SELECT OtherTypeID, OtherType FROM tblOtherType'
      'GROUP BY OtherType'
      'ORDER BY OtherType')
    Left = 208
    Top = 40
  end
  object qryEmp: TERPQuery
    SQL.Strings = (
      'SELECT EmployeeId, EmployeeName, Active FROM tblEmployees'
      'WHERE Active = "T"'
      'Order by EmployeeName')
    Left = 92
    Top = 40
  end
  object qryRelatedClients: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblrelatedcontacts'
      'Where MasterContactID=:ID;')
    AfterInsert = qryRelatedClientsAfterInsert
    Left = 324
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryRelatedClientsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblrelatedcontacts.GlobalRef'
      Size = 255
    end
    object qryRelatedClientsRelatedContactID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'RelatedContactID'
      Origin = 'tblrelatedcontacts.RelatedContactID'
    end
    object qryRelatedClientsMasterContactID: TIntegerField
      FieldName = 'MasterContactID'
      Origin = 'tblrelatedcontacts.MasterContactID'
    end
    object qryRelatedClientsMasterCompany: TWideStringField
      FieldName = 'MasterCompany'
      Origin = 'tblrelatedcontacts.MasterCompany'
      Size = 80
    end
    object qryRelatedClientsChildContactID: TIntegerField
      FieldName = 'ChildContactID'
      Origin = 'tblrelatedcontacts.ChildContactID'
    end
    object qryRelatedClientsChildCompany: TWideStringField
      FieldName = 'ChildCompany'
      Origin = 'tblrelatedcontacts.ChildCompany'
      Size = 80
    end
    object qryRelatedClientsCustomer: TWideStringField
      FieldName = 'Customer'
      Origin = 'tblrelatedcontacts.Customer'
      FixedChar = True
      Size = 1
    end
    object qryRelatedClientsSupplier: TWideStringField
      FieldName = 'Supplier'
      Origin = 'tblrelatedcontacts.Supplier'
      FixedChar = True
      Size = 1
    end
    object qryRelatedClientsOtherContact: TWideStringField
      FieldName = 'OtherContact'
      Origin = 'tblrelatedcontacts.OtherContact'
      FixedChar = True
      Size = 1
    end
    object qryRelatedClientsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblrelatedcontacts.msTimeStamp'
    end
    object qryRelatedClientsMarketingcontact: TWideStringField
      FieldName = 'Marketingcontact'
      FixedChar = True
      Size = 1
    end
  end
  object DSRelatedClients: TDataSource
    DataSet = qryRelatedClients
    Left = 353
    Top = 40
  end
  object cboClientLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'ClientID as ClientID,'
      
        'Company as Company, Customer, supplier, Othercontact, "F" as Mar' +
        'ketingcontact , '
      
        'if(Customer="T","Customer",if( supplier="T","Supplier" , if(Othe' +
        'rcontact="T" , "Other Contact" , "Unknown"))) as category'
      'FROM tblclients'
      'LEFT JOIN tblrelatedclients on ChildClientID=ClientID'
      'WHERE Active = '#39'T'#39
      'And (Customer = '#39'F'#39' OR (IsJob = '#39'F'#39' AND IsNull(ChildClientID)))'
      'union all'
      
        'Select  ID , COMPANY , "F" , "F" , "F" , "T" , "Marketing Contac' +
        't"'
      'from tblmarketingcontacts'
      'Where ID<> :ID'
      'Order By Company;')
    Options.LongStrings = False
    Left = 237
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object cboClientLookupCompany: TWideStringField
      DisplayWidth = 50
      FieldName = 'Company'
      Size = 255
    end
    object cboClientLookupcategory: TWideStringField
      DisplayLabel = 'Category'
      DisplayWidth = 17
      FieldName = 'category'
      Size = 17
    end
    object cboClientLookupClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object cboClientLookupCustomer: TWideStringField
      FieldName = 'Customer'
      Visible = False
      Size = 1
    end
    object cboClientLookupsupplier: TWideStringField
      FieldName = 'supplier'
      Visible = False
      Size = 1
    end
    object cboClientLookupOthercontact: TWideStringField
      FieldName = 'Othercontact'
      Visible = False
      Size = 1
    end
    object cboClientLookupMarketingcontact: TWideStringField
      FieldName = 'Marketingcontact'
      Visible = False
      Size = 1
    end
  end
  object qryLeadLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblMarketingleadlines')
    Left = 382
    Top = 40
    object qryLeadLinesActiontypeName: TWideStringField
      DisplayLabel = 'Action Type'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ActiontypeName'
      LookupDataSet = qrySimpleTypes
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'ActionType'
      Size = 100
      Lookup = True
    end
    object qryLeadLinesActionDate: TDateTimeField
      DisplayLabel = 'Action Date'
      DisplayWidth = 12
      FieldName = 'ActionDate'
      Origin = 'tblmarketingleadlines.ActionDate'
    end
    object qryLeadLinesEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'tblmarketingleadlines.EmployeeName'
      Size = 255
    end
    object qryLeadLinesNotes: TWideMemoField
      DisplayWidth = 56
      FieldName = 'Notes'
      Origin = 'tblmarketingleadlines.Notes'
      BlobType = ftWideMemo
    end
    object qryLeadLinesDone: TWideStringField
      DisplayWidth = 4
      FieldName = 'Done'
      Origin = 'tblmarketingleadlines.Done'
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesCreationDate: TDateTimeField
      DisplayLabel = 'Action Date'
      DisplayWidth = 18
      FieldName = 'CreationDate'
      Origin = 'tblmarketingleadlines.CreationDate'
      Visible = False
    end
    object qryLeadLinesResultTypeName: TWideStringField
      DisplayLabel = 'Follow-Up'
      DisplayWidth = 22
      FieldName = 'ResultTypeName'
      Origin = 'tblmarketingleadlines.ResultTypeName'
      Visible = False
      Size = 255
    end
    object qryLeadLinesFollowUpDate: TDateTimeField
      DisplayLabel = 'Follow-Up / Action Date'
      DisplayWidth = 20
      FieldName = 'FollowUpDate'
      Origin = 'tblmarketingleadlines.FollowUpDate'
      Visible = False
    end
    object qryLeadLinesUpdateDate: TDateTimeField
      DisplayLabel = 'Last Updated'
      DisplayWidth = 17
      FieldName = 'UpdateDate'
      Origin = 'tblmarketingleadlines.UpdateDate'
      Visible = False
    end
    object qryLeadLinesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblmarketingleadlines.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryLeadLinesLeadID: TIntegerField
      FieldName = 'LeadID'
      Origin = 'tblmarketingleadlines.LeadID'
      Visible = False
    end
    object qryLeadLinesLeadLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'LeadLineID'
      Origin = 'tblmarketingleadlines.LeadLineID'
      Visible = False
    end
    object qryLeadLinesActionType: TIntegerField
      FieldName = 'ActionType'
      Origin = 'tblmarketingleadlines.ActionType'
      Visible = False
    end
    object qryLeadLinesActionID: TIntegerField
      FieldName = 'ActionID'
      Origin = 'tblmarketingleadlines.ActionID'
      Visible = False
    end
    object qryLeadLinesFollowupID: TIntegerField
      FieldName = 'FollowupID'
      Origin = 'tblmarketingleadlines.FollowupID'
      Visible = False
    end
    object qryLeadLinesActionRef: TWideStringField
      FieldName = 'ActionRef'
      Origin = 'tblmarketingleadlines.ActionRef'
      Visible = False
      Size = 255
    end
    object qryLeadLinesStatusID: TIntegerField
      FieldName = 'StatusID'
      Origin = 'tblmarketingleadlines.StatusID'
      Visible = False
    end
    object qryLeadLinesPriority: TIntegerField
      FieldName = 'Priority'
      Origin = 'tblmarketingleadlines.Priority'
      Visible = False
    end
    object qryLeadLinesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblmarketingleadlines.EmployeeID'
      Visible = False
    end
    object qryLeadLinesDuration: TWideStringField
      FieldName = 'Duration'
      Origin = 'tblmarketingleadlines.Duration'
      Visible = False
      Size = 255
    end
    object qryLeadLinesTypeId: TIntegerField
      FieldName = 'TypeId'
      Origin = 'tblmarketingleadlines.TypeId'
      Visible = False
    end
    object qryLeadLinesTypeName: TWideStringField
      FieldName = 'TypeName'
      Origin = 'tblmarketingleadlines.TypeName'
      Visible = False
      Size = 255
    end
    object qryLeadLinesHours: TFloatField
      FieldName = 'Hours'
      Origin = 'tblmarketingleadlines.Hours'
      Visible = False
    end
    object qryLeadLinesResultTypeId: TIntegerField
      FieldName = 'ResultTypeId'
      Origin = 'tblmarketingleadlines.ResultTypeId'
      Visible = False
    end
    object qryLeadLinesIsPhoneFollowUp: TWideStringField
      FieldName = 'IsPhoneFollowUp'
      Origin = 'tblmarketingleadlines.IsPhoneFollowUp'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesEntryCount: TIntegerField
      FieldName = 'EntryCount'
      Origin = 'tblmarketingleadlines.EntryCount'
      Visible = False
    end
    object qryLeadLinesCreatedByID: TIntegerField
      FieldName = 'CreatedByID'
      Origin = 'tblmarketingleadlines.CreatedByID'
      Visible = False
    end
    object qryLeadLinesIsMarketing: TWideStringField
      FieldName = 'IsMarketing'
      Origin = 'tblmarketingleadlines.IsMarketing'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesIsLead: TWideStringField
      FieldName = 'IsLead'
      Origin = 'tblmarketingleadlines.IsLead'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblmarketingleadlines.msTimeStamp'
      Visible = False
    end
  end
  object dsLeadLines: TDataSource
    DataSet = qryLeadLines
    Left = 411
    Top = 40
  end
  object qryActionType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblSimpleTypes WHERE '
      'Active <> '#39'F'#39' '
      'AND TypeCode ='#39'LeadActiontype'#39' '
      
        'AND NOT (name in ('#39'Appointment'#39', '#39'Invoice'#39', '#39'Quote'#39', '#39'SalesOrder' +
        #39','#39'Approved'#39','#39'Not Approved'#39'))')
    Left = 121
    Top = 40
    object qryActionTypeName: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
    object qryActionTypeId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'Id'
      Origin = 'tblsimpletypes.Id'
      Visible = False
    end
    object qryActionTypeTypeCode: TWideStringField
      DisplayWidth = 30
      FieldName = 'TypeCode'
      Origin = 'tblsimpletypes.TypeCode'
      Visible = False
      Size = 30
    end
    object qryActionTypeActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblsimpletypes.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeId, EmployeeName, Active FROM tblEmployees'
      'WHERE Active = '#39'T'#39)
    Left = 63
    Top = 40
  end
  object qryLeads: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblMArketingLeads')
    Left = 5
    Top = 40
    object qryLeadsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblMArketingLeads.GlobalRef'
      Size = 255
    end
    object qryLeadsLeadID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'LeadID'
      Origin = 'tblMArketingLeads.LeadID'
    end
    object qryLeadsMarketingContactID: TIntegerField
      FieldName = 'MarketingContactID'
      Origin = 'tblMArketingLeads.MarketingContactID'
    end
    object qryLeadsClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblMArketingLeads.ClientID'
    end
    object qryLeadsRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblMArketingLeads.RepID'
    end
    object qryLeadsEnteredByEmployeeID: TIntegerField
      FieldName = 'EnteredByEmployeeID'
      Origin = 'tblMArketingLeads.EnteredByEmployeeID'
    end
    object qryLeadsIsLead: TWideStringField
      FieldName = 'IsLead'
      Origin = 'tblMArketingLeads.IsLead'
      FixedChar = True
      Size = 1
    end
    object qryLeadsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblMArketingLeads.msTimeStamp'
    end
    object qryLeadsCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblMArketingLeads.Company'
      Size = 255
    end
    object qryLeadsLeadStatus: TWideStringField
      FieldName = 'LeadStatus'
      Size = 255
    end
    object qryLeadsnotes: TWideStringField
      FieldName = 'notes'
      Size = 255
    end
    object qryLeadsCreatedOn: TDateTimeField
      FieldName = 'CreatedOn'
    end
    object qryLeadsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object daLeads: TDataSource
    DataSet = qryLeads
    Left = 34
    Top = 40
  end
  object qryMediaType: TERPQuery
    SQL.Strings = (
      'SELECT  '
      'tblSource.MedTypeID, tblSource.MediaType, tblSource.Active, '
      'tblSource.CreationDate '
      'FROM tblSource '
      
        'WHERE (((tblSource.MediaType)>" ") And ((tblSource.Active)<>'#39'F'#39')' +
        ') '
      'ORDER BY tblSource.MediaType; ')
    Options.LongStrings = False
    Left = 470
    Top = 40
  end
  object qryContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblMarketingcontactContacts'
      'WHERE MarketingcontactID=:ID;')
    OnCalcFields = qryContactsCalcFields
    Left = 501
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryContactsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblMarketingcontactContacts.GlobalRef'
      Size = 255
    end
    object qryContactsContactID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ContactID'
      Origin = 'tblMarketingcontactContacts.ContactID'
      Visible = False
    end
    object qryContactsMarketingContactID: TIntegerField
      FieldName = 'MarketingContactID'
      Origin = 'tblMarketingcontactContacts.MarketingContactID'
    end
    object qryContactsCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblMarketingcontactContacts.Company'
      Size = 50
    end
    object qryContactsContactTitle: TWideStringField
      FieldName = 'ContactTitle'
      Origin = 'tblMarketingcontactContacts.ContactTitle'
      Size = 32
    end
    object qryContactsContactFirstName: TWideStringField
      FieldName = 'ContactFirstName'
      Origin = 'tblMarketingcontactContacts.ContactFirstName'
      Size = 30
    end
    object qryContactsContactSurName: TWideStringField
      FieldName = 'ContactSurName'
      Origin = 'tblMarketingcontactContacts.ContactSurName'
      Size = 30
    end
    object qryContactsContactAddress: TWideStringField
      FieldName = 'ContactAddress'
      Origin = 'tblMarketingcontactContacts.ContactAddress'
      Size = 255
    end
    object qryContactsContactAddress2: TWideStringField
      FieldName = 'ContactAddress2'
      Origin = 'tblMarketingcontactContacts.ContactAddress2'
      Size = 255
    end
    object qryContactsContactAddress3: TWideStringField
      FieldName = 'ContactAddress3'
      Origin = 'tblMarketingcontactContacts.ContactAddress3'
      Size = 255
    end
    object qryContactsContactCity: TWideStringField
      FieldName = 'ContactCity'
      Origin = 'tblMarketingcontactContacts.ContactCity'
      Size = 255
    end
    object qryContactsContactState: TWideStringField
      FieldName = 'ContactState'
      Origin = 'tblMarketingcontactContacts.ContactState'
      Size = 255
    end
    object qryContactsContactPcode: TWideStringField
      FieldName = 'ContactPcode'
      Origin = 'tblMarketingcontactContacts.ContactPcode'
      Size = 255
    end
    object qryContactsContactCountry: TWideStringField
      FieldName = 'ContactCountry'
      Origin = 'tblMarketingcontactContacts.ContactCountry'
      Size = 255
    end
    object qryContactsContactPH: TWideStringField
      FieldName = 'ContactPH'
      Origin = 'tblMarketingcontactContacts.ContactPH'
      Size = 255
    end
    object qryContactsContactAltPH: TWideStringField
      FieldName = 'ContactAltPH'
      Origin = 'tblMarketingcontactContacts.ContactAltPH'
      Size = 255
    end
    object qryContactsContactMOB: TWideStringField
      FieldName = 'ContactMOB'
      Origin = 'tblMarketingcontactContacts.ContactMOB'
      Size = 255
    end
    object qryContactsContactFax: TWideStringField
      FieldName = 'ContactFax'
      Origin = 'tblMarketingcontactContacts.ContactFax'
      Size = 255
    end
    object qryContactsContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Origin = 'tblMarketingcontactContacts.ContactEmail'
      Size = 255
    end
    object qryContactsNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'tblMarketingcontactContacts.Notes'
      Size = 255
    end
    object qryContactsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblMarketingcontactContacts.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryContactsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblMarketingcontactContacts.Active'
      FixedChar = True
      Size = 1
    end
    object qryContactsCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Origin = 'tblMarketingcontactContacts.CardNumber'
      Size = 255
    end
    object qryContactsAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Origin = 'tblMarketingcontactContacts.AccountNo'
      Size = 255
    end
    object qryContactsJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Origin = 'tblMarketingcontactContacts.JobTitle'
      Size = 255
    end
    object qryContactsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblMarketingcontactContacts.msTimeStamp'
      Visible = False
    end
    object qryContactsIsPrimarycontact: TWideStringField
      FieldName = 'IsPrimarycontact'
      Origin = 'tblMarketingcontactContacts.IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object qryContactsContactName: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'ContactName'
      Calculated = True
    end
  end
  object DSContacts: TDataSource
    DataSet = qryContacts
    Left = 536
    Top = 40
  end
  object qryCustomFields: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`tblcustomfields`.`CFLabel1`,'
      '`tblcustomfields`.`CFLabel2`,'
      '`tblcustomfields`.`CFLabel3`,'
      '`tblcustomfields`.`CFLabel4`,'
      '`tblcustomfields`.`CFLabel5`,'
      '`tblcustomfields`.`CFLabel6`,'
      '`tblcustomfields`.`CFLabel7`,'
      '`tblcustomfields`.`CFLabel8`,'
      '`tblcustomfields`.`CFLabel9`,'
      '`tblcustomfields`.`CFLabel10`,'
      '`tblcustomfields`.`CFLabel11`,'
      '`tblcustomfields`.`CFLabel12`,'
      '`tblcustomfields`.`CFLabel13`,'
      '`tblcustomfields`.`CFLabel14`,'
      '`tblcustomfields`.`CFLabel15`,'
      '`tblcustomfields`.`CFLabel16`,'
      '`tblcustomfields`.`CFLabel17`,'
      '`tblcustomfields`.`CFLabel18`,'
      '`tblcustomfields`.`CFMC1`,'
      '`tblcustomfields`.`CFMC2`,'
      '`tblcustomfields`.`CFMC3`,'
      '`tblcustomfields`.`CFMC4`,'
      '`tblcustomfields`.`CFMC5`,'
      '`tblcustomfields`.`CFMC6`,'
      '`tblcustomfields`.`CFMC7`,'
      '`tblcustomfields`.`CFMC8`,'
      '`tblcustomfields`.`CFMC9`,'
      '`tblcustomfields`.`CFMC10`,'
      '`tblcustomfields`.`CFMC11`,'
      '`tblcustomfields`.`CFMC12`,'
      '`tblcustomfields`.`CFMC13`,'
      '`tblcustomfields`.`CFMC14`,'
      '`tblcustomfields`.`CFMC15`,'
      '`tblcustomfields`.`CFMC16`,'
      '`tblcustomfields`.`CFMC17`,'
      '`tblcustomfields`.`CFMC18`'
      'FROM tblcustomfields')
    Left = 572
    Top = 40
    object qryCustomFieldsCFLabel1: TWideStringField
      FieldName = 'CFLabel1'
      Size = 16
    end
    object qryCustomFieldsCFLabel2: TWideStringField
      FieldName = 'CFLabel2'
      Size = 16
    end
    object qryCustomFieldsCFLabel3: TWideStringField
      FieldName = 'CFLabel3'
      Size = 16
    end
    object qryCustomFieldsCFLabel4: TWideStringField
      FieldName = 'CFLabel4'
      Size = 16
    end
    object qryCustomFieldsCFLabel5: TWideStringField
      FieldName = 'CFLabel5'
      Size = 16
    end
    object qryCustomFieldsCFLabel6: TWideStringField
      FieldName = 'CFLabel6'
      Size = 16
    end
    object qryCustomFieldsCFLabel7: TWideStringField
      FieldName = 'CFLabel7'
      Size = 16
    end
    object qryCustomFieldsCFLabel8: TWideStringField
      FieldName = 'CFLabel8'
      Size = 16
    end
    object qryCustomFieldsCFLabel9: TWideStringField
      FieldName = 'CFLabel9'
      Size = 16
    end
    object qryCustomFieldsCFLabel10: TWideStringField
      FieldName = 'CFLabel10'
      Size = 16
    end
    object qryCustomFieldsCFLabel11: TWideStringField
      FieldName = 'CFLabel11'
      Size = 16
    end
    object qryCustomFieldsCFLabel12: TWideStringField
      FieldName = 'CFLabel12'
      Size = 16
    end
    object qryCustomFieldsCFLabel13: TWideStringField
      FieldName = 'CFLabel13'
      Size = 16
    end
    object qryCustomFieldsCFLabel14: TWideStringField
      FieldName = 'CFLabel14'
      Size = 16
    end
    object qryCustomFieldsCFLabel15: TWideStringField
      FieldName = 'CFLabel15'
      Size = 16
    end
    object qryCustomFieldsCFLabel16: TWideStringField
      FieldName = 'CFLabel16'
      Size = 16
    end
    object qryCustomFieldsCFLabel17: TWideStringField
      FieldName = 'CFLabel17'
      Size = 16
    end
    object qryCustomFieldsCFLabel18: TWideStringField
      FieldName = 'CFLabel18'
      Size = 16
    end
    object qryCustomFieldsCFMC1: TWideStringField
      FieldName = 'CFMC1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC2: TWideStringField
      FieldName = 'CFMC2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC3: TWideStringField
      FieldName = 'CFMC3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC4: TWideStringField
      FieldName = 'CFMC4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC5: TWideStringField
      FieldName = 'CFMC5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC6: TWideStringField
      FieldName = 'CFMC6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC7: TWideStringField
      FieldName = 'CFMC7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC8: TWideStringField
      FieldName = 'CFMC8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC9: TWideStringField
      FieldName = 'CFMC9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC10: TWideStringField
      FieldName = 'CFMC10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC11: TWideStringField
      FieldName = 'CFMC11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC12: TWideStringField
      FieldName = 'CFMC12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC13: TWideStringField
      FieldName = 'CFMC13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC14: TWideStringField
      FieldName = 'CFMC14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC15: TWideStringField
      FieldName = 'CFMC15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC16: TWideStringField
      FieldName = 'CFMC16'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC17: TWideStringField
      FieldName = 'CFMC17'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFMC18: TWideStringField
      FieldName = 'CFMC18'
      FixedChar = True
      Size = 1
    end
  end
  object qryContact: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblMarketingcontactContacts'
      'WHERE MarketingcontactID=:ID;')
    AfterInsert = qryContactAfterInsert
    Left = 605
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryContactGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblMarketingcontactContacts.GlobalRef'
      Size = 255
    end
    object qryContactContactID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ContactID'
      Origin = 'tblMarketingcontactContacts.ContactID'
    end
    object qryContactMarketingContactID: TIntegerField
      FieldName = 'MarketingContactID'
      Origin = 'tblMarketingcontactContacts.MarketingContactID'
    end
    object qryContactCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblMarketingcontactContacts.Company'
      Size = 50
    end
    object qryContactContactTitle: TWideStringField
      FieldName = 'ContactTitle'
      Origin = 'tblMarketingcontactContacts.ContactTitle'
      Size = 32
    end
    object qryContactContactFirstName: TWideStringField
      FieldName = 'ContactFirstName'
      Origin = 'tblMarketingcontactContacts.ContactFirstName'
      Size = 30
    end
    object qryContactContactSurName: TWideStringField
      FieldName = 'ContactSurName'
      Origin = 'tblMarketingcontactContacts.ContactSurName'
      Size = 30
    end
    object qryContactContactAddress: TWideStringField
      FieldName = 'ContactAddress'
      Origin = 'tblMarketingcontactContacts.ContactAddress'
      Size = 255
    end
    object qryContactContactAddress2: TWideStringField
      FieldName = 'ContactAddress2'
      Origin = 'tblMarketingcontactContacts.ContactAddress2'
      Size = 255
    end
    object qryContactContactAddress3: TWideStringField
      FieldName = 'ContactAddress3'
      Origin = 'tblMarketingcontactContacts.ContactAddress3'
      Size = 255
    end
    object qryContactContactCity: TWideStringField
      FieldName = 'ContactCity'
      Origin = 'tblMarketingcontactContacts.ContactCity'
      Size = 255
    end
    object qryContactContactState: TWideStringField
      FieldName = 'ContactState'
      Origin = 'tblMarketingcontactContacts.ContactState'
      Size = 255
    end
    object qryContactContactPcode: TWideStringField
      FieldName = 'ContactPcode'
      Origin = 'tblMarketingcontactContacts.ContactPcode'
      Size = 255
    end
    object qryContactContactCountry: TWideStringField
      FieldName = 'ContactCountry'
      Origin = 'tblMarketingcontactContacts.ContactCountry'
      Size = 255
    end
    object qryContactContactPH: TWideStringField
      FieldName = 'ContactPH'
      Origin = 'tblMarketingcontactContacts.ContactPH'
      Size = 255
    end
    object qryContactContactAltPH: TWideStringField
      FieldName = 'ContactAltPH'
      Origin = 'tblMarketingcontactContacts.ContactAltPH'
      Size = 255
    end
    object qryContactContactMOB: TWideStringField
      FieldName = 'ContactMOB'
      Origin = 'tblMarketingcontactContacts.ContactMOB'
      Size = 255
    end
    object qryContactContactFax: TWideStringField
      FieldName = 'ContactFax'
      Origin = 'tblMarketingcontactContacts.ContactFax'
      Size = 255
    end
    object qryContactContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Origin = 'tblMarketingcontactContacts.ContactEmail'
      Size = 255
    end
    object qryContactNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'tblMarketingcontactContacts.Notes'
      Size = 255
    end
    object qryContactEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblMarketingcontactContacts.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryContactActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblMarketingcontactContacts.Active'
      FixedChar = True
      Size = 1
    end
    object qryContactCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Origin = 'tblMarketingcontactContacts.CardNumber'
      Size = 255
    end
    object qryContactAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Origin = 'tblMarketingcontactContacts.AccountNo'
      Size = 255
    end
    object qryContactJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Origin = 'tblMarketingcontactContacts.JobTitle'
      Size = 255
    end
    object qryContactmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblMarketingcontactContacts.msTimeStamp'
    end
    object qryContactIsPrimarycontact: TWideStringField
      FieldName = 'IsPrimarycontact'
      Origin = 'tblMarketingcontactContacts.IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
  end
  object qrySimpleTypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Id, TypeCode, Name, Active'
      'FROM tblsimpletypes')
    Left = 205
    Top = 245
    object StringField4: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
    object IntegerField2: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'Id'
      Origin = 'tblsimpletypes.Id'
      Visible = False
    end
    object StringField5: TWideStringField
      DisplayWidth = 30
      FieldName = 'TypeCode'
      Origin = 'tblsimpletypes.TypeCode'
      Visible = False
      Size = 30
    end
    object StringField6: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblsimpletypes.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryMarketingcontactProducts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblMarketingContactProducts'
      'WHERE MarketingcontactID=:ID;')
    Left = 653
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryMarketingcontactProductsProductName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'tblMarketingContactProducts.ProductName'
      Size = 100
    end
    object qryMarketingcontactProductsDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tblMarketingContactProducts.Description'
      Size = 255
    end
    object qryMarketingcontactProductsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblMarketingContactProducts.Active'
      FixedChar = True
      Size = 1
    end
    object qryMarketingcontactProductsGlobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'Globalref'
      Origin = 'tblMarketingContactProducts.Globalref'
      Visible = False
      Size = 255
    end
    object qryMarketingcontactProductsID: TLargeintField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'ID'
      Origin = 'tblMarketingContactProducts.ID'
      Visible = False
    end
    object qryMarketingcontactProductsMarketingcontactId: TLargeintField
      DisplayWidth = 15
      FieldName = 'MarketingcontactId'
      Origin = 'tblMarketingContactProducts.MarketingcontactId'
      Visible = False
    end
    object qryMarketingcontactProductsProductID: TLargeintField
      DisplayWidth = 15
      FieldName = 'ProductID'
      Origin = 'tblMarketingContactProducts.ProductID'
      Visible = False
    end
    object qryMarketingcontactProductsmstimestamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimestamp'
      Origin = 'tblMarketingContactProducts.mstimestamp'
      Visible = False
    end
  end
  object dsMarketingcontactProducts: TDataSource
    DataSet = qryMarketingcontactProducts
    Left = 688
    Top = 40
  end
  object cboProductQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        '#DUMMY QUERY - Sales.Formcreate dynamically changes the query fo' +
        'r seach options '
      ''
      'SELECT '
      'SUBSTRING_INDEX(P.ProductGroup,'#39'^'#39',1) AS Dept  , '
      
        'substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length(subs' +
        'tring_index(P.ProductGroup,'#39'^'#39',1))+2) AS Type  ,'
      
        'substring(substring_index(P.ProductGroup,'#39'^'#39',3),char_length(subs' +
        'tring_index(P.ProductGroup,'#39'^'#39',2))+2) AS Manuf  ,'
      'P.PARTSID as PARTSID,'
      'P.PARTTYPE as PARTTYPE,'
      'P.PRODUCTGROUP as PRODUCTGROUP,'
      'P.PARTNAME as PARTNAME,'
      'P.PARTSDESCRIPTION as PARTSDESCRIPTION,'
      'P.INCOMEACCNT as INCOMEACCNT,'
      'P.PurchaseDesc as PurchaseDesc,'
      'P.ASSETACCNT as ASSETACCNT,'
      'P.COGSACCNT as COGSACCNT,'
      'P.BARCODE as BARCODE,'
      'P.PRODUCTCODE as PRODUCTCODE,'
      'P.PURCHTAXCODE as PURCHTAXCODE,'
      'P.PREFEREDSUPP as PREFEREDSUPP,'
      'P.Batch as Batch,'
      'P.SpecialDiscount as SpecialDiscount,'
      'P.SNTracking as SNTracking,'
      'P.BuyQTY1 as BuyQTY1,'
      'P.BuyQTY2 as BuyQTY2,'
      'P.BuyQTY3 as BuyQTY3,'
      'P.COST1 as COST1,'
      'P.COST2 as COST2,'
      'P.COST3 as COST3,'
      'P.SellQTY1 as SellQTY1,'
      'P.SellQTY2 as SellQTY2,'
      'P.SellQTY3 as SellQTY3,'
      'P.PRICE1 as PRICE1,'
      'P.PRICE2 as PRICE2,'
      'P.PRICE3 as PRICE3,'
      'P.WHOLESALEPRICE as WHOLESALEPRICE,'
      'P.Active as Active,'
      'P.EditedFlag as EditedFlag,'
      'P.MultipleBins as MultipleBins,'
      'P.AvgCost as AvgCost,'
      'P.Discontinued as Discontinued,'
      'P.Attrib1Purchase as Attrib1Purchase,'
      'P.Attrib2Purchase as Attrib2Purchase,'
      'P.Attrib1PurchaseRate as Attrib1PurchaseRate,'
      
        'if (ifnull(LatestCost ,0) = 0 , cost1, LatestCost ) as LatestCos' +
        'tPrice  , '
      'p.TAXCODE, p.AutoBatch,'
      'p.Attrib1Sale,'
      'p.Attrib2Sale, '
      ' p.Attrib1SaleRate, '
      'P.LatestCostDate as LatestCostDate'
      'FROM tblParts P'
      'WHERE P.Active = "T"'
      ' AND ('
      '  ((1 = 0) or (IsNull(1))) '
      
        'or ((1 = 1) and ((Partname  LIKE Concat('#39'As'#39',"%")) or (PARTSDESC' +
        'RIPTION LIKE Concat('#39'As'#39',"%")) or (SUBSTRING_INDEX(P.ProductGrou' +
        'p,'#39'^'#39',1) LIKE Concat('#39'As'#39',"%")) or (substring(substring_index(P.' +
        'ProductGroup,'#39'^'#39',2),char_length(substring_index(P.ProductGroup,'#39 +
        '^'#39',1))+2) LIKE Concat('#39'As'#39',"%")) or (substring(substring_index(P' +
        '.ProductGroup,'#39'^'#39',3),char_length(substring_index(P.ProductGroup,' +
        #39'^'#39',2))+2) LIKE Concat('#39'As'#39',"%")) )) '
      
        'or ((1 = 2) and ((Partname  LIKE Concat("%",'#39'As'#39',"%")) or (PARTS' +
        'DESCRIPTION LIKE Concat("%",'#39'As'#39',"%")) or (SUBSTRING_INDEX(P.Pro' +
        'ductGroup,'#39'^'#39',1) LIKE Concat("%",'#39'As'#39',"%")) or (substring(substr' +
        'ing_index(P.ProductGroup,'#39'^'#39',2),char_length(substring_index(P.Pr' +
        'oductGroup,'#39'^'#39',1))+2) LIKE Concat("%",'#39'As'#39',"%")) or (substring(s' +
        'ubstring_index(P.ProductGroup,'#39'^'#39',3),char_length(substring_index' +
        '(P.ProductGroup,'#39'^'#39',2))+2) LIKE Concat("%",'#39'As'#39',"%")) )) '
      ')'
      'and IfNull(:SearchValue,"") <> ""')
    FilterOptions = [foCaseInsensitive]
    AfterOpen = cboProductQryAfterOpen
    Options.LongStrings = False
    Left = 271
    Top = 42
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object cboProductQryPARTNAME: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 15
      FieldName = 'PARTNAME'
      Origin = 'tblParts.PARTNAME'
      Size = 60
    end
    object cboProductQryPartsDescription: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 30
      FieldName = 'PartsDescription'
      Origin = 'tblParts.PARTSDESCRIPTION'
      Size = 255
    end
    object cboProductQryManuf: TWideStringField
      DisplayWidth = 255
      FieldName = 'Manuf'
      Origin = '.Manuf'
      Visible = False
      Size = 255
    end
    object cboProductQryType: TWideStringField
      DisplayWidth = 255
      FieldName = 'Type'
      Origin = '.Type'
      Visible = False
      Size = 255
    end
    object cboProductQryDept: TWideStringField
      DisplayWidth = 255
      FieldName = 'Dept'
      Origin = '.Dept'
      Visible = False
      Size = 255
    end
    object cboProductQryPARTSID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PARTSID'
      Origin = 'tblParts.PARTSID'
      Visible = False
    end
    object cboProductQryPARTTYPE: TWideStringField
      DisplayWidth = 13
      FieldName = 'PARTTYPE'
      Origin = 'tblParts.PARTTYPE'
      Visible = False
      Size = 13
    end
    object cboProductQryLatestCostPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'LatestCostPrice'
      Origin = '.LatestCostPrice'
      Visible = False
    end
    object cboProductQrySNTracking: TWideStringField
      DisplayWidth = 1
      FieldName = 'SNTracking'
      Origin = 'tblParts.SNTracking'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblParts.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryPreferedSupp: TWideStringField
      DisplayWidth = 55
      FieldName = 'PreferedSupp'
      Origin = 'tblParts.PREFEREDSUPP'
      Visible = False
      Size = 55
    end
    object cboProductQryPRODUCTGROUP: TWideStringField
      DisplayWidth = 255
      FieldName = 'PRODUCTGROUP'
      Origin = 'tblParts.PRODUCTGROUP'
      Visible = False
      Size = 255
    end
    object cboProductQryINCOMEACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'INCOMEACCNT'
      Origin = 'tblParts.INCOMEACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryASSETACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'ASSETACCNT'
      Origin = 'tblParts.ASSETACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryCOGSACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'COGSACCNT'
      Origin = 'tblParts.COGSACCNT'
      Visible = False
      Size = 50
    end
    object cboProductQryBARCODE: TWideStringField
      DisplayWidth = 35
      FieldName = 'BARCODE'
      Origin = 'tblParts.BARCODE'
      Visible = False
      Size = 35
    end
    object cboProductQryPRODUCTCODE: TWideStringField
      DisplayWidth = 255
      FieldName = 'PRODUCTCODE'
      Origin = 'tblParts.PRODUCTCODE'
      Visible = False
      Size = 255
    end
    object cboProductQryTAXCODE: TWideStringField
      DisplayWidth = 15
      FieldName = 'TAXCODE'
      Origin = 'tblParts.TAXCODE'
      Visible = False
      Size = 15
    end
    object cboProductQryBatch: TWideStringField
      DisplayWidth = 1
      FieldName = 'Batch'
      Origin = 'tblParts.Batch'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryAutoBatch: TWideStringField
      DisplayWidth = 1
      FieldName = 'AutoBatch'
      Origin = 'tblParts.AutoBatch'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryMultipleBins: TWideStringField
      DisplayWidth = 1
      FieldName = 'MultipleBins'
      Origin = 'tblParts.MultipleBins'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQrySpecialDiscount: TWideStringField
      DisplayWidth = 1
      FieldName = 'SpecialDiscount'
      Origin = 'tblParts.SpecialDiscount'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryBuyQTY1: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY1'
      Origin = 'tblParts.BuyQTY1'
      Visible = False
    end
    object cboProductQryBuyQTY2: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY2'
      Origin = 'tblParts.BuyQTY2'
      Visible = False
    end
    object cboProductQryBuyQTY3: TIntegerField
      DisplayWidth = 10
      FieldName = 'BuyQTY3'
      Origin = 'tblParts.BuyQTY3'
      Visible = False
    end
    object cboProductQryCOST1: TFloatField
      DisplayWidth = 10
      FieldName = 'COST1'
      Origin = 'tblParts.COST1'
      Visible = False
    end
    object cboProductQryCOST2: TFloatField
      DisplayWidth = 10
      FieldName = 'COST2'
      Origin = 'tblParts.COST2'
      Visible = False
    end
    object cboProductQryCOST3: TFloatField
      DisplayWidth = 10
      FieldName = 'COST3'
      Origin = 'tblParts.COST3'
      Visible = False
    end
    object cboProductQrySellQTY1: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY1'
      Origin = 'tblParts.SellQTY1'
      Visible = False
    end
    object cboProductQrySellQTY2: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY2'
      Origin = 'tblParts.SellQTY2'
      Visible = False
    end
    object cboProductQrySellQTY3: TIntegerField
      DisplayWidth = 10
      FieldName = 'SellQTY3'
      Origin = 'tblParts.SellQTY3'
      Visible = False
    end
    object cboProductQryPRICE1: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE1'
      Origin = 'tblParts.PRICE1'
      Visible = False
    end
    object cboProductQryPRICE2: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE2'
      Origin = 'tblParts.PRICE2'
      Visible = False
    end
    object cboProductQryPRICE3: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE3'
      Origin = 'tblParts.PRICE3'
      Visible = False
    end
    object cboProductQryWHOLESALEPRICE: TFloatField
      DisplayWidth = 10
      FieldName = 'WHOLESALEPRICE'
      Origin = 'tblParts.WHOLESALEPRICE'
      Visible = False
    end
    object cboProductQryEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblParts.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object cboProductQryAvgCost: TFloatField
      DisplayWidth = 10
      FieldName = 'AvgCost'
      Origin = 'tblParts.AvgCost'
      Visible = False
    end
    object cboProductQryAttrib1Sale: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1Sale'
      Origin = 'tblParts.Attrib1Sale'
      Visible = False
    end
    object cboProductQryAttrib2Sale: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib2Sale'
      Origin = 'tblParts.Attrib2Sale'
      Visible = False
    end
    object cboProductQryAttrib1SaleRate: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1SaleRate'
      Origin = 'tblParts.Attrib1SaleRate'
      Visible = False
    end
    object cboProductQryDiscontinued: TWideStringField
      DisplayWidth = 1
      FieldName = 'Discontinued'
      Origin = 'tblParts.Discontinued'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
end
