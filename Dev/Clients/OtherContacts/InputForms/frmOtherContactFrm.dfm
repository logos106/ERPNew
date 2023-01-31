inherited frmOtherContact: TfrmOtherContact
  Left = 367
  Top = 438
  HelpContext = 310000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Other Contact'
  ClientHeight = 486
  ClientWidth = 916
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  ExplicitLeft = 367
  ExplicitTop = 438
  ExplicitWidth = 932
  ExplicitHeight = 525
  DesignSize = (
    916
    486)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel6: TBevel [0]
    Left = 811
    Top = 322
    Width = 97
    Height = 45
    HelpContext = 310002
    Anchors = [akTop, akRight]
  end
  object Bevel4: TBevel [1]
    Left = 812
    Top = 272
    Width = 97
    Height = 45
    HelpContext = 310188
    Anchors = [akTop, akRight]
  end
  object Bevel1: TBevel [2]
    Left = 812
    Top = 371
    Width = 97
    Height = 99
    HelpContext = 310185
    Anchors = [akTop, akRight]
  end
  object Label36: TLabel [3]
    Left = 812
    Top = 276
    Width = 96
    Height = 15
    HelpContext = 310003
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Active'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label4: TLabel [4]
    Left = 820
    Top = 378
    Width = 85
    Height = 18
    HelpContext = 310004
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Convert To'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 486
    Width = 916
    HelpContext = 310167
    ExplicitTop = 486
    ExplicitWidth = 916
  end
  inherited imgGridWatermark: TImage
    Left = 219
    Top = 3
    HelpContext = 310001
    ExplicitLeft = 219
    ExplicitTop = 3
  end
  object Label14: TLabel [10]
    Left = 818
    Top = 327
    Width = 84
    Height = 14
    HelpContext = 310189
    Alignment = taCenter
    Anchors = [akTop, akRight]
    AutoSize = False
    Caption = 'Don'#39't Contact'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object txtCompany: TDBMemo [11]
    Left = 91
    Top = 50
    Width = 633
    Height = 25
    HelpContext = 310009
    TabStop = False
    Alignment = taCenter
    DataField = 'Company'
    DataSource = frmCustomerSrc
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object cmdOk: TDNMSpeedButton [12]
    Left = 818
    Top = 82
    Width = 87
    Height = 27
    HelpContext = 310010
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
    TabOrder = 4
    AutoDisableParentOnclick = True
    OnClick = cmdOkClick
  end
  object cmdCancel: TDNMSpeedButton [13]
    Left = 818
    Top = 113
    Width = 87
    Height = 27
    HelpContext = 310011
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
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = cmdCancelClick
  end
  object btnSupplier: TDNMSpeedButton [14]
    Left = 817
    Top = 434
    Width = 87
    Height = 27
    Hint = '"Print This Customer"'
    HelpContext = 310012
    Anchors = [akTop, akRight]
    Caption = 'Su&pplier'
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
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = btnSupplierClick
  end
  object btnCustomer: TDNMSpeedButton [15]
    Left = 817
    Top = 399
    Width = 87
    Height = 27
    Hint = '"Add Shipping Addresses For This Customer"'
    HelpContext = 310013
    Anchors = [akTop, akRight]
    Caption = 'C&ustomer'
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
    OnClick = btnCustomerClick
  end
  object Customer: TDBCheckBox [16]
    Left = 20
    Top = 177
    Width = 17
    Height = 16
    HelpContext = 310014
    TabStop = False
    DataField = 'Customer'
    DataSource = frmCustomerSrc
    TabOrder = 10
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    Visible = False
  end
  object Supplier: TDBCheckBox [17]
    Left = 31
    Top = 154
    Width = 17
    Height = 16
    HelpContext = 310015
    TabStop = False
    DataField = 'Supplier'
    DataSource = frmCustomerSrc
    TabOrder = 11
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    Visible = False
  end
  object TabCtl20: TPageControl [18]
    Left = 9
    Top = 79
    Width = 797
    Height = 391
    HelpContext = 310016
    ActivePage = Customer_Info
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    RaggedRight = True
    TabHeight = 25
    TabOrder = 3
    TabWidth = 198
    OnChange = TabCtl20Change
    OnChanging = TabCtl20Changing
    object Customer_Info: TTabSheet
      HelpContext = 310017
      Caption = 'C&ontact Info'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 789
        Height = 331
        HelpContext = 310018
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
          789
          331)
        object Bevel3: TBevel
          Left = 624
          Top = 14
          Width = 164
          Height = 143
          HelpContext = 310019
        end
        object Bevel23: TBevel
          Left = 324
          Top = 163
          Width = 462
          Height = 157
          HelpContext = 310168
          Anchors = [akLeft, akTop, akBottom]
        end
        object Box70: TBevel
          Left = 324
          Top = 14
          Width = 294
          Height = 143
          HelpContext = 310186
        end
        object Box69: TBevel
          Left = 14
          Top = 14
          Width = 304
          Height = 306
          HelpContext = 310020
        end
        object lblCompany: TLabel
          Left = 57
          Top = 190
          Width = 53
          Height = 15
          HelpContext = 310021
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
          Left = 56
          Top = 91
          Width = 54
          Height = 15
          HelpContext = 310022
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
          Left = 49
          Top = 124
          Width = 61
          Height = 15
          HelpContext = 310023
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
          Left = 49
          Top = 157
          Width = 61
          Height = 15
          HelpContext = 310024
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
          Left = 345
          Top = 21
          Width = 84
          Height = 15
          HelpContext = 310025
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
          Left = 361
          Top = 49
          Width = 68
          Height = 15
          HelpContext = 310026
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
          Left = 344
          Top = 77
          Width = 85
          Height = 15
          HelpContext = 310027
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
          Left = 375
          Top = 105
          Width = 54
          Height = 15
          HelpContext = 310028
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
          Left = 55
          Top = 290
          Width = 55
          Height = 15
          HelpContext = 310032
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
          Left = 44
          Top = 223
          Width = 66
          Height = 18
          HelpContext = 310033
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
          Left = 28
          Top = 58
          Width = 82
          Height = 15
          HelpContext = 310034
          Alignment = taRightJustify
          Caption = 'Company Type'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblRelatedCust: TLabel
          Left = 331
          Top = 168
          Width = 109
          Height = 15
          HelpContext = 310169
          Caption = 'Related Customers'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label2: TLabel
          Left = 37
          Top = 256
          Width = 73
          Height = 15
          HelpContext = 310030
          Alignment = taRightJustify
          Caption = 'Contact Type'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label9: TLabel
          Left = 632
          Top = 29
          Width = 65
          Height = 15
          HelpContext = 310170
          Alignment = taRightJustify
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
        object Label3: TLabel
          Left = 632
          Top = 99
          Width = 132
          Height = 15
          HelpContext = 310171
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
        object Label43: TLabel
          Left = 334
          Top = 134
          Width = 95
          Height = 17
          HelpContext = 310191
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Prospect  Code'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblClientPrintNameHeading: TLabel
          Left = 45
          Top = 25
          Width = 63
          Height = 15
          HelpContext = 310193
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
        object grdRelatedClient: TwwDBGrid
          Left = 331
          Top = 187
          Width = 448
          Height = 127
          HelpContext = 310172
          ControlType.Strings = (
            'ChildCompany;CustomEdit;cboClient;F')
          Selected.Strings = (
            'ChildCompany'#9'42'#9'Company'#9'F')
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
          TabOrder = 17
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
            HelpContext = 310173
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
        object Company: TDBEdit
          Left = 118
          Top = 187
          Width = 190
          Height = 23
          HelpContext = 310035
          TabStop = False
          DataField = 'Company'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object Title: TDBEdit
          Left = 118
          Top = 88
          Width = 190
          Height = 23
          HelpContext = 310036
          DataField = 'Title'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object FirstName: TDBEdit
          Left = 118
          Top = 121
          Width = 190
          Height = 23
          HelpContext = 310037
          DataField = 'FirstName'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object LastName: TDBEdit
          Left = 118
          Top = 154
          Width = 190
          Height = 23
          HelpContext = 310038
          DataField = 'LastName'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object Phone: TwwDBEdit
          Left = 435
          Top = 17
          Width = 161
          Height = 23
          HelpContext = 310039
          DataField = 'Phone'
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
        object FaxNumber: TwwDBEdit
          Left = 435
          Top = 45
          Width = 161
          Height = 23
          HelpContext = 310040
          DataField = 'FaxNumber'
          DataSource = frmCustomerSrc
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
        object MOB: TwwDBEdit
          Left = 435
          Top = 74
          Width = 161
          Height = 23
          HelpContext = 310041
          DataField = 'Mobile'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object AltPhone: TwwDBEdit
          Left = 435
          Top = 102
          Width = 161
          Height = 23
          HelpContext = 310042
          DataField = 'AltPhone'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
        end
        object cboRep: TwwDBLookupCombo
          Left = 118
          Top = 286
          Width = 190
          Height = 23
          HelpContext = 310045
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
          LookupTable = qryEmp
          LookupField = 'EmployeeID'
          ParentFont = False
          TabOrder = 8
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnEnter = cboRepEnter
        end
        object JobTitle: TDBEdit
          Left = 118
          Top = 220
          Width = 190
          Height = 23
          HelpContext = 310047
          DataField = 'JobTitle'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object cboCompanyType: TwwDBLookupCombo
          Left = 118
          Top = 55
          Width = 190
          Height = 23
          HelpContext = 310048
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'CompanyTypeId'
          DataSource = frmCustomerSrc
          LookupTable = qryCompanyType
          LookupField = 'Id'
          ParentFont = False
          TabOrder = 1
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboCompanyTypeCloseUp
          OnEnter = cboCompanyTypeEnter
          OnNotInList = cboCompanyTypeNotInList
        end
        object btnOtherPhones: TDNMSpeedButton
          Left = 598
          Top = 17
          Width = 13
          Height = 23
          Hint = 'Other Phones'
          HelpContext = 310049
          Caption = '+'
          DisableTransparent = False
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          AutoDisableParentOnclick = True
          OnClick = btnOtherPhonesClick
        end
        object cboClient: TwwDBLookupCombo
          Left = 479
          Top = 243
          Width = 201
          Height = 23
          HelpContext = 310174
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
            'StopCreditImage'#9'1'#9'Stop Credit'#9'T')
          DataField = 'ChildCompany'
          DataSource = DSRelatedClients
          LookupTable = cboClientLookup
          LookupField = 'Company'
          Options = [loColLines, loTitles, loSearchOnBackspace]
          Style = csDropDownList
          ParentFont = False
          TabOrder = 16
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = cboClientCloseUp
          OnEnter = cboClientEnter
          OnNotInList = cboClientNotInList
        end
        object cboContactType: TwwDBLookupCombo
          Left = 118
          Top = 253
          Width = 190
          Height = 23
          HelpContext = 310044
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'OtherType'#9'30'#9'OtherType'#9'T')
          DataField = 'OtherContactType'
          DataSource = frmCustomerSrc
          LookupTable = qryContactType
          LookupField = 'OtherTypeID'
          ParentFont = False
          TabOrder = 7
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnEnter = cboContactTypeEnter
        end
        object wwDBComboBox1: TwwDBComboBox
          Left = 632
          Top = 47
          Width = 146
          Height = 23
          HelpContext = 310175
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
          TabOrder = 14
          UnboundDataType = wwDefault
          UnboundAlignment = taCenter
        end
        object cboDefaultContactMethod: TwwDBComboBox
          Left = 632
          Top = 120
          Width = 146
          Height = 23
          HelpContext = 310176
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
          TabOrder = 15
          UnboundDataType = wwDefault
        end
        object DBEdit19: TDBEdit
          Left = 435
          Top = 131
          Width = 78
          Height = 23
          HelpContext = 310192
          DataField = 'clientCode'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 18
        end
        object edtPrintName: TDBEdit
          Left = 118
          Top = 22
          Width = 190
          Height = 23
          HelpContext = 310194
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
      end
    end
    object Address_Info: TTabSheet
      HelpContext = 310050
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
        Width = 789
        Height = 331
        HelpContext = 310051
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
          Left = 427
          Top = 11
          Width = 281
          Height = 235
          HelpContext = 310053
        end
        object Box83: TBevel
          Left = 99
          Top = 11
          Width = 317
          Height = 235
          HelpContext = 310054
        end
        object Label180: TLabel
          Left = 115
          Top = 72
          Width = 58
          Height = 15
          HelpContext = 310055
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
          Left = 514
          Top = 19
          Width = 136
          Height = 18
          HelpContext = 310056
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
          Left = 183
          Top = 19
          Width = 104
          Height = 18
          HelpContext = 310057
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
          Left = 453
          Top = 43
          Width = 48
          Height = 15
          HelpContext = 310058
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
          Left = 125
          Top = 43
          Width = 48
          Height = 15
          HelpContext = 310059
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
          Left = 149
          Top = 130
          Width = 24
          Height = 15
          HelpContext = 310060
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
          Left = 119
          Top = 187
          Width = 54
          Height = 15
          HelpContext = 310061
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
          Left = 140
          Top = 159
          Width = 33
          Height = 15
          HelpContext = 310062
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
          Left = 477
          Top = 130
          Width = 24
          Height = 15
          HelpContext = 310063
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
          Left = 468
          Top = 159
          Width = 33
          Height = 15
          HelpContext = 310064
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
          Left = 447
          Top = 187
          Width = 54
          Height = 15
          HelpContext = 310065
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
          Left = 443
          Top = 72
          Width = 58
          Height = 15
          HelpContext = 310066
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
          Left = 129
          Top = 217
          Width = 44
          Height = 15
          HelpContext = 310067
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
          Left = 457
          Top = 217
          Width = 44
          Height = 15
          HelpContext = 310068
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
          Left = 93
          Top = 301
          Width = 80
          Height = 15
          HelpContext = 310069
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
          Left = 115
          Top = 101
          Width = 58
          Height = 15
          HelpContext = 310071
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
          Left = 443
          Top = 101
          Width = 58
          Height = 15
          HelpContext = 310072
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
          Left = 138
          Top = 261
          Width = 35
          Height = 15
          HelpContext = 310029
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
          Left = 427
          Top = 250
          Width = 281
          Height = 39
          HelpContext = 310052
        end
        object Label127: TLabel
          Left = 452
          Top = 261
          Width = 49
          Height = 16
          HelpContext = 310070
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
        object Street: TDBEdit
          Left = 184
          Top = 40
          Width = 220
          Height = 23
          HelpContext = 310073
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
          Left = 184
          Top = 69
          Width = 220
          Height = 23
          HelpContext = 310074
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
          Left = 184
          Top = 156
          Width = 89
          Height = 23
          HelpContext = 310075
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
          Left = 184
          Top = 185
          Width = 89
          Height = 23
          HelpContext = 310076
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
        object BillStreet: TDBEdit
          Left = 513
          Top = 40
          Width = 186
          Height = 23
          HelpContext = 310077
          DataField = 'BillStreet'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object BillState: TDBEdit
          Left = 513
          Top = 156
          Width = 89
          Height = 23
          HelpContext = 310078
          DataField = 'BillState'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
        end
        object BillPostcode: TDBEdit
          Left = 513
          Top = 185
          Width = 89
          Height = 23
          HelpContext = 310079
          DataField = 'BillPostcode'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
        end
        object Suburb: TwwDBLookupCombo
          Left = 184
          Top = 127
          Width = 220
          Height = 23
          HelpContext = 310080
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
          OnCloseUp = SuburbCloseUp
          OnEnter = SuburbEnter
        end
        object BillSuburb: TwwDBLookupCombo
          Left = 513
          Top = 127
          Width = 186
          Height = 23
          HelpContext = 310081
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
          DataSource = frmCustomerSrc
          LookupTable = qrySuburb
          LookupField = 'City_sub'
          ParentFont = False
          TabOrder = 13
          AutoDropDown = True
          ShowButton = True
          UseTFields = False
          PreciseEditRegion = False
          AllowClearKey = False
          OnCloseUp = BillSuburbCloseUp
          OnEnter = BillSuburbEnter
        end
        object BillStreet2: TDBEdit
          Left = 513
          Top = 69
          Width = 186
          Height = 23
          HelpContext = 310082
          DataField = 'BillStreet2'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object cmdCopy: TDNMSpeedButton
          Left = 331
          Top = 184
          Width = 72
          Height = 24
          Hint = '"Copy The Bill To Details In To The Physical Address"'
          HelpContext = 310083
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
          TabOrder = 9
          AutoDisableParentOnclick = True
          OnClick = cmdCopyClick
        end
        object Country: TDBEdit
          Left = 184
          Top = 214
          Width = 222
          Height = 23
          HelpContext = 310084
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
          Left = 513
          Top = 214
          Width = 156
          Height = 23
          HelpContext = 310085
          DataField = 'BillCountry'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
        end
        object URL: TwwDBRichEdit
          Left = 184
          Top = 297
          Width = 525
          Height = 23
          HelpContext = 310086
          AutoURLDetect = True
          DataField = 'URL'
          DataSource = frmCustomerSrc
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HideSelection = False
          ParentFont = False
          PrintJobName = 'Delphi 6'
          TabOrder = 8
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
            760000007B5C727466315C616E73695C616E7369637067313235325C64656666
            305C6465666C616E67333038317B5C666F6E7474626C7B5C66305C666E696C5C
            66636861727365743020417269616C3B7D7D0D0A5C766965776B696E64345C75
            63315C706172645C667331382055524C5C7061720D0A7D0D0A00}
        end
        object Street3: TDBEdit
          Left = 184
          Top = 98
          Width = 220
          Height = 23
          HelpContext = 310088
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
          Left = 513
          Top = 98
          Width = 186
          Height = 23
          HelpContext = 310089
          DataField = 'BillStreet3'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
        end
        object Email: TDBEdit
          Left = 184
          Top = 257
          Width = 233
          Height = 23
          HelpContext = 310043
          DataField = 'Email'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object cboMediaType: TwwDBLookupCombo
          Left = 513
          Top = 258
          Width = 142
          Height = 23
          Hint = '"Enter Where This Customer Came From"'
          HelpContext = 310087
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
          TabOrder = 17
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnEnter = cboMediaTypeEnter
        end
      end
    end
    object FollowUp: TTabSheet
      HelpContext = 310090
      Caption = '&Follow-Up'
      ImageIndex = 4
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 789
        Height = 331
        HelpContext = 310091
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object grdFollowUp: TwwDBGrid
          Left = 0
          Top = 0
          Width = 789
          Height = 331
          HelpContext = 310092
          ControlType.Strings = (
            'FollowUpDate;CustomEdit;dtpDatePicker;T'
            'EmployeeID;CustomEdit;cboEmployee;T'
            'Done;CheckBox;T;F'
            'EmployeeName;CustomEdit;cboEmployee;T'
            'TypeId;CustomEdit;cboFollowUpType;T'
            'ResultTypeId;CustomEdit;cboFollowUpResultType;T'
            'TypeName;CustomEdit;cboFollowUpType;T'
            'ResultTypeName;CustomEdit;cboFollowUpResultType;T')
          Selected.Strings = (
            'FollowUpDate'#9'12'#9'Follow Up Date'#9#9
            'TypeName'#9'16'#9'Type'#9#9
            'ResultTypeName'#9'16'#9'Result'#9#9
            'Notes'#9'38'#9'Notes'#9'F'#9
            'EmployeeName'#9'15'#9'EmployeeName'#9#9
            'Done'#9'4'#9'Done'#9#9
            'LeadLineID'#9'10'#9'LeadLineID'#9'F'#9)
          IniAttributes.Delimiter = ';;'
          TitleColor = 14155775
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alClient
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
          OnDblClick = grdFollowUpDblClick
          OnEnter = grdFollowUpEnter
          FooterColor = clWhite
          FooterCellColor = clWhite
          object btnInactiveFollowUp: TwwIButton
            Left = 0
            Top = 0
            Width = 26
            Height = 24
            HelpContext = 310177
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
        object dtpDatePicker: TwwDBDateTimePicker
          Left = 36
          Top = 53
          Width = 109
          Height = 23
          HelpContext = 310178
          AutoFillDateAndTime = True
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          DataField = 'FollowUpDate'
          DataSource = dsOtherFollowUp
          Epoch = 1950
          ShowButton = True
          TabOrder = 1
          UnboundDataType = wwDTEdtDate
        end
        object cboEmployee: TwwDBLookupCombo
          Left = 359
          Top = 50
          Width = 109
          Height = 23
          HelpContext = 310179
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'40'#9'Employee Name'#9'F')
          DataField = 'EmployeeName'
          LookupTable = qryEmployee
          LookupField = 'EmployeeID'
          TabOrder = 2
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object cboFollowUpType: TwwDBLookupCombo
          Left = 200
          Top = 48
          Width = 116
          Height = 23
          HelpContext = 310180
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'TypeId'
          DataSource = dsOtherFollowUp
          LookupTable = qryFollowUpType
          LookupField = 'Id'
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
          OnNotInList = cboFollowUpTypeNotInList
        end
        object cboFollowUpResultType: TwwDBLookupCombo
          Left = 216
          Top = 96
          Width = 121
          Height = 23
          HelpContext = 310181
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'ResultTypeId'
          DataSource = dsOtherFollowUp
          LookupTable = qryFollowUpResultType
          LookupField = 'Id'
          TabOrder = 4
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnNotInList = cboFollowUpResultTypeNotInList
        end
      end
    end
    object Custom_Fields: TTabSheet
      HelpContext = 310093
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
        HelpContext = 310094
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
        Width = 789
        Height = 331
        HelpContext = 310095
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
          HelpContext = 310096
        end
        object Label179: TLabel
          Left = 301
          Top = 12
          Width = 193
          Height = 26
          HelpContext = 310097
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
          HelpContext = 310098
          Style = bsRaised
        end
        object CUSTLBL1: TLabel
          Left = 122
          Top = 78
          Width = 3
          Height = 15
          HelpContext = 310099
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
          HelpContext = 310100
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
          HelpContext = 310101
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
          HelpContext = 310102
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
          HelpContext = 310103
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
          HelpContext = 310104
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
          HelpContext = 310105
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
          HelpContext = 310106
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
          HelpContext = 310107
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
          HelpContext = 310108
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
          HelpContext = 310109
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
          HelpContext = 310110
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
          HelpContext = 310111
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
          HelpContext = 310112
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
          HelpContext = 310113
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
          HelpContext = 310114
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
          HelpContext = 310115
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
          HelpContext = 310116
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
          HelpContext = 310117
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
          TabOrder = 15
          AutoDisableParentOnclick = True
          OnClick = cmdCustomLabelsOldClick
        end
        object CUSTFLD1: TwwDBComboBox
          Left = 127
          Top = 75
          Width = 130
          Height = 23
          HelpContext = 310118
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
          Left = 127
          Top = 109
          Width = 130
          Height = 23
          HelpContext = 310119
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
          Left = 127
          Top = 144
          Width = 130
          Height = 23
          HelpContext = 310120
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
          Left = 127
          Top = 178
          Width = 130
          Height = 23
          HelpContext = 310121
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
          Left = 127
          Top = 212
          Width = 130
          Height = 23
          HelpContext = 310122
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
          Top = 178
          Width = 130
          Height = 23
          HelpContext = 310123
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
          Top = 144
          Width = 130
          Height = 23
          HelpContext = 310124
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
          Top = 109
          Width = 130
          Height = 23
          HelpContext = 310125
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
          Top = 75
          Width = 130
          Height = 23
          HelpContext = 310126
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
          Left = 127
          Top = 246
          Width = 130
          Height = 23
          HelpContext = 310127
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
          Top = 212
          Width = 130
          Height = 23
          HelpContext = 310128
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
          Top = 245
          Width = 130
          Height = 23
          HelpContext = 310129
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
          Left = 653
          Top = 75
          Width = 130
          Height = 23
          HelpContext = 310130
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
          Left = 653
          Top = 109
          Width = 130
          Height = 23
          HelpContext = 310131
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
          Left = 653
          Top = 144
          Width = 130
          Height = 23
          HelpContext = 310132
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
          Left = 653
          Top = 178
          Width = 130
          Height = 23
          HelpContext = 310133
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
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = True
          TabOrder = 16
        end
        object CUSTFLD17: TwwDBDateTimePicker
          Left = 653
          Top = 212
          Width = 130
          Height = 23
          HelpContext = 310134
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
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = True
          TabOrder = 17
        end
        object CUSTFLD18: TwwDBDateTimePicker
          Left = 653
          Top = 245
          Width = 130
          Height = 23
          HelpContext = 310135
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
          Font.Style = [fsBold]
          ParentFont = False
          ShowButton = True
          TabOrder = 18
        end
      end
    end
    object History: TTabSheet
      HelpContext = 310136
      Caption = '&History'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlHistory: TDNMPanel
        Left = 0
        Top = 0
        Width = 789
        Height = 331
        HelpContext = 310137
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object tabContacts: TTabSheet
      HelpContext = 310138
      Caption = 'Co&ntacts'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DNMPanel4: TDNMPanel
        Left = 0
        Top = 0
        Width = 789
        Height = 331
        HelpContext = 310139
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
          789
          331)
        object Bevel2: TBevel
          Left = 0
          Top = 8
          Width = 787
          Height = 322
          HelpContext = 310182
          Anchors = [akLeft, akTop, akRight, akBottom]
        end
        object Label10: TLabel
          Left = 28
          Top = 305
          Width = 133
          Height = 15
          HelpContext = 310143
          Caption = 'Show Inactive Contacts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object LetterBtn: TDNMSpeedButton
          Left = 651
          Top = 28
          Width = 129
          Height = 27
          HelpContext = 310144
          Anchors = [akTop, akRight]
          Caption = '&Letter'
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
          TabOrder = 0
          AutoDisableParentOnclick = True
          OnClick = LetterBtnClick
        end
        object FaxBtn: TDNMSpeedButton
          Left = 651
          Top = 60
          Width = 129
          Height = 27
          HelpContext = 310145
          Anchors = [akTop, akRight]
          Caption = '&Fax'
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
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = FaxBtnClick
        end
        object EmailBtn: TDNMSpeedButton
          Left = 651
          Top = 92
          Width = 129
          Height = 27
          HelpContext = 310146
          Anchors = [akTop, akRight]
          Caption = 'E-Mail'
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
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = EmailBtnClick
        end
        object EditBtn: TDNMSpeedButton
          Left = 651
          Top = 140
          Width = 129
          Height = 27
          HelpContext = 310147
          Anchors = [akTop, akRight]
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
          TabOrder = 3
          AutoDisableParentOnclick = True
          OnClick = EditBtnClick
        end
        object cmdNewContact: TDNMSpeedButton
          Left = 651
          Top = 172
          Width = 129
          Height = 27
          HelpContext = 310148
          Anchors = [akTop, akRight]
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
          TabOrder = 4
          AutoDisableParentOnclick = True
          OnClick = cmdNewContactClick
        end
        object chkShowAll: TCheckBox
          Left = 6
          Top = 304
          Width = 17
          Height = 17
          HelpContext = 310149
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 5
          OnClick = chkShowAllClick
        end
        object grdContact: TwwDBGrid
          Left = 7
          Top = 16
          Width = 638
          Height = 282
          HelpContext = 310183
          ControlType.Strings = (
            'UseOnRun;CheckBox;T;F'
            'isPrimarycontact;CheckBox;T;F'
            'IsPrimarycontact;CheckBox;T;F')
          Selected.Strings = (
            'ContactName'#9'28'#9'Contact'#9'T'
            'ContactPH'#9'13'#9'Phone'#9'T'
            'ContactFax'#9'13'#9'Fax'#9'T'
            'ContactMOB'#9'13'#9'Mobile'#9'T'
            'isPrimarycontact'#9'1'#9'Primary Contact?'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          OnRowChanged = grdContactRowChanged
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
          TabOrder = 6
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          UseTFields = False
          OnDblClick = EditBtnClick
          OnKeyUp = grdContactKeyUp
          object wwIButton1: TwwIButton
            Left = 0
            Top = 0
            Width = 22
            Height = 22
            Hint = 'Click this button to Deactivate the selected contact'
            HelpContext = 310184
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
            OnClick = btnInactiveClick
          end
        end
      end
    end
    object tabDocuments: TTabSheet
      HelpContext = 310151
      Caption = '&Documents'
      ImageIndex = 6
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DNMPanel5: TDNMPanel
        Left = 0
        Top = 0
        Width = 789
        Height = 331
        HelpContext = 310152
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
          789
          331)
        object Bevel5: TBevel
          Left = 55
          Top = 13
          Width = 671
          Height = 300
          HelpContext = 310153
          Anchors = [akLeft, akTop, akRight, akBottom]
        end
        object Label138: TLabel
          Left = 72
          Top = 28
          Width = 70
          Height = 18
          HelpContext = 310154
          AutoSize = False
          Caption = 'Documents'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object Label140: TLabel
          Left = 489
          Top = 30
          Width = 183
          Height = 14
          HelpContext = 310155
          AutoSize = False
          Caption = 'Double click to open correspondence'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object grdDocs: TwwDBGrid
          Left = 71
          Top = 49
          Width = 639
          Height = 257
          HelpContext = 310156
          Selected.Strings = (
            'Date'#9'14'#9'Date'#9'F'
            'ContactName'#9'23'#9'Contact'#9'F'
            'Type'#9'10'#9'Type'#9#9
            'Reference'#9'34'#9'Reference'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
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
          UseTFields = False
          OnDblClick = grdDocsDblClick
          FooterColor = clWhite
          FooterCellColor = clWhite
        end
      end
    end
    object tabNotes: TTabSheet
      HelpContext = 310157
      Caption = 'Not&es'
      ImageIndex = 7
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DNMPanel6: TDNMPanel
        Left = 0
        Top = 0
        Width = 789
        Height = 331
        HelpContext = 310158
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
          789
          331)
        object Label59: TLabel
          Left = 14
          Top = 6
          Width = 41
          Height = 18
          HelpContext = 310159
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
        object edtNotes: TDBMemo
          Left = 67
          Top = 6
          Width = 651
          Height = 280
          HelpContext = 310160
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataField = 'Notes'
          DataSource = frmCustomerSrc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnExit = edtNotesExit
        end
        object btnAddDateTime: TDNMSpeedButton
          Left = 336
          Top = 297
          Width = 110
          Height = 27
          HelpContext = 310161
          Anchors = [akLeft, akBottom]
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
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = btnAddDateTimeClick
        end
      end
    end
  end
  object cmdFollowUp: TDNMSpeedButton [19]
    Left = 818
    Top = 206
    Width = 87
    Height = 27
    Hint = '"Print This Customer"'
    HelpContext = 310162
    Anchors = [akTop, akRight]
    Caption = 'Ph Contact'
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
    TabOrder = 12
    AutoDisableParentOnclick = True
    OnClick = cmdFollowUpClick
  end
  object chkActive: TDBCheckBox [20]
    Left = 854
    Top = 296
    Width = 14
    Height = 15
    HelpContext = 310163
    Anchors = [akTop, akRight]
    Color = 13303807
    DataField = 'Active'
    DataSource = frmCustomerSrc
    ParentColor = False
    TabOrder = 8
    ValueChecked = 'T'
    ValueUnchecked = 'F'
  end
  object pnlTitle: TDNMPanel [21]
    Left = 288
    Top = 6
    Width = 238
    Height = 39
    HelpContext = 310164
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 35
      HelpContext = 310165
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
        Height = 35
        HelpContext = 310166
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Prospect'
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
  object txtCusID: TDBEdit [22]
    Left = 96
    Top = 51
    Width = 39
    Height = 23
    HelpContext = 310006
    TabStop = False
    DataField = 'ClientID'
    DataSource = frmCustomerSrc
    TabOrder = 9
    Visible = False
  end
  object cmdNew: TDNMSpeedButton [23]
    Left = 818
    Top = 144
    Width = 87
    Height = 27
    Hint = '"Add A New Customer"'
    HelpContext = 310005
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
    TabOrder = 6
    AutoDisableParentOnclick = True
    OnClick = cmdNewClick
  end
  object cmdPrint: TDNMSpeedButton [24]
    Left = 818
    Top = 175
    Width = 87
    Height = 27
    Hint = '"Print This Customer"'
    HelpContext = 310007
    Anchors = [akTop, akRight]
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
    TabOrder = 7
    AutoDisableParentOnclick = True
    OnClick = cmdPrintClick
  end
  object DNMSpeedButton1: TDNMSpeedButton [25]
    Left = 818
    Top = 238
    Width = 87
    Height = 27
    HelpContext = 310187
    Anchors = [akTop, akRight]
    Caption = 'Lock Fields'
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
    TabOrder = 14
    AutoDisableParentOnclick = True
    OnClick = mnuBusobjPropertiesoptionClick
  end
  object chkDontContact: TDBCheckBox [26]
    Left = 854
    Top = 346
    Width = 14
    Height = 16
    HelpContext = 310190
    Anchors = [akTop, akRight]
    Color = 14867920
    DataField = 'DontContact'
    DataSource = frmCustomerSrc
    ParentColor = False
    TabOrder = 15
    ValueChecked = 'T'
    ValueUnchecked = 'F'
  end
  inherited tmrProcessMessage: TTimer
    Left = 433
    Top = 0
  end
  inherited tmrdelay: TTimer
    Left = 505
    Top = 0
  end
  inherited popSpelling: TPopupMenu
    Left = 183
    Top = 0
  end
  inherited tmrdelayMsg: TTimer
    Left = 111
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 75
    Top = 0
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 362
    Top = 0
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
    Left = 42
  end
  inherited DataState: TDataState
    Left = 40
    Top = 0
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 541
    Top = 0
  end
  inherited imgsort: TImageList
    Left = 290
    Top = 0
    Bitmap = {
      494C010102004C00C00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 648
    Top = 31
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 398
    Top = 0
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 326
    Top = 0
  end
  inherited qryMemTrans: TERPQuery
    Left = 684
    Top = 31
  end
  object frmCustomerSrc: TDataSource
    DataSet = qryCustomers
    Left = 79
    Top = 58
  end
  object FollowUpSrc: TDataSource
    DataSet = qryFollowUp
    Left = 185
    Top = 58
  end
  object qryCustomers: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      '*'
      'FROM tblclients'
      'WHERE ClientID = :CusID;')
    AfterOpen = qryCustomersAfterOpen
    AfterInsert = qryCustomersAfterInsert
    AfterPost = qryCustomersAfterPost
    Left = 77
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
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
    object qryCustomersTitle: TWideStringField
      DisplayWidth = 10
      FieldName = 'Title'
      Origin = 'tblclients.Title'
      Size = 32
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
    object qryCustomersAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
      EditMask = '## #### ####;0;_'
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
    end
    object qryCustomersBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'tblclients.Balance'
    end
    object qryCustomersTERMS: TWideStringField
      FieldName = 'TERMS'
      Origin = 'tblclients.TERMS'
      Size = 30
    end
    object qryCustomersTermsID: TIntegerField
      FieldName = 'TermsID'
      Origin = 'tblclients.TermsID'
    end
    object qryCustomersShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Origin = 'tblclients.ShippingMethod'
      Size = 30
    end
    object qryCustomersShippingID: TIntegerField
      FieldName = 'ShippingID'
      Origin = 'tblclients.ShippingID'
    end
    object qryCustomersDiscount: TFloatField
      FieldName = 'Discount'
      Origin = 'tblclients.Discount'
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
    object qryCustomersClientNo: TWideStringField
      FieldName = 'ClientNo'
      Origin = 'tblclients.ClientNo'
      Size = 50
    end
    object qryCustomersTAXID: TIntegerField
      FieldName = 'TAXID'
      Origin = 'tblclients.TAXID'
    end
    object qryCustomersURL: TWideStringField
      FieldName = 'URL'
      Origin = 'tblclients.URL'
      Size = 255
    end
    object qryCustomersRequired: TWideStringField
      FieldName = 'Required'
      Origin = 'tblclients.Required'
      FixedChar = True
      Size = 1
    end
    object qryCustomersRepName: TWideStringField
      FieldName = 'RepName'
      Origin = 'tblclients.RepName'
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
    object qryCustomersState: TWideStringField
      FieldName = 'State'
      Origin = 'tblclients.State'
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
    object qryCustomersCUSTDATE1: TDateTimeField
      FieldName = 'CUSTDATE1'
      Origin = 'tblclients.CUSTDATE1'
    end
    object qryCustomersCUSTDATE2: TDateTimeField
      FieldName = 'CUSTDATE2'
      Origin = 'tblclients.CUSTDATE2'
    end
    object qryCustomersCUSTDATE3: TDateTimeField
      FieldName = 'CUSTDATE3'
      Origin = 'tblclients.CUSTDATE3'
    end
    object qryCustomersCompanyTypeId: TIntegerField
      FieldName = 'CompanyTypeId'
      Origin = 'tblclients.CompanyTypeId'
    end
    object qryCustomersJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Origin = 'tblclients.JobTitle'
      Size = 255
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
    object qryCustomersCallPriority: TIntegerField
      FieldName = 'CallPriority'
      Origin = 'tblclients.CallPriority'
    end
    object qryCustomersDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Origin = 'tblclients.DefaultContactMethod'
    end
    object qryCustomersDontContact: TWideStringField
      FieldName = 'DontContact'
      Origin = 'tblclients.DontContact'
      FixedChar = True
      Size = 1
    end
    object qryCustomersmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblclients.msUpdateSiteCode'
      Size = 3
    end
    object qryCustomersclientCode: TWideStringField
      FieldName = 'clientCode'
      Origin = 'tblclients.ClientCode'
      Size = 5
    end
    object qryCustomersPrintName: TWideStringField
      FieldName = 'PrintName'
      Origin = 'tblclients.PrintName'
      Size = 255
    end
    object qryCustomersGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object qryFollowUp: TERPQuery
    SQL.Strings = (
      
        'Select FollowUpID, OtherContactID, EmployeeID, FollowUpDate, Not' +
        'es,'
      'Done, EditedFlag, AppearDays, CreationDate'
      'FROM tblOtherFollowUp'
      'WHERE OtherContactID=:CusID;')
    Left = 184
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
  end
  object qryCustomFields: TERPQuery
    SQL.Strings = (
      'SELECT '
      'CFLabel1,CFCust1, CFEmpl1, CFSupp1, CFLabel2, '
      'CFCust2, CFEmpl2, CFSupp2, CFLabel3, CFCust3, CFEmpl3, '
      'CFSupp3, CFLabel4, CFCust4, CFEmpl4, CFSupp4, CFLabel5, '
      'CFCust5, CFEmpl5, CFSupp5, CFLabel6, CFCust6, CFEmpl6, '
      'CFSupp6, CFLabel7, CFCust7, CFEmpl7, CFSupp7, CFLabel8, '
      'CFCust8, CFEmpl8, CFSupp8, CFLabel9, CFCust9, CFEmpl9, '
      'CFSupp9, CFLabel10, CFCust10, CFEmpl10, CFSupp10, CFLabel11,'
      'CFCust11, CFEmpl11, CFSupp11, CFLabel12, CFCust12, CFEmpl12, '
      'CFSupp12, CFLabel13, CFCust13, CFEmpl13, CFSupp13, CFLabel14, '
      'CFCust14, CFEmpl14, CFSupp14, CFLabel15, CFCust15, CFEmpl15,'
      
        'CFSupp15, EditedFlag, CFOthr1, CFOthr2, CFOthr3, CFOthr4, CFOthr' +
        '5, '
      
        'CFOthr6, CFOthr7, CFOthr8, CFOthr9, CFOthr10, CFOthr11, CFOthr12' +
        ', '
      'CFOthr13, CFOthr14, CFOthr15, CFOthr16, CFOthr17, CFOthr18,'
      'CFLabel16, CFLabel17, CFLabel18  '
      'FROM tblcustomfields')
    Left = 327
    Top = 31
    object qryCustomFieldsCFLabel1: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel1'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust1: TWideStringField
      FieldName = 'CFCust1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl1: TWideStringField
      FieldName = 'CFEmpl1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp1: TWideStringField
      FieldName = 'CFSupp1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel2: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel2'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust2: TWideStringField
      FieldName = 'CFCust2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl2: TWideStringField
      FieldName = 'CFEmpl2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp2: TWideStringField
      FieldName = 'CFSupp2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel3: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel3'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust3: TWideStringField
      FieldName = 'CFCust3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl3: TWideStringField
      FieldName = 'CFEmpl3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp3: TWideStringField
      FieldName = 'CFSupp3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel4: TWideStringField
      FieldName = 'CFLabel4'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust4: TWideStringField
      FieldName = 'CFCust4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl4: TWideStringField
      FieldName = 'CFEmpl4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp4: TWideStringField
      FieldName = 'CFSupp4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel5: TWideStringField
      FieldName = 'CFLabel5'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust5: TWideStringField
      FieldName = 'CFCust5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl5: TWideStringField
      FieldName = 'CFEmpl5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp5: TWideStringField
      FieldName = 'CFSupp5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel6: TWideStringField
      FieldName = 'CFLabel6'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust6: TWideStringField
      FieldName = 'CFCust6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl6: TWideStringField
      FieldName = 'CFEmpl6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp6: TWideStringField
      FieldName = 'CFSupp6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel7: TWideStringField
      FieldName = 'CFLabel7'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust7: TWideStringField
      FieldName = 'CFCust7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl7: TWideStringField
      FieldName = 'CFEmpl7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp7: TWideStringField
      FieldName = 'CFSupp7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel8: TWideStringField
      FieldName = 'CFLabel8'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust8: TWideStringField
      FieldName = 'CFCust8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl8: TWideStringField
      FieldName = 'CFEmpl8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp8: TWideStringField
      FieldName = 'CFSupp8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel9: TWideStringField
      FieldName = 'CFLabel9'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust9: TWideStringField
      FieldName = 'CFCust9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl9: TWideStringField
      FieldName = 'CFEmpl9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp9: TWideStringField
      FieldName = 'CFSupp9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel10: TWideStringField
      FieldName = 'CFLabel10'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust10: TWideStringField
      FieldName = 'CFCust10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl10: TWideStringField
      FieldName = 'CFEmpl10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp10: TWideStringField
      FieldName = 'CFSupp10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel11: TWideStringField
      FieldName = 'CFLabel11'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust11: TWideStringField
      FieldName = 'CFCust11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl11: TWideStringField
      FieldName = 'CFEmpl11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp11: TWideStringField
      FieldName = 'CFSupp11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel12: TWideStringField
      FieldName = 'CFLabel12'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust12: TWideStringField
      FieldName = 'CFCust12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl12: TWideStringField
      FieldName = 'CFEmpl12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp12: TWideStringField
      FieldName = 'CFSupp12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel13: TWideStringField
      FieldName = 'CFLabel13'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust13: TWideStringField
      FieldName = 'CFCust13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl13: TWideStringField
      FieldName = 'CFEmpl13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp13: TWideStringField
      FieldName = 'CFSupp13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel14: TWideStringField
      FieldName = 'CFLabel14'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust14: TWideStringField
      FieldName = 'CFCust14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl14: TWideStringField
      FieldName = 'CFEmpl14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp14: TWideStringField
      FieldName = 'CFSupp14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel15: TWideStringField
      FieldName = 'CFLabel15'
      FixedChar = True
      Size = 16
    end
    object qryCustomFieldsCFCust15: TWideStringField
      FieldName = 'CFCust15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFEmpl15: TWideStringField
      FieldName = 'CFEmpl15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFSupp15: TWideStringField
      FieldName = 'CFSupp15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr1: TWideStringField
      FieldName = 'CFOthr1'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr2: TWideStringField
      FieldName = 'CFOthr2'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr3: TWideStringField
      FieldName = 'CFOthr3'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr4: TWideStringField
      FieldName = 'CFOthr4'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr5: TWideStringField
      FieldName = 'CFOthr5'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr6: TWideStringField
      FieldName = 'CFOthr6'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr7: TWideStringField
      FieldName = 'CFOthr7'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr8: TWideStringField
      FieldName = 'CFOthr8'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr9: TWideStringField
      FieldName = 'CFOthr9'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr10: TWideStringField
      FieldName = 'CFOthr10'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr11: TWideStringField
      FieldName = 'CFOthr11'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr12: TWideStringField
      FieldName = 'CFOthr12'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr13: TWideStringField
      FieldName = 'CFOthr13'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr14: TWideStringField
      FieldName = 'CFOthr14'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr15: TWideStringField
      FieldName = 'CFOthr15'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFLabel16: TWideStringField
      FieldName = 'CFLabel16'
    end
    object qryCustomFieldsCFLabel17: TWideStringField
      FieldName = 'CFLabel17'
    end
    object qryCustomFieldsCFLabel18: TWideStringField
      DisplayWidth = 16
      FieldName = 'CFLabel18'
    end
    object qryCustomFieldsCFOthr16: TWideStringField
      FieldName = 'CFOthr16'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr17: TWideStringField
      FieldName = 'CFOthr17'
      FixedChar = True
      Size = 1
    end
    object qryCustomFieldsCFOthr18: TWideStringField
      FieldName = 'CFOthr18'
      FixedChar = True
      Size = 1
    end
  end
  object DataSource3: TDataSource
    DataSet = qryCustomFields
    Left = 327
    Top = 58
  end
  object qryContactType: TERPQuery
    SQL.Strings = (
      'SELECT OtherTypeID, OtherType FROM tblOtherType'
      'GROUP BY OtherType'
      'ORDER BY OtherType')
    Left = 577
    Top = 31
  end
  object dsOtherFollowUp: TDataSource
    DataSet = tbOtherFollowUp
    Left = 256
    Top = 58
  end
  object memqryCustomers: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ClientID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'Company'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'ABN'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'Title'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'FirstName'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'MiddleName'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'LastName'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Position'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Street'
        DataType = ftString
        Size = 38
      end
      item
        Name = 'Street2'
        DataType = ftString
        Size = 38
      end
      item
        Name = 'Suburb'
        DataType = ftString
        Size = 27
      end
      item
        Name = 'State'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 3
      end
      item
        Name = 'Country'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Postcode'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'BillStreet'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'BillStreet2'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'BillSuburb'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'BillState'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BillCountry'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'BillPostcode'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'POBox'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'POSuburb'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'POState'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'POCountry'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'POPostcode'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'FaxNumber'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Mobile'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Email'
        DataType = ftString
        Size = 80
      end
      item
        Name = 'AltContact'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'AltPhone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Contact1'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PhoneSupportTill'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'Contact2'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Contact1Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Contact2Phone'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Notes'
        DataType = ftWideMemo
      end
      item
        Name = 'ClientNo'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'MedTypeID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'TYPE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TAXID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'CreditLimit'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'Balance'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'TERMS'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'TermsID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'ShippingMethod'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'ShippingID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Discount'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'SpecialDiscount'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'JobName'
        DataType = ftString
        Size = 39
      end
      item
        Name = 'IsJob'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'CUSTFLD1'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD2'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD3'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD4'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD5'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD6'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD7'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD8'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD9'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD10'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD11'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD12'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD13'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD14'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CUSTFLD15'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'PayMethodID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Feedback'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'Customer'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'Supplier'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'OtherContact'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'OtherContactType'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'RepID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'Global'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'Done'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'Active'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'URL'
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
    Left = 469
  end
  object memtbOtherFollowUp: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'GlobalRef'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'FollowUpID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'OtherContactID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'RepairID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'EmployeeID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'ClientID'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'FollowUpDate'
        Attributes = [faFixed]
        DataType = ftDateTime
      end
      item
        Name = 'Notes'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Done'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'AppearDays'
        Attributes = [faFixed]
        DataType = ftInteger
      end
      item
        Name = 'CreationDate'
        Attributes = [faFixed]
        DataType = ftDateTime
      end
      item
        Name = 'UpdateDate'
        Attributes = [faFixed]
        DataType = ftDate
      end
      item
        Name = 'IsSupplier'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IsOtherContact'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'IsCustomer'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
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
    Left = 577
  end
  object qryMediaType: TERPQuery
    SQL.Strings = (
      
        'SELECT  tblSource.MedTypeID, tblSource.MediaType, tblSource.Acti' +
        've '
      'FROM tblSource '
      
        'WHERE (((tblSource.MediaType)>" ") And ((tblSource.Active)<>'#39'F'#39')' +
        ') '
      'ORDER BY tblSource.MediaType; ')
    Left = 434
    Top = 31
  end
  object qryContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT * , Concat_Ws('#39' '#39',ContactFirstName,ContactSurName) AS Con' +
        'tactName'
      'FROM tblContacts'
      'WHERE clientId=:CusID')
    AfterOpen = qryContactsAfterOpen
    Left = 291
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
    object qryContactsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblcontacts.GlobalRef'
      Size = 255
    end
    object qryContactsContactID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ContactID'
      Origin = 'tblcontacts.ContactID'
      ReadOnly = True
    end
    object qryContactsCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblcontacts.Company'
      Size = 50
    end
    object qryContactsContactTitle: TWideStringField
      FieldName = 'ContactTitle'
      Origin = 'tblcontacts.ContactTitle'
      Size = 10
    end
    object qryContactsContactFirstName: TWideStringField
      FieldName = 'ContactFirstName'
      Origin = 'tblcontacts.ContactFirstName'
      Size = 30
    end
    object qryContactsContactSurName: TWideStringField
      FieldName = 'ContactSurName'
      Origin = 'tblcontacts.ContactSurName'
      Size = 30
    end
    object qryContactsContactAddress: TWideStringField
      FieldName = 'ContactAddress'
      Origin = 'tblcontacts.ContactAddress'
      Size = 100
    end
    object qryContactsContactCity: TWideStringField
      FieldName = 'ContactCity'
      Origin = 'tblcontacts.ContactCity'
      Size = 30
    end
    object qryContactsContactState: TWideStringField
      FieldName = 'ContactState'
      Origin = 'tblcontacts.ContactState'
      Size = 5
    end
    object qryContactsContactPcode: TWideStringField
      FieldName = 'ContactPcode'
      Origin = 'tblcontacts.ContactPcode'
      Size = 255
    end
    object qryContactsContactPH: TWideStringField
      FieldName = 'ContactPH'
      Origin = 'tblcontacts.ContactPH'
    end
    object qryContactsContactAltPH: TWideStringField
      FieldName = 'ContactAltPH'
      Origin = 'tblcontacts.ContactAltPH'
    end
    object qryContactsContactMOB: TWideStringField
      FieldName = 'ContactMOB'
      Origin = 'tblcontacts.ContactMOB'
    end
    object qryContactsContactFax: TWideStringField
      FieldName = 'ContactFax'
      Origin = 'tblcontacts.ContactFax'
    end
    object qryContactsContactEmail: TWideStringField
      FieldName = 'ContactEmail'
      Origin = 'tblcontacts.ContactEmail'
      Size = 80
    end
    object qryContactsNotes: TWideStringField
      FieldName = 'Notes'
      Origin = 'tblcontacts.Notes'
      Size = 255
    end
    object qryContactsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblcontacts.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryContactsContactAddress2: TWideStringField
      FieldName = 'ContactAddress2'
      Origin = 'tblcontacts.ContactAddress2'
      Size = 40
    end
    object qryContactsCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Origin = 'tblcontacts.CardNumber'
      Size = 255
    end
    object qryContactsAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Origin = 'tblcontacts.AccountNo'
      EditMask = '999999999999999999999999999999;0; '
      Size = 255
    end
    object qryContactsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblcontacts.Active'
      FixedChar = True
      Size = 1
    end
    object qryContactsContactName: TWideStringField
      FieldName = 'ContactName'
      Origin = 'ContactName'
      ReadOnly = True
      Size = 61
    end
    object qryContactsIsPrimarycontact: TWideStringField
      FieldName = 'IsPrimarycontact'
      Origin = 'tblcontacts.IsPrimarycontact'
      FixedChar = True
      Size = 1
    end
    object qryContactsClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblcontacts.ClientID'
    end
    object qryContactsClientName: TWideStringField
      FieldName = 'ClientName'
      Origin = 'tblcontacts.ClientName'
      Size = 255
    end
    object qryContactsContactAddress3: TWideStringField
      FieldName = 'ContactAddress3'
      Size = 255
    end
  end
  object qryDocuments: TERPQuery
    SQL.Strings = (
      'SELECT tblReference.RefID,'
      'tblReference.Ref_Date as Date,'
      'tblReference.Ref_type as Type,'
      'tblReference.Referencetxt as Reference,'
      'tblReference.CusID,'
      'tblReference.ContactID,'
      
        'Concat_Ws('#39' '#39',tblContacts.ContactFirstName,tblContacts.ContactSu' +
        'rname) as ContactName,'
      'tblContacts.ContactID,'
      'tblReference.EditedFlag'
      'FROM tblReference'
      'LEFT JOIN tblClients'
      'ON tblReference.CusID=tblClients.ClientID'
      'LEFT JOIN tblContacts'
      'ON tblReference.ContactID=tblContacts.ContactID'
      'WHERE tblReference.OthercontactID=:CusID'
      'GROUP BY tblReference.RefID'
      'ORDER BY tblReference.Ref_Date DESC;')
    Left = 113
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CusID'
      end>
  end
  object DSContacts: TDataSource
    DataSet = qryContacts
    Left = 291
    Top = 58
  end
  object DSDocuments: TDataSource
    DataSet = qryDocuments
    Left = 114
    Top = 58
  end
  object WordApplication1: TWordApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 254
  end
  object memqryContacts: TkbmMemTable
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
    Left = 147
  end
  object qryDocPath: TERPQuery
    SQL.Strings = (
      'Select DPID, DocumentPath '
      'FROM tblDocPath;')
    Left = 470
    Top = 31
  end
  object qrySuburb: TERPQuery
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Country'
      'FROM tblLocations'
      'Where RegionID= :xRegionID'
      'ORDER BY City_sub')
    BeforeOpen = qrySuburbBeforeOpen
    Left = 541
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object qryCompanyType: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblSimpleTypes '
      'WHERE Active = "T" AND TypeCode = :TypeCode')
    Left = 720
    Top = 31
    ParamData = <
      item
        DataType = ftString
        Name = 'TypeCode'
        Value = ''
      end>
  end
  object tbOtherFollowUp: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblOtherFollowUp  '
      'WHERE ClientId = :ClientId'
      'ORDER BY FollowUpDate')
    AfterOpen = tbOtherFollowUpAfterOpen
    AfterInsert = tbOtherFollowUpAfterInsert
    AfterScroll = tbOtherFollowUpAfterScroll
    OnNewRecord = tbOtherFollowUpNewRecord
    Left = 256
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClientId'
      end>
    object tbOtherFollowUpFollowUpDate: TDateTimeField
      DisplayLabel = 'Follow Up Date'
      DisplayWidth = 12
      FieldName = 'FollowUpDate'
      DisplayFormat = 'dd/mm/yy hh:nn'
    end
    object tbOtherFollowUpTypeName: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 16
      FieldKind = fkLookup
      FieldName = 'TypeName'
      LookupDataSet = qryFollowUpType
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'TypeId'
      Size = 255
      Lookup = True
    end
    object tbOtherFollowUpResultTypeName: TWideStringField
      DisplayLabel = 'Result'
      DisplayWidth = 16
      FieldKind = fkLookup
      FieldName = 'ResultTypeName'
      LookupDataSet = qryFollowUpResultType
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'ResultTypeId'
      Size = 255
      Lookup = True
    end
    object tbOtherFollowUpEmployeeName: TWideStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'EmployeeName'
      LookupDataSet = qryEmployee
      LookupKeyFields = 'EmployeeId'
      LookupResultField = 'EmployeeName'
      KeyFields = 'EmployeeID'
      Size = 255
      Lookup = True
    end
    object tbOtherFollowUpDone: TWideStringField
      DisplayWidth = 4
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpLeadLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LeadLineID'
    end
    object tbOtherFollowUpGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object tbOtherFollowUpFollowUpID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FollowUpID'
      ReadOnly = True
      Visible = False
    end
    object tbOtherFollowUpOtherContactID: TIntegerField
      DisplayWidth = 10
      FieldName = 'OtherContactID'
      Visible = False
    end
    object tbOtherFollowUpRepairID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairID'
      Visible = False
    end
    object tbOtherFollowUpEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
    object tbOtherFollowUpClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object tbOtherFollowUpEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpAppearDays: TIntegerField
      DisplayWidth = 10
      FieldName = 'AppearDays'
      Visible = False
    end
    object tbOtherFollowUpCreationDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'CreationDate'
      Visible = False
    end
    object tbOtherFollowUpUpdateDate: TDateField
      DisplayWidth = 10
      FieldName = 'UpdateDate'
      Visible = False
    end
    object tbOtherFollowUpIsSupplier: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsSupplier'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsOtherContact: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsOtherContact'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpIsCustomer: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsCustomer'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbOtherFollowUpHours: TFloatField
      DisplayWidth = 10
      FieldName = 'Hours'
      Visible = False
    end
    object tbOtherFollowUpTypeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'TypeId'
      Visible = False
    end
    object tbOtherFollowUpResultTypeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ResultTypeId'
      Visible = False
    end
    object tbOtherFollowUpNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
  end
  object qryFollowUpType: TERPQuery
    SQL.Strings = (
      
        'select * from tblSimpleTypes where Active <> "F" and TypeCode = ' +
        ':TypeCode')
    Left = 399
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TypeCode'
      end>
  end
  object qryFollowUpResultType: TERPQuery
    SQL.Strings = (
      'SELECT * '
      'FROM tblSimpleTypes '
      'WHERE Active <> "F" AND'
      'TypeCode = :TypeCode AND'
      'Name NOT LIKE '#39'Appoint%'#39';')
    Left = 756
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TypeCode'
      end>
  end
  object qryEmployee: TERPQuery
    SQL.Strings = (
      'SELECT EmployeeId, EmployeeName, Active FROM tblEmployees'
      'WHERE Active = "T"')
    Left = 613
    Top = 31
  end
  object qryEmp: TERPQuery
    SQL.Strings = (
      'SELECT EmployeeId, EmployeeName, Active FROM tblEmployees'
      'WHERE Active = "T"'
      'Order by EmployeeName')
    Left = 149
    Top = 31
  end
  object dsEmp: TDataSource
    DataSet = qryEmp
    Left = 149
    Top = 58
  end
  object qrySimpleTypes: TERPQuery
    SQL.Strings = (
      'SELECT * '
      'FROM tblSimpleTypes')
    Left = 363
    Top = 31
  end
  object DSRelatedClients: TDataSource
    DataSet = qryRelatedClients
    Left = 220
    Top = 58
  end
  object qryRelatedClients: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT RelatedClientID, MasterClientID, MasterCompany, ChildClie' +
        'ntID, ChildCompany  '
      'FROM tblrelatedclients'
      'Where MasterClientID=:ID;')
    AfterInsert = qryRelatedClientsAfterInsert
    Left = 220
    Top = 31
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
      Size = 80
    end
  end
  object cboClientLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'ClientID as ClientID,'
      'Company as Company'
      'FROM tblclients'
      'LEFT JOIN tblrelatedclients on ChildClientID=ClientID'
      'WHERE Active = '#39'T'#39
      'And Customer = '#39'T'#39' AND IsJob = '#39'F'#39' AND IsNull(ChildClientID)'
      'And ClientID<>:ID'
      'Order By Company;')
    Options.LongStrings = False
    Left = 506
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
end
