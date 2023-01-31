inherited frmClass: TfrmClass
  Left = 707
  Top = 124
  HelpContext = 245000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Class'
  ClientHeight = 593
  ClientWidth = 723
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 707
  ExplicitTop = 124
  ExplicitWidth = 739
  ExplicitHeight = 632
  DesignSize = (
    723
    593)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 543
    Width = 723
    HelpContext = 245043
    ExplicitTop = 461
    ExplicitWidth = 723
  end
  inherited imgGridWatermark: TImage
    HelpContext = 245001
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 723
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlTitle: TDNMPanel
      Left = 199
      Top = 5
      Width = 326
      Height = 40
      HelpContext = 245040
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
        Width = 322
        Height = 36
        HelpContext = 245041
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
          Width = 322
          Height = 36
          HelpContext = 245042
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Class'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 1
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 50
    Width = 723
    Height = 493
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 144
    ExplicitTop = 24
    ExplicitWidth = 150
    ExplicitHeight = 50
    object PgMain: TPageControl
      Left = 1
      Top = 1
      Width = 721
      Height = 491
      ActivePage = TabStS
      Align = alClient
      TabOrder = 0
      OnChange = PgMainChange
      OnChanging = PgMainChanging
      OnResize = PgMainResize
      ExplicitHeight = 359
      object TabMain: TTabSheet
        Caption = 'Main'
        ExplicitLeft = 7
        ExplicitTop = 25
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel2: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 707
          Height = 455
          HelpContext = 245007
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          ExplicitTop = -21
          ExplicitWidth = 700
          ExplicitHeight = 449
          object Description_Label: TLabel
            Left = 19
            Top = 77
            Width = 103
            Height = 18
            HelpContext = 245008
            AutoSize = False
            Caption = 'Description'
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
            Left = 19
            Top = 19
            Width = 117
            Height = 15
            HelpContext = 245009
            AutoSize = False
            Caption = 'Header Class'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label7: TLabel
            Left = 174
            Top = 21
            Width = 117
            Height = 15
            HelpContext = 245010
            AutoSize = False
            Caption = 'Sub Class 1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label10: TLabel
            Left = 327
            Top = 20
            Width = 117
            Height = 15
            HelpContext = 245011
            AutoSize = False
            Caption = 'Sub Class 2'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label3: TLabel
            Left = 480
            Top = 20
            Width = 68
            Height = 15
            HelpContext = 245012
            Caption = 'Class Name'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label2: TLabel
            Left = 360
            Top = 77
            Width = 91
            Height = 15
            HelpContext = 245013
            Caption = 'Class Tree View'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lblAddress1: TLabel
            Left = 32
            Top = 152
            Width = 66
            Height = 18
            HelpContext = 245017
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Address : '
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblAddress2: TLabel
            Left = 32
            Top = 178
            Width = 66
            Height = 18
            HelpContext = 245018
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Address 2 : '
            Enabled = False
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
            Left = 32
            Top = 232
            Width = 66
            Height = 18
            HelpContext = 245019
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'City : '
            Enabled = False
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
            Left = 32
            Top = 258
            Width = 66
            Height = 18
            HelpContext = 245020
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'State : '
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblPostcode: TLabel
            Left = 32
            Top = 285
            Width = 66
            Height = 18
            HelpContext = 245021
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Postcode : '
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblAddress3: TLabel
            Left = 32
            Top = 205
            Width = 66
            Height = 18
            HelpContext = 245022
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Address 3 : '
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object lblCountry: TLabel
            Left = 32
            Top = 312
            Width = 66
            Height = 18
            HelpContext = 245023
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Country : '
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            WordWrap = True
          end
          object Label9: TLabel
            Left = 624
            Top = 20
            Width = 54
            Height = 15
            HelpContext = 245044
            Caption = 'Site Code'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lblLocationCode: TLabel
            Left = 7
            Top = 339
            Width = 91
            Height = 15
            HelpContext = 496046
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Location Code : '
            Enabled = False
            Transparent = True
          end
          object edtDescription: TDBEdit
            Left = 19
            Top = 95
            Width = 327
            Height = 23
            HelpContext = 245024
            DataField = 'Description'
            DataSource = frmClassSrc
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
          end
          object cboAccLevel1: TwwDBLookupCombo
            Left = 19
            Top = 36
            Width = 123
            Height = 23
            HelpContext = 245025
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            LookupTable = qryAccLevel1
            LookupField = 'AccLevel1'
            Style = csDropDownList
            DropDownWidth = 150
            ParentFont = False
            TabOrder = 0
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
            OnChange = cboAccLevel1Change
            OnExit = cboAccLevel1Exit
          end
          object cboAccLevel2: TwwDBLookupCombo
            Left = 172
            Top = 36
            Width = 123
            Height = 23
            HelpContext = 245026
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            LookupTable = qryAccLevel2
            LookupField = 'AccLevel2'
            Style = csDropDownList
            DropDownWidth = 150
            ParentFont = False
            TabOrder = 1
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
            OnChange = cboAccLevel2Change
            OnExit = cboAccLevel2Exit
          end
          object cboAccLevel3: TwwDBLookupCombo
            Left = 325
            Top = 36
            Width = 123
            Height = 23
            HelpContext = 245027
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            LookupTable = qryAccLevel3
            LookupField = 'AccLevel3'
            Style = csDropDownList
            DropDownWidth = 150
            ParentFont = False
            TabOrder = 2
            AutoDropDown = True
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = True
            OnChange = cboAccLevel3Change
          end
          object edtClassName: TwwDBEdit
            Left = 479
            Top = 36
            Width = 123
            Height = 23
            HelpContext = 245028
            DataField = 'ClassName'
            DataSource = frmClassSrc
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnChange = edtClassNameChange
          end
          object AccountTreeView: TTreeView
            Left = 360
            Top = 95
            Width = 327
            Height = 130
            HelpContext = 245029
            AutoExpand = True
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Indent = 21
            ParentFont = False
            ReadOnly = True
            ShowButtons = False
            TabOrder = 16
            TabStop = False
          end
          object chkAutoCreateSmartOrders: TDBCheckBox
            Left = 32
            Top = 358
            Width = 287
            Height = 44
            HelpContext = 245030
            Caption = 
              'Allow the creation of Smart Orders when converting a Quote to a ' +
              'Sales Order.'
            DataField = 'AutoCreateSmartOrders'
            DataSource = frmClassSrc
            TabOrder = 6
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            WordWrap = True
          end
          object chkAutoCreateRepairs: TDBCheckBox
            Left = 32
            Top = 407
            Width = 287
            Height = 44
            HelpContext = 245031
            Caption = 'Auto Create Repair when converting Quote to Sales Order.'
            DataField = 'AutoCreateRepairs'
            DataSource = frmClassSrc
            TabOrder = 7
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            WordWrap = True
          end
          object chkUseAddress: TDBCheckBox
            Left = 19
            Top = 126
            Width = 327
            Height = 17
            HelpContext = 245032
            Caption = '  Use this shipping address on Purchase Orders'
            DataField = 'UseAddress'
            DataSource = frmClassSrc
            TabOrder = 8
            ValueChecked = 'T'
            ValueUnchecked = 'F'
            OnClick = chkUseAddressClick
          end
          object edtStreet: TDBEdit
            Left = 109
            Top = 150
            Width = 186
            Height = 23
            HelpContext = 245033
            DataField = 'Street'
            DataSource = frmClassSrc
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object edtStreet2: TDBEdit
            Left = 109
            Top = 176
            Width = 186
            Height = 23
            HelpContext = 245034
            DataField = 'Street2'
            DataSource = frmClassSrc
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 10
          end
          object cboSuburb: TwwDBLookupCombo
            Left = 109
            Top = 229
            Width = 186
            Height = 23
            HelpContext = 245035
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
            DataSource = frmClassSrc
            LookupTable = SuburbQry
            LookupField = 'City_sub'
            Enabled = False
            ParentFont = False
            TabOrder = 12
            AutoDropDown = True
            ShowButton = True
            UseTFields = False
            PreciseEditRegion = False
            AllowClearKey = False
            OnCloseUp = cboSuburbCloseUp
          end
          object edtState: TDBEdit
            Left = 109
            Top = 256
            Width = 89
            Height = 23
            HelpContext = 245036
            DataField = 'State'
            DataSource = frmClassSrc
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 13
          end
          object edtPostcode: TDBEdit
            Left = 109
            Top = 282
            Width = 89
            Height = 23
            HelpContext = 245037
            DataField = 'Postcode'
            DataSource = frmClassSrc
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 14
          end
          object edtStreet3: TDBEdit
            Left = 109
            Top = 203
            Width = 186
            Height = 23
            HelpContext = 245038
            DataField = 'Street3'
            DataSource = frmClassSrc
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 11
          end
          object edtCountry: TDBEdit
            Left = 109
            Top = 309
            Width = 186
            Height = 23
            HelpContext = 245039
            DataField = 'Country'
            DataSource = frmClassSrc
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
          end
          object edtSiteCode: TwwDBEdit
            Left = 623
            Top = 36
            Width = 58
            Height = 23
            HelpContext = 245045
            DataField = 'SiteCode'
            DataSource = frmClassSrc
            Font.Charset = ANSI_CHARSET
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
          object DNMPanel5: TDNMPanel
            AlignWithMargins = True
            Left = 360
            Top = 231
            Width = 327
            Height = 208
            Margins.Left = 0
            Margins.Right = 0
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 17
            object Label11: TLabel
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
            object Label13: TLabel
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
              Top = 47
              Width = 319
              Height = 157
              Hint = 'Double click to Restore a Deleted Product'
              HelpContext = 254381
              ControlType.Strings = (
                'Active;CheckBox;T;F'
                'IsprimaryBarcode;CheckBox;T;F'
                'ProductName;CustomEdit;cboTaxExceptionProduct;F')
              Selected.Strings = (
                'ProductName'#9'33'#9'ProductName'
                'Active'#9'1'#9'Active')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
              Align = alBottom
              DataSource = dsDepttaxexceptionproducts
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
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
              DataSource = dsDepttaxexceptionproducts
              LookupTable = QryProduct
              LookupField = 'Partname'
              Options = [loTitles]
              TabOrder = 0
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
              DataIDField = 'ProductID'
              LookupIDField = 'PartsID'
              LookupFieldAlt = 'ProductPrintName'
            end
            object cboTaxCode: TERPDbLookupCombo
              Left = 119
              Top = 3
              Width = 198
              Height = 23
              DropDownAlignment = taLeftJustify
              Selected.Strings = (
                'Taxname'#9'15'#9'Taxname'#9'F')
              DataField = 'Taxname'
              DataSource = frmClassSrc
              LookupTable = qryTaxCodes
              LookupField = 'Taxname'
              TabOrder = 1
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnNotInList = cboTaxCodeNotInList
              LookupFormClassName = 'TTaxCodeListGUI'
              EditFormClassName = 'TfrmTaxcode'
              LookupFormKeyStringFieldName = 'Name'
              LookupComboType = ctTaxcode
              AllowFullListSearchMode = False
              DisableNotInList = False
              AllowMultipleSelectFromList = False
              OpenListinF6WhenNotinList = False
              DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
              DataIDField = 'TaxID'
              LookupIDField = 'TaxCodeID'
            end
          end
          object edtLocationCode: TwwDBEdit
            Left = 109
            Top = 336
            Width = 91
            Height = 23
            HelpContext = 496049
            DataField = 'LocationCode'
            DataSource = frmClassSrc
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 18
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
          end
        end
      end
      object TabStS: TTabSheet
        Caption = 'Seed To Sale'
        ImageIndex = 1
        object Label1: TLabel
          Left = 92
          Top = 34
          Width = 106
          Height = 15
          HelpContext = 372057
          Alignment = taRightJustify
          Caption = 'Principle Contact : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label4: TLabel
          Left = 53
          Top = 81
          Width = 145
          Height = 15
          HelpContext = 372057
          Alignment = taRightJustify
          Caption = 'Principle Contact Phone : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label6: TLabel
          Left = 99
          Top = 129
          Width = 99
          Height = 15
          HelpContext = 372057
          Alignment = taRightJustify
          Caption = 'License Number :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object lblbin: TLabel
          Left = 116
          Top = 177
          Width = 82
          Height = 15
          Alignment = taRightJustify
          Caption = 'Default Room :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cboPrincipleContact: TwwDBLookupCombo
          Left = 213
          Top = 30
          Width = 307
          Height = 23
          HelpContext = 372066
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'25'#9'EmployeeName'#9'F')
          DataField = 'PrincipleContact'
          DataSource = dsstsClass
          LookupTable = cboEmployeeLookup
          LookupField = 'EmployeeName'
          DropDownWidth = 300
          ParentFont = False
          TabOrder = 0
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
          OnCloseUp = cboPrincipleContactCloseUp
        end
        object edtPrincipleContactPhone: TwwDBEdit
          Left = 213
          Top = 77
          Width = 228
          Height = 23
          HelpContext = 245028
          DataField = 'PrincipleContactPhone'
          DataSource = dsstsClass
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnChange = edtClassNameChange
        end
        object edtLicenseNumber: TwwDBEdit
          Left = 213
          Top = 125
          Width = 228
          Height = 23
          HelpContext = 245028
          DataField = 'LicenseNumber'
          DataSource = dsstsClass
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          OnChange = edtClassNameChange
        end
        object cbobinLocation: TwwDBLookupCombo
          Left = 213
          Top = 173
          Width = 228
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'binlocation'#9'61'#9'binlocation'#9'F')
          DataField = 'DefaultStSBinID'
          DataSource = dsstsClass
          LookupTable = QryBin
          LookupField = 'binId'
          ParentFont = False
          TabOrder = 3
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnEnter = cbobinLocationEnter
        end
      end
    end
  end
  object DNMPanel4: TDNMPanel [7]
    Left = 0
    Top = 543
    Width = 723
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      723
      50)
    object cmdNew: TDNMSpeedButton
      Left = 318
      Top = 12
      Width = 87
      Height = 27
      Hint = '"Add A Class"'
      HelpContext = 245004
      Anchors = [akBottom]
      Caption = '&New'
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
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = cmdNewClick
    end
    object cmdOk: TDNMSpeedButton
      Left = 149
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 245003
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdOkClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 487
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 245005
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
    object chkActive: TDBCheckBox
      Left = 644
      Top = 17
      Width = 58
      Height = 16
      HelpContext = 245006
      Anchors = [akRight, akBottom]
      Caption = 'Active'
      DataField = 'Active'
      DataSource = frmClassSrc
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      OnClick = chkActiveClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Top = 176
  end
  inherited tmrdelay: TTimer
    Top = 176
  end
  inherited popSpelling: TPopupMenu
    Top = 176
  end
  inherited tmrdelayMsg: TTimer
    Left = 360
    Top = 176
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 176
  end
  inherited ApplicationEvents1: TApplicationEvents
    Top = 176
  end
  inherited MyConnection: TERPConnection
    Database = 'akubra_live'
    Server = 'Localhost'
    Left = 82
    Top = 215
  end
  inherited DataState: TDataState
    Top = 176
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Top = 176
  end
  inherited imgsort: TImageList
    Top = 176
    Bitmap = {
      494C010102003800B00010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 282
    Top = 224
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Top = 176
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 176
  end
  inherited qryMemTrans: TERPQuery
    Left = 317
    Top = 224
  end
  inherited tmrOnshow: TTimer
    Top = 176
  end
  object frmClassSrc: TDataSource
    DataSet = qryClass
    Left = 112
    Top = 250
  end
  object qryClass: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblclass '
      'WHERE ClassID = :varClassID;')
    AfterOpen = qryClassAfterOpen
    BeforeClose = qryClassBeforeClose
    AfterInsert = qryClassAfterInsert
    AfterPost = qryClassAfterPost
    Left = 117
    Top = 218
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'varClassID'
      end>
    object qryClassGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblclass.GlobalRef'
      Size = 255
    end
    object qryClassClassID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClassID'
      Origin = 'tblclass.ClassID'
    end
    object qryClassClassName: TWideStringField
      FieldName = 'ClassName'
      Origin = 'tblclass.ClassName'
      OnChange = qryClassClassNameChange
      Size = 60
    end
    object qryClassClassGroup: TWideStringField
      FieldName = 'ClassGroup'
      Origin = 'tblclass.ClassGroup'
      Size = 255
    end
    object qryClassDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tblclass.Description'
      Size = 50
    end
    object qryClassActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblclass.Active'
      FixedChar = True
      Size = 1
    end
    object qryClassSubClass: TWideStringField
      FieldName = 'SubClass'
      Origin = 'tblclass.SubClass'
      FixedChar = True
      Size = 1
    end
    object qryClassEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblclass.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryClassSubClassOf: TWideStringField
      FieldName = 'SubClassOf'
      Origin = 'tblclass.SubClassOf'
      Size = 60
    end
    object qryClassClassPercent: TFloatField
      FieldName = 'ClassPercent'
      Origin = 'tblclass.ClassPercent'
    end
    object qryClassLevel1: TWideStringField
      FieldName = 'Level1'
      Origin = 'tblclass.Level1'
      Size = 255
    end
    object qryClassLevel2: TWideStringField
      FieldName = 'Level2'
      Origin = 'tblclass.Level2'
      Size = 255
    end
    object qryClassLevel3: TWideStringField
      FieldName = 'Level3'
      Origin = 'tblclass.Level3'
      Size = 255
    end
    object qryClassLevel4: TWideStringField
      FieldName = 'Level4'
      Origin = 'tblclass.Level4'
      Size = 255
    end
    object qryClassAutoCreateSmartOrders: TWideStringField
      FieldName = 'AutoCreateSmartOrders'
      Origin = 'tblclass.AutoCreateSmartOrders'
      FixedChar = True
      Size = 1
    end
    object qryClassAutoCreateRepairs: TWideStringField
      FieldName = 'AutoCreateRepairs'
      Origin = 'tblclass.AutoCreateRepairs'
      FixedChar = True
      Size = 1
    end
    object qryClassmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblclass.msTimeStamp'
    end
    object qryClassUseAddress: TWideStringField
      FieldName = 'UseAddress'
      Origin = 'tblclass.UseAddress'
      FixedChar = True
      Size = 1
    end
    object qryClassStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblclass.Street'
      Size = 255
    end
    object qryClassStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblclass.Street2'
      Size = 255
    end
    object qryClassStreet3: TWideStringField
      FieldName = 'Street3'
      Size = 255
    end
    object qryClassSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblclass.Suburb'
      Size = 255
    end
    object qryClassState: TWideStringField
      FieldName = 'State'
      Origin = 'tblclass.State'
      Size = 255
    end
    object qryClassPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblclass.Postcode'
      Size = 255
    end
    object qryClassCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryClassLocationCode: TWideStringField
      FieldName = 'LocationCode'
      Size = 255
    end
    object qryClassSiteCode: TWideStringField
      FieldName = 'SiteCode'
      OnSetText = qryClassSiteCodeSetText
      FixedChar = True
      Size = 3
    end
    object qryClassTaxname: TWideStringField
      FieldName = 'Taxname'
      Size = 255
    end
    object qryClassTAXID: TIntegerField
      FieldName = 'TAXID'
    end
  end
  object qryClass2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassID, ClassName, ClassGroup,Description, '
      'Active, SubClass, SubClassOf, ClassPercent'
      'FROM tblclass '
      '')
    AfterInsert = qryClassAfterInsert
    Left = 248
    Top = 218
  end
  object memQryClass: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ClassID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'ClassName'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'ClassGroup'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Description'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'Active'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'SubClass'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end
      item
        Name = 'SubClassOf'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'ClassPercent'
        Attributes = [faFixed]
        DataType = ftFloat
      end
      item
        Name = 'EditedFlag'
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
    Left = 517
    Top = 162
  end
  object qryAccLevel3: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassName As AccLevel3'
      'FROM tblClass'
      'Where ClassName <> '#39#39' And ClassGroup =:SubAcc'
      'And ClassID <>  :CurrentClassID'
      'Group by AccLevel3'
      'Order by AccLevel3;')
    Left = 211
    Top = 212
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SubAcc'
      end
      item
        DataType = ftUnknown
        Name = 'CurrentClassID'
      end>
  end
  object qryAccLevel2: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassName As AccLevel2'
      'FROM tblClass'
      'Where ClassName <> '#39#39' And ClassGroup =:SubAcc'
      'And ClassID <>  :CurrentClassID'
      'Group by AccLevel2'
      'Order by AccLevel2;')
    Left = 186
    Top = 212
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SubAcc'
      end
      item
        DataType = ftUnknown
        Name = 'CurrentClassID'
      end>
  end
  object qryAccLevel1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassName As AccLevel1'
      'FROM tblClass'
      'Where ClassName <> '#39#39' And (ClassGroup ='#39#39' Or IsNull(ClassGroup))'
      'And ClassID <>  :CurrentClassID'
      'Group by AccLevel1'
      'Order by AccLevel1;')
    Left = 153
    Top = 213
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CurrentClassID'
      end>
  end
  object DataSource6: TDataSource
    DataSet = qryAccLevel1
    Left = 153
    Top = 244
  end
  object qryProductLevels: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT If(InStr(ClassGroup,'#39'^'#39') -1 >0,Left(ClassGroup,InStr(Clas' +
        'sGroup,'#39'^'#39')-1),ClassGroup) AS AccLevel1,'
      
        'MID(ClassGroup, InStr(ClassGroup,'#39'^'#39')+1 ,If(LOCATE('#39'^'#39',ClassGrou' +
        'p,InStr(ClassGroup,'#39'^'#39')+1) - InStr(ClassGroup,'#39'^'#39') >0,LOCATE('#39'^'#39 +
        ',ClassGroup,InStr(ClassGroup,'#39'^'#39')+1)-1 - InStr(ClassGroup,'#39'^'#39'),I' +
        'F(InStr(ClassGroup,'#39'^'#39')<>0,char_length(ClassGroup) - InStr(Class' +
        'Group,'#39'^'#39'),0)))  AS AccLevel2,'
      
        'if((LOCATE('#39'^'#39',ClassGroup,InStr(ClassGroup,'#39'^'#39')+1)) >0, MID(Clas' +
        'sGroup,LOCATE('#39'^'#39',ClassGroup, InStr(ClassGroup,'#39'^'#39')+1)+1,char_le' +
        'ngth(ClassGroup)- LOCATE('#39'^'#39',ClassGroup,InStr(ClassGroup,'#39'^'#39')+1)' +
        '),  Null)  AS AccLevel3'
      'FROM tblclass'
      'Where ClassID = :KeyID;'
      '')
    Left = 378
    Top = 225
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
  end
  object DataSource4: TDataSource
    DataSet = qryAccLevel3
    Left = 211
    Top = 245
  end
  object DataSource5: TDataSource
    DataSet = qryAccLevel2
    Left = 186
    Top = 244
  end
  object SuburbQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT LocationID, City_sub, State, Postcode, Country,Code'
      'FROM tblLocations'
      'Where RegionID= :xRegionID'
      'ORDER BY City_sub;')
    BeforeOpen = SuburbQryBeforeOpen
    Options.LongStrings = False
    Left = 346
    Top = 221
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object qryCurrencyConversions: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CurrencyID, Country,Currency,Code,BuyRate,SellRate '
      'FROM tblcurrencyconversion'
      'Where Active = '#39'T'#39)
    Left = 317
    Top = 432
    object qryCurrencyConversionsCurrencyID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'CurrencyID'
      Origin = 'tblcurrencyconversion.CurrencyID'
      ReadOnly = True
    end
    object qryCurrencyConversionsCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblcurrencyconversion.Country'
      Size = 255
    end
    object qryCurrencyConversionsCurrency: TWideStringField
      FieldName = 'Currency'
      Origin = 'tblcurrencyconversion.Currency'
      Size = 255
    end
    object qryCurrencyConversionsCode: TWideStringField
      FieldName = 'Code'
      Origin = 'tblcurrencyconversion.Code'
      FixedChar = True
      Size = 3
    end
    object qryCurrencyConversionsBuyRate: TFloatField
      FieldName = 'BuyRate'
      Origin = 'tblcurrencyconversion.BuyRate'
      DisplayFormat = '0.0000##'
      EditFormat = '0.0000##'
    end
    object qryCurrencyConversionsSellRate: TFloatField
      FieldName = 'SellRate'
      Origin = 'tblcurrencyconversion.SellRate'
      DisplayFormat = '0.0000##'
      EditFormat = '0.0000##'
    end
  end
  object ERPQuery1: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT CurrencyID, Country,Currency,Code,BuyRate,SellRate '
      'FROM tblcurrencyconversion'
      'Where Active = '#39'T'#39)
    Left = 317
    Top = 432
    object AutoIncField1: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'CurrencyID'
      Origin = 'tblcurrencyconversion.CurrencyID'
      ReadOnly = True
    end
    object WideStringField1: TWideStringField
      FieldName = 'Country'
      Origin = 'tblcurrencyconversion.Country'
      Size = 255
    end
    object WideStringField2: TWideStringField
      FieldName = 'Currency'
      Origin = 'tblcurrencyconversion.Currency'
      Size = 255
    end
    object WideStringField3: TWideStringField
      FieldName = 'Code'
      Origin = 'tblcurrencyconversion.Code'
      FixedChar = True
      Size = 3
    end
    object FloatField1: TFloatField
      FieldName = 'BuyRate'
      Origin = 'tblcurrencyconversion.BuyRate'
      DisplayFormat = '0.0000##'
      EditFormat = '0.0000##'
    end
    object FloatField2: TFloatField
      FieldName = 'SellRate'
      Origin = 'tblcurrencyconversion.SellRate'
      DisplayFormat = '0.0000##'
      EditFormat = '0.0000##'
    end
  end
  object qrystsClass: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblstsClass'
      'WHERE ClassID = :ClassID;')
    BeforeOpen = qrystsClassBeforeOpen
    AfterInsert = qrystsClassAfterInsert
    Left = 421
    Top = 226
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClassID'
      end>
    object qrystsClassID: TIntegerField
      FieldName = 'ID'
    end
    object qrystsClassGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qrystsClassClassId: TIntegerField
      FieldName = 'ClassId'
    end
    object qrystsClassPrincipleContactID: TIntegerField
      FieldName = 'PrincipleContactID'
    end
    object qrystsClassPrincipleContact: TWideStringField
      FieldName = 'PrincipleContact'
      Size = 255
    end
    object qrystsClassPrincipleContactPhone: TWideStringField
      FieldName = 'PrincipleContactPhone'
      Size = 40
    end
    object qrystsClassLicenseNumber: TWideStringField
      FieldName = 'LicenseNumber'
      Size = 255
    end
    object qrystsClassmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object qrystsClassDefaultStSBinID: TIntegerField
      FieldName = 'DefaultStSBinID'
    end
    object qrystsClassmsUpdatesitecode: TWideStringField
      FieldName = 'msUpdatesitecode'
      Size = 3
    end
  end
  object dsstsClass: TDataSource
    DataSet = qrystsClass
    Left = 416
    Top = 258
  end
  object cboEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblEmployees.EmployeeID, EmployeeName  AS EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 450
    Top = 220
    object cboEmployeeLookupEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object cboEmployeeLookupEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
  end
  object qryTaxCodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT T.Name as Taxname, T.TaxCodeID, T.Description, T.Rate  , ' +
        'LOC.LocationValue as Location'
      'FROM tbltaxcodes T'
      'Left join tbltaxcodelocations LOC on T.TaxCodeID = LOC.TaxCodeID'
      'where T.Active <>'#39'F'#39'  '
      'AND  RegionID= :RegionId'
      'and '
      ''
      '(((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (T.Name LIKE Concat(:SearchValue,"%"))' +
        ')'
      
        'or ((:SearchMode = 2) and (T.Name LIKE Concat("%",:SearchValue,"' +
        '%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    BeforeOpen = qryTaxCodesBeforeOpen
    Options.LongStrings = False
    Left = 513
    Top = 233
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'RegionId'
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
      Visible = False
      Size = 255
    end
    object qryTaxCodesLocation: TWideStringField
      DisplayWidth = 10
      FieldName = 'Location'
      Origin = 'LOC.Location'
      Visible = False
      Size = 255
    end
    object qryTaxCodescRate: TFloatField
      DisplayLabel = 'Rate'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'cRate'
      Visible = False
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
  object qryDepttaxexceptionproducts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblDepttaxexceptionproducts'
      'WHERE DeptID=:xDeptID')
    BeforeOpen = arambyn
    AfterInsert = qryDepttaxexceptionproductsAfterInsert
    BeforePost = qryDepttaxexceptionproductsBeforePost
    Left = 563
    Top = 209
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xDeptID'
      end>
    object qryDepttaxexceptionproductsProductName: TWideStringField
      DisplayWidth = 33
      FieldName = 'ProductName'
      Origin = 'tbldepttaxexceptionproducts.ProductName'
      Size = 100
    end
    object qryDepttaxexceptionproductsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tbldepttaxexceptionproducts.Active'
      FixedChar = True
      Size = 1
    end
    object qryDepttaxexceptionproductsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tbldepttaxexceptionproducts.ID'
      Visible = False
    end
    object qryDepttaxexceptionproductsglobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'globalref'
      Origin = 'tbldepttaxexceptionproducts.globalref'
      Visible = False
      Size = 255
    end
    object qryDepttaxexceptionproductsDeptID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DeptID'
      Origin = 'tbldepttaxexceptionproducts.DeptID'
      Visible = False
    end
    object qryDepttaxexceptionproductsDeptName: TWideStringField
      DisplayWidth = 100
      FieldName = 'DeptName'
      Origin = 'tbldepttaxexceptionproducts.DeptName'
      Visible = False
      Size = 100
    end
    object qryDepttaxexceptionproductsProductId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductId'
      Origin = 'tbldepttaxexceptionproducts.ProductId'
      Visible = False
    end
    object qryDepttaxexceptionproductsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tbldepttaxexceptionproducts.msTimeStamp'
      Visible = False
    end
    object qryDepttaxexceptionproductsmsUpdatesitecode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdatesitecode'
      Origin = 'tbldepttaxexceptionproducts.msUpdatesitecode'
      Visible = False
      Size = 3
    end
  end
  object dsDepttaxexceptionproducts: TDataSource
    DataSet = qryDepttaxexceptionproducts
    Left = 563
    Top = 233
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
  object QryBin: TERPQuery
    Connection = fmStSMain.MyConnection
    SQL.Strings = (
      
        'SELECT binId, CONCAT( binlocation , if(ifnull(binnumber,'#39#39')<> '#39#39 +
        ', CONCAT('#39'-'#39',binnumber) , '#39#39') ) AS binlocation FROM tblproductbi' +
        'n WHERE classId = :ClassId')
    BeforeOpen = QryBinBeforeOpen
    Left = 448
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ClassId'
      end>
    object QryBinbinlocation: TWideStringField
      DisplayWidth = 61
      FieldName = 'binlocation'
      Size = 61
    end
    object QryBinbinId: TIntegerField
      FieldName = 'binId'
      Visible = False
    end
  end
end
