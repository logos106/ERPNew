inherited fmTransProductSpec: TfmTransProductSpec
  Left = 805
  Caption = 'Trans Formula Entry'
  ClientHeight = 530
  ClientWidth = 460
  ExplicitLeft = 805
  ExplicitWidth = 476
  ExplicitHeight = 569
  DesignSize = (
    460
    530)
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1674002
  inherited lblSkingroupMsg: TLabel
    Top = 492
    Width = 460
    ExplicitTop = 461
    ExplicitWidth = 477
    HelpContext = 1674003
  end
  inherited shapehint: TShape
    Left = -4
    ExplicitLeft = -4
  end
  inherited shapehintextra1: TShape
    Left = 18
    ExplicitLeft = 19
  end
  object pnlFooter: TDNMPanel [5]
    Left = 0
    Top = 492
    Width = 460
    Height = 38
    HelpContext = 1674004
    Align = alBottom
    Anchors = [akLeft, akRight]
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitTop = 493
    DesignSize = (
      460
      38)
    object btnCompleted: TDNMSpeedButton
      Left = 115
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 1674005
      Anchors = [akTop, akRight]
      Caption = 'Ok'
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      Style = bsModern
      TabOrder = 0
      TabStop = False
    end
    object btnCancel: TDNMSpeedButton
      Left = 241
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 1674006
      Anchors = [akTop, akRight]
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      Style = bsModern
      TabOrder = 1
      TabStop = False
    end
  end
  object pnlHeader: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 460
    Height = 192
    HelpContext = 1674007
    Align = alTop
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 48
      Top = 72
      Width = 48
      Height = 15
      HelpContext = 1674008
      Caption = 'Product '
      Transparent = True
    end
    object Label2: TLabel
      Left = 48
      Top = 129
      Width = 46
      Height = 15
      HelpContext = 1674009
      Caption = 'Formula'
      Transparent = True
    end
    object Label3: TLabel
      Left = 48
      Top = 101
      Width = 33
      Height = 15
      HelpContext = 1674010
      Caption = 'Name'
      Transparent = True
    end
    object edtProductName: TwwDBEdit
      Left = 112
      Top = 70
      Width = 313
      Height = 23
      HelpContext = 1674011
      DataField = 'ProductName'
      DataSource = BaseSaleGUI.dsFESalesLines
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
    end
    object pnlTitle: TDNMPanel
      Left = 122
      Top = 8
      Width = 238
      Height = 45
      HelpContext = 1674012
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 234
        Height = 41
        HelpContext = 1674013
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
          HelpContext = 1674014
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Trans Formula Entry'
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
    object edtFormula: TEdit
      Left = 112
      Top = 125
      Width = 225
      Height = 23
      HelpContext = 1674015
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object btnchooseformula: TDNMSpeedButton
      Left = 343
      Top = 123
      Width = 106
      Height = 27
      HelpContext = 1674016
      Caption = 'Choose Formula'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Style = bsModern
      TabOrder = 3
      OnClick = btnchooseformulaClick
    end
    object edtFormulaWithValue: TEdit
      Left = 112
      Top = 96
      Width = 225
      Height = 23
      HelpContext = 1674017
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object DNMPanel1: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 153
      Width = 454
      Height = 36
      Margins.Top = 0
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      HelpContext = 1674018
      object lblformulaValue1: TLabel
        AlignWithMargins = True
        Left = 374
        Top = 4
        Width = 76
        Height = 28
        HelpContext = 1674019
        Align = alRight
        Alignment = taRightJustify
        Caption = 'FormulaValue'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object lblformulaValue2: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 76
        Height = 28
        HelpContext = 1674020
        Align = alLeft
        Caption = 'FormulaValue'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitHeight = 15
      end
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 310
    Width = 460
    Height = 182
    HelpContext = 1674021
    Align = alClient
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 460
      Height = 161
      HelpContext = 1674022
      Align = alClient
      Shape = bsFrame
      ExplicitWidth = 477
      ExplicitHeight = 224
    end
    object LblMsg: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 164
      Width = 454
      Height = 15
      HelpContext = 1674023
      Align = alBottom
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitWidth = 3
    end
    object grdRelatedPr: TwwDBGrid
      AlignWithMargins = True
      Left = 11
      Top = 11
      Width = 438
      Height = 139
      HelpContext = 1674024
      Margins.Left = 11
      Margins.Top = 11
      Margins.Right = 11
      Margins.Bottom = 11
      ControlType.Strings = (
        'PartName;CustomEdit;cboGroupPartName;T'
        'Active;CheckBox;T;F'
        'ProductName;CustomEdit;cboProductX;F'
        'Formula;CustomEdit;cboFormula;F')
      Selected.Strings = (
        'ProductName'#9'18'#9'ProductName'#9'F'
        'Formula'#9'18'#9'Formula'#9'F'
        'RelatedQty'#9'10'#9'Ordered'#9'F'#9'RelatedQty'
        'RelatedShippedQty'#9'10'#9'Received'#9'F'#9'RelatedQty')
      IniAttributes.Delimiter = ';;'
      TitleColor = 15527129
      FixedCols = 0
      ShowHorzScrollBar = False
      Align = alClient
      DataSource = BaseSaleGUI.dsFESaleslinesRelatedPrs
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
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
      FooterColor = 15527129
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object grdRelatedPrIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 18
        Height = 22
        HelpContext = 1674025
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
      end
    end
    object cboProductX: TwwDBLookupCombo
      Left = 42
      Top = 47
      Width = 166
      Height = 23
      HelpContext = 1674026
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'60'#9'PARTNAME'#9'F')
      LookupTable = QryRelatedPRLookup
      LookupField = 'PARTNAME'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      DropDownWidth = 300
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboFormula: TwwDBLookupCombo
      Left = 214
      Top = 47
      Width = 166
      Height = 23
      HelpContext = 1674027
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'FormulaName'#9'50'#9'Formula Name'#9'F'
        'Formula'#9'40'#9'Formula'#9'F')
      LookupTable = qryformula
      LookupField = 'Formula'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  object pnlProduct: TDNMPanel [8]
    Left = 0
    Top = 192
    Width = 460
    Height = 118
    HelpContext = 1674028
    Align = alTop
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    ExplicitTop = 170
    object Bevel41: TBevel
      AlignWithMargins = True
      Left = 122
      Top = 0
      Width = 216
      Height = 57
      HelpContext = 1674029
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alClient
      Shape = bsFrame
      ExplicitLeft = 0
      ExplicitWidth = 477
      ExplicitHeight = 75
    end
    object grdProductGroup: TwwDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 57
      Width = 454
      Height = 60
      HelpContext = 1674030
      Margins.Top = 0
      Margins.Bottom = 1
      ControlType.Strings = (
        'LineTaxCode;CustomEdit;cboTaxCode;F'
        'UnitofMeasureSaleLines;CustomEdit;cboUnitOfMeasure;F'
        'ForeignExchangeSellCode;CustomEdit;cboForeignCurrencyCode;F'
        'Supplier;CustomEdit;cboSupplier;F'
        'SearchFilter;CustomEdit;txtSearchFilter;T'
        'CostCentreName;CustomEdit;cboCostCentre;F'
        'SpecDescription;CustomEdit;cboPartSpecs;F')
      Selected.Strings = (
        'Field1'#9'10'#9'Field1'#9'F'#9
        'Field2'#9'10'#9'Field2'#9#9
        'Field3'#9'10'#9'Field3'#9#9
        'field4'#9'10'#9'field4'#9#9
        'Field5'#9'10'#9'Field5'#9#9
        'ShippedField1'#9'10'#9'ShippedField1'#9'F'#9
        'ShippedField2'#9'10'#9'ShippedField2'#9'F'#9
        'ShippedField3'#9'10'#9'ShippedField3'#9'F'#9
        'ShippedField4'#9'10'#9'ShippedField4'#9'F'#9
        'ShippedField5'#9'10'#9'ShippedField5'#9'F'#9
        'SaleID'#9'10'#9'SaleID'#9'F'#9
        'SaleLineID'#9'10'#9'SaleLineID'#9'F'#9
        'ProductName'#9'60'#9'ProductName'#9'F'#9
        'msTimeStamp'#9'18'#9'msTimeStamp'#9'F'#9
        'msUpdateSiteCode'#9'3'#9'msUpdateSiteCode'#9'F'#9
        'FormulaId'#9'10'#9'FormulaId'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = 15527129
      FixedCols = 0
      ShowHorzScrollBar = False
      ShowVertScrollBar = False
      Align = alBottom
      DataSource = BaseSaleGUI.dsFESalesLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgEnterToTab]
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTabExitsOnLastCol, dgRowResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      OnEnter = grdProductGroupEnter
      FooterColor = 15527129
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
    object grpFilters: TwwRadioGroup
      AlignWithMargins = True
      Left = 130
      Top = 3
      Width = 200
      Height = 51
      Margins.Left = 11
      Margins.Right = 11
      DisableThemes = False
      ShowGroupCaption = False
      Align = alClient
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Items.Strings = (
        'Ordered'
        'Received')
      ParentFont = False
      TabOrder = 1
      OnClick = grpFiltersClick
      HelpContext = 1674031
    end
    object btnUpdateshipped: TDNMSpeedButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 113
      Height = 51
      HelpContext = 1674032
      Align = alLeft
      Caption = 'Shipped = Sold'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Style = bsModern
      TabOrder = 2
      OnClick = btnUpdateshippedClick
    end
    object btnUpdateOrderd: TDNMSpeedButton
      AlignWithMargins = True
      Left = 344
      Top = 3
      Width = 113
      Height = 51
      HelpContext = 1674033
      Align = alRight
      Caption = 'Sold = shipped'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Style = bsModern
      TabOrder = 3
      OnClick = btnUpdateOrderdClick
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004801FC0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryFieldNames: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select FormulaEntryID , FormulaEntryName, FormulaEntryNO from tb' +
        'lFENames'
      '')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 247
    Top = 344
    object qryFieldNamesFormulaEntryID: TIntegerField
      FieldName = 'FormulaEntryID'
    end
    object qryFieldNamesFormulaEntryName: TWideStringField
      FieldName = 'FormulaEntryName'
      Size = 50
    end
    object qryFieldNamesFormulaEntryNO: TIntegerField
      FieldName = 'FormulaEntryNO'
    end
  end
  object qryformula: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select FormulaID ,  FormulaName, Formula from tblFEFormula '
      '')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 210
    Top = 344
    object qryformulaFormulaID: TIntegerField
      FieldName = 'FormulaID'
    end
    object qryformulaFormulaName: TWideStringField
      FieldName = 'FormulaName'
      Size = 50
    end
    object qryformulaFormula: TWideStringField
      FieldName = 'Formula'
      Size = 255
    end
  end
  object QryRelatedPRLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'p.PARTNAME, p.PARTSID'
      'FROM tblparts p'
      'WHERE p.Active = '#39'T'#39
      'Order By p.PARTNAME;')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 174
    Top = 344
    object StringField1: TWideStringField
      FieldName = 'PARTNAME'
      Origin = 'tblparts.PARTNAME'
      Size = 60
    end
    object IntegerField1: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PARTSID'
      Origin = 'tblparts.PARTSID'
    end
  end
end
