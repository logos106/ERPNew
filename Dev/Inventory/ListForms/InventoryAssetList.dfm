inherited InventoryAssetListGUI: TInventoryAssetListGUI
  Left = -13
  Top = 89
  HelpContext = 1237002
  Caption = 'Inventory Asset List'
  ClientHeight = 905
  ClientWidth = 1920
  ExplicitLeft = -13
  ExplicitTop = 89
  ExplicitWidth = 1936
  ExplicitHeight = 944
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 810
    Width = 1920
    HelpContext = 1237003
    ExplicitTop = 966
    ExplicitWidth = 1920
  end
  inherited FilterLabel: TLabel
    Top = 810
    Width = 1920
    HelpContext = 1237004
    ExplicitTop = 810
  end
  inherited pnlGraph: TDNMPanel
    Width = 1920
    Height = 681
    HelpContext = 1237005
    ExplicitWidth = 1920
    ExplicitHeight = 681
  end
  inherited HeaderPanel: TPanel
    Width = 1920
    HelpContext = 1237006
    ExplicitWidth = 1920
    DesignSize = (
      1920
      129)
    inherited lblFrom: TLabel
      Left = 1695
      Visible = False
      ExplicitLeft = 1695
    end
    inherited lblTo: TLabel
      Left = 1817
      Visible = False
      ExplicitLeft = 1817
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
      Left = 1731
      ExplicitLeft = 1731
    end
    inherited pnlHeader: TPanel
      Left = 724
      Anchors = [akTop]
      ExplicitLeft = 724
      HelpContext = 1237054
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          HelpContext = 1237007
          Caption = 'Inventory Asset List'
          ExplicitWidth = 347
        end
      end
    end
    inherited Panel2: TPanel
      Width = 1920
      HelpContext = 1237008
      ExplicitWidth = 1920
      inherited grpFilters: TwwRadioGroup
        Width = 1153
        HelpContext = 1237009
        ItemIndex = 0
        Columns = 2
        Items.Strings = (
          'All'
          'Transaction Value <> Balancesheet Amount')
        ExplicitWidth = 1165
      end
      inherited pnlIncludehistory: TDNMPanel
        Left = 1763
        ExplicitLeft = 1763
        HelpContext = 1237055
      end
      object DNMPanel1: TDNMPanel
        Left = 1606
        Top = 0
        Width = 157
        Height = 37
        HelpContext = 1237010
        Align = alRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 3
        Transparent = False
        object Label4: TLabel
          Left = 36
          Top = 1
          Width = 120
          Height = 35
          HelpContext = 1237011
          Align = alRight
          Caption = 'Hide Products with 0 In-Stock Quantity'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitHeight = 30
        end
        object chkHideProducts: TwwCheckBox
          Left = 6
          Top = 9
          Width = 18
          Height = 17
          HelpContext = 1237012
          DisableThemes = False
          AlwaysTransparent = True
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          Color = 15199967
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ShowText = False
          TabOrder = 0
          OnClick = chkHideProductsClick
        end
      end
    end
    inherited Panel3: TPanel
      Width = 1920
      HelpContext = 1237013
      ExplicitWidth = 1920
      DesignSize = (
        1920
        33)
      inherited lblFilter: TLabel
        Left = 47
        ExplicitLeft = 47
      end
      inherited lblSearchoptions: TLabel
        Left = 607
        ExplicitLeft = 607
      end
      inherited lblSearchMode: TLabel
        Left = 1173
        ExplicitLeft = 1173
      end
      inherited cboFilter: TComboBox
        Left = 266
        ExplicitLeft = 266
      end
      inherited edtSearch: TEdit
        Left = 909
        ExplicitLeft = 909
      end
      inherited grpView: TwwRadioGroup
        Left = 1755
        ExplicitLeft = 1754
      end
      inherited pnlSearchbuttons: TDNMPanel
        Left = 654
        ExplicitLeft = 654
        HelpContext = 1237056
      end
      inherited btnEditCahrt: TDNMSpeedButton
        Left = 1665
        ExplicitLeft = 1661
      end
      inherited btnShowMultiSelectSelectionList: TDNMSpeedButton
        Left = 1524
        ExplicitLeft = 1524
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Left = 1731
      Visible = False
      ExplicitLeft = 1731
    end
    inherited dtTo: TwwDBDateTimePicker
      Left = 1831
      Visible = False
      ExplicitLeft = 1831
    end
    inherited chkIgnoreDates: TCheckBox
      Left = 1663
      Visible = False
      ExplicitLeft = 1663
    end
  end
  inherited Panel1: TPanel
    Width = 1920
    Height = 681
    HelpContext = 1237014
    ExplicitWidth = 1920
    ExplicitHeight = 681
    inherited lblDateComments: TLabel
      Top = 665
      Width = 1920
      HelpContext = 1237015
      ExplicitTop = 665
    end
    object Splitter1: TSplitter [1]
      Left = 0
      Top = 343
      Width = 1920
      Height = 2
      Cursor = crVSplit
      HelpContext = 1237016
      Align = alBottom
      OnCanResize = Splitter1CanResize
      OnMoved = Splitter1Moved
      ExplicitTop = 131
      ExplicitWidth = 311
    end
    inherited lblTimerMsg: TLabel
      Top = 327
      Width = 1920
      ExplicitTop = 327
      HelpContext = 1237057
    end
    inherited splMultiSelectList: TSplitter
      Left = 1657
      Height = 158
      ExplicitLeft = 1657
      ExplicitHeight = 158
      HelpContext = 1237058
    end
    inherited grdMain: TwwDBGrid
      Width = 1657
      Height = 158
      Hint = 'Summary from the PQA (based on individual transactions)'
      HelpContext = 1237017
      ControlType.Strings = (
        'IsSystemProduct;CheckBox;T;F'
        'Active;CheckBox;T;F'
        'MultipleBins;CheckBox;T;F'
        'batch;CheckBox;T;F'
        'SNTracking;CheckBox;T;F')
      Selected.Strings = (
        'ProductName'#9'15'#9'Name'#9#9
        'ASSETACCNT'#9'10'#9'Asset~Account'#9'F'#9
        'instock'#9'10'#9'Quantity~In-Stock'#9#9
        'Calctotalcost'#9'10'#9'Transaction~Value'#9'F'#9
        'Balamount'#9'10'#9'Inv Asset On~Balance Sheet'#9#9
        'DiffAmount'#9'10'#9'Balance Sheet - ~Trans Value'#9#9
        'SOBO'#9'10'#9'So Bo'#9#9'Quantity'
        'Available'#9'10'#9'Available'#9#9'Quantity'
        'SOQty'#9'10'#9'SO'#9#9'Quantity'
        'InvBO'#9'10'#9'Inv Bo'#9#9'Quantity'
        'POBO'#9'10'#9'Po Bo'#9#9'Quantity'
        'onbuild'#9'10'#9'On Build Raw'#9#9'Quantity'
        'Building'#9'10'#9'Building'#9#9'Quantity'
        'FirstColumn'#9'10'#9'FirstColumn'#9#9
        'SecondColumn'#9'10'#9'SecondColumn'#9#9
        'ThirdColumn'#9'10'#9'ThirdColumn'#9#9
        'SalesDescription'#9'10'#9'Sales'#9#9
        'PURCHASEDESC'#9'10'#9'Purchase'#9#9
        'ProductCode'#9'10'#9'Code'#9#9
        'PreferredSupplier'#9'10'#9'Preferred~Supplier'#9#9
        'SupplierProductCode'#9'10'#9'Supplier~Code'#9#9
        'ProductTypeCode'#9'5'#9'Type'#9#9
        'Area'#9'10'#9'Area'#9#9
        'MultipleBins'#9'1'#9'Multiple~Bins?'#9#9
        'batch'#9'1'#9'Batch?'#9#9
        'SNTracking'#9'1'#9'SN~Tracking?'#9#9
        'LandedCost'#9'10'#9'Landed~Cost'#9#9
        'cost1'#9'10'#9'Product~Cost'#9#9
        'Price1'#9'10'#9'Price'#9#9
        'WHOLESALEPRICE'#9'10'#9'Whole Sale~Price'#9#9
        'AvgCost'#9'10'#9'Average~Cost'#9'F'#9
        'StockValue'#9'10'#9'Stock Value~on AvgCost'#9#9
        'Active'#9'1'#9'Active?'#9#9
        'IsSystemProduct'#9'1'#9'System~Product?'#9#9)
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
      TitleLines = 2
      OnCalcTitleAttributes = grdMainCalcTitleAttributes
      ExplicitWidth = 1920
      ExplicitHeight = 212
    end
    inherited mem_Note: TMemo
      Width = 1920
      HelpContext = 1237018
      ExplicitWidth = 1920
    end
    inherited pnlMultiSelectList: TDNMPanel
      Left = 1659
      Height = 158
      TabOrder = 3
      ExplicitLeft = 1659
      ExplicitHeight = 158
      HelpContext = 1237059
      inherited chkhideMultiSelectSelectionList: TCheckBox
        Top = 139
        ExplicitTop = 139
      end
    end
    object pgMain: TPageControl
      Left = 0
      Top = 345
      Width = 1920
      Height = 320
      HelpContext = 1237019
      ActivePage = TabBalancesheetDetails
      Align = alBottom
      TabOrder = 2
      object TabBalancesheet: TTabSheet
        HelpContext = 1237020
        Caption = 'Product Summary and Balance Sheet'
        object report1n2: TSplitter
          Left = 1346
          Top = 0
          Width = 2
          Height = 290
          HelpContext = 1237021
          Align = alRight
          ExplicitLeft = 598
          ExplicitTop = 89
          ExplicitHeight = 326
        end
        object grdAccounts: TwwDBGrid
          Left = 0
          Top = 0
          Width = 1346
          Height = 290
          HelpContext = 1237022
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 10
          Selected.Strings = (
            'AccountName'#9'15'#9'Account'
            'Partscount'#9'1'#9'No of Products'
            'calctotalcost'#9'20'#9'Total amount'
            'BalanceSheetamt2'#9'15'#9'Before Closing Date'
            'BalanceSheetamt1'#9'15'#9'After Closing Date'
            'BalanceSheetamt'#9'20'#9'Total'
            'BalanceSheetamtexJE2'#9'15'#9'Before Closing Date'
            'BalanceSheetamtexJE1'#9'15'#9'After Closing Date'
            'BalanceSheetamtexJE'#9'20'#9'Total'
            'Difference'#9'15'#9'Inc JE'
            'DifferenceexJE'#9'15'#9'Ex JE')
          IniAttributes.SaveToRegistry = True
          IniAttributes.Delimiter = ';;'
          IniAttributes.CheckNewFields = True
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Align = alClient
          Color = clWhite
          DataSource = dsAssetAccounts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = True
          LineColors.GroupingColor = clSilver
          OnCalcCellColors = grdAccountsCalcCellColors
          OnCalcTitleAttributes = grdAccountsCalcTitleAttributes
          FooterColor = clWhite
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          object wwIButton2: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 32
            HelpContext = 1237023
            AllowAllUp = True
          end
        end
        object pnlBalancesheet: TDNMPanel
          Left = 1348
          Top = 0
          Width = 564
          Height = 290
          HelpContext = 1237024
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object lblBalancesheet: TLabel
            AlignWithMargins = True
            Left = 17
            Top = 7
            Width = 530
            Height = 16
            HelpContext = 1237025
            Margins.Left = 16
            Margins.Top = 6
            Margins.Right = 16
            Margins.Bottom = 0
            Align = alTop
            AutoSize = False
            Caption = 'Details'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
            ExplicitLeft = 14
            ExplicitTop = 146
            ExplicitWidth = 936
          end
          object grdBalancesheet: TwwDBGrid
            AlignWithMargins = True
            Left = 17
            Top = 23
            Width = 530
            Height = 266
            HelpContext = 1237026
            Margins.Left = 16
            Margins.Top = 0
            Margins.Right = 16
            Margins.Bottom = 0
            ControlType.Strings = (
              'PriorToclosingDt;CheckBox;T;F')
            Selected.Strings = (
              'accountName'#9'20'#9'Account'
              'Type'#9'15'#9'Type'
              'PriorToclosingDt'#9'1'#9'Prior To~Closing Date?'
              'Amount'#9'20'#9'Amount')
            IniAttributes.SaveToRegistry = True
            IniAttributes.Delimiter = ';;'
            IniAttributes.CheckNewFields = True
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
            Align = alClient
            Color = clWhite
            DataSource = dsBalancesheet
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 2
            TitleButtons = True
            LineColors.GroupingColor = clSilver
            OnCalcCellColors = grdBalancesheetCalcCellColors
            OnCalcTitleAttributes = grdBalancesheetCalcTitleAttributes
            FooterColor = clWhite
            FooterCellColor = clWhite
            ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
            PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
            object wwIButton3: TwwIButton
              Left = 0
              Top = 0
              Width = 13
              Height = 18
              HelpContext = 1237027
              AllowAllUp = True
            end
          end
        end
      end
      object TabBalancesheetDetails: TTabSheet
        HelpContext = 1237028
        Caption = 'Balance Sheet Entries for the Product'
        ImageIndex = 2
        object Splitter2: TSplitter
          Left = 1268
          Top = 0
          Width = 2
          Height = 290
          HelpContext = 1237029
          Align = alRight
          ExplicitLeft = 1260
          ExplicitTop = -20
        end
        object Splitter3: TSplitter
          Left = 489
          Top = 0
          Width = 2
          Height = 290
          HelpContext = 1237030
          ExplicitLeft = 598
          ExplicitTop = 89
          ExplicitHeight = 326
        end
        object Label6: TLabel
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 146
          Height = 15
          HelpContext = 1237031
          Margins.Left = 16
          Margins.Top = 6
          Margins.Right = 16
          Margins.Bottom = 0
          Caption = 'Balance Sheet : Summary'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object grdAccountsDetails: TwwDBGrid
          AlignWithMargins = True
          Left = 0
          Top = 15
          Width = 489
          Height = 275
          HelpContext = 1237032
          Margins.Left = 0
          Margins.Top = 15
          Margins.Right = 0
          Margins.Bottom = 0
          ControlType.Strings = (
            'PriorToclosingDt;CheckBox;T;F')
          Selected.Strings = (
            'accountName'#9'15'#9'Account'
            'PriorToclosingDt'#9'1'#9'Prior To~Closing Date?'
            'Type'#9'15'#9'Type'
            'Amount'#9'20'#9'Amount')
          IniAttributes.SaveToRegistry = True
          IniAttributes.Delimiter = ';;'
          IniAttributes.CheckNewFields = True
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Align = alLeft
          Color = clWhite
          DataSource = dsAssetAccountsDetails
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = True
          LineColors.GroupingColor = clSilver
          OnCalcCellColors = grdAccountsCalcCellColors
          OnCalcTitleAttributes = grdAccountsCalcTitleAttributes
          FooterColor = clWhite
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          object wwIButton4: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 32
            HelpContext = 1237033
            AllowAllUp = True
          end
        end
        object PnlBalancesheetDetails: TDNMPanel
          Left = 491
          Top = 0
          Width = 777
          Height = 290
          HelpContext = 1237034
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label2: TLabel
            AlignWithMargins = True
            Left = 17
            Top = 7
            Width = 743
            Height = 16
            HelpContext = 1237035
            Margins.Left = 16
            Margins.Top = 6
            Margins.Right = 16
            Margins.Bottom = 0
            Align = alTop
            AutoSize = False
            Caption = 'Balance Sheet : Details'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
            ExplicitTop = 6
          end
          object grdBalancesheetDetails: TwwDBGrid
            AlignWithMargins = True
            Left = 17
            Top = 23
            Width = 743
            Height = 266
            HelpContext = 1237036
            Margins.Left = 16
            Margins.Top = 0
            Margins.Right = 16
            Margins.Bottom = 0
            ControlType.Strings = (
              'PriorToclosingDt;CheckBox;T;F')
            Selected.Strings = (
              'Type'#9'15'#9'Type'#9#9
              'Seqno'#9'10'#9'Seqno'#9#9
              'Productname'#9'1'#9'Product'#9#9
              'accountName'#9'15'#9'Account'#9#9
              'Amount'#9'20'#9'Amount'#9#9
              'CreditsEx'#9'10'#9'CreditsEx'#9#9
              'DebitsEx'#9'10'#9'DebitsEx'#9#9
              'Date'#9'10'#9'Date'#9'F'#9)
            IniAttributes.SaveToRegistry = True
            IniAttributes.Delimiter = ';;'
            IniAttributes.CheckNewFields = True
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
            Align = alClient
            Color = clWhite
            DataSource = dsBalancesheetDetails
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 2
            TitleButtons = True
            LineColors.GroupingColor = clSilver
            OnCalcCellColors = grdBalancesheetCalcCellColors
            OnCalcTitleAttributes = grdBalancesheetCalcTitleAttributes
            FooterColor = clWhite
            FooterCellColor = clWhite
            ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
            PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
            object wwIButton5: TwwIButton
              Left = 0
              Top = 0
              Width = 13
              Height = 15
              HelpContext = 1237037
              AllowAllUp = True
            end
          end
        end
        object pnlPQa: TDNMPanel
          Left = 1270
          Top = 0
          Width = 642
          Height = 290
          HelpContext = 1237038
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          object Label5: TLabel
            AlignWithMargins = True
            Left = 17
            Top = 7
            Width = 608
            Height = 16
            HelpContext = 1237039
            Margins.Left = 16
            Margins.Top = 6
            Margins.Right = 16
            Margins.Bottom = 0
            Align = alTop
            AutoSize = False
            Caption = 'PQA: Details'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
            ExplicitLeft = 14
            ExplicitTop = 146
            ExplicitWidth = 936
          end
          object grdPQa: TwwDBGrid
            AlignWithMargins = True
            Left = 17
            Top = 23
            Width = 608
            Height = 266
            HelpContext = 1237040
            Margins.Left = 16
            Margins.Top = 0
            Margins.Right = 16
            Margins.Bottom = 0
            ControlType.Strings = (
              'PriorToclosingDt;CheckBox;T;F')
            Selected.Strings = (
              'description'#9'20'#9'description'
              'transId'#9'10'#9'transId'
              'transdate'#9'12'#9'transdate'
              'qty'#9'10'#9'qty'
              'Actualtotalcost'#9'12'#9'Cost (Ex)'
              'Actualtotalcostinc'#9'14'#9'Cost (Inc)')
            IniAttributes.SaveToRegistry = True
            IniAttributes.Delimiter = ';;'
            IniAttributes.CheckNewFields = True
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
            Align = alClient
            Color = clWhite
            DataSource = dsPQa
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = True
            LineColors.GroupingColor = clSilver
            OnCalcCellColors = grdBalancesheetCalcCellColors
            OnCalcTitleAttributes = grdBalancesheetCalcTitleAttributes
            FooterColor = clWhite
            FooterCellColor = clWhite
            ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
            PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
            object wwIButton6: TwwIButton
              Left = 0
              Top = 0
              Width = 13
              Height = 15
              HelpContext = 1237041
              AllowAllUp = True
            end
          end
        end
      end
      object TabProduct: TTabSheet
        HelpContext = 1237042
        Caption = 'Product Summary On Transaction Value'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Splitter4: TSplitter
          Left = 1069
          Top = 0
          Width = 2
          Height = 290
          HelpContext = 1237043
          Align = alRight
          ExplicitLeft = 1264
          ExplicitTop = -22
        end
        object grdcosts: TwwDBGrid
          Left = 0
          Top = 0
          Width = 1069
          Height = 290
          HelpContext = 1237044
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 10
          Selected.Strings = (
            'TransId'#9'1'#9'Trans#'
            'Date'#9'10'#9'Date'
            'Description'#9'15'#9'Type'
            'TransQty'#9'10'#9'Trans Qty'
            'Qty'#9'10'#9'Qty'
            'cost'#9'10'#9'Trans Cost'
            'totalcost'#9'16'#9'Total Cost For Qty')
          IniAttributes.SaveToRegistry = True
          IniAttributes.Delimiter = ';;'
          IniAttributes.CheckNewFields = True
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
          Align = alClient
          Color = clWhite
          DataSource = dsCostDetails
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = True
          LineColors.GroupingColor = clSilver
          OnCalcCellColors = grdcostsCalcCellColors
          OnCalcTitleAttributes = grdcostsCalcTitleAttributes
          FooterColor = clWhite
          FooterCellColor = clWhite
          ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
          PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
          object wwIButton1: TwwIButton
            Left = 0
            Top = 0
            Width = 13
            Height = 17
            HelpContext = 1237045
            AllowAllUp = True
          end
        end
        object pnlBSnPQA: TDNMPanel
          Left = 1071
          Top = 0
          Width = 841
          Height = 290
          HelpContext = 1237046
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          Visible = False
          object Label7: TLabel
            AlignWithMargins = True
            Left = 17
            Top = 7
            Width = 807
            Height = 16
            HelpContext = 1237047
            Margins.Left = 16
            Margins.Top = 6
            Margins.Right = 16
            Margins.Bottom = 0
            Align = alTop
            AutoSize = False
            Caption = 'Quantity Details'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
            ExplicitLeft = 14
            ExplicitTop = 146
            ExplicitWidth = 936
          end
          object grdBSnPQA: TwwDBGrid
            AlignWithMargins = True
            Left = 17
            Top = 23
            Width = 807
            Height = 266
            HelpContext = 1237048
            Margins.Left = 16
            Margins.Top = 0
            Margins.Right = 16
            Margins.Bottom = 0
            ControlType.Strings = (
              'PriorToclosingDt;CheckBox;T;F')
            Selected.Strings = (
              'TYPE'#9'10'#9'Type'
              'ACCOUNTNAME'#9'10'#9'Account'
              'PURCHASEORDERID'#9'10'#9'PO#'
              'SALEID'#9'10'#9'Sale#'
              'DEBITSEX'#9'10'#9'Debit'
              'CREDITSEX'#9'10'#9'Credit'
              'ADEBITSEX'#9'10'#9'Debit'
              'ACREDITSEX'#9'10'#9'Credit'
              'ACTUALTOTALCOST'#9'12'#9'Cost (Ex)'
              'SEQNO'#9'10'#9'Seq no')
            IniAttributes.SaveToRegistry = True
            IniAttributes.Delimiter = ';;'
            IniAttributes.CheckNewFields = True
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
            Align = alClient
            Color = clWhite
            DataSource = dsBSnPQA
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgRowResize]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 2
            TitleButtons = True
            LineColors.GroupingColor = clSilver
            OnCalcCellColors = grdBalancesheetCalcCellColors
            OnCalcTitleAttributes = grdBalancesheetCalcTitleAttributes
            FooterColor = clWhite
            FooterCellColor = clWhite
            ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
            PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
            object wwIButton7: TwwIButton
              Left = 0
              Top = 0
              Width = 13
              Height = 15
              HelpContext = 1237049
              AllowAllUp = True
            end
          end
        end
      end
    end
  end
  inherited FooterPanel: TDNMPanel
    Top = 825
    Width = 1920
    HelpContext = 1237050
    ExplicitTop = 825
    ExplicitWidth = 1920
    DesignSize = (
      1920
      80)
    inherited lblNote: TLabel
      Left = 458
      ExplicitLeft = 458
    end
    inherited lblTimeLabel: TLabel
      Left = 1806
      Top = 6
      Anchors = [akRight, akBottom]
      ExplicitLeft = 1806
      ExplicitTop = 6
    end
    inherited lblTime: TLabel
      Left = 1887
      Top = 6
      Anchors = [akRight, akBottom]
      ExplicitLeft = 1887
      ExplicitTop = 6
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 1164
      ExplicitLeft = 1164
    end
    inherited cmdNew: TDNMSpeedButton
      Left = 917
      ExplicitLeft = 917
    end
    inherited cmdPrint: TDNMSpeedButton
      Left = 1040
      ExplicitLeft = 1040
    end
    inherited cmdExport: TDNMSpeedButton
      Left = 669
      Top = 32
      ExplicitLeft = 669
      ExplicitTop = 32
    end
    inherited btnCustomize: TDNMSpeedButton
      Left = 546
      ExplicitLeft = 546
    end
    inherited pnlAdvPrinting: TDNMPanel
      Left = 829
      ExplicitLeft = 829
      HelpContext = 1237060
    end
    inherited barStatus: TAdvOfficeStatusBar
      Width = 1920
      HelpContext = 1237051
      ExplicitWidth = 1920
    end
    inherited chkShowEmailOptions: TCheckBox
      Left = 1826
      TabOrder = 10
      ExplicitLeft = 1826
    end
    object btndiff: TDNMSpeedButton
      Left = 1288
      Top = 32
      Width = 87
      Height = 27
      HelpContext = 1237052
      Anchors = [akBottom]
      Caption = 'Diff'
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
      TabOrder = 8
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btndiffClick
    end
    object DNMSpeedButton3: TDNMSpeedButton
      Left = 793
      Top = 32
      Width = 95
      Height = 27
      Hint = 'Product Movement summary of all selected Products'
      HelpContext = 1237053
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
      TabOrder = 9
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton3Click
    end
  end
  inherited imgPopup: TImageList
    Bitmap = {
      494C010108002403300310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select * from tmp_1')
    object qryMainProductName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 15
      FieldName = 'ProductName'
      Origin = 'tmp_1.ProductName'
      Size = 60
    end
    object QrymainASSETACCNT: TWideStringField
      DisplayLabel = 'Asset~Account'
      DisplayWidth = 10
      FieldName = 'ASSETACCNT'
      Origin = 'tmp_1.ASSETACCNT'
      Size = 255
    end
    object qryMaininstock: TFloatField
      DisplayLabel = 'Quantity~In-Stock'
      DisplayWidth = 10
      FieldName = 'instock'
      Origin = 'tmp_1.instock'
    end
    object qryMainCalctotalcost: TFloatField
      DisplayLabel = 'Transaction~Value'
      DisplayWidth = 10
      FieldName = 'Calctotalcost'
      Origin = 'tmp_1.Calctotalcost'
      currency = True
    end
    object qryMainBalamount: TFloatField
      DisplayLabel = 'Inv Asset On~Balance Sheet'
      DisplayWidth = 10
      FieldName = 'Balamount'
      Origin = 'tmp_1.Balamount'
      currency = True
    end
    object qryMainDiffAmount: TFloatField
      DisplayLabel = 'Balance Sheet - ~Trans Value'
      DisplayWidth = 10
      FieldName = 'DiffAmount'
      Origin = 'tmp_1.DiffAmount'
      currency = True
    end
    object qryMainSOBO: TFloatField
      DisplayLabel = 'So Bo'
      DisplayWidth = 10
      FieldName = 'SOBO'
      Origin = 'tmp_1.SOBO'
    end
    object qryMainAvailable: TFloatField
      DisplayWidth = 10
      FieldName = 'Available'
      Origin = 'tmp_1.Available'
    end
    object qryMainSOQty: TFloatField
      DisplayLabel = 'SO'
      DisplayWidth = 10
      FieldName = 'SOQty'
      Origin = 'tmp_1.SOQty'
    end
    object qryMainInvBO: TFloatField
      DisplayLabel = 'Inv Bo'
      DisplayWidth = 10
      FieldName = 'InvBO'
      Origin = 'tmp_1.InvBO'
    end
    object qryMainPOBO: TFloatField
      DisplayLabel = 'Po Bo'
      DisplayWidth = 10
      FieldName = 'POBO'
      Origin = 'tmp_1.POBO'
    end
    object qryMainonbuild: TFloatField
      DisplayLabel = 'On Build Raw'
      DisplayWidth = 10
      FieldName = 'onbuild'
      Origin = 'tmp_1.onbuild'
    end
    object qryMainBuilding: TFloatField
      DisplayWidth = 10
      FieldName = 'Building'
      Origin = 'tmp_1.Building'
    end
    object qryMainFirstColumn: TWideStringField
      DisplayWidth = 10
      FieldName = 'FirstColumn'
      Origin = 'tmp_1.FirstColumn'
      Size = 255
    end
    object qryMainSecondColumn: TWideStringField
      DisplayWidth = 10
      FieldName = 'SecondColumn'
      Origin = 'tmp_1.SecondColumn'
      Size = 255
    end
    object qryMainThirdColumn: TWideStringField
      DisplayWidth = 10
      FieldName = 'ThirdColumn'
      Origin = 'tmp_1.ThirdColumn'
      Size = 255
    end
    object qryMainSalesDescription: TWideStringField
      DisplayLabel = 'Sales'
      DisplayWidth = 10
      FieldName = 'SalesDescription'
      Origin = 'tmp_1.SalesDescription'
      Size = 255
    end
    object qryMainPURCHASEDESC: TWideStringField
      DisplayLabel = 'Purchase'
      DisplayWidth = 10
      FieldName = 'PURCHASEDESC'
      Origin = 'tmp_1.PURCHASEDESC'
      Size = 255
    end
    object qryMainProductCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 10
      FieldName = 'ProductCode'
      Origin = 'tmp_1.ProductCode'
      Size = 255
    end
    object qryMainPreferredSupplier: TWideStringField
      DisplayLabel = 'Preferred~Supplier'
      DisplayWidth = 10
      FieldName = 'PreferredSupplier'
      Origin = 'tmp_1.PreferredSupplier'
      Size = 55
    end
    object qryMainSupplierProductCode: TWideStringField
      DisplayLabel = 'Supplier~Code'
      DisplayWidth = 10
      FieldName = 'SupplierProductCode'
      Origin = 'tmp_1.SupplierProductCode'
      Size = 50
    end
    object qryMainProductTypeCode: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 5
      FieldName = 'ProductTypeCode'
      Origin = 'tmp_1.ProductTypeCode'
      Size = 13
    end
    object qryMainArea: TWideStringField
      DisplayWidth = 10
      FieldName = 'Area'
      Origin = 'tmp_1.Area'
      Size = 50
    end
    object qryMainMultipleBins: TWideStringField
      DisplayLabel = 'Multiple~Bins?'
      DisplayWidth = 1
      FieldName = 'MultipleBins'
      Origin = 'tmp_1.MultipleBins'
      FixedChar = True
      Size = 1
    end
    object qryMainbatch: TWideStringField
      DisplayLabel = 'Batch?'
      DisplayWidth = 1
      FieldName = 'batch'
      Origin = 'tmp_1.batch'
      FixedChar = True
      Size = 1
    end
    object qryMainSNTracking: TWideStringField
      DisplayLabel = 'SN~Tracking?'
      DisplayWidth = 1
      FieldName = 'SNTracking'
      Origin = 'tmp_1.SNTracking'
      FixedChar = True
      Size = 1
    end
    object qryMainLandedCost: TFloatField
      DisplayLabel = 'Landed~Cost'
      DisplayWidth = 10
      FieldName = 'LandedCost'
      Origin = 'tmp_1.LandedCost'
      currency = True
    end
    object qryMaincost1: TFloatField
      DisplayLabel = 'Product~Cost'
      DisplayWidth = 10
      FieldName = 'cost1'
      Origin = 'tmp_1.cost1'
      currency = True
    end
    object qryMainPrice1: TFloatField
      DisplayLabel = 'Price'
      DisplayWidth = 10
      FieldName = 'Price1'
      Origin = 'tmp_1.Price1'
      currency = True
    end
    object qryMainWHOLESALEPRICE: TFloatField
      DisplayLabel = 'Whole Sale~Price'
      DisplayWidth = 10
      FieldName = 'WHOLESALEPRICE'
      Origin = 'tmp_1.WHOLESALEPRICE'
    end
    object qryMainAvgCost: TFloatField
      DisplayLabel = 'Average~Cost'
      DisplayWidth = 10
      FieldName = 'AvgCost'
      Origin = 'tmp_1.AvgCost'
      currency = True
    end
    object qryMainStockValue: TFloatField
      DisplayLabel = 'Stock Value~on AvgCost'
      DisplayWidth = 10
      FieldName = 'StockValue'
      Origin = 'tmp_1.StockValue'
      currency = True
    end
    object qryMainActive: TWideStringField
      DisplayLabel = 'Active?'
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tmp_1.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainIsSystemProduct: TWideStringField
      DisplayLabel = 'System~Product?'
      DisplayWidth = 1
      FieldName = 'IsSystemProduct'
      Origin = 'tmp_1.IsSystemProduct'
      FixedChar = True
      Size = 1
    end
    object qryMainPartsID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsID'
      Origin = 'tmp_1.PartsID'
      Visible = False
    end
  end
  inherited MyConnection1: TERPConnection
    Server = 'localhost'
  end
  object dsCostDetails: TDataSource
    DataSet = QryCostDetails
    Left = 654
    Top = 567
  end
  object QryCostDetails: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'Select T.* , TT.Description from tmp_InvAsset_Admin_3C1163BACost' +
        's T inner join tblpqatranstypes TT on T.type = TT.Transtype')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterOpen = QryCostDetailsAfterOpen
    MasterSource = dsMain
    MasterFields = 'PartsID'
    DetailFields = 'PartsId'
    Left = 686
    Top = 567
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PartsID'
        ParamType = ptInput
        Value = 35
      end>
    object QryCostDetailsTransId: TIntegerField
      DisplayLabel = 'Trans#'
      DisplayWidth = 1
      FieldName = 'TransId'
      Origin = 'T.TransId'
    end
    object QryCostDetailsDate: TDateTimeField
      DisplayWidth = 10
      FieldName = 'Date'
      Origin = 'T.Date'
    end
    object QryCostDetailsDescription: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 15
      FieldName = 'Description'
      Origin = 'TT.Description'
      Size = 100
    end
    object QryCostDetailsTransQty: TFloatField
      DisplayLabel = 'Trans Qty'
      DisplayWidth = 10
      FieldName = 'TransQty'
      Origin = 'T.TransQty'
    end
    object QryCostDetailsQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'T.Qty'
    end
    object QryCostDetailscost: TFloatField
      DisplayLabel = 'Trans Cost'
      DisplayWidth = 10
      FieldName = 'cost'
      Origin = 'T.cost'
      currency = True
    end
    object QryCostDetailstotalcost: TFloatField
      DisplayLabel = 'Total Cost For Qty'
      DisplayWidth = 16
      FieldName = 'totalcost'
      Origin = 'T.totalcost'
      currency = True
    end
    object QryCostDetailstype: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'type'
      Origin = 'T.type'
      Visible = False
      Size = 100
    end
    object QryCostDetailsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'T.ID'
      Visible = False
    end
    object QryCostDetailsPartsId: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsId'
      Origin = 'T.PartsId'
      Visible = False
    end
  end
  object dsAssetAccounts: TDataSource
    DataSet = QryAssetAccounts
    Left = 54
    Top = 567
  end
  object QryAssetAccounts: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select * from tmp_InvAsset_Admin_3C1163BAAccounts')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterOpen = QryAssetAccountsAfterOpen
    AfterScroll = CalcAccountTotals
    DetailFields = 'PartsId'
    Left = 86
    Top = 567
    object QryAssetAccountsAccountName: TWideStringField
      DisplayLabel = 'Account'
      DisplayWidth = 15
      FieldName = 'AccountName'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.AccountName'
      Size = 100
    end
    object QryAssetAccountsPartscount: TIntegerField
      DisplayLabel = 'No of Products'
      DisplayWidth = 1
      FieldName = 'Partscount'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.Partscount'
    end
    object QryAssetAccountscalctotalcost: TFloatField
      DisplayLabel = 'Total amount'
      DisplayWidth = 20
      FieldName = 'calctotalcost'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.calctotalcost'
      currency = True
    end
    object QryAssetAccountsBalanceSheetamt2: TFloatField
      DisplayLabel = 'Before Closing Date'
      DisplayWidth = 15
      FieldName = 'BalanceSheetamt2'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.BalanceSheetamt2'
      currency = True
    end
    object QryAssetAccountsBalanceSheetamt1: TFloatField
      DisplayLabel = 'After Closing Date'
      DisplayWidth = 15
      FieldName = 'BalanceSheetamt1'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.BalanceSheetamt1'
      currency = True
    end
    object QryAssetAccountsBalanceSheetamt: TFloatField
      DisplayLabel = 'Total'
      DisplayWidth = 20
      FieldName = 'BalanceSheetamt'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.BalanceSheetamt'
      currency = True
    end
    object QryAssetAccountsBalanceSheetamtexJE2: TFloatField
      DisplayLabel = 'Before Closing Date'
      DisplayWidth = 15
      FieldName = 'BalanceSheetamtexJE2'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.BalanceSheetamtexJE2'
      currency = True
    end
    object QryAssetAccountsBalanceSheetamtexJE1: TFloatField
      DisplayLabel = 'After Closing Date'
      DisplayWidth = 15
      FieldName = 'BalanceSheetamtexJE1'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.BalanceSheetamtexJE1'
      currency = True
    end
    object QryAssetAccountsBalanceSheetamtexJE: TFloatField
      DisplayLabel = 'Total'
      DisplayWidth = 20
      FieldName = 'BalanceSheetamtexJE'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.BalanceSheetamtexJE'
      currency = True
    end
    object QryAssetAccountsDifference: TFloatField
      DisplayLabel = 'Inc JE'
      DisplayWidth = 15
      FieldName = 'Difference'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.Difference'
      currency = True
    end
    object QryAssetAccountsDifferenceexJE: TFloatField
      DisplayLabel = 'Ex JE'
      DisplayWidth = 15
      FieldName = 'DifferenceexJE'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.DifferenceexJE'
      currency = True
    end
    object QryAssetAccountsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tmp_invasset_admin_3c1163baaccounts.ID'
      Visible = False
    end
  end
  object dsCostsum: TDataSource
    DataSet = QryCostsum
    Left = 654
    Top = 607
  end
  object QryCostsum: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'Select PartsID, sum(totalcost) as totalcost from tmp_invasset_ad' +
        'min_3c1163bacosts  group by partsID')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    MasterSource = dsMain
    MasterFields = 'PartsID'
    DetailFields = 'PartsId'
    Left = 686
    Top = 607
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PartsID'
        ParamType = ptInput
        Value = 35
      end>
    object QryCostsumPartsID: TIntegerField
      FieldName = 'PartsID'
    end
    object QryCostsumtotalcost: TFloatField
      FieldName = 'totalcost'
    end
  end
  object dsBalancesheet: TDataSource
    DataSet = QryBalancesheet
    Left = 54
    Top = 607
  end
  object dsBalancesheetDetails: TDataSource
    DataSet = QryBalancesheetDetails
    Left = 318
    Top = 607
  end
  object QryBalancesheetDetails: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT Trans.Date,Trans.Seqno,Trans.PurchaseOrderId, Trans.saleI' +
        'd,Trans.PaymentID, Trans.PrepaymentID , Trans.FixedAssetID, "F" ' +
        'PriorToclosingDt,  Trans.accountName, Trans.ProductName, Trans.T' +
        'ype, DebitsEx,CreditsEx, TRUNCATE((DebitsEx)-(CreditsEx),4) AS A' +
        'mount  FROM tbltransactions   as Trans  WHERE Trans.AccountName ' +
        'in (Select Distinct AccountName from  tmp_InvAsset_Admin_3C1163B' +
        'AAccounts) and Productname = '#39'TDSW'#39'  union all SELECT Trans.Date' +
        ',Trans.Seqno,Trans.PurchaseOrderId, Trans.saleId,Trans.PaymentID' +
        ', Trans.PrepaymentID , Trans.FixedAssetID, "T" PriorToclosingDt,' +
        '  Trans.accountName, Trans.ProductName, Trans.Type, DebitsEx,Cre' +
        'ditsEx, TRUNCATE((DebitsEx)-(CreditsEx),4) AS Amount  FROM tbltr' +
        'ansactionsummarydetails   as Trans  WHERE Trans.AccountName in (' +
        'Select Distinct AccountName from  tmp_InvAsset_Admin_3C1163BAAcc' +
        'ounts) and Productname = '#39'TDSW'#39'  order by  date desc  ,Type, Pri' +
        'orToclosingDt')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterOpen = QryBalancesheetDetailsAfterOpen
    MasterSource = dsAssetAccountsDetails
    MasterFields = 'Type;accountName'
    DetailFields = 'Type;accountName'
    Left = 350
    Top = 607
    ParamData = <
      item
        DataType = ftWideString
        Name = 'Type'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Name = 'accountName'
        ParamType = ptInput
      end>
    object WideStringField1: TWideStringField
      DisplayWidth = 15
      FieldName = 'Type'
      Origin = 'Type'
      Size = 50
    end
    object QryBalancesheetDetailsSeqno: TFloatField
      DisplayWidth = 10
      FieldName = 'Seqno'
      Origin = 'Seqno'
    end
    object QryBalancesheetDetailsProductname: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 1
      FieldName = 'Productname'
      Origin = 'Productname'
      Size = 60
    end
    object WideStringField3: TWideStringField
      DisplayLabel = 'Account'
      DisplayWidth = 15
      FieldName = 'accountName'
      Origin = 'accountName'
      Size = 50
    end
    object FloatField1: TFloatField
      DisplayWidth = 20
      FieldName = 'Amount'
      Origin = 'Amount'
      currency = True
    end
    object QryBalancesheetDetailsCreditsEx: TFloatField
      DisplayWidth = 10
      FieldName = 'CreditsEx'
      Origin = 'CreditsEx'
      currency = True
    end
    object QryBalancesheetDetailsDebitsEx: TFloatField
      DisplayWidth = 10
      FieldName = 'DebitsEx'
      Origin = 'DebitsEx'
      currency = True
    end
    object WideStringField2: TWideStringField
      DisplayLabel = 'Prior To~Closing Date?'
      DisplayWidth = 1
      FieldName = 'PriorToclosingDt'
      Origin = 'PriorToclosingDt'
      Visible = False
      Size = 1
    end
    object QryBalancesheetDetailsPurchaseOrderId: TIntegerField
      FieldName = 'PurchaseOrderId'
      Origin = 'PurchaseOrderId'
      Visible = False
    end
    object QryBalancesheetDetailssaleId: TIntegerField
      FieldName = 'saleId'
      Origin = 'saleId'
      Visible = False
    end
    object QryBalancesheetDetailsPaymentID: TIntegerField
      FieldName = 'PaymentID'
      Origin = 'PaymentID'
      Visible = False
    end
    object QryBalancesheetDetailsPrepaymentID: TIntegerField
      FieldName = 'PrepaymentID'
      Origin = 'PrepaymentID'
      Visible = False
    end
    object QryBalancesheetDetailsFixedAssetID: TIntegerField
      FieldName = 'FixedAssetID'
      Origin = 'FixedAssetID'
      Visible = False
    end
    object QryBalancesheetDetailsDate: TDateField
      DisplayWidth = 10
      FieldName = 'Date'
    end
  end
  object QryBalancesheet: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT  "F" PriorToclosingDt,  Trans.accountName,  Trans.Type,  ' +
        'TRUNCATE(Sum(DebitsEx)-Sum(CreditsEx),4) AS Amount  '
      'FROM tbltransactions   as Trans  '
      
        'WHERE Trans.AccountName in (Select Distinct AccountName from  tm' +
        'p_InvAsset_Admin_3C1163BAAccounts) '
      'Group By type'
      ''
      'union all  '
      
        'SELECT  "T" as PriorToclosingDt,  Trans.Accountname,  Trans.Type' +
        ',  TRUNCATE(Sum(DebitsEx)-Sum(CreditsEx),4) AS Amount  '
      'FROM tbltransactionsummarydetails  as Trans  '
      
        'WHERE Trans.AccountName in (Select Distinct AccountName from  tm' +
        'p_InvAsset_Admin_3C1163BAAccounts) '
      'Group By type')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterOpen = QryBalancesheetAfterOpen
    MasterSource = dsAssetAccounts
    MasterFields = 'AccountName'
    DetailFields = 'accountName'
    Left = 86
    Top = 607
    ParamData = <
      item
        DataType = ftWideString
        Name = 'AccountName'
        ParamType = ptInput
        Value = 'Inventory Asset'
      end>
    object QryBalancesheetaccountName: TWideStringField
      DisplayLabel = 'Account'
      DisplayWidth = 20
      FieldName = 'accountName'
      Origin = 'accountName'
      Size = 50
    end
    object QryBalancesheetType: TWideStringField
      DisplayWidth = 15
      FieldName = 'Type'
      Origin = 'Type'
      Size = 50
    end
    object QryBalancesheetPriorToclosingDt: TWideStringField
      DisplayLabel = 'Prior To~Closing Date?'
      DisplayWidth = 1
      FieldName = 'PriorToclosingDt'
      Origin = 'PriorToclosingDt'
      Size = 1
    end
    object QryBalancesheetAmount: TFloatField
      DisplayWidth = 20
      FieldName = 'Amount'
      Origin = 'Amount'
      currency = True
    end
  end
  object QryAssetAccountsDetails: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'SELECT  "F" PriorToclosingDt,  Trans.accountName,  Trans.Type,  ' +
        'TRUNCATE(Sum(DebitsEx)-Sum(CreditsEx),4) AS Amount  '
      'FROM tbltransactions   as Trans  '
      
        'WHERE Trans.AccountName in (Select Distinct AccountName from  tm' +
        'p_InvAsset_Admin_3C1163BAAccounts) '
      'and Productname = :ProductName'
      'Group By type, Trans.AccountType  '
      'union all  '
      
        'SELECT  "T" as PriorToclosingDt,  Trans.Accountname,  Trans.Type' +
        ',  TRUNCATE(Sum(DebitsEx)-Sum(CreditsEx),4) AS Amount  '
      'FROM tbltransactionsummarydetails  as Trans  '
      
        'WHERE Trans.AccountName in (Select Distinct AccountName from  tm' +
        'p_InvAsset_Admin_3C1163BAAccounts) '
      'and Productname = :ProductName'
      'Group By type, Trans.AccountType')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterOpen = QryAssetAccountsDetailsAfterOpen
    Left = 350
    Top = 567
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductName'
      end
      item
        DataType = ftUnknown
        Name = 'ProductName'
      end>
    object WideStringField6: TWideStringField
      DisplayLabel = 'Account'
      DisplayWidth = 15
      FieldName = 'accountName'
      Origin = 'accountName'
      Size = 50
    end
    object WideStringField5: TWideStringField
      DisplayLabel = 'Prior To~Closing Date?'
      DisplayWidth = 1
      FieldName = 'PriorToclosingDt'
      Origin = 'PriorToclosingDt'
      Size = 1
    end
    object WideStringField4: TWideStringField
      DisplayWidth = 15
      FieldName = 'Type'
      Origin = 'Type'
      Size = 50
    end
    object FloatField2: TFloatField
      DisplayWidth = 20
      FieldName = 'Amount'
      Origin = 'Amount'
      currency = True
    end
  end
  object dsAssetAccountsDetails: TDataSource
    DataSet = QryAssetAccountsDetails
    Left = 318
    Top = 567
  end
  object dsPQa: TDataSource
    DataSet = QryPQa
    Left = 318
    Top = 655
  end
  object QryPQa: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'select T.transId, TT.description, T.TransLineId, T.productName, ' +
        'T.Alloctype, T.Actualtotalcost ,T.Actualtotalcostinc, T.qty, T.t' +
        'ransdate '
      'from tbltransactionpqas T'
      'Left join tblpqatranstypes TT on T.TransType = TT.transType'
      
        'where productname = :ProductName order by transdate desc , T.tra' +
        'nstype')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterOpen = QryPQaAfterOpen
    Left = 350
    Top = 655
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductName'
      end>
    object QryPQadescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'description'
      Origin = 'TT.description'
      Size = 100
    end
    object QryPQatransId: TLargeintField
      DisplayWidth = 10
      FieldName = 'transId'
      Origin = 'T.transId'
    end
    object QryPQatransdate: TDateTimeField
      DisplayWidth = 12
      FieldName = 'transdate'
      Origin = 'T.transdate'
    end
    object QryPQaqty: TFloatField
      DisplayWidth = 10
      FieldName = 'qty'
      Origin = 'T.qty'
      DisplayFormat = '###,###,###.#####'
    end
    object QryPQaActualtotalcost: TFloatField
      DisplayLabel = 'Cost (Ex)'
      DisplayWidth = 12
      FieldName = 'Actualtotalcost'
      Origin = 'T.Actualtotalcost'
      currency = True
    end
    object QryPQaActualtotalcostinc: TFloatField
      DisplayLabel = 'Cost (Inc)'
      DisplayWidth = 14
      FieldName = 'Actualtotalcostinc'
      Origin = 'T.Actualtotalcostinc'
      currency = True
    end
    object QryPQaTransLineId: TIntegerField
      FieldName = 'TransLineId'
      Origin = 'T.TransLineId'
      Visible = False
    end
    object QryPQaproductName: TWideStringField
      FieldName = 'productName'
      Origin = 'T.productName'
      Visible = False
      Size = 100
    end
    object QryPQaAlloctype: TWideStringField
      FieldName = 'Alloctype'
      Origin = 'T.Alloctype'
      Visible = False
      Size = 3
    end
  end
  object dsBSnPQA: TDataSource
    DataSet = QryBSnPQA
    Left = 774
    Top = 567
  end
  object QryBSnPQA: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from tmp_transactioninvasset_3c1163ba')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    AfterOpen = QryBSnPQAAfterOpen
    Left = 806
    Top = 567
    object QryBSnPQATYPE: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'TYPE'
      Origin = 'tmp_transactioninvasset_3c1163ba.TYPE'
      Size = 100
    end
    object QryBSnPQAACCOUNTNAME: TWideStringField
      DisplayLabel = 'Account'
      DisplayWidth = 10
      FieldName = 'ACCOUNTNAME'
      Origin = 'tmp_transactioninvasset_3c1163ba.ACCOUNTNAME'
      Size = 100
    end
    object QryBSnPQAPURCHASEORDERID: TIntegerField
      DisplayLabel = 'PO#'
      DisplayWidth = 10
      FieldName = 'PURCHASEORDERID'
      Origin = 'tmp_transactioninvasset_3c1163ba.PURCHASEORDERID'
    end
    object QryBSnPQASALEID: TIntegerField
      DisplayLabel = 'Sale#'
      DisplayWidth = 10
      FieldName = 'SALEID'
      Origin = 'tmp_transactioninvasset_3c1163ba.SALEID'
    end
    object QryBSnPQADEBITSEX: TFloatField
      DisplayLabel = 'Debit'
      DisplayWidth = 10
      FieldName = 'DEBITSEX'
      Origin = 'tmp_transactioninvasset_3c1163ba.DEBITSEX'
      currency = True
    end
    object QryBSnPQACREDITSEX: TFloatField
      DisplayLabel = 'Credit'
      DisplayWidth = 10
      FieldName = 'CREDITSEX'
      Origin = 'tmp_transactioninvasset_3c1163ba.CREDITSEX'
      currency = True
    end
    object QryBSnPQAADEBITSEX: TFloatField
      DisplayLabel = 'Debit'
      DisplayWidth = 10
      FieldName = 'ADEBITSEX'
      Origin = 'tmp_transactioninvasset_3c1163ba.ADEBITSEX'
      currency = True
    end
    object QryBSnPQAACREDITSEX: TFloatField
      DisplayLabel = 'Credit'
      DisplayWidth = 10
      FieldName = 'ACREDITSEX'
      Origin = 'tmp_transactioninvasset_3c1163ba.ACREDITSEX'
      currency = True
    end
    object QryBSnPQAACTUALTOTALCOST: TFloatField
      DisplayLabel = 'Cost (Ex)'
      DisplayWidth = 12
      FieldName = 'ACTUALTOTALCOST'
      Origin = 'tmp_transactioninvasset_3c1163ba.ACTUALTOTALCOST'
      currency = True
    end
    object QryBSnPQASEQNO: TIntegerField
      DisplayLabel = 'Seq no'
      DisplayWidth = 10
      FieldName = 'SEQNO'
      Origin = 'tmp_transactioninvasset_3c1163ba.SEQNO'
    end
    object QryBSnPQAID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tmp_transactioninvasset_3c1163ba.ID'
      Visible = False
    end
    object QryBSnPQADATE: TDateTimeField
      FieldName = 'DATE'
      Origin = 'tmp_transactioninvasset_3c1163ba.DATE'
      Visible = False
    end
    object QryBSnPQAPQAID: TIntegerField
      FieldName = 'PQAID'
      Origin = 'tmp_transactioninvasset_3c1163ba.PQAID'
      Visible = False
    end
    object QryBSnPQACLASSID: TIntegerField
      FieldName = 'CLASSID'
      Origin = 'tmp_transactioninvasset_3c1163ba.CLASSID'
      Visible = False
    end
    object QryBSnPQAPAYMENTID: TIntegerField
      FieldName = 'PAYMENTID'
      Origin = 'tmp_transactioninvasset_3c1163ba.PAYMENTID'
      Visible = False
    end
    object QryBSnPQAPREPAYMENTID: TIntegerField
      FieldName = 'PREPAYMENTID'
      Origin = 'tmp_transactioninvasset_3c1163ba.PREPAYMENTID'
      Visible = False
    end
    object QryBSnPQAFIXEDASSETID: TIntegerField
      FieldName = 'FIXEDASSETID'
      Origin = 'tmp_transactioninvasset_3c1163ba.FIXEDASSETID'
      Visible = False
    end
    object QryBSnPQASALELINEID: TIntegerField
      FieldName = 'SALELINEID'
      Origin = 'tmp_transactioninvasset_3c1163ba.SALELINEID'
      Visible = False
    end
    object QryBSnPQAPURCHASELINEID: TIntegerField
      FieldName = 'PURCHASELINEID'
      Origin = 'tmp_transactioninvasset_3c1163ba.PURCHASELINEID'
      Visible = False
    end
    object QryBSnPQAPAYMENTLINEID: TIntegerField
      FieldName = 'PAYMENTLINEID'
      Origin = 'tmp_transactioninvasset_3c1163ba.PAYMENTLINEID'
      Visible = False
    end
    object QryBSnPQAPREPAYMENTLINEID: TIntegerField
      FieldName = 'PREPAYMENTLINEID'
      Origin = 'tmp_transactioninvasset_3c1163ba.PREPAYMENTLINEID'
      Visible = False
    end
    object QryBSnPQAACCOUNTGROUPLEVELS: TWideStringField
      FieldName = 'ACCOUNTGROUPLEVELS'
      Origin = 'tmp_transactioninvasset_3c1163ba.ACCOUNTGROUPLEVELS'
      Visible = False
      Size = 306
    end
    object QryBSnPQALEVEL1: TWideStringField
      FieldName = 'LEVEL1'
      Origin = 'tmp_transactioninvasset_3c1163ba.LEVEL1'
      Visible = False
      Size = 255
    end
    object QryBSnPQALEVEL2: TWideStringField
      FieldName = 'LEVEL2'
      Origin = 'tmp_transactioninvasset_3c1163ba.LEVEL2'
      Visible = False
      Size = 255
    end
    object QryBSnPQALEVEL3: TWideStringField
      FieldName = 'LEVEL3'
      Origin = 'tmp_transactioninvasset_3c1163ba.LEVEL3'
      Visible = False
      Size = 255
    end
    object QryBSnPQALEVEL4: TWideStringField
      FieldName = 'LEVEL4'
      Origin = 'tmp_transactioninvasset_3c1163ba.LEVEL4'
      Visible = False
      Size = 255
    end
    object QryBSnPQAACCOUNTID: TIntegerField
      FieldName = 'ACCOUNTID'
      Origin = 'tmp_transactioninvasset_3c1163ba.ACCOUNTID'
      Visible = False
    end
    object QryBSnPQAACCOUNTTYPE: TWideStringField
      FieldName = 'ACCOUNTTYPE'
      Origin = 'tmp_transactioninvasset_3c1163ba.ACCOUNTTYPE'
      Visible = False
      Size = 100
    end
    object QryBSnPQAPRODUCTNAME: TWideStringField
      FieldName = 'PRODUCTNAME'
      Origin = 'tmp_transactioninvasset_3c1163ba.PRODUCTNAME'
      Visible = False
      Size = 100
    end
    object QryBSnPQADEBITSINC: TFloatField
      FieldName = 'DEBITSINC'
      Origin = 'tmp_transactioninvasset_3c1163ba.DEBITSINC'
      Visible = False
      currency = True
    end
    object QryBSnPQACREDITSINC: TFloatField
      FieldName = 'CREDITSINC'
      Origin = 'tmp_transactioninvasset_3c1163ba.CREDITSINC'
      Visible = False
      currency = True
    end
    object QryBSnPQAADEBITSINC: TFloatField
      FieldName = 'ADEBITSINC'
      Origin = 'tmp_transactioninvasset_3c1163ba.ADEBITSINC'
      Visible = False
      currency = True
    end
    object QryBSnPQAACREDITSINC: TFloatField
      FieldName = 'ACREDITSINC'
      Origin = 'tmp_transactioninvasset_3c1163ba.ACREDITSINC'
      Visible = False
      currency = True
    end
  end
end
