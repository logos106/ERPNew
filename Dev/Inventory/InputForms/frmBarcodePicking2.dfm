inherited fmBarcodePicking2: TfmBarcodePicking2
  Left = 34
  Top = 193
  HelpContext = 613000
  Caption = 'Barcode Picking'
  ClientHeight = 564
  ClientWidth = 998
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 34
  ExplicitTop = 193
  ExplicitWidth = 1014
  ExplicitHeight = 603
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 507
    Width = 998
    HelpContext = 613015
    ExplicitTop = 507
    ExplicitWidth = 998
  end
  object Splitter1: TSplitter [1]
    Left = 0
    Top = 328
    Width = 998
    Height = 2
    Cursor = crVSplit
    HelpContext = 613001
    Align = alTop
    Color = clBlack
    ParentColor = False
    ResizeStyle = rsLine
  end
  object pnlSummary: TDNMPanel [6]
    Left = 0
    Top = 355
    Width = 998
    Height = 152
    HelpContext = 613011
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 4
    Transparent = False
    object grdSummary: TwwDBGrid
      Left = 15
      Top = 0
      Width = 968
      Height = 152
      HelpContext = 613012
      ControlType.Strings = (
        'Done;CheckBox;True;False')
      Selected.Strings = (
        'ProductName'#9'24'#9'Product Name'#9'F'#9
        'ProductDescription'#9'60'#9'Description'#9'F'#9
        'QtyRequired'#9'12'#9'Qty Required'#9'F'#9
        'QtyPacked'#9'12'#9'Qty Packed'#9'F'#9
        'UOM'#9'12'#9'UOM'#9'F'#9
        'Done'#9'6'#9'Done'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsSummary
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = grdSummaryCalcCellColors
      OnCalcTitleAttributes = grdSummaryCalcTitleAttributes
      OnDblClick = grdSummaryDblClick
    end
    object DNMPanel2: TDNMPanel
      Left = 983
      Top = 0
      Width = 15
      Height = 152
      HelpContext = 613013
      Align = alRight
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      Transparent = False
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 0
      Width = 15
      Height = 152
      HelpContext = 613014
      Align = alLeft
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      Transparent = False
    end
  end
  object pnlMaster: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 998
    Height = 176
    HelpContext = 613003
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    Transparent = False
    DesignSize = (
      998
      176)
    object lblEmployee: TLabel
      Left = 20
      Top = 83
      Width = 55
      Height = 15
      HelpContext = 613020
      Caption = 'Employee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblEmployeeName: TLabel
      Left = 92
      Top = 82
      Width = 300
      Height = 18
      HelpContext = 613021
      AutoSize = False
      Caption = 'lblEmployeeName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label5: TLabel
      Left = 20
      Top = 106
      Width = 31
      Height = 15
      HelpContext = 613022
      Caption = 'Sale :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblSale: TLabel
      Left = 92
      Top = 106
      Width = 300
      Height = 18
      HelpContext = 613023
      AutoSize = False
      Caption = 'lblSale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 20
      Top = 60
      Width = 43
      Height = 15
      HelpContext = 613024
      Caption = 'Status :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblStatus: TLabel
      Left = 92
      Top = 58
      Width = 300
      Height = 18
      HelpContext = 613025
      AutoSize = False
      Caption = 'lblStatus'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 416
      Top = 117
      Width = 62
      Height = 15
      HelpContext = 613026
      Caption = 'Pick Start :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblPickStart: TLabel
      Left = 492
      Top = 116
      Width = 87
      Height = 19
      HelpContext = 613027
      Caption = 'lblPickStart'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 634
      Top = 117
      Width = 39
      Height = 15
      HelpContext = 613028
      Caption = 'Finish :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblPickFinish: TLabel
      Left = 684
      Top = 116
      Width = 98
      Height = 19
      HelpContext = 613029
      Caption = 'lblPickFinish'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label8: TLabel
      Left = 416
      Top = 135
      Width = 66
      Height = 15
      HelpContext = 613030
      Caption = 'Pack Start :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblPackStart: TLabel
      Left = 492
      Top = 134
      Width = 92
      Height = 19
      HelpContext = 613031
      Caption = 'lblPackStart'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label10: TLabel
      Left = 634
      Top = 135
      Width = 39
      Height = 15
      HelpContext = 613032
      Caption = 'Finish :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblPackFinish: TLabel
      Left = 684
      Top = 134
      Width = 103
      Height = 19
      HelpContext = 613033
      Caption = 'lblPackFinish'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblSale2: TLabel
      Left = 92
      Top = 130
      Width = 300
      Height = 18
      HelpContext = 613034
      AutoSize = False
      Caption = 'lblSale2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object imgProduct: TImage
      Left = 816
      Top = 8
      Width = 169
      Height = 137
      HelpContext = 613004
      Anchors = [akTop, akRight]
      Proportional = True
      Stretch = True
    end
    object Label2: TLabel
      Left = 416
      Top = 59
      Width = 350
      Height = 15
      HelpContext = 613035
      Caption = 
        'To select existing  picking  enter "S-<order number>"  (eg S-123' +
        ')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 20
      Top = 156
      Width = 93
      Height = 15
      HelpContext = 613036
      Caption = 'Scan Summary :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblLastProduct: TLabel
      Left = 504
      Top = 154
      Width = 481
      Height = 18
      HelpContext = 613037
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'lblLastProduct'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblCountSummary: TLabel
      Left = 120
      Top = 154
      Width = 353
      Height = 18
      HelpContext = 613038
      AutoSize = False
      Caption = 'lblCountSummary'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object edtBarcodeInput: TEdit
      Left = 416
      Top = 79
      Width = 273
      Height = 32
      HelpContext = 613039
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnExit = edtBarcodeInputExit
      OnKeyDown = edtBarcodeInputKeyDown
      OnKeyPress = edtBarcodeInputKeyPress
    end
    object edtQty: TAdvEdit
      Left = 695
      Top = 80
      Width = 97
      Height = 32
      HelpContext = 613005
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = '0.00'
      Visible = True
      OnExit = edtQtyExit
      OnKeyDown = edtQtyKeyDown
      OnKeyPress = edtQtyKeyPress
      Version = '2.8.6.9'
    end
    object pnlTitle: TDNMPanel
      Left = 255
      Top = 6
      Width = 487
      Height = 45
      HelpContext = 613040
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 483
        Height = 41
        HelpContext = 613041
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
          Width = 483
          Height = 41
          HelpContext = 613042
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Barcode Picking'
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
  object pnlButtons: TDNMPanel [8]
    Left = 0
    Top = 507
    Width = 998
    Height = 57
    HelpContext = 613002
    Align = alBottom
    BevelOuter = bvNone
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
      998
      57)
    object Label4: TLabel
      Left = 345
      Top = 0
      Width = 308
      Height = 15
      HelpContext = 613043
      Alignment = taCenter
      Anchors = [akBottom]
      Caption = '{ Press (Ctrl + Enter) to Start Printing a New Picking Slip }'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
    end
    object btnStartNewPicking: TDNMSpeedButton
      Left = 368
      Top = 18
      Width = 97
      Height = 29
      HelpContext = 613044
      Anchors = [akBottom]
      Caption = 'Start New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
        07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
        0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnStartNewPickingClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 532
      Top = 18
      Width = 97
      Height = 29
      HelpContext = 613045
      Anchors = [akBottom]
      Cancel = True
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnConNote: TDNMSpeedButton
      Left = 884
      Top = 18
      Width = 97
      Height = 29
      HelpContext = 613046
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Con Note'
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
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnConNoteClick
    end
    object btnControlBarCodes: TDNMSpeedButton
      Left = 15
      Top = 18
      Width = 149
      Height = 29
      HelpContext = 613047
      Anchors = [akLeft, akBottom]
      Cancel = True
      Caption = 'Print Control Codes'
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
      TabOrder = 3
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnControlBarCodesClick
    end
  end
  object pnlDetail: TDNMPanel [9]
    Left = 0
    Top = 176
    Width = 998
    Height = 152
    HelpContext = 613006
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    Transparent = False
    object grdLines: TwwDBGrid
      Left = 15
      Top = 0
      Width = 968
      Height = 152
      HelpContext = 613007
      Selected.Strings = (
        'ProductName'#9'34'#9'Product Name'#9'F'#9
        'Description'#9'64'#9'Description'#9'F'#9
        'Qty'#9'10'#9'Qty'#9#9
        'UOM'#9'13'#9'UOM'#9#9
        'PackNumber'#9'8'#9'Pack No'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnRowChanged = grdLinesRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsPickingAssemblyLine
      KeyOptions = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ReadOnly = True
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = grdLinesCalcCellColors
      OnCalcTitleAttributes = grdLinesCalcTitleAttributes
      OnDblClick = grdLinesDblClick
    end
    object DNMPanel4: TDNMPanel
      Left = 0
      Top = 0
      Width = 15
      Height = 152
      HelpContext = 613008
      Align = alLeft
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      Transparent = False
    end
    object DNMPanel5: TDNMPanel
      Left = 983
      Top = 0
      Width = 15
      Height = 152
      HelpContext = 613009
      Align = alRight
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      Transparent = False
    end
  end
  object memsummaryreturn: TMemo [10]
    Left = 233
    Top = 91
    Width = 559
    Height = 410
    HelpContext = 613048
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      ''
      ''
      ''
      'THIS FORM IS NOT USED ANY MORE'
      'PLS USE THE FRMBARCODEPICKING INSTEAD')
    ParentFont = False
    TabOrder = 5
    Visible = False
  end
  object pnlSummaryHeader: TDNMPanel [11]
    Left = 0
    Top = 330
    Width = 998
    Height = 25
    HelpContext = 613010
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 3
    Transparent = False
    object Label1: TLabel
      Left = 22
      Top = 7
      Width = 104
      Height = 15
      HelpContext = 613016
      Caption = 'Packing Summary'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object lblPacknoCaption: TLabel
      Left = 779
      Top = 5
      Width = 96
      Height = 15
      HelpContext = 613017
      Caption = 'Current Pack No:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      Visible = False
    end
    object lblPackno: TLabel
      Left = 869
      Top = 3
      Width = 92
      Height = 19
      HelpContext = 613018
      Alignment = taRightJustify
      Caption = 'lblPackStart'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      Visible = False
    end
    object Label11: TLabel
      Left = 147
      Top = 5
      Width = 614
      Height = 15
      HelpContext = 613019
      Alignment = taCenter
      AutoSize = False
      Caption = 'Double Click on '#39'Scan Summary'#39' Pack Number to Adjust'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102002000300010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryPickingAssembly: TERPQuery
    SQL.Strings = (
      'select * from tblPickingAssembly')
    BeforeInsert = BeforeDataChange
    BeforeEdit = BeforeDataChange
    Left = 56
    Top = 24
  end
  object qryPickingAssemblyLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblPickingAssemblyLines')
    BeforeInsert = BeforeDataChange
    BeforeEdit = BeforeDataChange
    Left = 240
    Top = 48
    object qryPickingAssemblyLinesProductName: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 34
      FieldName = 'ProductName'
      Origin = 'tblPickingAssemblyLines.ProductName'
      Size = 255
    end
    object qryPickingAssemblyLinesDescription: TWideStringField
      DisplayWidth = 64
      FieldName = 'Description'
      Origin = 'tblPickingAssemblyLines.Description'
      Size = 255
    end
    object qryPickingAssemblyLinesQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
    end
    object qryPickingAssemblyLinesUOM: TWideStringField
      DisplayWidth = 13
      FieldName = 'UOM'
      Origin = 'tblPickingAssemblyLines.UOM'
      Size = 255
    end
    object qryPickingAssemblyLinesPackNumber: TIntegerField
      DisplayLabel = 'Pack No'
      DisplayWidth = 8
      FieldName = 'PackNumber'
      Origin = 'tblPickingAssemblyLines.PackNumber'
    end
    object qryPickingAssemblyLinesQtyMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'QtyMultiplier'
      Origin = 'tblPickingAssemblyLines.QtyMultiplier'
      Visible = False
    end
    object qryPickingAssemblyLinesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblPickingAssemblyLines.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPickingAssemblyLinesPickingAssemblylinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PickingAssemblylinesID'
      Origin = 'tblPickingAssemblyLines.PickingAssemblylinesID'
      Visible = False
    end
    object qryPickingAssemblyLinesPickingAssemblyID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PickingAssemblyID'
      Origin = 'tblPickingAssemblyLines.PickingAssemblyID'
      Visible = False
    end
    object qryPickingAssemblyLinesProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductID'
      Origin = 'tblPickingAssemblyLines.ProductID'
      Visible = False
    end
    object qryPickingAssemblyLinesUOMID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UOMID'
      Origin = 'tblPickingAssemblyLines.UOMID'
      Visible = False
    end
  end
  object dsPixkingAssembly: TDataSource
    DataSet = qryPickingAssembly
    Left = 48
    Top = 32
  end
  object dsPickingAssemblyLine: TDataSource
    DataSet = qryPickingAssemblyLines
    Left = 80
    Top = 40
  end
  object memSummary: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'ProductName'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ProductDescription'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'QtyRequired'
        DataType = ftFloat
      end
      item
        Name = 'QtyPacked'
        DataType = ftFloat
      end
      item
        Name = 'Done'
        DataType = ftBoolean
      end
      item
        Name = 'ProductId'
        DataType = ftInteger
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
    Left = 192
    Top = 40
    object memSummaryProductName: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 24
      FieldName = 'ProductName'
      Size = 255
    end
    object memSummaryProductDescription: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 60
      FieldName = 'ProductDescription'
      Size = 255
    end
    object memSummaryQtyRequired: TFloatField
      DisplayLabel = 'Qty Required'
      DisplayWidth = 12
      FieldName = 'QtyRequired'
    end
    object memSummaryQtyPacked: TFloatField
      DisplayLabel = 'Qty Packed'
      DisplayWidth = 12
      FieldName = 'QtyPacked'
    end
    object memSummaryUOM: TWideStringField
      DisplayWidth = 12
      FieldName = 'UOM'
      Size = 255
    end
    object memSummaryDone: TBooleanField
      DisplayWidth = 6
      FieldName = 'Done'
    end
    object memSummaryProductId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductId'
      Visible = False
    end
  end
  object dsSummary: TDataSource
    DataSet = memSummary
    Left = 192
    Top = 8
  end
end
