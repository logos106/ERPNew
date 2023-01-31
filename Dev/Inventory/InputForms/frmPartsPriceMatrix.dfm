inherited fmPartsPriceMatrix: TfmPartsPriceMatrix
  Left = 160
  Top = 95
  HelpContext = 807001
  Caption = ''
  ClientHeight = 434
  ClientWidth = 908
  ExplicitLeft = 160
  ExplicitTop = 95
  ExplicitWidth = 924
  ExplicitHeight = 473
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 434
    Width = 908
    ExplicitTop = 434
    ExplicitWidth = 908
    HelpContext = 807041
  end
  object pnlPriceMatrix: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 908
    Height = 434
    HelpContext = 807002
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 906
      Height = 432
      HelpContext = 807003
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        HelpContext = 807004
        Caption = 'TabSheet1'
        object pnlmatrix: TDNMPanel
          Left = 0
          Top = 0
          Width = 898
          Height = 402
          HelpContext = 807005
          Align = alClient
          BevelOuter = bvNone
          BorderStyle = bsSingle
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
            894
            398)
          object Bevel19: TBevel
            Left = 0
            Top = 0
            Width = 894
            Height = 398
            HelpContext = 807006
            Align = alClient
            Shape = bsFrame
            ExplicitLeft = 3
            ExplicitTop = 2
            ExplicitWidth = 883
            ExplicitHeight = 390
          end
          object Label94: TLabel
            Left = 14
            Top = 23
            Width = 92
            Height = 15
            HelpContext = 807007
            Caption = 'Attribute Names'
            Transparent = True
          end
          object Label100: TLabel
            Left = 292
            Top = 23
            Width = 90
            Height = 15
            HelpContext = 807008
            Caption = 'Attribute Values'
            Transparent = True
          end
          object Label101: TLabel
            Left = 573
            Top = 42
            Width = 63
            Height = 15
            HelpContext = 807009
            Caption = 'X Attribute '
            Transparent = True
          end
          object Label102: TLabel
            Left = 573
            Top = 104
            Width = 62
            Height = 15
            HelpContext = 807010
            Caption = 'Y Attribute '
            Transparent = True
          end
          object Label103: TLabel
            Left = 573
            Top = 164
            Width = 96
            Height = 15
            HelpContext = 807011
            Caption = 'Quantity Formula'
            Transparent = True
            Visible = False
          end
          object Label1: TLabel
            Left = 573
            Top = 337
            Width = 77
            Height = 15
            HelpContext = 807012
            Caption = 'Quantity UOM'
            Transparent = True
            Visible = False
          end
          object wwDBGrid3: TwwDBGrid
            Left = 14
            Top = 42
            Width = 260
            Height = 328
            HelpContext = 807013
            ControlType.Strings = (
              'isOnYAxis;CheckBox;T;F'
              'IsonXaxis;CheckBox;T;F'
              'EntryOption;CustomEdit;cboentryOption;F')
            Selected.Strings = (
              'Name'#9'20'#9'Name'#9'F'
              'EntryOption'#9'1'#9'EntryOption'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Anchors = [akLeft, akTop, akBottom]
            DataSource = dspartspricemethodentries
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = [dgAllowInsert]
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTabExitsOnLastCol]
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
            OnExit = wwDBGrid3Exit
          end
          object wwDBGrid4: TwwDBGrid
            Left = 292
            Top = 42
            Width = 260
            Height = 328
            HelpContext = 807014
            ControlType.Strings = (
              'SalesDefault;CheckBox;T;F'
              'PurchaseDefault;CheckBox;T;F')
            Selected.Strings = (
              'Value'#9'15'#9'Value'#9'F'
              'SalesDefault'#9'1'#9'Sales~Default?'#9'F'
              'PurchaseDefault'#9'1'#9'Purchase~Default?'#9'F')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
            Anchors = [akLeft, akTop, akBottom]
            DataSource = dspartspricemethodvalues
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = [dgAllowInsert]
            ParentFont = False
            TabOrder = 1
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 2
            TitleButtons = False
            UseTFields = False
            OnExit = wwDBGrid4Exit
          end
          object cboxAxis: TwwDBLookupCombo
            Left = 573
            Top = 59
            Width = 173
            Height = 23
            HelpContext = 807015
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Name'#9'20'#9'Name'#9'F')
            DataField = 'XAxis'
            DataSource = dspartspricemethod
            LookupTable = qrycboxpartspricemethodentries
            LookupField = 'Name'
            ParentFont = False
            TabOrder = 2
            AutoDropDown = False
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnDropDown = cboxAxisDropDown
            OnCloseUp = cboxAxisCloseUp
          end
          object cboyAxis: TwwDBLookupCombo
            Left = 573
            Top = 120
            Width = 173
            Height = 23
            HelpContext = 807016
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'Name'#9'20'#9'Name'#9'F')
            DataField = 'Yaxis'
            DataSource = dspartspricemethod
            LookupTable = qrycboypartspricemethodentries
            LookupField = 'Name'
            ParentFont = False
            TabOrder = 3
            AutoDropDown = False
            ShowButton = True
            PreciseEditRegion = False
            AllowClearKey = False
            OnDropDown = cboyAxisDropDown
            OnCloseUp = cboyAxisCloseUp
          end
          object btnNext: TDNMSpeedButton
            Left = 756
            Top = 355
            Width = 119
            Height = 27
            HelpContext = 807017
            Anchors = [akRight, akBottom]
            Caption = 'Product Prices'
            Color = clWhite
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = []
            Layout = blGlyphRight
            ModalResult = 1
            ParentColor = False
            ParentFont = False
            TabOrder = 4
            OnClick = btnNextClick
          end
          object cboentryOption: TwwDBComboBox
            Left = 56
            Top = 216
            Width = 121
            Height = 23
            HelpContext = 807018
            ShowButton = True
            Style = csDropDown
            MapList = True
            AllowClearKey = False
            DropDownCount = 8
            ItemHeight = 0
            Items.Strings = (
              'Exact'#9'E'
              'Prior'#9'P'
              'Next'#9'N')
            Sorted = False
            TabOrder = 5
            UnboundDataType = wwDefault
          end
          object memFormula: TDBMemo
            Left = 573
            Top = 181
            Width = 298
            Height = 147
            HelpContext = 807019
            DataField = 'Qtyformula'
            DataSource = dspartspricemethod
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            PopupMenu = pumFormula
            TabOrder = 6
            Visible = False
            OnMouseDown = memFormulaMouseDown
          end
          object cboUnitOfMeasure: TwwDBLookupCombo
            Left = 574
            Top = 358
            Width = 173
            Height = 26
            HelpContext = 807020
            Anchors = [akLeft, akBottom]
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            DropDownAlignment = taLeftJustify
            Selected.Strings = (
              'UnitName'#9'15'#9'UnitName'#9'F')
            DataField = 'UOM'
            DataSource = dspartspricemethod
            LookupTable = qryUnitOfMeasure
            LookupField = 'UnitName'
            ParentFont = False
            TabOrder = 7
            Visible = False
            AutoDropDown = True
            ShowButton = True
            UseTFields = False
            PreciseEditRegion = False
            AllowClearKey = False
          end
          object btnHowto: TDNMSpeedButton
            AlignWithMargins = True
            Left = 860
            Top = 6
            Width = 28
            Height = 27
            HelpContext = 807042
            Anchors = [akTop, akRight]
            Caption = '?'
            DisableTransparent = False
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = []
            TabOrder = 8
            OnClick = ShowPriceMatrixHelp
          end
        end
      end
      object TabSheet2: TTabSheet
        HelpContext = 807021
        Caption = 'TabSheet2'
        ImageIndex = 1
        object pnlMain: TDNMPanel
          Left = 0
          Top = 0
          Width = 898
          Height = 402
          HelpContext = 807022
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object DNMPanel1: TDNMPanel
            Left = 199
            Top = 1
            Width = 698
            Height = 400
            HelpContext = 807023
            Align = alClient
            BevelOuter = bvNone
            BorderStyle = bsSingle
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
              694
              396)
            object Bevel18: TBevel
              Left = 23
              Top = 28
              Width = 582
              Height = 272
              HelpContext = 807024
              Anchors = [akLeft, akTop, akRight, akBottom]
              Shape = bsFrame
              ExplicitWidth = 642
              ExplicitHeight = 332
            end
            object lblXAttribute: TGradientLabel
              Left = -1
              Top = 22
              Width = 18
              Height = 276
              HelpContext = 807025
              Alignment = taCenter
              Anchors = [akLeft, akTop, akBottom]
              AutoSize = False
              Caption = 'lblXAttribute'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlCenter
              ColorTo = clWhite
              EllipsType = etNone
              GradientType = gtFullHorizontal
              GradientDirection = gdLeftToRight
              Indent = 0
              LineWidth = 2
              Orientation = goVertical
              TransparentText = False
              VAlignment = vaTop
              Version = '1.1.1.0'
              ExplicitHeight = 336
            end
            object lblYAttribute: TGradientLabel
              Left = 17
              Top = 5
              Width = 587
              Height = 17
              HelpContext = 807026
              Alignment = taCenter
              Anchors = [akLeft, akTop, akRight]
              AutoSize = False
              Caption = 'lblYAttribute'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              ColorTo = clWhite
              EllipsType = etNone
              GradientType = gtFullVertical
              GradientDirection = gdLeftToRight
              Indent = 0
              LineWidth = 2
              Orientation = goHorizontal
              TransparentText = False
              VAlignment = vaTop
              Version = '1.1.1.0'
              ExplicitWidth = 675
            end
            object Label2: TLabel
              Left = 0
              Top = 366
              Width = 694
              Height = 30
              HelpContext = 807027
              Align = alBottom
              Alignment = taCenter
              Caption = 
                'If Using Price Matrix, This Becomes Your Main Price Window For D' +
                'iscounting etc. ie. Discounts Will be Based on These Prices not ' +
                'the Prices on the Main Window.'
              WordWrap = True
              ExplicitWidth = 670
            end
            object grdMatrix: TwwDBGrid
              Left = 24
              Top = 29
              Width = 580
              Height = 270
              HelpContext = 807028
              Selected.Strings = (
                'xRef'#9'10'#9'xRef')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              FixedCols = 0
              ShowHorzScrollBar = True
              Anchors = [akLeft, akTop, akRight, akBottom]
              DataSource = dsMatrix
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
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
              OnCalcCellColors = grdMatrixCalcCellColors
              OnColEnter = grdMatrixColEnter
              OnEnter = grdMatrixEnter
              OnExit = grdMatrixExit
              OnKeyUp = grdMatrixKeyUp
              FooterColor = clWhite
            end
            object DNMPanel2: TDNMPanel
              Left = 485
              Top = 319
              Width = 196
              Height = 37
              HelpContext = 807030
              Anchors = [akRight, akBottom]
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              object DNMSpeedButton1: TDNMSpeedButton
                AlignWithMargins = True
                Left = 4
                Top = 4
                Width = 188
                Height = 29
                HelpContext = 807031
                Align = alClient
                Caption = 'Save and View Attributes'
                Color = clWhite
                DisableTransparent = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                HotTrackFont.Charset = DEFAULT_CHARSET
                HotTrackFont.Color = clWindowText
                HotTrackFont.Height = -12
                HotTrackFont.Name = 'Arial'
                HotTrackFont.Style = []
                Layout = blGlyphRight
                ModalResult = 1
                ParentColor = False
                ParentFont = False
                TabOrder = 0
                OnClick = DNMSpeedButton1Click
              end
            end
            object DNMSpeedButton2: TDNMSpeedButton
              AlignWithMargins = True
              Left = 662
              Top = 6
              Width = 28
              Height = 27
              HelpContext = 807043
              Anchors = [akTop, akRight]
              Caption = '?'
              DisableTransparent = False
              HotTrackFont.Charset = DEFAULT_CHARSET
              HotTrackFont.Color = clWindowText
              HotTrackFont.Height = -12
              HotTrackFont.Name = 'Arial'
              HotTrackFont.Style = []
              TabOrder = 2
              OnClick = ShowPriceMatrixHelp
            end
          end
          object pnlOptions: TDNMPanel
            Left = 1
            Top = 1
            Width = 198
            Height = 400
            HelpContext = 807029
            Align = alLeft
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object scMain: TAdvScrollBox
              Left = 1
              Top = 1
              Width = 196
              Height = 398
              HelpContext = 807032
              HorzScrollBar.Increment = 49
              HorzScrollBar.Style = ssFlat
              HorzScrollBar.Visible = False
              VertScrollBar.Increment = 37
              VertScrollBar.Style = ssFlat
              Align = alClient
              BevelInner = bvNone
              BevelKind = bkSoft
              BorderStyle = bsNone
              DoubleBuffered = True
              Ctl3D = True
              ParentCtl3D = False
              ParentDoubleBuffered = False
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  object qrypartspricemethod: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblpartspricemethod where productId = :ProductID')
    AfterPost = qrypartspricemethodAfterPost
    Left = 32
    Top = 161
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
    object qrypartspricemethodGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qrypartspricemethodID: TIntegerField
      FieldName = 'ID'
    end
    object qrypartspricemethodProductId: TIntegerField
      FieldName = 'ProductId'
    end
    object qrypartspricemethodXAxisID: TIntegerField
      FieldName = 'XAxisID'
    end
    object qrypartspricemethodYAxisID: TIntegerField
      FieldName = 'YAxisID'
    end
    object qrypartspricemethodQtyformula: TWideStringField
      FieldName = 'Qtyformula'
      Size = 255
    end
    object qrypartspricemethodmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object qrypartspricemethodXAxis: TWideStringField
      FieldName = 'XAxis'
      Size = 100
    end
    object qrypartspricemethodYAxis: TWideStringField
      FieldName = 'YAxis'
      Size = 100
    end
    object qrypartspricemethodUOMID: TIntegerField
      FieldName = 'UOMID'
    end
    object qrypartspricemethodUOM: TWideStringField
      FieldName = 'UOM'
      Size = 100
    end
  end
  object dspartspricemethod: TDataSource
    DataSet = qrypartspricemethod
    Left = 40
    Top = 127
  end
  object qrypartspricemethodentries: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblpartspricemethodentries')
    AfterPost = qrypartspricemethodentriesAfterPost
    Left = 72
    Top = 161
    object qrypartspricemethodentriesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qrypartspricemethodentriesID: TIntegerField
      FieldName = 'ID'
    end
    object qrypartspricemethodentriesPriceMethodID: TIntegerField
      FieldName = 'PriceMethodID'
    end
    object qrypartspricemethodentriesName: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
    object qrypartspricemethodentriesEntryOption: TWideStringField
      FieldName = 'EntryOption'
      FixedChar = True
      Size = 1
    end
    object qrypartspricemethodentriesmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
  end
  object dspartspricemethodentries: TDataSource
    DataSet = qrypartspricemethodentries
    Left = 72
    Top = 119
  end
  object qrypartspricemethodvalues: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblpartspricemethodvalues')
    Left = 120
    Top = 161
    object qrypartspricemethodvaluesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qrypartspricemethodvaluesID: TIntegerField
      FieldName = 'ID'
    end
    object qrypartspricemethodvaluesPriceMethodID: TIntegerField
      FieldName = 'PriceMethodID'
    end
    object qrypartspricemethodvaluesPriceEntryID: TIntegerField
      FieldName = 'PriceEntryID'
    end
    object qrypartspricemethodvaluesmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object qrypartspricemethodvaluesSalesDefault: TWideStringField
      FieldName = 'SalesDefault'
      FixedChar = True
      Size = 1
    end
    object qrypartspricemethodvaluesValue: TFloatField
      FieldName = 'Value'
    end
    object qrypartspricemethodvaluesPurchaseDefault: TWideStringField
      FieldName = 'PurchaseDefault'
      FixedChar = True
      Size = 1
    end
  end
  object dspartspricemethodvalues: TDataSource
    DataSet = qrypartspricemethodvalues
    Left = 120
    Top = 111
  end
  object qrycboxpartspricemethodentries: TERPQuery
    SQL.Strings = (
      'Select * from tblpartspricemethodentries '
      'where PriceMethodId =  :PriceMethodId'
      'and ID<> :yAxisID')
    Left = 200
    Top = 161
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PriceMethodId'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'yAxisID'
        Value = 0
      end>
    object qrycboxpartspricemethodentriesName: TWideStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 100
    end
    object qrycboxpartspricemethodentriesID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object qrycboxpartspricemethodentriesPriceMethodID: TIntegerField
      FieldName = 'PriceMethodID'
      Visible = False
    end
  end
  object qrycboypartspricemethodentries: TERPQuery
    SQL.Strings = (
      'Select * from tblpartspricemethodentries '
      'where PriceMethodId =  :PriceMethodId'
      'and ID<> :xAxisID')
    Left = 176
    Top = 209
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PriceMethodId'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'xAxisID'
        Value = 0
      end>
    object qrycboypartspricemethodentriesName: TWideStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Size = 100
    end
    object qrycboypartspricemethodentriesID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object qrycboypartspricemethodentriesPriceMethodID: TIntegerField
      FieldName = 'PriceMethodID'
      Visible = False
    end
  end
  object QryMatrix: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tmp_PriceMatrix_Admin_324707B0')
    Left = 242
    Top = 161
  end
  object dsMatrix: TDataSource
    DataSet = QryMatrix
    Left = 240
    Top = 127
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
    LoginPrompt = False
    Left = 104
    Top = 7
  end
  object pumFormula: TAdvPopupMenu
    OnPopup = pumFormulaPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 816
    Top = 152
    object mnuColumns: TMenuItem
      Caption = 'Columns'
      HelpContext = 807033
    end
    object N5: TMenuItem
      Caption = '-'
      HelpContext = 807034
    end
    object N1: TMenuItem
      Caption = 'add'
      HelpContext = 807035
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = 'subtract'
      HelpContext = 807036
      OnClick = N1Click
    end
    object multiply1: TMenuItem
      Caption = 'multiply'
      HelpContext = 807037
      OnClick = N1Click
    end
    object divide1: TMenuItem
      Caption = 'divide'
      HelpContext = 807038
      OnClick = N1Click
    end
    object N3: TMenuItem
      Caption = '('
      HelpContext = 807039
      OnClick = N1Click
    end
    object N4: TMenuItem
      Caption = ')'
      HelpContext = 807040
      OnClick = N1Click
    end
  end
  object qryUnitOfMeasure: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.UnitDescription'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :xPartID and U.Mu' +
        'ltiplier =1 '
      'union all '
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.UnitDescription'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :xPartID  )  and U.Multiplier =1 '
      'Order By UnitID desc ,UnitName;')
    Left = 600
    Top = 325
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end>
    object qryUnitOfMeasureUnitID: TIntegerField
      FieldName = 'UnitID'
    end
    object qryUnitOfMeasureUnitName: TWideStringField
      FieldName = 'UnitName'
      Size = 15
    end
    object qryUnitOfMeasureUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Size = 35
    end
  end
end
