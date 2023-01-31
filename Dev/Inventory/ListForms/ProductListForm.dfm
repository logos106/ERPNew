inherited ProductListGUI: TProductListGUI
  Left = 625
  Top = 68
  HelpContext = 444000
  Caption = 'Product List'
  OldCreateOrder = True
  ExplicitLeft = 625
  ExplicitTop = 68
  ExplicitWidth = 1012
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 456
    ExplicitTop = 464
    ExplicitWidth = 984
  end
  inherited FilterLabel: TLabel
    Top = 456
    HelpContext = 444001
    ExplicitTop = 456
  end
  inherited pnlGraph: TDNMPanel
    Height = 327
    HelpContext = 444078
    ExplicitHeight = 338
  end
  inherited HeaderPanel: TPanel
    HelpContext = 444044
    ParentColor = True
    inherited lblFrom: TLabel
      Top = 11
      ExplicitTop = 11
    end
    inherited lblTo: TLabel
      Left = 861
      Alignment = taRightJustify
      ExplicitLeft = 861
    end
    inherited imgReportTablesMsg: TImage
      Picture.Data = {
        0954474946496D6167654749463839611100120077000021F904010000FC002C
        0000000011001200870000000000330000660000990000CC0000FF002B00002B
        33002B66002B99002BCC002BFF0055000055330055660055990055CC0055FF00
        80000080330080660080990080CC0080FF00AA0000AA3300AA6600AA9900AACC
        00AAFF00D50000D53300D56600D59900D5CC00D5FF00FF0000FF3300FF6600FF
        9900FFCC00FFFF3300003300333300663300993300CC3300FF332B00332B3333
        2B66332B99332BCC332BFF3355003355333355663355993355CC3355FF338000
        3380333380663380993380CC3380FF33AA0033AA3333AA6633AA9933AACC33AA
        FF33D50033D53333D56633D59933D5CC33D5FF33FF0033FF3333FF6633FF9933
        FFCC33FFFF6600006600336600666600996600CC6600FF662B00662B33662B66
        662B99662BCC662BFF6655006655336655666655996655CC6655FF6680006680
        336680666680996680CC6680FF66AA0066AA3366AA6666AA9966AACC66AAFF66
        D50066D53366D56666D59966D5CC66D5FF66FF0066FF3366FF6666FF9966FFCC
        66FFFF9900009900339900669900999900CC9900FF992B00992B33992B66992B
        99992BCC992BFF9955009955339955669955999955CC9955FF99800099803399
        80669980999980CC9980FF99AA0099AA3399AA6699AA9999AACC99AAFF99D500
        99D53399D56699D59999D5CC99D5FF99FF0099FF3399FF6699FF9999FFCC99FF
        FFCC0000CC0033CC0066CC0099CC00CCCC00FFCC2B00CC2B33CC2B66CC2B99CC
        2BCCCC2BFFCC5500CC5533CC5566CC5599CC55CCCC55FFCC8000CC8033CC8066
        CC8099CC80CCCC80FFCCAA00CCAA33CCAA66CCAA99CCAACCCCAAFFCCD500CCD5
        33CCD566CCD599CCD5CCCCD5FFCCFF00CCFF33CCFF66CCFF99CCFFCCCCFFFFFF
        0000FF0033FF0066FF0099FF00CCFF00FFFF2B00FF2B33FF2B66FF2B99FF2BCC
        FF2BFFFF5500FF5533FF5566FF5599FF55CCFF55FFFF8000FF8033FF8066FF80
        99FF80CCFF80FFFFAA00FFAA33FFAA66FFAA99FFAACCFFAAFFFFD500FFD533FF
        D566FFD599FFD5CCFFD5FFFFFF00FFFF33FFFF66FFFF99FFFFCCFFFFFF000000
        000000000000000000084B0025081C48B0E0C07D08132A5C28709FC1870E2544
        7C4830E2448A0D33623CA851A144841C2576D43852E4C48B161B262429B265CA
        96255FA28CC9F2E54697374BDEB4B8B0E7CA9C050302003B}
    end
    inherited cboDateRange: TComboBox
      Top = 7
      TabOrder = 4
      ExplicitTop = 7
    end
    inherited pnlHeader: TPanel
      Left = 347
      Width = 302
      HelpContext = 444047
      ExplicitLeft = 347
      ExplicitWidth = 302
      inherited TitleShader: TShader
        Width = 300
        HelpContext = 444048
        ExplicitWidth = 300
        inherited TitleLabel: TLabel
          Width = 300
          HelpContext = 444049
          Caption = 'Product List'
          ExplicitLeft = -5
          ExplicitTop = -8
          ExplicitWidth = 416
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 444050
      DesignSize = (
        996
        37)
      inherited grpFilters: TwwRadioGroup
        HelpContext = 444051
        ItemIndex = 0
        Anchors = [akLeft, akRight]
      end
      inherited pnlButtons: TPanel
        HelpContext = 444052
        inherited lblcustomReport: TLabel
          HelpContext = 444053
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 444054
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 444055
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 444056
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 444057
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 444058
        end
      end
      inherited pnlIncludehistory: TDNMPanel
        HelpContext = 444097
        TabOrder = 4
      end
      object btnListWithDept: TDNMSpeedButton
        Left = 777
        Top = 9
        Width = 96
        Height = 25
        Hint = 'Product List'
        HelpContext = 444080
        Anchors = [akTop, akRight]
        Caption = 'Reorder Details'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
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
        TabOrder = 2
        Visible = False
        AutoDisableParentOnclick = True
        OnClick = btnListWithDeptClick
      end
    end
    inherited Panel3: TPanel
      HelpContext = 444060
      inherited lblFilter: TLabel
        HelpContext = 444061
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 444062
      end
      inherited cboFilter: TComboBox
        HelpContext = 444063
      end
      inherited edtSearch: TEdit
        HelpContext = 444064
      end
      inherited grpView: TwwRadioGroup
        TabOrder = 7
      end
      object btnActiveState: TDNMSpeedButton
        Left = 901
        Top = 4
        Width = 75
        Height = 25
        HelpContext = 444065
        Anchors = [akTop, akRight]
        Caption = 'Inactive'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 2
        Visible = False
        AutoDisableParentOnclick = True
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Top = 7
      HelpContext = 444081
      ShowHint = True
      TabOrder = 6
      ExplicitTop = 7
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 444082
      ShowHint = True
      TabOrder = 3
    end
    inherited chkIgnoreDates: TCheckBox
      Left = 754
      Top = 36
      Width = 89
      Height = 15
      HelpContext = 444098
      TabOrder = 5
      ExplicitLeft = 754
      ExplicitTop = 36
      ExplicitWidth = 89
      ExplicitHeight = 15
    end
  end
  inherited Panel1: TPanel
    Height = 327
    HelpContext = 444076
    Color = 15588572
    ExplicitHeight = 338
    inherited lblDateComments: TLabel
      Top = 311
      ExplicitTop = 311
    end
    inherited lblTimerMsg: TLabel
      Top = 295
      ExplicitTop = 295
    end
    inherited splMultiSelectList: TSplitter
      Height = 126
      HelpContext = 444099
      ExplicitHeight = 137
    end
    inherited grdMain: TwwDBGrid
      Height = 126
      Hint = 'Product List'
      HelpContext = 444077
      ControlType.Strings = (
        'MatrixQtyBtn;CustomEdit;ebPriceMatrixQty;F'
        'CommIsPercent;CheckBox;T;F'
        'Multiplebins;CheckBox;T;F'
        'Batch;CheckBox;T;F'
        'Has~Formula?;CheckBox;T;F'
        'Include In~Analysis?;CheckBox;T;F'
        'IncludeInAnalysis;CheckBox;T;F'
        'HasFormulaAttached;CheckBox;T;F'
        'IsSystemProduct;CheckBox;T;F'
        'EnablePackWeight;CheckBox;T;F'
        'Active;CheckBox;T;F'
        'OnSpecial;CheckBox;T;F'
        'Discontinued;CheckBox;T;F'
        'batch;CheckBox;T;F'
        'SNTracking;CheckBox;T;F'
        'SpecialDiscount;CheckBox;T;F'
        'MultipleBins;CheckBox;T;F'
        'Hire;CheckBox;T;F')
      Selected.Strings = (
        'ProductName'#9'15'#9'ProductName'#9'F'
        'ProductType'#9'10'#9'ProductType'#9'F'#9'ProductType'
        'Available'#9'10'#9'Available'#9'F'#9'Quantity read as Units'
        'InStock'#9'10'#9'InStock'#9'F'#9'Quantity read as Units'
        'AllocatedSO'#9'10'#9'AllocatedSO'#9'F'#9'Quantity read as Units'
        'AllocatedBO'#9'10'#9'AllocatedBO'#9'F'#9'Quantity read as Units'
        'SOBackOrders'#9'10'#9'SO Back Orders'#9'F'#9'Quantity read as Units'
        'OnOrder'#9'10'#9'OnOrder'#9'F'#9'Quantity read as Units'
        'Building'#9'10'#9'Building'#9'F'#9'Quantity read as Units'
        'OnBuild'#9'10'#9'OnBuild'#9'F'#9'Quantity read as Units'
        'Ontransit'#9'10'#9'On Transit'#9'F'#9'Quantity read as Units'
        'RA'#9'10'#9'RA'#9'F'#9'Quantity read as Units'
        'BuyQtyA'#9'10'#9'BuyQtyA'#9'F'#9'Buy Qty & Cost'
        'CostExA'#9'10'#9'CostExA'#9'F'#9'Buy Qty & Cost'
        'CostIncA'#9'10'#9'CostIncA'#9'F'#9'Buy Qty & Cost'
        'BuyQtyB'#9'10'#9'BuyQtyB'#9'F'#9'Buy Qty & Cost'
        'CostExB'#9'10'#9'CostExB'#9'F'#9'Buy Qty & Cost'
        'CostIncB'#9'10'#9'CostIncB'#9'F'#9'Buy Qty & Cost'
        'BuyQtyC'#9'10'#9'BuyQtyC'#9'F'#9'Buy Qty & Cost'
        'CostExC'#9'10'#9'CostExC'#9'F'#9'Buy Qty & Cost'
        'CostIncC'#9'10'#9'CostIncC'#9'F'#9'Buy Qty & Cost'
        'SellQtyA'#9'10'#9'SellQtyA'#9'F'#9'Sell Qty & Price'
        'PriceExA'#9'10'#9'PriceExA'#9'F'#9'Sell Qty & Price'
        'PriceIncA'#9'10'#9'PriceIncA'#9'F'#9'Sell Qty & Price'
        'SellQtyB'#9'10'#9'SellQtyB'#9'F'#9'Sell Qty & Price'
        'PriceExB'#9'10'#9'PriceExB'#9'F'#9'Sell Qty & Price'
        'PriceIncB'#9'10'#9'PriceIncB'#9'F'#9'Sell Qty & Price'
        'SellQtyC'#9'10'#9'SellQtyC'#9'F'#9'Sell Qty & Price'
        'PriceExC'#9'10'#9'PriceExC'#9'F'#9'Sell Qty & Price'
        'PriceIncC'#9'10'#9'PriceIncC'#9'F'#9'Sell Qty & Price'
        'WholesalePrice'#9'10'#9'WholesalePrice'#9'F'
        'GlobalRef'#9'10'#9'GlobalRef'#9'F'
        'FirstColumn'#9'15'#9'FirstColumn'#9'F'#9'Product Group'
        'SecondColumn'#9'15'#9'SecondColumn'#9'F'#9'Product Group'
        'ThirdColumn'#9'15'#9'ThirdColumn'#9'F'#9'Product Group'
        'SalesDescription'#9'15'#9'SalesDescription'#9'F'
        'PurchaseDescription'#9'15'#9'PurchaseDescription'#9'F'
        'IncomeAccount'#9'12'#9'IncomeAccount'#9'F'#9'Account'
        'AssetAccount'#9'12'#9'AssetAccount'#9'F'#9'Account'
        'CostofGoodsSoldAccount'#9'15'#9'CostofGoodsSoldAccount'#9'F'#9'Account'
        'Barcode'#9'20'#9'Barcode'#9'F'
        'ProductCode'#9'11'#9'ProductCode'#9#9
        'Taxcode'#9'6'#9'Taxcode'#9'F'#9'Tax Code'
        'PurchaseTaxcode'#9'6'#9'PurchaseTaxcode'#9'F'#9'Tax Code'
        'PreferredSupplier'#9'15'#9'PreferredSupplier'#9'F'
        'StockValue'#9'10'#9'StockValue(cost)'#9'F'#9'Value'
        'ValueAvg'#9'10'#9'ValueAvg'#9'F'#9'Value'
        'PercentCost'#9'10'#9'PercentCost'#9#9
        'Active'#9'1'#9'Active'#9#9
        'PARTSID'#9'10'#9'PARTSID'#9#9
        'SupplierProductCode'#9'12'#9'SupplierProductCode'#9'F'
        'DateCreated'#9'12'#9'DateCreated'#9'F'
        'DateUpdated'#9'12'#9'DateUpdated'#9'F'
        'VariancePriceInc'#9'10'#9'VariancePriceInc'#9#9
        'Area'#9'12'#9'Area'#9'F'
        'Discontinued'#9'1'#9'Discontinued'#9#9
        'OnSpecial'#9'1'#9'OnSpecial'#9#9
        'ProductTypeCode'#9'13'#9'ProductTypeCode'#9'F'#9'ProductType'
        'LandedCost'#9'10'#9'LandedCost'#9#9
        'AvgCost'#9'10'#9'Avg Cost'#9#9
        'CUSTDATE1'#9'18'#9'CUSTDATE1'#9'F'
        'CUSTDATE2'#9'18'#9'CUSTDATE2'#9'F'
        'CUSTDATE3'#9'18'#9'CUSTDATE3'#9'F'
        'CUSTFLD1'#9'20'#9'CUSTFLD1'#9'F'
        'CUSTFLD10'#9'20'#9'CUSTFLD10'#9'F'
        'CUSTFLD11'#9'20'#9'CUSTFLD11'#9'F'
        'CUSTFLD12'#9'20'#9'CUSTFLD12'#9'F'
        'CUSTFLD13'#9'20'#9'CUSTFLD13'#9'F'
        'CUSTFLD14'#9'20'#9'CUSTFLD14'#9'F'
        'CUSTFLD15'#9'20'#9'CUSTFLD15'#9'F'
        'CUSTFLD2'#9'20'#9'CUSTFLD2'#9'F'
        'CUSTFLD3'#9'20'#9'CUSTFLD3'#9'F'
        'CUSTFLD4'#9'20'#9'CUSTFLD4'#9'F'
        'CUSTFLD5'#9'20'#9'CUSTFLD5'#9'F'
        'CUSTFLD6'#9'20'#9'CUSTFLD6'#9'F'
        'CUSTFLD7'#9'20'#9'CUSTFLD7'#9'F'
        'CUSTFLD8'#9'20'#9'CUSTFLD8'#9'F'
        'CUSTFLD9'#9'20'#9'CUSTFLD9'#9'F'
        'MarkupPercentage'#9'10'#9'Markup%'#9'F'
        'MarginMode'#9'10'#9'Margin~Mode'#9'F'
        'HasFormulaAttached'#9'1'#9'Has~Formula?'#9'F'
        'IncludeInAnalysis'#9'1'#9'Include In~Analysis?'#9'F'
        'SalesValue'#9'10'#9'Sales Value'#9'F'
        'IsSystemProduct'#9'1'#9'System Product?'#9'F'
        'EnablePackWeight'#9'1'#9'Enable~Pack Weight?'#9'F'
        'batch'#9'1'#9'batch'#9'F'
        'MultipleBins'#9'1'#9'MultipleBins'#9'F'
        'SNTracking'#9'1'#9'SNTracking'#9'F'
        'SpecialDiscount'#9'1'#9'SpecialDiscount'#9'F'
        'Hire'#9'1'#9'Hire'#9'F'
        'RA_AwaitingRANo'#9'10'#9'Awaiting RA No'#9'F'#9'Return Authority Quantities'
        'RA_InTransit'#9'10'#9'In Transit'#9'F'#9'Return Authority Quantities'
        'RA_Returned'#9'10'#9'Returned'#9'F'#9'Return Authority Quantities'
        
          'RA_SendToSupplier'#9'10'#9'Send To Supplier'#9'F'#9'Return Authority Quantit' +
          'ies'
        'RA_Testing'#9'10'#9'Testing'#9'F'#9'Return Authority Quantities'
        'RA_WithSupplier'#9'10'#9'With Supplier'#9'F'#9'Return Authority Quantities')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly, mDisableDialog]
      TitleColor = 15588572
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgShowFooter, dgRowResize]
      TitleAlignment = taCenter
      UseTFields = False
      FooterColor = 15588572
      ExplicitHeight = 126
      inherited btnGrid: TwwIButton
        Height = 34
        HelpContext = 444084
        Visible = False
        ExplicitHeight = 34
      end
    end
    inherited pnlMultiSelectList: TDNMPanel
      Height = 126
      HelpContext = 444100
      ExplicitHeight = 137
      inherited chkhideMultiSelectSelectionList: TCheckBox
        Top = 107
        ExplicitTop = 118
      end
    end
  end
  inherited FooterPanel: TDNMPanel
    Top = 471
    Height = 83
    HelpContext = 444002
    ParentColor = True
    ExplicitTop = 482
    ExplicitHeight = 83
    DesignSize = (
      996
      83)
    inherited lblNote: TLabel [0]
      Left = 0
      Top = 19
      Width = 996
      HelpContext = 444005
      Align = alTop
      Caption = '"Double Click on any Field For More Information."'
      Visible = False
      ExplicitLeft = 80
      ExplicitTop = 28
      ExplicitWidth = 996
    end
    inherited Label3: TLabel [1]
      Left = 11
      Top = 31
      HelpContext = 444003
      Anchors = []
      ExplicitLeft = 11
      ExplicitTop = 31
    end
    inherited lblTotal: TLabel [2]
      Left = 110
      HelpContext = 444004
      Anchors = []
      ExplicitLeft = 110
    end
    inherited lblTimeLabel: TLabel
      Left = 873
      HelpContext = 444006
      ExplicitLeft = 873
    end
    object lblMsg1: TLabel [4]
      Left = 0
      Top = 0
      Width = 996
      Height = 19
      HelpContext = 444021
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = '"Hold Down Ctrl to Select Multiple Entries to Merge"'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitWidth = 984
    end
    inherited lblTime: TLabel
      Left = 957
      HelpContext = 444007
      ExplicitLeft = 957
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 97
      Top = 35
      Width = 95
      HelpContext = 444086
      TabOrder = 7
      ExplicitLeft = 97
      ExplicitTop = 35
      ExplicitWidth = 95
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 450
      Top = 35
      Width = 95
      HelpContext = 444011
      TabOrder = 2
      ExplicitLeft = 450
      ExplicitTop = 35
      ExplicitWidth = 95
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 568
      Top = 35
      Width = 95
      HelpContext = 444009
      TabOrder = 0
      ExplicitLeft = 568
      ExplicitTop = 35
      ExplicitWidth = 95
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 686
      Top = 35
      Width = 95
      HelpContext = 444010
      TabOrder = 1
      ExplicitLeft = 686
      ExplicitTop = 35
      ExplicitWidth = 95
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 804
      Top = 35
      Width = 95
      HelpContext = 444085
      TabOrder = 6
      ExplicitLeft = 804
      ExplicitTop = 35
      ExplicitWidth = 95
    end
    object btnBarCodes: TDNMSpeedButton [11]
      Left = 214
      Top = 35
      Width = 95
      Height = 27
      HelpContext = 444087
      Action = actBarCodes
      Anchors = [akBottom]
      Caption = 'Deactive prods'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      TabOrder = 3
      AutoDisableParentOnclick = True
    end
    inherited chkAdvancedPrinting: TCheckBox [12]
      Left = 14
      Height = 19
      HelpContext = 444018
      TabOrder = 5
      ExplicitLeft = 14
      ExplicitHeight = 19
    end
    inherited barStatus: TAdvOfficeStatusBar [13]
      Top = 66
      HelpContext = 444019
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
      ExplicitTop = 66
    end
    object btnSelect: TDNMSpeedButton [14]
      Left = 332
      Top = 35
      Width = 95
      Height = 27
      HelpContext = 444088
      Action = actSelectAll
      Anchors = [akBottom]
      Caption = 'Select All'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      TabStop = False
      AutoDisableParentOnclick = True
    end
    inherited pnlAdvPrinting: TDNMPanel [15]
      Left = 720
      Top = 0
      Width = 274
      Height = 30
      HelpContext = 444093
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 4
      ExplicitLeft = 720
      ExplicitTop = 0
      ExplicitWidth = 274
      ExplicitHeight = 30
      inherited LblChooseTemplate: TLabel
        Top = 8
        HelpContext = 444014
        ExplicitTop = 8
      end
      inherited LblShowPreview: TLabel
        HelpContext = 444015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 444016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 444017
      end
    end
    inherited chkShowEmailOptions: TCheckBox
      Top = 61
      Height = 2
      HelpContext = 444101
      ExplicitTop = 61
      ExplicitHeight = 2
    end
    object DNMSpeedButton3: TDNMSpeedButton
      Left = 503
      Top = 6
      Width = 95
      Height = 27
      Hint = 'Product Movement summary of all selected Products'
      HelpContext = 444094
      Anchors = [akBottom]
      Caption = 'Movement'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      TabStop = False
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton3Click
    end
    object pnlOptions: TDNMPanel
      Left = 1
      Top = 2
      Width = 723
      Height = 29
      HelpContext = 444095
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 271
        Height = 29
        HelpContext = 444013
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        Transparent = False
        object lblSetPoints: TLabel
          Left = 300
          Top = 10
          Width = 58
          Height = 15
          HelpContext = 444023
          Caption = 'Set Points'
          Enabled = False
        end
        object chkBarCodes: TCheckBox
          Left = 5
          Top = 6
          Width = 130
          Height = 17
          HelpContext = 444024
          Caption = 'Ba&rcode Printing'
          TabOrder = 0
          OnClick = chkBarCodesClick
        end
        object chkSetCommission: TCheckBox
          Left = 141
          Top = 6
          Width = 116
          Height = 17
          HelpContext = 444036
          Caption = 'Set Commission'
          Enabled = False
          TabOrder = 1
          OnClick = chkSetCommissionClick
        end
        object chkSetPoints: TCheckBox
          Left = 283
          Top = 9
          Width = 15
          Height = 17
          HelpContext = 444043
          Enabled = False
          TabOrder = 2
        end
      end
      object pnlBarCode: TDNMPanel
        Left = 271
        Top = 0
        Width = 370
        Height = 29
        HelpContext = 444026
        Align = alLeft
        Color = 15588572
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        Visible = False
        Transparent = False
        DesignSize = (
          370
          29)
        object lblBarCode: TLabel
          Left = 195
          Top = 1
          Width = 171
          Height = 28
          HelpContext = 444029
          Alignment = taCenter
          Anchors = [akRight, akBottom]
          AutoSize = False
          Caption = '"Press Ctrl && Click to select Barcodes for printing'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object chkBarInStock: TCheckBox
          Left = 3
          Top = 6
          Width = 135
          Height = 17
          HelpContext = 444032
          Caption = '&Quantity InStock  OR'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = chkBarInStockClick
        end
        object edtBarQty: TEdit
          Left = 144
          Top = 6
          Width = 36
          Height = 19
          HelpContext = 444033
          AutoSize = False
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = '1'
        end
        object udBarQty: TUpDown
          Left = 180
          Top = 6
          Width = 16
          Height = 19
          HelpContext = 444034
          Associate = edtBarQty
          Enabled = False
          Min = 1
          Max = 999
          Position = 1
          TabOrder = 2
        end
      end
      object pnlCommission: TDNMPanel
        Left = 641
        Top = 0
        Width = 370
        Height = 29
        HelpContext = 444037
        Align = alLeft
        Color = 15588572
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        Visible = False
        Transparent = False
        DesignSize = (
          370
          29)
        object Label8: TLabel
          Left = 11
          Top = 8
          Width = 26
          Height = 15
          HelpContext = 444038
          Caption = 'Rate'
          Transparent = True
        end
        object Label9: TLabel
          Left = 141
          Top = 8
          Width = 79
          Height = 15
          HelpContext = 444039
          Caption = 'Is Percentage'
          Transparent = True
        end
        object lblRateType: TLabel
          Left = 40
          Top = 7
          Width = 7
          Height = 16
          HelpContext = 444040
          Alignment = taRightJustify
          Caption = '$'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object chkIsPercentage: TwwCheckBox
          Left = 117
          Top = 7
          Width = 17
          Height = 17
          HelpContext = 444041
          DisableThemes = False
          AlwaysTransparent = True
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          TabOrder = 1
          OnClick = chkIsPercentageClick
        end
        object edtRate: TEdit
          Left = 50
          Top = 4
          Width = 61
          Height = 23
          HelpContext = 444042
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtRateKeyPress
        end
        object btnProductcommissionList: TDNMSpeedButton
          Left = 235
          Top = 1
          Width = 131
          Height = 27
          Hint = '"Close The List"'
          HelpContext = 444089
          Anchors = [akRight, akBottom]
          Caption = 'Product Commsn List'
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ModalResult = 1
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btnProductcommissionListClick
        end
      end
    end
    object btnReorderLevels: TDNMSpeedButton
      Left = 504
      Top = 35
      Width = 95
      Height = 27
      Hint = '"Add A New Entry"'
      HelpContext = 444096
      Anchors = [akBottom]
      Caption = '&Reorder Lvls'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 12
      TabStop = False
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnReorderLevelsClick
    end
  end
  inherited imgPopup: TImageList
    Left = 491
    Top = 287
    Bitmap = {
      494C010108005001A00210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000BFBFBF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF00000000000000000000FFFF000000
      00000000000000FFFF0000000000000000000000000000FFFF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      FF000000FF000000FF0000000000FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF000000000000FFFF000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000FFFFFF000000000000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000000000007F7F7F000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF007F7F7F0000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000FFFF0000000000FFFFFF007F7F7F00FFFFFF000000000000FFFF0000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000000000FFFFFF0000FFFF007F7F7F0000FFFF00FFFFFF000000000000FF
      FF0000FFFF0000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
      FF000000000000FFFF00FFFFFF007F7F7F00FFFFFF0000FFFF000000000000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000000000000000FF000000
      FF000000FF000000FF000000000000FF000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF00000000000000000000FFFF0000FF
      FF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000000000FF
      FF0000FFFF00000000000000000000000000000000007F7F7F000000FF000000
      FF000000FF000000000000FF000000FF000000FF000000000000FF000000FF00
      0000FF0000007F7F7F0000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000FFFF000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000000000FFFFFF0000FFFF00FFFFFF000000000000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      FF000000000000FF000000FF000000FF000000FF000000FF000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000FF000000FF000000FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00000000000000000000FFFF000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF00000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
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
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000FFFF007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000800000008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      000000000000000000000000000000000000000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008080000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF0000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000080800000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000808000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      000000000000000000000000000000000000000000007F7F7F00BFBFBF00FFFF
      FF00BFBFBF000000FF00BFBFBF00FFFFFF00BFBFBF007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000808000008080000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F00FFFFFF00BFBF
      BF00FFFFFF000000FF00FFFFFF00BFBFBF00FFFFFF007F7F7F007F7F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008080000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      00000000000000000000000000000000000000000000000000007F7F7F00FFFF
      FF00BFBFBF00FFFFFF00BFBFBF00FFFFFF007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000000000000000000000007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FDFF8000FEFFFFFFF8FF8000FC7FF83F
      F8FFC000FC7F1010F87FE000D837E00FF81FF000E00FC007F80FF800E00F8003
      F00FFC00C0078003E00F0600C0078003E00F070000018003E00F0180C0078003
      F01F0180C007C007F00F0060E00FE00FF00FC060E00F3018F007C060D837F83F
      F007F044FEFFFFFFF007F07EFEFFFFFFFFFDFFFF847FE00FFFF8FFFF00EFE00F
      FFF1F9FF31BFE00FFFE3F0FF39FFF00FFFC7F0FF993FF00FE08FE07FCA1FF80F
      C01FC07FF40FF007803F843F9C07F007001F1E3F9603F007001FFE1FCB01F00F
      001FFF1FFF80F01F001FFF8FF7C0F81F001FFFC7FFE0FE1F803FFFE3EFF0FF1F
      C07FFFF8FFF8FF1FE0FFFFFFFFFCFFBF00000000000000000000000000000000
      000000000000}
  end
  inherited dlgPrint: TPdtPrintDAT
    Left = 854
    Top = 287
  end
  inherited actlstFilters: TActionList
    Left = 458
    Top = 287
    object actBarCodes: TAction
      Caption = 'Print Bar&Codes'
      HelpContext = 444090
      OnExecute = actBarCodesExecute
      OnUpdate = actBarCodesUpdate
    end
    object actSelectAll: TDNMAction
      Caption = 'Select All'
      HelpContext = 444091
      OnExecute = actSelectAllExecute
      OnUpdate = actSelectAllUpdate
      buttoncolor = clWhite
    end
  end
  inherited wwLocateDialog1: TwwLocateDialog
    Left = 590
    Top = 287
  end
  object DataSource1: TDataSource [14]
    AutoEdit = False
    DataSet = qryPartTypes
    Left = 297
    Top = 265
  end
  object qryPartTypes: TERPQuery [15]
    SQL.Strings = (
      'SELECT ID, TypeCode, TypeDesc  FROM tblparttypes;')
    Left = 293
    Top = 287
  end
  inherited CloseModalTimer: TTimer
    Left = 722
    Top = 287
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      '# DUMMY Query'
      'SELECT P.GlobalRef as GlobalRef, '
      'P.PARTNAME as ProductName, '
      'P.HasFormulaAttached, P.IncludeInAnalysis,'
      'LandedCost as "LandedCost", '
      'P.PARTTYPE as ProductTypeCode, '
      'p.MultipleBins,'
      'p.batch,'
      'P.SNTracking,'
      '"" AS FirstColumn, '
      '"" AS SecondColumn, '
      '"" AS ThirdColumn, '
      'PARTSDESCRIPTION as SalesDescription,'
      'PARTSDESCRIPTION_Memo as PARTSDESCRIPTION_Memo,'
      'PURCHASEDESC_Memo as PURCHASEDESC_Memo,'
      'PRODUCTCOMMENT as PRODUCTCOMMENT,'
      'COST1 + (COST1 * T2.Rate) as "CostIncA",'
      'PRICE1 + (PRICE1* T1.Rate) as "PriceIncA",'
      'Sell_Cost_Percentage as MarkupPercentage,'
      'if(GrossMarginMode="T","Markup" , "Gross Margin") as MarginMode,'
      
        'IF(P.PARTTYPE = "INV",Round(Sum(if(PQA.Active ="F" , 0, if(PQA.T' +
        'ransType='#39'TSalesOrderLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0),0' +
        '))),5),0.0) AS "SOBackOrders",'
      
        '(PRICE1 + (PRICE1 * (ClassPriceVariance/100))) + ((PRICE1 + (PRI' +
        'CE1 * (ClassPriceVariance/100)))* T1.Rate) as VariancePriceInc,'
      
        'Round(IF(P.PARTTYPE = "INV",Round(Sum(if(PQA.Active ="F" and  PQ' +
        'A.alloctype ="IN" and PQA.TransType in ('#39'TProcTreePart'#39','#39'TProcTr' +
        'eePartIN'#39'), ifnull(PQA.QTY,0), if((PQA.Active ="F") and  (not(PQ' +
        'A.TransType in ('#39'TProcTreePart'#39','#39'TProcTreePartIN'#39')) OR ((PQA.Tra' +
        'nsType='#39'TProcTreePart'#39') and (PQA.alloctype ="IN")) ), 0, if(PQA.' +
        'alloctype="IN" and  PQA.ISBo="F", ifnull(PQA.QTY,0), if(PQA.allo' +
        'ctype="OUT" and (PQA.TransType<>'#39'TSalesOrderLine'#39' or PQA.ISBO="F' +
        '") ,0-ifnull(PQA.QTY,0),0))))),5),0.0),5) AS "Available",'
      
        'Round(IF(P.PARTTYPE = "INV",Round(Sum(if(PQA.Active ="F" , 0, if' +
        '(PQA.TransType='#39'TSalesOrderLine'#39' or PQA.IsBO ="T",0,if(PQA.Trans' +
        'Type = '#39'TPOSLaybylines'#39' and PQA.Reserved = "T" ,0 ,if(PQA.alloct' +
        'ype="IN"  , ifnull(PQA.QTY,0), 0-ifnull(PQA.QTY,0)))))),5),0.0),' +
        '5) AS "InStock",'
      
        'Round(IF(P.PARTTYPE = "INV",Round(Sum(if(PQA.Active ="F" , 0, if' +
        '(((PQA.TransType = '#39'TSalesOrderLine'#39') OR (PQA.TransType = '#39'TPOSL' +
        'aybylines'#39' and PQA.Reserved = "T")) and (PQA.IsBO ="F"),ifnull(P' +
        'QA.QTY,0), 0))),5),0.0),5) AS "AllocatedSO",'
      
        'Round(IF(P.PARTTYPE = "INV",Round(Sum(if(PQA.Active ="F" , 0, if' +
        '(PQA.TransType='#39'TInvoiceLine'#39' and PQA.IsBO ="T",ifnull(PQA.QTY,0' +
        '),0))),5),0.0),5) AS "AllocatedBO",'
      
        'Round(IF(P.PARTTYPE = "INV",Round(Sum(if(PQA.Active ="F" , 0, if' +
        '(PQA.TransType='#39'TPurchaseOrderLine'#39' and PQA.IsBO ="T",ifnull(PQA' +
        '.QTY,0),0))),5),0.0),5) AS "OnOrder",'
      
        'Round(IF(P.PARTTYPE = "INV",Round(Sum(if(PQA.Active ="F" and  PQ' +
        'A.alloctype ="OUT" and PQA.TransType in ('#39'TProcTreePart'#39','#39'TProcT' +
        'reePartIN'#39'), ifnull(PQA.QTY,0),0)),5),0.0),5) AS "OnBuild",'
      
        '0-Round(IF(P.PARTTYPE = "INV",Round(Sum(if(PQA.Active ="F" and  ' +
        'PQA.alloctype ="IN" and PQA.TransType in ('#39'TProcTreePart'#39','#39'TProc' +
        'TreePartIN'#39'), ifnull(PQA.QTY,0),0)),5),0.0),5) AS "Building",'
      '0.0 as RA,'
      'BuyQTY1 as "BuyQtyA",'
      'BuyQTY2 as "BuyQtyB",'
      'BuyQTY3 as "BuyQtyC",'
      'COST1 as "CostExA",'
      'COST2 as "CostExB",'
      'COST3 as "CostExC",'
      'COST2 + (COST2*T2.Rate) as "CostIncB",'
      'COST3 + (COST3*T2.Rate) as "CostIncC",'
      'SellQTY1 as "SellQtyA",'
      'SellQTY2 as "SellQtyB",'
      'SellQTY3 as "SellQtyC",'
      'PRICE1 as "PriceExA",'
      'PRICE2 as "PriceExB",'
      'PRICE3 as "PriceExC",'
      'PRICE2 + (PRICE2*T1.Rate) as "PriceIncB",'
      'PRICE3 + (PRICE3*T1.Rate) as "PriceIncC",'
      'WHOLESALEPRICE as "WholesalePrice",'
      'PURCHASEDESC as "PurchaseDescription",'
      'INCOMEACCNT as "IncomeAccount",'
      'ASSETACCNT as "AssetAccount",'
      'COGSACCNT as "CostofGoodsSoldAccount",'
      'BARCODE as "Barcode",'
      'PRODUCTCODE as "ProductCode",'
      'P.TAXCODE as "Taxcode",'
      'PURCHTAXCODE as "PurchaseTaxcode",'
      'PREFEREDSUPP as "PreferredSupplier",'
      'SpecialDiscount as "SpecialDiscount",'
      '((PRICE1 - COST1)/COST1)*100 as "PercentCost",'
      'P.Active as Active,'
      'P.PARTSID as PARTSID,'
      'SupplierProductCode as SupplierProductCode,'
      'DateCreated as DateCreated,'
      'DateUpdated as DateUpdated,'
      'Area as Area,'
      'Discontinued as Discontinued,'
      'OnSpecial as OnSpecial,'
      'AvgCost as AvgCost,'
      'CUSTFLD1 as CUSTFLD1,'
      'CUSTFLD2 as CUSTFLD2,'
      'CUSTFLD3 as CUSTFLD3,'
      'CUSTFLD4 as CUSTFLD4,'
      'CUSTFLD5 as CUSTFLD5,'
      'CUSTFLD6 as CUSTFLD6,'
      'CUSTFLD7 as CUSTFLD7,'
      'CUSTFLD8 as CUSTFLD8,'
      'CUSTFLD9 as CUSTFLD9,'
      'CUSTFLD10 as CUSTFLD10,'
      'CUSTFLD11 as CUSTFLD11,'
      'CUSTFLD12 as CUSTFLD12,'
      'CUSTFLD13 as CUSTFLD13,'
      'CUSTFLD14 as CUSTFLD14,'
      'CUSTFLD15 as CUSTFLD15,'
      'CUSTDATE1 as CUSTDATE1,'
      'CUSTDATE2 as CUSTDATE2,'
      'CUSTDATE3 as CUSTDATE3,'
      'P.IsSystemProduct as IsSystemProduct,'
      'P.EnablePackWeight as EnablePackWeight,'
      'Attrib1Sale as Attrib1Sale,'
      'Attrib2Sale as Attrib2Sale,'
      'Attrib1SaleRate as Attrib1SaleRate,'
      'Attrib1Purchase as Attrib1Purchase,'
      'Attrib2Purchase as Attrib2Purchase,'
      'Attrib1PurchaseRate as Attrib1PurchaseRate,'
      'If(IsNull(E.EquipmentID),"F","T") as Hire'
      'FROM tblParts as P'
      'Left join tblProductClasses as PC on PC.ProductID = P.PartsId'
      
        'left join tblPQA as PQA on PC.ProductID = PQA.ProductID and PC.C' +
        'lassID = PQA.departmentID'
      'left join tblclass as C on PQA.departmentID = C.ClassID '
      ''
      
        'LEFT JOIN tbltaxcodes AS T1 ON T1.Name = P.TAXCODE AND T1.Region' +
        'ID= 1 '
      
        'LEFT JOIN tbltaxcodes AS T2 ON T2.Name = P.PURCHTAXCODE AND T2.R' +
        'egionID= 1 '
      
        'LEFT JOIN tblEquipment E ON E.ProductId = P.PartsID and E.OnHire' +
        ' = "T"'
      
        'WHERE char_length(P.PARTNAME)>0 AND not IsNull(P.PARTNAME) and i' +
        'fnull(PC.Active,"T") = "T"'
      'and PC.ClassID = 1'
      'GROUP BY P.PARTSID')
    OnCalcFields = qryMainCalcFields
    Left = 211
    Top = 287
    inherited qryMainProductName: TWideStringField
      DisplayWidth = 15
    end
    inherited qryMainPreferedSupplier: TWideStringField
      Visible = False
    end
    inherited qryMainAvailable: TFloatField [2]
    end
    inherited qryMainInStock: TFloatField [3]
    end
    inherited qryMainAllocatedSO: TFloatField [4]
    end
    inherited qryMainAllocatedBO: TFloatField [5]
    end
    inherited qryMainOnOrder: TFloatField [6]
    end
    inherited qryMainBuilding: TFloatField [7]
    end
    inherited qryMainOnBuild: TFloatField [8]
    end
    inherited qryMainOnTransit: TFloatField [9]
      DisplayLabel = 'On Transit'
    end
    inherited qryMainCostExA: TFloatField [10]
    end
    inherited qryMainSOBackOrders: TFloatField [11]
      DisplayLabel = 'SO Back Orders'
    end
    inherited qryMainPriceExA: TFloatField [12]
    end
    inherited qryMainFirstColumn: TWideStringField [13]
      DisplayWidth = 15
    end
    inherited qryMainSecondColumn: TWideStringField [14]
      DisplayWidth = 15
    end
    inherited qryMainThirdColumn: TWideStringField [15]
      DisplayWidth = 15
    end
    inherited qryMainSalesDescription: TWideStringField [16]
      DisplayWidth = 15
    end
    inherited qryMainPurchaseDescription: TWideStringField [17]
      DisplayWidth = 15
    end
    inherited qryMainPRODUCTCODE: TWideStringField [18]
      DisplayLabel = 'ProductCode'
      DisplayWidth = 11
    end
    inherited qryMainTAXCODE: TWideStringField [19]
      DisplayLabel = 'Taxcode'
      DisplayWidth = 6
    end
    inherited qryMainPurchaseTaxcode: TWideStringField [20]
      DisplayWidth = 6
    end
    inherited qryMainActive: TWideStringField [21]
    end
    inherited qryMainPARTSID: TIntegerField [22]
    end
    inherited qryMainProductTypeCode: TWideStringField [23]
    end
    inherited qryMainLandedCost: TFloatField [24]
    end
    inherited qryMainAvgCost: TFloatField [25]
      DisplayLabel = 'Avg Cost'
    end
    inherited qryMainbatch: TWideStringField [26]
    end
    inherited qryMainMultipleBins: TWideStringField [27]
    end
    inherited qryMainSNTracking: TWideStringField [28]
    end
    inherited qryMainCostIncA: TFloatField [29]
    end
    inherited qryMainPriceIncA: TFloatField [30]
    end
    object qryMainGlobalRef: TWideStringField [31]
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainProductType: TWideStringField [32]
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'ProductType'
      LookupDataSet = qryPartTypes
      LookupKeyFields = 'TypeCode'
      LookupResultField = 'TypeDesc'
      KeyFields = 'ProductTypeCode'
      Lookup = True
    end
    object qryMainBuyQtyA: TIntegerField [33]
      DisplayWidth = 10
      FieldName = 'BuyQtyA'
      Origin = 'tblparts.`BuyQtyA`'
    end
    object qryMainBuyQtyB: TIntegerField [34]
      DisplayWidth = 10
      FieldName = 'BuyQtyB'
      Origin = 'tblparts.`BuyQtyB`'
    end
    object qryMainCostExB: TFloatField [35]
      DisplayWidth = 16
      FieldName = 'CostExB'
      Origin = 'tblparts.`CostExB`'
      currency = True
    end
    object qryMainCostIncB: TFloatField [36]
      DisplayWidth = 10
      FieldName = 'CostIncB'
      Origin = 'tblparts.`CostIncB`'
      currency = True
    end
    object qryMainBuyQtyC: TIntegerField [37]
      DisplayWidth = 10
      FieldName = 'BuyQtyC'
      Origin = 'tblparts.`BuyQtyC`'
    end
    object qryMainCostExC: TFloatField [38]
      DisplayWidth = 16
      FieldName = 'CostExC'
      Origin = 'tblparts.`CostExC`'
      currency = True
    end
    object qryMainCostIncC: TFloatField [39]
      DisplayWidth = 10
      FieldName = 'CostIncC'
      Origin = 'tblparts.`CostIncC`'
      currency = True
    end
    object qryMainSellQtyA: TIntegerField [40]
      DisplayWidth = 10
      FieldName = 'SellQtyA'
      Origin = 'tblparts.`SellQtyA`'
    end
    object qryMainSellQtyB: TIntegerField [41]
      DisplayWidth = 10
      FieldName = 'SellQtyB'
      Origin = 'tblparts.`SellQtyB`'
    end
    object qryMainPriceExB: TFloatField [42]
      DisplayWidth = 16
      FieldName = 'PriceExB'
      Origin = 'tblparts.`PriceExB`'
      currency = True
    end
    object qryMainPriceIncB: TFloatField [43]
      DisplayWidth = 10
      FieldName = 'PriceIncB'
      Origin = 'tblparts.`PriceIncB`'
      currency = True
    end
    object qryMainSellQtyC: TIntegerField [44]
      DisplayWidth = 10
      FieldName = 'SellQtyC'
      Origin = 'tblparts.`SellQtyC`'
    end
    object qryMainPriceExC: TFloatField [45]
      DisplayWidth = 16
      FieldName = 'PriceExC'
      Origin = 'tblparts.`PriceExC`'
      currency = True
    end
    object qryMainPriceIncC: TFloatField [46]
      DisplayWidth = 10
      FieldName = 'PriceIncC'
      Origin = 'tblparts.`PriceIncC`'
      currency = True
    end
    object qryMainWholesalePrice: TFloatField [47]
      DisplayWidth = 16
      FieldName = 'WholesalePrice'
      Origin = 'tblparts.`WholesalePrice`'
      currency = True
    end
    object qryMainBarcode: TWideStringField [48]
      DisplayWidth = 35
      FieldName = 'Barcode'
      Origin = 'tblparts.Barcode'
      FixedChar = True
      Size = 35
    end
    object qryMainPreferredSupplier: TWideStringField [49]
      DisplayWidth = 55
      FieldName = 'PreferredSupplier'
      FixedChar = True
      Size = 55
    end
    object qryMainStockValue: TFloatField [50]
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'StockValue'
      Origin = 'tblparts.`StockValue`'
      ReadOnly = True
      currency = True
      Calculated = True
    end
    object qryMainStockValueonLandedCost: TFloatField [51]
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'StockValueonLandedCost'
      ReadOnly = True
      currency = True
      Calculated = True
    end
    object qryMainValueAvg: TFloatField [52]
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ValueAvg'
      currency = True
      Calculated = True
    end
    object qryMainCost: TFloatField [53]
      DisplayWidth = 10
      FieldName = 'PercentCost'
      Origin = 'tblparts.`PercentCost`'
      DisplayFormat = '%####.##'
    end
    object qryMainSupplierProductCode: TWideStringField [54]
      DisplayWidth = 50
      FieldName = 'SupplierProductCode'
      Origin = 'tblparts.SupplierProductCode'
      FixedChar = True
      Size = 50
    end
    object qryMainDateCreated: TDateField [55]
      DisplayWidth = 18
      FieldName = 'DateCreated'
      Origin = 'tblparts.DateCreated'
    end
    object qryMainDateUpdated: TDateField [56]
      DisplayWidth = 18
      FieldName = 'DateUpdated'
      Origin = 'tblparts.DateUpdated'
    end
    object qryMainArea: TWideStringField [57]
      DisplayWidth = 40
      FieldName = 'Area'
      Origin = 'tblparts.Area'
      Size = 255
    end
    object qryMainDiscontinued: TWideStringField [58]
      DisplayWidth = 1
      FieldName = 'Discontinued'
      Origin = 'tblparts.Discontinued'
      FixedChar = True
      Size = 1
    end
    object qryMainOnSpecial: TWideStringField [59]
      DisplayWidth = 1
      FieldName = 'OnSpecial'
      Origin = 'tblparts.OnSpecial'
      FixedChar = True
      Size = 1
    end
    object qryMainMarkupPercentage: TFloatField [60]
      FieldName = 'MarkupPercentage'
    end
    object qryMainMarginMode: TWideStringField [61]
      FieldName = 'MarginMode'
      Size = 100
    end
    object qryMainHasFormulaAttached: TWideStringField [62]
      DisplayLabel = 'Has~Formula?'
      FieldName = 'HasFormulaAttached'
      FixedChar = True
      Size = 1
    end
    object qryMainIncludeInAnalysis: TWideStringField [63]
      DisplayLabel = 'Include In~Analysis?'
      FieldName = 'IncludeInAnalysis'
      FixedChar = True
      Size = 1
    end
    object qryMainSpecialDiscount: TWideStringField [64]
      FieldName = 'SpecialDiscount'
      FixedChar = True
      Size = 1
    end
    object qryMainSalesValue: TFloatField [65]
      FieldKind = fkCalculated
      FieldName = 'SalesValue'
      currency = True
      Calculated = True
    end
    object qryMainIsSystemProduct: TWideStringField [66]
      DisplayLabel = 'System Product?'
      FieldName = 'IsSystemProduct'
      Size = 1
    end
    object qryMainEnablePackWeight: TWideStringField [67]
      DisplayLabel = 'Enabel~Pack Weight?'
      FieldName = 'EnablePackWeight'
      Size = 1
    end
    object qryMainAttrib1Sale: TFloatField [68]
      FieldName = 'Attrib1Sale'
    end
    object qryMainAttrib2Sale: TFloatField [69]
      FieldName = 'Attrib2Sale'
    end
    object qryMainAttrib1SaleRate: TFloatField [70]
      FieldName = 'Attrib1SaleRate'
    end
    object qryMainAttrib1Purchase: TFloatField [71]
      FieldName = 'Attrib1Purchase'
    end
    object qryMainAttrib2Purchase: TFloatField [72]
      FieldName = 'Attrib2Purchase'
    end
    object qryMainAttrib1PurchaseRate: TFloatField [73]
      DisplayWidth = 20
      FieldName = 'Attrib1PurchaseRate'
    end
    object qryMainPRODUCTCOMMENT: TWideStringField [74]
      DisplayLabel = 'Product Comment'
      DisplayWidth = 20
      FieldName = 'PRODUCTCOMMENT'
      Size = 255
    end
    object qryMainVariancePriceInc: TFloatField [75]
      FieldName = 'VariancePriceInc'
      DisplayFormat = '########0.0####'
    end
    object qryMainHire: TWideStringField [76]
      FieldName = 'Hire'
      Size = 1
    end
    object qryMainRA: TFloatField [77]
      FieldName = 'RA'
    end
    inherited qryMainIncomeAccount: TWideStringField
      DisplayWidth = 12
    end
    inherited qryMainAssetAccount: TWideStringField
      DisplayWidth = 12
    end
    inherited qryMainCostofGoodsSoldAccount: TWideStringField
      DisplayWidth = 15
    end
    inherited qryMainProductPrintName: TWideStringField [81]
      Visible = False
    end
    object qryMainRA_AwaitingRANo: TFloatField
      DisplayLabel = 'Awaiting RA No'
      FieldName = 'RA_AwaitingRANo'
    end
    object qryMainRA_InTransit: TFloatField
      DisplayLabel = 'In Transit'
      FieldName = 'RA_InTransit'
    end
    object qryMainRA_Returned: TFloatField
      DisplayLabel = 'Returned'
      FieldName = 'RA_Returned'
    end
    object qryMainRA_SendToSupplier: TFloatField
      DisplayLabel = 'Send To Supplier'
      FieldName = 'RA_SendToSupplier'
    end
    object qryMainRA_Testing: TFloatField
      DisplayLabel = 'Testing'
      FieldName = 'RA_Testing'
    end
    object qryMainRA_WithSupplier: TFloatField
      DisplayLabel = 'With Supplier'
      FieldName = 'RA_WithSupplier'
    end
    object qryMainCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Size = 255
    end
    object qryMainCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Size = 255
    end
    object qryMainCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Size = 255
    end
    object qryMainCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Size = 255
    end
    object qryMainCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object qryMainCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Size = 255
    end
    object qryMainCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Size = 255
    end
    object qryMainCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Size = 255
    end
    object qryMainCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Size = 255
    end
    object qryMainCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Size = 255
    end
    object qryMainCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Size = 255
    end
    object qryMainCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Size = 255
    end
    object qryMainCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Size = 255
    end
    object qryMainCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Size = 255
    end
    object qryMainCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Size = 255
    end
    object qryMainCUSTDATE1: TDateTimeField
      FieldName = 'CUSTDATE1'
    end
    object qryMainCUSTDATE2: TDateTimeField
      FieldName = 'CUSTDATE2'
    end
    object qryMainCUSTDATE3: TDateTimeField
      FieldName = 'CUSTDATE3'
    end
  end
  inherited qryPersonalPrefs: TERPQuery
    Left = 425
    Top = 287
  end
  inherited MyConnection1: TERPConnection
    Database = 'aus_sample_company'
  end
  inherited ExportDialog: TProgressDialog
    Left = 623
    Top = 287
  end
  inherited mnuFilter: TAdvPopupMenu
    Top = 287
    object N1: TMenuItem
      Caption = '-'
      HelpContext = 444092
    end
    object Merge1: TMenuItem
      Action = actMerge
    end
  end
  inherited CustomInputBox: TCustomInputBox
    Left = 689
    Top = 287
  end
  inherited qryCustomReports: TERPQuery
    Left = 392
    Top = 287
  end
  inherited qryCurrencyConversion: TERPQuery
    Left = 326
    Top = 287
  end
  inherited qryFConReport: TERPQuery
    Left = 359
    Top = 287
  end
  inherited FConReport: TkbmMemTable
    Left = 557
    Top = 287
  end
  inherited TimerSearchLabel: TTimer
    Left = 755
    Top = 287
  end
  inherited ProgDialog: TProgressDialog
    Left = 524
    Top = 287
  end
  inherited fPaintTimer: TTimer
    Left = 887
    Top = 287
  end
  inherited timerdateComments: TTimer
    Left = 788
    Top = 287
  end
  inherited mnuHeader: TPopupMenu
    Left = 920
    Top = 287
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 953
    Top = 287
  end
  inherited dlgSave: TSaveDialog
    Left = 821
    Top = 287
  end
  inherited dsMain: TDataSource
    Left = 204
    Top = 241
  end
end
