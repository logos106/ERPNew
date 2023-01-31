inherited frmRunSequencerGUI: TfrmRunSequencerGUI
  Left = 166
  Top = 134
  Caption = 'Run'
  ClientHeight = 559
  ClientWidth = 990
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 990
    Height = 559
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    DesignSize = (
      990
      559)
    object Bevel1: TBevel
      Left = 1
      Top = 95
      Width = 988
      Height = 417
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object Label10: TLabel
      Left = 841
      Top = 526
      Width = 139
      Height = 15
      Anchors = [akRight, akBottom]
      Caption = 'Show Contact as Default'
      Transparent = True
    end
    object cmdOK: TDNMSpeedButton
      Left = 186
      Top = 520
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = '&Save'
      Default = True
      DisableTransparent = False
      Enabled = False
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Kind = bkOK
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = cmdOKClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 704
      Top = 520
      Width = 99
      Height = 27
      Anchors = [akBottom]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 7
      OnClick = cmdCancelClick
    end
    object grdRunlines: TwwDBGrid
      Left = 6
      Top = 102
      Width = 977
      Height = 403
      ControlType.Strings = (
        'Exclude;CustomEdit;chkExclude;T'
        'ExcludeFrom;CustomEdit;dtExcludeFrom;T'
        'ExcludeTo;CustomEdit;dtExcludeTo;F'
        'PayMethodName;CustomEdit;cboPayMethod;F'
        'ProductName;CustomEdit;cboParts;F'
        'FreqType;CustomEdit;cboFreqType;F'
        'StartDate;CustomEdit;dtStartDate;T'
        'Track;CheckBox;T;F'
        'Company;CustomEdit;cboCustomer;F'
        'NextRunDate;CustomEdit;dtNextRun;T')
      Selected.Strings = (
        'Company'#9'20'#9'Company'#9'F'#9
        'ClientName'#9'22'#9'Contact'#9'T'#9
        'Address'#9'28'#9'Address'#9#9
        'Sequence'#9'5'#9'Seq #'#9'F'#9
        'Qty'#9'5'#9'Qty'#9#9
        'ProductName'#9'18'#9'Product Name'#9#9
        'Track'#9'1'#9'Track'#9'F'#9
        'OrderValue'#9'10'#9'Price (Inc)'#9'T'#9
        'PayMethodName'#9'10'#9'Pay Code'#9#9
        'StartDate'#9'11'#9'Start Date'#9'F'#9
        'FreqInterval'#9'5'#9'Interval'#9'F'#9'Frequency'
        'FreqType'#9'12'#9'Type'#9'F'#9'Frequency'
        'Exclude'#9'1'#9'Exclude'#9#9
        'ExcludeFrom'#9'10'#9'From'#9#9
        'ExcludeTo'#9'10'#9'To'#9#9
        'NextRunDate'#9'10'#9'Next Run'#9'F'#9
        'DateAfterNext'#9'10'#9'Expected After'#9'T'#9
        'TaxCode'#9'8'#9'Tax Code'#9'T'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnRowChanged = grdRunlinesRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsMemLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgWordWrap, dgShowFooter]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      OnCalcCellColors = grdRunlinesCalcCellColors
      OnCalcTitleAttributes = grdRunlinesCalcTitleAttributes
      OnTitleButtonClick = grdRunlinesTitleButtonClick
      OnEnter = grdRunlinesEnter
      FooterColor = clWhite
      FooterCellColor = clWhite
      object btnDelete: TwwIButton
        Left = -1
        Top = 0
        Width = 24
        Height = 33
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = btnDeleteClick
      end
    end
    object cboCustomer: TwwDBLookupCombo
      Left = 38
      Top = 200
      Width = 193
      Height = 23
      ControlType.Strings = (
        'Address;RichEdit;;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'30'#9'Company'#9'F'
        'Customer'#9'30'#9'Contact'#9'F'
        'Address'#9'30'#9'Address'#9'F')
      DataField = 'Company'
      DataSource = dsMemLines
      LookupTable = qryCustomer
      LookupField = 'Company'
      Options = [loTitles]
      Style = csDropDownList
      DropDownCount = 12
      TabOrder = 9
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = cboCustomerCloseUp
      OnNotInList = cboCustomerNotInList
    end
    object btnResequence: TDNMSpeedButton
      Left = 497
      Top = 520
      Width = 100
      Height = 27
      Action = actResequence
      Anchors = [akBottom]
      Caption = '&Resequence'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 5
    end
    object btnReorder: TDNMSpeedButton
      Left = 290
      Top = 520
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Re&order'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 3
      OnClick = btnReorderClick
    end
    object dtExcludeFrom: TwwDBDateTimePicker
      Left = 504
      Top = 200
      Width = 129
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ExcludeFrom'
      DataSource = dsMemLines
      Epoch = 1950
      ShowButton = True
      TabOrder = 10
      OnCloseUp = dtExcludeFromCloseUp
    end
    object dtExcludeTo: TwwDBDateTimePicker
      Left = 648
      Top = 200
      Width = 129
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ExcludeTo'
      DataSource = dsMemLines
      Epoch = 1950
      ShowButton = True
      TabOrder = 11
      OnCloseUp = dtExcludeToCloseUp
    end
    object btnRenumber: TDNMSpeedButton
      Left = 394
      Top = 520
      Width = 100
      Height = 27
      Anchors = [akBottom]
      Caption = 'Re&number'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      OnClick = btnRenumberClick
    end
    object cboPayMethod: TwwDBLookupCombo
      Left = 248
      Top = 200
      Width = 81
      Height = 23
      ControlType.Strings = (
        'Address;RichEdit;;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'30'#9'Payment Method'#9'F')
      DataField = 'PayMethodName'
      DataSource = dsMemLines
      LookupTable = qryPayment
      LookupField = 'Name'
      Options = [loTitles]
      Style = csDropDownList
      TabOrder = 12
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnChange = cboPayMethodChange
    end
    object cboParts: TwwDBLookupCombo
      Left = 344
      Top = 200
      Width = 145
      Height = 23
      ControlType.Strings = (
        'Address;RichEdit;;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'30'#9'Product'#9'F')
      DataField = 'ProductName'
      DataSource = dsMemLines
      LookupTable = qryParts
      LookupField = 'PARTNAME'
      Options = [loTitles]
      Style = csDropDownList
      TabOrder = 13
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = cboPartsCloseUp
      OnNotInList = cboPartsNotInList
    end
    object chkShowCompany: TwwCheckBox
      Left = 824
      Top = 525
      Width = 15
      Height = 16
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
      Anchors = [akRight, akBottom]
      DataField = 'ShowCompanyAsDefaultOnRun'
      DataSource = dsPersonalPreferences
      ShowText = False
      TabOrder = 8
      OnClick = chkShowCompanyClick
    end
    object cboFreqType: TwwDBComboBox
      Left = 800
      Top = 200
      Width = 121
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = True
      AutoDropDown = True
      AutoFillDate = False
      DataField = 'FreqType'
      DataSource = dsMemLines
      DropDownCount = 8
      DropDownWidth = 200
      ItemHeight = 0
      Items.Strings = (
        'Day(s)'
        'Month(s)'
        'Time Only'
        'Week(s)'
        'Year(s)')
      Sorted = True
      TabOrder = 14
      UnboundDataType = wwDefault
      OnCloseUp = cboFreqTypeCloseUp
    end
    object dtStartDate: TwwDBDateTimePicker
      Left = 504
      Top = 232
      Width = 129
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'StartDate'
      DataSource = dsMemLines
      Epoch = 1950
      ShowButton = True
      TabOrder = 15
      OnCloseUp = dtStartDateCloseUp
    end
    object DNMPanel2: TDNMPanel
      Left = 1
      Top = 33
      Width = 988
      Height = 62
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      TabStop = True
      object Label3: TLabel
        Left = 23
        Top = 9
        Width = 58
        Height = 15
        Caption = 'Run Name'
        Transparent = True
      end
      object Label6: TLabel
        Left = 629
        Top = 24
        Width = 77
        Height = 19
        Caption = 'Operator: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 353
        Top = 9
        Width = 100
        Height = 15
        Caption = 'Customer Search'
        Enabled = False
        Transparent = True
      end
      object cboRunName: TwwDBLookupCombo
        Left = 22
        Top = 23
        Width = 283
        Height = 23
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'RunName'#9'30'#9'Run Name'#9'F'
          'Operator'#9'30'#9'Operator'#9'F')
        LookupTable = qryRuns
        LookupField = 'RunName'
        Options = [loTitles]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboRunNameCloseUp
        OnNotInList = cboRunNameNotInList
      end
      object txtSearch: TEdit
        Left = 352
        Top = 23
        Width = 209
        Height = 23
        Enabled = False
        TabOrder = 1
        OnChange = txtSearchChange
      end
    end
    object dtNextRun: TwwDBDateTimePicker
      Left = 504
      Top = 264
      Width = 129
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ExcludeTo'
      DataSource = dsMemLines
      Epoch = 1950
      ShowButton = True
      TabOrder = 16
      OnCloseUp = dtNextRunCloseUp
    end
    object btnExport: TDNMSpeedButton
      Left = 600
      Top = 520
      Width = 100
      Height = 27
      Anchors = [akBottom]
      Caption = 'Export'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 6
      OnClick = btnExportClick
    end
    object chkExclude: TwwCheckBox
      Left = 424
      Top = 236
      Width = 41
      Height = 14
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      DynamicCaption = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'Yes'
      DisplayValueUnchecked = 'No'
      NullAndBlankState = cbUnchecked
      Indents.ButtonX = 15
      Caption = 'No'
      Color = clWhite
      CenterTextVertically = False
      DataField = 'Exclude'
      DataSource = dsMemLines
      ParentColor = False
      ShowText = False
      TabOrder = 17
      OnClick = chkExcludeClick
    end
    object pnlTitle: TDNMPanel
      Left = 373
      Top = 5
      Width = 238
      Height = 37
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 18
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 234
        Height = 33
        Align = alClient
        BevelOuter = bvNone
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
          Width = 234
          Height = 33
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Run Template'
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
  inherited ApplicationEvents1: TApplicationEvents
    Left = 688
    Top = 37
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 624
    Top = 38
  end
  inherited MyConnection: TMyConnection
    Left = 720
    Top = 38
  end
  object qryRuns: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblruns'
      'WHERE Active = '#39'T'#39
      'ORDER BY RunName;')
    Left = 192
    Top = 5
    object qryRunsRunName: TStringField
      DisplayLabel = 'Run Name'
      DisplayWidth = 30
      FieldName = 'RunName'
      Size = 255
    end
    object qryRunsOperator: TStringField
      DisplayWidth = 30
      FieldName = 'Operator'
      Size = 255
    end
    object qryRunsRunID: TAutoIncField
      FieldName = 'RunID'
      ReadOnly = True
      Visible = False
    end
    object qryRunsActive: TStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryRunsOperatorID: TIntegerField
      FieldName = 'OperatorID'
      Visible = False
    end
    object qryRunsRunDate: TDateField
      FieldName = 'RunDate'
      Visible = False
    end
    object qryRunsGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryRunsClassName: TStringField
      FieldName = 'ClassName'
      Visible = False
      Size = 255
    end
    object qryRunsClassID: TIntegerField
      FieldName = 'ClassID'
      Visible = False
    end
    object qryRunsIsPublicHoliday: TStringField
      FieldName = 'IsPublicHoliday'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryRunLines: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblrunslines'
      'WHERE RunID = :xRunID'
      'ORDER BY Sequence')
    Left = 224
    Top = 5
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRunID'
      end>
    object qryRunLinesClientName: TStringField
      DisplayLabel = 'Contact'
      DisplayWidth = 20
      FieldName = 'ClientName'
      Size = 255
    end
    object qryRunLinesAddress: TStringField
      DisplayWidth = 30
      FieldName = 'Address'
      Size = 255
    end
    object qryRunLinesSequence: TIntegerField
      DisplayLabel = 'Seq'
      DisplayWidth = 5
      FieldName = 'Sequence'
    end
    object qryRunLinesQty: TFloatField
      DisplayWidth = 5
      FieldName = 'Qty'
    end
    object qryRunLinesProductName: TStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 18
      FieldName = 'ProductName'
      Size = 255
    end
    object qryRunLinesOrderValue: TFloatField
      DisplayLabel = 'Price (Inc)'
      DisplayWidth = 10
      FieldName = 'OrderValue'
      currency = True
    end
    object qryRunLinesPayMethodName: TStringField
      DisplayLabel = 'Pay Code'
      DisplayWidth = 9
      FieldName = 'PayMethodName'
      Size = 255
    end
    object qryRunLinesExclude: TStringField
      DisplayWidth = 1
      FieldName = 'Exclude'
      FixedChar = True
      Size = 1
    end
    object qryRunLinesExcludeFrom: TDateField
      DisplayLabel = 'From'
      DisplayWidth = 8
      FieldName = 'ExcludeFrom'
    end
    object qryRunLinesExcludeTo: TDateField
      DisplayLabel = 'To'
      DisplayWidth = 8
      FieldName = 'ExcludeTo'
    end
    object qryRunLinesGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryRunLinesTaxCode: TStringField
      DisplayWidth = 8
      FieldName = 'TaxCode'
      Visible = False
      Size = 255
    end
    object qryRunLinesPreferedSupp: TStringField
      DisplayWidth = 255
      FieldName = 'PreferedSupp'
      Visible = False
      Size = 255
    end
    object qryRunLinesPhone: TStringField
      DisplayWidth = 13
      FieldName = 'Phone'
      Visible = False
      Size = 255
    end
    object qryRunLinesMobile: TStringField
      DisplayWidth = 13
      FieldName = 'Mobile'
      Visible = False
      Size = 255
    end
    object qryRunLinesID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object qryRunLinesRunID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RunID'
      Visible = False
    end
    object qryRunLinesClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object qryRunLinesPayMethodID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayMethodID'
      Visible = False
    end
    object qryRunLinesProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object qryRunLinesUnitExPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitExPrice'
      Visible = False
      currency = True
    end
    object qryRunLinesTaxAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'TaxAmount'
      Visible = False
      currency = True
    end
    object qryRunLinesOriginalExPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'OriginalExPrice'
      Visible = False
      currency = True
    end
    object qryRunLinesDiscount: TFloatField
      DisplayWidth = 10
      FieldName = 'Discount'
      Visible = False
    end
    object qryRunLinesCompany: TStringField
      FieldName = 'Company'
      Size = 255
    end
    object qryRunLinesFreqInterval: TIntegerField
      FieldName = 'FreqInterval'
    end
    object qryRunLinesFreqType: TStringField
      FieldName = 'FreqType'
      Size = 255
    end
    object qryRunLinesStartDate: TDateField
      FieldName = 'StartDate'
    end
    object qryRunLinesNextRunDate: TDateField
      FieldName = 'NextRunDate'
    end
    object qryRunLinesDateAfterNext: TDateField
      FieldName = 'DateAfterNext'
    end
    object qryRunLinesLastDelivery: TDateField
      FieldName = 'LastDelivery'
    end
    object qryRunLinesTrack: TStringField
      FieldName = 'Track'
      FixedChar = True
      Size = 1
    end
    object qryRunLinesIsContact: TStringField
      FieldName = 'IsContact'
      FixedChar = True
      Size = 1
    end
    object qryRunLinesContactID: TIntegerField
      FieldName = 'ContactID'
    end
  end
  object dsRuns: TDataSource
    DataSet = qryRuns
    Left = 160
    Top = 37
  end
  object dsRunLines: TDataSource
    DataSet = qryRunLines
    Left = 192
    Top = 37
  end
  object ActionManager1: TActionManager
    Left = 255
    Top = 5
    object actResequence: TAction
      Caption = 'Resequence'
      OnExecute = actResequenceExecute
      OnUpdate = actResequenceUpdate
    end
  end
  object qryCustomer: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      '# Dummy SQL - See RefreshClientList procedure.'
      'SELECT'
      'ClientID, Company, Type, '
      
        'TRIM(CONCAT_WS('#39' '#39', IF(ISNULL(Title), '#39#39', Title), Firstname, Las' +
        'tName)) AS ClientName,'
      
        'TRIM(LEFT(CONCAT_WS('#39' '#39', Street, IF(ISNULL(Street2), '#39#39', Street2' +
        '), IF(ISNULL(Suburb), '#39#39', Suburb),'
      
        'IF(ISNULL(State), '#39#39', State), IF(ISNULL(Postcode), '#39#39', Postcode)' +
        ','
      
        'IF(ISNULL(Country), '#39#39', Country)), 200)) AS Address, Phone, FaxN' +
        'umber AS Fax, Mobile'
      'FROM tblclients'
      
        'WHERE (Active = "T" AND Customer = "T" AND IsJob = "F" AND Compa' +
        'ny NOT LIKE "Table%")'
      'ORDER BY Customer;'
      ''
      '')
    Options.LongStrings = False
    Left = 624
    Top = 8
  end
  object memRunLines: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = [mtcoDescending, mtcoCaseInsensitive]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    AfterOpen = memRunLinesAfterOpen
    AfterPost = memRunLinesAfterPost
    Left = 288
    Top = 4
    object memRunLinesCompany: TStringField
      DisplayWidth = 20
      FieldName = 'Company'
      Size = 255
    end
    object memRunLinesClientName: TStringField
      DisplayLabel = 'Contact'
      DisplayWidth = 22
      FieldName = 'ClientName'
      OnChange = memRunLinesClientNameChange
      Size = 255
    end
    object memRunLinesAddress: TStringField
      DisplayWidth = 28
      FieldName = 'Address'
      OnChange = memRunLinesAddressChange
      Size = 255
    end
    object memRunLinesSequence: TIntegerField
      DisplayLabel = 'Seq #'
      DisplayWidth = 5
      FieldName = 'Sequence'
      OnChange = memRunLinesSequenceChange
    end
    object memRunLinesQty: TFloatField
      DisplayWidth = 5
      FieldName = 'Qty'
      OnChange = memRunLinesQtyChange
    end
    object memRunLinesProductName: TStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 18
      FieldName = 'ProductName'
      Size = 255
    end
    object memRunLinesTrack: TStringField
      DisplayWidth = 1
      FieldName = 'Track'
      FixedChar = True
      Size = 1
    end
    object memRunLinesOrderValue: TFloatField
      DisplayLabel = 'Price (Inc)'
      DisplayWidth = 10
      FieldName = 'OrderValue'
      OnChange = memRunLinesOrderValueChange
      currency = True
    end
    object memRunLinesPayMethodName: TStringField
      DisplayLabel = 'Pay Code'
      DisplayWidth = 10
      FieldName = 'PayMethodName'
      OnChange = memRunLinesPayMethodNameChange
      Size = 255
    end
    object memRunLinesStartDate: TDateField
      DisplayLabel = 'Start Date'
      DisplayWidth = 11
      FieldName = 'StartDate'
      OnChange = memRunLinesStartDateChange
    end
    object memRunLinesFreqInterval: TIntegerField
      DisplayLabel = 'Interval'
      DisplayWidth = 5
      FieldName = 'FreqInterval'
      OnChange = memRunLinesFreqIntervalChange
    end
    object memRunLinesFreqType: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 12
      FieldName = 'FreqType'
      OnChange = memRunLinesFreqTypeChange
      Size = 255
    end
    object memRunLinesExclude: TStringField
      DisplayWidth = 1
      FieldName = 'Exclude'
      OnChange = memRunLinesExcludeChange
      FixedChar = True
      Size = 1
    end
    object memRunLinesExcludeFrom: TDateField
      DisplayLabel = 'From'
      DisplayWidth = 10
      FieldName = 'ExcludeFrom'
      OnChange = memRunLinesExcludeFromChange
    end
    object memRunLinesExcludeTo: TDateField
      DisplayLabel = 'To'
      DisplayWidth = 10
      FieldName = 'ExcludeTo'
      OnChange = memRunLinesExcludeToChange
    end
    object memRunLinesNextRunDate: TDateField
      DisplayLabel = 'Next Run'
      DisplayWidth = 10
      FieldName = 'NextRunDate'
      OnChange = memRunLinesNextRunDateChange
    end
    object memRunLinesDateAfterNext: TDateField
      DisplayLabel = 'Expected After'
      DisplayWidth = 10
      FieldName = 'DateAfterNext'
    end
    object memRunLinesTaxCode: TStringField
      DisplayLabel = 'Tax Code'
      DisplayWidth = 8
      FieldName = 'TaxCode'
      Size = 255
    end
    object memRunLinesContactID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ContactID'
      Visible = False
    end
    object memRunLinesIsContact: TStringField
      DisplayWidth = 1
      FieldName = 'IsContact'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object memRunLinesLastDelivery: TDateField
      DisplayLabel = 'Last Delivery'
      DisplayWidth = 10
      FieldName = 'LastDelivery'
      ReadOnly = True
      Visible = False
    end
    object memRunLinesGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object memRunLinesPreferedSupp: TStringField
      DisplayWidth = 255
      FieldName = 'PreferedSupp'
      Visible = False
      Size = 255
    end
    object memRunLinesPhone: TStringField
      DisplayWidth = 13
      FieldName = 'Phone'
      Visible = False
      Size = 255
    end
    object memRunLinesMobile: TStringField
      DisplayWidth = 13
      FieldName = 'Mobile'
      Visible = False
      Size = 255
    end
    object memRunLinesID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
    object memRunLinesRunID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RunID'
      Visible = False
    end
    object memRunLinesClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object memRunLinesPayMethodID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayMethodID'
      Visible = False
      OnChange = memRunLinesPayMethodIDChange
    end
    object memRunLinesProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object memRunLinesUnitExPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitExPrice'
      Visible = False
      currency = True
    end
    object memRunLinesTaxAmount: TFloatField
      DisplayLabel = 'Tax Amount'
      DisplayWidth = 10
      FieldName = 'TaxAmount'
      Visible = False
      currency = True
    end
    object memRunLinesOriginalExPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'OriginalExPrice'
      Visible = False
      currency = True
    end
    object memRunLinesDiscount: TFloatField
      DisplayWidth = 10
      FieldName = 'Discount'
      Visible = False
    end
  end
  object dsMemLines: TDataSource
    DataSet = memRunLines
    Left = 256
    Top = 37
  end
  object qryPayment: TMyQuery
    SQL.Strings = (
      'SELECT PayMethodID, Name '
      'FROM tblPaymentMethods'
      'ORDER BY Name')
    Options.LongStrings = False
    Left = 688
    Top = 8
  end
  object qryParts: TMyQuery
    SQL.Strings = (
      'SELECT'
      'PartsID, PARTNAME, Price1, TAXCODE, PREFEREDSUPP'
      'FROM tblparts'
      'WHERE Discontinued = '#39'F'#39' AND Active = '#39'T'#39' AND '
      '(PARTTYPE = '#39'INV'#39' OR PARTTYPE = "OTHER" OR PARTTYPE = "NONINV")'
      'ORDER BY Partname;')
    Options.LongStrings = False
    Left = 656
    Top = 8
    object qryPartsPARTNAME: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 30
      FieldName = 'PARTNAME'
      Origin = 'tblparts.PARTNAME'
      Size = 60
    end
    object qryPartsPartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PartsID'
      Origin = 'tblparts.PartsID'
      Visible = False
    end
    object qryPartsPrice1: TFloatField
      DisplayLabel = 'Price (Ex)'
      DisplayWidth = 15
      FieldName = 'Price1'
      Origin = 'tblparts.Price1'
      Visible = False
      currency = True
    end
    object qryPartsTAXCODE: TStringField
      FieldName = 'TAXCODE'
      Origin = 'tblparts.TAXCODE'
      Visible = False
      Size = 11
    end
    object qryPartsPREFEREDSUPP: TStringField
      FieldName = 'PREFEREDSUPP'
      Size = 55
    end
  end
  object qryHolidays: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tblpublicholidays'
      'WHERE Day = :xDay')
    Options.LongStrings = False
    Left = 720
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xDay'
      end>
  end
  object memCopy: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    AutoAddIndexes = True
    IndexDefs = <>
    SortOptions = [mtcoDescending, mtcoCaseInsensitive]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = [foCaseInsensitive]
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 320
    Top = 5
    object StringField1: TStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 20
      FieldName = 'ClientName'
      Size = 255
    end
    object StringField2: TStringField
      DisplayWidth = 27
      FieldName = 'Address'
      Size = 255
    end
    object IntegerField1: TIntegerField
      DisplayLabel = 'Seq'
      DisplayWidth = 5
      FieldName = 'Sequence'
    end
    object FloatField1: TFloatField
      DisplayWidth = 5
      FieldName = 'Qty'
    end
    object StringField3: TStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 18
      FieldName = 'ProductName'
      Size = 255
    end
    object FloatField2: TFloatField
      DisplayLabel = 'Price (Inc)'
      DisplayWidth = 10
      FieldName = 'OrderValue'
      currency = True
    end
    object StringField4: TStringField
      DisplayLabel = 'Pay Code'
      DisplayWidth = 11
      FieldName = 'PayMethodName'
      Size = 255
    end
    object memCopyStartDate: TDateField
      DisplayLabel = 'Start Date'
      DisplayWidth = 11
      FieldName = 'StartDate'
    end
    object memCopyFreqInterval: TIntegerField
      DisplayLabel = 'Interval'
      DisplayWidth = 5
      FieldName = 'FreqInterval'
    end
    object memCopyFreqType: TStringField
      DisplayLabel = 'Type'
      DisplayWidth = 12
      FieldName = 'FreqType'
      Size = 255
    end
    object StringField5: TStringField
      DisplayWidth = 1
      FieldName = 'Exclude'
      FixedChar = True
      Size = 1
    end
    object DateField1: TDateField
      DisplayLabel = 'From'
      DisplayWidth = 9
      FieldName = 'ExcludeFrom'
    end
    object DateField2: TDateField
      DisplayLabel = 'To'
      DisplayWidth = 9
      FieldName = 'ExcludeTo'
    end
    object StringField6: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object StringField7: TStringField
      DisplayLabel = 'Tax Code'
      DisplayWidth = 20
      FieldName = 'TaxCode'
      Visible = False
      Size = 255
    end
    object StringField8: TStringField
      DisplayWidth = 255
      FieldName = 'PreferedSupp'
      Visible = False
      Size = 255
    end
    object StringField9: TStringField
      DisplayWidth = 13
      FieldName = 'Phone'
      Visible = False
      Size = 255
    end
    object StringField10: TStringField
      DisplayWidth = 13
      FieldName = 'Mobile'
      Visible = False
      Size = 255
    end
    object AutoIncField1: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
    object IntegerField2: TIntegerField
      DisplayWidth = 10
      FieldName = 'RunID'
      Visible = False
    end
    object IntegerField3: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object IntegerField4: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayMethodID'
      Visible = False
    end
    object IntegerField5: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object FloatField3: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitExPrice'
      Visible = False
    end
    object FloatField4: TFloatField
      DisplayWidth = 10
      FieldName = 'TaxAmount'
      Visible = False
    end
    object FloatField5: TFloatField
      DisplayWidth = 10
      FieldName = 'OriginalExPrice'
      Visible = False
    end
    object FloatField6: TFloatField
      DisplayWidth = 10
      FieldName = 'Discount'
      Visible = False
    end
    object memCopyCompany: TStringField
      FieldName = 'Company'
      Size = 255
    end
    object memCopyNextRunDate: TDateField
      FieldName = 'NextRunDate'
    end
    object memCopyDateAfterNext: TDateField
      FieldName = 'DateAfterNext'
    end
    object memCopyLastDelivery: TDateField
      DisplayLabel = 'Last Delivery'
      FieldName = 'LastDelivery'
    end
    object memCopyTrack: TStringField
      FieldName = 'Track'
      FixedChar = True
      Size = 1
    end
    object memCopyIsContact: TStringField
      FieldName = 'IsContact'
      FixedChar = True
      Size = 1
    end
    object memCopyContactID: TIntegerField
      FieldName = 'ContactID'
    end
  end
  object tmrTrigger: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrTriggerTimer
    Left = 160
    Top = 6
  end
  object qryPersonalPreferences: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblpersonalpreferences '
      'WHERE (EmployeeID = :xID);')
    Options.LongStrings = False
    Left = 752
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 752
    Top = 38
  end
  object PopupMenu1: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.1.1'
    Left = 872
    Top = 8
    object CustomiseFields1: TMenuItem
      Caption = 'Select Columns'
      Enabled = False
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Export1: TMenuItem
      Caption = 'Export'
      Enabled = False
      OnClick = Export1Click
    end
    object Resequence1: TMenuItem
      Caption = 'Resequence'
      Enabled = False
      OnClick = actResequenceExecute
    end
    object Renumber1: TMenuItem
      Caption = 'Renumber'
      Enabled = False
      OnClick = btnRenumberClick
    end
    object Reorder1: TMenuItem
      Caption = 'Reorder'
      Enabled = False
      OnClick = btnReorderClick
    end
    object Save1: TMenuItem
      Caption = 'Save'
      Enabled = False
      OnClick = cmdOKClick
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Export CSV File As ...'
    Left = 784
    Top = 8
  end
end
