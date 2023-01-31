inherited fmDU_Product: TfmDU_Product
  Left = -8
  Top = 140
  HelpContext = 984001
  Caption = 'fmDU_Product'
  ClientHeight = 722
  ClientWidth = 794
  ExplicitLeft = -8
  ExplicitTop = 140
  ExplicitWidth = 810
  ExplicitHeight = 761
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 722
    Width = 794
    HelpContext = 984002
    ExplicitTop = 381
    ExplicitWidth = 838
  end
  inherited pnlMain: TDNMPanel
    Width = 794
    Height = 722
    HelpContext = 984003
    ExplicitWidth = 794
    ExplicitHeight = 722
    inherited pnlTop: TDNMPanel
      Width = 792
      HelpContext = 984004
      ExplicitWidth = 792
      inherited Shader1: TShader
        Width = 790
        HelpContext = 984005
        ExplicitWidth = 790
        inherited lblCaption: TLabel
          Width = 790
          HelpContext = 984006
          Caption = '  Product Properties'
          ExplicitLeft = -1
          ExplicitTop = -4
          ExplicitWidth = 790
          ExplicitHeight = 42
        end
      end
    end
    inherited pnlDEtails: TDNMPanel
      Width = 792
      Height = 673
      HelpContext = 984007
      ExplicitWidth = 792
      ExplicitHeight = 673
      object sbmain: TScrollBox
        Left = 1
        Top = 1
        Width = 790
        Height = 671
        HelpContext = 984008
        HorzScrollBar.Visible = False
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
        object pnlcost: TDNMPanel
          Left = 0
          Top = 0
          Width = 773
          Height = 186
          HelpContext = 984009
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            773
            186)
          object Label2: TLabel
            Left = 102
            Top = 151
            Width = 562
            Height = 30
            HelpContext = 984010
            Alignment = taCenter
            Anchors = [akLeft, akBottom]
            Caption = 
              'Note:  If Product'#39's '#39'Auto Price Update'#39' is turned on (Product Ca' +
              'rd-> Miscellaneous -.General), Changing the '#39'Cost'#39' will automati' +
              'cally update the '#39'Price'#39' as well based on the  '#39'Markup / Gross M' +
              'argin'#39' percentage.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            WordWrap = True
            ExplicitTop = 214
          end
          object chkcost: TCheckBox
            Left = 63
            Top = 27
            Width = 141
            Height = 17
            HelpContext = 984011
            Alignment = taLeftJustify
            Caption = 'Update Product Cost'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object optcostOption: TRadioGroup
            AlignWithMargins = True
            Left = 215
            Top = 13
            Width = 290
            Height = 44
            Hint = 
              'Choosing Amount here will update all 3 costs of the product to v' +
              'alue given'
            HelpContext = 984012
            Columns = 3
            ItemIndex = 0
            Items.Strings = (
              '&Increase By'
              '&Decrease By'
              '&Amount')
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = FlagtoUpdate
          end
          object optcosttype: TRadioGroup
            AlignWithMargins = True
            Left = 506
            Top = 13
            Width = 193
            Height = 44
            HelpContext = 984013
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              '&Percentage'
              '&Dollars')
            TabOrder = 2
            OnClick = FlagtoUpdate
          end
          object edtcostAmt: TLabeledEdit
            Left = 701
            Top = 28
            Width = 62
            Height = 23
            HelpContext = 984014
            EditLabel.Width = 44
            EditLabel.Height = 15
            EditLabel.Caption = 'Amount'
            EditLabel.Transparent = True
            EditLabel.Layout = tlCenter
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = '1.00'
            OnChange = FlagtoUpdate
          end
          object chkprice: TCheckBox
            Left = 61
            Top = 95
            Width = 143
            Height = 17
            HelpContext = 984015
            Alignment = taLeftJustify
            Caption = 'Update Product Price'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
          end
          object optpriceOption: TRadioGroup
            AlignWithMargins = True
            Left = 377
            Top = 63
            Width = 159
            Height = 81
            Hint = 
              'Choosing Amount here will update all 3 Prices of the product to ' +
              'value given'
            HelpContext = 984016
            ItemIndex = 0
            Items.Strings = (
              '&Increase By'
              '&Decrease By'
              '&Amount')
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = FlagtoUpdate
          end
          object optPricetype: TRadioGroup
            AlignWithMargins = True
            Left = 540
            Top = 63
            Width = 159
            Height = 81
            HelpContext = 984017
            ItemIndex = 0
            Items.Strings = (
              '&Percentage'
              '&Dollars')
            TabOrder = 6
            OnClick = FlagtoUpdate
          end
          object edtPriceAmt: TLabeledEdit
            Left = 701
            Top = 92
            Width = 62
            Height = 23
            HelpContext = 984018
            EditLabel.Width = 44
            EditLabel.Height = 15
            EditLabel.Caption = 'Amount'
            EditLabel.Transparent = True
            EditLabel.Layout = tlCenter
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            Text = '1.00'
            OnChange = FlagtoUpdate
          end
          object OptPriceBasedon: TRadioGroup
            AlignWithMargins = True
            Left = 215
            Top = 63
            Width = 159
            Height = 81
            HelpContext = 984062
            Caption = 'Update Price based on'
            ItemIndex = 1
            Items.Strings = (
              'Product Cost '
              'Product Price')
            ParentShowHint = False
            ShowHint = True
            TabOrder = 8
            OnClick = FlagtoUpdate
          end
        end
        object pnlReorderpoint: TDNMPanel
          Left = 0
          Top = 186
          Width = 773
          Height = 120
          HelpContext = 984029
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object lblRounding: TLabel
            Left = 622
            Top = 62
            Width = 141
            Height = 15
            HelpContext = 984070
            Caption = 'Rounding To The Nearest'
            Transparent = True
          end
          object btnReorderPoint: TDNMSpeedButton
            Left = 31
            Top = 30
            Width = 97
            Height = 45
            HelpContext = 984073
            Caption = 'ReorderPoint     %'
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 0
            WordWrap = True
            OnClick = btnReorderPointClick
          end
          object btnPreferredLevel: TDNMSpeedButton
            Left = 142
            Top = 30
            Width = 97
            Height = 45
            HelpContext = 984074
            Caption = 'PreferredLevel  %'
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 1
            WordWrap = True
            OnClick = btnPreferredLevelClick
          end
          object btnReorderAmount: TDNMSpeedButton
            Left = 254
            Top = 30
            Width = 97
            Height = 45
            HelpContext = 984075
            Caption = 'ReorderAmount %'
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 2
            WordWrap = True
            OnClick = btnReorderAmountClick
          end
          object spReorderPoint: TSpinEdit
            Left = 56
            Top = 85
            Width = 49
            Height = 24
            HelpContext = 984076
            MaxValue = 100
            MinValue = -100
            TabOrder = 3
            Value = 0
          end
          object spPreferredLevel: TSpinEdit
            Left = 168
            Top = 85
            Width = 49
            Height = 24
            HelpContext = 984077
            MaxValue = 100
            MinValue = -100
            TabOrder = 4
            Value = 0
          end
          object spReorderAmount: TSpinEdit
            Left = 280
            Top = 85
            Width = 49
            Height = 24
            HelpContext = 984078
            MaxValue = 100
            MinValue = -100
            TabOrder = 5
            Value = 0
          end
          object cbRounding: TComboBox
            Left = 622
            Top = 85
            Width = 141
            Height = 23
            HelpContext = 984079
            TabOrder = 6
            Text = 'cbRounding'
          end
          object chkDoRound: TCheckBox
            Left = 622
            Top = 30
            Width = 141
            Height = 17
            HelpContext = 984080
            Caption = 'Round Reorder Points'
            TabOrder = 7
            OnClick = chkDoRoundClick
          end
          object chkAllMonths: TCheckBox
            Left = 410
            Top = 30
            Width = 174
            Height = 17
            HelpContext = 984082
            Caption = 'Adjust Points for All Months'
            TabOrder = 8
            OnClick = chkAllMonthsClick
          end
          object cbMonth: TCheckComboBox
            Left = 410
            Top = 85
            Width = 141
            Height = 22
            HelpContext = 984083
            AutoComplete = False
            TabOrder = 9
          end
          object chkAdjustReorderPoints: TCheckBox
            Left = 30
            Top = 5
            Width = 174
            Height = 17
            HelpContext = 984084
            Alignment = taLeftJustify
            Caption = 'Adjust Reorder Points '
            TabOrder = 10
            OnClick = chkAllMonthsClick
          end
        end
        object pnlActive: TDNMPanel
          Left = 0
          Top = 827
          Width = 773
          Height = 68
          HelpContext = 984034
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object chkActive: TCheckBox
            Left = 86
            Top = 27
            Width = 118
            Height = 17
            HelpContext = 984035
            Alignment = taLeftJustify
            Caption = 'Activate Product '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object OptActive: TRadioGroup
            Left = 215
            Top = 13
            Width = 368
            Height = 44
            HelpContext = 984036
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              '&Active'
              '&Inactive')
            TabOrder = 1
            OnClick = FlagtoUpdate
          end
        end
        object pnlSalesDefault: TDNMPanel
          Left = 0
          Top = 477
          Width = 773
          Height = 68
          HelpContext = 984037
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object Label4: TLabel
            Left = 553
            Top = 32
            Width = 11
            Height = 15
            HelpContext = 984038
            Caption = 'of'
            Transparent = True
          end
          object Label3: TLabel
            Left = 649
            Top = 11
            Width = 47
            Height = 15
            HelpContext = 984039
            Caption = 'Defaults'
            Transparent = True
          end
          object Label5: TLabel
            Left = 365
            Top = 11
            Width = 65
            Height = 15
            HelpContext = 984040
            Caption = 'Description'
            Transparent = True
          end
          object Label1: TLabel
            Left = 215
            Top = 11
            Width = 89
            Height = 15
            HelpContext = 984041
            Caption = 'Unit of Measure'
            Transparent = True
          end
          object pnlUOM: TLabel
            Left = 506
            Top = 11
            Width = 77
            Height = 15
            HelpContext = 984042
            Caption = 'Unit Multiplier'
            Transparent = True
          end
          object Bevel1: TBevel
            Left = 649
            Top = 28
            Width = 106
            Height = 23
            HelpContext = 984043
          end
          object chkUOM: TCheckBox
            Left = 45
            Top = 27
            Width = 159
            Height = 17
            HelpContext = 984044
            Alignment = taLeftJustify
            Caption = 'Make Unit Of Meassure'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object edtUnit: TwwDBLookupCombo
            Left = 215
            Top = 28
            Width = 146
            Height = 23
            HelpContext = 984045
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            LookupTable = qryUOM2
            LookupField = 'UnitName'
            ParentFont = False
            TabOrder = 1
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnChange = FlagtoUpdate
          end
          object edtDesc: TEdit
            Left = 367
            Top = 28
            Width = 133
            Height = 23
            HelpContext = 984046
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = FlagtoUpdate
          end
          object cboUnitOfMeasure: TwwDBLookupCombo
            Left = 569
            Top = 28
            Width = 77
            Height = 23
            HelpContext = 984047
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'UnitName'#9'15'#9'Unit Name'#9'F')
            DataField = 'BaseUnitName'
            LookupTable = qrycboUnitOfMeasure
            LookupField = 'UnitName'
            Style = csDropDownList
            ParentFont = False
            TabOrder = 4
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnChange = FlagtoUpdate
          end
          object chkSalesDefault: TwwCheckBox
            Left = 653
            Top = 31
            Width = 54
            Height = 17
            HelpContext = 984048
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
            Caption = '&Sales'
            DataField = 'SalesDefault'
            TabOrder = 5
            OnClick = FlagtoUpdate
          end
          object chkPurchDefault: TwwCheckBox
            Left = 713
            Top = 32
            Width = 37
            Height = 14
            HelpContext = 984049
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
            Caption = '&PO'
            DataField = 'PurchasesDefault'
            TabOrder = 6
            OnClick = FlagtoUpdate
          end
          object edMultiplier: TEdit
            Left = 506
            Top = 28
            Width = 42
            Height = 23
            HelpContext = 984050
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = FlagtoUpdate
          end
        end
        object pnlallocations: TDNMPanel
          Left = 0
          Top = 306
          Width = 773
          Height = 171
          HelpContext = 984057
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          DesignSize = (
            773
            171)
          object chkbatch: TCheckBox
            Left = 8
            Top = 21
            Width = 201
            Height = 17
            HelpContext = 984058
            Alignment = taLeftJustify
            Caption = 'Update Product Batch Tracking'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object optBatch: TRadioGroup
            Left = 215
            Top = 3
            Width = 300
            Height = 52
            HelpContext = 984059
            Columns = 3
            ItemIndex = 0
            Items.Strings = (
              '&Off'
              '&Automatic Allocation'
              '&Manual Allocation')
            TabOrder = 1
            WordWrap = True
            OnClick = FlagtoUpdate
          end
          object chkbin: TCheckBox
            Left = 23
            Top = 77
            Width = 186
            Height = 17
            HelpContext = 984055
            Alignment = taLeftJustify
            Caption = 'Update Product Bin Tracking'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
          object optbin: TRadioGroup
            Left = 215
            Top = 59
            Width = 300
            Height = 52
            HelpContext = 984056
            Columns = 3
            ItemIndex = 0
            Items.Strings = (
              '&Off'
              '&Automatic Allocation'
              '&Manual Allocation')
            TabOrder = 3
            WordWrap = True
            OnClick = FlagtoUpdate
          end
          object chksn: TCheckBox
            Left = 23
            Top = 133
            Width = 186
            Height = 17
            HelpContext = 984052
            Alignment = taLeftJustify
            Caption = 'Update Product SN Tracking'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
          end
          object optSN: TRadioGroup
            Left = 215
            Top = 115
            Width = 204
            Height = 52
            HelpContext = 984053
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'O&ff'
              'O&n')
            TabOrder = 5
            WordWrap = True
            OnClick = FlagtoUpdate
          end
          object DNMPanel1: TDNMPanel
            Left = 518
            Top = 1
            Width = 254
            Height = 169
            Anchors = [akLeft, akTop, akBottom]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 6
            HelpContext = 984085
            object lblAllocationhint: TLabel
              AlignWithMargins = True
              Left = 1
              Top = 1
              Width = 248
              Height = 163
              HelpContext = 984086
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alClient
              Caption = 
                'Once the Serial No'#39's / Batches / Bins already Exist For the Prod' +
                'uct,  You Can Only Turn Off Batch / Bin / SN Tracking(Based on t' +
                'he Company Preference : Inventory ->Allow Changing Product Alloc' +
                'ation Flags .   You Cannot Turn it back ON'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clMaroon
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              WordWrap = True
              ExplicitWidth = 246
              ExplicitHeight = 90
            end
          end
        end
        object pnlUpdateSupplier: TDNMPanel
          Left = 0
          Top = 691
          Width = 773
          Height = 68
          HelpContext = 984063
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          object Label6: TLabel
            Left = 215
            Top = 7
            Width = 105
            Height = 15
            HelpContext = 984064
            Caption = 'Preferred Supplier'
            Transparent = True
          end
          object Label7: TLabel
            Left = 408
            Top = 7
            Width = 82
            Height = 15
            HelpContext = 984065
            Caption = 'Supplier Code:'
            Transparent = True
            Visible = False
          end
          object chkPreferedSupplier: TCheckBox
            Left = 31
            Top = 27
            Width = 173
            Height = 17
            HelpContext = 984066
            Alignment = taLeftJustify
            Caption = 'Update Preferred Supplier'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object cboSupp: TwwDBLookupCombo
            Left = 215
            Top = 24
            Width = 181
            Height = 23
            HelpContext = 984060
            BiDiMode = bdLeftToRight
            ParentBiDiMode = False
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Company'#9'30'#9'Supplier'#9'T')
            DataField = 'PREFEREDSUPP'
            LookupTable = cboClientLookup
            LookupField = 'Company'
            Options = [loSearchOnBackspace]
            ParentFont = False
            TabOrder = 1
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object edtSupplierProductCode: TEdit
            Left = 410
            Top = 24
            Width = 133
            Height = 23
            HelpContext = 984067
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            Visible = False
            OnChange = FlagtoUpdate
          end
        end
        object pnlLinkDepartment: TDNMPanel
          Left = 0
          Top = 545
          Width = 773
          Height = 146
          HelpContext = 984068
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          object chkClasses: TCheckBox
            Left = 9
            Top = 66
            Width = 195
            Height = 17
            HelpContext = 984069
            Alignment = taLeftJustify
            Caption = 'Link Departments to Products'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object grdClasses: TwwDBGrid
            Left = 215
            Top = 8
            Width = 368
            Height = 132
            HelpContext = 984061
            Selected.Strings = (
              'classname'#9'47'#9'Name'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            DataSource = dsClasses
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
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
        end
        object pnlUpdateWithPurchaseCost: TDNMPanel
          Left = 0
          Top = 759
          Width = 773
          Height = 68
          HelpContext = 984087
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          object chkUpdateWithPurchaseCost: TCheckBox
            Left = 31
            Top = 18
            Width = 173
            Height = 34
            HelpContext = 984088
            Alignment = taLeftJustify
            Caption = 'Update Product Cost with Purchase Cost '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            WordWrap = True
          end
          object OptUpdateWithPurchaseCost: TRadioGroup
            Left = 215
            Top = 13
            Width = 368
            Height = 44
            HelpContext = 984089
            Columns = 2
            ItemIndex = 0
            Items.Strings = (
              'O&ff'
              'O&n')
            TabOrder = 1
            OnClick = FlagtoUpdate
          end
        end
      end
    end
  end
  object qryUOM2: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblunitsofmeasure GROUP BY UnitName')
    Left = 474
    Top = 292
  end
  object qrycboUnitOfMeasure: TERPQuery
    SQL.Strings = (
      'SELECT  U.UnitID as UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 AND Multiplier ' +
        ' = 1'
      'Group By U.UnitName Desc'
      'Order By U.UnitName')
    Left = 525
    Top = 310
    object qrycboUnitOfMeasureUnitName: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 15
      FieldName = 'UnitName'
      Size = 15
    end
    object qrycboUnitOfMeasureUnitID: TAutoIncField
      FieldName = 'UnitID'
      ReadOnly = True
      Visible = False
    end
    object qrycboUnitOfMeasureUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Visible = False
      Size = 35
    end
  end
  object cboClientLookup: TERPQuery
    SQLDelete.Strings = (
      'DELETE FROM tblclients'
      'WHERE'
      '  ClientID = :Old_ClientID')
    SQLUpdate.Strings = (
      'UPDATE tblclients'
      'SET'
      
        '  ClientID = :ClientID, Company = :Company, ForeignExchangeSellC' +
        'ode = :ForeignExchangeSellCode'
      'WHERE'
      '  ClientID = :Old_ClientID')
    SQLRefresh.Strings = (
      
        'SELECT tblclients.ClientID, tblclients.Company, tblclients.Forei' +
        'gnExchangeSellCode FROM tblclients'
      'WHERE'
      '  tblclients.ClientID = :Old_ClientID')
    SQL.Strings = (
      'SELECT ClientID, Company, ForeignExchangeSellCode'
      'FROM tblclients'
      
        'WHERE tblclients.Company Is Not Null And tblclients.Active <>'#39'F'#39 +
        ' And tblclients.Supplier = '#39'T'#39
      ''
      '')
    FetchRows = 1
    Left = 326
    Top = 656
    object cboClientLookupCompany: TWideStringField
      DisplayWidth = 80
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object cboClientLookupClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
    end
    object cboClientLookupForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblclients.ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
  end
  object QryClasses: TERPQuery
    SQLDelete.Strings = (
      'DELETE FROM tblclients'
      'WHERE'
      '  ClientID = :Old_ClientID')
    SQLUpdate.Strings = (
      'UPDATE tblclients'
      'SET'
      
        '  ClientID = :ClientID, Company = :Company, ForeignExchangeSellC' +
        'ode = :ForeignExchangeSellCode'
      'WHERE'
      '  ClientID = :Old_ClientID')
    SQLRefresh.Strings = (
      
        'SELECT tblclients.ClientID, tblclients.Company, tblclients.Forei' +
        'gnExchangeSellCode FROM tblclients'
      'WHERE'
      '  tblclients.ClientID = :Old_ClientID')
    Connection = MyConnection
    SQL.Strings = (
      
        'select classId , classname from tblclass where active ="T" order' +
        ' by classname')
    FetchRows = 1
    Left = 398
    Top = 552
    object QryClassesclassname: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 47
      FieldName = 'classname'
      Origin = 'tblclass.ClassName'
      Size = 60
    end
    object QryClassesclassId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'classId'
      Origin = 'tblclass.ClassID'
      Visible = False
    end
  end
  object dsClasses: TDataSource
    DataSet = QryClasses
    Left = 402
    Top = 527
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 528
    Top = 551
  end
end
