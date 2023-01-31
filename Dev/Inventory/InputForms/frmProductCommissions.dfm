inherited fmProductCommissions: TfmProductCommissions
  Left = 292
  Top = 368
  HelpContext = 705000
  Caption = 'fmProductCommissions'
  ClientHeight = 439
  ClientWidth = 773
  OldCreateOrder = True
  ExplicitLeft = 292
  ExplicitTop = 368
  ExplicitWidth = 789
  ExplicitHeight = 478
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 439
    Width = 773
    ExplicitTop = 439
    ExplicitWidth = 773
    HelpContext = 705030
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 247
    Top = 64
    Width = 526
    Height = 375
    HelpContext = 705005
    Align = alClient
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    Transparent = False
    object Bevel3: TBevel
      Left = 16
      Top = 274
      Width = 504
      Height = 49
      HelpContext = 705006
    end
    object Bevel2: TBevel
      Left = 16
      Top = 32
      Width = 504
      Height = 49
      HelpContext = 705007
    end
    object Label2: TLabel
      Left = 26
      Top = 296
      Width = 26
      Height = 15
      HelpContext = 705008
      Caption = 'Rate'
      Transparent = True
    end
    object Label3: TLabel
      Left = 26
      Top = 52
      Width = 107
      Height = 15
      HelpContext = 705009
      Caption = 'For All Employees?'
      Transparent = True
    end
    object Label4: TLabel
      Left = 198
      Top = 296
      Width = 86
      Height = 15
      HelpContext = 705010
      Caption = 'Is Percentage?'
      Transparent = True
    end
    object lblEmployee: TLabel
      Left = 232
      Top = 52
      Width = 58
      Height = 15
      HelpContext = 705011
      Caption = 'Employee '
      Transparent = True
    end
    object lblOHbase: TLabel
      Left = 331
      Top = 296
      Width = 90
      Height = 15
      HelpContext = 705024
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
      Top = 294
      Width = 10
      Height = 18
      HelpContext = 705025
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
    object cboemployee: TwwDBLookupCombo
      Left = 296
      Top = 48
      Width = 217
      Height = 23
      HelpContext = 705012
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'employeename'#9'30'#9'Employee'#9'F')
      DataField = 'EmployeeName'
      DataSource = dsProdcommissions
      LookupTable = QryEmployee
      LookupField = 'EmployeeID'
      ParentFont = False
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnChange = dodatachanged
      OnCloseUp = cboemployeeCloseUp
    end
    object chkIsPercentage: TwwCheckBox
      Left = 170
      Top = 295
      Width = 17
      Height = 17
      HelpContext = 705013
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Checked = True
      DataField = 'IsPercentage'
      DataSource = dsProdcommissions
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 1
      OnClick = chkIsPercentageClick
    end
    object wwCheckBox2: TwwCheckBox
      Left = 146
      Top = 51
      Width = 17
      Height = 17
      HelpContext = 705014
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Checked = True
      DataField = 'ForAllEmployees'
      DataSource = dsProdcommissions
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
      OnClick = dodatachanged
    end
    object wwDBEdit1: TwwDBEdit
      Left = 66
      Top = 292
      Width = 81
      Height = 23
      HelpContext = 705015
      DataField = 'CommissionRate'
      DataSource = dsProdcommissions
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnChange = dodatachanged
    end
    object btnGenerate: TDNMSpeedButton
      Left = 432
      Top = 4
      Width = 89
      Height = 27
      HelpContext = 705026
      Caption = 'Single'
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
      TabOrder = 4
    end
    object optCommissionOnPaid: TwwRadioGroup
      Left = 16
      Top = 86
      Width = 233
      Height = 85
      HelpContext = 705016
      DisableThemes = False
      TransparentActiveItem = True
      Transparent = True
      Caption = 'Commission For'
      DataField = 'CommissionOnPaid'
      DataSource = dsProdcommissions
      Items.Strings = (
        'All Invoices'
        'Paid Invoices')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      Values.Strings = (
        'F'
        'T')
      OnChange = dodatachanged
    end
    object optCommissionInvoiceExPrice: TwwRadioGroup
      Left = 16
      Top = 184
      Width = 233
      Height = 85
      HelpContext = 705017
      DisableThemes = False
      TransparentActiveItem = True
      Transparent = True
      Caption = 'Commission Amount'
      DataField = 'CommissionInvoiceExPrice'
      DataSource = dsProdcommissions
      Items.Strings = (
        'Ex Price'
        'Inc Price')
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      Values.Strings = (
        'T'
        'F')
      OnChange = dodatachanged
    end
    object pnlBottom: TDNMPanel
      Left = 2
      Top = 327
      Width = 522
      Height = 46
      HelpContext = 705027
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      DesignSize = (
        522
        46)
      object btnSave: TDNMSpeedButton
        Left = 119
        Top = 11
        Width = 87
        Height = 27
        HelpContext = 705018
        Anchors = [akBottom]
        Caption = '&Update'
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
        TabOrder = 0
        OnClick = btnSaveClick
      end
      object btnCancel: TDNMSpeedButton
        Left = 311
        Top = 11
        Width = 87
        Height = 27
        HelpContext = 705028
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
        TabOrder = 1
        OnClick = btnCancelClick
      end
    end
    object optCommissionOn: TwwRadioGroup
      Left = 287
      Top = 86
      Width = 233
      Height = 183
      HelpContext = 705019
      DisableThemes = False
      Caption = 'Commission On'
      DataField = 'CommissionOn'
      DataSource = dsProdcommissions
      Items.Strings = (
        'Invoice Value'
        'Gross Profit'
        'Landed Cost'
        'Gross Profit with Overhead'
        'Total Landed Cost')
      TabOrder = 8
      Values.Strings = (
        'I'
        'G'
        'L'
        'GO'
        'LT')
      OnChange = optCommissionOnChange
    end
    object edtOverheadbaserate: TDBEdit
      Left = 440
      Top = 292
      Width = 54
      Height = 23
      HelpContext = 705029
      DataField = 'Overheadbaserate'
      DataSource = dsProdcommissions
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnChange = dodatachanged
      OnEnter = edtOverheadbaserateEnter
    end
  end
  object pnlTop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 773
    Height = 64
    HelpContext = 705020
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      773
      64)
    object pnlTitle: TDNMPanel
      Left = 101
      Top = 6
      Width = 550
      Height = 45
      HelpContext = 705021
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
        Width = 546
        Height = 41
        HelpContext = 705022
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
          Width = 546
          Height = 41
          HelpContext = 705023
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
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 64
    Width = 247
    Height = 375
    HelpContext = 705001
    Align = alLeft
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
    DesignSize = (
      247
      375)
    object Bevel5: TBevel
      Left = 6
      Top = 34
      Width = 236
      Height = 337
      HelpContext = 705002
      Anchors = [akLeft, akTop, akRight, akBottom]
    end
    object t: TwwDBGrid
      Left = 12
      Top = 39
      Width = 223
      Height = 324
      HelpContext = 705003
      Selected.Strings = (
        'PArtname'#9'26'#9'Product Name'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsParts
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
      FooterColor = clWhite
    end
    object btnProdList: TDNMSpeedButton
      Left = 8
      Top = 4
      Width = 89
      Height = 25
      HelpContext = 705004
      Caption = 'Product List'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 0
      OnClick = btnProdListClick
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200B400C80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryProdcommissions: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblProductcommission')
    AfterInsert = qryProdcommissionsAfterInsert
    Left = 488
    Top = 11
    object qryProdcommissionsProductCommissionId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ProductCommissionId'
      Origin = 'tblProductcommission.ProductCommissionId'
    end
    object qryProdcommissionsPartsId: TIntegerField
      FieldName = 'PartsId'
      Origin = 'tblProductcommission.PartsId'
    end
    object qryProdcommissionsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblProductcommission.GlobalRef'
      Size = 255
    end
    object qryProdcommissionsIsPercentage: TWideStringField
      FieldName = 'IsPercentage'
      Origin = 'tblProductcommission.IsPercentage'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionsCommissionRate: TFloatField
      FieldName = 'CommissionRate'
      Origin = 'tblProductcommission.CommissionRate'
    end
    object qryProdcommissionsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblProductcommission.Active'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblProductcommission.msTimeStamp'
    end
    object qryProdcommissionsEmployeeId: TLargeintField
      FieldName = 'EmployeeId'
      Origin = 'tblProductcommission.EmployeeId'
    end
    object qryProdcommissionsPartname: TWideStringField
      FieldName = 'Partname'
      Origin = 'tblProductcommission.Partname'
      Size = 100
    end
    object qryProdcommissionsForAllEmployees: TWideStringField
      FieldName = 'ForAllEmployees'
      Origin = 'tblProductcommission.ForAllEmployees'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionsEmployeeName: TWideStringField
      FieldKind = fkLookup
      FieldName = 'EmployeeName'
      LookupDataSet = QryEmployee
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'employeename'
      KeyFields = 'EmployeeId'
      Size = 100
      Lookup = True
    end
    object qryProdcommissionsCommissionOnPaid: TWideStringField
      FieldName = 'CommissionOnPaid'
      Origin = 'tblProductcommission.CommissionOnPaid'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionsCommissionInvoiceExPrice: TWideStringField
      FieldName = 'CommissionInvoiceExPrice'
      Origin = 'tblProductcommission.CommissionInvoiceExPrice'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionsOverheadbaserate: TFloatField
      FieldName = 'Overheadbaserate'
      Origin = 'tblProductcommission.Overheadbaserate'
    end
    object qryProdcommissionsCommissionOn: TWideStringField
      FieldName = 'CommissionOn'
      Origin = 'tblProductcommission.CommissionOn'
      FixedChar = True
      Size = 2
    end
  end
  object dsProdcommissions: TDataSource
    DataSet = qryProdcommissions
    Left = 328
    Top = 11
  end
  object qryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Distinct P.PARTSID,P.PARTNAME'
      'FROM tblparts AS P  '
      'WHERE P.Active =  "T" AND P.PARTSID IN  (0)')
    Left = 516
    object qryPartsPArtname: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 26
      FieldName = 'PArtname'
      Origin = 'tblparts.PARTNAME'
      Size = 60
    end
    object qryPartsPARTSID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PARTSID'
      Visible = False
    end
  end
  object dsParts: TDataSource
    DataSet = qryParts
    Left = 447
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
      DisplayLabel = 'Employee'
      DisplayWidth = 30
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
  object qryProdcommission: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblProductcommission')
    Left = 624
    Top = 11
    object qryProdcommissionProductCommissionId: TIntegerField
      FieldName = 'ProductCommissionId'
    end
    object qryProdcommissionPartsId: TIntegerField
      FieldName = 'PartsId'
    end
    object qryProdcommissionGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryProdcommissionIsPercentage: TWideStringField
      FieldName = 'IsPercentage'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionCommissionRate: TFloatField
      FieldName = 'CommissionRate'
    end
    object qryProdcommissionActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryProdcommissionEmployeeId: TLargeintField
      FieldName = 'EmployeeId'
    end
    object qryProdcommissionPartname: TWideStringField
      FieldName = 'Partname'
      Size = 100
    end
    object qryProdcommissionForAllEmployees: TWideStringField
      FieldName = 'ForAllEmployees'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionCommissionOnPaid: TWideStringField
      FieldName = 'CommissionOnPaid'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionCommissionInvoiceExPrice: TWideStringField
      FieldName = 'CommissionInvoiceExPrice'
      FixedChar = True
      Size = 1
    end
    object qryProdcommissionOverheadbaserate: TFloatField
      FieldName = 'Overheadbaserate'
    end
    object qryProdcommissionCommissionOn: TWideStringField
      FieldName = 'CommissionOn'
      FixedChar = True
      Size = 2
    end
  end
end
