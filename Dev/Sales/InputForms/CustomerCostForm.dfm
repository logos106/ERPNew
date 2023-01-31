inherited CustomerCostGUI: TCustomerCostGUI
  Left = 252
  Top = 170
  HelpContext = 77000
  Caption = 'Customer Costs'
  ClientHeight = 449
  ClientWidth = 814
  OldCreateOrder = True
  Position = poScreenCenter
  ExplicitLeft = 252
  ExplicitTop = 170
  ExplicitWidth = 830
  ExplicitHeight = 488
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 399
    Width = 814
    HelpContext = 77023
    ExplicitTop = 399
    ExplicitWidth = 814
  end
  inherited imgGridWatermark: TImage
    HelpContext = 77001
  end
  object pnlFooter: TDNMPanel [5]
    Left = 0
    Top = 399
    Width = 814
    Height = 50
    HelpContext = 77002
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      814
      50)
    object btnOK: TDNMSpeedButton
      Left = 143
      Top = 13
      Width = 87
      Height = 27
      HelpContext = 77003
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
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnOKClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 568
      Top = 13
      Width = 87
      Height = 27
      HelpContext = 77004
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 287
      Top = 13
      Width = 87
      Height = 27
      HelpContext = 77005
      Anchors = [akBottom]
      Caption = '&Print'
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
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnPrintClick
    end
    object btnSelectAll: TDNMSpeedButton
      Left = 431
      Top = 13
      Width = 87
      Height = 27
      HelpContext = 77006
      Anchors = [akBottom]
      Caption = 'Select &All'
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
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnSelectAllClick
    end
    object DNMPanel1: TDNMPanel
      Left = 688
      Top = 12
      Width = 99
      Height = 26
      HelpContext = 77007
      Anchors = [akBottom]
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      DesignSize = (
        99
        26)
      object Label1: TLabel
        Left = 30
        Top = 4
        Width = 59
        Height = 15
        HelpContext = 77008
        Anchors = [akBottom]
        Caption = 'Show BOs'
        Transparent = True
      end
      object chkShowBO: TwwCheckBox
        Left = 10
        Top = 4
        Width = 15
        Height = 17
        HelpContext = 77009
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Anchors = [akBottom]
        TabOrder = 0
        OnClick = chkShowBOClick
      end
    end
  end
  object pnlDetail: TDNMPanel [6]
    Left = 0
    Top = 105
    Width = 814
    Height = 294
    HelpContext = 77015
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object pgeCosts: TPageControl
      Left = 0
      Top = 0
      Width = 814
      Height = 294
      HelpContext = 77016
      ActivePage = tabTimesheet
      Align = alClient
      TabHeight = 25
      TabOrder = 0
      TabWidth = 270
      OnChange = pgeCostsChange
      object tabProducts: TTabSheet
        HelpContext = 77017
        Caption = '&Products'
        object grdProductCosts: TwwDBGrid
          Left = 0
          Top = 0
          Width = 806
          Height = 259
          HelpContext = 77018
          ControlType.Strings = (
            'UseTimeCost;CheckBox;True;False')
          Selected.Strings = (
            'UseTimeCost'#9'1'#9'Use'#9'F'
            'PurchaseOrderNumber'#9'10'#9'PO # | CT #'#9'T'
            'Date'#9'12'#9'Date'#9'T'
            'ProductName'#9'15'#9'Product'#9'T'
            'ProductDescription'#9'20'#9'Description'#9'T'
            'Quantity'#9'5'#9'Qty'#9'T'
            'LineCost'#9'10'#9'Cost (Ex)'#9'T'
            'LineTax'#9'10'#9'Tax'#9'T'
            'LineTaxCode'#9'5'#9'Tax Code'#9'T'
            'LineCostInc'#9'10'#9'Cost Amt'#9'T'
            'DocketNumber'#9'15'#9'Docket Number'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alClient
          Ctl3D = True
          DataSource = dsProducts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
          ParentCtl3D = False
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
          UseTFields = False
          FooterColor = clWhite
          FooterCellColor = clWhite
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
        end
      end
      object tabExpenses: TTabSheet
        HelpContext = 77019
        Caption = '&Expenses'
        ImageIndex = 1
        object grdCostExpenses: TwwDBGrid
          Left = 0
          Top = 0
          Width = 806
          Height = 259
          HelpContext = 77020
          ControlType.Strings = (
            'UseTimeCost;CheckBox;T;F')
          Selected.Strings = (
            'UseTimeCost'#9'1'#9'Use'#9#9
            'Type'#9'10'#9'Type'#9'T'
            'OrderDate'#9'12'#9'Date'#9'T'
            'SupplierName'#9'28'#9'Supplier'#9'T'
            'LineCost'#9'10'#9'Amount'#9'T'
            'LineTax'#9'10'#9'Tax Amt'#9'T'
            'LineCostInc'#9'10'#9'Cost Amt'#9'T'
            'TimeCostPrice'#9'10'#9'Price (Ex)'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alClient
          DataSource = dsExpenseCosts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
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
          UseTFields = False
          FooterColor = clWhite
          FooterCellColor = clWhite
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
        end
      end
      object tabTimesheet: TTabSheet
        HelpContext = 77021
        Caption = '&Timesheet'
        ImageIndex = 2
        object grdCostPayroll: TwwDBGrid
          Left = 0
          Top = 0
          Width = 806
          Height = 259
          HelpContext = 77022
          ControlType.Strings = (
            'UseTimeCost;CheckBox;T;F')
          Selected.Strings = (
            'UseTimeCost'#9'1'#9'Use'#9'F'
            'EquipmentName'#9'1'#9'Equipment'#9'T'
            'Type'#9'5'#9'Type'#9'T'
            'Date'#9'10'#9'Date'#9'T'
            'Name'#9'15'#9'Employee'#9'T'
            'Service'#9'13'#9'Service'#9'T'
            'Hours'#9'1'#9'Hours'#9'T'
            'PartName'#9'17'#9'Description'#9'F'
            'Cost'#9'13'#9'Cost / Hour (Inc)'#9'T'
            'Amount'#9'14'#9'Rate / Hour (Inc)'#9'T')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alClient
          DataSource = dsPayrollCosts
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgFixedProportionalResize]
          ParentFont = False
          TabOrder = 0
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
          FooterCellColor = clWhite
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
        end
      end
    end
  end
  object pnlHeader: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 814
    Height = 105
    HelpContext = 77010
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
      814
      105)
    object pnlCustomer: TPanel
      Left = 40
      Top = 69
      Width = 730
      Height = 25
      HelpContext = 77011
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnlTitle: TDNMPanel
      Left = 257
      Top = 6
      Width = 289
      Height = 45
      HelpContext = 77012
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
        Width = 285
        Height = 41
        HelpContext = 77013
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
          Width = 285
          Height = 41
          HelpContext = 77014
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Customer Costs'
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
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020048004C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object dsProducts: TDataSource
    DataSet = tblProductCosts
    Left = 688
    Top = 360
  end
  object qryExpenseCosts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'tblPurchaseLines.PurchaseOrderId,'
      'SaleID_TimeCost,'
      'PurchaseLineID, '
      'UseTimeCost,'
      'TimeCostPrice,'
      'tblPurchaseOrders.OrderDate'
      'FROM tblPurchaseLines'
      
        'INNER JOIN tblpurchaseorders ON tblPurchaseLines.PurchaseOrderID' +
        ' = tblPurchaseOrders.PurchaseOrderID'
      
        'where (tblPurchaseLines.UseTimeCost = "F" or tblPurchaseLines.Sa' +
        'leID_TimeCost = :xSaleID) and'
      
        'tblPurchaseLines.PurchaseOrderID in (Select PurchaseOrderId from' +
        ' tblPurchaseOrders where tblPurchaseOrders.PurchaseOrderID = tbl' +
        'PurchaseLines.PurchaseOrderID  and  ((tblPurchaseOrders.IsBill =' +
        ' "T" OR tblPurchaseOrders.IsCheque = "T"  OR tblPurchaseOrders.I' +
        'sCredit = "T") and (tblPurchaseLines.CustomerJobID = :xCustomerJ' +
        'obID)) )')
    BeforePost = qryExpenseCostsBeforePost
    Left = 720
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xSaleID'
      end
      item
        DataType = ftUnknown
        Name = 'xCustomerJobID'
      end>
    object qryExpenseCostsSaleID_TimeCost: TIntegerField
      FieldName = 'SaleID_TimeCost'
      Origin = 'tblPurchaseLines.SaleID_Timecost'
    end
    object qryExpenseCostsPurchaseLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PurchaseLineID'
      Origin = 'tblPurchaseLines.PurchaseLineID'
    end
    object qryExpenseCostsUseTimeCost: TWideStringField
      FieldName = 'UseTimeCost'
      Origin = 'tblPurchaseLines.UseTimecost'
      FixedChar = True
      Size = 1
    end
    object qryExpenseCostsTimeCostPrice: TFloatField
      FieldName = 'TimeCostPrice'
      Origin = 'tblPurchaseLines.TimecostPrice'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object qryExpenseCostsPurchaseOrderId: TIntegerField
      FieldName = 'PurchaseOrderId'
      Origin = 'tblPurchaseLines.PurchaseOrderID'
    end
    object qryExpenseCostsType: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Type'
      LookupDataSet = LookupPurchaseOrders
      LookupKeyFields = 'PurchaseOrderID'
      LookupResultField = 'Type'
      KeyFields = 'PurchaseOrderId'
      Lookup = True
    end
    object qryExpenseCostsSupplierName: TWideStringField
      FieldKind = fkLookup
      FieldName = 'SupplierName'
      LookupDataSet = LookupPurchaseOrders
      LookupKeyFields = 'PurchaseOrderID'
      LookupResultField = 'SupplierName'
      KeyFields = 'PurchaseOrderId'
      Lookup = True
    end
    object qryExpenseCostsLineCost: TFloatField
      FieldKind = fkLookup
      FieldName = 'LineCost'
      LookupDataSet = LookupPurchaseOrders
      LookupKeyFields = 'PurchaseOrderID'
      LookupResultField = 'LineCost'
      KeyFields = 'PurchaseOrderId'
      Lookup = True
    end
    object qryExpenseCostsLineTax: TFloatField
      FieldKind = fkLookup
      FieldName = 'LineTax'
      LookupDataSet = LookupPurchaseOrders
      LookupKeyFields = 'PurchaseOrderID'
      LookupResultField = 'LineTax'
      KeyFields = 'PurchaseOrderId'
      Lookup = True
    end
    object qryExpenseCostsLineCostInc: TFloatField
      FieldKind = fkLookup
      FieldName = 'LineCostInc'
      LookupDataSet = LookupPurchaseOrders
      LookupKeyFields = 'PurchaseOrderID'
      LookupResultField = 'LineCostInc'
      KeyFields = 'PurchaseOrderId'
      Lookup = True
    end
    object qryExpenseCostsTotalLineAmount: TFloatField
      FieldKind = fkLookup
      FieldName = 'TotalLineAmount'
      LookupDataSet = LookupPurchaseOrders
      LookupKeyFields = 'PurchaseOrderID'
      LookupResultField = 'TotalLineAmount'
      KeyFields = 'PurchaseOrderId'
      Lookup = True
    end
    object qryExpenseCostsOrderDate: TDateTimeField
      FieldName = 'OrderDate'
    end
  end
  object dsExpenseCosts: TDataSource
    DataSet = qryExpenseCosts
    Left = 720
    Top = 360
  end
  object cdsResults: TkbmMemTable
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
    Left = 656
    Top = 328
    object cdsResultsUseTimeCost: TWideStringField
      FieldName = 'UseTimeCost'
      FixedChar = True
      Size = 1
    end
    object cdsResultsOrderDate: TDateField
      FieldName = 'OrderDate'
    end
    object cdsResultsProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 60
    end
    object cdsResultsProductID: TIntegerField
      FieldName = 'ProductID'
    end
    object cdsResultsProduct_Description: TWideStringField
      FieldName = 'Product_Description'
      Size = 255
    end
    object cdsResultsShipped: TFloatField
      FieldName = 'Shipped'
    end
    object cdsResultsLineCost: TFloatField
      FieldName = 'LineCost'
    end
    object cdsResultsLineTax: TFloatField
      FieldName = 'LineTax'
    end
    object cdsResultsLineTaxCode: TWideStringField
      FieldName = 'LineTaxCode'
      Size = 5
    end
    object cdsResultsLineCostInc: TFloatField
      FieldName = 'LineCostInc'
    end
    object cdsResultsTotalLineAmount: TFloatField
      FieldName = 'TotalLineAmount'
    end
    object cdsResultsPurchaseLineID: TAutoIncField
      FieldName = 'PurchaseLineID'
      ReadOnly = True
    end
    object cdsResultsSaleID_TimeCost: TIntegerField
      FieldName = 'SaleID_TimeCost'
    end
    object cdsResultsTimeCostPrice: TFloatField
      FieldName = 'TimeCostPrice'
    end
    object cdsResultsEntryType: TWideStringField
      FieldName = 'EntryType'
      Size = 255
    end
    object cdsResultsPurchaseOrderNumber: TWideStringField
      FieldName = 'PurchaseOrderNumber'
      Size = 30
    end
    object cdsResultsDocketNumber: TWideStringField
      FieldName = 'DocketNumber'
      Size = 255
    end
    object cdsResultsSaleLineID: TIntegerField
      FieldName = 'SaleLineID'
    end
  end
  object dsPayrollCosts: TDataSource
    DataSet = qryPayrollCosts
    Left = 752
    Top = 360
  end
  object qryPayrollCosts: TERPQuery
    SQL.Strings = (
      'SELECT'
      'T.ID,'
      'T.UseTimeCost,'
      #39'Timesheet'#39' AS Type,'
      'Cast(T.TimeSheetDate AS Date) as Date,'
      'T.ServiceName AS Service,'
      'T.EmployeeName AS Name,'
      'T.ChargeRate AS Amount,'
      'T.LabourCost AS Cost,'
      'T.PartID AS PartID,'
      'T.PartName AS PartName,'
      'T.SalesID AS SalesID,'
      'T.Hours AS Hours, '
      'E.EquipmentName'
      'FROM tbltimesheets T'
      
        'Left  Join `tblcustomerequip` AS `CE` ON `T`.`CustomerEquipmentI' +
        'D` = `CE`.`id`'
      
        'Left Join `tblequipment` AS `E` ON `CE`.`EquipmentID` = `E`.`Equ' +
        'ipmentID`'
      'WHERE ((JobID = :xJobID AND UseTimeCost = '#39'F'#39') OR'
      '(JobID = :xJobID2 AND UseTimeCost = '#39'T'#39' AND SalesID = :xSaleID))'
      'ORDER BY Date')
    Left = 752
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xJobID'
      end
      item
        DataType = ftUnknown
        Name = 'xJobID2'
      end
      item
        DataType = ftUnknown
        Name = 'xSaleID'
      end>
    object qryPayrollCostsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object qryPayrollCostsUseTimeCost: TWideStringField
      FieldName = 'UseTimeCost'
      OnChange = qryPayrollCostsUseTimeCostChange
      FixedChar = True
      Size = 1
    end
    object qryPayrollCostsType: TWideStringField
      FieldName = 'Type'
      ReadOnly = True
      FixedChar = True
      Size = 9
    end
    object qryPayrollCostsDate: TDateField
      FieldName = 'Date'
    end
    object qryPayrollCostsService: TWideStringField
      FieldName = 'Service'
      Size = 255
    end
    object qryPayrollCostsName: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object qryPayrollCostsAmount: TFloatField
      FieldName = 'Amount'
      currency = True
    end
    object qryPayrollCostsCost: TFloatField
      FieldName = 'Cost'
      currency = True
    end
    object qryPayrollCostsPartID: TIntegerField
      FieldName = 'PartID'
    end
    object qryPayrollCostsPartName: TWideStringField
      FieldName = 'PartName'
      Size = 40
    end
    object qryPayrollCostsSalesID: TIntegerField
      FieldName = 'SalesID'
    end
    object qryPayrollCostsHours: TFloatField
      FieldName = 'Hours'
    end
    object qryPayrollCostsEquipmentName: TWideStringField
      FieldName = 'EquipmentName'
      Size = 100
    end
  end
  object tblProductCosts: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'PurchaseLineID'
        DataType = ftInteger
      end
      item
        Name = 'UseTimeCost'
        DataType = ftBoolean
      end
      item
        Name = 'PurchaseOrderNumber'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'Date'
        DataType = ftDateTime
      end
      item
        Name = 'ProductID'
        DataType = ftInteger
      end
      item
        Name = 'ProductName'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'ProductDescription'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Quantity'
        DataType = ftFloat
      end
      item
        Name = 'LineCost'
        DataType = ftCurrency
      end
      item
        Name = 'LineTax'
        DataType = ftCurrency
      end
      item
        Name = 'LineTaxCode'
        DataType = ftWideString
        Size = 5
      end
      item
        Name = 'LineCostInc'
        DataType = ftCurrency
      end
      item
        Name = 'TotalLineAmount'
        DataType = ftFloat
      end
      item
        Name = 'SaleID_TimeCost'
        DataType = ftCurrency
      end
      item
        Name = 'TimeCostPrice'
        DataType = ftCurrency
      end
      item
        Name = 'DocketNumber'
        DataType = ftWideString
        Size = 255
      end>
    IndexFieldNames = 'PurchaseLineID'
    IndexName = 'PurchaseLineID'
    IndexDefs = <
      item
        Name = 'PurchaseLineID'
        Fields = 'PurchaseLineID'
        Options = [ixPrimary, ixUnique]
      end>
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
    Left = 688
    Top = 328
    object tblProductCostsPurchaseLineID: TIntegerField
      FieldName = 'PurchaseLineID'
    end
    object tblProductCostsUseTimeCost: TBooleanField
      FieldName = 'UseTimeCost'
      OnChange = tblProductCostsUseTimeCostChange
    end
    object tblProductCostsPurchaseOrderNumber: TWideStringField
      FieldName = 'PurchaseOrderNumber'
    end
    object tblProductCostsDate: TDateTimeField
      FieldName = 'Date'
    end
    object tblProductCostsProductName: TIntegerField
      FieldName = 'ProductID'
    end
    object StringField1: TWideStringField
      FieldName = 'ProductName'
      Size = 255
    end
    object tblProductCostsProductDescription: TWideStringField
      FieldName = 'ProductDescription'
      Size = 255
    end
    object tblProductCostsQuantity: TFloatField
      FieldName = 'Quantity'
    end
    object tblProductCostsLineCost: TCurrencyField
      FieldName = 'LineCost'
    end
    object tblProductCostsLineTax: TCurrencyField
      FieldName = 'LineTax'
    end
    object tblProductCostsLineTaxCode: TWideStringField
      FieldName = 'LineTaxCode'
      Size = 5
    end
    object tblProductCostsLineCostInc: TCurrencyField
      FieldName = 'LineCostInc'
    end
    object tblProductCostsTotalLineAmount: TFloatField
      FieldName = 'TotalLineAmount'
    end
    object tblProductCostsSaleID_TimeCost: TCurrencyField
      FieldName = 'SaleID_TimeCost'
    end
    object tblProductCostsTimeCostPrice: TCurrencyField
      FieldName = 'TimeCostPrice'
    end
    object tblProductCostsDocketNumber: TWideStringField
      FieldName = 'DocketNumber'
      Size = 255
    end
  end
  object LookupPurchaseOrders: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'tblPurchaseOrders.PurchaseOrderID,'
      'tblPurchaseOrders.PurchaseOrderNumber,'
      
        'tblPurchaseLines.PurchaseLineID, tblPurchaseLines.UseTimeCost, t' +
        'blPurchaseOrders.OrderDate,'
      
        'If(tblPurchaseOrders.IsCredit='#39'T'#39','#39'Credit'#39',If(tblPurchaseOrders.' +
        'IsCheque='#39'T'#39','#39'Cheque'#39','#39'Bill'#39')) AS Type,'
      'tblPurchaseOrders.SupplierName,'
      
        'If(tblPurchaseOrders.IsCredit='#39'T'#39',-tblPurchaseLines.LineCost,tbl' +
        'PurchaseLines.LineCost) as LineCost,'
      
        'If(tblPurchaseOrders.IsCredit='#39'T'#39',-tblPurchaseLines.LineTax,tblP' +
        'urchaseLines.LineTax) as LineTax,'
      
        'If(tblPurchaseOrders.IsCredit='#39'T'#39',-tblPurchaseLines.LineCostInc,' +
        'tblPurchaseLines.LineCostInc) as LineCostInc,'
      
        'If(tblPurchaseOrders.IsCredit='#39'T'#39',-tblPurchaseLines.TotalLineAmo' +
        'unt,tblPurchaseLines.TotalLineAmount) as TotalLineAmount,'
      'tblPurchaseLines.SaleID_TimeCost,'
      'tblPurchaseLines.TimeCostPrice'
      'FROM tblPurchaseLines'
      
        'LEFT JOIN tblPurchaseOrders on tblPurchaseOrders.PurchaseOrderID' +
        ' = tblPurchaseLines.PurchaseOrderID'
      
        'WHERE (tblPurchaseOrders.IsBill = "T" OR tblPurchaseOrders.IsChe' +
        'que = "T"  OR tblPurchaseOrders.IsCredit = "T") and (tblPurchase' +
        'Lines.CustomerJobID = :xCustomerJobID) AND'
      
        '(tblPurchaseLines.UseTimeCost = "F" or tblPurchaseLines.SaleID_T' +
        'imeCost = :xSaleID);')
    BeforePost = qryExpenseCostsBeforePost
    Left = 720
    Top = 297
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xCustomerJobID'
      end
      item
        DataType = ftUnknown
        Name = 'xSaleID'
      end>
    object LookupPurchaseOrdersPurchaseOrderNumber: TWideStringField
      FieldName = 'PurchaseOrderNumber'
      Origin = 'tblPurchaseOrders.PurchaseOrderNumber'
      Size = 30
    end
    object LookupPurchaseOrdersPurchaseLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PurchaseLineID'
      Origin = 'tblPurchaseLines.PurchaseLineID'
    end
    object LookupPurchaseOrdersUseTimeCost: TWideStringField
      FieldName = 'UseTimeCost'
      Origin = 'tblPurchaseLines.UseTimecost'
      FixedChar = True
      Size = 1
    end
    object LookupPurchaseOrdersType: TWideStringField
      FieldName = 'Type'
      Origin = '.Type'
      Size = 6
    end
    object LookupPurchaseOrdersSupplierName: TWideStringField
      FieldName = 'SupplierName'
      Origin = 'tblPurchaseOrders.SupplierName'
      Size = 255
    end
    object LookupPurchaseOrdersLineCost: TFloatField
      FieldName = 'LineCost'
      Origin = '.LineCost'
      currency = True
    end
    object LookupPurchaseOrdersLineTax: TFloatField
      FieldName = 'LineTax'
      Origin = '.LineTax'
      currency = True
    end
    object LookupPurchaseOrdersLineCostInc: TFloatField
      FieldName = 'LineCostInc'
      Origin = '.LineCostInc'
      currency = True
    end
    object LookupPurchaseOrdersTotalLineAmount: TFloatField
      FieldName = 'TotalLineAmount'
      Origin = '.TotalLineAmount'
      currency = True
    end
    object LookupPurchaseOrdersSaleID_TimeCost: TIntegerField
      FieldName = 'SaleID_TimeCost'
      Origin = 'tblPurchaseLines.SaleID_Timecost'
    end
    object LookupPurchaseOrdersTimeCostPrice: TFloatField
      FieldName = 'TimeCostPrice'
      Origin = 'tblPurchaseLines.TimecostPrice'
    end
    object LookupPurchaseOrdersPurchaseOrderID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PurchaseOrderID'
      Origin = 'tblPurchaseOrders.PurchaseOrderID'
    end
    object LookupPurchaseOrdersOrderDate: TDateTimeField
      FieldName = 'OrderDate'
    end
  end
end
