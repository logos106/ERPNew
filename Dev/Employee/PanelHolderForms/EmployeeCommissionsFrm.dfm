inherited frmEmployeeCommissions: TfrmEmployeeCommissions
  Left = 21
  Top = 178
  HelpContext = 570000
  Caption = 'frmEmployeeCommissions'
  ClientHeight = 478
  ClientWidth = 800
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 21
  ExplicitTop = 178
  ExplicitWidth = 816
  ExplicitHeight = 517
  DesignSize = (
    800
    478)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 478
    Width = 800
    HelpContext = 570020
    ExplicitTop = 545
    ExplicitWidth = 948
  end
  inherited shapehint: TShape
    Left = 4
    ExplicitLeft = 7
  end
  inherited shapehintextra1: TShape
    Left = 42
    ExplicitLeft = 54
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 10
    Top = 35
    Width = 790
    Height = 420
    HelpContext = 570001
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Transparent = False
    ExplicitWidth = 947
    ExplicitHeight = 504
    object lblNote: TLabel
      Left = 1
      Top = 39
      Width = 788
      Height = 22
      HelpContext = 570021
      Align = alTop
      Alignment = taCenter
      Caption = 
        'Sales Commission is disabled. Please enable in Preferences -> Sa' +
        'les'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      OnDblClick = lblNoteDblClick
      ExplicitWidth = 634
    end
    object pnlempSales: TDNMPanel
      Left = 1
      Top = 1
      Width = 788
      Height = 38
      HelpContext = 570022
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Label7: TLabel
        Left = 6
        Top = 12
        Width = 74
        Height = 15
        HelpContext = 570005
        Caption = 'Sales  Target'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object wwDBEdit1: TwwDBEdit
        Left = 111
        Top = 7
        Width = 139
        Height = 24
        HelpContext = 570023
        DataField = 'SalesTarget'
        DataSource = DSEmployees
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object pnlcommission: TDNMPanel
      Left = 1
      Top = 61
      Width = 788
      Height = 358
      HelpContext = 570024
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 945
      ExplicitHeight = 442
      object mainpage: TPageControl
        Left = 1
        Top = 1
        Width = 786
        Height = 356
        HelpContext = 570025
        ActivePage = tabEmployee
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabHeight = 25
        TabOrder = 0
        TabWidth = 333
        OnChange = pageControlChange
        OnDrawTab = PageControlDrawTab
        OnResize = mainpageResize
        ExplicitHeight = 440
        object tabEmployee: TTabSheet
          HelpContext = 570026
          Caption = 'Commission for Employee (All Sales)'
          OnExit = TabControlExit
          OnShow = TabSheetShow
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object DNMPanel2: TDNMPanel
            Left = 0
            Top = 0
            Width = 778
            Height = 321
            HelpContext = 570027
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            ExplicitWidth = 935
            ExplicitHeight = 405
            DesignSize = (
              778
              321)
            object Label4: TLabel
              Left = 16
              Top = 13
              Width = 288
              Height = 15
              HelpContext = 570045
              Caption = 'Commission on all Sales Enabled  for the Employee'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label8: TLabel
              Left = 12
              Top = 245
              Width = 103
              Height = 15
              HelpContext = 570046
              Anchors = [akLeft, akBottom]
              Caption = 'Commission Rate '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label9: TLabel
              Left = 85
              Top = 270
              Width = 10
              Height = 16
              HelpContext = 570006
              Anchors = [akLeft, akBottom]
              Caption = '%'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object Label2: TLabel
              Left = 277
              Top = 270
              Width = 10
              Height = 16
              HelpContext = 570047
              Anchors = [akLeft, akBottom]
              Caption = '%'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              WordWrap = True
            end
            object lblOHbase: TLabel
              Left = 197
              Top = 245
              Width = 90
              Height = 15
              HelpContext = 570048
              Anchors = [akLeft, akBottom]
              Caption = 'Overhead  Base'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object Label6: TLabel
              Left = 345
              Top = 59
              Width = 351
              Height = 15
              HelpContext = 570016
              Caption = 'Products to Exclude from Sales Commission for the Employee'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object lblformula: TLabel
              Left = 1
              Top = 304
              Width = 776
              Height = 16
              HelpContext = 570028
              Align = alBottom
              Alignment = taCenter
              Caption = '..........'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitTop = 388
              ExplicitWidth = 40
            end
            object chkUseEmpComm: TwwCheckBox
              Left = 310
              Top = 11
              Width = 18
              Height = 18
              HelpContext = 570018
              TabStop = False
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
              ShowFocusRect = False
              NullAndBlankState = cbUnchecked
              BiDiMode = bdLeftToRight
              DataField = 'CommissionUseEmp'
              DataSource = DSEmployees
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentBiDiMode = False
              ParentFont = False
              TabOrder = 0
              OnClick = chkUseEmpCommClick
              OnEnter = chkUseEmpCommEnter
            end
            object optCommissionOnPaid: TwwRadioGroup
              Left = 7
              Top = 40
              Width = 136
              Height = 96
              HelpContext = 570029
              DisableThemes = False
              TransparentActiveItem = True
              Transparent = True
              Caption = 'Commission For'
              DataField = 'CommissionOnPaid'
              DataSource = DSEmployees
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Items.Strings = (
                'All Invoices'
                'Paid Invoices')
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              Values.Strings = (
                'F'
                'T')
              OnChange = optCommissionOnPaidChange
              OnClick = optCommissionOnPaidClick
            end
            object optCommissionInvoiceExPrice: TwwRadioGroup
              Left = 3
              Top = 141
              Width = 136
              Height = 96
              HelpContext = 570030
              DisableThemes = False
              TransparentActiveItem = True
              Transparent = True
              Caption = 'Commission Amount'
              DataField = 'CommissionInvoiceExPrice'
              DataSource = DSEmployees
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Items.Strings = (
                'Ex Price'
                'Inc Price')
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              Values.Strings = (
                'T'
                'F')
              OnClick = optCommissionInvoiceExPriceClick
            end
            object optCommissionOn: TwwRadioGroup
              Left = 145
              Top = 40
              Width = 189
              Height = 197
              HelpContext = 570031
              DisableThemes = False
              TransparentActiveItem = True
              Transparent = True
              Caption = 'Commission On'
              DataField = 'CommissionOn'
              DataSource = DSEmployees
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              Items.Strings = (
                'Invoice Value'
                'Gross Profit'
                'Landed Cost'
                'Landed Cost with Overhead'
                'Gross Profit with Overhead'
                'Total Landed Cost')
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              Values.Strings = (
                'I'
                'G'
                'L'
                'LO'
                'GO'
                'LT')
              OnChange = optCommissionOnChange
              OnClick = optCommissionOnClick
            end
            object txtCommissionRate: TDBEdit
              Left = 16
              Top = 266
              Width = 62
              Height = 24
              HelpContext = 570012
              Anchors = [akLeft, akBottom]
              DataField = 'CommissionFlatRate'
              DataSource = DSEmployees
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
            end
            object edtOverheadbaserate: TDBEdit
              Left = 201
              Top = 266
              Width = 62
              Height = 24
              HelpContext = 570049
              Anchors = [akLeft, akBottom]
              DataField = 'Overheadbaserate'
              DataSource = DSEmployees
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 5
              OnEnter = edtOverheadbaserateEnter
            end
            object grdEmpNoCommsProducts: TwwDBGrid
              Left = 345
              Top = 80
              Width = 418
              Height = 172
              HelpContext = 570032
              Selected.Strings = (
                'ProductName'#9'50'#9'Product Name')
              IniAttributes.Delimiter = ';;'
              TitleColor = 14155775
              FixedCols = 0
              ShowHorzScrollBar = True
              EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
              Anchors = [akLeft, akTop, akRight, akBottom]
              DataSource = dsEmpNoCommsProducts
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
              ParentFont = False
              TabOrder = 6
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              UseTFields = False
              OnCalcCellColors = grdProductcommissionCalcCellColors
              OnDblClick = grdEmpNoCommsProductsDblClick
              FooterColor = 14155775
              FooterCellColor = 14155775
              ExplicitHeight = 256
              object grdEmpNoCommsProductsIButton: TwwIButton
                Left = 0
                Top = 0
                Width = 18
                Height = 25
                HelpContext = 570033
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
                Visible = False
                OnClick = grdEmpNoCommsProductsIButtonClick
              end
            end
            object DNMSpeedButton1: TDNMSpeedButton
              Left = 612
              Top = 263
              Width = 151
              Height = 27
              HelpContext = 570034
              Anchors = [akLeft, akBottom]
              Caption = 'Choose Products'
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
              TabOrder = 7
              AutoDisableParentOnclick = True
              OnClick = DNMSpeedButton1Click
              ExplicitTop = 347
            end
            object btnExplain: TDNMSpeedButton
              Left = 662
              Top = 13
              Width = 101
              Height = 27
              HelpContext = 570035
              Anchors = [akTop, akRight]
              Caption = 'Explain'
              DisableTransparent = False
              Font.Charset = ANSI_CHARSET
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
              OnClick = btnExplainClick
            end
          end
        end
        object Tabproduct: TTabSheet
          HelpContext = 570036
          Caption = 'Commission on Product Sale'
          ImageIndex = 1
          OnShow = TabSheetShow
          ExplicitHeight = 405
          object DNMPanel3: TDNMPanel
            Left = 0
            Top = 0
            Width = 778
            Height = 321
            HelpContext = 570037
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            ExplicitHeight = 405
            DesignSize = (
              778
              321)
            object Label5: TLabel
              Left = 8
              Top = 13
              Width = 289
              Height = 15
              HelpContext = 570051
              Caption = 'Commission on Products Enabled for the Employee'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
            end
            object btnProdList: TDNMSpeedButton
              Left = 253
              Top = 36
              Width = 151
              Height = 27
              HelpContext = 570038
              Caption = 'Choose Products'
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
              TabOrder = 2
              AutoDisableParentOnclick = True
              OnClick = btnProdListClick
            end
            object chkUseProdComm: TwwCheckBox
              Left = 383
              Top = 11
              Width = 21
              Height = 19
              HelpContext = 570019
              TabStop = False
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
              ShowFocusRect = False
              NullAndBlankState = cbUnchecked
              Alignment = taLeftJustify
              DataField = 'CommissionUseProd'
              DataSource = DSEmployees
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              OnClick = chkUseProdCommClick
            end
            object DNMSpeedButton2: TDNMSpeedButton
              Left = 670
              Top = 5
              Width = 101
              Height = 27
              HelpContext = 570043
              Anchors = [akTop, akRight]
              Caption = 'Explain'
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
              TabOrder = 1
              AutoDisableParentOnclick = True
              OnClick = btnExplainClick
            end
            object btnProdListForAllemp: TDNMSpeedButton
              Left = 620
              Top = 36
              Width = 151
              Height = 27
              HelpContext = 570044
              Anchors = [akTop, akRight]
              Caption = 'Choose Products'
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
              OnClick = btnProdListClick
            end
            object pnlAllemp: TDNMPanel
              AlignWithMargins = True
              Left = 392
              Top = 76
              Width = 382
              Height = 241
              HelpContext = 570054
              Margins.Top = 75
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
              ExplicitHeight = 325
              object Label3: TLabel
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 374
                Height = 15
                HelpContext = 570053
                Align = alTop
                Caption = 'Product Commission for all Employees'
                Transparent = True
                ExplicitWidth = 219
              end
              object grdProductcommission: TwwDBGrid
                AlignWithMargins = True
                Left = 4
                Top = 25
                Width = 374
                Height = 212
                HelpContext = 570039
                ControlType.Strings = (
                  'ForAllEmployees;CheckBox;T;F'
                  'Active;CheckBox;T;F')
                Selected.Strings = (
                  'Partname'#9'30'#9'Product Name'
                  'commission'#9'1'#9'Commission'
                  'Active'#9'1'#9'Active')
                IniAttributes.Delimiter = ';;'
                TitleColor = 14155775
                FixedCols = 0
                ShowHorzScrollBar = True
                EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
                Align = alClient
                DataSource = dsProductcommission
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                KeyOptions = []
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
                OnCalcCellColors = grdProductcommissionCalcCellColors
                OnDblClick = grdemployeeProductcommissionDblClick
                FooterColor = 14155775
                FooterCellColor = 14155775
                ExplicitHeight = 296
                object grdProductcommissionIButton: TwwIButton
                  Left = 0
                  Top = 0
                  Width = 21
                  Height = 25
                  HelpContext = 570040
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
                  Visible = False
                  OnClick = grdProductcommissionIButtonClick
                end
              end
            end
            object pnlEmp: TDNMPanel
              AlignWithMargins = True
              Left = 4
              Top = 76
              Width = 382
              Height = 241
              HelpContext = 570055
              Margins.Top = 75
              Align = alLeft
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
              ExplicitHeight = 325
              object Label1: TLabel
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 374
                Height = 15
                HelpContext = 570052
                Align = alTop
                Caption = 'Product Commission for the Employee'
                Transparent = True
                ExplicitWidth = 217
              end
              object grdemployeeProductcommission: TwwDBGrid
                AlignWithMargins = True
                Left = 4
                Top = 25
                Width = 374
                Height = 212
                HelpContext = 570041
                ControlType.Strings = (
                  'ForAllEmployees;CheckBox;T;F'
                  'Active;CheckBox;T;F')
                Selected.Strings = (
                  'Partname'#9'30'#9'Product Name'
                  'commission'#9'1'#9'Commission'
                  'Active'#9'1'#9'Active')
                IniAttributes.Delimiter = ';;'
                TitleColor = 14155775
                FixedCols = 0
                ShowHorzScrollBar = True
                EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
                Align = alClient
                DataSource = dsEmployeeProductCommission
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                KeyOptions = []
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
                OnCalcCellColors = grdemployeeProductcommissionCalcCellColors
                OnDblClick = grdemployeeProductcommissionDblClick
                FooterColor = 14155775
                FooterCellColor = 14155775
                ExplicitHeight = 296
                object grdemployeeProductcommissionIButton: TwwIButton
                  Left = 0
                  Top = 0
                  Width = 21
                  Height = 25
                  HelpContext = 570042
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
                  Visible = False
                  OnClick = grdemployeeProductcommissionIButtonClick
                end
              end
            end
          end
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 572
    Top = 432
  end
  inherited tmrdelay: TTimer
    Left = 608
    Top = 432
  end
  inherited popSpelling: TPopupMenu
    Left = 536
    Top = 360
  end
  inherited tmrdelayMsg: TTimer
    Left = 536
    Top = 432
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 641
    Top = 360
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 677
    Top = 360
  end
  inherited MyConnection: TERPConnection
    Left = 778
    Top = 327
  end
  inherited DataState: TDataState
    Left = 536
    Top = 392
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 571
    Top = 360
  end
  inherited imgsort: TImageList
    Left = 571
    Top = 392
    Bitmap = {
      494C01010200A000D40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 706
    Top = 328
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 606
    Top = 392
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 606
    Top = 360
  end
  inherited qryMemTrans: TERPQuery
    Left = 741
    Top = 328
  end
  inherited tmrOnshow: TTimer
    Left = 648
    Top = 432
  end
  object DSEmployees: TDataSource
    Left = 536
    Top = 328
  end
  object dsEmployeeProductCommission: TDataSource
    Left = 640
    Top = 328
  end
  object qryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PartsId, PartName '
      'FROM tblParts'
      'WHERE Active = "T"'
      'ORDER BY PartName')
    Left = 672
    Top = 328
  end
  object dsProductcommission: TDataSource
    Left = 576
    Top = 328
  end
  object dsEmpNoCommsProducts: TDataSource
    Left = 608
    Top = 328
  end
end
