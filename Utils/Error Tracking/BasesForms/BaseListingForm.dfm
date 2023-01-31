inherited BaseListingGUI: TBaseListingGUI
  Left = 145
  Top = 105
  BorderStyle = bsSingle
  Caption = 'BaseListingGUI'
  ClientHeight = 666
  ClientWidth = 994
  KeyPreview = True
  OldCreateOrder = True
  Position = poDefault
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TDNMPanel
    Left = 0
    Top = 62
    Width = 994
    Height = 545
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      994
      545)
    object grdMain: TwwDBGrid
      Left = 13
      Top = 34
      Width = 966
      Height = 510
      IniAttributes.Delimiter = ';;'
      IniAttributes.CheckNewFields = True
      ExportOptions.Options = [esoShowHeader, esoShowFooter, esoShowTitle, esoDblQuoteFields, esoShowAlternating]
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoSearchOwnerForm, ecoDisableDateTimePicker]
      Anchors = [akLeft, akTop, akRight, akBottom]
      Ctl3D = True
      DataSource = dsMain
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect, dgRowResize]
      ParentCtl3D = False
      ParentFont = False
      PopupMenu = mnuFilter
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      OnCalcCellColors = grdMainCalcCellColors
      OnTitleButtonClick = grdMainTitleButtonClick
      OnColEnter = grdMainColEnter
      OnDblClick = grdMainDblClick
      OnKeyDown = grdMainKeyDown
      OnCalcTitleImage = grdMainCalcTitleImage
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedRow, coBlendFixedColumn, coBlendActiveRecord]
    end
    object pnlfilter: TDNMPanel
      Left = 13
      Top = 0
      Width = 966
      Height = 33
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        966
        33)
      object Label2: TLabel
        Left = 4
        Top = 9
        Width = 88
        Height = 16
        AutoSize = False
        Caption = 'Search Colu&mn'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label4: TLabel
        Left = 292
        Top = 9
        Width = 72
        Height = 16
        AutoSize = False
        Caption = '&Search Text'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object cboFilter: TComboBox
        Left = 93
        Top = 5
        Width = 193
        Height = 23
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 15
        ParentFont = False
        TabOrder = 0
      end
      object edtSearch: TEdit
        Left = 363
        Top = 5
        Width = 351
        Height = 23
        Hint = '"Type In What To Filter This Column By"'
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnChange = edtSearchChange
      end
      object DNMPanel1: TDNMPanel
        Left = 735
        Top = 1
        Width = 230
        Height = 31
        Align = alRight
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object rgOptions: TwwRadioGroup
          Left = 0
          Top = 0
          Width = 230
          Height = 31
          TransparentActiveItem = True
          ButtonFrame.Transparent = True
          Indents.ButtonX = 12
          Indents.TextX = 5
          ShowBorder = False
          Transparent = True
          Align = alClient
          Columns = 2
          TabOrder = 0
          OnChange = rgOptionsChange
        end
      end
    end
  end
  object HeaderPanel: TDNMPanel
    Left = 0
    Top = 0
    Width = 994
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    BevelWidth = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      994
      62)
    object lblFrom: TLabel
      Left = 771
      Top = 36
      Width = 29
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&From'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object lblTo: TLabel
      Left = 887
      Top = 36
      Width = 14
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object Label1: TLabel
      Left = 14
      Top = 9
      Width = 114
      Height = 15
      Caption = 'Select Custom Filter'
      Transparent = True
    end
    object cboDateRange: TComboBox
      Left = 801
      Top = 4
      Width = 183
      Height = 23
      AutoDropDown = True
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ItemIndex = 11
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      Text = 'This Month'
      Visible = False
      OnChange = cboDateRangeChange
      OnCloseUp = cboDateRangeChange
      Items.Strings = (
        'Today'
        'Yesterday'
        'Last Week'
        'Last Month'
        'Last Quarter'
        'Last 12 Months'
        'Previous Week'
        'Previous Month'
        'Previous Quarter'
        'Previous Finacial Year'
        'This Week'
        'This Month'
        'This Quarter'
        'This Financial Year'
        'Custom')
    end
    object dtFrom: TwwDBDateTimePicker
      Left = 801
      Top = 32
      Width = 82
      Height = 23
      TabStop = False
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Date = 37432
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
      UnboundDataType = wwDTEdtDate
      Visible = False
      OnCloseUp = dtFromChange
      OnChange = dtFromChange
    end
    object dtTo: TwwDBDateTimePicker
      Left = 902
      Top = 32
      Width = 82
      Height = 23
      TabStop = False
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Date = 37432
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
      UnboundDataType = wwDTEdtDate
      Visible = False
      OnCloseUp = dtToChange
      OnChange = dtToChange
    end
    object cboCustomFilter: TwwDBLookupCombo
      Left = 13
      Top = 24
      Width = 203
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      LookupTable = qryCustomFilter
      LookupField = 'FilterName'
      Style = csDropDownList
      DropDownWidth = 400
      ParentFont = False
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
      OnChange = cboCustomFilterChange
    end
    object pnlHeader: TPanel
      Left = 224
      Top = 5
      Width = 533
      Height = 49
      HelpContext = 2697
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 4
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 531
        Height = 47
        Align = alClient
        BevelOuter = bvNone
        Caption = 'TitleShader'
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.2.1.1'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 531
          Height = 47
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial Rounded MT Bold'
          Font.Style = []
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
  end
  object FooterPanel: TDNMPanel
    Left = 0
    Top = 607
    Width = 994
    Height = 59
    Align = alBottom
    BevelOuter = bvNone
    BevelWidth = 0
    Caption = '`'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      994
      59)
    object Label3: TLabel
      Left = 18
      Top = 24
      Width = 86
      Height = 15
      Anchors = [akLeft, akBottom]
      Caption = 'Total Records : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblTotal: TLabel
      Left = 103
      Top = 24
      Width = 41
      Height = 18
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object btnCustomize: TDNMSpeedButton
      Left = 195
      Top = 13
      Width = 93
      Height = 29
      Hint = '"Customize the List"'
      Anchors = [akBottom]
      Caption = 'Customi&se'
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
      TabOrder = 4
      TabStop = False
      OnClick = btnCustomizeClick
    end
    object cmdClose: TDNMSpeedButton
      Left = 743
      Top = 13
      Width = 93
      Height = 29
      Hint = '"Close The List"'
      Anchors = [akBottom]
      Caption = '&Close'
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
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = cmdCloseClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 468
      Top = 13
      Width = 93
      Height = 29
      Hint = '"Add A New Entry"'
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
    end
    object cmdPrint: TDNMSpeedButton
      Left = 605
      Top = 13
      Width = 93
      Height = 29
      Hint = '"Print The List"'
      Anchors = [akBottom]
      Caption = 'Prin&t'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      OnClick = cmdPrintClick
      OnMouseMove = cmdPrintMouseMove
    end
    object cmdExport: TDNMSpeedButton
      Left = 331
      Top = 13
      Width = 93
      Height = 29
      Hint = '"Export The List To An Excel Spreadsheet"'
      Anchors = [akBottom]
      Caption = 'E&xport'
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
      NumGlyphs = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = False
      OnClick = cmdExportClick
    end
  end
  object dsMain: TDataSource
    DataSet = qryListData
    Left = 75
    Top = 165
  end
  object dlgSave: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 
      'Tabbed Delimited Text  (*.txt)|*.txt|Comma Delimited Text (*.csv' +
      ')|*.csv|Excel SYLK (.slk)|*.slk|HTML (*.html)|*.html'
    Left = 110
    Top = 133
  end
  object mnuFilter: TPopupMenu
    Images = BaseDataModule.imgPopup
    Left = 195
    Top = 168
    object Requery: TMenuItem
      Action = actRequery
    end
    object Lin2: TMenuItem
      Caption = '-'
    end
    object AddFilter: TMenuItem
      Action = actAddFilter
      AutoCheck = True
    end
    object ExcludeinFilter: TMenuItem
      Action = actExcludeinFilter
    end
    object AddPartialtoFilter: TMenuItem
      Action = actAddPartialtoFilter
    end
    object ExcludePartialFilter: TMenuItem
      Action = actExcludePartialFilter
    end
    object mnuExecute: TMenuItem
      Action = actClearFilter
      AutoCheck = True
    end
    object Lin3: TMenuItem
      Caption = '-'
    end
    object AddCustomFilter1: TMenuItem
      Caption = 'Add Custom Filter'
      ImageIndex = 4
      OnClick = AddCustomFilter1Click
    end
  end
  object actlstFilters: TActionList
    Left = 197
    Top = 135
    object actAddFilter: TAction
      AutoCheck = True
      Caption = 'Add to Filter'
      ImageIndex = 0
      OnExecute = actAddFilterExecute
    end
    object actExcludePartialFilter: TAction
      Caption = 'Exclude Partial Filter'
      ImageIndex = 5
      OnExecute = actExcludePartialFilterExecute
    end
    object actAddPartialtoFilter: TAction
      Caption = 'Add Partial Filter'
      ImageIndex = 0
      OnExecute = actAddPartialtoFilterExecute
    end
    object actExcludeinFilter: TAction
      Caption = 'Exclude in Filter'
      ImageIndex = 5
      OnExecute = actExcludeinFilterExecute
    end
    object actClearFilter: TAction
      AutoCheck = True
      Caption = 'Clear Filter'
      ImageIndex = 1
      OnExecute = actClearFilterExecute
    end
    object actRequery: TAction
      Caption = 'Requery'
      ImageIndex = 6
      OnExecute = actRequeryExecute
    end
  end
  object qryListData: TMyQuery
    Connection = BaseDataModule.NonTransDBConnection
    FilterOptions = [foCaseInsensitive]
    Options.CompressBlobMode = cbClientServer
    Options.FlatBuffers = True
    Left = 74
    Top = 132
  end
  object qryCustomFilter: TMyQuery
    Connection = BaseDataModule.NonTransDBConnection
    SQL.Strings = (
      'select'
      '0 as customfilterid,'
      'concat('#39'none'#39',space(200)) as filtername,'
      'space(9000) as filter'
      ''
      'union'
      ''
      'select'
      'customfilterid,'
      'filtername,'
      'filter'
      'from customfilters'
      'where userid = :xuserid'
      'and classname = :xclassname;')
    Options.CompressBlobMode = cbClientServer
    Options.FlatBuffers = True
    Left = 150
    Top = 131
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xUserID'
      end
      item
        DataType = ftUnknown
        Name = 'xClassName'
      end>
  end
  object CustomInputBox1: TCustomInputBox
    Caption = 'Enter Something'
    PasswordCharacter = #0
    EditBoxFont.Charset = DEFAULT_CHARSET
    EditBoxFont.Color = clWindowText
    EditBoxFont.Height = -11
    EditBoxFont.Name = 'MS Sans Serif'
    EditBoxFont.Style = []
    Message = 'Enter the Description of task here..'
    MessageFont.Charset = DEFAULT_CHARSET
    MessageFont.Color = clWindowText
    MessageFont.Height = -11
    MessageFont.Name = 'MS Sans Serif'
    MessageFont.Style = []
    Buttons = [sbOK, sbCancel]
    Width = 350
    Height = 150
    Color = clBtnFace
    Left = 233
    Top = 133
  end
end
