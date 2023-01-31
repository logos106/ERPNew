inherited fmExportpreferences: TfmExportpreferences
  Left = 248
  Top = 209
  HelpContext = 649000
  Caption = 'Export the preference '
  ClientHeight = 564
  ClientWidth = 986
  OldCreateOrder = True
  Position = poMainFormCenter
  OnResize = FormResize
  ExplicitLeft = 248
  ExplicitTop = 209
  ExplicitWidth = 1002
  ExplicitHeight = 603
  DesignSize = (
    986
    564)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 564
    Width = 986
    HelpContext = 649004
    ExplicitTop = 564
    ExplicitWidth = 986
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 986
    Height = 564
    HelpContext = 649005
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 984
      Height = 562
      HelpContext = 649066
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        HelpContext = 649007
        Caption = 'Preferences'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel1: TDNMPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 532
          HelpContext = 649008
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          ExplicitTop = -1
          object Edit1: TEdit
            Left = 0
            Top = 0
            Width = 233
            Height = 23
            HelpContext = 649009
            TabOrder = 0
            Text = 'Edit1'
            OnExit = Edit1Exit
            OnKeyPress = Edit1KeyPress
          end
          object chk1User: TCheckBox
            Left = 248
            Top = 8
            Width = 97
            Height = 17
            HelpContext = 649010
            Caption = 'Only user 1'
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = chk1UserClick
          end
          object DNMSpeedButton1: TDNMSpeedButton
            Left = 347
            Top = 1
            Width = 54
            Height = 23
            HelpContext = 649003
            Caption = 'Delete'
            Default = True
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 2
            OnClick = DNMSpeedButton1Click
          end
          object btngeenratescript: TDNMSpeedButton
            Left = 403
            Top = 1
            Width = 100
            Height = 23
            HelpContext = 649011
            Caption = 'Generate Script'
            Default = True
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 3
            OnClick = btngeenratescriptClick
          end
          object memomain: TMemo
            Left = 504
            Top = 0
            Width = 474
            Height = 529
            HelpContext = 649002
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object PageControl2: TPageControl
            Left = 8
            Top = 40
            Width = 497
            Height = 489
            HelpContext = 649012
            ActivePage = TabPrehs
            TabOrder = 5
            object TabPrehs: TTabSheet
              HelpContext = 649013
              Caption = 'Prefs'
              object grdMain: TwwDBGrid
                Left = 0
                Top = 0
                Width = 489
                Height = 459
                HelpContext = 649001
                Selected.Strings = (
                  'UserID'#9'10'#9'UserID'#9#9
                  'NewPrefname'#9'50'#9'NewPrefname'#9'F'#9)
                IniAttributes.Delimiter = ';;'
                TitleColor = clBtnFace
                FixedCols = 0
                ShowHorzScrollBar = True
                Align = alClient
                DataSource = dsmain
                MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
                Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
                TabOrder = 0
                TitleAlignment = taLeftJustify
                TitleFont.Charset = DEFAULT_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = 'Arial'
                TitleFont.Style = [fsBold]
                TitleLines = 1
                TitleButtons = False
                OnCalcCellColors = grdMainCalcCellColors
                OnKeyPress = grdMainKeyPress
                OnMouseDown = grdMainMouseDown
              end
            end
            object TabTemplates: TTabSheet
              HelpContext = 649014
              Caption = 'Templates'
              ImageIndex = 1
              object grdTemplates: TwwDBGrid
                Left = 0
                Top = 0
                Width = 489
                Height = 459
                HelpContext = 649015
                Selected.Strings = (
                  'TemplName'#9'20'#9'TemplName'
                  'TemplateClass'#9'20'#9'TemplateClass'
                  'SQLString'#9'10'#9'SQLString'
                  'DesignTimeSQLString'#9'10'#9'DesignTimeSQLString'
                  'EmployeeID'#9'10'#9'EmployeeID'
                  'Editable'#9'1'#9'Editable'
                  'DefaultTemplate'#9'1'#9'DefaultTemplate'
                  'TypeID'#9'10'#9'TypeID'
                  'Report'#9'10'#9'Report'
                  'EditedFlag'#9'1'#9'EditedFlag'
                  'msTimeStamp'#9'18'#9'msTimeStamp'
                  'Active'#9'1'#9'Active')
                IniAttributes.Delimiter = ';;'
                TitleColor = clBtnFace
                FixedCols = 0
                ShowHorzScrollBar = True
                Align = alClient
                DataSource = dsTemplates
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
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
              end
            end
          end
          object DNMSpeedButton7: TDNMSpeedButton
            Left = 347
            Top = 30
            Width = 151
            Height = 23
            HelpContext = 649071
            Caption = 'DB Preferece SQL'
            Default = True
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 6
            OnClick = DNMSpeedButton7Click
          end
        end
      end
      object TabSheet2: TTabSheet
        HelpContext = 649016
        Caption = 'DB Preferences'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object DNMPanel2: TDNMPanel
          Left = 0
          Top = 0
          Width = 976
          Height = 532
          HelpContext = 649017
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            976
            532)
          object Label1: TLabel
            Left = 477
            Top = 28
            Width = 35
            Height = 15
            HelpContext = 649018
            Caption = 'PrefID'
          end
          object Label2: TLabel
            Left = 461
            Top = 64
            Width = 50
            Height = 15
            HelpContext = 649019
            Caption = 'PrefType'
          end
          object Label3: TLabel
            Left = 479
            Top = 246
            Width = 33
            Height = 15
            HelpContext = 649020
            Caption = 'Name'
          end
          object Label4: TLabel
            Left = 459
            Top = 137
            Width = 52
            Height = 15
            HelpContext = 649021
            Caption = 'FieldType'
          end
          object Label5: TLabel
            Left = 462
            Top = 173
            Width = 50
            Height = 15
            HelpContext = 649022
            Caption = 'FieldSize'
          end
          object Label6: TLabel
            Left = 440
            Top = 100
            Width = 71
            Height = 15
            HelpContext = 649023
            Caption = 'DefaultValue'
          end
          object Label7: TLabel
            Left = 462
            Top = 209
            Width = 57
            Height = 15
            HelpContext = 649024
            Caption = 'FieldValue'
          end
          object Edit2: TEdit
            Left = 8
            Top = 8
            Width = 233
            Height = 23
            HelpContext = 649025
            TabOrder = 0
            Text = 'Edit1'
            OnExit = Edit2Exit
            OnKeyPress = Edit2KeyPress
          end
          object grdDbPref: TwwDBGrid
            Left = 8
            Top = 33
            Width = 417
            Height = 488
            HelpContext = 649026
            Selected.Strings = (
              'Name'#9'255'#9'Name'#9'F'#9)
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 0
            ShowHorzScrollBar = True
            Anchors = [akLeft, akTop, akRight, akBottom]
            DataSource = dsDBPref
            MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
            TabOrder = 1
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 1
            TitleButtons = False
            OnCalcCellColors = grdDbPrefCalcCellColors
            OnKeyPress = grdDbPrefKeyPress
            OnMouseDown = grdDbPrefMouseDown
          end
          object DNMSpeedButton2: TDNMSpeedButton
            Left = 259
            Top = 9
            Width = 100
            Height = 23
            HelpContext = 649027
            Caption = 'Generate Script'
            Default = True
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 2
            OnClick = DNMSpeedButton2Click
          end
          object memodbPref: TMemo
            Left = 440
            Top = 272
            Width = 529
            Height = 177
            HelpContext = 649028
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object wwDBEdit1: TwwDBEdit
            Left = 525
            Top = 24
            Width = 121
            Height = 23
            HelpContext = 649029
            DataField = 'PrefID'
            DataSource = dsDBPref
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnDblClick = wwDBEdit3DblClick
          end
          object wwDBEdit2: TwwDBEdit
            Left = 525
            Top = 60
            Width = 121
            Height = 23
            HelpContext = 649030
            DataField = 'PrefType'
            DataSource = dsDBPref
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnDblClick = wwDBEdit3DblClick
          end
          object wwDBEdit3: TwwDBEdit
            Left = 525
            Top = 242
            Width = 444
            Height = 23
            HelpContext = 649031
            DataField = 'Name'
            DataSource = dsDBPref
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnDblClick = wwDBEdit3DblClick
          end
          object wwDBEdit4: TwwDBEdit
            Left = 525
            Top = 133
            Width = 121
            Height = 23
            HelpContext = 649032
            DataField = 'FieldType'
            DataSource = dsDBPref
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnDblClick = wwDBEdit3DblClick
          end
          object wwDBEdit5: TwwDBEdit
            Left = 525
            Top = 169
            Width = 121
            Height = 23
            HelpContext = 649033
            DataField = 'FieldSize'
            DataSource = dsDBPref
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnDblClick = wwDBEdit3DblClick
          end
          object wwDBEdit6: TwwDBEdit
            Left = 525
            Top = 96
            Width = 121
            Height = 23
            HelpContext = 649034
            DataField = 'DefaultValue'
            DataSource = dsDBPref
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 9
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnDblClick = wwDBEdit3DblClick
          end
          object details: TwwDBRichEdit
            Left = 656
            Top = 24
            Width = 311
            Height = 204
            HelpContext = 649035
            AutoURLDetect = False
            DataSource = dsDBPref
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            HideSelection = False
            ParentFont = False
            PrintJobName = 'Delphi 6'
            TabOrder = 10
            Visible = False
            OnExit = detailsExit
            EditorCaption = 'Edit Rich Text'
            EditorPosition.Left = 0
            EditorPosition.Top = 0
            EditorPosition.Width = 0
            EditorPosition.Height = 0
            MeasurementUnits = muInches
            PrintMargins.Top = 1.000000000000000000
            PrintMargins.Bottom = 1.000000000000000000
            PrintMargins.Left = 1.000000000000000000
            PrintMargins.Right = 1.000000000000000000
            PrintHeader.VertMargin = 0.500000000000000000
            PrintHeader.Font.Charset = DEFAULT_CHARSET
            PrintHeader.Font.Color = clWindowText
            PrintHeader.Font.Height = -11
            PrintHeader.Font.Name = 'Tahoma'
            PrintHeader.Font.Style = []
            PrintFooter.VertMargin = 0.500000000000000000
            PrintFooter.Font.Charset = DEFAULT_CHARSET
            PrintFooter.Font.Color = clWindowText
            PrintFooter.Font.Height = -11
            PrintFooter.Font.Name = 'Tahoma'
            PrintFooter.Font.Style = []
            RichEditVersion = 2
            Data = {
              730000007B5C727466315C616E73695C616E7369637067313235325C64656666
              305C6465666C616E67313033337B5C666F6E7474626C7B5C66305C666E696C20
              417269616C3B7D7D0D0A5C766965776B696E64345C7563315C706172645C6630
              5C667331382064657461696C735C7061720D0A7D0D0A00}
          end
          object wwDBEdit7: TwwDBEdit
            Left = 525
            Top = 205
            Width = 121
            Height = 23
            HelpContext = 649036
            DataField = 'FieldValue'
            DataSource = dsDBPref
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 11
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            OnDblClick = wwDBEdit3DblClick
          end
          object DNMSpeedButton6: TDNMSpeedButton
            Left = 440
            Top = 489
            Width = 241
            Height = 23
            HelpContext = 649037
            Caption = 'Export Colour Pref to default Values'
            Default = True
            DisableTransparent = False
            HotTrackFont.Charset = ANSI_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -12
            HotTrackFont.Name = 'Arial'
            HotTrackFont.Style = [fsBold]
            TabOrder = 12
            Visible = False
            OnClick = DNMSpeedButton6Click
          end
        end
      end
      object TabSheet3: TTabSheet
        HelpContext = 649038
        Caption = 'Add fields to template'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label8: TLabel
          Left = 104
          Top = 40
          Width = 74
          Height = 15
          HelpContext = 649039
          Caption = 'Fields To Add'
        end
        object Label9: TLabel
          Left = 104
          Top = 80
          Width = 49
          Height = 15
          HelpContext = 649040
          Caption = 'Replace '
        end
        object Label10: TLabel
          Left = 104
          Top = 131
          Width = 44
          Height = 15
          HelpContext = 649041
          Caption = 'Search '
        end
        object edtfields: TEdit
          Left = 240
          Top = 32
          Width = 481
          Height = 23
          HelpContext = 649042
          TabOrder = 0
        end
        object edtREplace: TEdit
          Left = 240
          Top = 72
          Width = 481
          Height = 23
          HelpContext = 649043
          TabOrder = 1
        end
        object opt: TRadioGroup
          Left = 740
          Top = 64
          Width = 185
          Height = 35
          HelpContext = 649044
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'After'
            'Before')
          TabOrder = 2
        end
        object edtSearch: TEdit
          Left = 240
          Top = 128
          Width = 481
          Height = 23
          HelpContext = 649045
          TabOrder = 3
        end
        object wwDBGrid1: TwwDBGrid
          Left = 0
          Top = 166
          Width = 976
          Height = 253
          HelpContext = 649046
          Selected.Strings = (
            'TemplID'#9'10'#9'TemplID'
            'TemplName'#9'30'#9'TemplName'
            'SQLString'#9'92'#9'SQLString')
          MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly, mDisableDialog]
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alBottom
          DataSource = dsTemplate
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
        end
        object DNMSpeedButton4: TDNMSpeedButton
          Left = 840
          Top = 128
          Width = 100
          Height = 23
          HelpContext = 649047
          Caption = 'Make Script'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 5
          OnClick = DNMSpeedButton4Click
        end
        object edtScript: TMemo
          Left = 0
          Top = 419
          Width = 976
          Height = 113
          HelpContext = 649048
          Align = alBottom
          Lines.Strings = (
            'edtScript')
          TabOrder = 6
        end
        object DNMSpeedButton3: TDNMSpeedButton
          Left = 727
          Top = 128
          Width = 100
          Height = 23
          HelpContext = 649049
          Caption = 'Refresh'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 7
          OnClick = DNMSpeedButton3Click
        end
      end
      object TabSheet4: TTabSheet
        HelpContext = 649050
        Caption = 'Charts'
        ImageIndex = 3
        object grdchart: TwwDBGrid
          Left = 0
          Top = 0
          Width = 976
          Height = 302
          HelpContext = 649051
          ControlType.Strings = (
            'Global;CheckBox;T;F'
            'DefaultChart;CheckBox;T;F')
          Selected.Strings = (
            'ChartName'#9'25'#9'ChartName'
            'ReportClassName'#9'25'#9'ReportClassName'
            'Global'#9'1'#9'Global'
            'DefaultChart'#9'1'#9'DefaultChart'
            'X_LabelsField'#9'16'#9'X_LabelsField'
            'X_ChartedField'#9'16'#9'X_ChartedField'
            'Y_ChartedField'#9'16'#9'Y_ChartedField'
            'Z_ChartedField'#9'16'#9'Z_ChartedField')
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alTop
          DataSource = dscustomcharts
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
        end
        object memchart: TMemo
          Left = 0
          Top = 336
          Width = 976
          Height = 196
          HelpContext = 649052
          Align = alBottom
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object DNMSpeedButton5: TDNMSpeedButton
          Left = 423
          Top = 308
          Width = 100
          Height = 23
          HelpContext = 649053
          Caption = 'Generate'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 2
          OnClick = DNMSpeedButton5Click
        end
      end
      object TabSheet5: TTabSheet
        HelpContext = 649054
        Caption = 'Misc'
        ImageIndex = 4
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label11: TLabel
          Left = 176
          Top = 16
          Width = 59
          Height = 15
          HelpContext = 649055
          Caption = 'Trans SQL'
        end
        object edtTransSQL: TEdit
          Left = 241
          Top = 13
          Width = 121
          Height = 23
          HelpContext = 649056
          TabOrder = 0
          Text = '1'
        end
        object memMisc: TMemo
          Left = 560
          Top = 0
          Width = 416
          Height = 532
          HelpContext = 649057
          Align = alRight
          Lines.Strings = (
            'memMisc')
          TabOrder = 1
        end
        object btnTransSQL: TDNMSpeedButton
          Left = 368
          Top = 13
          Width = 41
          Height = 23
          HelpContext = 649058
          Caption = '=>>'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 2
          OnClick = btnTransSQLClick
        end
      end
      object TabSheet6: TTabSheet
        HelpContext = 649059
        Caption = 'Tables'
        ImageIndex = 5
        object lstTables: TListBox
          Left = 16
          Top = 74
          Width = 297
          Height = 256
          HelpContext = 649060
          ItemHeight = 15
          TabOrder = 0
          Visible = False
          OnDblClick = lstTablesDblClick
        end
        object Button2: TButton
          Left = 319
          Top = 74
          Width = 75
          Height = 25
          HelpContext = 649061
          Caption = 'Load Tables'
          TabOrder = 1
          OnClick = Button2Click
        end
        object btnmakeTableSQL: TButton
          Left = 319
          Top = 184
          Width = 75
          Height = 25
          HelpContext = 649062
          Caption = '==>'
          TabOrder = 2
          WordWrap = True
          OnClick = btnmakeTableSQLClick
        end
        object grdTablerecs: TwwDBGrid
          Left = 0
          Top = 336
          Width = 976
          Height = 196
          HelpContext = 649063
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alBottom
          DataSource = dsTable
          TabOrder = 3
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          Visible = False
        end
        object Button3: TButton
          Left = 407
          Top = 74
          Width = 75
          Height = 25
          HelpContext = 649067
          Caption = 'Script'
          TabOrder = 4
          OnClick = Button3Click
        end
        object memotablestructure: TMemo
          Left = 502
          Top = 0
          Width = 474
          Height = 529
          HelpContext = 649068
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object edtTablename: TEdit
          Left = 16
          Top = 45
          Width = 233
          Height = 23
          HelpContext = 649069
          TabOrder = 6
          Text = 'Edit1'
          OnExit = edtTablenameExit
        end
      end
      object TabSheet7: TTabSheet
        HelpContext = 649070
        Caption = 'Misc'
        ImageIndex = 6
        object Button1: TButton
          Left = 901
          Top = 0
          Width = 75
          Height = 25
          HelpContext = 649064
          Caption = 'PQA SQL'
          TabOrder = 0
          OnClick = Button1Click
        end
        object edtProductID: TEdit
          Left = 784
          Top = 0
          Width = 121
          Height = 23
          HelpContext = 649065
          TabOrder = 1
          Text = '0'
        end
      end
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 207
    Top = 120
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 60
    Top = 120
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 280
    Top = 120
  end
  inherited DataState: TDataState
    Left = 24
    Top = 120
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    HelpContext = 649021
    Left = 170
    Top = 120
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102005800700010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 390
    Top = 120
  end
  inherited qryMemTrans: TERPQuery
    Left = 13
    Top = 48
  end
  object MyDump1: TMyDump
    TableNames = 'tblpreferences'
    SQL.Strings = (
      
        'delete from tblpreferences where PrefName = '#39'TStockQtysLocations' +
        'ReportGUI'#39';'
      
        'INSERT INTO tblpreferences(GlobalRef, PackageID, UserID, PrefGro' +
        'up, PrefName, PrefType, PrefValue, PrefDesc, msTimeStamp) VALUES'
      
        '  (NULL, 0, 0, '#39'GuiPrefs'#39', '#39'TStockQtysLocationsReportGUI'#39', NULL,' +
        ' '#39'<?xml version=\"1.0\" encoding=\"UTF-8\" ?><TStockQtysLocation' +
        'sReportGUI><grdMain><Columns><UOMQty><Hidden>False</Hidden><Visi' +
        'ble>False</Visible><Index>18</Index><DisplayWidth>10</DisplayWid' +
        'th><DisplayLabel>UOMQty</DisplayLabel></UOMQty><UOMMultiplier><V' +
        'isible>False</Visible><Index>18</Index><DisplayWidth>10</Display' +
        'Width><DisplayLabel>UOMMultiplier</DisplayLabel><Hidden>True</Hi' +
        'dden></UOMMultiplier><SOQty><Visible>False</Visible><Index>18</I' +
        'ndex><DisplayWidth>10</DisplayWidth><DisplayLabel>SOQty</Display' +
        'Label><Hidden>True</Hidden></SOQty><Qty><Visible>False</Visible>' +
        '<Index>18</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>Qt' +
        'y</DisplayLabel><Hidden>True</Hidden></Qty><PartsId><Visible>Fal' +
        'se</Visible><Index>18</Index><DisplayWidth>10</DisplayWidth><Dis' +
        'playLabel>PartsId</DisplayLabel><Hidden>True</Hidden></PartsId><' +
        'InstockQty><Hidden>False</Hidden><Visible>False</Visible><Index>' +
        '18</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>InstockQt' +
        'y</DisplayLabel></InstockQty><gLevel><Visible>False</Visible><In' +
        'dex>18</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>gLeve' +
        'l</DisplayLabel><Hidden>True</Hidden></gLevel><DepartmentID><Vis' +
        'ible>False</Visible><Index>18</Index><DisplayWidth>10</DisplayWi' +
        'dth><DisplayLabel>DepartmentID</DisplayLabel><Hidden>True</Hidde' +
        'n></DepartmentID><BatchExpiryDate><Visible>False</Visible><Index' +
        '>18</Index><DisplayWidth>18</DisplayWidth><DisplayLabel>BatchExp' +
        'iryDate</DisplayLabel><Hidden>True</Hidden></BatchExpiryDate><Au' +
        'toID><Visible>False</Visible><Index>18</Index><DisplayWidth>10</' +
        'DisplayWidth><DisplayLabel>AutoID</DisplayLabel><Hidden>True</Hi' +
        'dden></AutoID><Value><Visible>True</Visible><Index>15</Index><Di' +
        'splayWidth>10</DisplayWidth><DisplayLabel>Value</DisplayLabel><H' +
        'idden>False</Hidden></Value><Cost><Visible>True</Visible><Index>' +
        '14</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>Cost</Dis' +
        'playLabel><Hidden>False</Hidden></Cost><SOUOMQty><Visible>True</' +
        'Visible><Index>13</Index><DisplayWidth>10</DisplayWidth><Display' +
        'Label>Sales Order</DisplayLabel><Hidden>False</Hidden></SOUOMQty' +
        '><InstockUOMQty><Visible>True</Visible><Index>12</Index><Display' +
        'Width>10</DisplayWidth><DisplayLabel>In-Stock</DisplayLabel><Hid' +
        'den>False</Hidden></InstockUOMQty><Serialnumber><Visible>True</V' +
        'isible><Index>11</Index><DisplayWidth>13</DisplayWidth><DisplayL' +
        'abel>Serial Number</DisplayLabel><Hidden>False</Hidden></Serialn' +
        'umber><Binnumber><Visible>True</Visible><Index>10</Index><Displa' +
        'yWidth>11</DisplayWidth><DisplayLabel>Bin Number</DisplayLabel><' +
        'Hidden>False</Hidden></Binnumber><Binlocation><Visible>True</Vis' +
        'ible><Index>9</Index><DisplayWidth>11</DisplayWidth><DisplayLabe' +
        'l>Bin Location</DisplayLabel><Hidden>False</Hidden></Binlocation' +
        '><ExpiryDate><Visible>True</Visible><Index>8</Index><DisplayWidt' +
        'h>10</DisplayWidth><DisplayLabel>Expiry Date</DisplayLabel><Hidd' +
        'en>False</Hidden></ExpiryDate><Batchnumber><Visible>True</Visibl' +
        'e><Index>7</Index><DisplayWidth>14</DisplayWidth><DisplayLabel>B' +
        'atch Number</DisplayLabel><Hidden>False</Hidden></Batchnumber><U' +
        'OM><Visible>True</Visible><Index>6</Index><DisplayWidth>16</Disp' +
        'layWidth><DisplayLabel>Units of ~Measure</DisplayLabel><Hidden>F' +
        'alse</Hidden></UOM><Classname><Visible>True</Visible><Index>5</I' +
        'ndex><DisplayWidth>14</DisplayWidth><DisplayLabel>Department~Nam' +
        'e</DisplayLabel><Hidden>False</Hidden></Classname><PartsDescript' +
        'ion><Visible>True</Visible><Index>4</Index><DisplayWidth>17</Dis' +
        'playWidth><DisplayLabel>Description</DisplayLabel><Hidden>False<' +
        '/Hidden></PartsDescription><ProductColumn3><Visible>True</Visibl' +
        'e><Index>3</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>D' +
        'ept</DisplayLabel><Hidden>False</Hidden></ProductColumn3><Produc' +
        'tColumn2><Visible>True</Visible><Index>2</Index><DisplayWidth>13' +
        '</DisplayWidth><DisplayLabel>Type</DisplayLabel><Hidden>False</H' +
        'idden></ProductColumn2><ProductColumn1><Visible>True</Visible><I' +
        'ndex>1</Index><DisplayWidth>13</DisplayWidth><DisplayLabel>Manuf' +
        'acture</DisplayLabel><Hidden>False</Hidden></ProductColumn1><Pro' +
        'ductName><Visible>True</Visible><Index>0</Index><DisplayWidth>21' +
        '</DisplayWidth><DisplayLabel>Product</DisplayLabel><Hidden>False' +
        '</Hidden></ProductName></Columns><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TStockQtysLocationsReportGUI>'#39', N' +
        'ULL, '#39'2008-11-05 11:38:26'#39');')
    Connection = MyConnection
    Objects = [doData]
    Options.GenerateHeader = False
    Options.AddDrop = False
    Options.CompleteInsert = True
    Left = 97
    Top = 120
  end
  object qryMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select if(SubString(PrefName,1,1) = '#39'T'#39' , SUBSTRING(Prefname, 2,' +
        'char_length(Prefname)) , PrefName) as NewPrefname, tblpreference' +
        's. *  from tblpreferences order by Prefname, UserID')
    Filter = 'UserID = 1'
    Left = 133
    Top = 120
    object qryMainUserID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UserID'
      Origin = 'tblpreferences.UserID'
    end
    object qryMainNewPrefname: TWideStringField
      DisplayWidth = 50
      FieldName = 'NewPrefname'
      Origin = '.NewPrefname'
      Size = 255
    end
    object qryMainPrefName: TWideStringField
      DisplayWidth = 40
      FieldName = 'PrefName'
      Origin = 'tblpreferences.PrefName'
      Visible = False
      Size = 255
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblpreferences.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainPreferenceID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PreferenceID'
      Origin = 'tblpreferences.PreferenceID'
      Visible = False
    end
    object qryMainPackageID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PackageID'
      Origin = 'tblpreferences.PackageID'
      Visible = False
    end
    object qryMainPrefGroup: TWideStringField
      DisplayWidth = 255
      FieldName = 'PrefGroup'
      Origin = 'tblpreferences.PrefGroup'
      Visible = False
      Size = 255
    end
    object qryMainPrefType: TWideStringField
      DisplayWidth = 1
      FieldName = 'PrefType'
      Origin = 'tblpreferences.PrefType'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainPrefValue: TWideMemoField
      DisplayWidth = 10
      FieldName = 'PrefValue'
      Origin = 'tblpreferences.PrefValue'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryMainPrefDesc: TWideStringField
      DisplayWidth = 128
      FieldName = 'PrefDesc'
      Origin = 'tblpreferences.PrefDesc'
      Visible = False
      Size = 128
    end
    object qryMainmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblpreferences.msTimeStamp'
      Visible = False
    end
    object qryMainIndustryId: TIntegerField
      FieldName = 'IndustryId'
    end
  end
  object dsmain: TDataSource
    DataSet = qryMain
    Left = 243
    Top = 120
  end
  object dsDBPref: TDataSource
    DataSet = QryDBPref
    Left = 317
    Top = 160
  end
  object QryDBPref: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tbldbpreferences'
      'order by name')
    Filter = 'UserID = 1'
    Left = 317
    Top = 120
    object QryDBPrefName: TWideStringField
      DisplayWidth = 255
      FieldName = 'Name'
      Origin = 'tbldbpreferences.Name'
      Size = 255
    end
    object QryDBPrefPrefID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PrefID'
      Origin = 'tbldbpreferences.PrefID'
      Visible = False
    end
    object QryDBPrefPrefType: TWideStringField
      DisplayWidth = 20
      FieldName = 'PrefType'
      Origin = 'tbldbpreferences.PrefType'
      Visible = False
    end
    object QryDBPrefFieldType: TWideStringField
      DisplayWidth = 20
      FieldName = 'FieldType'
      Origin = 'tbldbpreferences.FieldType'
      Visible = False
    end
    object QryDBPrefFieldSize: TIntegerField
      DisplayWidth = 10
      FieldName = 'FieldSize'
      Origin = 'tbldbpreferences.FieldSize'
      Visible = False
    end
    object QryDBPrefFieldValue: TWideMemoField
      DisplayWidth = 10
      FieldName = 'FieldValue'
      Origin = 'tbldbpreferences.FieldValue'
      Visible = False
      BlobType = ftWideMemo
    end
    object QryDBPrefDefaultValue: TWideStringField
      DisplayWidth = 255
      FieldName = 'DefaultValue'
      Origin = 'tbldbpreferences.DefaultValue'
      Visible = False
      Size = 255
    end
    object QryDBPrefGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tbldbpreferences.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryDBPrefmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tbldbpreferences.msTimeStamp'
      Visible = False
    end
  end
  object qryTemplates: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tbltemplates order by msTimeStamp;')
    Filter = 'UserID = 1'
    Left = 427
    Top = 120
    object qryTemplatesTemplName: TWideStringField
      DisplayWidth = 20
      FieldName = 'TemplName'
      Origin = 'tbltemplates.TemplName'
      Size = 30
    end
    object qryTemplatesTemplateClass: TWideStringField
      DisplayWidth = 20
      FieldName = 'TemplateClass'
      Origin = 'tbltemplates.TemplateClass'
      Size = 255
    end
    object qryTemplatesSQLString: TWideMemoField
      DisplayWidth = 10
      FieldName = 'SQLString'
      Origin = 'tbltemplates.SQLString'
      BlobType = ftWideMemo
    end
    object qryTemplatesDesignTimeSQLString: TWideMemoField
      DisplayWidth = 10
      FieldName = 'DesignTimeSQLString'
      Origin = 'tbltemplates.DesignTimeSQLString'
      BlobType = ftWideMemo
    end
    object qryTemplatesEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tbltemplates.EmployeeID'
    end
    object qryTemplatesEditable: TWideStringField
      DisplayWidth = 1
      FieldName = 'Editable'
      Origin = 'tbltemplates.Editable'
      FixedChar = True
      Size = 1
    end
    object qryTemplatesDefaultTemplate: TWideStringField
      DisplayWidth = 1
      FieldName = 'DefaultTemplate'
      Origin = 'tbltemplates.DefaultTemplate'
      FixedChar = True
      Size = 1
    end
    object qryTemplatesTypeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TypeID'
      Origin = 'tbltemplates.TypeID'
    end
    object qryTemplatesReport: TBlobField
      DisplayWidth = 10
      FieldName = 'Report'
      Origin = 'tbltemplates.Report'
    end
    object qryTemplatesEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tbltemplates.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryTemplatesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tbltemplates.msTimeStamp'
    end
    object qryTemplatesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tbltemplates.Active'
      FixedChar = True
      Size = 1
    end
  end
  object dsTemplates: TDataSource
    DataSet = qryTemplates
    Left = 427
    Top = 160
  end
  object QryTemplate: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tbltemplates limit 10')
    Left = 353
    Top = 120
  end
  object dsTemplate: TDataSource
    DataSet = QryTemplate
    Left = 353
    Top = 160
  end
  object qrycustomcharts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblcustomcharts'
      'order by chartname')
    Filter = 'UserID = 1'
    Left = 467
    Top = 120
    object qrycustomchartsChartName: TWideStringField
      DisplayWidth = 25
      FieldName = 'ChartName'
      Origin = 'tblcustomcharts.ChartName'
      Size = 255
    end
    object qrycustomchartsReportClassName: TWideStringField
      DisplayWidth = 25
      FieldName = 'ReportClassName'
      Origin = 'tblcustomcharts.ReportClassName'
      Size = 255
    end
    object qrycustomchartsGlobal: TWideStringField
      DisplayWidth = 1
      FieldName = 'Global'
      Origin = 'tblcustomcharts.Global'
      FixedChar = True
      Size = 1
    end
    object qrycustomchartsDefaultChart: TWideStringField
      DisplayWidth = 1
      FieldName = 'DefaultChart'
      Origin = 'tblcustomcharts.DefaultChart'
      FixedChar = True
      Size = 1
    end
    object qrycustomchartsX_LabelsField: TWideStringField
      DisplayWidth = 16
      FieldName = 'X_LabelsField'
      Origin = 'tblcustomcharts.X_LabelsField'
      Size = 255
    end
    object qrycustomchartsX_ChartedField: TWideStringField
      DisplayWidth = 16
      FieldName = 'X_ChartedField'
      Origin = 'tblcustomcharts.X_ChartedField'
      Size = 255
    end
    object qrycustomchartsY_ChartedField: TWideStringField
      DisplayWidth = 16
      FieldName = 'Y_ChartedField'
      Origin = 'tblcustomcharts.Y_ChartedField'
      Size = 255
    end
    object qrycustomchartsZ_ChartedField: TWideStringField
      DisplayWidth = 16
      FieldName = 'Z_ChartedField'
      Origin = 'tblcustomcharts.Z_ChartedField'
      Size = 255
    end
    object qrycustomchartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblcustomcharts.ID'
      Visible = False
    end
    object qrycustomchartsCustomFilterID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomFilterID'
      Origin = 'tblcustomcharts.CustomFilterID'
      Visible = False
    end
    object qrycustomchartsEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblcustomcharts.EmployeeID'
      Visible = False
    end
    object qrycustomchartsChartBlob: TBlobField
      DisplayWidth = 10
      FieldName = 'ChartBlob'
      Origin = 'tblcustomcharts.ChartBlob'
      Visible = False
    end
  end
  object dscustomcharts: TDataSource
    DataSet = qrycustomcharts
    Left = 467
    Top = 160
  end
  object qrytable: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM'
      '`tblcustomfields` AS `CF`')
    Options.LongStrings = False
    Left = 334
    Top = 296
  end
  object dsTable: TDataSource
    DataSet = qrytable
    Left = 337
    Top = 336
  end
end
