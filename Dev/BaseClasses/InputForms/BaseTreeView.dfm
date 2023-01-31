inherited BaseTreeViewGUI: TBaseTreeViewGUI
  Left = 426
  Top = 232
  Caption = 'BaseTreeViewGUI'
  ClientHeight = 557
  ClientWidth = 996
  OldCreateOrder = True
  ExplicitLeft = 426
  ExplicitTop = 232
  ExplicitWidth = 1012
  ExplicitHeight = 596
  DesignSize = (
    996
    557)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 254
    Width = 996
    ExplicitTop = 507
    ExplicitWidth = 996
  end
  object lblMsg: TLabel [4]
    Left = 0
    Top = 492
    Width = 996
    Height = 15
    Align = alBottom
    Alignment = taCenter
    Caption = 'lblMsg'
    Visible = False
    ExplicitWidth = 37
  end
  object Tree: TVirtualStringTree [6]
    Left = 0
    Top = 93
    Width = 996
    Height = 161
    Align = alClient
    Colors.HeaderHotColor = clBtnHighlight
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    Header.AutoSizeIndex = -1
    Header.Background = clWhite
    Header.DefaultHeight = 17
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = -1
    Header.Options = [hoColumnResize, hoDrag]
    ParentFont = False
    TabOrder = 2
    OnAdvancedHeaderDraw = TreeAdvancedHeaderDraw
    OnColumnClick = TreeColumnClick
    OnDblClick = TreeDblClick
    OnGetText = TreeGetText
    OnHeaderDrawQueryElements = TreeHeaderDrawQueryElements
    OnMouseDown = TreeMouseDown
    Columns = <>
  end
  object pnlBottom: TDNMPanel [7]
    Left = 0
    Top = 507
    Width = 996
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      996
      50)
    object btnCustomize: TDNMSpeedButton
      Left = 199
      Top = 12
      Width = 87
      Height = 26
      Hint = '"Customise the List"'
      Anchors = [akBottom]
      Caption = 'Customi&se'
      DisableTransparent = False
      Enabled = False
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      Visible = False
      AutoDisableParentOnclick = True
    end
    object cmdExport: TDNMSpeedButton
      Left = 327
      Top = 12
      Width = 87
      Height = 26
      Hint = '"Export The List To An Excel Spreadsheet"'
      Anchors = [akBottom]
      Caption = 'E&xport'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdExportClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 455
      Top = 12
      Width = 88
      Height = 26
      Hint = '"Add A New Entry"'
      Anchors = [akBottom]
      Caption = '&New'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
    end
    object cmdPrint: TDNMSpeedButton
      Left = 583
      Top = 12
      Width = 87
      Height = 26
      Hint = '"Print The List"'
      Anchors = [akBottom]
      Caption = 'Prin&t'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdPrintClick
    end
    object cmdClose: TDNMSpeedButton
      Left = 711
      Top = 12
      Width = 86
      Height = 26
      Hint = '"Close The List"'
      Anchors = [akBottom]
      Caption = '&Close'
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object btnExpandAll: TDNMSpeedButton
      Left = 12
      Top = 12
      Width = 86
      Height = 26
      Hint = 'Fully expand the tree'
      Caption = 'Expand All'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnExpandAllClick
    end
  end
  object Memo1: TMemo [8]
    Left = 0
    Top = 254
    Width = 996
    Height = 238
    Align = alBottom
    Color = clGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'BaseTreeView'
      
        '        ChartOfAccountsTree------------------(TfmChartOfAccounts' +
        'Tree)'
      
        '                SelectAccountsForreport--------(TfmSelectAccount' +
        'sForReportsAccount)'
      
        '                ChartofAccountsreportTree-----(TFmChartofAccount' +
        'sReportTree)'
      
        '        ERPClientListTree-----------------------(TERPClientListT' +
        'reeGUI)'
      
        '        ProductAllocationTree------------------(TfmProductAlloca' +
        'tionTree)'
      
        '        TreeItemList-----------------------------(TfmTreeItemLis' +
        't)')
    ParentFont = False
    TabOrder = 3
    Visible = False
  end
  object pnlTop: TDNMPanel [9]
    Left = 0
    Top = 0
    Width = 996
    Height = 93
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      93)
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
      Visible = False
    end
    object lblTo: TLabel
      Left = 893
      Top = 35
      Width = 13
      Height = 15
      Anchors = [akTop, akRight]
      Caption = '&To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object cboDateRange: TComboBox
      Left = 807
      Top = 3
      Width = 185
      Height = 23
      AutoDropDown = True
      Style = csDropDownList
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 14
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      Text = 'Custom'
      Visible = False
      OnCloseUp = cboDateRangeCloseUp
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
      Left = 807
      Top = 32
      Width = 81
      Height = 23
      TabStop = False
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Date = 37432.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxDate = 401769.000000000000000000
      MinDate = -363.000000000000000000
      ParentFont = False
      ShowButton = True
      TabOrder = 1
      UnboundDataType = wwDTEdtDate
      Visible = False
      OnCloseUp = dtFromCloseUp
      OnChange = dtFromChange
    end
    object dtTo: TwwDBDateTimePicker
      Left = 910
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
      Date = 37432.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      MaxDate = 401769.000000000000000000
      MinDate = -363.000000000000000000
      ParentFont = False
      ShowButton = True
      TabOrder = 2
      UnboundDataType = wwDTEdtDate
      Visible = False
      OnCloseUp = dtToCloseUp
      OnChange = dtToChange
    end
    object pnlSearch: TPanel
      Left = 0
      Top = 60
      Width = 996
      Height = 33
      Align = alBottom
      BevelInner = bvLowered
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
      DesignSize = (
        996
        33)
      object Label1: TLabel
        Left = 177
        Top = 9
        Width = 88
        Height = 17
        AutoSize = False
        Caption = 'Search Colu&mn'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object Label2: TLabel
        Left = 465
        Top = 9
        Width = 72
        Height = 17
        AutoSize = False
        Caption = '&Search Text'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object cboFilter: TComboBox
        Left = 267
        Top = 5
        Width = 193
        Height = 23
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object edtSearch: TEdit
        Left = 537
        Top = 5
        Width = 289
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
      object btnGo: TDNMSpeedButton
        AlignWithMargins = True
        Left = 832
        Top = 4
        Width = 38
        Height = 25
        Align = alRight
        Caption = '&Go'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        Visible = False
        AutoDisableParentOnclick = True
        OnClick = btnGoClick
      end
      object btnRequery: TDNMSpeedButton
        Left = 10
        Top = 4
        Width = 107
        Height = 25
        Caption = 'Refresh'
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
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
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = btnRequeryClick
      end
      object chkBlankwhen0: TCheckBox
        Left = 873
        Top = 1
        Width = 122
        Height = 31
        Align = alRight
        Caption = 'Blank when Zero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        Visible = False
        WordWrap = True
        OnClick = chkBlankwhen0Click
      end
    end
    object pnlTitle: TDNMPanel
      Left = 253
      Top = 6
      Width = 492
      Height = 49
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
        Width = 488
        Height = 45
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
          Width = 488
          Height = 45
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 400
    Top = 215
  end
  inherited tmrdelay: TTimer
    Left = 438
    Top = 215
  end
  inherited popSpelling: TPopupMenu
    Left = 132
    Top = 215
  end
  inherited tmrdelayMsg: TTimer
    Left = 477
    Top = 215
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 362
    Top = 215
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 515
    Top = 215
  end
  inherited MyConnection: TERPConnection
    Left = 18
    Top = 215
  end
  inherited DataState: TDataState
    Left = 553
    Top = 215
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 171
    Top = 215
  end
  inherited imgsort: TImageList
    Left = 591
    Top = 215
    Bitmap = {
      494C010102007400800010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 56
    Top = 215
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 630
    Top = 215
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 209
    Top = 215
  end
  inherited qryMemTrans: TERPQuery
    Left = 94
    Top = 215
  end
  object PrintDialog: TPrintDialog
    Left = 285
    Top = 215
  end
  object PrinterSetupDialog: TPrinterSetupDialog
    Left = 247
    Top = 215
  end
  object dlgSave: TSaveDialog
    DefaultExt = '*.txt'
    Filter = 
      'Tabbed Delimited Text  (*.TXT)|*.txt|Comma Delimited Text (*.CSV' +
      ')|*.csv'
    Left = 324
    Top = 215
  end
end
