inherited fmProductCommission: TfmProductCommission
  Left = 1656
  Top = 127
  HelpContext = 704000
  Caption = 'Product Commission'
  ClientHeight = 485
  ClientWidth = 536
  OldCreateOrder = True
  ExplicitLeft = 1656
  ExplicitTop = 127
  ExplicitWidth = 552
  ExplicitHeight = 524
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 439
    Width = 536
    HelpContext = 704017
    ExplicitTop = 439
    ExplicitWidth = 536
  end
  object pnlBottom: TDNMPanel [5]
    Left = 0
    Top = 439
    Width = 536
    Height = 46
    HelpContext = 704023
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      536
      46)
    object Label50: TLabel
      Left = 463
      Top = 15
      Width = 40
      Height = 18
      HelpContext = 704024
      Anchors = [akRight, akBottom]
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
    object btnSave: TDNMSpeedButton
      Left = 110
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 704025
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
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnNew: TDNMSpeedButton
      Left = 222
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 704026
      Anchors = [akBottom]
      Caption = '&New'
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
      TabOrder = 2
      OnClick = btnNewClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 334
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 704027
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
      TabOrder = 3
      OnClick = btnCancelClick
    end
    object chkActive: TwwCheckBox
      Left = 504
      Top = 15
      Width = 16
      Height = 17
      HelpContext = 704028
      DisableThemes = False
      AlwaysTransparent = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Anchors = [akRight, akBottom]
      Caption = 'chkActive'
      DataField = 'Active'
      DataSource = dsProdcommission
      TabOrder = 0
    end
  end
  object pnlTop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 536
    Height = 64
    HelpContext = 704029
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      536
      64)
    object pnlTitle: TDNMPanel
      Left = 101
      Top = 6
      Width = 313
      Height = 45
      HelpContext = 704030
      Anchors = [akLeft, akTop, akRight]
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
        Width = 309
        Height = 41
        HelpContext = 704031
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
          Width = 309
          Height = 41
          HelpContext = 704032
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Product Commission'
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
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 64
    Width = 536
    Height = 375
    HelpContext = 704001
    Align = alClient
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object Bevel3: TBevel
      Left = 16
      Top = 322
      Width = 504
      Height = 49
      HelpContext = 704002
    end
    object Label1: TLabel
      Left = 16
      Top = 19
      Width = 45
      Height = 15
      HelpContext = 704003
      Caption = 'Product'
      Transparent = True
    end
    object Label2: TLabel
      Left = 26
      Top = 343
      Width = 26
      Height = 15
      HelpContext = 704004
      Caption = 'Rate'
      Transparent = True
    end
    object Label3: TLabel
      Left = 26
      Top = 99
      Width = 106
      Height = 15
      HelpContext = 704005
      Caption = 'For all employees?'
      Transparent = True
    end
    object Label4: TLabel
      Left = 198
      Top = 343
      Width = 86
      Height = 15
      HelpContext = 704006
      Caption = 'Is Percentage?'
      Transparent = True
    end
    object lblEmployee: TLabel
      Left = 232
      Top = 99
      Width = 58
      Height = 15
      HelpContext = 704007
      Caption = 'Employee '
      Transparent = True
    end
    object lblOHbase: TLabel
      Left = 331
      Top = 343
      Width = 90
      Height = 15
      HelpContext = 704018
      Caption = 'Overhead  Base'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 502
      Top = 341
      Width = 10
      Height = 18
      HelpContext = 704019
      AutoSize = False
      Caption = '%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel2: TBevel
      Left = 16
      Top = 80
      Width = 504
      Height = 49
      HelpContext = 704008
    end
    object cboPartName: TwwDBLookupCombo
      Left = 16
      Top = 43
      Width = 385
      Height = 23
      HelpContext = 704009
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Partname'#9'60'#9'Partname'#9'F')
      DataField = 'Partname'
      DataSource = dsProdcommission
      LookupTable = qryParts
      LookupField = 'Partname'
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = cboPartNameDblClick
      OnBeforeDropDown = cboPartNameBeforeDropDown
      OnCloseUp = cboPartNameCloseUp
    end
    object cboemployee: TwwDBLookupCombo
      Left = 296
      Top = 95
      Width = 217
      Height = 23
      HelpContext = 704010
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'employeename'#9'128'#9'employeename'#9'F')
      DataField = 'EmployeeName'
      DataSource = dsProdcommission
      LookupTable = QryEmployee
      LookupField = 'EmployeeID'
      ParentFont = False
      TabOrder = 2
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboemployeeCloseUp
    end
    object chkIsPercentage: TwwCheckBox
      Left = 170
      Top = 342
      Width = 17
      Height = 17
      HelpContext = 704011
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      DataField = 'IsPercentage'
      DataSource = dsProdcommission
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = chkIsPercentageClick
    end
    object wwCheckBox2: TwwCheckBox
      Left = 146
      Top = 98
      Width = 17
      Height = 17
      HelpContext = 704012
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      DataField = 'ForAllEmployees'
      DataSource = dsProdcommission
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object wwDBEdit1: TwwDBEdit
      Left = 66
      Top = 339
      Width = 81
      Height = 23
      HelpContext = 704013
      DataField = 'CommissionRate'
      DataSource = dsProdcommission
      Font.Charset = ANSI_CHARSET
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
    object btnGenerate: TDNMSpeedButton
      Left = 432
      Top = 9
      Width = 89
      Height = 27
      HelpContext = 704020
      Caption = 'Multiple'
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
      TabOrder = 9
      OnClick = btnGenerateClick
    end
    object btnProdList: TDNMSpeedButton
      Left = 432
      Top = 45
      Width = 89
      Height = 27
      HelpContext = 704021
      Caption = 'Product'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 10
      OnClick = btnProdListClick
    end
    object optCommissionOnPaid: TwwRadioGroup
      Left = 16
      Top = 133
      Width = 233
      Height = 85
      HelpContext = 704014
      DisableThemes = False
      TransparentActiveItem = True
      Transparent = True
      Caption = 'Commission For'
      DataField = 'CommissionOnPaid'
      DataSource = dsProdcommission
      Items.Strings = (
        'All Invoices'
        'Paid Invoices')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Values.Strings = (
        'F'
        'T')
    end
    object optCommissionInvoiceExPrice: TwwRadioGroup
      Left = 16
      Top = 231
      Width = 233
      Height = 85
      HelpContext = 704015
      DisableThemes = False
      TransparentActiveItem = True
      Transparent = True
      Caption = 'Commission Amount'
      DataField = 'CommissionInvoiceExPrice'
      DataSource = dsProdcommission
      Items.Strings = (
        'Ex Price'
        'Inc Price')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Values.Strings = (
        'T'
        'F')
    end
    object edtOverheadbaserate: TDBEdit
      Left = 440
      Top = 339
      Width = 54
      Height = 23
      HelpContext = 704022
      DataField = 'Overheadbaserate'
      DataSource = dsProdcommission
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnEnter = edtOverheadbaserateEnter
    end
    object optCommissionOn: TwwRadioGroup
      Left = 287
      Top = 133
      Width = 233
      Height = 183
      HelpContext = 704016
      DisableThemes = False
      Caption = 'Commission On'
      DataField = 'CommissionOn'
      DataSource = dsProdcommission
      Items.Strings = (
        'Invoice Value'
        'Gross Profit'
        'Landed Cost'
        'Landed Cost with Overhead'
        'Gross Profit with Overhead'
        'Total Landed Cost')
      TabOrder = 5
      Values.Strings = (
        'I'
        'G'
        'L'
        'LO'
        'GO'
        'LT')
      OnChange = optCommissionOnChange
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 11
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 168
    Top = 11
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 61
    Top = 11
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    HelpContext = 704020
    Left = 274
    Top = 11
  end
  inherited imgsort: TImageList
    Left = 114
    Top = 11
    Bitmap = {
      494C0101020054006C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryProdcommission: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblProductcommission')
    Left = 488
    Top = 11
    object qryProdcommissionProductCommissionId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ProductCommissionId'
      Origin = 'tblProductcommission.ProductCommissionId'
    end
    object qryProdcommissionPartsId: TIntegerField
      FieldName = 'PartsId'
      Origin = 'tblProductcommission.PartsId'
    end
    object qryProdcommissionGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblProductcommission.GlobalRef'
      Size = 255
    end
    object qryProdcommissionIsPercentage: TWideStringField
      FieldName = 'IsPercentage'
      Origin = 'tblProductcommission.IsPercentage'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionCommissionRate: TFloatField
      FieldName = 'CommissionRate'
      Origin = 'tblProductcommission.CommissionRate'
    end
    object qryProdcommissionActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblProductcommission.Active'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblProductcommission.msTimeStamp'
    end
    object qryProdcommissionEmployeeId: TLargeintField
      FieldName = 'EmployeeId'
      Origin = 'tblProductcommission.EmployeeId'
    end
    object qryProdcommissionPartname: TWideStringField
      FieldName = 'Partname'
      Origin = 'tblProductcommission.Partname'
      Size = 100
    end
    object qryProdcommissionForAllEmployees: TWideStringField
      FieldName = 'ForAllEmployees'
      Origin = 'tblProductcommission.ForAllEmployees'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionEmployeeName: TWideStringField
      FieldKind = fkLookup
      FieldName = 'EmployeeName'
      LookupDataSet = QryEmployee
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'employeename'
      KeyFields = 'EmployeeId'
      Size = 100
      Lookup = True
    end
    object qryProdcommissionCommissionOnPaid: TWideStringField
      FieldName = 'CommissionOnPaid'
      Origin = 'tblProductcommission.CommissionOnPaid'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionCommissionInvoiceExPrice: TWideStringField
      FieldName = 'CommissionInvoiceExPrice'
      Origin = 'tblProductcommission.CommissionInvoiceExPrice'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionOverheadbaserate: TFloatField
      FieldName = 'Overheadbaserate'
      Origin = 'tblProductcommission.CommissionOn'
    end
    object qryProdcommissionCommissionOn: TWideStringField
      FieldName = 'CommissionOn'
      FixedChar = True
      Size = 2
    end
  end
  object QryEmployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`EmployeeID`,'
      
        'concat_Ws('#39' '#39' , `Title`,`FirstName`,`MiddleName`,`LastName`) as ' +
        'employeename'
      'from tblemployees')
    Left = 381
    Top = 11
    object QryEmployeeemployeename: TWideStringField
      DisplayWidth = 128
      FieldName = 'employeename'
      Origin = '.employeename'
      Size = 128
    end
    object QryEmployeeEmployeeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmployeeID'
      Origin = 'tblemployees.EmployeeID'
      Visible = False
    end
  end
  object qryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select PartsId, Partname from tblParts where active = "T" order ' +
        'by partname')
    Left = 434
    Top = 11
    object qryPartsPartname: TWideStringField
      DisplayWidth = 60
      FieldName = 'Partname'
      Size = 60
    end
    object qryPartsPartsId: TIntegerField
      FieldName = 'PartsId'
      Visible = False
    end
  end
  object dsProdcommission: TDataSource
    DataSet = qryProdcommission
    Left = 328
    Top = 11
  end
end
