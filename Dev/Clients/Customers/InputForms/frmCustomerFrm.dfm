inherited frmCustomer: TfrmCustomer
  Left = 267
  Top = 172
  HelpContext = 254000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Customer'
  ClientHeight = 565
  ClientWidth = 996
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  ExplicitLeft = 267
  ExplicitTop = 172
  ExplicitWidth = 1012
  ExplicitHeight = 604
  DesignSize = (
    996
    565)
  PixelsPerInch = 96
  TextHeight = 15
  object Label15: TLabel [0]
    Left = 434
    Top = 313
    Width = 71
    Height = 18
    HelpContext = 254002
    AutoSize = False
    Caption = 'Stop Credit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label51: TLabel [1]
    Left = 559
    Top = 364
    Width = 3
    Height = 15
    HelpContext = 254003
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 559
    Width = 996
    HelpContext = 254369
    ExplicitTop = 549
    ExplicitWidth = 916
  end
  inherited shapehint: TShape
    Left = 13
    ExplicitLeft = 13
  end
  inherited imgGridWatermark: TImage
    HelpContext = 254001
  end
  inherited shapehintextra1: TShape
    Left = 59
    ExplicitLeft = 59
  end
  object pnlHeader: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 996
    Height = 81
    HelpContext = 254004
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      81)
    object txtCompany: TDBMemo
      Left = 11
      Top = 46
      Width = 858
      Height = 25
      HelpContext = 254005
      TabStop = False
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      DataField = 'Company'
      DataSource = frmCustomerSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object pnlTitle: TDNMPanel
      Left = 315
      Top = 4
      Width = 238
      Height = 36
      HelpContext = 254006
      Anchors = [akTop]
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
        Width = 234
        Height = 32
        HelpContext = 254007
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
          Height = 32
          HelpContext = 254008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Customer'
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
  end
  object DNMPanel9: TDNMPanel [8]
    Left = 0
    Top = 559
    Width = 996
    Height = 6
    HelpContext = 254010
    Align = alBottom
    BevelOuter = bvNone
    BevelWidth = 5
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object TabCtl20: TPageControl [9]
    AlignWithMargins = True
    Left = 4
    Top = 81
    Width = 872
    Height = 478
    HelpContext = 254011
    Margins.Left = 4
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    ActivePage = SpecialProds
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    RaggedRight = True
    TabHeight = 23
    TabOrder = 2
    TabWidth = 143
    OnChange = TabCtl20Change
    OnChanging = TabCtl20Changing
    OnResize = TabCtl20Resize
    object Customer_Info: TTabSheet
      HelpContext = 254012
      Caption = 'Customer Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object pnlMain: TDNMPanel
        Left = 0
        Top = 0
        Width = 864
        Height = 422
        HelpContext = 254013
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          864
          422)
        object Box72: TBevel
          Left = 54
          Top = 263
          Width = 752
          Height = 111
          HelpContext = 254014
          Anchors = [akLeft, akTop, akRight, akBottom]
          ExplicitWidth = 753
          ExplicitHeight = 144
        end
        object Box70: TBevel
          Left = 441
          Top = 7
          Width = 366
          Height = 217
          HelpContext = 254015
        end
        object Box69: TBevel
          Left = 54
          Top = 7
          Width = 366
          Height = 217
          HelpContext = 254016
        end
        object lblCompany: TLabel
          AlignWithMargins = True
          Left = 106
          Top = 136
          Width = 53
          Height = 15
          HelpContext = 254017
          Alignment = taRightJustify
          Caption = 'Company'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label27: TLabel
          Left = 99
          Top = 46
          Width = 60
          Height = 18
          HelpContext = 254018
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
          Left = 90
          Top = 76
          Width = 69
          Height = 18
          HelpContext = 254019
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
          Left = 93
          Top = 106
          Width = 66
          Height = 18
          HelpContext = 254020
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
          Left = 497
          Top = 16
          Width = 92
          Height = 18
          HelpContext = 254021
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
          Left = 513
          Top = 46
          Width = 76
          Height = 18
          HelpContext = 254022
          Alignment = taRightJustify
          AutoSize = False
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
          Left = 496
          Top = 76
          Width = 93
          Height = 18
          HelpContext = 254023
          Alignment = taRightJustify
          AutoSize = False
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
          Left = 527
          Top = 106
          Width = 62
          Height = 18
          HelpContext = 254024
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
        object Label35: TLabel
          Left = 519
          Top = 136
          Width = 70
          Height = 18
          HelpContext = 254025
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Alt Contact'
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
          Left = 65
          Top = 274
          Width = 41
          Height = 18
          HelpContext = 254026
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
        object lblClientType: TLabel
          Left = 69
          Top = 197
          Width = 90
          Height = 18
          HelpContext = 254027
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Customer Type'
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
          Left = 93
          Top = 166
          Width = 66
          Height = 18
          HelpContext = 254028
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
        object Label53: TLabel
          Left = 452
          Top = 197
          Width = 137
          Height = 18
          HelpContext = 254029
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Default Contact Method'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label92: TLabel
          Left = 518
          Top = 166
          Width = 71
          Height = 15
          HelpContext = 254370
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
        object lblClientPrintNameHeading: TLabel
          AlignWithMargins = True
          Left = 95
          Top = 16
          Width = 63
          Height = 15
          HelpContext = 254556
          Alignment = taRightJustify
          Caption = 'Print Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Company: TDBEdit
          Left = 166
          Top = 134
          Width = 245
          Height = 23
          HelpContext = 254030
          TabStop = False
          DataField = 'Company'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object Title: TDBEdit
          Left = 166
          Top = 44
          Width = 245
          Height = 23
          HelpContext = 254031
          DataField = 'Title'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object FirstName: TDBEdit
          Left = 166
          Top = 74
          Width = 245
          Height = 23
          HelpContext = 254032
          DataField = 'FirstName'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnExit = FirstNameExit
        end
        object LastName: TDBEdit
          Left = 166
          Top = 104
          Width = 245
          Height = 23
          HelpContext = 254033
          DataField = 'LastName'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnExit = FirstNameExit
        end
        object Phone: TwwDBEdit
          Left = 600
          Top = 14
          Width = 183
          Height = 23
          HelpContext = 254034
          DataField = 'Phone'
          DataSource = frmCustomerSrc
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
        end
        object FaxNumber: TwwDBEdit
          Left = 600
          Top = 44
          Width = 200
          Height = 23
          HelpContext = 254035
          DataField = 'FaxNumber'
          DataSource = frmCustomerSrc
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
        object MOB: TwwDBEdit
          Left = 600
          Top = 74
          Width = 200
          Height = 23
          HelpContext = 254036
          DataField = 'Mobile'
          DataSource = frmCustomerSrc
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
        end
        object AltPhone: TwwDBEdit
          Left = 600
          Top = 103
          Width = 200
          Height = 23
          HelpContext = 254037
          DataField = 'AltPhone'
          DataSource = frmCustomerSrc
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
        object AltContact: TDBEdit
          Left = 600
          Top = 134
          Width = 200
          Height = 23
          HelpContext = 254038
          DataField = 'AltContact'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object Notes: TDBMemo
          Left = 112
          Top = 271
          Width = 677
          Height = 98
          HelpContext = 254039
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataField = 'Notes'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 17
        end
        object cboClientType: TwwDBLookupCombo
          Left = 166
          Top = 195
          Width = 245
          Height = 23
          HelpContext = 254040
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ControlType.Strings = (
            'active;CheckBox;T;F')
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'TypeName'#9'25'#9'Type Name'#9'F'
            'active'#9'1'#9'Active'#9'F')
          DataField = 'ClientTypeID'
          DataSource = frmCustomerSrc
          LookupTable = qryClientTypes
          LookupField = 'ClientTypeID'
          Options = [loColLines, loTitles]
          ParentFont = False
          TabOrder = 6
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
          OnCloseUp = cboClientTypeCloseUp
          OnEnter = cboClientTypeEnter
        end
        object JobTitle: TDBEdit
          Left = 166
          Top = 164
          Width = 245
          Height = 23
          HelpContext = 254041
          DataField = 'JobTitle'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object btnAddDateTime: TDNMSpeedButton
          Left = 378
          Top = 433
          Width = 105
          Height = 27
          HelpContext = 254042
          Anchors = [akBottom]
          Caption = 'Add Date && Time'
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
          OnClick = btnAddDateTimeClick
        end
        object btnInvoice: TDNMSpeedButton
          Left = 524
          Top = 230
          Width = 87
          Height = 27
          HelpContext = 254044
          Caption = 'Invoice'
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
          TabOrder = 14
          AutoDisableParentOnclick = True
          OnClick = btnInvoiceClick
        end
        object btnSalesOrder: TDNMSpeedButton
          Left = 618
          Top = 230
          Width = 87
          Height = 27
          HelpContext = 254045
          Caption = 'Sales Order'
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
          TabOrder = 15
          AutoDisableParentOnclick = True
          OnClick = btnSalesOrderClick
        end
        object btnQuote: TDNMSpeedButton
          Left = 713
          Top = 230
          Width = 87
          Height = 27
          HelpContext = 254046
          Caption = 'Quote'
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
          TabOrder = 16
          AutoDisableParentOnclick = True
          OnClick = btnQuoteClick
        end
        object cboDefaultContactMethod: TwwDBComboBox
          Left = 600
          Top = 195
          Width = 200
          Height = 23
          HelpContext = 254047
          ShowButton = True
          Style = csDropDownList
          MapList = False
          AllowClearKey = False
          DataField = 'DefaultContactMethod'
          DataSource = frmCustomerSrc
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
          TabOrder = 13
          UnboundDataType = wwDefault
        end
        object btnOtherPhones: TDNMSpeedButton
          Left = 786
          Top = 15
          Width = 13
          Height = 23
          Hint = 'Other Phones'
          HelpContext = 254049
          Caption = '+'
          DisableTransparent = False
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 19
          AutoDisableParentOnclick = True
          OnClick = btnOtherPhonesClick
        end
        object btnCustStatement: TDNMSpeedButton
          Left = 54
          Top = 230
          Width = 87
          Height = 27
          HelpContext = 254050
          Caption = 'Statement'
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
          TabOrder = 20
          AutoDisableParentOnclick = True
          OnClick = btnCustStatementClick
        end
        object btnARReport: TDNMSpeedButton
          Left = 148
          Top = 230
          Width = 87
          Height = 27
          HelpContext = 254051
          Caption = 'AR Report'
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
          TabOrder = 21
          AutoDisableParentOnclick = True
          OnClick = btnARReportClick
        end
        object btnAddDate: TDNMSpeedButton
          Left = 113
          Top = 383
          Width = 111
          Height = 27
          HelpContext = 254350
          Anchors = [akLeft, akBottom]
          Caption = 'Add Date && Time'
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
          TabOrder = 22
          AutoDisableParentOnclick = True
          OnClick = btnAddDateClick
        end
        object edtSkypeName: TDBEdit
          Left = 599
          Top = 164
          Width = 200
          Height = 23
          HelpContext = 254371
          AutoSelect = False
          AutoSize = False
          DataField = 'SkypeName'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object DNMSpeedButton1: TDNMSpeedButton
          Left = 600
          Top = 383
          Width = 111
          Height = 27
          Hint = '"Go To The Notes Field"'
          HelpContext = 254342
          Anchors = [akLeft, akBottom]
          Caption = 'N&otes Audit Trail'
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
          TabOrder = 23
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton1Click
        end
        object btnRepair: TDNMSpeedButton
          Left = 430
          Top = 230
          Width = 87
          Height = 27
          HelpContext = 254557
          Caption = 'Repair'
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
          TabOrder = 24
          AutoDisableParentOnclick = True
          OnClick = btnRepairClick
        end
        object edtPrintName: TDBEdit
          Left = 166
          Top = 14
          Width = 245
          Height = 23
          HelpContext = 254558
          DataField = 'PrintName'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = edtPrintNameChange
          OnExit = edtPrintNameExit
        end
        object btnPriceList: TDNMSpeedButton
          Left = 242
          Top = 230
          Width = 87
          Height = 27
          HelpContext = 254043
          Caption = 'Price List'
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
          TabOrder = 25
          AutoDisableParentOnclick = True
          OnClick = btnPriceListClick
        end
        object btnLead: TDNMSpeedButton
          Left = 336
          Top = 230
          Width = 87
          Height = 27
          HelpContext = 254560
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
          TabOrder = 26
          AutoDisableParentOnclick = True
          OnClick = btnLeadClick
        end
      end
    end
    object Address_Info: TTabSheet
      HelpContext = 254052
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
      object PageAddress: TPageControl
        Left = 0
        Top = 0
        Width = 864
        Height = 422
        HelpContext = 254372
        ActivePage = tabAddressmain
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        RaggedRight = True
        TabHeight = 23
        TabOrder = 0
        TabWidth = 143
        OnChange = PageAddressChange
        OnChanging = PageAddressChanging
        object tabAddressmain: TTabSheet
          HelpContext = 254373
          Caption = 'Customer Address'
          object pnlAddress: TDNMPanel
            Left = 0
            Top = 0
            Width = 856
            Height = 389
            HelpContext = 254053
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Transparent = False
            object Bevel19: TBevel
              Left = 2
              Top = 339
              Width = 504
              Height = 42
              HelpContext = 254056
            end
            object Bevel17: TBevel
              Left = 2
              Top = 254
              Width = 504
              Height = 79
              HelpContext = 254055
            end
            object Bevel13: TBevel
              Left = 510
              Top = 254
              Width = 338
              Height = 127
              HelpContext = 254421
            end
            object Box41: TBevel
              Left = 483
              Top = 0
              Width = 365
              Height = 250
              HelpContext = 254423
            end
            object Box83: TBevel
              Left = 9
              Top = -2
              Width = 385
              Height = 250
              HelpContext = 254057
            end
            object Label180: TLabel
              Left = 36
              Top = 57
              Width = 66
              Height = 18
              HelpContext = 254058
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
            object Label38: TLabel
              Left = 597
              Top = 4
              Width = 186
              Height = 15
              HelpContext = 254059
              Alignment = taCenter
              AutoSize = False
              Caption = 'Bill To'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label39: TLabel
              Left = 108
              Top = 4
              Width = 186
              Height = 15
              HelpContext = 254060
              Alignment = taCenter
              AutoSize = False
              Caption = 'Physical Address'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label42: TLabel
              Left = 516
              Top = 24
              Width = 56
              Height = 18
              HelpContext = 254061
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
            object Label78: TLabel
              Left = 36
              Top = 24
              Width = 66
              Height = 18
              HelpContext = 254062
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
            object lblSuburb: TLabel
              Left = 36
              Top = 123
              Width = 66
              Height = 18
              HelpContext = 254063
              Alignment = taRightJustify
              AutoSize = False
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
            object lblPostCode: TLabel
              Left = 36
              Top = 189
              Width = 66
              Height = 18
              HelpContext = 254064
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
              Left = 36
              Top = 156
              Width = 66
              Height = 18
              HelpContext = 254065
              Alignment = taRightJustify
              AutoSize = False
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
            object Label182: TLabel
              Left = 506
              Top = 57
              Width = 66
              Height = 18
              HelpContext = 254066
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
            object lblBillSuburb: TLabel
              Left = 543
              Top = 123
              Width = 29
              Height = 18
              HelpContext = 254067
              Alignment = taRightJustify
              AutoSize = False
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
            object lblBillState: TLabel
              Left = 534
              Top = 156
              Width = 38
              Height = 18
              HelpContext = 254068
              Alignment = taRightJustify
              AutoSize = False
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
            object lblBillPostcode: TLabel
              Left = 510
              Top = 189
              Width = 62
              Height = 18
              HelpContext = 254069
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
            object Label10: TLabel
              Left = 36
              Top = 222
              Width = 66
              Height = 18
              HelpContext = 254070
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
            object Label11: TLabel
              Left = 506
              Top = 222
              Width = 66
              Height = 18
              HelpContext = 254071
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
            object Label12: TLabel
              Left = 43
              Top = 305
              Width = 77
              Height = 15
              HelpContext = 254072
              Alignment = taRightJustify
              Caption = 'Web Address'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object lblDefaultClass: TLabel
              Left = 45
              Top = 350
              Width = 75
              Height = 15
              HelpContext = 254073
              Alignment = taRightJustify
              Caption = 'Default Class'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Layout = tlCenter
            end
            object Label77: TLabel
              Left = 25
              Top = 271
              Width = 95
              Height = 17
              HelpContext = 254074
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Company Email'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label73: TLabel
              Left = 36
              Top = 90
              Width = 66
              Height = 18
              HelpContext = 254077
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
            object Label79: TLabel
              Left = 506
              Top = 90
              Width = 66
              Height = 18
              HelpContext = 254078
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
            object Label85: TLabel
              Left = 689
              Top = 327
              Width = 59
              Height = 15
              HelpContext = 254424
              Caption = 'Inco Place'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label84: TLabel
              Left = 689
              Top = 264
              Width = 99
              Height = 15
              HelpContext = 254425
              Caption = 'Port of Discharge'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label81: TLabel
              Left = 521
              Top = 264
              Width = 86
              Height = 15
              HelpContext = 254426
              Caption = 'Port of Loading'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label82: TLabel
              Left = 521
              Top = 323
              Width = 93
              Height = 15
              HelpContext = 254427
              Caption = 'Final Destination'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label8: TLabel
              Left = 320
              Top = 349
              Width = 95
              Height = 17
              HelpContext = 254540
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Customer Code'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Street: TDBEdit
              Left = 108
              Top = 22
              Width = 250
              Height = 23
              HelpContext = 254079
              DataField = 'Street'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object Street2: TDBEdit
              Left = 108
              Top = 54
              Width = 250
              Height = 23
              HelpContext = 254080
              DataField = 'Street2'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object State: TDBEdit
              Left = 108
              Top = 153
              Width = 89
              Height = 23
              HelpContext = 254081
              DataField = 'State'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object Postcode: TDBEdit
              Left = 108
              Top = 186
              Width = 89
              Height = 23
              HelpContext = 254082
              DataField = 'Postcode'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
            end
            object cmdCopy: TDNMSpeedButton
              Left = 400
              Top = 106
              Width = 72
              Height = 24
              Hint = '"Copy The Bill To Details In To The Physical Address"'
              HelpContext = 254083
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
              TabOrder = 7
              AutoDisableParentOnclick = True
              OnClick = cmdCopyClick
            end
            object BillStreet: TDBEdit
              Left = 583
              Top = 22
              Width = 250
              Height = 23
              HelpContext = 254084
              DataField = 'BillStreet'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object BillStreet2: TDBEdit
              Left = 583
              Top = 55
              Width = 250
              Height = 23
              HelpContext = 254085
              DataField = 'BillStreet2'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
            end
            object BillState: TDBEdit
              Left = 583
              Top = 154
              Width = 89
              Height = 23
              HelpContext = 254086
              DataField = 'BillState'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
            end
            object BillPostcode: TDBEdit
              Left = 583
              Top = 187
              Width = 89
              Height = 23
              HelpContext = 254087
              DataField = 'BillPostcode'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 13
            end
            object Suburb: TwwDBLookupCombo
              Left = 108
              Top = 120
              Width = 250
              Height = 23
              HelpContext = 254088
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'City_sub'#9'20'#9'Suburb'#9'T'
                'State'#9'20'#9'State'#9'T'
                'Postcode'#9'10'#9'Postcode'#9'T'
                'Code'#9'10'#9'Code'#9'T')
              DataField = 'Suburb'
              DataSource = frmCustomerSrc
              LookupTable = qrySuburb
              LookupField = 'City_sub'
              ParentFont = False
              TabOrder = 3
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnChange = SuburbChange
              OnCloseUp = SuburbCloseUp
              OnEnter = SuburbOnEnter
            end
            object BillSuburb: TwwDBLookupCombo
              Left = 583
              Top = 121
              Width = 250
              Height = 23
              HelpContext = 254089
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'City_sub'#9'20'#9'Suburb'#9'T'
                'State'#9'20'#9'State'#9'T'
                'Postcode'#9'10'#9'Postcode'#9'T'
                'Code'#9'10'#9'Code'#9'T')
              DataField = 'BillSuburb'
              DataSource = frmCustomerSrc
              LookupTable = qrySuburb
              LookupField = 'City_sub'
              ParentFont = False
              TabOrder = 11
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnChange = BillSuburbChange
              OnCloseUp = BillSuburbCloseUp
              OnEnter = SuburbOnEnter
            end
            object Country: TDBEdit
              Left = 108
              Top = 220
              Width = 250
              Height = 23
              HelpContext = 254090
              DataField = 'Country'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object BillCountry: TDBEdit
              Left = 583
              Top = 220
              Width = 250
              Height = 23
              HelpContext = 254091
              DataField = 'BillCountry'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 14
            end
            object cboClassName: TwwDBLookupCombo
              Left = 123
              Top = 346
              Width = 190
              Height = 23
              HelpContext = 254093
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'ClassName'#9'20'#9'Class Name'#9#9)
              DataField = 'DefaultClass'
              DataSource = frmCustomerSrc
              LookupTable = cboClassQry
              LookupField = 'ClassName'
              ParentFont = False
              TabOrder = 21
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              ShowMatchText = True
            end
            object Email: TDBEdit
              Left = 123
              Top = 268
              Width = 210
              Height = 23
              HelpContext = 254094
              DataField = 'Email'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 15
              OnDblClick = EmailDblClick
              OnExit = EmailExit
            end
            object Street3: TDBEdit
              Left = 108
              Top = 87
              Width = 250
              Height = 23
              HelpContext = 254097
              DataField = 'Street3'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object BillStreet3: TDBEdit
              Left = 583
              Top = 88
              Width = 250
              Height = 23
              HelpContext = 254098
              DataField = 'BillStreet3'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
            end
            object edtURL: TDBEdit
              Left = 123
              Top = 302
              Width = 369
              Height = 23
              HelpContext = 254092
              DataField = 'URL'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsUnderline]
              ParentFont = False
              TabOrder = 16
              OnDblClick = edtURLDblClick
            end
            object cboPortOfLoading: TwwDBLookupCombo
              Left = 521
              Top = 282
              Width = 146
              Height = 23
              HelpContext = 254428
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'City_sub'#9'20'#9'Suburb'#9'T'
                'State'#9'20'#9'State'#9'T'
                'Postcode'#9'10'#9'Postcode'#9'T'
                'Code'#9'10'#9'Code'#9'T')
              DataField = 'PortOfLanding'
              DataSource = frmCustomerSrc
              LookupTable = qrySuburb
              LookupField = 'City_sub'
              ParentFont = False
              TabOrder = 17
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnEnter = cboPortOfLoadingEnter
            end
            object cboPortOfDischarge: TwwDBLookupCombo
              Left = 689
              Top = 282
              Width = 146
              Height = 23
              HelpContext = 254429
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'City_sub'#9'20'#9'Suburb'#9'T'
                'State'#9'20'#9'State'#9'T'
                'Postcode'#9'10'#9'Postcode'#9'T'
                'Code'#9'10'#9'Code'#9'T')
              DataField = 'PortOfDischarge'
              DataSource = frmCustomerSrc
              LookupTable = qrySuburb
              LookupField = 'City_sub'
              ParentFont = False
              TabOrder = 18
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnEnter = cboPortOfDischargeEnter
            end
            object cboFinalDestination: TwwDBLookupCombo
              Left = 521
              Top = 344
              Width = 146
              Height = 23
              HelpContext = 254430
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'City_sub'#9'20'#9'Suburb'#9'T'
                'State'#9'20'#9'State'#9'T'
                'Postcode'#9'10'#9'Postcode'#9'T'
                'Code'#9'10'#9'Code'#9'T')
              DataField = 'FinalDestination'
              DataSource = frmCustomerSrc
              LookupTable = qrySuburb
              LookupField = 'City_sub'
              ParentFont = False
              TabOrder = 19
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnEnter = cboFinalDestinationEnter
            end
            object cboIncoPlace: TwwDBLookupCombo
              Left = 689
              Top = 344
              Width = 146
              Height = 23
              HelpContext = 254348
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'City_sub'#9'20'#9'Suburb'#9'T'
                'State'#9'20'#9'State'#9'T'
                'Postcode'#9'10'#9'Postcode'#9'T'
                'Code'#9'10'#9'Code'#9'T')
              DataField = 'IncoPlace'
              DataSource = frmCustomerSrc
              LookupTable = qrySuburb
              LookupField = 'City_sub'
              ParentFont = False
              TabOrder = 20
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnEnter = cboIncoPlaceEnter
            end
            object edtclientCode: TDBEdit
              Left = 434
              Top = 346
              Width = 58
              Height = 23
              HelpContext = 254541
              DataField = 'clientCode'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 22
            end
            object btnValidatePhysical: TDNMSpeedButton
              Left = 286
              Top = 152
              Width = 72
              Height = 24
              Hint = 'Validate Physical Address against Shipping providers database'
              HelpContext = 254542
              Caption = 'Validate'
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
              TabOrder = 23
              AutoDisableParentOnclick = True
              OnClick = btnValidatePhysicalClick
            end
            object btnValidateBill: TDNMSpeedButton
              Left = 758
              Top = 153
              Width = 72
              Height = 24
              Hint = 'Validate Bill Address against Shipping providers database'
              HelpContext = 254543
              Caption = 'Validate'
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
              TabOrder = 24
              AutoDisableParentOnclick = True
              OnClick = btnValidatePhysicalClick
            end
            object chkBillAddressValid: TwwCheckBox
              Left = 720
              Top = 189
              Width = 110
              Height = 17
              HelpContext = 254544
              DisableThemes = False
              AlwaysTransparent = False
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              DisplayValueChecked = 'T'
              DisplayValueUnchecked = 'F'
              NullAndBlankState = cbUnchecked
              Alignment = taLeftJustify
              Caption = 'Address Valid'
              DataField = 'BillAddressValid'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 25
              ReadOnly = True
            end
            object chkAddressValid: TwwCheckBox
              Left = 248
              Top = 189
              Width = 110
              Height = 17
              HelpContext = 254545
              DisableThemes = False
              AlwaysTransparent = False
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              DisplayValueChecked = 'True'
              DisplayValueUnchecked = 'False'
              NullAndBlankState = cbUnchecked
              Alignment = taLeftJustify
              Caption = 'Address Valid'
              DataField = 'AddressValid'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 26
              ReadOnly = True
            end
          end
        end
        object TabShippingAddresses: TTabSheet
          HelpContext = 254374
          Caption = 'Shipping Addresses'
          ImageIndex = 1
          object pnlShippingAddress: TDNMPanel
            Left = 0
            Top = 0
            Width = 856
            Height = 389
            HelpContext = 254375
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object lblcustomerShipAddresslist: TLabel
              Left = 1
              Top = 373
              Width = 854
              Height = 15
              HelpContext = 254376
              Align = alBottom
              Alignment = taCenter
              Caption = 
                'The record in RED colour is the Customer'#39's physical Address. Thi' +
                's record is always updated from the customer card and is not edi' +
                'table from any where.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              WordWrap = True
              ExplicitWidth = 828
            end
            object grdShipAddressList: TwwDBGrid
              Left = 1
              Top = 1
              Width = 854
              Height = 372
              HelpContext = 254377
              Selected.Strings = (
                'ContactName'#9'10'#9'Contact Name'
                'Address'#9'20'#9'Address'
                'Address 2'#9'20'#9'Address 2'
                'Address 3'#9'20'#9'Address 3'
                'City'#9'10'#9'City'
                'PostCode'#9'10'#9'PostCode'
                'State'#9'10'#9'State'
                'Country'#9'10'#9'Country'
                'Active'#9'1'#9'Active'
                'PortOfLanding'#9'10'#9'Landing Port'
                'PortOfDischarge'#9'10'#9'Discharge Port'
                'FinalDestination'#9'10'#9'Final Destination'
                'IncoPlace'#9'10'#9'Inco Place')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Align = alClient
              DataSource = dscustomerShipAddresslist
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              OnCalcCellColors = grdShipAddressListCalcCellColors
              OnDblClick = grdShipAddressListDblClick
              FooterColor = clWhite
              object btnDeleteShippingAddress: TwwIButton
                Left = 0
                Top = 0
                Width = 13
                Height = 22
                HelpContext = 254559
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
                OnClick = btnDeleteShippingAddressClick
              end
            end
          end
        end
        object tabCustomershippingoptions: TTabSheet
          Caption = 'Shipment'
          ImageIndex = 3
          object lblMsg: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 369
            Width = 850
            Height = 18
            HelpContext = 254335
            Margins.Top = 2
            Margins.Bottom = 2
            Align = alBottom
            Alignment = taCenter
            AutoSize = False
            Caption = 'lblMsg'
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Visible = False
            WordWrap = True
            ExplicitTop = 4
            ExplicitWidth = 104
          end
          object grdCustomershippingoptions: TwwDBGrid
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 850
            Height = 361
            Hint = 'Double click to Restore a Deleted Product'
            HelpContext = 254381
            ControlType.Strings = (
              'Active;CheckBox;T;F'
              'IsprimaryBarcode;CheckBox;T;F'
              'ProductName;CustomEdit;cboTaxExceptionProduct;F'
              'Default;CheckBox;T;F'
              'PayorType;CustomEdit;cboPayorType;F'
              'IsDefault;CheckBox;T;F')
            Selected.Strings = (
              'ShipperType'#9'35'#9'Provider'#9#9
              'PayorType'#9'30'#9'Payor Type'#9#9
              'AccountNumber'#9'27'#9'Account Number'#9#9
              'Active'#9'1'#9'Active ?'#9#9
              'IsDefault'#9'1'#9'Is Default?'#9'F'#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
            Align = alClient
            DataSource = dsCustomershippingoptions
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            OnEnter = grdCustomershippingoptionsEnter
          end
          object cboPayorType: TwwDBComboBox
            Left = 296
            Top = 160
            Width = 121
            Height = 23
            ShowButton = True
            Style = csDropDown
            MapList = False
            AllowClearKey = False
            DataField = 'PayorType'
            DataSource = dsCustomershippingoptions
            DropDownCount = 8
            ItemHeight = 0
            Sorted = False
            TabOrder = 1
            UnboundDataType = wwDefault
          end
        end
        object tabXML: TTabSheet
          HelpContext = 254521
          Caption = 'XML'
          ImageIndex = 2
          object pnlXML: TDNMPanel
            Left = 0
            Top = 0
            Width = 856
            Height = 389
            HelpContext = 254522
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Bevel28: TBevel
              Left = 18
              Top = 187
              Width = 387
              Height = 151
              HelpContext = 254422
            end
            object Bevel25: TBevel
              Left = 18
              Top = 16
              Width = 387
              Height = 151
              HelpContext = 254523
            end
            object Label43: TLabel
              Left = 36
              Top = 140
              Width = 56
              Height = 15
              HelpContext = 254075
              Caption = 'XMLEmail'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label118: TLabel
              Left = 29
              Top = 22
              Width = 186
              Height = 15
              HelpContext = 254524
              AutoSize = False
              Caption = 'Email XML Invoices'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label119: TLabel
              Left = 35
              Top = 253
              Width = 51
              Height = 15
              HelpContext = 254525
              Caption = 'FTP User'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label120: TLabel
              Left = 35
              Top = 282
              Width = 53
              Height = 15
              HelpContext = 254526
              Caption = 'FTP Pass'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label121: TLabel
              Left = 35
              Top = 311
              Width = 72
              Height = 15
              HelpContext = 254527
              Caption = 'FTP Address'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label45: TLabel
              Left = 29
              Top = 195
              Width = 186
              Height = 15
              HelpContext = 254528
              AutoSize = False
              Caption = 'FTP XML Invoices'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object lblSendXMLInvoices: TLabel
              Left = 53
              Top = 71
              Width = 353
              Height = 45
              HelpContext = 254561
              AutoSize = False
              Caption = 
                'When Checked, Emailing Invoice from the Invoice Form will Send t' +
                'he Invoice in XML Format  to the Email Address provided below'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object XMLEmail: TDBEdit
              Left = 117
              Top = 136
              Width = 258
              Height = 23
              HelpContext = 254095
              DataField = 'EmailXML'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnExit = XMLEmailExit
            end
            object DBCheckBox1: TDBCheckBox
              Left = 36
              Top = 52
              Width = 212
              Height = 16
              HelpContext = 254096
              Caption = 'Send XML Invoices on Invoice Run '
              DataField = 'SendXMLInvoices'
              DataSource = frmCustomerSrc
              TabOrder = 1
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              OnClick = DBCheckBox1Click
            end
            object FTPUserName: TDBEdit
              Left = 117
              Top = 249
              Width = 258
              Height = 23
              HelpContext = 254529
              DataField = 'FTPUserName'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object FTPPassword: TDBEdit
              Left = 117
              Top = 278
              Width = 258
              Height = 23
              HelpContext = 254530
              DataField = 'FTPPassword'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object FTPAddress: TDBEdit
              Left = 117
              Top = 307
              Width = 258
              Height = 23
              HelpContext = 254531
              DataField = 'FTPAddress'
              DataSource = frmCustomerSrc
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object DBCheckBox2: TDBCheckBox
              Left = 35
              Top = 224
              Width = 340
              Height = 15
              HelpContext = 254532
              Caption = 'Send FTP XML Invoices on Invoice Run '
              DataField = 'SendFTPXMLInvoices'
              DataSource = frmCustomerSrc
              TabOrder = 5
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              OnClick = DBCheckBox2Click
            end
          end
        end
        object tsEDI: TTabSheet
          Caption = 'EDI'
          ImageIndex = 4
          object DNMPanel28: TDNMPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 850
            Height = 383
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label117: TLabel
              Left = 55
              Top = 48
              Width = 60
              Height = 15
              Alignment = taRightJustify
              Caption = 'Vend Code'
            end
            object Label122: TLabel
              Left = 64
              Top = 78
              Width = 51
              Height = 15
              Alignment = taRightJustify
              Caption = 'FTP User'
            end
            object Label123: TLabel
              Left = 62
              Top = 108
              Width = 53
              Height = 15
              Alignment = taRightJustify
              Caption = 'FTP Pass'
            end
            object Label124: TLabel
              Left = 53
              Top = 138
              Width = 62
              Height = 15
              Alignment = taRightJustify
              Caption = 'FTP Server'
            end
            object Label125: TLabel
              Left = 67
              Top = 168
              Width = 48
              Height = 15
              Alignment = taRightJustify
              Caption = 'Send Dir'
            end
            object Label126: TLabel
              Left = 51
              Top = 198
              Width = 64
              Height = 15
              Alignment = taRightJustify
              Caption = 'Receive Dir'
            end
            object lblPOFTPPort: TLabel
              Left = 91
              Top = 228
              Width = 24
              Height = 15
              Alignment = taRightJustify
              Caption = 'Port'
            end
            object Label129: TLabel
              Left = 17
              Top = 259
              Width = 98
              Height = 15
              Alignment = taRightJustify
              Caption = 'Local Receive Dir'
            end
            object DBCheckBox3: TDBCheckBox
              Left = 74
              Top = 21
              Width = 203
              Height = 15
              HelpContext = 355275
              Caption = 'Send X12 Invoices Using CoreEDI'
              DataField = 'X12_SalesSendActive'
              DataSource = dsCoreEDIConfig
              TabOrder = 0
              ValueChecked = 'T'
              ValueUnchecked = 'F'
              OnClick = DBCheckBox3Click
            end
            object edtEDIVendorCode: TEdit
              Left = 120
              Top = 44
              Width = 200
              Height = 23
              HelpContext = 355272
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              Text = 'edtEDIVendorCode'
              OnChange = edtEDIVendorCodeChange
            end
            object edtSaleSendUser: TEdit
              Left = 120
              Top = 74
              Width = 200
              Height = 23
              HelpContext = 355272
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              Text = 'edtSaleSendUser'
              OnChange = edtSaleSendUserChange
            end
            object edtSaleSendPass: TEdit
              Left = 120
              Top = 104
              Width = 200
              Height = 23
              HelpContext = 355273
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              Text = 'edtSaleSendPass'
              OnChange = edtSaleSendPassChange
            end
            object edtSaleSendServer: TEdit
              Left = 120
              Top = 134
              Width = 200
              Height = 23
              HelpContext = 355274
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              Text = 'edtSaleSendServer'
              OnChange = edtSaleSendServerChange
            end
            object edtSaleSendDir: TEdit
              Left = 120
              Top = 164
              Width = 200
              Height = 23
              HelpContext = 355274
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
              Text = 'edtSaleSendDir'
              OnChange = edtSaleSendDirChange
            end
            object edtSaleReceiveDir: TEdit
              Left = 120
              Top = 194
              Width = 200
              Height = 23
              HelpContext = 355274
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              Text = 'edtSaleReceiveDir'
              OnChange = edtSaleReceiveDirChange
            end
            object edtSaleFTPPort: TEdit
              Left = 120
              Top = 224
              Width = 200
              Height = 23
              HelpContext = 355274
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              Text = 'edtSaleFTPPort'
              OnChange = edtSaleFTPPortChange
            end
            object edtLocalReceiveDir: TEdit
              Left = 120
              Top = 255
              Width = 200
              Height = 23
              HelpContext = 355274
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
              Text = 'edtPOFTPPort'
              OnChange = edtLocalReceiveDirChange
            end
          end
        end
      end
    end
    object tabAccounts: TTabSheet
      HelpContext = 254099
      Caption = 'Accounts'
      ImageIndex = 13
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DNMPanel13: TDNMPanel
        Left = 0
        Top = 0
        Width = 864
        Height = 422
        HelpContext = 254100
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Transparent = False
        object Label13: TLabel
          Left = 550
          Top = 111
          Width = 34
          Height = 30
          HelpContext = 254115
          Alignment = taCenter
          Caption = 'Stop Credit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object ChkStopCredit: TwwCheckBox
          Left = 560
          Top = 138
          Width = 15
          Height = 23
          HelpContext = 254146
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
          Caption = 'ChkStopCredit'
          DataField = 'StopCredit'
          DataSource = frmCustomerSrc
          TabOrder = 10
        end
        object DNMPanel2: TDNMPanel
          Left = 259
          Top = 258
          Width = 344
          Height = 164
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          object Label63: TLabel
            Left = 3
            Top = 8
            Width = 93
            Height = 15
            HelpContext = 254128
            Alignment = taRightJustify
            Caption = 'Credit Card Type'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label62: TLabel
            Left = 3
            Top = 35
            Width = 103
            Height = 15
            HelpContext = 254135
            Alignment = taRightJustify
            Caption = 'Card-holder Name'
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
            Left = 3
            Top = 62
            Width = 45
            Height = 15
            HelpContext = 254124
            Alignment = taRightJustify
            Caption = 'Card No'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label61: TLabel
            Left = 3
            Top = 90
            Width = 64
            Height = 15
            HelpContext = 254126
            Alignment = taRightJustify
            Caption = 'Expiry Date'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label25: TLabel
            Left = 182
            Top = 90
            Width = 24
            Height = 15
            HelpContext = 254562
            Alignment = taRightJustify
            Caption = 'CVC'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label32: TLabel
            Left = 3
            Top = 130
            Width = 33
            Height = 15
            HelpContext = 254127
            Alignment = taRightJustify
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
          object cboCreditCardType: TwwDBLookupCombo
            Left = 113
            Top = 4
            Width = 221
            Height = 23
            HelpContext = 254156
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Name'#9'25'#9'Name'#9'F')
            DataField = 'CreditCardType'
            DataSource = frmCustomerSrc
            LookupTable = QryCreditcardtypes
            LookupField = 'Name'
            Style = csDropDownList
            ParentFont = False
            TabOrder = 0
            AutoDropDown = False
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
            OnChange = cboCreditCardTypeChange
            OnCloseUp = cboCreditCardTypeCloseUp
          end
          object txtCardHolderName: TwwDBEdit
            Left = 113
            Top = 31
            Width = 221
            Height = 23
            HelpContext = 254152
            DataField = 'CreditCardCardHolderName'
            DataSource = frmCustomerSrc
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
          end
          object txtCardNumber: TEdit
            Left = 71
            Top = 56
            Width = 215
            Height = 23
            Hint = 'Right click for Options'
            HelpContext = 254152
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            PopupMenu = MnuCreditCard
            ShowHint = True
            TabOrder = 2
            OnExit = txtCardNumberExit
            OnKeyPress = AccountNoKeyPress
          end
          object wwDBEdit2: TwwDBEdit
            Left = 71
            Top = 86
            Width = 73
            Height = 23
            HelpContext = 254154
            DataField = 'CreditCardExpiryDate'
            DataSource = frmCustomerSrc
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
            OnDblClick = wwDBEdit1DblClick
          end
          object edtCreditCardCVC: TwwDBEdit
            Left = 213
            Top = 86
            Width = 73
            Height = 23
            HelpContext = 254563
            DataField = 'CreditCardCVC'
            DataSource = frmCustomerSrc
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
          object DBMemo1: TDBMemo
            Left = 42
            Top = 114
            Width = 298
            Height = 46
            HelpContext = 254155
            DataField = 'CreditCardNotes'
            DataSource = frmCustomerSrc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object btnClearCreditCardDetails: TDNMSpeedButton
            AlignWithMargins = True
            Left = 292
            Top = 59
            Width = 44
            Height = 50
            HelpContext = 254339
            Margins.Top = 2
            Margins.Bottom = 2
            Caption = 'Clear'
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
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            TabOrder = 6
            WordWrap = True
            AutoDisableParentOnclick = True
            OnClick = btnClearCreditCardDetailsClick
          end
        end
        object DNMPanel15: TDNMPanel
          Left = 5
          Top = 6
          Width = 337
          Height = 34
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Label56: TLabel
            Left = 53
            Top = 9
            Width = 76
            Height = 16
            HelpContext = 254106
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Account No'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object AccountNo: TDBEdit
            Left = 141
            Top = 6
            Width = 180
            Height = 23
            HelpContext = 254138
            DataField = 'ClientNo'
            DataSource = frmCustomerSrc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnKeyPress = AccountNoKeyPress
          end
        end
        object DNMPanel16: TDNMPanel
          Left = 5
          Top = 42
          Width = 337
          Height = 86
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label52: TLabel
            Left = 82
            Top = 8
            Width = 47
            Height = 16
            HelpContext = 254107
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Terms'
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
            Left = 36
            Top = 36
            Width = 93
            Height = 15
            HelpContext = 254108
            Alignment = taRightJustify
            Caption = 'Credit Limit ($'#39's)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label7: TLabel
            Left = 16
            Top = 63
            Width = 113
            Height = 15
            HelpContext = 254109
            Alignment = taRightJustify
            Caption = 'Grace Period (Days)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object cboTerms: TwwDBLookupCombo
            Left = 141
            Top = 5
            Width = 145
            Height = 23
            Hint = '"What Are Your Trading Terms For This Customer"'
            HelpContext = 254139
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Terms'#9'40'#9'Terms'#9'F')
            DataField = 'TermsID'
            DataSource = frmCustomerSrc
            LookupTable = qryTerms
            LookupField = 'TermsID'
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnChange = cboTermsChange
            OnCloseUp = cboTermsCloseUp
          end
          object CreditLimit: TwwDBEdit
            Left = 141
            Top = 32
            Width = 79
            Height = 23
            HelpContext = 254140
            DataField = 'CreditLimit'
            DataSource = frmCustomerSrc
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
          end
          object GracePeriod: TwwDBEdit
            Left = 141
            Top = 59
            Width = 39
            Height = 23
            HelpContext = 254141
            DataField = 'GracePeriod'
            DataSource = frmCustomerSrc
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
          object btnExportCredit: TDNMSpeedButton
            Left = 229
            Top = 57
            Width = 97
            Height = 27
            Hint = 'Apply Credit to Customer Jobs'
            HelpContext = 254142
            Caption = 'Export To Jobs'
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
            TabOrder = 3
            AutoDisableParentOnclick = True
            OnClick = btnExportCreditClick
          end
        end
        object DNMPanel18: TDNMPanel
          Left = 5
          Top = 130
          Width = 337
          Height = 34
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Label58: TLabel
            AlignWithMargins = True
            Left = 11
            Top = 9
            Width = 122
            Height = 15
            HelpContext = 254125
            Caption = 'Membership Card  No'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object CardNumber: TDBEdit
            Left = 141
            Top = 5
            Width = 187
            Height = 23
            HelpContext = 254153
            DataField = 'CardNumber'
            DataSource = frmCustomerSrc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
        object DNMPanel19: TDNMPanel
          Left = 5
          Top = 169
          Width = 244
          Height = 98
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object Label86: TLabel
            Left = 9
            Top = 10
            Width = 85
            Height = 15
            HelpContext = 254436
            Caption = 'Shipping Agent'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label88: TLabel
            Left = 29
            Top = 42
            Width = 65
            Height = 15
            HelpContext = 254437
            Caption = 'Description'
            Transparent = True
          end
          object Label89: TLabel
            Left = 37
            Top = 75
            Width = 57
            Height = 15
            HelpContext = 254438
            Caption = 'Insurance'
            Transparent = True
          end
          object cboShippingAgent: TwwDBLookupCombo
            Left = 100
            Top = 6
            Width = 140
            Height = 23
            HelpContext = 254444
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Code'#9'10'#9'Code'#9'F'
              'Description'#9'20'#9'Description'#9'F'
              'SupplierName'#9'20'#9'Supplier'#9'F')
            DataField = 'ShippingAgentID'
            DataSource = frmCustomerSrc
            LookupTable = QryShippingAgent
            LookupField = 'ShippingAgentID'
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnCloseUp = cboShippingAgentCloseUp
            OnEnter = cboShippingAgentEnter
          end
          object wwDBEdit5: TwwDBEdit
            Left = 100
            Top = 71
            Width = 140
            Height = 23
            HelpContext = 254446
            DataField = 'ShippingAgentInsurance'
            DataSource = frmCustomerSrc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Picture.AutoFill = False
            ReadOnly = True
            TabOrder = 2
            UnboundDataType = wwDefault
            WantReturns = True
            WordWrap = False
          end
          object wwDBEdit3: TwwDBEdit
            Left = 100
            Top = 38
            Width = 140
            Height = 23
            HelpContext = 254445
            DataField = 'ShippingAgentDescription'
            DataSource = frmCustomerSrc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Picture.AutoFill = False
            ReadOnly = True
            TabOrder = 1
            UnboundDataType = wwDefault
            WantReturns = True
            WordWrap = False
            OnCheckValue = edtBankAccBSBCheckValue
          end
        end
        object DNMPanel20: TDNMPanel
          Left = 5
          Top = 273
          Width = 244
          Height = 65
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object Label50: TLabel
            Left = 18
            Top = 44
            Width = 90
            Height = 15
            HelpContext = 254121
            Caption = 'Next Invoice No.'
            Transparent = True
          end
          object chkUseBaseInvNo: TwwCheckBox
            Left = 16
            Top = 14
            Width = 177
            Height = 17
            HelpContext = 254149
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
            Caption = ' Use Individual Invoice No.'
            DataField = 'UseInvBase'
            DataSource = frmCustomerSrc
            TabOrder = 0
            OnClick = chkUseBaseInvNoClick
          end
          object edtBaseInvNo: TwwDBEdit
            Left = 114
            Top = 40
            Width = 97
            Height = 23
            HelpContext = 254150
            DataField = 'InvBaseNumber'
            DataSource = frmCustomerSrc
            TabOrder = 1
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
        end
        object DNMPanel21: TDNMPanel
          Left = 5
          Top = 344
          Width = 244
          Height = 73
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          object Label23: TLabel
            Left = 14
            Top = 35
            Width = 44
            Height = 15
            HelpContext = 254440
            Alignment = taCenter
            Caption = 'Repairs'
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
            Left = 70
            Top = 35
            Width = 46
            Height = 15
            HelpContext = 254118
            Alignment = taCenter
            Caption = 'Booking'
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
            Left = 130
            Top = 35
            Width = 40
            Height = 15
            HelpContext = 254117
            Alignment = taCenter
            Caption = 'Invoice'
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
            Left = 190
            Top = 20
            Width = 35
            Height = 30
            HelpContext = 254546
            Alignment = taCenter
            Caption = 'Sales Order'
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
            Left = 13
            Top = 5
            Width = 103
            Height = 15
            HelpContext = 254439
            Caption = 'Force PO Entry On'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object wwCheckBox3: TwwCheckBox
            Left = 29
            Top = 51
            Width = 15
            Height = 17
            HelpContext = 254447
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
            DataField = 'ForcePOOnRepair'
            DataSource = frmCustomerSrc
            TabOrder = 0
          end
          object chkForcePOOnBooking: TwwCheckBox
            Left = 86
            Top = 51
            Width = 15
            Height = 17
            HelpContext = 254148
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
            Caption = 'ChkStopCredit'
            DataField = 'ForcePOOnBooking'
            DataSource = frmCustomerSrc
            TabOrder = 1
          end
          object chkForcePOOnInvoice: TwwCheckBox
            Left = 143
            Top = 51
            Width = 15
            Height = 17
            HelpContext = 254147
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
            DataField = 'ForcePOOnInvoice'
            DataSource = frmCustomerSrc
            TabOrder = 2
          end
          object wwCheckBox1: TwwCheckBox
            Left = 200
            Top = 51
            Width = 15
            Height = 17
            HelpContext = 254547
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
            DataField = 'ForcePoOnSalesOrder'
            DataSource = frmCustomerSrc
            TabOrder = 3
          end
        end
        object DNMPanel22: TDNMPanel
          Left = 345
          Top = 5
          Width = 258
          Height = 86
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          object Label17: TLabel
            AlignWithMargins = True
            Left = 8
            Top = 58
            Width = 95
            Height = 15
            HelpContext = 254114
            Caption = 'Payment Method'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label49: TLabel
            AlignWithMargins = True
            Left = 6
            Top = 31
            Width = 97
            Height = 15
            HelpContext = 254134
            Caption = 'Foreign Currency'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label65: TLabel
            Left = 79
            Top = 4
            Width = 24
            Height = 15
            HelpContext = 254111
            Caption = 'ABN'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object cboPaymentMethod: TwwDBLookupCombo
            Left = 109
            Top = 54
            Width = 137
            Height = 23
            HelpContext = 254145
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taRightJustify
            Selected.Strings = (
              'Name'#9'30'#9'Name'#9'F')
            DataField = 'PayMethodID'
            DataSource = frmCustomerSrc
            LookupTable = qryPayMethod
            LookupField = 'PayMethodID'
            Style = csDropDownList
            DropDownCount = 5
            DropDownWidth = 150
            ParentFont = False
            TabOrder = 2
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object cboForeignCurrencyCode: TwwDBLookupCombo
            Left = 109
            Top = 27
            Width = 137
            Height = 23
            HelpContext = 254161
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Code'#9'5'#9'Code'#9'F'
              'Country'#9'25'#9'Country'#9'F'#9
              'Currency'#9'15'#9'Currency'#9'F')
            DataField = 'ForeignExchangeSellCode'
            DataSource = frmCustomerSrc
            LookupTable = qryForeignCurrency
            LookupField = 'Code'
            Style = csDropDownList
            ParentFont = False
            TabOrder = 1
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
          end
          object ABN: TDBEdit
            Left = 109
            Top = 0
            Width = 137
            Height = 23
            HelpContext = 254143
            DataField = 'ABN'
            DataSource = frmCustomerSrc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
        object DNMPanel23: TDNMPanel
          Left = 345
          Top = 94
          Width = 199
          Height = 69
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          object Label1: TLabel
            Left = 7
            Top = 4
            Width = 69
            Height = 15
            HelpContext = 254122
            Caption = 'Outstanding'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label71: TLabel
            Left = 17
            Top = 22
            Width = 101
            Height = 16
            HelpContext = 254136
            AutoSize = False
            Caption = 'Amount'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label75: TLabel
            Left = 128
            Top = 22
            Width = 55
            Height = 16
            HelpContext = 254137
            AutoSize = False
            Caption = 'Hours'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object wwDBEdit1: TwwDBEdit
            Left = 17
            Top = 42
            Width = 105
            Height = 23
            HelpContext = 254151
            DataField = 'Balance'
            DataSource = frmCustomerSrc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnDblClick = wwDBEdit1DblClick
          end
          object txtFreeHours: TwwDBEdit
            Left = 128
            Top = 42
            Width = 63
            Height = 23
            HelpContext = 254163
            DataField = 'Hours'
            DataSource = frmCustomerSrc
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
            OnDblClick = wwDBEdit1DblClick
          end
        end
        object DNMPanel24: TDNMPanel
          Left = 259
          Top = 169
          Width = 344
          Height = 89
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          object Label67: TLabel
            Left = 5
            Top = 4
            Width = 129
            Height = 16
            HelpContext = 254130
            AutoSize = False
            Caption = 'Bank Account Name'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblBSB: TLabel
            Left = 5
            Top = 46
            Width = 24
            Height = 15
            HelpContext = 254131
            Caption = 'BSB'
            Transparent = True
          end
          object Label69: TLabel
            Left = 94
            Top = 46
            Width = 65
            Height = 15
            HelpContext = 254132
            Caption = 'Account No'
            Transparent = True
          end
          object Label70: TLabel
            Left = 238
            Top = 46
            Width = 61
            Height = 15
            HelpContext = 254133
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
          object edtBankAccName: TwwDBEdit
            Left = 5
            Top = 19
            Width = 330
            Height = 23
            HelpContext = 254157
            DataField = 'BankAccountName'
            DataSource = frmCustomerSrc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object edtBankAccBSB: TwwDBEdit
            Left = 5
            Top = 61
            Width = 83
            Height = 23
            HelpContext = 254158
            DataField = 'BankAccountBSB'
            DataSource = frmCustomerSrc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Picture.AutoFill = False
            TabOrder = 1
            UnboundDataType = wwDefault
            WantReturns = True
            WordWrap = False
            OnCheckValue = edtBankAccBSBCheckValue
          end
          object edtBankAccNo: TwwDBEdit
            Left = 93
            Top = 61
            Width = 136
            Height = 23
            HelpContext = 254159
            DataField = 'BankAccountNo'
            DataSource = frmCustomerSrc
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Picture.AutoFill = False
            TabOrder = 2
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
          object cboBankCode: TwwDBLookupCombo
            Left = 234
            Top = 61
            Width = 101
            Height = 23
            HelpContext = 254160
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
            DataSource = frmCustomerSrc
            LookupTable = qryBankCodes
            LookupField = 'BankCode'
            DropDownWidth = 300
            ParentFont = False
            TabOrder = 3
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnEnter = cboBankCodeEnter
          end
        end
        object DNMPanel27: TDNMPanel
          Left = 608
          Top = 0
          Width = 256
          Height = 422
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 11
          object DNMPanel4: TDNMPanel
            AlignWithMargins = True
            Left = 1
            Top = 273
            Width = 254
            Height = 144
            Margins.Left = 0
            Margins.Right = 0
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            object lblrewardPoints: TLabel
              Left = 5
              Top = 1
              Width = 89
              Height = 15
              HelpContext = 254119
              Caption = 'Reward Points :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object lblLinePoints: TLabel
              Left = 45
              Top = 29
              Width = 96
              Height = 15
              HelpContext = 254433
              Alignment = taRightJustify
              Caption = 'Opening Balance'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object lblOpeningBalanceAsOn: TLabel
              Left = 10
              Top = 56
              Width = 131
              Height = 15
              HelpContext = 254171
              Alignment = taRightJustify
              Caption = 'Opening balance as On'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object lblPointExpiresOn: TLabel
              Left = 39
              Top = 83
              Width = 102
              Height = 15
              HelpContext = 254435
              Alignment = taRightJustify
              Caption = 'Points Expires on '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label83: TLabel
              Left = 38
              Top = 111
              Width = 100
              Height = 15
              HelpContext = 254434
              Alignment = taRightJustify
              BiDiMode = bdRightToLeft
              Caption = 'Points Redeemed'
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              Transparent = True
            end
            object edtLinePoints: TwwDBEdit
              Left = 144
              Top = 25
              Width = 72
              Height = 23
              HelpContext = 254441
              DataField = 'LinePoints'
              DataSource = dsOpeningPoints
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
              OnExit = edtLinePointsExit
            end
            object edtOpeningBalanceAsOn: TwwDBDateTimePicker
              Left = 144
              Top = 52
              Width = 103
              Height = 23
              HelpContext = 254443
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'MS Sans Serif'
              CalendarAttributes.Font.Style = []
              CalendarAttributes.PopupYearOptions.StartYear = 2008
              DataField = 'OpeningBalanceAsOn'
              DataSource = dsOpeningPoints
              Epoch = 1950
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ShowButton = True
              TabOrder = 1
              OnExit = edtPointExpiresOnExit
            end
            object edtPointExpiresOn: TwwDBDateTimePicker
              Left = 144
              Top = 79
              Width = 103
              Height = 23
              HelpContext = 254197
              CalendarAttributes.Font.Charset = DEFAULT_CHARSET
              CalendarAttributes.Font.Color = clWindowText
              CalendarAttributes.Font.Height = -11
              CalendarAttributes.Font.Name = 'MS Sans Serif'
              CalendarAttributes.Font.Style = []
              CalendarAttributes.PopupYearOptions.StartYear = 2008
              DataField = 'PointExpiresOn'
              DataSource = dsOpeningPoints
              Epoch = 1950
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ShowButton = True
              TabOrder = 2
              OnExit = edtPointExpiresOnExit
            end
            object wwDBEdit4: TwwDBEdit
              Left = 144
              Top = 107
              Width = 72
              Height = 23
              HelpContext = 254442
              DataField = 'UsedPoints'
              DataSource = dsSalesRedeemedPoints
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
              OnDblClick = wwDBEdit1DblClick
            end
          end
          object DNMPanel26: TDNMPanel
            AlignWithMargins = True
            Left = 1
            Top = 57
            Width = 254
            Height = 210
            Margins.Left = 0
            Margins.Right = 0
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object Label9: TLabel
              Left = 4
              Top = 7
              Width = 98
              Height = 15
              HelpContext = 254112
              Alignment = taRightJustify
              Caption = 'Default Tax Code '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label72: TLabel
              Left = 4
              Top = 28
              Width = 209
              Height = 15
              HelpContext = 254379
              Caption = 'Products to Exclude Default TaxCode'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object grdTaxExceptionProducts: TwwDBGrid
              AlignWithMargins = True
              Left = 4
              Top = 49
              Width = 246
              Height = 157
              Hint = 'Double click to Restore a Deleted Product'
              HelpContext = 254381
              ControlType.Strings = (
                'Active;CheckBox;T;F'
                'IsprimaryBarcode;CheckBox;T;F'
                'ProductName;CustomEdit;cboTaxExceptionProduct;F')
              Selected.Strings = (
                'ProductName'#9'23'#9'ProductName'#9#9
                'Active'#9'1'#9'Active'#9#9)
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
              Align = alBottom
              DataSource = dsTaxExceptionProducts
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              OnDblClick = grdTaxExceptionProductsDblClick
              object delTaxExceptionProducts: TwwIButton
                Left = 0
                Top = 0
                Width = 22
                Height = 22
                HelpContext = 254382
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
                OnClick = delTaxExceptionProductsClick
              end
            end
            object cboTaxExceptionProduct: TERPDbLookupCombo
              Left = 72
              Top = 119
              Width = 65
              Height = 23
              HelpContext = 254383
              ControlType.Strings = (
                'Active;CheckBox;T;F')
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'PARTNAME'#9'15'#9'Product Name'#9'F')
              DataField = 'ProductName'
              DataSource = dsTaxExceptionProducts
              LookupTable = QryProduct
              LookupField = 'Partname'
              Options = [loTitles]
              TabOrder = 2
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnChange = cboTaxExceptionProductChange
              OnCloseUp = cboTaxExceptionProductCloseUp
              LookupFormClassName = 'TProductListExpressGUI'
              EditFormClassName = 'TfrmParts'
              LookupFormKeyStringFieldName = 'ProductName'
              LookupComboType = ctProduct
              AllowFullListSearchMode = False
              DisableNotInList = False
              AllowMultipleSelectFromList = False
              OpenListinF6WhenNotinList = False
              DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
              LookupIDField = 'PartsID'
              LookupFieldAlt = 'ProductPrintName'
            end
            object cboTaxCode: TERPDbLookupCombo
              Left = 109
              Top = 3
              Width = 140
              Height = 23
              HelpContext = 254144
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Taxname'#9'15'#9'Taxname'#9'F'
                'Description'#9'30'#9'Description'#9'T'
                'Location'#9'10'#9'Location'#9'T'
                'cRate'#9'10'#9'Rate'#9'T')
              DataField = 'Taxname'
              DataSource = frmCustomerSrc
              LookupTable = qryTaxCodes
              LookupField = 'Taxname'
              Options = [loTitles]
              ParentFont = False
              TabOrder = 0
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = True
              OnNotInList = cboTaxCodeNotInList
              LookupFormClassName = 'TTaxCodeListGUI'
              EditFormClassName = 'TfrmTaxcode'
              LookupFormKeyStringFieldName = 'Name'
              LookupComboType = ctNone
              AllowFullListSearchMode = False
              DisableNotInList = False
              AllowMultipleSelectFromList = False
              OpenListinF6WhenNotinList = False
              DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
            end
          end
          object DNMPanel25: TDNMPanel
            AlignWithMargins = True
            Left = 1
            Top = 4
            Width = 254
            Height = 47
            Margins.Left = 0
            Margins.Right = 0
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label76: TLabel
              Left = 4
              Top = 3
              Width = 112
              Height = 15
              HelpContext = 254380
              Caption = 'Default A/R Account'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object cboDefaultARAccountName: TwwDBLookupCombo
              Left = 4
              Top = 19
              Width = 245
              Height = 23
              HelpContext = 254384
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'AccountName'#9'50'#9'AccountName'#9'F')
              DataField = 'DefaultARAccountName'
              DataSource = frmCustomerSrc
              LookupTable = QryARAccounts
              LookupField = 'AccountName'
              ParentFont = False
              TabOrder = 0
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboDefaultARAccountNameCloseUp
            end
          end
        end
      end
    end
    object General: TTabSheet
      HelpContext = 254164
      Caption = 'General'
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
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 864
        Height = 422
        HelpContext = 254165
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        Locked = True
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          864
          422)
        object Bevel20: TBevel
          Left = 385
          Top = 253
          Width = 467
          Height = 78
          HelpContext = 254184
        end
        object Bevel22: TBevel
          Left = 385
          Top = 135
          Width = 467
          Height = 35
          HelpContext = 254168
        end
        object Bevel8: TBevel
          Left = 10
          Top = 3
          Width = 369
          Height = 229
          HelpContext = 254166
        end
        object Bevel23: TBevel
          Left = 8
          Top = 236
          Width = 371
          Height = 177
          HelpContext = 254167
          Anchors = [akLeft, akTop, akBottom]
        end
        object Bevel7: TBevel
          Left = 385
          Top = 3
          Width = 467
          Height = 129
          HelpContext = 254169
        end
        object Label128: TLabel
          Left = 388
          Top = 45
          Width = 99
          Height = 19
          HelpContext = 254448
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Ph Support Until '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label127: TLabel
          Left = 438
          Top = 16
          Width = 49
          Height = 17
          HelpContext = 254172
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Source '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label163: TLabel
          Left = 655
          Top = 16
          Width = 44
          Height = 17
          HelpContext = 254173
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Rep'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label19: TLabel
          Left = 83
          Top = 71
          Width = 99
          Height = 18
          HelpContext = 254174
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Picking Priority'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label26: TLabel
          Left = 105
          Top = 17
          Width = 77
          Height = 15
          HelpContext = 254175
          Alignment = taRightJustify
          Caption = 'Creation Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label30: TLabel
          Left = 95
          Top = 99
          Width = 87
          Height = 15
          HelpContext = 254176
          Alignment = taRightJustify
          Caption = 'Discharge Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblArea: TLabel
          Left = 432
          Top = 146
          Width = 75
          Height = 15
          HelpContext = 254177
          Alignment = taRightJustify
          Caption = 'Area Number'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblRelatedCust: TLabel
          Left = 23
          Top = 238
          Width = 109
          Height = 15
          HelpContext = 254178
          Caption = 'Related Customers'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblChildmessage: TLabel
          Left = 15
          Top = 395
          Width = 355
          Height = 18
          HelpContext = 254179
          Alignment = taCenter
          Anchors = [akLeft, akBottom]
          AutoSize = False
          Caption = 'lblChildmessage'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          Transparent = True
          Visible = False
          OnDblClick = lblChildmessageDblClick
          ExplicitTop = 385
        end
        object Bevel24: TBevel
          Left = 385
          Top = 335
          Width = 467
          Height = 78
          HelpContext = 254180
          Anchors = [akLeft, akTop, akBottom]
        end
        object Label60: TLabel
          Left = 396
          Top = 339
          Width = 89
          Height = 16
          HelpContext = 254181
          AutoSize = False
          Caption = 'Delivery Notes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label20: TLabel
          Left = 32
          Top = 126
          Width = 150
          Height = 18
          HelpContext = 254182
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Default Invoice Template'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label74: TLabel
          Left = 32
          Top = 154
          Width = 150
          Height = 18
          HelpContext = 254183
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Default Delivery Template'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Bevel12: TBevel
          Left = 385
          Top = 175
          Width = 467
          Height = 78
          HelpContext = 254449
        end
        object Label44: TLabel
          Left = 396
          Top = 177
          Width = 113
          Height = 16
          HelpContext = 254185
          AutoSize = False
          Caption = 'Sales Comments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label87: TLabel
          Left = 24
          Top = 181
          Width = 158
          Height = 18
          HelpContext = 254450
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Default Statement Template'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object cboShippingMethod_Label: TLabel
          Left = 415
          Top = 74
          Width = 72
          Height = 18
          HelpContext = 254170
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Ship Method'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label90: TLabel
          Left = 83
          Top = 44
          Width = 99
          Height = 18
          HelpContext = 254451
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Call Priority'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label91: TLabel
          Left = 616
          Top = 45
          Width = 83
          Height = 15
          HelpContext = 254452
          Alignment = taRightJustify
          Caption = 'Teamviewer ID'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label116: TLabel
          Left = 399
          Top = 256
          Width = 113
          Height = 16
          HelpContext = 254454
          AutoSize = False
          Caption = 'Repair Comments'
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
          Left = 8
          Top = 209
          Width = 174
          Height = 18
          HelpContext = 254548
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Default Sales Order Template'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label96: TLabel
          Left = 388
          Top = 103
          Width = 99
          Height = 19
          HelpContext = 254564
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Ship Account'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object grdRelatedClient: TwwDBGrid
          Left = 17
          Top = 254
          Width = 353
          Height = 154
          HelpContext = 254193
          ControlType.Strings = (
            'ChildCompany;CustomEdit;cboClientR;F')
          Selected.Strings = (
            'ChildCompany'#9'44'#9'Company'#9'F')
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
          TabOrder = 7
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnExit = grdRelatedClientExit
          OnFieldChanged = grdRelatedClientFieldChanged
          FooterColor = clWhite
          FooterCellColor = clWhite
          object wwIButton1: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            HelpContext = 254351
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
            OnClick = wwIButton1Click
          end
        end
        object cboMediaType: TwwDBLookupCombo
          Left = 493
          Top = 13
          Width = 156
          Height = 23
          Hint = '"Enter Where This Customer Came From"'
          HelpContext = 254195
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'MediaType'#9'40'#9'MediaType'#9'F')
          DataField = 'MedTypeID'
          DataSource = frmCustomerSrc
          LookupTable = qryMediaType
          LookupField = 'MedTypeID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboMediaTypeCloseUp
        end
        object cboRep: TwwDBLookupCombo
          Left = 704
          Top = 13
          Width = 145
          Height = 23
          Hint = '"Who Is The Rep For This Customer"'
          HelpContext = 254196
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'47'#9'EmployeeName'#9#9)
          DataField = 'RepID'
          DataSource = frmCustomerSrc
          LookupTable = qryEmployees
          LookupField = 'EmployeeID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
          OnChange = cboRepChange
          OnCloseUp = cboRepCloseUp
          OnEnter = cboRepEnter
        end
        object PhoneSupport: TwwDBDateTimePicker
          Left = 493
          Top = 42
          Width = 111
          Height = 23
          HelpContext = 254455
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          CalendarAttributes.PopupYearOptions.StartYear = 2008
          DataField = 'PhoneSupportTill'
          DataSource = frmCustomerSrc
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 10
        end
        object cboPickingPriority: TwwDBComboBox
          Left = 193
          Top = 68
          Width = 135
          Height = 23
          HelpContext = 254198
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          AutoDropDown = True
          AutoFillDate = False
          DataField = 'PickingPriority'
          DataSource = frmCustomerSrc
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
          TabOrder = 2
          UnboundDataType = wwDefault
          UnboundAlignment = taCenter
        end
        object wwDBDateTimePicker1: TwwDBDateTimePicker
          Left = 193
          Top = 13
          Width = 135
          Height = 23
          HelpContext = 254199
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'CreationDate'
          DataSource = frmCustomerSrc
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 0
        end
        object wwDBDateTimePicker2: TwwDBDateTimePicker
          Left = 193
          Top = 96
          Width = 135
          Height = 23
          HelpContext = 254200
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'DischargeDate'
          DataSource = frmCustomerSrc
          Epoch = 1950
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ShowButton = True
          TabOrder = 3
        end
        object memoDeliveryNotes: TDBMemo
          Left = 396
          Top = 357
          Width = 450
          Height = 55
          HelpContext = 254202
          Anchors = [akLeft, akTop, akBottom]
          DataField = 'DeliveryNotes'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 16
        end
        object cboInvoiceTemplate: TwwDBLookupCombo
          Left = 193
          Top = 123
          Width = 180
          Height = 23
          HelpContext = 254203
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'TemplName'#9'30'#9'Name'#9'T')
          DataField = 'DefaultInvoiceTemplateID'
          DataSource = frmCustomerSrc
          LookupTable = qryInvoiceTemplates
          LookupField = 'TemplID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object cboDeliveryTemplate: TwwDBLookupCombo
          Left = 193
          Top = 151
          Width = 180
          Height = 23
          HelpContext = 254204
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'TemplName'#9'30'#9'Name'#9'T')
          DataField = 'DefaultDeliveryTemplateID'
          DataSource = frmCustomerSrc
          LookupTable = qryDeliveryTemplates
          LookupField = 'TemplID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object memoSalesComments: TDBMemo
          Left = 396
          Top = 195
          Width = 452
          Height = 55
          HelpContext = 254205
          DataField = 'InvoiceComment'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 13
        end
        object wwCheckBox2: TwwCheckBox
          Left = 784
          Top = 176
          Width = 57
          Height = 17
          HelpContext = 254206
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
          Caption = 'PopUp'
          DataField = 'InvoiceCommentPopUp'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 12
        end
        object wwDBLookupCombo1: TwwDBLookupCombo
          Left = 193
          Top = 179
          Width = 180
          Height = 23
          HelpContext = 254456
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'TemplName'#9'30'#9'Name'#9'T')
          DataField = 'DefaultStatementTemplateId'
          DataSource = frmCustomerSrc
          LookupTable = QrystatementTemplates
          LookupField = 'TemplID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object cboVia: TwwDBLookupCombo
          Left = 493
          Top = 71
          Width = 189
          Height = 23
          Hint = 
            '"What Is The Customers Preferred Shipping Method For Any Goods T' +
            'hat Are Sold To Them"'
          HelpContext = 254194
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'ShippingMethod'#9'20'#9'ShippingMethod'#9#9)
          DataField = 'ShippingID'
          DataSource = frmCustomerSrc
          LookupTable = qryShipping
          LookupField = 'ShippingMethodID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object wwDBComboBox1: TwwDBComboBox
          Left = 193
          Top = 40
          Width = 135
          Height = 23
          HelpContext = 254457
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          AutoDropDown = True
          AutoFillDate = False
          DataField = 'CallPriority'
          DataSource = frmCustomerSrc
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
          TabOrder = 1
          UnboundDataType = wwDefault
          UnboundAlignment = taCenter
        end
        object wwDBEdit6: TwwDBEdit
          Left = 704
          Top = 42
          Width = 145
          Height = 23
          HelpContext = 254201
          DataField = 'TeamviewerID'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Picture.PictureMask = '#########'
          TabOrder = 17
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboClientR: TERPDbLookupCombo
          Left = 131
          Top = 321
          Width = 170
          Height = 23
          HelpContext = 254385
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Company'#9'45'#9'Company'#9'F')
          DataField = 'ChildCompany'
          DataSource = DSRelatedClients
          LookupTable = cboClientLookup
          LookupField = 'Company'
          ParentFont = False
          TabOrder = 18
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboClientCloseUp
          OnNotInList = cboClientNotInList
          LookupFormClassName = 'TCustomerExpressListGUI'
          EditFormClassName = 'TfrmCustomer'
          LookupFormKeyStringFieldName = 'Company'
          LookupComboType = ctCustomer
          AllowFullListSearchMode = False
          OnAfterchange = cboClientRAfterchange
          OnBeforeOpenList = cboClientRBeforeOpenList
          DisableNotInList = False
          AllowMultipleSelectFromList = False
          OpenListinF6WhenNotinList = False
          DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
          LookupIDField = 'ClientID'
          LookupFieldAlt = 'PrintName'
        end
        object chkIsInternal: TwwCheckBox
          Left = 659
          Top = 145
          Width = 182
          Height = 17
          HelpContext = 254458
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
          Caption = 'Internal Customer'
          DataField = 'IsInternal'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 20
        end
        object cboAreaCode: TwwDBLookupCombo
          Left = 518
          Top = 142
          Width = 131
          Height = 23
          Hint = '"Enter Where This Customer Came From"'
          HelpContext = 254459
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'AreaCode'#9'10'#9'Code'#9'F'
            'AreaName'#9'20'#9'Name'#9'F')
          DataField = 'Area'
          DataSource = frmCustomerSrc
          LookupTable = QryAreaCodes
          LookupField = 'AreaCode'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 19
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboMediaTypeCloseUp
        end
        object wwCheckBox9: TwwCheckBox
          Left = 787
          Top = 255
          Width = 57
          Height = 17
          HelpContext = 254460
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
          Caption = 'PopUp'
          DataField = 'repairCommentPopUp'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 14
        end
        object DBMemo2: TDBMemo
          Left = 398
          Top = 274
          Width = 450
          Height = 55
          HelpContext = 254461
          DataField = 'repairComment'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 15
        end
        object cboDefaultSalesOrderTemplate: TwwDBLookupCombo
          Left = 193
          Top = 207
          Width = 180
          Height = 23
          HelpContext = 254549
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'TemplName'#9'30'#9'Name'#9'T')
          DataField = 'DefaultSalesOrderTemplateID'
          DataSource = frmCustomerSrc
          LookupTable = qrySalesOrderTemplate
          LookupField = 'TemplID'
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 21
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object chkClientPaysShipping: TwwCheckBox
          Left = 704
          Top = 103
          Width = 151
          Height = 17
          Hint = 'Use Address Info-> Shipment to Alter this'
          HelpContext = 254565
          DisableThemes = False
          AlwaysTransparent = False
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          Caption = 'Cust Pays Shipping'
          DataField = 'ClientPaysShippment'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 22
          ReadOnly = True
        end
        object edtClientShippingAccountNo: TwwDBEdit
          Left = 493
          Top = 100
          Width = 189
          Height = 23
          Hint = 'Use Address Info-> Shipment to Alter this'
          HelpContext = 254566
          DataField = 'ClientShipperAccountNo'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 23
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
      end
    end
    object History: TTabSheet
      HelpContext = 254212
      Caption = '&History'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object pnlHistory: TDNMPanel
        Left = 0
        Top = 0
        Width = 864
        Height = 422
        HelpContext = 254213
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
        object grpHistory: TRadioGroup
          Left = 0
          Top = 0
          Width = 864
          Height = 73
          HelpContext = 254214
          Align = alTop
          Color = 15527129
          Columns = 5
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ItemIndex = 2
          Items.Strings = (
            'Appoints'
            'AR Notes'
            'Invoices'
            'Job Profit'
            'Jobs'
            'Product Sales'
            'Quotes'
            'Repairs'
            'Reward Points'
            'Sales Orders'
            'Statements'
            'Timesheet'
            'Non ERP Sales'
            'HR Forms')
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          OnClick = grpHistoryClick
        end
      end
    end
    object tabContacts: TTabSheet
      HelpContext = 254215
      Caption = 'C&ontacts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object pnlContacts: TDNMPanel
        Left = 0
        Top = 0
        Width = 864
        Height = 422
        HelpContext = 254216
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          864
          422)
        object Bevel3: TBevel
          Left = 0
          Top = 387
          Width = 864
          Height = 35
          HelpContext = 254217
          Align = alClient
          ExplicitLeft = 44
          ExplicitTop = 42
          ExplicitWidth = 620
          ExplicitHeight = 319
        end
        object Label6: TLabel
          Left = 386
          Top = 12
          Width = 91
          Height = 24
          HelpContext = 254219
          Anchors = [akTop]
          Caption = 'Contacts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 343
        end
        object Label80: TLabel
          Left = 28
          Top = 394
          Width = 133
          Height = 15
          HelpContext = 254353
          Anchors = [akLeft, akBottom]
          Caption = 'Show inactive Contacts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitTop = 384
        end
        object chkShowAll: TCheckBox
          Left = 7
          Top = 393
          Width = 15
          Height = 17
          HelpContext = 254223
          Anchors = [akLeft, akBottom]
          Color = 14867920
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          OnClick = chkShowAllClick
        end
        object cmdNewContact: TDNMSpeedButton
          Left = 300
          Top = 393
          Width = 99
          Height = 27
          Hint = 'Create New Contact'
          HelpContext = 254224
          Anchors = [akTop, akRight]
          Caption = '&New'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
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
          OnClick = cmdNewContactClick
        end
        object EditBtn: TDNMSpeedButton
          Left = 415
          Top = 393
          Width = 99
          Height = 27
          Hint = 'Edit Selected Contact'
          HelpContext = 254225
          Anchors = [akTop, akRight]
          Caption = '&Edit'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
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
          OnClick = EditbtnClick
        end
        object btnContactMessage: TDNMSpeedButton
          Left = 646
          Top = 393
          Width = 99
          Height = 27
          Hint = 'Send A Message To The Selected Contact'
          HelpContext = 254227
          Anchors = [akTop, akRight]
          Caption = 'Message'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
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
          OnClick = btnContactMessageClick
        end
        object btnFollowUps: TDNMSpeedButton
          Left = 530
          Top = 393
          Width = 99
          Height = 27
          Hint = 'Show FollowUps For The Selected Contact'
          HelpContext = 254550
          Anchors = [akTop, akRight]
          Caption = 'Follow Ups'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
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
          OnClick = btnFollowUpsClick
        end
        object pnlContactsForm: TDNMPanel
          Left = 0
          Top = 0
          Width = 864
          Height = 387
          HelpContext = 254551
          Align = alTop
          BevelOuter = bvLowered
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          Transparent = False
        end
        object btnContactCustomise: TDNMSpeedButton
          Left = 185
          Top = 393
          Width = 99
          Height = 27
          HelpContext = 254552
          Anchors = [akTop, akRight]
          Caption = 'Customise'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4210688
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 6
          AutoDisableParentOnclick = True
          OnClick = btnContactCustomiseClick
        end
      end
    end
    object Documents: TTabSheet
      HelpContext = 254230
      Caption = '&Documents'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object pnlDocuments: TDNMPanel
        Left = 0
        Top = 0
        Width = 864
        Height = 385
        HelpContext = 254231
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          864
          385)
        object Label66: TLabel
          Left = 972
          Top = 256
          Width = 183
          Height = 14
          HelpContext = 254236
          Alignment = taRightJustify
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'Drag and drop attachments into list'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitLeft = 885
        end
        object pnlDocumentsInner: TDNMPanel
          Left = 9
          Top = 6
          Width = 848
          Height = 375
          HelpContext = 254386
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Splitter1: TSplitter
            Left = 0
            Top = 177
            Width = 848
            Height = 3
            Cursor = crVSplit
            HelpContext = 254387
            Align = alTop
            ExplicitWidth = 225
          end
          object pnlDocumentsList: TDNMPanel
            Left = 0
            Top = 0
            Width = 848
            Height = 177
            HelpContext = 254388
            Align = alTop
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              848
              177)
            object Label140: TLabel
              Left = 659
              Top = 12
              Width = 178
              Height = 13
              HelpContext = 254234
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = 'Double click to open correspondence'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
              WordWrap = True
              ExplicitLeft = 572
            end
            object grdDocs: TwwDBGrid
              Left = 7
              Top = 32
              Width = 833
              Height = 142
              HelpContext = 254238
              ControlType.Strings = (
                'active;CheckBox;T;F')
              Selected.Strings = (
                'Date'#9'19'#9'Date'#9'F'#9
                'ContactName'#9'14'#9'Contact'#9'F'#9
                'Type'#9'6'#9'Type'#9'F'#9
                'Status'#9'9'#9'Status'#9'F'
                'Reference'#9'25'#9'Reference'#9'F'#9
                'MessageFrom'#9'15'#9'From'#9'F'#9
                'MessageTo'#9'15'#9'To'#9'F'#9
                'active'#9'1'#9'Active'#9'F'#9)
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              OnRowChanged = grdDocsRowChanged
              FixedCols = 0
              ShowHorzScrollBar = True
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clWhite
              DataSource = DSDocuments
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              OnDblClick = grdDocsDblClick
              FooterColor = clWhite
              FooterCellColor = clWhite
              object grdDocsIButton: TwwIButton
                Left = 0
                Top = 0
                Width = 18
                Height = 22
                HelpContext = 254389
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
                OnClick = grdDocsIButtonClick
              end
            end
            object btnGetEmails: TButton
              Left = 9
              Top = 4
              Width = 75
              Height = 25
              HelpContext = 254390
              Caption = 'Get Emails'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnClick = btnGetEmailsClick
            end
            object chkdocuments: TCheckBox
              Left = 114
              Top = 8
              Width = 183
              Height = 17
              HelpContext = 254464
              Caption = 'Show inactive Documents'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnClick = chkdocumentsClick
            end
          end
          object pnlDocumentsMessage: TDNMPanel
            Left = 0
            Top = 180
            Width = 848
            Height = 195
            HelpContext = 254391
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            DesignSize = (
              848
              195)
            object HtmlViewer: THtmlViewer
              Left = 7
              Top = 3
              Width = 833
              Height = 133
              HelpContext = 254392
              TabOrder = 0
              Anchors = [akLeft, akTop, akRight, akBottom]
              BorderStyle = htFocused
              CharSet = DEFAULT_CHARSET
              DefBackground = clWhite
              DefFontName = 'Arial'
              DefFontSize = 9
              DefPreFontName = 'Courier New'
              HistoryMaxCount = 0
              NoSelect = False
              PrintMarginBottom = 2.000000000000000000
              PrintMarginLeft = 2.000000000000000000
              PrintMarginRight = 2.000000000000000000
              PrintMarginTop = 2.000000000000000000
              PrintScale = 1.000000000000000000
              QuirksMode = qmDetect
              OnHotSpotClick = HtmlViewerHotSpotClick
              OnImageRequest = HtmlViewerImageRequest
            end
            object lvAttachments: TListView
              Left = 7
              Top = 142
              Width = 835
              Height = 49
              HelpContext = 254393
              Anchors = [akLeft, akRight, akBottom]
              Columns = <>
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ViewStyle = vsSmallIcon
              OnDblClick = lvAttachmentsDblClick
            end
          end
        end
      end
      object pnlDocsBottom: TDNMPanel
        Left = 0
        Top = 385
        Width = 864
        Height = 37
        HelpContext = 254533
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lblDocumentPath: TDBText
          Left = 222
          Top = 12
          Width = 615
          Height = 15
          HelpContext = 254534
          DataField = 'cDocumentPath'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object btnOpenDocumentPath: TDNMSpeedButton
          Left = 16
          Top = 6
          Width = 93
          Height = 27
          HelpContext = 254535
          Caption = 'Open Doc Path'
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
          TabOrder = 0
          AutoDisableParentOnclick = True
          OnClick = btnOpenDocumentPathClick
        end
        object btnSetDocumentPath: TDNMSpeedButton
          Left = 123
          Top = 6
          Width = 93
          Height = 27
          HelpContext = 254536
          Caption = 'Set Doc Path'
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
          OnClick = btnSetDocumentPathClick
        end
      end
    end
    object Custom_Fields: TTabSheet
      HelpContext = 254239
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
        HelpContext = 254240
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
      object pnlCustFieldsTab: TDNMPanel
        Left = 0
        Top = 0
        Width = 864
        Height = 422
        HelpContext = 254241
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Transparent = False
        object Label54: TLabel
          Left = 631
          Top = 215
          Width = 3
          Height = 15
          HelpContext = 254261
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label55: TLabel
          Left = 631
          Top = 247
          Width = 3
          Height = 15
          HelpContext = 254262
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object pgCustomFields: TPageControl
          Left = 0
          Top = 0
          Width = 864
          Height = 422
          HelpContext = 254394
          ActivePage = TabSheet2
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          TabWidth = 387
          object tabCustomFields: TTabSheet
            HelpContext = 254395
            Caption = 'Customisable List'
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object pnlcustomfieldList: TDNMPanel
              Left = 0
              Top = 0
              Width = 856
              Height = 392
              HelpContext = 254396
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              object DNMPanel12: TDNMPanel
                Left = 1
                Top = 1
                Width = 854
                Height = 34
                HelpContext = 254397
                Align = alTop
                Caption = 'Customisable List'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clMaroon
                Font.Height = -19
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object Memo1: TMemo
                Left = 1
                Top = 35
                Width = 854
                Height = 356
                HelpContext = 254398
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -24
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                Lines.Strings = (
                  'Steps to add Customisable list to any form'
                  '=============================================='
                  
                    '1: CustomFieldListFormExtender.ClassExtenderList.AddExtender    ' +
                    ' '
                  '2: TCustomFieldListFormExtender.InitForm       '
                  '3: Busobjcustomfields.ListType'
                  '4: Create table and busobj. eg : in Busobjcustomfields'
                  '5: create a new from TfmCustomFieldValue ONLY if there are new '
                  
                    'fields and OVERRIDE the INSTANCE procedure to create its instanc' +
                    'e. '
                  'Otehrwise the wrong form will be created'
                  '6: Override CustomFieldExtenderListtype in the input form using '
                  'custom fields'
                  '7: TfmCustomFieldValue.MakeCustomFieldForm : Add the new class'
                  '8: the name of the page control has to be '#39'TABCTL20'#39
                  '9: Name of the tabsheet has to be '#39'CUSTOM_FIELDS'#39
                  '10: Save button name : cmdOk'
                  '11:Newbutton name :cmdNew'
                  '12: TfmCustomfieldList.SetListType(const Value: TListType)'
                  '13: change enum field - tblcustomfieldlist.ListType to have new '
                  'listtype')
                ParentFont = False
                ScrollBars = ssVertical
                TabOrder = 1
                Visible = False
              end
            end
          end
          object TabSheet2: TTabSheet
            HelpContext = 254399
            Caption = 'Customisable Fields'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ImageIndex = 1
            ParentFont = False
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object pnlCustFldsFixed: TDNMPanel
              Left = 0
              Top = 0
              Width = 856
              Height = 392
              HelpContext = 254465
              Align = alClient
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Transparent = False
              object Bevel14: TBevel
                Left = 292
                Top = 25
                Width = 206
                Height = 32
                HelpContext = 254244
                Style = bsRaised
              end
              object Box181: TBevel
                Left = 0
                Top = 70
                Width = 776
                Height = 247
                HelpContext = 254242
              end
              object Label95: TLabel
                Left = 301
                Top = 29
                Width = 193
                Height = 26
                HelpContext = 254243
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
              object CUSTLBL1: TLabel
                Left = 99
                Top = 93
                Width = 17
                Height = 15
                HelpContext = 254245
                Alignment = taRightJustify
                Caption = 'cl1'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL2: TLabel
                Left = 99
                Top = 131
                Width = 17
                Height = 15
                HelpContext = 254246
                Alignment = taRightJustify
                Caption = 'cl2'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL3: TLabel
                Left = 99
                Top = 170
                Width = 17
                Height = 15
                HelpContext = 254247
                Alignment = taRightJustify
                Caption = 'cl3'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL4: TLabel
                Left = 99
                Top = 208
                Width = 17
                Height = 15
                HelpContext = 254248
                Alignment = taRightJustify
                Caption = 'cl4'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL5: TLabel
                Left = 99
                Top = 247
                Width = 17
                Height = 15
                HelpContext = 254249
                Alignment = taRightJustify
                Caption = 'cl5'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL6: TLabel
                Left = 99
                Top = 286
                Width = 17
                Height = 15
                HelpContext = 254250
                Alignment = taRightJustify
                Caption = 'cl6'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL7: TLabel
                Left = 358
                Top = 93
                Width = 17
                Height = 15
                HelpContext = 254251
                Alignment = taRightJustify
                Caption = 'cl7'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL8: TLabel
                Left = 358
                Top = 131
                Width = 17
                Height = 15
                HelpContext = 254252
                Alignment = taRightJustify
                Caption = 'cl8'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL9: TLabel
                Left = 358
                Top = 170
                Width = 17
                Height = 15
                HelpContext = 254253
                Alignment = taRightJustify
                Caption = 'cl9'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL10: TLabel
                Left = 351
                Top = 208
                Width = 24
                Height = 15
                HelpContext = 254254
                Alignment = taRightJustify
                Caption = 'cl10'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL11: TLabel
                Left = 351
                Top = 247
                Width = 23
                Height = 15
                HelpContext = 254255
                Alignment = taRightJustify
                Caption = 'cl11'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL12: TLabel
                Left = 350
                Top = 286
                Width = 24
                Height = 15
                HelpContext = 254256
                Alignment = taRightJustify
                Caption = 'cl12'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL13: TLabel
                Left = 610
                Top = 93
                Width = 24
                Height = 15
                HelpContext = 254257
                Alignment = taRightJustify
                Caption = 'cl13'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL14: TLabel
                Left = 610
                Top = 131
                Width = 24
                Height = 15
                HelpContext = 254258
                Alignment = taRightJustify
                Caption = 'cl14'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL15: TLabel
                Left = 610
                Top = 170
                Width = 24
                Height = 15
                HelpContext = 254259
                Alignment = taRightJustify
                Caption = 'cl15'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL16: TLabel
                Left = 610
                Top = 208
                Width = 24
                Height = 15
                HelpContext = 254260
                Alignment = taRightJustify
                Caption = 'cl16'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object Label93: TLabel
                Left = 631
                Top = 215
                Width = 3
                Height = 15
                HelpContext = 254466
                Alignment = taRightJustify
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object Label94: TLabel
                Left = 631
                Top = 247
                Width = 3
                Height = 15
                HelpContext = 254467
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
                Left = 610
                Top = 247
                Width = 24
                Height = 15
                HelpContext = 254263
                Alignment = taRightJustify
                Caption = 'cl17'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object CUSTLBL18: TLabel
                Left = 610
                Top = 286
                Width = 24
                Height = 15
                HelpContext = 254264
                Alignment = taRightJustify
                Caption = 'cl18'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
              end
              object cmdCustomLabelsOld: TDNMSpeedButton
                Left = 355
                Top = 328
                Width = 87
                Height = 27
                Hint = '"Add A New Customised Field For All Employee'#39's"'
                HelpContext = 254265
                Caption = '&Add Labels'
                DisableTransparent = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
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
                Left = 119
                Top = 89
                Width = 130
                Height = 23
                HelpContext = 254266
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD1'
                DataSource = frmCustomerSrc
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
                Left = 119
                Top = 127
                Width = 130
                Height = 23
                HelpContext = 254267
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD2'
                DataSource = frmCustomerSrc
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
                Left = 119
                Top = 166
                Width = 130
                Height = 23
                HelpContext = 254268
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD3'
                DataSource = frmCustomerSrc
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
                Left = 119
                Top = 204
                Width = 130
                Height = 23
                HelpContext = 254269
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD4'
                DataSource = frmCustomerSrc
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
                Left = 119
                Top = 243
                Width = 130
                Height = 23
                HelpContext = 254270
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD5'
                DataSource = frmCustomerSrc
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
                Top = 204
                Width = 130
                Height = 23
                HelpContext = 254271
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD10'
                DataSource = frmCustomerSrc
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
                Top = 166
                Width = 130
                Height = 23
                HelpContext = 254272
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD9'
                DataSource = frmCustomerSrc
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
                Top = 127
                Width = 130
                Height = 23
                HelpContext = 254273
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD8'
                DataSource = frmCustomerSrc
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
                Top = 89
                Width = 130
                Height = 23
                HelpContext = 254274
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD7'
                DataSource = frmCustomerSrc
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
                Left = 119
                Top = 282
                Width = 130
                Height = 23
                HelpContext = 254275
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD6'
                DataSource = frmCustomerSrc
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
                Top = 243
                Width = 130
                Height = 23
                HelpContext = 254276
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD11'
                DataSource = frmCustomerSrc
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
                Top = 282
                Width = 130
                Height = 23
                HelpContext = 254277
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD12'
                DataSource = frmCustomerSrc
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
                Left = 637
                Top = 89
                Width = 130
                Height = 23
                HelpContext = 254278
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD13'
                DataSource = frmCustomerSrc
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
                Left = 637
                Top = 127
                Width = 130
                Height = 23
                HelpContext = 254279
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD14'
                DataSource = frmCustomerSrc
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
                Left = 637
                Top = 166
                Width = 130
                Height = 23
                HelpContext = 254280
                ShowButton = True
                Style = csDropDown
                MapList = False
                AllowClearKey = False
                DataField = 'CUSTFLD15'
                DataSource = frmCustomerSrc
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
                Left = 637
                Top = 204
                Width = 130
                Height = 23
                HelpContext = 254281
                CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                CalendarAttributes.Font.Color = clWindowText
                CalendarAttributes.Font.Height = -11
                CalendarAttributes.Font.Name = 'MS Sans Serif'
                CalendarAttributes.Font.Style = []
                DataField = 'CUSTDATE1'
                DataSource = frmCustomerSrc
                Epoch = 1950
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ShowButton = True
                TabOrder = 15
                UnboundDataType = wwDTEdtDate
              end
              object CUSTFLD17: TwwDBDateTimePicker
                Left = 637
                Top = 243
                Width = 130
                Height = 23
                HelpContext = 254282
                CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                CalendarAttributes.Font.Color = clWindowText
                CalendarAttributes.Font.Height = -11
                CalendarAttributes.Font.Name = 'MS Sans Serif'
                CalendarAttributes.Font.Style = []
                DataField = 'CUSTDATE2'
                DataSource = frmCustomerSrc
                Epoch = 1950
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ShowButton = True
                TabOrder = 16
                UnboundDataType = wwDTEdtDate
              end
              object CUSTFLD18: TwwDBDateTimePicker
                Left = 637
                Top = 282
                Width = 130
                Height = 23
                HelpContext = 254283
                CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                CalendarAttributes.Font.Color = clWindowText
                CalendarAttributes.Font.Height = -11
                CalendarAttributes.Font.Name = 'MS Sans Serif'
                CalendarAttributes.Font.Style = []
                DataField = 'CUSTDATE3'
                DataSource = frmCustomerSrc
                Epoch = 1950
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                ShowButton = True
                TabOrder = 17
                UnboundDataType = wwDTEdtDate
              end
            end
          end
        end
      end
    end
    object tabAttachments: TTabSheet
      HelpContext = 254286
      Caption = 'Attachments'
      ImageIndex = 8
      object pnlAttach: TDNMPanel
        Left = 0
        Top = 0
        Width = 864
        Height = 422
        HelpContext = 254317
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          864
          422)
        object pnlAttachments: TPanel
          Left = 31
          Top = 13
          Width = 809
          Height = 347
          HelpContext = 254237
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 0
        end
      end
    end
    object SpecialProds: TTabSheet
      HelpContext = 254292
      Caption = 'Discounts'
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
      object DNMPanel5: TDNMPanel
        Left = 0
        Top = 0
        Width = 864
        Height = 246
        HelpContext = 254293
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          860
          242)
        object Label98: TLabel
          Left = 118
          Top = 11
          Width = 144
          Height = 18
          HelpContext = 254294
          AutoSize = False
          Caption = 'Permanent Discount (%):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label104: TLabel
          Left = 335
          Top = 11
          Width = 171
          Height = 18
          HelpContext = 254295
          AutoSize = False
          Caption = 'Special Product Discount (%):'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label57: TLabel
          Left = 3
          Top = 11
          Width = 108
          Height = 18
          HelpContext = 254233
          AutoSize = False
          Caption = 'Special Products'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object grdSpecials: TwwDBGrid
          Left = 1
          Top = 38
          Width = 858
          Height = 203
          HelpContext = 254296
          ControlType.Strings = (
            'ProductID;CustomEdit;cboProd;F'
            'Name;CustomEdit;cboProd;F'
            'IncludeInRun;CheckBox;T;F'
            'UOM;CustomEdit;cboUOM;F')
          Selected.Strings = (
            'Name'#9'16'#9'Name'#9'F'
            'Description'#9'34'#9'Description'#9'T'
            'OrigPrice'#9'12'#9'Original Price (ex)'#9'T'
            'LinePrice'#9'13'#9'Line Price (ex)'#9'F'
            'UOM'#9'17'#9'UOM'#9'F'
            'DateFrom'#9'9'#9'Date From'#9'F'
            'DateTo'#9'9'#9'Date To'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alBottom
          Color = clWhite
          DataSource = DSSpecials
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnDblClick = grdSpecialsDblClick
          OnExit = grdSpecialsExit
          OnFieldChanged = grdSpecialsFieldChanged
          FooterColor = clWhite
          FooterCellColor = clWhite
          object grdSpecialsIButton: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            HelpContext = 254349
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
            OnClick = grdSpecialsIButtonClick
          end
        end
        object cboProd: TERPDbLookupCombo
          Left = 376
          Top = 96
          Width = 121
          Height = 26
          HelpContext = 254358
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'PARTNAME'#9'15'#9'PARTNAME'#9'T'
            'PARTSDESCRIPTION'#9'30'#9'PARTSDESCRIPTION'#9'T')
          DataField = 'Name'
          DataSource = DSSpecials
          LookupTable = cboProductQry
          LookupField = 'Partname'
          TabOrder = 5
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnChange = cboProdChange
          OnCloseUp = cboProdCloseUp
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
        object btnNewProd: TDNMSpeedButton
          Left = 735
          Top = 5
          Width = 115
          Height = 27
          Hint = 'Use this button to add a new product line to the grid'
          HelpContext = 254297
          Anchors = [akRight, akBottom]
          Caption = 'Add Ne&w Product'
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
          TabOrder = 4
          AutoDisableParentOnclick = True
          OnClick = btnNewProdClick
        end
        object edtSpecDisc: TEdit
          Left = 505
          Top = 9
          Width = 65
          Height = 23
          HelpContext = 254298
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'edtSpecDisc'
          OnExit = edtSpecDiscExit
        end
        object edtDisc: TEdit
          Left = 261
          Top = 9
          Width = 65
          Height = 23
          HelpContext = 254299
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = 'edtDisc'
          OnExit = edtDiscExit
        end
        object btnCopySpecialPrices: TDNMSpeedButton
          Left = 657
          Top = 5
          Width = 73
          Height = 27
          Hint = '"Copy Special Prices"'
          HelpContext = 254468
          Anchors = [akRight, akBottom]
          Caption = 'Copy'
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
          OnClick = btnCopySpecialPricesClick
        end
        object cboUOM: TwwDBLookupCombo
          Left = 153
          Top = 63
          Width = 109
          Height = 26
          HelpContext = 254567
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Unitname'#9'15'#9'Unit Name'#9'F'
            'multiplier'#9'10'#9'Multiplier'#9'F')
          DataField = 'UOM'
          DataSource = DSSpecials
          LookupTable = QryUOM
          LookupField = 'Unitname'
          AutoSelect = False
          TabOrder = 6
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDropDown = cboUOMDropDown
          OnCloseUp = cboUOMCloseUp
        end
      end
      object DNMPanel10: TDNMPanel
        Left = 0
        Top = 246
        Width = 864
        Height = 176
        HelpContext = 254301
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Transparent = False
        DesignSize = (
          860
          172)
        object Label68: TLabel
          Left = 3
          Top = 4
          Width = 108
          Height = 18
          HelpContext = 254469
          AutoSize = False
          Caption = 'Group Discounts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label21: TLabel
          Left = 215
          Top = 2
          Width = 223
          Height = 15
          HelpContext = 254305
          Caption = 'Group Discount Overrides All Discounts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label24: TLabel
          Left = 484
          Top = 2
          Width = 259
          Height = 15
          HelpContext = 254470
          Caption = 'Special Product Price Overrides All Discounts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object grdProdGroupDiscs: TwwDBGrid
          Left = 10
          Top = 28
          Width = 858
          Height = 152
          HelpContext = 254303
          ControlType.Strings = (
            'Col1;CustomEdit;cboCol1;F'
            'Col2;CustomEdit;cboCol2;F'
            'Col3;CustomEdit;cboCol3;F'
            'MustMatch;CheckBox;T;F')
          Selected.Strings = (
            'Col1'#9'20'#9'Col1'#9'F'#9
            'Col2'#9'20'#9'Col2'#9'F'#9
            'Col3'#9'20'#9'Col3'#9'F'#9
            'Discount'#9'10'#9'% Discount'#9#9
            'MustMatch'#9'1'#9'Must Match All'#9'F'#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clWhite
          DataSource = dsProdGroupDiscs
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          OnExit = grdProdGroupDiscsExit
          OnFieldChanged = grdProdGroupDiscsFieldChanged
          FooterColor = clWhite
          FooterCellColor = clWhite
          object grdProdGroupDiscsIButton: TwwIButton
            Left = 0
            Top = 0
            Width = 23
            Height = 22
            HelpContext = 254359
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
            OnClick = grdProdGroupDiscsIButtonClick
          end
        end
        object cboCol1: TwwDBLookupCombo
          Left = 39
          Top = 56
          Width = 121
          Height = 23
          HelpContext = 254360
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'PartLevel'#9'20'#9'PartLevel'#9'F')
          DataField = 'Col1'
          DataSource = dsProdGroupDiscs
          LookupTable = qryProductGroupcol1
          LookupField = 'PartLevel'
          Style = csDropDownList
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object cboCol2: TwwDBLookupCombo
          Left = 39
          Top = 80
          Width = 121
          Height = 23
          HelpContext = 254361
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'PartLevel'#9'20'#9'PartLevel'#9'F')
          DataField = 'Col2'
          DataSource = dsProdGroupDiscs
          LookupTable = qryProductGroupcol2
          LookupField = 'PartLevel'
          Style = csDropDownList
          TabOrder = 4
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object cboCol3: TwwDBLookupCombo
          Left = 39
          Top = 105
          Width = 121
          Height = 23
          HelpContext = 254362
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'PartLevel'#9'20'#9'PartLevel'#9'F')
          DataField = 'Col3'
          DataSource = dsProdGroupDiscs
          LookupTable = qryProductGroupcol3
          LookupField = 'PartLevel'
          Style = csDropDownList
          TabOrder = 5
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object chkgroupdiscount: TwwCheckBox
          Left = 457
          Top = 1
          Width = 15
          Height = 16
          HelpContext = 254306
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
          Caption = 'chkgroupdiscount'
          DataField = 'GroupDiscountOverridesAll'
          DataSource = frmCustomerSrc
          TabOrder = 0
        end
        object chksplPrductdiscount: TwwCheckBox
          Left = 748
          Top = 1
          Width = 15
          Height = 16
          HelpContext = 254471
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
          Caption = 'wwCheckBox1'
          DataField = 'SpecialProductPriceOverridesAll'
          DataSource = frmCustomerSrc
          TabOrder = 1
        end
      end
    end
    object tabEquip: TTabSheet
      HelpContext = 254300
      Caption = '&Equipment'
      ImageIndex = 11
      object CustEquipDNMPanel: TDNMPanel
        Left = 0
        Top = 0
        Width = 864
        Height = 422
        HelpContext = 254363
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Transparent = False
      end
    end
    object tabReferrals: TTabSheet
      HelpContext = 254316
      Caption = 'Miscellaneous'
      ImageIndex = 14
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object MiscPageControl: TPageControl
        Left = 0
        Top = 0
        Width = 864
        Height = 422
        HelpContext = 254400
        ActivePage = tabFollowUp
        Align = alClient
        TabOrder = 0
        OnChange = MiscPageControlChange
        OnChanging = MiscPageControlChanging
        object tabFollowUp: TTabSheet
          HelpContext = 254401
          Caption = '&Follow-Up'
          object DNMPanel11: TDNMPanel
            Left = 0
            Top = 0
            Width = 856
            Height = 392
            HelpContext = 254287
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            object DNMPanel17: TDNMPanel
              Left = 0
              Top = 0
              Width = 856
              Height = 392
              HelpContext = 254288
              Align = alClient
              BevelOuter = bvNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              Transparent = False
              DesignSize = (
                856
                392)
              object Label3: TLabel
                Left = 24
                Top = 19
                Width = 87
                Height = 16
                HelpContext = 254553
                AutoSize = False
                Caption = 'Follow Ups for'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                WordWrap = True
              end
              object grdFollowUp: TwwDBGrid
                Left = 0
                Top = 46
                Width = 856
                Height = 346
                HelpContext = 254289
                ControlType.Strings = (
                  'FollowUpDate;CustomEdit;dtpDatePicker;T'
                  'EmployeeID;CustomEdit;cboEmployee;T'
                  'Done;CheckBox;T;F'
                  'EmployeeName;CustomEdit;cboEmployee;T'
                  'ContactName;CustomEdit;cboContactName;T')
                Selected.Strings = (
                  'FollowUpDate'#9'12'#9'Follow Up Date'#9#9
                  'ContactName'#9'20'#9'Contact Name'#9'F'#9
                  'Notes'#9'55'#9'Notes'#9'F'#9
                  'EmployeeName'#9'20'#9'Employee'#9'F'#9
                  'Done'#9'4'#9'Done'#9#9)
                MemoAttributes = [mSizeable, mWordWrap, mGridShow, mDisableDialog]
                IniAttributes.Delimiter = ';;'
                TitleColor = clWhite
                OnRowChanged = grdFollowUpRowChanged
                FixedCols = 0
                ShowHorzScrollBar = True
                EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
                Align = alBottom
                Color = clWhite
                DataSource = dsOtherFollowUp
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                TitleAlignment = taLeftJustify
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = 'Arial'
                TitleFont.Style = [fsBold]
                TitleLines = 1
                TitleButtons = False
                OnColEnter = grdFollowUpColEnter
                OnColExit = grdFollowUpColExit
                OnDblClick = grdFollowUpDblClick
                OnEnter = grdFollowUpEnter
                OnFieldChanged = grdFollowUpFieldChanged
                FooterColor = clWhite
                FooterCellColor = clWhite
                object btnInactiveFollowUp: TwwIButton
                  Left = 0
                  Top = 0
                  Width = 23
                  Height = 22
                  HelpContext = 254355
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
                  OnClick = btnInactiveFollowUpClick
                end
              end
              object cboEmployee: TwwDBLookupCombo
                Left = 408
                Top = 46
                Width = 165
                Height = 23
                HelpContext = 254356
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'EmployeeName'#9'47'#9'EmployeeName'#9#9)
                DataField = 'EmployeeName'
                DataSource = dsOtherFollowUp
                LookupTable = qryEmployees
                LookupField = 'EmployeeID'
                DropDownWidth = 25
                TabOrder = 3
                AutoDropDown = True
                ShowButton = True
                PreciseEditRegion = False
                AllowClearKey = False
              end
              object dtpDatePicker: TwwDBDateTimePicker
                Left = 24
                Top = 80
                Width = 88
                Height = 23
                HelpContext = 254357
                CalendarAttributes.Font.Charset = DEFAULT_CHARSET
                CalendarAttributes.Font.Color = clWindowText
                CalendarAttributes.Font.Height = -11
                CalendarAttributes.Font.Name = 'MS Sans Serif'
                CalendarAttributes.Font.Style = []
                DataField = 'FollowUpDate'
                DataSource = dsOtherFollowUp
                Epoch = 1950
                ShowButton = True
                TabOrder = 4
              end
              object btnRepeat: TDNMSpeedButton
                Left = 310
                Top = 440
                Width = 87
                Height = 27
                Hint = '"Repeat Customer Followup"'
                HelpContext = 254290
                Anchors = [akBottom]
                Caption = '&Repeat'
                DisableTransparent = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
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
                TabOrder = 1
                AutoDisableParentOnclick = True
                OnClick = btnRepeatClick
              end
              object btnServiceCycle: TDNMSpeedButton
                Left = 469
                Top = 440
                Width = 87
                Height = 27
                Hint = '"Service Cycle Followup"'
                HelpContext = 254291
                Anchors = [akBottom]
                Caption = 'Service C&ycle'
                DisableTransparent = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
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
                TabOrder = 2
                AutoDisableParentOnclick = True
                OnClick = btnServiceCycleClick
              end
              object btnAddfollowupnotedate: TDNMSpeedButton
                Left = 773
                Top = 0
                Width = 75
                Height = 18
                HelpContext = 254402
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
                TabOrder = 5
                AutoDisableParentOnclick = True
                OnClick = btnAddfollowupnotedateClick
              end
              object cboContactName: TwwDBLookupCombo
                Left = 118
                Top = 95
                Width = 144
                Height = 23
                HelpContext = 254554
                DropDownAlignment = taLeftJustify
                Selected.Strings = (
                  'ContactName'#9'47'#9'ContactName'#9#9)
                DataField = 'ContactName'
                DataSource = dsOtherFollowUp
                LookupTable = qryContactNames
                LookupField = 'ContactId'
                DropDownWidth = 25
                TabOrder = 6
                AutoDropDown = True
                ShowButton = True
                PreciseEditRegion = False
                AllowClearKey = False
              end
              object cboContactSelector: TComboBoxEx
                Left = 117
                Top = 16
                Width = 145
                Height = 24
                HelpContext = 254555
                AutoCompleteOptions = [acoAutoSuggest, acoSearch]
                ItemsEx = <>
                Style = csExDropDownList
                TabOrder = 7
                OnChange = cboContactSelectorChange
                OnSelect = cboContactSelectorSelect
              end
            end
          end
        end
        object TabSheet3: TTabSheet
          HelpContext = 254403
          Caption = 'Referrals'
          ImageIndex = 1
          object DNMPanel8: TDNMPanel
            Left = 0
            Top = 0
            Width = 856
            Height = 392
            HelpContext = 254472
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            Transparent = False
            object Bevel27: TBevel
              Left = 2
              Top = 10
              Width = 839
              Height = 373
              HelpContext = 254318
            end
            object lblReferralsWarning: TLabel
              Left = 711
              Top = 132
              Width = 87
              Height = 60
              HelpContext = 254322
              Caption = 'Please Save New Customer before Adding Referrals'
              Color = clBtnFace
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              Transparent = True
              Visible = False
              WordWrap = True
            end
            object Label46: TLabel
              Left = 21
              Top = 356
              Width = 53
              Height = 15
              HelpContext = 254323
              Caption = 'Select All'
              Transparent = True
            end
            object Label47: TLabel
              Left = 149
              Top = 355
              Width = 337
              Height = 17
              HelpContext = 254324
              AutoSize = False
              Caption = 'To Select individual Referrals hold down CTRL Key and Click'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsItalic]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object grdReferrals: TwwDBGrid
              Left = 21
              Top = 21
              Width = 682
              Height = 313
              HelpContext = 254325
              ControlType.Strings = (
                'CompanyLookup;CustomEdit;cboClients;F')
              Selected.Strings = (
                'CompanyLookup'#9'22'#9'Name'#9'F'
                'Customertype'#9'20'#9'Customer Type'#9'T'
                'PhoneLookup'#9'17'#9'Phone'#9'F'
                'FaxLookup'#9'17'#9'Fax'#9'F')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Color = clWhite
              DataSource = dsReferrals
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              MultiSelectOptions = [msoShiftSelect]
              Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
              ParentFont = False
              ReadOnly = True
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
              OnDblClick = EditbtnClick
              OnExit = grdReferralsExit
              OnFieldChanged = grdReferralsFieldChanged
              object btnDeleteReferral: TwwIButton
                Left = 0
                Top = 0
                Width = 24
                Height = 22
                Hint = 'Click this button to Deactivate the selected contact'
                HelpContext = 254364
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
                OnClick = btnDeleteReferralClick
              end
            end
            object cboClients: TwwDBLookupCombo
              Left = 80
              Top = 124
              Width = 121
              Height = 23
              HelpContext = 254365
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Company'#9'40'#9'Company'#9'F'#9)
              DataField = 'CompanyLookup'
              DataSource = dsReferrals
              LookupTable = qryClients
              LookupField = 'ClientID'
              TabOrder = 2
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnExit = cboClientsExit
            end
            object btnLetters: TDNMSpeedButton
              Left = 711
              Top = 82
              Width = 87
              Height = 27
              HelpContext = 254368
              Action = actReferralsPrint
              Caption = 'Letters'
              DisableTransparent = False
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -12
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              TabOrder = 1
              AutoDisableParentOnclick = True
            end
            object chkSelectAll: TCheckBox
              Left = 80
              Top = 355
              Width = 17
              Height = 17
              HelpContext = 254366
              TabOrder = 3
            end
          end
        end
        object tabAusEParcel: TTabSheet
          HelpContext = 254404
          Caption = 'eParcel'
          ImageIndex = 2
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object DNMPanel14: TDNMPanel
            Left = 0
            Top = 0
            Width = 856
            Height = 392
            HelpContext = 254405
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              856
              392)
            object Shape9: TShape
              Left = 618
              Top = 311
              Width = 226
              Height = 33
              HelpContext = 254406
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape8: TShape
              Left = 618
              Top = 291
              Width = 226
              Height = 21
              HelpContext = 254407
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape7: TShape
              Left = 618
              Top = 271
              Width = 226
              Height = 21
              HelpContext = 254408
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape6: TShape
              Left = 618
              Top = 223
              Width = 226
              Height = 49
              HelpContext = 254409
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape5: TShape
              Left = 618
              Top = 143
              Width = 226
              Height = 81
              HelpContext = 254410
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape2: TShape
              Left = 618
              Top = 76
              Width = 226
              Height = 68
              HelpContext = 254411
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape3: TShape
              Left = 81
              Top = 37
              Width = 260
              Height = 349
              HelpContext = 254412
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Shape1: TShape
              Left = 618
              Top = 9
              Width = 226
              Height = 68
              HelpContext = 254413
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Label37: TLabel
              Left = 17
              Top = 46
              Width = 61
              Height = 18
              HelpContext = 254473
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Company'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label41: TLabel
              Left = 8
              Top = 79
              Width = 69
              Height = 18
              HelpContext = 254474
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Name'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label64: TLabel
              Left = 11
              Top = 112
              Width = 66
              Height = 18
              HelpContext = 254475
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
            object Label97: TLabel
              Left = 11
              Top = 145
              Width = 66
              Height = 18
              HelpContext = 254476
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
            object Label99: TLabel
              Left = 11
              Top = 179
              Width = 66
              Height = 18
              HelpContext = 254477
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
            object Label100: TLabel
              Left = 11
              Top = 212
              Width = 66
              Height = 18
              HelpContext = 254478
              Alignment = taRightJustify
              AutoSize = False
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
            object Label101: TLabel
              Left = 11
              Top = 245
              Width = 66
              Height = 18
              HelpContext = 254479
              Alignment = taRightJustify
              AutoSize = False
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
            object Label102: TLabel
              Left = 11
              Top = 278
              Width = 66
              Height = 18
              HelpContext = 254480
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
            object Label103: TLabel
              Left = 11
              Top = 312
              Width = 66
              Height = 18
              HelpContext = 254481
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
            object Label105: TLabel
              Left = 82
              Top = 22
              Width = 89
              Height = 15
              HelpContext = 254482
              Caption = 'Return Address'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label106: TLabel
              Left = 352
              Top = 22
              Width = 99
              Height = 15
              HelpContext = 254483
              Caption = 'Redirect Address'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label107: TLabel
              Left = 623
              Top = 12
              Width = 69
              Height = 15
              HelpContext = 254484
              Alignment = taRightJustify
              Caption = 'Reference 1'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label109: TLabel
              Left = 623
              Top = 57
              Width = 88
              Height = 15
              HelpContext = 254485
              Alignment = taRightJustify
              Caption = 'Print on Label? '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Shape4: TShape
              Left = 352
              Top = 37
              Width = 260
              Height = 307
              HelpContext = 254414
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object Label108: TLabel
              Left = 623
              Top = 79
              Width = 69
              Height = 15
              HelpContext = 254486
              Alignment = taRightJustify
              Caption = 'Reference 2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label110: TLabel
              Left = 623
              Top = 123
              Width = 88
              Height = 15
              HelpContext = 254487
              Alignment = taRightJustify
              Caption = 'Print on Label? '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label111: TLabel
              Left = 645
              Top = 274
              Width = 175
              Height = 15
              HelpContext = 254488
              Alignment = taRightJustify
              Caption = 'Print Phone Number on Label ?'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label112: TLabel
              Left = 618
              Top = 312
              Width = 202
              Height = 30
              HelpContext = 254489
              Alignment = taRightJustify
              Caption = 
                'If the Premises unattended, leave in a secure location out of we' +
                'ather ?'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label113: TLabel
              Left = 701
              Top = 294
              Width = 119
              Height = 15
              HelpContext = 254490
              Alignment = taRightJustify
              Caption = 'Signature Required ?'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label114: TLabel
              Left = 623
              Top = 146
              Width = 149
              Height = 15
              HelpContext = 254491
              Alignment = taRightJustify
              Caption = 'Extra Delivery Instructions'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object lblAccount: TLabel
              Left = 623
              Top = 228
              Width = 119
              Height = 15
              HelpContext = 254415
              Caption = 'Chargeback Account'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label115: TLabel
              Left = 357
              Top = 361
              Width = 94
              Height = 15
              HelpContext = 254492
              Alignment = taRightJustify
              Caption = 'Email Notiication'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Shape10: TShape
              Left = 456
              Top = 351
              Width = 388
              Height = 35
              HelpContext = 254416
              Brush.Style = bsClear
              Pen.Color = clGray
            end
            object DBEdit1: TDBEdit
              Left = 85
              Top = 44
              Width = 245
              Height = 23
              HelpContext = 254493
              DataField = 'Return_Company'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object DBEdit2: TDBEdit
              Left = 85
              Top = 77
              Width = 245
              Height = 23
              HelpContext = 254494
              DataField = 'Return_Name'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnExit = FirstNameExit
            end
            object DBEdit3: TDBEdit
              Left = 85
              Top = 110
              Width = 245
              Height = 23
              HelpContext = 254495
              DataField = 'Return_Street1'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object DBEdit4: TDBEdit
              Left = 85
              Top = 143
              Width = 245
              Height = 23
              HelpContext = 254496
              DataField = 'Return_Street2'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object DBEdit5: TDBEdit
              Left = 85
              Top = 177
              Width = 245
              Height = 23
              HelpContext = 254497
              DataField = 'Return_Street3'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object wwDBLookupCombo2: TwwDBLookupCombo
              Left = 85
              Top = 210
              Width = 245
              Height = 23
              HelpContext = 254498
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'City_sub'#9'20'#9'Suburb'#9'T'
                'State'#9'20'#9'State'#9'T'
                'Postcode'#9'10'#9'Postcode'#9'T'
                'Code'#9'10'#9'Code'#9'T')
              DataField = 'Return_Suburb'
              DataSource = dsclients_eParcel
              LookupTable = qrySuburb
              LookupField = 'City_sub'
              ParentFont = False
              TabOrder = 5
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnChange = SuburbChange
              OnCloseUp = wwDBLookupCombo2CloseUp
              OnEnter = SuburbOnEnter
            end
            object DBEdit6: TDBEdit
              Left = 85
              Top = 243
              Width = 89
              Height = 23
              HelpContext = 254499
              DataField = 'Return_State'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object DBEdit7: TDBEdit
              Left = 85
              Top = 276
              Width = 89
              Height = 23
              HelpContext = 254500
              DataField = 'Return_Postcode'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object DBEdit8: TDBEdit
              Left = 85
              Top = 310
              Width = 245
              Height = 23
              HelpContext = 254501
              DataField = 'Return_Country'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object DBEdit9: TDBEdit
              Left = 357
              Top = 44
              Width = 250
              Height = 23
              HelpContext = 254502
              DataField = 'ReDir_Company'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
            end
            object DBEdit10: TDBEdit
              Left = 357
              Top = 77
              Width = 250
              Height = 23
              HelpContext = 254503
              DataField = 'ReDir_Name'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 10
              OnExit = FirstNameExit
            end
            object DBEdit11: TDBEdit
              Left = 357
              Top = 110
              Width = 250
              Height = 23
              HelpContext = 254504
              DataField = 'ReDir_Street1'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 11
            end
            object DBEdit12: TDBEdit
              Left = 357
              Top = 143
              Width = 250
              Height = 23
              HelpContext = 254505
              DataField = 'ReDir_Street2'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 12
            end
            object DBEdit13: TDBEdit
              Left = 357
              Top = 177
              Width = 250
              Height = 23
              HelpContext = 254506
              DataField = 'ReDir_Street3'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 13
            end
            object wwDBLookupCombo3: TwwDBLookupCombo
              Left = 357
              Top = 210
              Width = 250
              Height = 23
              HelpContext = 254507
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'City_sub'#9'20'#9'Suburb'#9'T'
                'State'#9'20'#9'State'#9'T'
                'Postcode'#9'10'#9'Postcode'#9'T'
                'Code'#9'10'#9'Code'#9'T')
              DataField = 'ReDir_Suburb'
              DataSource = dsclients_eParcel
              LookupTable = qrySuburb
              LookupField = 'City_sub'
              ParentFont = False
              TabOrder = 14
              AutoDropDown = True
              ShowButton = True
              UseTFields = False
              PreciseEditRegion = False
              AllowClearKey = False
              OnChange = SuburbChange
              OnCloseUp = wwDBLookupCombo3CloseUp
              OnEnter = SuburbOnEnter
            end
            object DBEdit14: TDBEdit
              Left = 357
              Top = 243
              Width = 89
              Height = 23
              HelpContext = 254508
              DataField = 'ReDir_State'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 15
            end
            object DBEdit15: TDBEdit
              Left = 357
              Top = 276
              Width = 89
              Height = 23
              HelpContext = 254509
              DataField = 'ReDir_Postcode'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 16
            end
            object DBEdit16: TDBEdit
              Left = 357
              Top = 310
              Width = 250
              Height = 23
              HelpContext = 254510
              DataField = 'ReDir_Country'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 17
            end
            object DBEdit17: TDBEdit
              Left = 623
              Top = 29
              Width = 217
              Height = 23
              HelpContext = 254511
              DataField = 'eParcelreference1'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 18
            end
            object wwCheckBox4: TwwCheckBox
              Left = 720
              Top = 53
              Width = 15
              Height = 19
              HelpContext = 254512
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
              Caption = 'ChkStopCredit'
              DataField = 'PrinteParcelreference1'
              DataSource = dsclients_eParcel
              TabOrder = 19
            end
            object btnCopyReturnAddress: TDNMSpeedButton
              Left = 87
              Top = 345
              Width = 245
              Height = 27
              HelpContext = 254417
              Anchors = [akBottom]
              Caption = 'Copy Address From Company Info'
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
              NumGlyphs = 2
              ParentFont = False
              TabOrder = 20
              AutoDisableParentOnclick = True
              OnClick = btnCopyReturnAddressClick
            end
            object DBEdit18: TDBEdit
              Left = 623
              Top = 98
              Width = 217
              Height = 23
              HelpContext = 254513
              DataField = 'eParcelreference2'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 21
            end
            object wwCheckBox5: TwwCheckBox
              Left = 723
              Top = 122
              Width = 15
              Height = 19
              HelpContext = 254514
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
              Caption = 'ChkStopCredit'
              DataField = 'PrinteParcelreference2'
              DataSource = dsclients_eParcel
              TabOrder = 22
            end
            object wwCheckBox6: TwwCheckBox
              Left = 826
              Top = 272
              Width = 15
              Height = 19
              HelpContext = 254515
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
              DataField = 'consigneePhoneonLabel'
              DataSource = dsclients_eParcel
              TabOrder = 23
            end
            object wwCheckBox7: TwwCheckBox
              Left = 826
              Top = 318
              Width = 15
              Height = 19
              HelpContext = 254516
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
              DataField = 'LeaveAtAddress'
              DataSource = dsclients_eParcel
              TabOrder = 24
            end
            object wwCheckBox8: TwwCheckBox
              Left = 826
              Top = 292
              Width = 15
              Height = 19
              HelpContext = 254517
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
              DataField = 'consigneePhoneonLabel'
              DataSource = dsclients_eParcel
              TabOrder = 25
            end
            object txtExtraDeliveryInstructions: TDBMemo
              Left = 623
              Top = 167
              Width = 217
              Height = 50
              HelpContext = 254418
              Anchors = [akLeft, akBottom]
              DataField = 'ExtraDeliveryInstructions'
              DataSource = dsclients_eParcel
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ScrollBars = ssVertical
              ShowHint = True
              TabOrder = 26
            end
            object cboAccount: TwwDBLookupCombo
              Left = 623
              Top = 243
              Width = 217
              Height = 23
              HelpContext = 254419
              AutoSize = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'AccountName'#9'50'#9'AccountName'#9'F')
              DataField = 'ChargeBackAcnt'
              DataSource = dsclients_eParcel
              LookupTable = cboAccountQry
              LookupField = 'AccountName'
              ParentFont = False
              TabOrder = 27
              AutoDropDown = True
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboAccountCloseUp
            end
            object wwRadioGroup1: TwwRadioGroup
              Left = 457
              Top = 352
              Width = 383
              Height = 31
              HelpContext = 254420
              DisableThemes = False
              Columns = 3
              DataField = 'EmailNotification'
              DataSource = dsclients_eParcel
              Items.Strings = (
                'NONE'
                'DESPATCH'
                'TRACK ADV')
              TabOrder = 28
              Values.Strings = (
                'NONE'
                'DESPATCH'
                'TRACKADV')
            end
          end
        end
      end
    end
  end
  object pnlButtons: TDNMPanel [10]
    Left = 876
    Top = 81
    Width = 120
    Height = 478
    HelpContext = 254332
    Align = alRight
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object cmdOk: TDNMSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 0
      Width = 114
      Height = 27
      HelpContext = 254338
      Margins.Top = 0
      Margins.Bottom = 2
      Align = alTop
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
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = cmdOkClick
    end
    object cmdCancel: TDNMSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 31
      Width = 114
      Height = 27
      HelpContext = 254339
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alTop
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
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
    object cmdNew: TDNMSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 62
      Width = 114
      Height = 27
      Hint = '"Add A New Customer"'
      HelpContext = 254340
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = '&New'
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = cmdNewClick
    end
    object cmdShipping: TDNMSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 93
      Width = 114
      Height = 27
      Hint = '"Add Shipping Addresses For This Customer"'
      HelpContext = 254341
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Shippin&g'
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
      OnClick = cmdShippingClick
    end
    object cmdNotes: TDNMSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 124
      Width = 114
      Height = 27
      Hint = '"Go To The Notes Field"'
      HelpContext = 254518
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'N&otes'
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
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = cmdNotesClick
    end
    object cmdPrint: TDNMSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 155
      Width = 114
      Height = 27
      Hint = '"Print This Customer"'
      HelpContext = 254343
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Prin&t'
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
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = cmdPrintClick
    end
    object DNMSpeedButton2: TDNMSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 186
      Width = 114
      Height = 27
      HelpContext = 254519
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Address Labels'
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
      TabOrder = 6
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton2Click
    end
    object pnlDontContact: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 224
      Width = 114
      Height = 41
      HelpContext = 254568
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      BevelKind = bkFlat
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object chkDontContact: TDBCheckBox
        AlignWithMargins = True
        Left = 11
        Top = 2
        Width = 88
        Height = 33
        HelpContext = 254345
        Margins.Left = 11
        Margins.Top = 2
        Margins.Right = 11
        Margins.Bottom = 2
        Align = alClient
        Alignment = taLeftJustify
        Caption = 'Don'#39't Contact'
        DataField = 'DontContact'
        DataSource = frmCustomerSrc
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
      end
    end
    object pnlActive: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 267
      Width = 114
      Height = 41
      HelpContext = 254569
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      BevelKind = bkFlat
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object chkActive: TDBCheckBox
        AlignWithMargins = True
        Left = 22
        Top = 2
        Width = 77
        Height = 33
        HelpContext = 254346
        Margins.Left = 22
        Margins.Top = 2
        Margins.Right = 11
        Margins.Bottom = 2
        Align = alClient
        Alignment = taLeftJustify
        Caption = 'Customer is Active'
        DataField = 'Active'
        DataSource = frmCustomerSrc
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
        OnClick = chkActiveClick
      end
    end
    object DNMPanel6: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 366
      Width = 114
      Height = 54
      HelpContext = 254570
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      BevelKind = bkFlat
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object Label4: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 2
        Width = 104
        Height = 18
        HelpContext = 254335
        Margins.Top = 2
        Margins.Bottom = 2
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Convert To'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitTop = 4
      end
      object btnSupplier: TDNMSpeedButton
        AlignWithMargins = True
        Left = 7
        Top = 22
        Width = 96
        Height = 26
        Hint = 'Make this Customer a Supplier'
        HelpContext = 254367
        Margins.Left = 7
        Margins.Top = 0
        Margins.Right = 7
        Margins.Bottom = 2
        Align = alClient
        Caption = 'Supplier'
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
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = btnSupplierClick
      end
    end
    object DNMPanel7: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 423
      Width = 114
      Height = 53
      HelpContext = 254571
      Margins.Top = 2
      Margins.Bottom = 2
      Align = alBottom
      BevelKind = bkFlat
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      object chkIntrastat: TDBCheckBox
        AlignWithMargins = True
        Left = 3
        Top = 1
        Width = 104
        Height = 47
        HelpContext = 254347
        Margins.Top = 1
        Margins.Bottom = 1
        Align = alClient
        Alignment = taLeftJustify
        Caption = 'Include on Intrastat Report'
        DataField = 'IncludeOnIntrastat'
        DataSource = frmCustomerSrc
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        WordWrap = True
        OnClick = chkActiveClick
      end
    end
    object DNMPanel1: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 310
      Width = 114
      Height = 54
      HelpContext = 254572
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alBottom
      BevelKind = bkFlat
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      object Label40: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 2
        Width = 104
        Height = 18
        HelpContext = 254573
        Margins.Top = 2
        Margins.Bottom = 2
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Convert To'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitTop = 4
      end
      object btnMarketingContact: TDNMSpeedButton
        AlignWithMargins = True
        Left = 7
        Top = 22
        Width = 96
        Height = 26
        Hint = 'Make this Customer a Marketing Contact'
        HelpContext = 254574
        Margins.Left = 7
        Margins.Top = 0
        Margins.Right = 7
        Margins.Bottom = 2
        Align = alClient
        Caption = 'Marketing Cont'
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
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = btnMarketingContactClick
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 656
  end
  inherited tmrdelay: TTimer
    Left = 697
  end
  object frmCustomerSrc: TDataSource [13]
    DataSet = qryCustomers
    OnStateChange = dsStateChange
    Left = 741
    Top = 33
  end
  object qryCustomers: TERPQuery [14]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM tblclients'
      'WHERE Customer='#39'T'#39' AND ClientID = :CusID;')
    AfterOpen = qryCustomersAfterOpen
    AfterInsert = qryCustomersAfterInsert
    BeforePost = qryCustomersBeforePost
    AfterPost = qryCustomersAfterPost
    OnCalcFields = qryCustomersCalcFields
    Left = 752
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object qryCustomersPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
      EditMask = '## #### ####;0;_'
    end
    object qryCustomersFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
      EditMask = '## #### ####;0;_'
    end
    object qryCustomersMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblclients.Mobile'
      EditMask = '#### ### ###;0;_'
    end
    object qryCustomersAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
      EditMask = '## #### ####;0;_'
    end
    object qryCustomersContact1Phone: TWideStringField
      FieldName = 'Contact1Phone'
      Origin = 'tblclients.Contact1Phone'
      EditMask = '## #### ####;0;_'
    end
    object qryCustomersContact2Phone: TWideStringField
      FieldName = 'Contact2Phone'
      Origin = 'tblclients.Contact2Phone'
      EditMask = '## #### ####;0;_'
    end
    object qryCustomersClientID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
      ReadOnly = True
    end
    object qryCustomersCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object qryCustomersABN: TWideStringField
      FieldName = 'ABN'
      Origin = 'tblclients.ABN'
      EditMask = '## ### ### ###;0;_'
      Size = 15
    end
    object qryCustomersFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'tblclients.FirstName'
      OnChange = qryCustomersFirstNameChange
      Size = 40
    end
    object qryCustomersMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Origin = 'tblclients.MiddleName'
      Size = 40
    end
    object qryCustomersLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblclients.LastName'
      OnChange = qryCustomersLastNameChange
      Size = 40
    end
    object qryCustomersPosition: TWideStringField
      FieldName = 'Position'
      Origin = 'tblclients.Position'
      Size = 30
    end
    object qryCustomersEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'tblclients.Email'
      Size = 80
    end
    object qryCustomersAltContact: TWideStringField
      FieldName = 'AltContact'
      Origin = 'tblclients.AltContact'
      Size = 50
    end
    object qryCustomersContact1: TWideStringField
      FieldName = 'Contact1'
      Origin = 'tblclients.Contact1'
      Size = 50
    end
    object qryCustomersPhoneSupportTill: TDateField
      FieldName = 'PhoneSupportTill'
      Origin = 'tblclients.PhoneSupportTill'
    end
    object qryCustomersContact2: TWideStringField
      FieldName = 'Contact2'
      Origin = 'tblclients.Contact2'
      Size = 50
    end
    object qryCustomersNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblclients.Notes'
      BlobType = ftWideMemo
    end
    object qryCustomersMedTypeID: TIntegerField
      FieldName = 'MedTypeID'
      Origin = 'tblclients.MedTypeID'
    end
    object qryCustomersTYPE: TWideStringField
      FieldName = 'TYPE'
      Origin = 'tblclients.TYPE'
      Size = 50
    end
    object qryCustomersCreditLimit: TFloatField
      FieldName = 'CreditLimit'
      Origin = 'tblclients.CreditLimit'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object qryCustomersBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'tblclients.Balance'
      currency = True
    end
    object qryCustomersTERMS: TWideStringField
      FieldName = 'TERMS'
      Origin = 'tblclients.TERMS'
      Size = 30
    end
    object qryCustomersTermsID: TIntegerField
      FieldName = 'TermsID'
      Origin = 'tblclients.TermsID'
      OnChange = qryCustomersTermsIDChange
    end
    object qryCustomersShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Origin = 'tblclients.ShippingMethod'
      Size = 30
    end
    object qryCustomersShippingID: TIntegerField
      FieldName = 'ShippingID'
      Origin = 'tblclients.ShippingID'
      OnChange = qryCustomersShippingIDChange
    end
    object qryCustomersDiscount: TFloatField
      FieldName = 'Discount'
      Origin = 'tblclients.Discount'
      DisplayFormat = '#.#%'
    end
    object qryCustomersSpecialDiscount: TFloatField
      FieldName = 'SpecialDiscount'
      Origin = 'tblclients.SpecialDiscount'
    end
    object qryCustomersJobName: TWideStringField
      FieldName = 'JobName'
      Origin = 'tblclients.JobName'
      Size = 39
    end
    object qryCustomersIsJob: TWideStringField
      FieldName = 'IsJob'
      Origin = 'tblclients.IsJob'
      FixedChar = True
      Size = 1
    end
    object qryCustomersPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
      Origin = 'tblclients.PayMethodID'
    end
    object qryCustomersFeedback: TWideStringField
      FieldName = 'Feedback'
      Origin = 'tblclients.Feedback'
      FixedChar = True
      Size = 1
    end
    object qryCustomersCustomer: TWideStringField
      FieldName = 'Customer'
      Origin = 'tblclients.Customer'
      FixedChar = True
      Size = 1
    end
    object qryCustomersSupplier: TWideStringField
      FieldName = 'Supplier'
      Origin = 'tblclients.Supplier'
      FixedChar = True
      Size = 1
    end
    object qryCustomersOtherContact: TWideStringField
      FieldName = 'OtherContact'
      Origin = 'tblclients.OtherContact'
      FixedChar = True
      Size = 1
    end
    object qryCustomersOtherContactType: TIntegerField
      FieldName = 'OtherContactType'
      Origin = 'tblclients.OtherContactType'
    end
    object qryCustomersRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblclients.RepID'
      OnChange = qryCustomersRepIDChange
    end
    object qryCustomersGlobal: TWideStringField
      FieldName = 'Global'
      Origin = 'tblclients.Global'
      FixedChar = True
      Size = 1
    end
    object qryCustomersDone: TWideStringField
      FieldName = 'Done'
      Origin = 'tblclients.Done'
      FixedChar = True
      Size = 1
    end
    object qryCustomersActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblclients.Active'
      FixedChar = True
      Size = 1
    end
    object qryCustomersEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblclients.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryCustomersDontContact: TWideStringField
      FieldName = 'DontContact'
      Origin = 'tblclients.DontContact'
      FixedChar = True
      Size = 1
    end
    object qryCustomersParentClientID: TIntegerField
      FieldName = 'ParentClientID'
      Origin = 'tblclients.ParentClientID'
    end
    object qryCustomersGracePeriod: TSmallintField
      FieldName = 'GracePeriod'
      Origin = 'tblclients.GracePeriod'
    end
    object qryCustomersClientNo: TWideStringField
      FieldName = 'ClientNo'
      Origin = 'tblclients.ClientNo'
      Size = 50
    end
    object qryCustomersTAXID: TIntegerField
      FieldName = 'TAXID'
      Origin = 'tblclients.TAXID'
    end
    object qryCustomersTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'tblclients.Title'
      Size = 25
    end
    object qryCustomersClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
      Origin = 'tblclients.ClientTypeID'
      OnChange = qryCustomersClientTypeIDChange
    end
    object qryCustomersURL: TWideStringField
      FieldName = 'URL'
      Origin = 'tblclients.URL'
      Size = 255
    end
    object qryCustomersStopCredit: TWideStringField
      FieldName = 'StopCredit'
      Origin = 'tblclients.StopCredit'
      FixedChar = True
      Size = 1
    end
    object qryCustomersRequired: TWideStringField
      FieldName = 'Required'
      Origin = 'tblclients.Required'
      FixedChar = True
      Size = 1
    end
    object qryCustomersForcePOOnBooking: TWideStringField
      FieldName = 'ForcePOOnBooking'
      Origin = 'tblclients.ForcePOOnBooking'
      FixedChar = True
      Size = 1
    end
    object qryCustomersForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      Origin = 'tblclients.ForcePOOnInvoice'
      FixedChar = True
      Size = 1
    end
    object qryCustomersPickingPriority: TIntegerField
      FieldName = 'PickingPriority'
      Origin = 'tblclients.PickingPriority'
    end
    object qryCustomersDefaultInvoiceTemplateID: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
      Origin = 'tblclients.DefaultInvoiceTemplateID'
    end
    object qryCustomersRepName: TWideStringField
      FieldName = 'RepName'
      Origin = 'tblclients.RepName'
      Size = 255
    end
    object qryCustomersCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Origin = 'tblclients.CardNumber'
      Size = 255
    end
    object qryCustomersGroupDiscountOverridesAll: TWideStringField
      FieldName = 'GroupDiscountOverridesAll'
      Origin = 'tblclients.GroupDiscountOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qryCustomersDefaultClass: TWideStringField
      FieldName = 'DefaultClass'
      Origin = 'tblclients.DefaultClass'
      Size = 255
    end
    object qryCustomersState: TWideStringField
      DisplayWidth = 40
      FieldName = 'State'
      Origin = 'tblclients.State'
      FixedChar = True
      Size = 255
    end
    object qryCustomersStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblclients.Street'
      Size = 255
    end
    object qryCustomersStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblclients.Street2'
      Size = 255
    end
    object qryCustomersSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblclients.Suburb'
      Size = 255
    end
    object qryCustomersCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblclients.Country'
      Size = 255
    end
    object qryCustomersPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblclients.Postcode'
      Size = 255
    end
    object qryCustomersBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Origin = 'tblclients.BillStreet'
      Size = 255
    end
    object qryCustomersBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Origin = 'tblclients.BillStreet2'
      Size = 255
    end
    object qryCustomersBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Origin = 'tblclients.BillSuburb'
      Size = 255
    end
    object qryCustomersBillState: TWideStringField
      FieldName = 'BillState'
      Origin = 'tblclients.BillState'
      Size = 255
    end
    object qryCustomersBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Origin = 'tblclients.BillCountry'
      Size = 255
    end
    object qryCustomersBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Origin = 'tblclients.BillPostcode'
      Size = 255
    end
    object qryCustomersPOBox: TWideStringField
      FieldName = 'POBox'
      Origin = 'tblclients.POBox'
      Size = 255
    end
    object qryCustomersPOSuburb: TWideStringField
      FieldName = 'POSuburb'
      Origin = 'tblclients.POSuburb'
      Size = 255
    end
    object qryCustomersPOState: TWideStringField
      FieldName = 'POState'
      Origin = 'tblclients.POState'
      Size = 255
    end
    object qryCustomersPOCountry: TWideStringField
      FieldName = 'POCountry'
      Origin = 'tblclients.POCountry'
      Size = 255
    end
    object qryCustomersPOPostcode: TWideStringField
      FieldName = 'POPostcode'
      Origin = 'tblclients.POPostcode'
      Size = 255
    end
    object qryCustomersCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Origin = 'tblclients.CUSTFLD1'
      Size = 255
    end
    object qryCustomersCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Origin = 'tblclients.CUSTFLD2'
      Size = 255
    end
    object qryCustomersCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Origin = 'tblclients.CUSTFLD3'
      Size = 255
    end
    object qryCustomersCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Origin = 'tblclients.CUSTFLD4'
      Size = 255
    end
    object qryCustomersCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Origin = 'tblclients.CUSTFLD5'
      Size = 255
    end
    object qryCustomersCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Origin = 'tblclients.CUSTFLD6'
      Size = 255
    end
    object qryCustomersCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Origin = 'tblclients.CUSTFLD7'
      Size = 255
    end
    object qryCustomersCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Origin = 'tblclients.CUSTFLD8'
      Size = 255
    end
    object qryCustomersCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Origin = 'tblclients.CUSTFLD9'
      Size = 255
    end
    object qryCustomersCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Origin = 'tblclients.CUSTFLD10'
      Size = 255
    end
    object qryCustomersCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Origin = 'tblclients.CUSTFLD11'
      Size = 255
    end
    object qryCustomersCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Origin = 'tblclients.CUSTFLD12'
      Size = 255
    end
    object qryCustomersCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Origin = 'tblclients.CUSTFLD13'
      Size = 255
    end
    object qryCustomersCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Origin = 'tblclients.CUSTFLD14'
      Size = 255
    end
    object qryCustomersCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Origin = 'tblclients.CUSTFLD15'
      Size = 255
    end
    object qryCustomersCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblclients.CreationDate'
    end
    object qryCustomersDischargeDate: TDateField
      FieldName = 'DischargeDate'
      Origin = 'tblclients.DischargeDate'
    end
    object qryCustomersArea: TWideStringField
      FieldName = 'Area'
      Origin = 'tblclients.Area'
    end
    object qryCustomersJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Origin = 'tblclients.JobTitle'
      Size = 255
    end
    object qryCustomersInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
      Origin = 'tblclients.InvBaseNumber'
    end
    object qryCustomersUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      Origin = 'tblclients.UseInvBase'
      FixedChar = True
      Size = 1
    end
    object qryCustomersParentRelatedClientID: TIntegerField
      FieldName = 'ParentRelatedClientID'
      Origin = 'tblclients.ParentRelatedClientID'
    end
    object qryCustomersDeliveryNotes: TWideMemoField
      FieldName = 'DeliveryNotes'
      Origin = 'tblclients.DeliveryNotes'
      BlobType = ftWideMemo
    end
    object qryCustomersDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Origin = 'tblclients.DefaultContactMethod'
      Size = 255
    end
    object qryCustomersCreditCardNumber: TWideStringField
      FieldName = 'CreditCardNumber'
      Origin = 'tblclients.CreditCardNumber'
      Size = 255
    end
    object qryCustomersCreditCardExpiryDate: TWideStringField
      FieldName = 'CreditCardExpiryDate'
      Origin = 'tblclients.CreditCardExpiryDate'
      EditMask = '90/00;1; '
      Size = 255
    end
    object qryCustomersCreditCardNotes: TWideStringField
      FieldName = 'CreditCardNotes'
      Origin = 'tblclients.CreditCardNotes'
      Size = 255
    end
    object qryCustomersCreditCardType: TWideStringField
      FieldName = 'CreditCardType'
      Origin = 'tblclients.CreditCardType'
      Size = 255
    end
    object qryCustomersLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
      Origin = 'tblclients.LastUpdated'
    end
    object qryCustomersBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Origin = 'tblclients.BankAccountName'
      Size = 255
    end
    object qryCustomersBankAccountBSB: TWideStringField
      FieldName = 'BankAccountBSB'
      Origin = 'tblclients.BankAccountBSB'
      EditMask = '000-000;1;_'
      Size = 30
    end
    object qryCustomersBankAccountNo: TWideStringField
      FieldName = 'BankAccountNo'
      Origin = 'tblclients.BankAccountNo'
      EditMask = '999999999;0; '
      Size = 30
    end
    object qryCustomersBankCode: TWideStringField
      FieldName = 'BankCode'
      Origin = 'tblclients.BankCode'
      FixedChar = True
      Size = 3
    end
    object qryCustomersForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblclients.ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
    object qryCustomersCreditCardCardHolderName: TWideStringField
      FieldName = 'CreditCardCardHolderName'
      Origin = 'tblclients.CreditCardCardHolderName'
      Size = 40
    end
    object qryCustomersForcePOOnCustomer: TWideStringField
      FieldName = 'ForcePOOnCustomer'
      Origin = 'tblclients.ForcePOOnCustomer'
      FixedChar = True
      Size = 1
    end
    object qryCustomersDefaultDeliveryTemplateID: TIntegerField
      FieldName = 'DefaultDeliveryTemplateID'
      Origin = 'tblclients.DefaultDeliveryTemplateID'
    end
    object qryCustomersHours: TFloatField
      FieldName = 'Hours'
      Origin = 'tblclients.hours'
    end
    object qryCustomersEmailXML: TWideStringField
      FieldName = 'EmailXML'
      Origin = 'tblclients.EmailXML'
      Size = 80
    end
    object qryCustomersInvoiceComment: TWideMemoField
      FieldName = 'InvoiceComment'
      Origin = 'tblclients.InvoiceComment'
      BlobType = ftWideMemo
    end
    object qryCustomersrepairComment: TWideMemoField
      FieldName = 'repairComment'
      Origin = 'tblclients.repairComment'
      BlobType = ftWideMemo
    end
    object qryCustomersInvoiceCommentPopUp: TWideStringField
      FieldName = 'InvoiceCommentPopUp'
      Origin = 'tblclients.InvoiceCommentPopup'
      FixedChar = True
      Size = 1
    end
    object qryCustomersrepairCommentPopUp: TWideStringField
      FieldName = 'repairCommentPopUp'
      Origin = 'tblclients.RepairCommentPopUp'
      FixedChar = True
      Size = 1
    end
    object qryCustomersSendXMLInvoices: TWideStringField
      FieldName = 'SendXMLInvoices'
      Origin = 'tblclients.SendXMLInvoices'
      FixedChar = True
      Size = 1
    end
    object qryCustomersStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblclients.Street3'
      Size = 255
    end
    object qryCustomersBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Origin = 'tblclients.BillStreet3'
      Size = 255
    end
    object qryCustomersIncludeOnIntrastat: TWideStringField
      FieldName = 'IncludeOnIntrastat'
      Origin = 'tblclients.IncludeOnIntrastat'
      FixedChar = True
      Size = 1
    end
    object qryCustomersCUSTDATE1: TDateField
      FieldName = 'CUSTDATE1'
      Origin = 'tblclients.CUSTDATE1'
    end
    object qryCustomersCUSTDATE2: TDateField
      FieldName = 'CUSTDATE2'
      Origin = 'tblclients.CUSTDATE2'
    end
    object qryCustomersCUSTDATE3: TDateField
      FieldName = 'CUSTDATE3'
      Origin = 'tblclients.CUSTDATE3'
    end
    object qryCustomersForcePOOnRepair: TWideStringField
      FieldName = 'ForcePOOnRepair'
      Origin = 'tblclients.ForcePOOnRepair'
      FixedChar = True
      Size = 1
    end
    object qryCustomersGlobalref: TWideStringField
      FieldName = 'Globalref'
      Origin = 'tblclients.GlobalRef'
      Size = 255
    end
    object qryCustomersSpecialProductPriceOverridesAll: TWideStringField
      FieldName = 'SpecialProductPriceOverridesAll'
      Origin = 'tblclients.SpecialProductPriceOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qryCustomersPortOfLanding: TWideStringField
      FieldName = 'PortOfLanding'
      Origin = 'tblclients.PortOfLanding'
      Size = 100
    end
    object qryCustomersPortOfDischarge: TWideStringField
      FieldName = 'PortOfDischarge'
      Origin = 'tblclients.PortOfDischarge'
      Size = 100
    end
    object qryCustomersFinalDestination: TWideStringField
      FieldName = 'FinalDestination'
      Origin = 'tblclients.FinalDestination'
      Size = 100
    end
    object qryCustomersIncoPlace: TWideStringField
      FieldName = 'IncoPlace'
      Origin = 'tblclients.IncoPlace'
      Size = 100
    end
    object qryCustomersShippingAgentID: TIntegerField
      FieldName = 'ShippingAgentID'
      Origin = 'tblclients.ShippingAgentID'
    end
    object qryCustomersShippingAgentCode: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ShippingAgentCode'
      LookupDataSet = QryShippingAgent
      LookupKeyFields = 'ShippingAgentID'
      LookupResultField = 'Code'
      KeyFields = 'ShippingAgentID'
      Size = 10
      Lookup = True
    end
    object qryCustomersShippingAgentDescription: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ShippingAgentDescription'
      LookupDataSet = QryShippingAgent
      LookupKeyFields = 'ShippingAgentID'
      LookupResultField = 'Description'
      KeyFields = 'ShippingAgentID'
      Size = 100
      Lookup = True
    end
    object qryCustomersShippingAgentSuplierName: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ShippingAgentSupplierName'
      LookupDataSet = QryShippingAgent
      LookupKeyFields = 'ShippingAgentID'
      LookupResultField = 'SupplierName'
      KeyFields = 'ShippingAgentID'
      Size = 100
      Lookup = True
    end
    object qryCustomersShippingAgentSuplierID: TIntegerField
      FieldKind = fkLookup
      FieldName = 'ShippingAgentSupplierID'
      LookupDataSet = QryShippingAgent
      LookupKeyFields = 'ShippingAgentID'
      LookupResultField = 'SupplierId'
      KeyFields = 'ShippingAgentID'
      Lookup = True
    end
    object qryCustomersShippingAgentInsurance: TWideStringField
      FieldKind = fkLookup
      FieldName = 'ShippingAgentInsurance'
      LookupDataSet = QryShippingAgent
      LookupKeyFields = 'ShippingAgentID'
      LookupResultField = 'Insurance'
      KeyFields = 'ShippingAgentID'
      Size = 255
      Lookup = True
    end
    object qryCustomersDefaultStatementTemplateId: TIntegerField
      FieldName = 'DefaultStatementTemplateId'
      Origin = 'tblclients.DefaultStatementTemplateId'
    end
    object qryCustomersCallPriority: TIntegerField
      FieldName = 'CallPriority'
      Origin = 'tblclients.CallPriority'
    end
    object qryCustomersTeamviewerID: TWideStringField
      FieldName = 'TeamviewerID'
      Origin = 'tblclients.TeamviewerID'
      Size = 9
    end
    object qryCustomersSkypename: TWideStringField
      FieldName = 'Skypename'
      Origin = 'tblclients.SkypeName'
      Size = 100
    end
    object qryCustomersmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblclients.msUpdateSiteCode'
      Size = 3
    end
    object qryCustomersIsInternal: TWideStringField
      FieldName = 'IsInternal'
      Origin = 'tblclients.IsInternal'
      FixedChar = True
      Size = 1
    end
    object qryCustomersTaxname: TWideStringField
      FieldName = 'Taxname'
      Origin = 'tblclients.Taxname'
      OnChange = qryCustomersTaxnameChange
      Size = 100
    end
    object qryCustomersDefaultARAccountName: TWideStringField
      FieldName = 'DefaultARAccountName'
      Origin = 'tblclients.DefaultARAccountName'
      Size = 100
    end
    object qryCustomersDefaultARAccountID: TIntegerField
      FieldName = 'DefaultARAccountID'
      Origin = 'tblclients.DefaultARAccountID'
    end
    object qryCustomersSendFTPXMLInvoices: TWideStringField
      FieldName = 'SendFTPXMLInvoices'
      Origin = 'tblclients.SendFTPXMLInvoices'
      FixedChar = True
      Size = 1
    end
    object qryCustomersFTPAddress: TWideStringField
      FieldName = 'FTPAddress'
      Origin = 'tblclients.FTPAddress'
      Size = 255
    end
    object qryCustomersFTPUserName: TWideStringField
      FieldName = 'FTPUserName'
      Origin = 'tblclients.FTPUserName'
      Size = 255
    end
    object qryCustomersFTPPassword: TWideStringField
      FieldName = 'FTPPassword'
      Origin = 'tblclients.FTPPassword'
      Size = 255
    end
    object qryCustomersDocumentPath: TWideStringField
      FieldName = 'DocumentPath'
      Origin = 'tblclients.DocumentPath'
      Size = 255
    end
    object qryCustomerscDocumentPath: TStringField
      FieldKind = fkCalculated
      FieldName = 'cDocumentPath'
      Size = 255
      Calculated = True
    end
    object qryCustomersclientCode: TWideStringField
      FieldName = 'clientCode'
      Origin = 'tblclients.ClientCode'
      Size = 5
    end
    object qryCustomersAddressValid: TWideStringField
      FieldName = 'AddressValid'
      Origin = 'tblclients.AddressValid'
      FixedChar = True
      Size = 1
    end
    object qryCustomersBillAddressValid: TWideStringField
      FieldName = 'BillAddressValid'
      Origin = 'tblclients.BillAddressValid'
      FixedChar = True
      Size = 1
    end
    object qryCustomersForcePoOnSalesOrder: TWideStringField
      FieldName = 'ForcePoOnSalesOrder'
      FixedChar = True
      Size = 1
    end
    object qryCustomersDefaultSalesOrderTemplateID: TIntegerField
      FieldName = 'DefaultSalesOrderTemplateID'
    end
    object qryCustomersPrintName: TWideStringField
      FieldName = 'PrintName'
      Size = 255
    end
    object qryCustomersCreditCardCVC: TWideStringField
      FieldName = 'CreditCardCVC'
      Size = 50
    end
    object qryCustomersClientPaysShippment: TWideStringField
      FieldName = 'ClientPaysShippment'
      FixedChar = True
      Size = 1
    end
    object qryCustomersClientShipperAccountNo: TWideStringField
      FieldName = 'ClientShipperAccountNo'
      Size = 255
    end
    object qryCustomersmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object qryDocuments: TERPQuery [15]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'tblReference.RefID, '
      'tblReference.Ref_Date as Date, '
      'tblReference.Ref_type as Type,'
      'tblReference.Referencetxt as Reference, '
      'tblReference.CusID, '
      'tblReference.ContactID,'
      
        'Concat_Ws(" ",tblContacts.ContactFirstName,tblContacts.ContactSu' +
        'rname) as ContactName,'
      'tblReference.active,'
      'tblReference.EditedFlag,'
      'tblReference.MessageId,'
      'tblReference.ReferenceData,'
      'tblReference.MessageFrom,'
      'tblReference.MessageTo,'
      'tblReference.Status'
      'FROM tblReference'
      'LEFT JOIN tblClients ON tblReference.CusID=tblClients.ClientID'
      
        'LEFT JOIN tblContacts ON tblReference.ContactID=tblContacts.Cont' +
        'actID'
      'WHERE tblReference.CusID=:CusID'
      'ORDER BY tblReference.Ref_Date DESC;')
    Filtered = True
    Filter = 'Active ='#39'T'#39
    BeforePost = qryDocumentsBeforePost
    AfterPost = qryDocumentsAfterPost
    Left = 687
    Top = 1
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CusID'
        Value = 0
      end>
    object qryDocumentsDate: TDateTimeField
      DisplayWidth = 19
      FieldName = 'Date'
    end
    object qryDocumentsContactName: TWideStringField
      DisplayLabel = 'Contact'
      DisplayWidth = 14
      FieldName = 'ContactName'
      Size = 61
    end
    object qryDocumentsType: TWideStringField
      DisplayWidth = 6
      FieldName = 'Type'
      Size = 50
    end
    object qryDocumentsStatus: TWideStringField
      DisplayWidth = 9
      FieldName = 'Status'
    end
    object qryDocumentsReference: TWideStringField
      DisplayWidth = 25
      FieldName = 'Reference'
      Size = 50
    end
    object qryDocumentsMessageFrom: TWideStringField
      DisplayLabel = 'From'
      DisplayWidth = 15
      FieldName = 'MessageFrom'
      Size = 255
    end
    object qryDocumentsMessageTo: TWideStringField
      DisplayLabel = 'To'
      DisplayWidth = 15
      FieldName = 'MessageTo'
      Size = 255
    end
    object qryDocumentsactive: TWideStringField
      DisplayLabel = 'Active'
      DisplayWidth = 1
      FieldName = 'active'
      FixedChar = True
      Size = 1
    end
    object qryDocumentsRefID: TIntegerField
      FieldName = 'RefID'
      Visible = False
    end
    object qryDocumentsCusID: TIntegerField
      FieldName = 'CusID'
      Visible = False
    end
    object qryDocumentsContactID: TIntegerField
      FieldName = 'ContactID'
      Visible = False
    end
    object qryDocumentsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDocumentsMessageId: TWideStringField
      FieldName = 'MessageId'
      Visible = False
      Size = 255
    end
    object qryDocumentsReferenceData: TBlobField
      FieldName = 'ReferenceData'
      Visible = False
    end
  end
  object DSDocuments: TDataSource [16]
    DataSet = qryDocuments
    Left = 670
    Top = 33
  end
  object qrySpecials: TERPQuery [17]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblCustomerLines'
      'Where CustomerID = :CusID'
      'ORDER BY ProductID')
    AfterOpen = qrySpecialsAfterOpen
    AfterInsert = qrySpecialsAfterInsert
    BeforePost = qrySpecialsBeforePost
    AfterPost = qrySpecialsAfterPost
    Left = 817
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object qrySpecialsName: TWideStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Origin = 'tblCustomerLines.Name'
      OnChange = qrySpecialsNameChange
      Size = 40
    end
    object qrySpecialsDescription: TWideStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Origin = 'tblCustomerLines.Description'
      Size = 255
    end
    object qrySpecialsOrigPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'OrigPrice'
      Origin = 'tblCustomerLines.OrigPrice'
      currency = True
    end
    object qrySpecialsLinePrice: TFloatField
      DisplayWidth = 10
      FieldName = 'LinePrice'
      Origin = 'tblCustomerLines.LinePrice'
      currency = True
    end
    object qrySpecialsCustomerLinesID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'CustomerLinesID'
      Origin = 'tblCustomerLines.CustomerLinesID'
      ReadOnly = True
      Visible = False
    end
    object qrySpecialsProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblCustomerLines.ProductID'
      Visible = False
    end
    object qrySpecialsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblCustomerLines.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qrySpecialsCustomerId: TIntegerField
      FieldName = 'CustomerId'
      Origin = 'tblCustomerLines.CustomerId'
    end
    object qrySpecialsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qrySpecialsIncludeInRun: TWideStringField
      FieldName = 'IncludeInRun'
      FixedChar = True
      Size = 1
    end
    object qrySpecialsDateFrom: TDateField
      DisplayLabel = 'Date From'
      DisplayWidth = 18
      FieldName = 'DateFrom'
    end
    object qrySpecialsDateTo: TDateField
      DisplayLabel = 'Date To'
      DisplayWidth = 18
      FieldName = 'DateTo'
    end
    object qrySpecialsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qrySpecialsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qrySpecialsUOM: TWideStringField
      FieldName = 'UOM'
      Size = 100
    end
    object qrySpecialsUOMID: TIntegerField
      FieldName = 'UOMID'
    end
    object qrySpecialsUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
    end
  end
  object DSSpecials: TDataSource [18]
    DataSet = qrySpecials
    Left = 812
    Top = 33
  end
  object qryContacts: TERPQuery [19]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblContacts'
      'WHERE ClientID = :CusID')
    BeforeOpen = qryContactsBeforeOpen
    AfterOpen = qryContactsAfterOpen
    Left = 785
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object qryContactsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryContactsContactID: TIntegerField
      FieldName = 'ContactID'
    end
    object qryContactsClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryContactsClientName: TWideStringField
      FieldName = 'ClientName'
      Size = 255
    end
    object qryContactsCompany: TWideStringField
      FieldName = 'Company'
      Size = 50
    end
    object qryContactsContactTitle: TWideStringField
      FieldName = 'ContactTitle'
      Size = 32
    end
    object qryContactsContactFirstName: TWideStringField
      FieldName = 'ContactFirstName'
      Size = 30
    end
    object qryContactsContactSurName: TWideStringField
      FieldName = 'ContactSurName'
      Size = 30
    end
    object qryContactsContactAddress: TWideStringField
      FieldName = 'ContactAddress'
      Size = 255
    end
    object qryContactsContactAddress2: TWideStringField
      FieldName = 'ContactAddress2'
      Size = 255
    end
    object qryContactsContactAddress3: TWideStringField
      FieldName = 'ContactAddress3'
      Size = 255
    end
    object qryContactsContactCity: TWideStringField
      FieldName = 'ContactCity'
      Size = 255
    end
    object qryContactsContactState: TWideStringField
      FieldName = 'ContactState'
      Size = 255
    end
    object qryContactsContactPcode: TWideStringField
      FieldName = 'ContactPcode'
      Size = 255
    end
    object qryContactsContactCountry: TWideStringField
      FieldName = 'ContactCountry'
      Size = 255
    end
    object qryContactsContactPH: TWideStringField
      FieldName = 'ContactPH'
      Size = 255
    end
    object qryContactsContactAltPH: TWideStringField
      FieldName = 'ContactAltPH'
      Size = 255
    end
    object qryContactsContactMOB: TWideStringField
      FieldName = 'ContactMOB'
      Size = 255
    end
    object qryContactsContactFax: TWideStringField
      FieldName = 'ContactFax'
      Size = 255
    end
    object qryContactsContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Size = 255
    end
    object qryContactsNotes: TWideStringField
      FieldName = 'Notes'
      Size = 255
    end
    object qryContactsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryContactsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryContactsCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object qryContactsAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Size = 255
    end
    object qryContactsJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object qryContactsUseOnRun: TWideStringField
      FieldName = 'UseOnRun'
      FixedChar = True
      Size = 1
    end
    object qryContactsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryContactsLogMeInComputerIPAddress: TWideStringField
      FieldName = 'LogMeInComputerIPAddress'
    end
    object qryContactsLogMeInEmailPassword: TWideStringField
      FieldName = 'LogMeInEmailPassword'
      Size = 100
    end
    object qryContactsLogMeInUserName: TWideStringField
      FieldName = 'LogMeInUserName'
      Size = 100
    end
    object qryContactsLogMeInPassword: TWideStringField
      FieldName = 'LogMeInPassword'
      Size = 100
    end
    object qryContactsLogMeInERPUserName: TWideStringField
      FieldName = 'LogMeInERPUserName'
      Size = 100
    end
    object qryContactsLogMeInERPPassword: TWideStringField
      FieldName = 'LogMeInERPPassword'
      Size = 100
    end
    object qryContactsLogMeIncomputerPassword: TWideStringField
      FieldName = 'LogMeIncomputerPassword'
      Size = 100
    end
    object qryContactsIsPrimarycontact: TWideStringField
      FieldName = 'IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object qryContactsTeamviewerID: TWideStringField
      FieldName = 'TeamviewerID'
      Size = 9
    end
    object qryContactsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object DSContacts: TDataSource [20]
    DataSet = qryContacts
    Left = 776
    Top = 33
  end
  inherited popSpelling: TPopupMenu
    Left = 96
    Top = 0
  end
  object dsOtherFollowUp: TDataSource [22]
    DataSet = tbOtherFollowUp
    OnStateChange = dsStateChange
    Left = 847
    Top = 33
  end
  object ActionList1: TActionList [23]
    OnUpdate = ActionList1Update
    Left = 231
    Top = 1
    object actGeneral: TAction
      Caption = 'Save'
      HelpContext = 254367
      OnUpdate = actGeneralUpdate
    end
    object actReferralsPrint: TAction
      Caption = 'Letters'
      HelpContext = 254520
      OnExecute = actReferralsPrintExecute
      OnUpdate = actReferralsPrintUpdate
    end
  end
  object memqryCustomers: TkbmMemTable [24]
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 491
    Top = 1
  end
  object memtbOtherFollowUp: TkbmMemTable [25]
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 589
    Top = 1
  end
  object memqrySpecials: TkbmMemTable [26]
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 821
    Top = 64
  end
  object memqryContacts22: TkbmMemTable [27]
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    Left = 779
    Top = 64
  end
  object dsProdGroupDiscs: TDataSource [28]
    DataSet = qryProdGroupDiscs
    Left = 706
    Top = 33
  end
  object qryProdGroupDiscs: TERPQuery [29]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * '
      'FROM tblprodgroupdiscs'
      'WHERE ClientID=:xClientID')
    BeforeOpen = qryProdGroupDiscsBeforeOpen
    AfterOpen = qryProdGroupDiscsAfterOpen
    AfterInsert = qryProdGroupDiscsAfterInsert
    BeforePost = qryProdGroupDiscsBeforePost
    Left = 720
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryProdGroupDiscsCol1: TWideStringField
      DisplayWidth = 20
      FieldName = 'Col1'
      Size = 255
    end
    object qryProdGroupDiscsCol2: TWideStringField
      DisplayWidth = 20
      FieldName = 'Col2'
      Size = 255
    end
    object qryProdGroupDiscsCol3: TWideStringField
      DisplayWidth = 20
      FieldName = 'Col3'
      Size = 255
    end
    object qryProdGroupDiscsDiscount: TFloatField
      DisplayLabel = '% Discount'
      DisplayWidth = 10
      FieldName = 'Discount'
    end
    object qryProdGroupDiscsMustMatch: TWideStringField
      DisplayLabel = 'Must Match All'
      DisplayWidth = 1
      FieldName = 'MustMatch'
      FixedChar = True
      Size = 1
    end
    object qryProdGroupDiscsGrpDiscID: TIntegerField
      DisplayWidth = 10
      FieldName = 'GrpDiscID'
      Visible = False
    end
    object qryProdGroupDiscsGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryProdGroupDiscsClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object qryProdGroupDiscsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryProdGroupDiscsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object qryProdGroupDiscsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsReferrals: TDataSource [30]
    DataSet = qryReferrals
    Left = 635
    Top = 33
  end
  object qryReferrals: TERPQuery [31]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ReferralID, ClientID, ReferredClientID, EditedFlag'
      'FROM tblReferrals'
      'WHERE ClientID = :xClientID')
    AfterInsert = qryReferralsAfterInsert
    Left = 654
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryReferralsReferralID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ReferralID'
      Origin = 'tblReferrals.ReferralID'
      ReadOnly = True
    end
    object qryReferralsClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblReferrals.ClientID'
    end
    object qryReferralsReferredClientID: TIntegerField
      FieldName = 'ReferredClientID'
      Origin = 'tblReferrals.ReferredClientID'
    end
    object qryReferralsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblReferrals.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryReferralsCompanyLookup: TWideStringField
      FieldKind = fkLookup
      FieldName = 'CompanyLookup'
      LookupDataSet = qryClients
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ReferredClientID'
      Size = 80
      Lookup = True
    end
    object qryReferralsPhoneLookup: TWideStringField
      FieldKind = fkLookup
      FieldName = 'PhoneLookup'
      LookupDataSet = qryClients
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Phone'
      KeyFields = 'ReferredClientID'
      EditMask = '## #### ####;0;_'
      Size = 25
      Lookup = True
    end
    object qryReferralsFaxLookup: TWideStringField
      FieldKind = fkLookup
      FieldName = 'FaxLookup'
      LookupDataSet = qryClients
      LookupKeyFields = 'ClientID'
      LookupResultField = 'FaxNumber'
      KeyFields = 'ReferredClientID'
      EditMask = '## #### ####;0;_'
      Size = 25
      Lookup = True
    end
    object qryReferralsCustomertype: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Customertype'
      LookupDataSet = qryClients
      LookupKeyFields = 'ClientID'
      LookupResultField = 'TypeName'
      KeyFields = 'ReferredClientID'
      Size = 100
      Lookup = True
    end
  end
  object tbOtherFollowUp: TERPQuery [32]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT O.* '
      'FROM tblotherfollowup O'
      'WHERE ClientID= :xClientID'
      '/*'
      'SELECT O.*,'
      'case O.ContactId'
      
        'when 0  then (select  CONCAT(C.FirstName, CONCAT('#39' '#39', C.LastName' +
        '))  from tblClients C where ClientId=:xClientId)'
      
        'else (Select  CONCAT(T.ContactFirstName, Concat('#39' '#39',T.ContactSur' +
        'name)) from tblContacts T where T.ContactId = O.ContactId)'
      'END as ContactName'
      'FROM tblotherfollowup O'
      'WHERE ClientID=:xClientId'
      '*/')
    AfterOpen = tbOtherFollowUpAfterOpen
    BeforeInsert = tbOtherFollowUpBeforeInsert
    AfterInsert = tbOtherFollowUpAfterInsert
    AfterScroll = tbOtherFollowUpAfterScroll
    OnNewRecord = tbOtherFollowUpNewRecord
    Left = 850
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object tbOtherFollowUpFollowUpDate: TDateTimeField
      DisplayLabel = 'Follow Up Date'
      DisplayWidth = 12
      FieldName = 'FollowUpDate'
      Origin = 'O.FollowUpDate'
    end
    object tbOtherFollowUpContactName: TWideStringField
      DisplayLabel = 'Contact Name'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'ContactName'
      LookupDataSet = qryContactNames
      LookupKeyFields = 'ContactId'
      LookupResultField = 'ContactName'
      KeyFields = 'ContactId'
      Lookup = True
    end
    object tbOtherFollowUpNotes: TWideMemoField
      DisplayWidth = 55
      FieldName = 'Notes'
      Origin = 'O.Notes'
      BlobType = ftWideMemo
    end
    object tbOtherFollowUpEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'EmployeeName'
      LookupDataSet = qryEmployees
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'EmployeeID'
      Size = 30
      Lookup = True
    end
    object tbOtherFollowUpDone: TWideStringField
      DisplayWidth = 4
      FieldName = 'Done'
      Origin = 'O.Done'
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpEmployeeID: TIntegerField
      DisplayLabel = 'Employee'
      DisplayWidth = 13
      FieldName = 'EmployeeID'
      Origin = 'O.EmployeeID'
      Visible = False
    end
    object tbOtherFollowUpFollowUpID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'FollowUpID'
      Origin = 'O.FollowUpID'
      ReadOnly = True
      Visible = False
    end
    object tbOtherFollowUpOtherContactID: TIntegerField
      DisplayWidth = 10
      FieldName = 'OtherContactID'
      Origin = 'O.OtherContactID'
      Visible = False
    end
    object tbOtherFollowUpRepairID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairID'
      Origin = 'O.RepairID'
      Visible = False
    end
    object tbOtherFollowUpEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'O.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpAppearDays: TIntegerField
      DisplayWidth = 10
      FieldName = 'AppearDays'
      Origin = 'O.AppearDays'
      Visible = False
    end
    object tbOtherFollowUpCreationDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CreationDate'
      Origin = 'O.CreationDate'
      Visible = False
    end
    object tbOtherFollowUpClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'O.ClientID'
      Visible = False
    end
    object tbOtherFollowUpIsSupplier: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsSupplier'
      Origin = 'O.IsSupplier'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsOtherContact: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsOtherContact'
      Origin = 'O.IsOtherContact'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsCustomer: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsCustomer'
      Origin = 'O.IsCustomer'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'O.GlobalRef'
      Visible = False
      Size = 255
    end
    object tbOtherFollowUpUpdateDate: TDateField
      DisplayWidth = 10
      FieldName = 'UpdateDate'
      Origin = 'O.UpdateDate'
      Visible = False
    end
    object tbOtherFollowUpLeadLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LeadLineID'
      Origin = 'O.LeadLineID'
      Visible = False
    end
    object tbOtherFollowUpContactId: TIntegerField
      FieldName = 'ContactId'
      Origin = 'O.ContactId'
      Visible = False
    end
  end
  object EquipNotesDialog1: TwwMemoDialog [33]
    DataField = 'Notes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    DlgLeft = 0
    DlgTop = 0
    DlgWidth = 561
    DlgHeight = 396
    OnUserButton1Click = EquipNotesDialog1UserButton1Click
    UserButton1Caption = 'Add Date'
    Left = 198
    Top = 1
  end
  object qryProductGroupcol3: TERPQuery [34]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '"" AS PartLevel'
      'FROM tblparts'
      
        'WHERE INSTR(IF(INSTR(PRODUCTGROUP,"^")<>0, SUBSTRING_INDEX(PRODU' +
        'CTGROUP,"^",2),""),"^")<>0'
      'Group by PartLevel'
      'Order by PartLevel;')
    Options.LongStrings = False
    Left = 459
    Top = 1
  end
  object qryDocPath: TERPQuery [35]
    Connection = MyConnection
    SQL.Strings = (
      'Select DPID, DocumentPath '
      'FROM tblDocPath;')
    Options.LongStrings = False
    Left = 328
    Top = 1
  end
  object qryClientTypes: TERPQuery [36]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TypeName, TypeDescription , TermsID, CreditLimit,'
      'GracePeriod, ClientTypeID,callpriority , active'
      'FROM tblClientType'
      'WHERE (Active = '#39'T'#39' or ClientTypeID = :ClientTypeID)'
      'Order By TypeName;')
    Options.LongStrings = False
    Left = 34
    Top = 33
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientTypeID'
      end>
    object qryClientTypesTypeName: TWideStringField
      DisplayLabel = 'Type Name'
      DisplayWidth = 25
      FieldName = 'TypeName'
      Size = 50
    end
    object qryClientTypesactive: TWideStringField
      DisplayLabel = 'Active'
      DisplayWidth = 1
      FieldName = 'active'
      FixedChar = True
      Size = 1
    end
    object qryClientTypesTypeDescription: TWideStringField
      FieldName = 'TypeDescription'
      Visible = False
      Size = 255
    end
    object qryClientTypesTermsID: TIntegerField
      FieldName = 'TermsID'
      Visible = False
    end
    object qryClientTypesCreditLimit: TFloatField
      FieldName = 'CreditLimit'
      Visible = False
    end
    object qryClientTypesGracePeriod: TWordField
      FieldName = 'GracePeriod'
      Visible = False
    end
    object qryClientTypesClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
      Visible = False
    end
    object qryClientTypescallpriority: TIntegerField
      FieldName = 'callpriority'
      Visible = False
    end
  end
  object qryProductGroupcol2: TERPQuery [37]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      '"" AS PartLevel'
      'FROM tblparts'
      'WHERE INSTR(PRODUCTGROUP,"^")<>0'
      'Group by PartLevel'
      'Order by PartLevel;')
    Options.LongStrings = False
    Left = 426
    Top = 1
  end
  object qryProductGroupcol1: TERPQuery [38]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '"" AS PartLevel'
      'FROM tblparts'
      'where char_length(SUBSTRING_INDEX(PRODUCTGROUP,'#39'^'#39',1))<>0'
      'Group by PartLevel'
      'Order by PartLevel;')
    Options.LongStrings = False
    Left = 394
    Top = 1
  end
  object qryTaxCodes: TERPQuery [39]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT T.Name as Taxname, T.TaxCodeID, T.Description, T.Rate  , ' +
        'LOC.LocationValue as Location'
      'FROM tbltaxcodes T'
      'Left join tbltaxcodelocations LOC on T.TaxCodeID = LOC.TaxCodeID'
      'where T.Active <>'#39'F'#39'  '
      'AND  RegionID= :RegionId'
      ''
      'and '
      '((ifnull(LOC.ID,0)=0) or ( :filterTaxcodeforClient ='#39'F'#39') or '
      '(LOc.active ="T" and '
      
        '(T.TaxcodeLocationCategory ="C" and LOC.LocationValue = :Clientc' +
        'ountry ) or '
      
        '(T.TaxcodeLocationCategory ="S" and LOC.LocationValue = :ClientS' +
        'tate ) or '
      
        '(T.TaxcodeLocationCategory ="L" and LOC.LocationValue = :clientL' +
        'ocation ) or '
      
        '(T.TaxcodeLocationCategory ="P" and LOC.LocationValue = :ClientP' +
        'ostcode ) '
      '))'
      'and '
      '(((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (T.Name LIKE Concat(:SearchValue,"%"))' +
        ')'
      
        'or ((:SearchMode = 2) and (T.Name LIKE Concat("%",:SearchValue,"' +
        '%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    BeforeOpen = qryTaxCodesBeforeOpen
    OnCalcFields = qryTaxCodesCalcFields
    Options.LongStrings = False
    Left = 433
    Top = 65
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RegionId'
      end
      item
        DataType = ftUnknown
        Name = 'filterTaxcodeforClient'
      end
      item
        DataType = ftUnknown
        Name = 'Clientcountry'
      end
      item
        DataType = ftUnknown
        Name = 'ClientState'
      end
      item
        DataType = ftUnknown
        Name = 'clientLocation'
      end
      item
        DataType = ftUnknown
        Name = 'ClientPostcode'
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
    object qryTaxCodesTaxname: TWideStringField
      DisplayWidth = 15
      FieldName = 'Taxname'
      Size = 15
    end
    object qryTaxCodesDescription: TWideStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Origin = 'T.Description'
      Size = 255
    end
    object qryTaxCodesLocation: TWideStringField
      DisplayWidth = 10
      FieldName = 'Location'
      Origin = 'LOC.Location'
      Size = 255
    end
    object qryTaxCodescRate: TFloatField
      DisplayLabel = 'Rate'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'cRate'
      DisplayFormat = '##0.00%'
      Calculated = True
    end
    object qryTaxCodesTaxCodeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TaxCodeID'
      Origin = 'T.TaxCodeID'
      Visible = False
    end
    object qryTaxCodesRate: TFloatField
      FieldName = 'Rate'
      Origin = 'T.Rate'
      Visible = False
    end
  end
  object qryClients: TERPQuery [40]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblClients.ClientID, tblClients.Company, tblClients.Phone' +
        ', tblClients.FaxNumber  , tblclienttype.TypeName'
      'FROM tblClients '
      
        'Left join tblclienttype on tblclienttype.ClientTypeID = tblClien' +
        'ts.ClientTypeID'
      'WHERE tblClients.Active = '#39'T'#39
      'ORDER BY Company;')
    Options.LongStrings = False
    Left = 423
    Top = 33
  end
  object qryEmployees: TERPQuery [41]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT E.EmployeeID, Concat_WS('#39' '#39',E.FirstName,E.LastName) AS Em' +
        'ployeeName'
      'FROM tblEmployees AS E'
      'WHERE E.Active = '#39'T'#39
      'ORDER BY EmployeeName;')
    Options.LongStrings = False
    Left = 458
    Top = 33
  end
  object qryPayMethod: TERPQuery [42]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT PayMethodID, Name, IsCreditCard FROM tblpaymentmethods wh' +
        'ere Active ="T";')
    Options.LongStrings = False
    Left = 352
    Top = 33
  end
  object qryMediaType: TERPQuery [43]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT  tblSource.MedTypeID, tblSource.MediaType, tblSource.Acti' +
        've '
      'FROM tblSource '
      
        'WHERE (((tblSource.MediaType)>" ") And ((tblSource.Active)<>'#39'F'#39')' +
        ') '
      'ORDER BY tblSource.MediaType; ')
    Options.LongStrings = False
    Left = 317
    Top = 33
  end
  object qryTerms: TERPQuery [44]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblTerms.TermsID, tblTerms.Terms, tblTerms.Active '
      
        'FROM tblTerms WHERE (((tblTerms.Terms)>" ") And ((tblTerms.Activ' +
        'e)<>'#39'F'#39')) '
      'ORDER BY tblTerms.Terms; ')
    AfterOpen = qryTermsAfterOpen
    Options.LongStrings = False
    Left = 210
    Top = 33
  end
  object qryInvoiceTemplates: TERPQuery [45]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT TemplID,TemplName FROM `tbltemplates`  WHERE `TypeID` = '#39 +
        '11'#39';')
    Options.LongStrings = False
    Left = 140
    Top = 33
  end
  object qrySuburb: TERPQuery [46]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Code, Country'
      'FROM tblLocations '
      'Where RegionID= :xRegionID'
      'ORDER BY City_sub;')
    BeforeOpen = qrySuburbBeforeOpen
    Options.LongStrings = False
    Left = 281
    Top = 33
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object cboProductQry: TERPQuery [47]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PARTSID,PARTTYPE, PRODUCTGROUP, PARTNAME,'
      ' PARTSDESCRIPTION,  INCOMEACCNT,'
      ' ASSETACCNT, COGSACCNT, BARCODE, PRODUCTCODE, '
      'TAXCODE,   '
      'SpecialDiscount, SNTracking,  BuyQTY1, BuyQTY2,'
      ' BuyQTY3, COST1, COST2, COST3, SellQTY1, SellQTY2, SellQTY3,'
      ' PRICE1, PRICE2, PRICE3, WHOLESALEPRICE, Active, EditedFlag  '
      'FROM tblparts WHERE Active = '#39'T'#39
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((PartName LIKE Concat(:SearchValue,"%' +
        '")) or (PARTSDESCRIPTION LIKE Concat(:SearchValue,"%"))) )'
      
        'or ((:SearchMode = 2) and ((PartName LIKE Concat("%",:SearchValu' +
        'e,"%")) or (PARTSDESCRIPTION LIKE Concat("%",:SearchValue,"%")))' +
        ' ))'
      'and IfNull(:SearchValue,"") <> ""'
      'order by PartName')
    AfterOpen = cboProductQryAfterOpen
    Options.LongStrings = False
    Left = 96
    Top = 33
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
      end>
  end
  object qryShipping: TERPQuery [48]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblShippingMethods.ShippingMethodID, '
      'tblShippingMethods.ShippingMethod '
      'FROM tblShippingMethods '
      
        'GROUP BY tblShippingMethods.ShippingMethodID, tblShippingMethods' +
        '.ShippingMethod '
      'ORDER BY tblShippingMethods.ShippingMethod; '
      '')
    Options.LongStrings = False
    Left = 69
    Top = 33
  end
  object cboClassQry: TERPQuery [49]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT C.ClassID, C.ClassName '
      'FROM tblClass AS C'
      'WHERE C.Active='#39'T'#39
      'ORDER BY C.ClassName; ')
    Options.LongStrings = False
    Left = 73
    Top = 65
    object cboClassQryClassID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClassID'
      Origin = 'tblClass.ClassID'
    end
    object cboClassQryClassName: TWideStringField
      DisplayLabel = 'Class Name'
      DisplayWidth = 20
      FieldName = 'ClassName'
      Origin = 'tblClass.ClassName'
      Size = 60
    end
  end
  object qryCustomFields: TERPQuery [50]
    Connection = frmCustomFields.MyConnection
    SQL.Strings = (
      'SELECT'
      'CFLabel1,CFCust1, CFEmpl1, CFSupp1, CFLabel2,'
      'CFCust2, CFEmpl2, CFSupp2, CFLabel3, CFCust3, CFEmpl3,'
      'CFSupp3, CFLabel4, CFCust4, CFEmpl4, CFSupp4, CFLabel5,'
      'CFCust5, CFEmpl5, CFSupp5, CFLabel6, CFCust6, CFEmpl6,'
      'CFSupp6, CFLabel7, CFCust7, CFEmpl7, CFSupp7, CFLabel8,'
      'CFCust8, CFEmpl8, CFSupp8, CFLabel9, CFCust9, CFEmpl9,'
      'CFSupp9, CFLabel10, CFCust10, CFEmpl10, CFSupp10, CFLabel11,'
      'CFCust11, CFEmpl11, CFSupp11, CFLabel12, CFCust12, CFEmpl12,'
      'CFSupp12, CFLabel13, CFCust13, CFEmpl13, CFSupp13, CFLabel14,'
      'CFCust14, CFEmpl14, CFSupp14, CFLabel15, CFCust15, CFEmpl15,'
      'CFSupp15, CFEmpl16, CFEmpl17, CFEmpl18, CFLabel16, CFlabel17,'
      'CFLabel18, CFCust16, CFCust17, CFCust18,'
      'CFSupp16, CFSupp17, CFSupp18,'
      'EditedFlag, CFOthr1, CFOthr2, CFOthr3, CFOthr4, CFOthr5,'
      
        'CFOthr6, CFOthr7, CFOthr8, CFOthr9, CFOthr10, CFOthr11, CFOthr12' +
        ','
      'CFOthr13, CFOthr14, CFOthr15, CFOthr16, CFOthr17, CFOthr18,'
      'CFIsCombo1, CFIsCombo2, CFIsCombo3, CFIsCombo4, CFIsCombo5,'
      'CFIsCombo6, CFIsCombo7, CFIsCombo8, CFIsCombo9, CFIsCombo10,'
      'CFIsCombo11, CFIsCombo12, CFIsCombo13, CFIsCombo14, CFIsCombo15'
      'FROM tblcustomfields;')
    Options.LongStrings = False
    Left = 387
    Top = 33
  end
  object qryRelatedClients: TERPQuery [51]
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT RelatedClientID, MasterClientID, MasterCompany, ChildClie' +
        'ntID, ChildCompany  '
      'FROM tblrelatedclients'
      'Where MasterClientID=:ID'
      'Order by ChildCompany')
    AfterInsert = qryRelatedClientsAfterInsert
    BeforePost = qryRelatedClientsBeforePost
    Left = 622
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object qryRelatedClientsRelatedClientID: TAutoIncField
      FieldName = 'RelatedClientID'
      ReadOnly = True
    end
    object qryRelatedClientsMasterClientID: TIntegerField
      FieldName = 'MasterClientID'
    end
    object qryRelatedClientsMasterCompany: TWideStringField
      FieldName = 'MasterCompany'
      Size = 80
    end
    object qryRelatedClientsChildClientID: TIntegerField
      FieldName = 'ChildClientID'
    end
    object qryRelatedClientsChildCompany: TWideStringField
      FieldName = 'ChildCompany'
      OnChange = qryRelatedClientsChildCompanyChange
      Size = 80
    end
  end
  object DSRelatedClients: TDataSource [52]
    DataSet = qryRelatedClients
    Left = 600
    Top = 33
  end
  object cboClientLookup: TERPQuery [53]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'C.ClientID as ClientID,'
      'C.Company as Company'
      'FROM tblclients C'
      'LEFT JOIN tblrelatedclients RC on RC.ChildClientID=C.ClientID'
      'WHERE C.Active = '#39'T'#39
      
        'And C.Customer = '#39'T'#39' AND IsJob = '#39'F'#39' AND IsNull(RC.ChildClientID' +
        ')'
      'And C.ClientID<>:ID'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (C.Company LIKE Concat(:SearchValue,"%' +
        '")))'
      
        'or ((:SearchMode = 2) and (C.Company LIKE Concat("%",:SearchValu' +
        'e,"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'Order By Company;')
    Options.LongStrings = False
    Left = 361
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
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
    object cboClientLookupClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object cboClientLookupCompany: TWideStringField
      FieldName = 'Company'
      Size = 160
    end
  end
  inherited tmrdelayMsg: TTimer
    Left = 738
    Top = 64
  end
  object qryBankCodes: TERPQuery [55]
    Connection = MyConnection
    SQL.Strings = (
      'Select CodeID,BankCode,BankName'
      'FROM tblBankCodes '
      'where (RegionId = :XRegionID) or (BankCode = :BankCode)'
      'Order by BankCode;')
    BeforeOpen = qryBankCodesBeforeOpen
    Options.LongStrings = False
    Left = 37
    Top = 65
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
  object qryForeignCurrency: TERPQuery [56]
    SQL.Strings = (
      'SELECT CurrencyID, Country, Currency, Code, BuyRate, Active  '
      'FROM tblcurrencyconversion'
      'Where active = '#39'T'#39' ')
    Options.LongStrings = False
    Left = 246
    Top = 33
  end
  object qryDeliveryTemplates: TERPQuery [57]
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TemplID, TemplName'
      'FROM tbltemplates'
      'WHERE TypeID = '#39'29'#39';')
    Options.LongStrings = False
    Left = 175
    Top = 33
  end
  object qryOpeningPoints: TERPQuery [58]
    Connection = MyConnection
    SQL.Strings = (
      
        'select * from tblsaleslinespoints where IsOpeningBalance = "T" a' +
        'nd clientID = :cusId')
    AfterOpen = qryOpeningPointsAfterOpen
    AfterInsert = qryOpeningPointsAfterInsert
    Left = 883
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cusId'
      end>
    object qryOpeningPointsGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object qryOpeningPointsSalesLinesPointsId: TIntegerField
      FieldName = 'SalesLinesPointsId'
    end
    object qryOpeningPointsLineValue: TFloatField
      FieldName = 'LineValue'
    end
    object qryOpeningPointsPointExpiresOn: TDateField
      FieldName = 'PointExpiresOn'
    end
    object qryOpeningPointsExpiresOnNoOfMonthsAfterPurchase: TIntegerField
      FieldName = 'ExpiresOnNoOfMonthsAfterPurchase'
    end
    object qryOpeningPointsPointsUOMID: TIntegerField
      FieldName = 'PointsUOMID'
    end
    object qryOpeningPointsPointsUOMMultiplier: TFloatField
      FieldName = 'PointsUOMMultiplier'
    end
    object qryOpeningPointsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryOpeningPointsclientID: TIntegerField
      FieldName = 'clientID'
    end
    object qryOpeningPointsRewardPointID: TIntegerField
      FieldName = 'RewardPointID'
    end
    object qryOpeningPointsValueforRewardPoint: TFloatField
      FieldName = 'ValueforRewardPoint'
    end
    object qryOpeningPointsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryOpeningPointsIsOpeningBalance: TWideStringField
      FieldName = 'IsOpeningBalance'
      FixedChar = True
      Size = 1
    end
    object qryOpeningPointsOpeningBalanceAsOn: TDateField
      FieldName = 'OpeningBalanceAsOn'
    end
    object qryOpeningPointsDeptID: TLargeintField
      FieldName = 'DeptID'
    end
    object qryOpeningPointsDeptname: TWideStringField
      FieldName = 'Deptname'
      Size = 100
    end
    object qryOpeningPointsSaleID: TIntegerField
      FieldName = 'SaleID'
    end
    object qryOpeningPointsSaleLineID: TIntegerField
      FieldName = 'SaleLineID'
    end
    object qryOpeningPointsProductID: TIntegerField
      FieldName = 'ProductID'
    end
    object qryOpeningPointsProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 100
    end
    object qryOpeningPointsLinePoints: TFloatField
      FieldName = 'LinePoints'
      OnSetText = FeldSetTextDontAllowNulls
    end
  end
  object dsOpeningPoints: TDataSource [59]
    DataSet = qryOpeningPoints
    OnStateChange = dsStateChange
    Left = 883
    Top = 33
  end
  object QrySalesRedeemedPoints: TERPQuery [60]
    Connection = MyConnection
    SQL.Strings = (
      'select UsedPoints'
      
        'from tblsalesredeempoints Where SalesLinesPointsId = :SalesPoint' +
        'ID')
    AfterOpen = QrySalesRedeemedPointsAfterOpen
    Left = 915
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SalesPointID'
      end>
    object QrySalesRedeemedPointsUsedPoints: TFloatField
      FieldName = 'UsedPoints'
    end
  end
  object dsSalesRedeemedPoints: TDataSource [61]
    DataSet = QrySalesRedeemedPoints
    OnStateChange = dsStateChange
    Left = 915
    Top = 33
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 165
    Top = 1
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 35
    Top = 1
  end
  inherited MyConnection: TERPConnection
    Database = 'sample_company'
    Server = 'localhost'
    Connected = True
    Left = 2
    Top = 65535
  end
  inherited DataState: TDataState
    Left = 296
    Top = 1
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 132
    Top = 1
  end
  inherited imgsort: TImageList
    Left = 68
    Top = 1
    Bitmap = {
      494C010100008001400410001000FFFFFFFFFF00FFFFFFFFFFFFFFFF424D3600
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
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000}
  end
  inherited QryCustomField: TERPQuery
    Left = 145
    Top = 65
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 615
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 574
  end
  inherited qryMemTrans: TERPQuery
    Left = 109
    Top = 65
  end
  object QryShippingAgent: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblshippingagent')
    BeforeOpen = qrySuburbBeforeOpen
    Options.LongStrings = False
    Left = 181
    Top = 65
    object QryShippingAgentCode: TWideStringField
      DisplayWidth = 10
      FieldName = 'Code'
      Origin = 'tblshippingagent.Code'
      Size = 10
    end
    object QryShippingAgentDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tblshippingagent.Description'
      Size = 100
    end
    object QryShippingAgentSupplierName: TWideStringField
      DisplayLabel = 'Supplier'
      DisplayWidth = 20
      FieldName = 'SupplierName'
      Origin = 'tblshippingagent.SupplierName'
      Size = 100
    end
    object QryShippingAgentShippingAgentID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ShippingAgentID'
      Origin = 'tblshippingagent.ShippingAgentID'
      Visible = False
    end
    object QryShippingAgentSupplierId: TLargeintField
      FieldName = 'SupplierId'
      Origin = 'tblshippingagent.SupplierId'
      Visible = False
    end
    object QryShippingAgentActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblshippingagent.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryShippingAgentInsurance: TWideStringField
      FieldName = 'Insurance'
      Origin = 'tblshippingagent.Insurance'
      Size = 255
    end
  end
  object WordApplication1: TWordApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 263
    Top = 1
  end
  object QrystatementTemplates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TemplID, TemplName'
      'FROM tbltemplates'
      'WHERE TypeID = 44;')
    Options.LongStrings = False
    Left = 518
    Top = 1
  end
  object QryAreaCodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 289
    Top = 65
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
  object qryTaxExceptionProducts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblclientTaxExceptionProducts'
      'WHERE ClientID=:xClientID')
    AfterInsert = qryTaxExceptionProductsAfterInsert
    BeforePost = qryTaxExceptionProductsBeforePost
    Left = 555
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryTaxExceptionProductsProductName: TWideStringField
      DisplayWidth = 23
      FieldName = 'ProductName'
      Origin = 'tblclienttaxexceptionproducts.ProductName'
      OnChange = qryTaxExceptionProductsProductNameChange
      Size = 100
    end
    object qryTaxExceptionProductsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblclienttaxexceptionproducts.Active'
      FixedChar = True
      Size = 1
    end
    object qryTaxExceptionProductsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblclienttaxexceptionproducts.ID'
      Visible = False
    end
    object qryTaxExceptionProductsglobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'globalref'
      Origin = 'tblclienttaxexceptionproducts.globalref'
      Visible = False
      Size = 255
    end
    object qryTaxExceptionProductsClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tblclienttaxexceptionproducts.ClientID'
      Visible = False
    end
    object qryTaxExceptionProductsClientName: TWideStringField
      DisplayWidth = 100
      FieldName = 'ClientName'
      Origin = 'tblclienttaxexceptionproducts.ClientName'
      Visible = False
      Size = 100
    end
    object qryTaxExceptionProductsProductId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductId'
      Origin = 'tblclienttaxexceptionproducts.ProductId'
      Visible = False
    end
    object qryTaxExceptionProductsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblclienttaxexceptionproducts.msTimeStamp'
      Visible = False
    end
    object qryTaxExceptionProductsmsUpdatesitecode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdatesitecode'
      Origin = 'tblclienttaxexceptionproducts.msUpdatesitecode'
      Visible = False
      Size = 3
    end
  end
  object dsTaxExceptionProducts: TDataSource
    DataSet = qryTaxExceptionProducts
    Left = 555
    Top = 25
  end
  object QryProduct: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PARTSID,PARTTYPE, PRODUCTGROUP, PARTNAME,'
      ' PARTSDESCRIPTION,  INCOMEACCNT,'
      ' ASSETACCNT, COGSACCNT, BARCODE, PRODUCTCODE, '
      'TAXCODE,   '
      'SpecialDiscount, SNTracking,  BuyQTY1, BuyQTY2,'
      ' BuyQTY3, COST1, COST2, COST3, SellQTY1, SellQTY2, SellQTY3,'
      ' PRICE1, PRICE2, PRICE3, WHOLESALEPRICE, Active, EditedFlag  '
      'FROM tblparts WHERE Active = '#39'T'#39
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((PartName LIKE Concat(:SearchValue,"%' +
        '")) or (PARTSDESCRIPTION LIKE Concat(:SearchValue,"%"))) )'
      
        'or ((:SearchMode = 2) and ((PartName LIKE Concat("%",:SearchValu' +
        'e,"%")) or (PARTSDESCRIPTION LIKE Concat("%",:SearchValue,"%")))' +
        ' ))'
      'and IfNull(:SearchValue,"") <> ""'
      'order by PartName')
    FilterOptions = [foCaseInsensitive]
    AfterOpen = QryProductAfterOpen
    Options.LongStrings = False
    Left = 505
    Top = 65
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
      end>
    object QryProductPARTSID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PARTSID'
      Origin = 'tblparts.PARTSID'
    end
    object QryProductPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Origin = 'tblparts.PARTNAME'
      Size = 60
    end
    object QryProductPARTTYPE: TWideStringField
      FieldName = 'PARTTYPE'
      Origin = 'tblparts.PARTTYPE'
      Size = 13
    end
    object QryProductPRODUCTGROUP: TWideStringField
      FieldName = 'PRODUCTGROUP'
      Origin = 'tblparts.PRODUCTGROUP'
      Size = 255
    end
    object QryProductPARTSDESCRIPTION: TWideStringField
      FieldName = 'PARTSDESCRIPTION'
      Origin = 'tblparts.PARTSDESCRIPTION'
      Size = 255
    end
    object QryProductINCOMEACCNT: TWideStringField
      FieldName = 'INCOMEACCNT'
      Origin = 'tblparts.INCOMEACCNT'
      Size = 50
    end
    object QryProductASSETACCNT: TWideStringField
      FieldName = 'ASSETACCNT'
      Origin = 'tblparts.ASSETACCNT'
      Size = 50
    end
    object QryProductCOGSACCNT: TWideStringField
      FieldName = 'COGSACCNT'
      Origin = 'tblparts.COGSACCNT'
      Size = 50
    end
    object QryProductBARCODE: TWideStringField
      FieldName = 'BARCODE'
      Origin = 'tblparts.BARCODE'
      Size = 35
    end
    object QryProductPRODUCTCODE: TWideStringField
      FieldName = 'PRODUCTCODE'
      Origin = 'tblparts.PRODUCTCODE'
      Size = 255
    end
    object QryProductTAXCODE: TWideStringField
      FieldName = 'TAXCODE'
      Origin = 'tblparts.TAXCODE'
      Size = 15
    end
    object QryProductSpecialDiscount: TWideStringField
      FieldName = 'SpecialDiscount'
      Origin = 'tblparts.SpecialDiscount'
      FixedChar = True
      Size = 1
    end
    object QryProductSNTracking: TWideStringField
      FieldName = 'SNTracking'
      Origin = 'tblparts.SNTracking'
      FixedChar = True
      Size = 1
    end
    object QryProductBuyQTY1: TIntegerField
      FieldName = 'BuyQTY1'
      Origin = 'tblparts.BuyQTY1'
    end
    object QryProductBuyQTY2: TIntegerField
      FieldName = 'BuyQTY2'
      Origin = 'tblparts.BuyQTY2'
    end
    object QryProductBuyQTY3: TIntegerField
      FieldName = 'BuyQTY3'
      Origin = 'tblparts.BuyQTY3'
    end
    object QryProductCOST1: TFloatField
      FieldName = 'COST1'
      Origin = 'tblparts.COST1'
    end
    object QryProductCOST2: TFloatField
      FieldName = 'COST2'
      Origin = 'tblparts.COST2'
    end
    object QryProductCOST3: TFloatField
      FieldName = 'COST3'
      Origin = 'tblparts.COST3'
    end
    object QryProductSellQTY1: TIntegerField
      FieldName = 'SellQTY1'
      Origin = 'tblparts.SellQTY1'
    end
    object QryProductSellQTY2: TIntegerField
      FieldName = 'SellQTY2'
      Origin = 'tblparts.SellQTY2'
    end
    object QryProductSellQTY3: TIntegerField
      FieldName = 'SellQTY3'
      Origin = 'tblparts.SellQTY3'
    end
    object QryProductPRICE1: TFloatField
      FieldName = 'PRICE1'
      Origin = 'tblparts.PRICE1'
    end
    object QryProductPRICE2: TFloatField
      FieldName = 'PRICE2'
      Origin = 'tblparts.PRICE2'
    end
    object QryProductPRICE3: TFloatField
      FieldName = 'PRICE3'
      Origin = 'tblparts.PRICE3'
    end
    object QryProductWHOLESALEPRICE: TFloatField
      FieldName = 'WHOLESALEPRICE'
      Origin = 'tblparts.WHOLESALEPRICE'
    end
    object QryProductActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblparts.Active'
      FixedChar = True
      Size = 1
    end
    object QryProductEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblparts.EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
  object Qryclients_eParcel: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblclients_eParcel'
      'WHERE ClientID = :CusID;')
    AfterInsert = Qryclients_eParcelAfterInsert
    Left = 944
    Top = 1
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object Qryclients_eParcelGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblclients_eparcel.GlobalRef'
      Size = 255
    end
    object Qryclients_eParcelID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblclients_eparcel.ID'
    end
    object Qryclients_eParcelClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblclients_eparcel.ClientID'
    end
    object Qryclients_eParceleParcelreference1: TWideStringField
      FieldName = 'eParcelreference1'
      Origin = 'tblclients_eparcel.eParcelreference1'
      Size = 100
    end
    object Qryclients_eParceleParcelreference2: TWideStringField
      FieldName = 'eParcelreference2'
      Origin = 'tblclients_eparcel.eParcelreference2'
      Size = 100
    end
    object Qryclients_eParcelPrinteParcelreference1: TWideStringField
      FieldName = 'PrinteParcelreference1'
      Origin = 'tblclients_eparcel.PrinteParcelreference1'
      FixedChar = True
      Size = 1
    end
    object Qryclients_eParcelPrinteParcelreference2: TWideStringField
      FieldName = 'PrinteParcelreference2'
      Origin = 'tblclients_eparcel.PrinteParcelreference2'
      FixedChar = True
      Size = 1
    end
    object Qryclients_eParcelReturn_Company: TWideStringField
      FieldName = 'Return_Company'
      Origin = 'tblclients_eparcel.Return_Company'
      Size = 160
    end
    object Qryclients_eParcelReturn_Name: TWideStringField
      FieldName = 'Return_Name'
      Origin = 'tblclients_eparcel.Return_Name'
      Size = 40
    end
    object Qryclients_eParcelReturn_Street1: TWideStringField
      FieldName = 'Return_Street1'
      Origin = 'tblclients_eparcel.Return_Street1'
      Size = 255
    end
    object Qryclients_eParcelReturn_Street2: TWideStringField
      FieldName = 'Return_Street2'
      Origin = 'tblclients_eparcel.Return_Street2'
      Size = 255
    end
    object Qryclients_eParcelReturn_Street3: TWideStringField
      FieldName = 'Return_Street3'
      Origin = 'tblclients_eparcel.Return_Street3'
      Size = 255
    end
    object Qryclients_eParcelReturn_Suburb: TWideStringField
      FieldName = 'Return_Suburb'
      Origin = 'tblclients_eparcel.Return_Suburb'
      Size = 255
    end
    object Qryclients_eParcelReturn_State: TWideStringField
      FieldName = 'Return_State'
      Origin = 'tblclients_eparcel.Return_State'
      Size = 255
    end
    object Qryclients_eParcelReturn_Country: TWideStringField
      FieldName = 'Return_Country'
      Origin = 'tblclients_eparcel.Return_Country'
      Size = 255
    end
    object Qryclients_eParcelReturn_Postcode: TWideStringField
      FieldName = 'Return_Postcode'
      Origin = 'tblclients_eparcel.Return_Postcode'
      Size = 255
    end
    object Qryclients_eParcelReDir_Company: TWideStringField
      FieldName = 'ReDir_Company'
      Origin = 'tblclients_eparcel.ReDir_Company'
      Size = 160
    end
    object Qryclients_eParcelReDir_Name: TWideStringField
      FieldName = 'ReDir_Name'
      Origin = 'tblclients_eparcel.ReDir_Name'
      Size = 40
    end
    object Qryclients_eParcelReDir_Street1: TWideStringField
      FieldName = 'ReDir_Street1'
      Origin = 'tblclients_eparcel.ReDir_Street1'
      Size = 255
    end
    object Qryclients_eParcelReDir_Street2: TWideStringField
      FieldName = 'ReDir_Street2'
      Origin = 'tblclients_eparcel.ReDir_Street2'
      Size = 255
    end
    object Qryclients_eParcelReDir_Street3: TWideStringField
      FieldName = 'ReDir_Street3'
      Origin = 'tblclients_eparcel.ReDir_Street3'
      Size = 255
    end
    object Qryclients_eParcelReDir_Suburb: TWideStringField
      FieldName = 'ReDir_Suburb'
      Origin = 'tblclients_eparcel.ReDir_Suburb'
      Size = 255
    end
    object Qryclients_eParcelReDir_State: TWideStringField
      FieldName = 'ReDir_State'
      Origin = 'tblclients_eparcel.ReDir_State'
      Size = 255
    end
    object Qryclients_eParcelReDir_Country: TWideStringField
      FieldName = 'ReDir_Country'
      Origin = 'tblclients_eparcel.ReDir_Country'
      Size = 255
    end
    object Qryclients_eParcelReDir_Postcode: TWideStringField
      FieldName = 'ReDir_Postcode'
      Origin = 'tblclients_eparcel.ReDir_Postcode'
      Size = 255
    end
    object Qryclients_eParcelEmailNotification: TWideStringField
      FieldName = 'EmailNotification'
      Origin = 'tblclients_eparcel.EmailNotification'
      FixedChar = True
      Size = 8
    end
    object Qryclients_eParcelconsigneePhoneonLabel: TWideStringField
      FieldName = 'consigneePhoneonLabel'
      FixedChar = True
      Size = 1
    end
    object Qryclients_eParcelLeaveAtAddress: TWideStringField
      FieldName = 'LeaveAtAddress'
      FixedChar = True
      Size = 1
    end
    object Qryclients_eParcelSignatureReqd: TWideStringField
      FieldName = 'SignatureReqd'
      FixedChar = True
      Size = 1
    end
    object Qryclients_eParcelExtraDeliveryInstructions: TWideStringField
      FieldName = 'ExtraDeliveryInstructions'
      Size = 255
    end
    object Qryclients_eParcelChargeBackAcntID: TIntegerField
      FieldName = 'ChargeBackAcntID'
    end
    object Qryclients_eParcelChargeBackAcnt: TWideStringField
      FieldName = 'ChargeBackAcnt'
      Size = 100
    end
  end
  object dsclients_eParcel: TDataSource
    DataSet = Qryclients_eParcel
    OnStateChange = dsStateChange
    Left = 949
    Top = 33
  end
  object cboAccountQry: TERPQuery
    SQL.Strings = (
      'SELECT AccountID, AccountName'
      'FROM tblchartofaccounts'
      'WHERE IsHeader = '#39'F'#39)
    Options.LongStrings = False
    Left = 397
    Top = 65
  end
  object QryShippingAddressmain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select * from tblshippingaddress where Customer_ID = :KeyId and ' +
        'CustomerPhysicalAddress="T"')
    BeforeOpen = QryShippingAddressmainBeforeOpen
    AfterPost = QryShippingAddressmainAfterPost
    BeforeScroll = QryShippingAddressmainBeforeScroll
    Left = 469
    Top = 65
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyId'
      end>
    object QryShippingAddressmainGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QryShippingAddressmainShipAddressID: TIntegerField
      FieldName = 'ShipAddressID'
    end
    object QryShippingAddressmainCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 255
    end
    object QryShippingAddressmainCustomer_ID: TIntegerField
      FieldName = 'Customer_ID'
    end
    object QryShippingAddressmainContactName: TWideStringField
      FieldName = 'ContactName'
      Size = 255
    end
    object QryShippingAddressmainShipAddress: TWideStringField
      FieldName = 'ShipAddress'
      Size = 255
    end
    object QryShippingAddressmainShipAddress1: TWideStringField
      FieldName = 'ShipAddress1'
      Size = 255
    end
    object QryShippingAddressmainShipCity: TWideStringField
      FieldName = 'ShipCity'
      Size = 255
    end
    object QryShippingAddressmainShipPostCode: TWideStringField
      FieldName = 'ShipPostCode'
      Size = 255
    end
    object QryShippingAddressmainShipState: TWideStringField
      FieldName = 'ShipState'
      Size = 255
    end
    object QryShippingAddressmainShipCountry: TWideStringField
      FieldName = 'ShipCountry'
      Size = 255
    end
    object QryShippingAddressmainEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object QryShippingAddressmainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QryShippingAddressmainShipAddress2: TWideStringField
      FieldName = 'ShipAddress2'
      Size = 255
    end
    object QryShippingAddressmainActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QryShippingAddressmainPortOfLanding: TWideStringField
      FieldName = 'PortOfLanding'
      Size = 100
    end
    object QryShippingAddressmainPortOfDischarge: TWideStringField
      FieldName = 'PortOfDischarge'
      Size = 100
    end
    object QryShippingAddressmainFinalDestination: TWideStringField
      FieldName = 'FinalDestination'
      Size = 100
    end
    object QryShippingAddressmainIncoPlace: TWideStringField
      FieldName = 'IncoPlace'
      Size = 100
    end
    object QryShippingAddressmainPhone: TWideStringField
      FieldName = 'Phone'
    end
    object QryShippingAddressmainmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object QryShippingAddressmainemail: TWideStringField
      FieldName = 'email'
      Size = 255
    end
    object QryShippingAddressmainCustomerPhysicalAddress: TWideStringField
      FieldName = 'CustomerPhysicalAddress'
      FixedChar = True
      Size = 1
    end
    object QryShippingAddressmainAddressValidated: TWideStringField
      FieldName = 'AddressValidated'
      FixedChar = True
      Size = 1
    end
  end
  object qryClientToShipAddressLink: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select * from tblClientToShipAddressLink where clientID = :KeyId' +
        ' and shipAddressID = :shipAddressID')
    BeforeOpen = qryClientToShipAddressLinkBeforeOpen
    Left = 361
    Top = 65
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyId'
      end
      item
        DataType = ftUnknown
        Name = 'shipAddressID'
      end>
    object qryClientToShipAddressLinkGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryClientToShipAddressLinkID: TIntegerField
      FieldName = 'ID'
    end
    object qryClientToShipAddressLinkClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryClientToShipAddressLinkShipAddressID: TIntegerField
      FieldName = 'ShipAddressID'
    end
    object qryClientToShipAddressLinkEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryClientToShipAddressLinkmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryClientToShipAddressLinkmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object QrycustomerShipAddresslist: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblShippingAddress.ShipAddressId, Customer_ID,'
      '       CompanyName as "Company Name",'
      '       ContactName as ContactName,'
      '       ShipAddress as "Address",'
      '       ShipAddress1 as "Address 2",'
      '       ShipAddress2 as "Address 3",'
      '       ShipCity as "City",'
      '       ShipPostCode as "PostCode",'
      '       ShipState as "State",'
      '       ShipCountry as "Country",'
      '       PortOfLanding as PortOfLanding,'
      '       PortOfDischarge as PortOfDischarge,'
      '       FinalDestination as FinalDestination,'
      '       IncoPlace as IncoPlace,'
      '       tblClientToShipAddressLink.ClientID,'
      '       Active as Active,'
      'CustomerPhysicalAddress'
      'FROM tblShippingAddress'
      'INNER JOIN tblClientToShipAddressLink ON'
      
        '  tblClientToShipAddressLink.ShipAddressID = tblShippingAddress.' +
        'ShipAddressID'
      'where (tblShippingAddress.Customer_ID = :KeyID )')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    BeforeOpen = QrycustomerShipAddresslistBeforeOpen
    Left = 975
    Top = 65535
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object QrycustomerShipAddresslistContactName: TWideStringField
      DisplayLabel = 'Contact Name'
      DisplayWidth = 10
      FieldName = 'ContactName'
      Origin = 'tblshippingaddress.ContactName'
      Size = 255
    end
    object QrycustomerShipAddresslistAddress: TWideStringField
      DisplayWidth = 20
      FieldName = 'Address'
      Origin = 'tblshippingaddress.ShipAddress'
      Size = 255
    end
    object QrycustomerShipAddresslistAddress2: TWideStringField
      DisplayWidth = 20
      FieldName = 'Address 2'
      Origin = 'tblshippingaddress.ShipAddress1'
      Size = 255
    end
    object QrycustomerShipAddresslistAddress3: TWideStringField
      DisplayWidth = 20
      FieldName = 'Address 3'
      Origin = 'tblshippingaddress.ShipAddress2'
      Size = 255
    end
    object QrycustomerShipAddresslistCity: TWideStringField
      DisplayWidth = 10
      FieldName = 'City'
      Origin = 'tblshippingaddress.ShipCity'
      Size = 255
    end
    object QrycustomerShipAddresslistPostCode: TWideStringField
      DisplayWidth = 10
      FieldName = 'PostCode'
      Origin = 'tblshippingaddress.ShipPostCode'
      Size = 255
    end
    object QrycustomerShipAddresslistState: TWideStringField
      DisplayWidth = 10
      FieldName = 'State'
      Origin = 'tblshippingaddress.ShipState'
      Size = 255
    end
    object QrycustomerShipAddresslistCountry: TWideStringField
      DisplayWidth = 10
      FieldName = 'Country'
      Origin = 'tblshippingaddress.ShipCountry'
      Size = 255
    end
    object QrycustomerShipAddresslistActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblshippingaddress.Active'
      FixedChar = True
      Size = 1
    end
    object QrycustomerShipAddresslistPortOfLanding: TWideStringField
      DisplayLabel = 'Landing Port'
      DisplayWidth = 10
      FieldName = 'PortOfLanding'
      Origin = 'tblshippingaddress.PortOfLanding'
      Size = 100
    end
    object QrycustomerShipAddresslistPortOfDischarge: TWideStringField
      DisplayLabel = 'Discharge Port'
      DisplayWidth = 10
      FieldName = 'PortOfDischarge'
      Origin = 'tblshippingaddress.PortOfDischarge'
      Size = 100
    end
    object QrycustomerShipAddresslistFinalDestination: TWideStringField
      DisplayLabel = 'Final Destination'
      DisplayWidth = 10
      FieldName = 'FinalDestination'
      Origin = 'tblshippingaddress.FinalDestination'
      Size = 100
    end
    object QrycustomerShipAddresslistIncoPlace: TWideStringField
      DisplayLabel = 'Inco Place'
      DisplayWidth = 10
      FieldName = 'IncoPlace'
      Origin = 'tblshippingaddress.IncoPlace'
      Size = 100
    end
    object QrycustomerShipAddresslistCompanyName: TWideStringField
      DisplayWidth = 20
      FieldName = 'Company Name'
      Origin = 'tblshippingaddress.CompanyName'
      Visible = False
      Size = 255
    end
    object QrycustomerShipAddresslistShipAddressId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ShipAddressId'
      Origin = 'tblshippingaddress.ShipAddressID'
      Visible = False
    end
    object QrycustomerShipAddresslistShipAddressIdAlreadySelected: TStringField
      FieldKind = fkCalculated
      FieldName = 'ShipAddressIdAlreadySelected'
      Visible = False
      Size = 1
      Calculated = True
    end
    object QrycustomerShipAddresslistCustomerPhysicalAddress: TWideStringField
      FieldName = 'CustomerPhysicalAddress'
      Origin = 'tblshippingaddress.CustomerPhysicalAddress'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QrycustomerShipAddresslistCustomer_ID: TIntegerField
      FieldName = 'Customer_ID'
    end
    object QrycustomerShipAddresslistClientID: TIntegerField
      FieldName = 'ClientID'
    end
  end
  object dscustomerShipAddresslist: TDataSource
    DataSet = QrycustomerShipAddresslist
    Left = 971
    Top = 34
  end
  object QryCreditcardtypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT PayMethodID, Name FROM tblpaymentmethods where IsCreditCa' +
        'rd  ="T" and Active ="T"'
      'Order by name')
    Options.LongStrings = False
    Left = 496
    Top = 33
  end
  object QryARAccounts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT AccountID, AccountName'
      'FROM tblchartofaccounts'
      'WHERE AccountType = '#39'AR'#39' and Active='#39'T'#39' and IsHeader = '#39'F'#39)
    Options.LongStrings = False
    Left = 542
    Top = 65
    object QryARAccountsAccountID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'AccountID'
      Origin = 'tblchartofaccounts.AccountID'
    end
    object QryARAccountsAccountName: TWideStringField
      FieldName = 'AccountName'
      Origin = 'tblchartofaccounts.AccountName'
      Size = 50
    end
  end
  object qrySalesOrderTemplate: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT TemplID,TemplName FROM `tbltemplates`  WHERE `TypeID` = '#39 +
        '25'#39';')
    Options.LongStrings = False
    Left = 325
    Top = 65
  end
  object qryContactNames: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select'
      
        'CONCAT(IFNULL(T.ContactTitle, ""), " ", IFNULL(T.ContactFirstNam' +
        'e, ""), " ", IFNULL(T.ContactSurname, "")) as ContactName,'
      'ContactId'
      'from tblContacts T'
      'where ClientId=:ClientId'
      'AND Active="T"')
    BeforeOpen = qryContactNamesBeforeOpen
    AfterOpen = qryContactsAfterOpen
    Left = 253
    Top = 65
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientId'
      end>
    object qryContactNamesContactName: TWideStringField
      FieldName = 'ContactName'
      Origin = 'ContactName'
      Size = 94
    end
    object qryContactNamesContactId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ContactId'
      Origin = 'T.ContactID'
    end
  end
  object dsContactSelector: TDataSource
    DataSet = qryContactSelector
    Left = 524
    Top = 33
  end
  object qryContactSelector: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '/*select "All" as ContactName,'
      ' -1 as ContactId'
      'union all'
      '*/'
      'select '
      
        'CONCAT(IFNULL(T.ContactTitle, ""), " ", IFNULL(T.ContactFirstNam' +
        'e, ""), " ", IFNULL(T.ContactSurname, "")) as ContactName,'
      'ContactId'
      'from tblContacts T'
      'where ClientId=:xClientId'
      'and Active = "T";')
    BeforeOpen = qryContactSelectorBeforeOpen
    Left = 217
    Top = 65
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientId'
      end>
    object qryContactSelectorContactName: TWideStringField
      FieldName = 'ContactName'
      Size = 94
    end
    object qryContactSelectorContactId: TIntegerField
      FieldName = 'ContactId'
    end
  end
  object QryUOM: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, U.Pa' +
        'rtID'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :KeyId'
      'union all '
      'SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, U.Pa' +
        'rtID'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :KeyId  )'
      'Order By UnitID desc ,UnitName;')
    Options.LongStrings = False
    Left = 861
    Top = 65
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end
      item
        DataType = ftUnknown
        Name = 'KeyId'
      end>
    object QryUOMUnitname: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 15
      FieldName = 'Unitname'
      Origin = '.UnitName'
      Size = 15
    end
    object QryUOMmultiplier: TFloatField
      DisplayLabel = 'Multiplier'
      DisplayWidth = 10
      FieldName = 'multiplier'
      Origin = '.Multiplier'
    end
    object QryUOMUnitId: TIntegerField
      FieldName = 'UnitId'
      Origin = '.UnitID'
      Visible = False
    end
    object QryUOMPartID: TIntegerField
      FieldName = 'PartID'
      Origin = '.PartID'
      Visible = False
    end
  end
  object qryCustomershippingoptions: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblCustomershippingoptions'
      'WHERE CustomerID=:xClientID')
    AfterInsert = qryCustomershippingoptionsAfterInsert
    AfterPost = qryCustomershippingoptionsAfterPost
    AfterScroll = qryCustomershippingoptionsAfterScroll
    Left = 891
    Top = 65
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClientID'
      end>
    object qryCustomershippingoptionsShipperType: TWideStringField
      DisplayLabel = 'Provider'
      DisplayWidth = 35
      FieldName = 'ShipperType'
      Origin = 'tblcustomershippingoptions.ShipperType'
      Size = 50
    end
    object qryCustomershippingoptionsPayorType: TWideStringField
      DisplayLabel = 'Payor Type'
      DisplayWidth = 30
      FieldName = 'PayorType'
      Origin = 'tblcustomershippingoptions.PayorType'
      Size = 50
    end
    object qryCustomershippingoptionsAccountNumber: TWideStringField
      DisplayLabel = 'Account Number'
      DisplayWidth = 27
      FieldName = 'AccountNumber'
      Origin = 'tblcustomershippingoptions.AccountNumber'
      Size = 50
    end
    object qryCustomershippingoptionsActive: TWideStringField
      DisplayLabel = 'Active ?'
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblcustomershippingoptions.Active'
      FixedChar = True
      Size = 1
    end
    object qryCustomershippingoptionsIsDefault: TWideStringField
      DisplayLabel = 'Is Default?'
      DisplayWidth = 1
      FieldName = 'IsDefault'
      OnChange = qryCustomershippingoptionsIsDefaultChange
      FixedChar = True
      Size = 1
    end
    object qryCustomershippingoptionsPackageProvider: TWideStringField
      DisplayLabel = 'Package Provider'
      DisplayWidth = 25
      FieldName = 'PackageProvider'
      Origin = 'tblcustomershippingoptions.PackageProvider'
      Visible = False
      Size = 50
    end
    object qryCustomershippingoptionsGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblcustomershippingoptions.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryCustomershippingoptionsCustomerShipingOptionID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'CustomerShipingOptionID'
      Origin = 'tblcustomershippingoptions.CustomerShipingOptionID'
      Visible = False
    end
    object qryCustomershippingoptionsCustomerID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerID'
      Origin = 'tblcustomershippingoptions.CustomerID'
      Visible = False
    end
    object qryCustomershippingoptionsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblcustomershippingoptions.msTimeStamp'
      Visible = False
    end
    object qryCustomershippingoptionsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblcustomershippingoptions.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsCustomershippingoptions: TDataSource
    DataSet = qryCustomershippingoptions
    Left = 891
    Top = 89
  end
  object qryCoreEDIConfig: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblCoreEDIConfig')
    Left = 568
    Top = 88
  end
  object dsCoreEDIConfig: TDataSource
    DataSet = qryCoreEDIConfig
    Left = 576
    Top = 104
  end
  object MnuCreditCard: TAdvPopupMenu
    Version = '2.5.3.4'
    Left = 464
    Top = 456
    object RestoreFromTable1: TMenuItem
      Caption = 'Restore From Table'
      OnClick = RestoreFromTable1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Decrypt1: TMenuItem
      Caption = 'Decrypt'
      OnClick = Decrypt1Click
    end
    object Encrypt1: TMenuItem
      Caption = 'Encrypt'
      OnClick = Encrypt1Click
    end
  end
end
