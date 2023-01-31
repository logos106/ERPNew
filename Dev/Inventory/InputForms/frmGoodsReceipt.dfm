inherited fmGoodsReceipt: TfmGoodsReceipt
  Caption = 'Goods Receipt'
  ClientHeight = 564
  ClientWidth = 998
  ExplicitTop = 8
  ExplicitWidth = 1004
  ExplicitHeight = 593
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1643002
  inherited lblSkingroupMsg: TLabel
    Top = 334
    Width = 998
    ExplicitTop = 334
    ExplicitWidth = 998
    HelpContext = 1643003
  end
  inherited shapehint: TShape
    Left = 9
    ExplicitLeft = 9
  end
  inherited shapehintextra1: TShape
    Left = 57
    ExplicitLeft = 57
  end
  object Splitter1: TSplitter [5]
    Left = 0
    Top = 334
    Width = 998
    Height = 2
    Cursor = crVSplit
    Align = alBottom
    Color = clBlack
    ParentColor = False
    ResizeStyle = rsLine
    ExplicitTop = 176
    HelpContext = 1643004
  end
  object pnlButtons: TDNMPanel [6]
    Left = 0
    Top = 507
    Width = 998
    Height = 57
    Align = alBottom
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
      57)
    HelpContext = 1643005
    object Label7: TLabel
      Left = 186
      Top = 0
      Width = 626
      Height = 15
      Alignment = taCenter
      Anchors = [akTop, akRight, akBottom]
      AutoSize = False
      Caption = '{ Press (Ctrl + Enter) to Start a New Goods Receipt }'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      HelpContext = 1643006
    end
    object btnStartNewPicking: TDNMSpeedButton
      Left = 331
      Top = 20
      Width = 97
      Height = 29
      Anchors = []
      Caption = 'Start Next'
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
      OnClick = btnStartNewPickingClick
      HelpContext = 1643007
    end
    object btnCancel: TDNMSpeedButton
      Left = 805
      Top = 20
      Width = 97
      Height = 29
      Anchors = []
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
      OnClick = btnCancelClick
      HelpContext = 1643008
    end
    object btnControlBarCodes: TDNMSpeedButton
      Left = 213
      Top = 20
      Width = 97
      Height = 29
      Anchors = []
      Cancel = True
      Caption = 'Print Ctrl Codes'
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
      OnClick = btnControlBarCodesClick
      HelpContext = 1643009
    end
    object btnCompleted: TDNMSpeedButton
      Left = 95
      Top = 20
      Width = 97
      Height = 29
      Anchors = []
      Caption = '&Save'
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      TabStop = False
      OnClick = btnCompletedClick
      HelpContext = 1643010
    end
    object btnDelete: TDNMSpeedButton
      Left = 450
      Top = 20
      Width = 97
      Height = 29
      Anchors = []
      Caption = '&Delete'
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
      OnClick = btnDeleteClick
      HelpContext = 1643011
    end
    object cmdPrint: TDNMSpeedButton
      Left = 686
      Top = 20
      Width = 97
      Height = 29
      Anchors = []
      Caption = 'Prin&t'
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
      TabOrder = 5
      TabStop = False
      OnClick = cmdPrintClick
      HelpContext = 1643012
    end
    object chkAutoPrint: TwwCheckBox
      Left = 893
      Top = 1
      Width = 92
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Anchors = [akRight, akBottom]
      Caption = 'Auto Print'
      TabOrder = 6
      HelpContext = 1643013
    end
    object btnPrintPO: TDNMSpeedButton
      Left = 568
      Top = 20
      Width = 97
      Height = 29
      Anchors = []
      Caption = 'Print PO'
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
      TabOrder = 7
      TabStop = False
      OnClick = btnPrintPOClick
      HelpContext = 1643014
    end
    object chkChooseRpt: TCheckBox
      Left = 7
      Top = 3
      Width = 120
      Height = 15
      HelpContext = 1643015
      Caption = 'Choose Template'
      TabOrder = 8
    end
  end
  object pnlMaster: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 998
    Height = 153
    Align = alTop
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
      153)
    HelpContext = 1643016
    object lblEmployee: TLabel
      Left = 11
      Top = 83
      Width = 55
      Height = 15
      Caption = 'Employee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      HelpContext = 1643017
    end
    object lblEmployeeName: TLabel
      Left = 76
      Top = 82
      Width = 223
      Height = 18
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
      HelpContext = 1643018
    end
    object Label1: TLabel
      Left = 11
      Top = 106
      Width = 39
      Height = 15
      Caption = 'Order :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      HelpContext = 1643019
    end
    object lblPO: TLabel
      Left = 76
      Top = 106
      Width = 223
      Height = 18
      AutoSize = False
      Caption = 'lblPO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      HelpContext = 1643020
    end
    object Label3: TLabel
      Left = 11
      Top = 60
      Width = 43
      Height = 15
      Caption = 'Status :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      HelpContext = 1643021
    end
    object lbPickStart: TLabel
      Left = 305
      Top = 117
      Width = 80
      Height = 15
      Alignment = taRightJustify
      Caption = 'Receipt Start :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      HelpContext = 1643022
    end
    object lblReceiptStart: TLabel
      Left = 396
      Top = 116
      Width = 122
      Height = 19
      AutoSize = False
      Caption = 'lblReceiptStart'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      HelpContext = 1643023
    end
    object lbPickfinish: TLabel
      Left = 538
      Top = 117
      Width = 39
      Height = 15
      Caption = 'Finish :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      HelpContext = 1643024
    end
    object lblReceiptFinish: TLabel
      Left = 588
      Top = 116
      Width = 110
      Height = 19
      AutoSize = False
      Caption = 'lblReceiptFinish'
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
      HelpContext = 1643025
    end
    object lblPO2: TLabel
      Left = 76
      Top = 130
      Width = 223
      Height = 18
      AutoSize = False
      Caption = 'lblPO2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      HelpContext = 1643026
    end
    object imgProduct: TImage
      Left = 840
      Top = 8
      Width = 145
      Height = 113
      Anchors = [akTop, akRight]
      Proportional = True
      Stretch = True
      HelpContext = 1643027
    end
    object Label2: TLabel
      Left = 308
      Top = 59
      Width = 327
      Height = 15
      Caption = 'To select existing  PO  enter "P-<order number>"  (eg P-123)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      HelpContext = 1643028
    end
    object lblLastProduct: TLabel
      Left = 800
      Top = 127
      Width = 185
      Height = 18
      Alignment = taRightJustify
      Anchors = [akLeft, akTop, akRight]
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
      HelpContext = 1643029
    end
    object lblStatus: TLabel
      Left = 76
      Top = 58
      Width = 223
      Height = 18
      AutoSize = False
      Caption = 'lblStatus'
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
      HelpContext = 1643030
    end
    object edtBarcodeInput: TEdit
      Left = 308
      Top = 79
      Width = 273
      Height = 32
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnKeyPress = edtBarcodeInputKeyPress
      HelpContext = 1643031
    end
    object edtQty: TAdvEdit
      Left = 587
      Top = 80
      Width = 97
      Height = 32
      Hint = 
        'This is the Qty picking on the selected Line. Please change to P' +
        'ick a different Quantity. If the Quantity given is more than the' +
        ' '#39'shipped Quantity'#39' of the slaes it, Qty will be picked from the' +
        ' other sales of the group'
      EditType = etFloat
      Precision = 2
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'MS Sans Serif'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = 11075496
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '0.00'
      Visible = True
      OnKeyPress = edtQtyKeyPress
      Version = '2.8.6.9'
      HelpContext = 1643032
    end
    object pnlTitle: TDNMPanel
      Left = 310
      Top = 6
      Width = 378
      Height = 45
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      HelpContext = 1643033
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 374
        Height = 41
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
        HelpContext = 1643034
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 374
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Goods Receipt'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 483
          HelpContext = 1643035
        end
      end
    end
  end
  object pnlPOLines: TDNMPanel [8]
    Left = 0
    Top = 336
    Width = 998
    Height = 171
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      998
      171)
    HelpContext = 1643036
    object Label5: TLabel
      Left = 9
      Top = 6
      Width = 131
      Height = 15
      Caption = 'Purchase Order Lines :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      HelpContext = 1643037
    end
    object grdPoLines: TwwDBGrid
      Left = 9
      Top = 24
      Width = 976
      Height = 142
      Selected.Strings = (
        'ProductPrintName'#9'20'#9'Product Print Name'#9#9
        'Product_Description'#9'20'#9'Product_Description'#9#9
        'UnitofMeasurePOLines'#9'10'#9'UOM'#9#9
        'UnitofMeasureQtySold'#9'10'#9'UOM Qty Ordered'#9#9
        'ReceiptQty'#9'10'#9'Receipt Qty'#9'F'#9
        'QtyOutstanding'#9'10'#9'Qty Outstanding'#9'F'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      OnRowChanged = grdPoLinesRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsPOLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
      OnCalcCellColors = grdPoLinesCalcCellColors
      HelpContext = 1643038
    end
  end
  object pnlReceiptLines: TDNMPanel [9]
    Left = 0
    Top = 153
    Width = 998
    Height = 181
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      998
      181)
    HelpContext = 1643039
    object grdReceiptLines: TwwDBGrid
      Left = 9
      Top = 3
      Width = 976
      Height = 167
      ControlType.Strings = (
        'Deleted;CheckBox;T;F')
      Selected.Strings = (
        'ProductName'#9'30'#9'Product Name'#9'F'
        'QuantityReceived'#9'10'#9'Qty Received'#9#9
        'SerialNumber'#9'10'#9'Serial Number'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsGoodsReceiptLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
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
      HelpContext = 1643040
      object grdReceiptLinesIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 23
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          C6030000424DC603000000000000360000002800000010000000130000000100
          18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
          666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
          99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
          CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
          333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
          99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
          C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
          C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
          77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
          8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
          B2B2B2808080333366000080333366777777777777333366000080333399C0C0
          C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
          0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
          CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
          0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
          868686808080666699333399333399000080333366666666808080969696C0C0
          C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
          8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
          B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
          80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
          CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
          99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
          D7CCCCCCCCCCCCCCCCCC}
        OnClick = grdReceiptLinesIButtonClick
        HelpContext = 1643041
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 492
    Top = 0
  end
  inherited tmrdelay: TTimer
    Left = 528
    Top = 0
  end
  inherited popSpelling: TPopupMenu
    Left = 176
    Top = 0
  end
  inherited tmrdelayMsg: TTimer
    Left = 64
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 281
    Top = 0
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 317
    Top = 0
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 2
    Top = 65527
  end
  inherited DataState: TDataState
    Left = 352
    Top = 0
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 211
    Top = 0
  end
  inherited imgsort: TImageList
    Left = 387
    Top = 0
    Bitmap = {
      494C0101020048012C0210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 106
    Top = 0
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 422
    Top = 0
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 246
    Top = 0
  end
  inherited qryMemTrans: TERPQuery
    Left = 141
    Top = 0
  end
  object qryPOLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select * from tblpurchaseLines where PurchaseOrderID = :Purchase' +
        'OrderID')
    AfterOpen = qryPOLinesAfterOpen
    OnCalcFields = qryPOLinesCalcFields
    Left = 816
    Top = 416
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PurchaseOrderID'
      end>
    object qryPOLinesProductPrintName: TWideStringField
      DisplayLabel = 'Product Print Name'
      DisplayWidth = 20
      FieldName = 'ProductPrintName'
      Size = 255
    end
    object qryPOLinesProduct_Description: TWideStringField
      DisplayWidth = 20
      FieldName = 'Product_Description'
      Size = 255
    end
    object qryPOLinesUnitofMeasurePOLines: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 10
      FieldName = 'UnitofMeasurePOLines'
      Size = 255
    end
    object qryPOLinesUnitofMeasureQtySold: TFloatField
      DisplayLabel = 'UOM Qty Ordered'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureQtySold'
    end
    object qryPOLinesReceiptQty: TFloatField
      DisplayLabel = 'Receipt Qty'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ReceiptQty'
      Calculated = True
    end
    object qryPOLinesQtyOutstanding: TFloatField
      DisplayLabel = 'Qty Outstanding'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'QtyOutstanding'
      Calculated = True
    end
    object qryPOLinesUnitofMeasureShipped: TFloatField
      DisplayLabel = 'UOM Qty Received'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureShipped'
      Visible = False
    end
    object qryPOLinesUnitofMeasureBackorder: TFloatField
      DisplayLabel = 'UOM Backorder'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureBackorder'
      Visible = False
    end
    object qryPOLinesProductID: TIntegerField
      DisplayLabel = 'Produc tID'
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object qryPOLinesLineCost: TFloatField
      DisplayWidth = 10
      FieldName = 'LineCost'
      Visible = False
    end
    object qryPOLinesShipped: TFloatField
      DisplayWidth = 10
      FieldName = 'Shipped'
      Visible = False
    end
    object qryPOLinesBackOrder: TFloatField
      DisplayWidth = 10
      FieldName = 'BackOrder'
      Visible = False
    end
    object qryPOLinesUnitOfMeasureID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UnitOfMeasureID'
      Visible = False
    end
    object qryPOLinesUnitofMeasureMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitofMeasureMultiplier'
      Visible = False
    end
    object qryPOLinesInvoiced: TWideStringField
      DisplayWidth = 1
      FieldName = 'Invoiced'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPOLinesClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object qryPOLinesClass: TWideStringField
      DisplayWidth = 255
      FieldName = 'Class'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomerJob: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomerJob'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomerPrintJob: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomerPrintJob'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomerJobID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerJobID'
      Visible = False
    end
    object qryPOLinesRAQty: TFloatField
      DisplayWidth = 10
      FieldName = 'RAQty'
      Visible = False
    end
    object qryPOLinesRAstatus: TWideStringField
      DisplayWidth = 255
      FieldName = 'RAstatus'
      Visible = False
      Size = 255
    end
    object qryPOLinesBatch: TWideStringField
      DisplayWidth = 9
      FieldName = 'Batch'
      Visible = False
      Size = 9
    end
    object qryPOLinesUseTimecost: TWideStringField
      DisplayWidth = 1
      FieldName = 'UseTimecost'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPOLinesSaleID_Timecost: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID_Timecost'
      Visible = False
    end
    object qryPOLinesTimecostMarkupPer: TFloatField
      DisplayWidth = 10
      FieldName = 'TimecostMarkupPer'
      Visible = False
    end
    object qryPOLinesTimecostPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'TimecostPrice'
      Visible = False
    end
    object qryPOLinesTimecostMarkupDol: TFloatField
      DisplayWidth = 10
      FieldName = 'TimecostMarkupDol'
      Visible = False
    end
    object qryPOLinesserialno: TWideMemoField
      DisplayWidth = 10
      FieldName = 'serialno'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryPOLinesTotalLineAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalLineAmount'
      Visible = False
    end
    object qryPOLinesTotalLineAmountInc: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalLineAmountInc'
      Visible = False
    end
    object qryPOLinesCOGSTotalLineAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'COGSTotalLineAmount'
      Visible = False
    end
    object qryPOLinesCOGSTotalLineAmountInc: TFloatField
      DisplayWidth = 10
      FieldName = 'COGSTotalLineAmountInc'
      Visible = False
    end
    object qryPOLinesEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPOLinesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPOLinesRAInvoiceNo: TWideStringField
      DisplayWidth = 11
      FieldName = 'RAInvoiceNo'
      Visible = False
      Size = 11
    end
    object qryPOLinesAttrib1Purchase: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1Purchase'
      Visible = False
    end
    object qryPOLinesAttrib2Purchase: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib2Purchase'
      Visible = False
    end
    object qryPOLinesAttrib1PurchaseRate: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1PurchaseRate'
      Visible = False
    end
    object qryPOLinesAttrib1PurchaseEst: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1PurchaseEst'
      Visible = False
    end
    object qryPOLinesAttrib2PurchaseEst: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib2PurchaseEst'
      Visible = False
    end
    object qryPOLinesLastLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LastLineID'
      Visible = False
    end
    object qryPOLinesRelatedPOIDUsed: TWideStringField
      DisplayWidth = 1
      FieldName = 'RelatedPOIDUsed'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPOLinesRelatedPOID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RelatedPOID'
      Visible = False
    end
    object qryPOLinesLandedCostsPerItem: TFloatField
      DisplayWidth = 10
      FieldName = 'LandedCostsPerItem'
      Visible = False
    end
    object qryPOLinesLandedCostsPercentage: TFloatField
      DisplayWidth = 10
      FieldName = 'LandedCostsPercentage'
      Visible = False
    end
    object qryPOLinesLandedCostsTotal: TFloatField
      DisplayWidth = 10
      FieldName = 'LandedCostsTotal'
      Visible = False
    end
    object qryPOLinesForeignExchangeRate: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignExchangeRate'
      Visible = False
    end
    object qryPOLinesForeignExchangeCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'ForeignExchangeCode'
      Visible = False
      FixedChar = True
      Size = 3
    end
    object qryPOLinesForeignCurrencyLineCost: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignCurrencyLineCost'
      Visible = False
    end
    object qryPOLinesForeignTotalLineAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignTotalLineAmount'
      Visible = False
    end
    object qryPOLinesDescAttrib1: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib1'
      Visible = False
      Size = 255
    end
    object qryPOLinesDescAttrib2: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib2'
      Visible = False
      Size = 255
    end
    object qryPOLinesDescAttrib3: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib3'
      Visible = False
      Size = 255
    end
    object qryPOLinesDescAttrib4: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib4'
      Visible = False
      Size = 255
    end
    object qryPOLinesDescAttrib5: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib5'
      Visible = False
      Size = 255
    end
    object qryPOLinesSearchFilter: TWideStringField
      DisplayWidth = 255
      FieldName = 'SearchFilter'
      Visible = False
      Size = 255
    end
    object qryPOLinesSearchFilterCopy: TWideStringField
      DisplayWidth = 255
      FieldName = 'SearchFilterCopy'
      Visible = False
      Size = 255
    end
    object qryPOLinesReceivedDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'ReceivedDate'
      Visible = False
    end
    object qryPOLinesCostCentreId: TIntegerField
      DisplayWidth = 10
      FieldName = 'CostCentreId'
      Visible = False
    end
    object qryPOLinesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object qryPOLinesDocketNumber: TWideStringField
      DisplayWidth = 255
      FieldName = 'DocketNumber'
      Visible = False
      Size = 255
    end
    object qryPOLinesPartSpecID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartSpecID'
      Visible = False
    end
    object qryPOLinesSpecDescription: TWideStringField
      DisplayWidth = 255
      FieldName = 'SpecDescription'
      Visible = False
      Size = 255
    end
    object qryPOLinesSpecValue: TFloatField
      DisplayWidth = 10
      FieldName = 'SpecValue'
      Visible = False
    end
    object qryPOLinesNewForeignExchangeRate: TFloatField
      DisplayWidth = 10
      FieldName = 'NewForeignExchangeRate'
      Visible = False
    end
    object qryPOLinesETADate: TDateField
      DisplayWidth = 10
      FieldName = 'ETADate'
      Visible = False
    end
    object qryPOLinesCustomField1: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField1'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomField2: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField2'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomField3: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField3'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomField4: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField4'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomField5: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField5'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomField6: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField6'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomField7: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField7'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomField8: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField8'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomField9: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField9'
      Visible = False
      Size = 255
    end
    object qryPOLinesCustomField10: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField10'
      Visible = False
      Size = 255
    end
    object qryPOLinesLineNotes: TWideMemoField
      DisplayWidth = 10
      FieldName = 'LineNotes'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryPOLinesINCOMEACCNTID: TIntegerField
      DisplayWidth = 10
      FieldName = 'INCOMEACCNTID'
      Visible = False
    end
    object qryPOLinesASSETACCNTID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ASSETACCNTID'
      Visible = False
    end
    object qryPOLinesCOGSACCNTID: TIntegerField
      DisplayWidth = 10
      FieldName = 'COGSACCNTID'
      Visible = False
    end
    object qryPOLinesSortID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SortID'
      Visible = False
    end
    object qryPOLinesMemoLine: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MemoLine'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryPOLinesSaleLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      Visible = False
    end
    object qryPOLinesRelatedShipContainerID: TIntegerField
      DisplayWidth = 10
      FieldName = 'RelatedShipContainerID'
      Visible = False
    end
    object qryPOLinesRelatedShipContainerIDUsed: TWideStringField
      DisplayWidth = 1
      FieldName = 'RelatedShipContainerIDUsed'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPOLinesRepairId: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairId'
      Visible = False
    end
    object qryPOLinesCustomerEquipmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerEquipmentID'
      Visible = False
    end
    object qryPOLinesEquipmentName: TWideStringField
      DisplayWidth = 100
      FieldName = 'EquipmentName'
      Visible = False
      Size = 100
    end
    object qryPOLinesProcTreeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcTreeId'
      Visible = False
    end
    object qryPOLinesSupplierProductCode: TWideStringField
      DisplayWidth = 50
      FieldName = 'SupplierProductCode'
      Visible = False
      Size = 50
    end
    object qryPOLinesSupplierProductName: TWideStringField
      DisplayWidth = 50
      FieldName = 'SupplierProductName'
      Visible = False
      Size = 50
    end
    object qryPOLinesRALineRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'RALineRef'
      Visible = False
      Size = 255
    end
    object qryPOLinesPrintedValue: TFloatField
      DisplayWidth = 10
      FieldName = 'PrintedValue'
      Visible = False
    end
    object qryPOLinesDiscountPercent: TFloatField
      DisplayWidth = 10
      FieldName = 'DiscountPercent'
      Visible = False
    end
    object qryPOLinesDiscountAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'DiscountAmount'
      Visible = False
    end
    object qryPOLinesOriginalCost: TFloatField
      DisplayWidth = 10
      FieldName = 'OriginalCost'
      Visible = False
    end
    object qryPOLinesMatrixDesc: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixDesc'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryPOLinesMatrixRef: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryPOLinesMatrixPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'MatrixPrice'
      Visible = False
    end
    object qryPOLinesSmartOrderID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SmartOrderID'
      Visible = False
    end
    object qryPOLinesSmartOrderLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SmartOrderLineID'
      Visible = False
    end
    object qryPOLinesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryPOLinesformulaId: TIntegerField
      DisplayWidth = 10
      FieldName = 'formulaId'
      Visible = False
    end
    object qryPOLinesFormulaName: TWideStringField
      DisplayWidth = 255
      FieldName = 'FormulaName'
      Visible = False
      Size = 255
    end
    object qryPOLinesFormulaQtySoldValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue1'
      Visible = False
    end
    object qryPOLinesFormulaQtySoldValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue2'
      Visible = False
    end
    object qryPOLinesFormulaQtySoldValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue3'
      Visible = False
    end
    object qryPOLinesFormulaQtySoldValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue4'
      Visible = False
    end
    object qryPOLinesFormulaQtySoldValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue5'
      Visible = False
    end
    object qryPOLinesFormulaQtySoldValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue'
      Visible = False
    end
    object qryPOLinesFormulaQtyShippedValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue1'
      Visible = False
    end
    object qryPOLinesFormulaQtyShippedValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue2'
      Visible = False
    end
    object qryPOLinesFormulaQtyShippedValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue3'
      Visible = False
    end
    object qryPOLinesFormulaQtyShippedValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue4'
      Visible = False
    end
    object qryPOLinesFormulaQtyShippedValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue5'
      Visible = False
    end
    object qryPOLinesFormulaQtyShippedValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue'
      Visible = False
    end
    object qryPOLinesEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryPOLinesEmployeeName: TWideStringField
      DisplayWidth = 100
      FieldName = 'EmployeeName'
      Visible = False
      Size = 100
    end
    object qryPOLinesAreaCode: TWideStringField
      DisplayWidth = 50
      FieldName = 'AreaCode'
      Visible = False
      Size = 50
    end
    object qryPOLinesLinesOrder: TIntegerField
      DisplayWidth = 10
      FieldName = 'LinesOrder'
      Visible = False
    end
    object qryPOLinesExpenseProductID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ExpenseProductID'
      Visible = False
    end
    object qryPOLinesExpenseProductName: TWideStringField
      DisplayWidth = 100
      FieldName = 'ExpenseProductName'
      Visible = False
      Size = 100
    end
    object qryPOLinesGeneralNotes: TWideMemoField
      DisplayWidth = 10
      FieldName = 'GeneralNotes'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryPOLinesBoxesReceived: TIntegerField
      DisplayWidth = 10
      FieldName = 'BoxesReceived'
      Visible = False
    end
    object qryPOLinesBoxesOrdered: TIntegerField
      DisplayWidth = 10
      FieldName = 'BoxesOrdered'
      Visible = False
    end
    object qryPOLinesLineTaxRate: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTaxRate'
      Visible = False
    end
    object qryPOLinesPurchaseLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PurchaseLineID'
      Visible = False
    end
    object qryPOLinesSEQNo: TIntegerField
      DisplayWidth = 10
      FieldName = 'SEQNo'
      Visible = False
    end
    object qryPOLinesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPOLinesPurchaseOrderID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PurchaseOrderID'
      Visible = False
    end
    object qryPOLinesBaseLineno: TIntegerField
      DisplayWidth = 10
      FieldName = 'BaseLineno'
      Visible = False
    end
    object qryPOLinesPARTTYPE: TWideStringField
      DisplayLabel = 'Product Type'
      DisplayWidth = 13
      FieldName = 'PARTTYPE'
      Visible = False
      Size = 13
    end
    object qryPOLinesINCOMEACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'INCOMEACCNT'
      Visible = False
      Size = 50
    end
    object qryPOLinesASSETACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'ASSETACCNT'
      Visible = False
      Size = 50
    end
    object qryPOLinesCOGSACCNT: TWideStringField
      DisplayWidth = 50
      FieldName = 'COGSACCNT'
      Visible = False
      Size = 50
    end
    object qryPOLinesProductGroup: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProductGroup'
      Visible = False
      Size = 255
    end
    object qryPOLinesProductName: TWideStringField
      DisplayWidth = 60
      FieldName = 'ProductName'
      Visible = False
      Size = 60
    end
    object qryPOLinesPartBarcode: TWideStringField
      DisplayWidth = 255
      FieldName = 'PartBarcode'
      Visible = False
      Size = 255
    end
    object qryPOLinesAccountNumber: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountNumber'
      Visible = False
      Size = 50
    end
    object qryPOLinesAccountName: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountName'
      Visible = False
      Size = 50
    end
    object qryPOLinesAccountGroup: TWideStringField
      DisplayWidth = 255
      FieldName = 'AccountGroup'
      Visible = False
      Size = 255
    end
    object qryPOLinesAvgCost: TFloatField
      DisplayWidth = 10
      FieldName = 'AvgCost'
      Visible = False
    end
    object qryPOLinesStandardCost: TFloatField
      DisplayWidth = 10
      FieldName = 'StandardCost'
      Visible = False
    end
    object qryPOLinesLineCostInc: TFloatField
      DisplayWidth = 10
      FieldName = 'LineCostInc'
      Visible = False
    end
    object qryPOLinesLineTaxCode: TWideStringField
      DisplayWidth = 15
      FieldName = 'LineTaxCode'
      Visible = False
      Size = 15
    end
    object qryPOLinesLineTax: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTax'
      Visible = False
    end
    object qryPOLinesQtySold: TFloatField
      DisplayWidth = 10
      FieldName = 'QtySold'
      Visible = False
    end
  end
  object qryGoodsReceiptLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblGoodsReceiptLines')
    OnCalcFields = qryGoodsReceiptLinesCalcFields
    Left = 816
    Top = 240
    object qryGoodsReceiptLinesProductName: TStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 30
      FieldKind = fkCalculated
      FieldName = 'ProductName'
      Size = 255
      Calculated = True
    end
    object qryGoodsReceiptLinesQuantityReceived: TFloatField
      DisplayLabel = 'Qty Received'
      DisplayWidth = 10
      FieldName = 'QuantityReceived'
    end
    object qryGoodsReceiptLinesSerialNumber: TWideStringField
      DisplayLabel = 'Serial Number'
      DisplayWidth = 10
      FieldName = 'SerialNumber'
      Size = 100
    end
    object qryGoodsReceiptLinesBatchNumber: TWideStringField
      DisplayLabel = 'Batch Number'
      DisplayWidth = 10
      FieldName = 'BatchNumber'
      Visible = False
      Size = 100
    end
    object qryGoodsReceiptLinesBatchExpiryDate: TDateTimeField
      DisplayLabel = 'Batch Expiry'
      DisplayWidth = 18
      FieldName = 'BatchExpiryDate'
      Visible = False
    end
    object qryGoodsReceiptLinesBinID: TIntegerField
      DisplayLabel = 'Bin ID'
      DisplayWidth = 10
      FieldName = 'BinID'
      Visible = False
    end
    object qryGoodsReceiptLinesDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryGoodsReceiptLinesGlobalRef: TWideStringField
      DisplayLabel = 'Global Ref'
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryGoodsReceiptLinesID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
    object qryGoodsReceiptLinesMasterID: TIntegerField
      DisplayLabel = 'Master ID'
      DisplayWidth = 10
      FieldName = 'MasterID'
      Visible = False
    end
    object qryGoodsReceiptLinesPurchaseLineID: TIntegerField
      DisplayLabel = 'Purchase Line ID'
      DisplayWidth = 10
      FieldName = 'PurchaseLineID'
      Visible = False
    end
    object qryGoodsReceiptLinesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object qryGoodsReceiptLinesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object qryGoodsReceipt: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblGoodsReceipt')
    Left = 648
    Top = 224
    object qryGoodsReceiptGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryGoodsReceiptID: TIntegerField
      FieldName = 'ID'
    end
    object qryGoodsReceiptEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryGoodsReceiptPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
    end
    object qryGoodsReceiptReceiptStartTime: TDateTimeField
      FieldName = 'ReceiptStartTime'
    end
    object qryGoodsReceiptReceiptEndTime: TDateTimeField
      FieldName = 'ReceiptEndTime'
    end
    object qryGoodsReceiptActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryGoodsReceiptProcessed: TWideStringField
      FieldName = 'Processed'
      FixedChar = True
      Size = 1
    end
    object qryGoodsReceiptmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryGoodsReceiptmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object dsPOLines: TDataSource
    DataSet = qryPOLines
    Left = 872
    Top = 408
  end
  object dsGoodsReceiptLines: TDataSource
    DataSet = qryGoodsReceiptLines
    Left = 816
    Top = 192
  end
  object dsGoodsReceipt: TDataSource
    DataSet = qryGoodsReceipt
    Left = 648
    Top = 184
  end
  object qryProduct: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select tblparts.*, tblPartsPics.* from tblparts '
      
        'left join tblPartsPics on tblPartsPics.PartID = tblParts.PartsID' +
        ' and tblpartspics.isDefault = "T"'
      'where tblParts.PartsID = :ProductID')
    Left = 856
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProductID'
      end>
  end
  object qryPOLinesLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select * from tblpurchaseLines where PurchaseOrderID = :Purchase' +
        'OrderID')
    BeforeOpen = qryPOLinesLookupBeforeOpen
    AfterOpen = qryPOLinesAfterOpen
    Left = 648
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PurchaseOrderID'
      end>
    object WideStringField1: TWideStringField
      DisplayLabel = 'Product Print Name'
      DisplayWidth = 20
      FieldName = 'ProductPrintName'
      Size = 255
    end
    object WideStringField2: TWideStringField
      DisplayWidth = 20
      FieldName = 'Product_Description'
      Size = 255
    end
    object FloatField1: TFloatField
      DisplayLabel = 'UOM Qty Ordered'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureQtySold'
    end
    object FloatField2: TFloatField
      DisplayLabel = 'UOM Qty Received'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureShipped'
    end
    object FloatField3: TFloatField
      DisplayLabel = 'UOM Backorder'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureBackorder'
    end
    object WideStringField3: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 10
      FieldName = 'UnitofMeasurePOLines'
      Size = 255
    end
    object IntegerField1: TIntegerField
      DisplayLabel = 'Produc tID'
      DisplayWidth = 10
      FieldName = 'ProductID'
      Visible = False
    end
    object FloatField4: TFloatField
      DisplayWidth = 10
      FieldName = 'LineCost'
      Visible = False
    end
    object FloatField5: TFloatField
      DisplayWidth = 10
      FieldName = 'Shipped'
      Visible = False
    end
    object FloatField6: TFloatField
      DisplayWidth = 10
      FieldName = 'BackOrder'
      Visible = False
    end
    object IntegerField2: TIntegerField
      DisplayWidth = 10
      FieldName = 'UnitOfMeasureID'
      Visible = False
    end
    object FloatField7: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitofMeasureMultiplier'
      Visible = False
    end
    object WideStringField4: TWideStringField
      DisplayWidth = 1
      FieldName = 'Invoiced'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object IntegerField3: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object WideStringField5: TWideStringField
      DisplayWidth = 255
      FieldName = 'Class'
      Visible = False
      Size = 255
    end
    object WideStringField6: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomerJob'
      Visible = False
      Size = 255
    end
    object WideStringField7: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomerPrintJob'
      Visible = False
      Size = 255
    end
    object IntegerField4: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerJobID'
      Visible = False
    end
    object FloatField8: TFloatField
      DisplayWidth = 10
      FieldName = 'RAQty'
      Visible = False
    end
    object WideStringField8: TWideStringField
      DisplayWidth = 255
      FieldName = 'RAstatus'
      Visible = False
      Size = 255
    end
    object WideStringField9: TWideStringField
      DisplayWidth = 9
      FieldName = 'Batch'
      Visible = False
      Size = 9
    end
    object WideStringField10: TWideStringField
      DisplayWidth = 1
      FieldName = 'UseTimecost'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object IntegerField5: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleID_Timecost'
      Visible = False
    end
    object FloatField9: TFloatField
      DisplayWidth = 10
      FieldName = 'TimecostMarkupPer'
      Visible = False
    end
    object FloatField10: TFloatField
      DisplayWidth = 10
      FieldName = 'TimecostPrice'
      Visible = False
    end
    object FloatField11: TFloatField
      DisplayWidth = 10
      FieldName = 'TimecostMarkupDol'
      Visible = False
    end
    object WideMemoField1: TWideMemoField
      DisplayWidth = 10
      FieldName = 'serialno'
      Visible = False
      BlobType = ftWideMemo
    end
    object FloatField12: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalLineAmount'
      Visible = False
    end
    object FloatField13: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalLineAmountInc'
      Visible = False
    end
    object FloatField14: TFloatField
      DisplayWidth = 10
      FieldName = 'COGSTotalLineAmount'
      Visible = False
    end
    object FloatField15: TFloatField
      DisplayWidth = 10
      FieldName = 'COGSTotalLineAmountInc'
      Visible = False
    end
    object WideStringField11: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object WideStringField12: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object WideStringField13: TWideStringField
      DisplayWidth = 11
      FieldName = 'RAInvoiceNo'
      Visible = False
      Size = 11
    end
    object FloatField16: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1Purchase'
      Visible = False
    end
    object FloatField17: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib2Purchase'
      Visible = False
    end
    object FloatField18: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1PurchaseRate'
      Visible = False
    end
    object FloatField19: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib1PurchaseEst'
      Visible = False
    end
    object FloatField20: TFloatField
      DisplayWidth = 10
      FieldName = 'Attrib2PurchaseEst'
      Visible = False
    end
    object IntegerField6: TIntegerField
      DisplayWidth = 10
      FieldName = 'LastLineID'
      Visible = False
    end
    object WideStringField14: TWideStringField
      DisplayWidth = 1
      FieldName = 'RelatedPOIDUsed'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object IntegerField7: TIntegerField
      DisplayWidth = 10
      FieldName = 'RelatedPOID'
      Visible = False
    end
    object FloatField21: TFloatField
      DisplayWidth = 10
      FieldName = 'LandedCostsPerItem'
      Visible = False
    end
    object FloatField22: TFloatField
      DisplayWidth = 10
      FieldName = 'LandedCostsPercentage'
      Visible = False
    end
    object FloatField23: TFloatField
      DisplayWidth = 10
      FieldName = 'LandedCostsTotal'
      Visible = False
    end
    object FloatField24: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignExchangeRate'
      Visible = False
    end
    object WideStringField15: TWideStringField
      DisplayWidth = 3
      FieldName = 'ForeignExchangeCode'
      Visible = False
      FixedChar = True
      Size = 3
    end
    object FloatField25: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignCurrencyLineCost'
      Visible = False
    end
    object FloatField26: TFloatField
      DisplayWidth = 10
      FieldName = 'ForeignTotalLineAmount'
      Visible = False
    end
    object WideStringField16: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib1'
      Visible = False
      Size = 255
    end
    object WideStringField17: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib2'
      Visible = False
      Size = 255
    end
    object WideStringField18: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib3'
      Visible = False
      Size = 255
    end
    object WideStringField19: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib4'
      Visible = False
      Size = 255
    end
    object WideStringField20: TWideStringField
      DisplayWidth = 255
      FieldName = 'DescAttrib5'
      Visible = False
      Size = 255
    end
    object WideStringField21: TWideStringField
      DisplayWidth = 255
      FieldName = 'SearchFilter'
      Visible = False
      Size = 255
    end
    object WideStringField22: TWideStringField
      DisplayWidth = 255
      FieldName = 'SearchFilterCopy'
      Visible = False
      Size = 255
    end
    object DateTimeField1: TDateTimeField
      DisplayWidth = 18
      FieldName = 'ReceivedDate'
      Visible = False
    end
    object IntegerField8: TIntegerField
      DisplayWidth = 10
      FieldName = 'CostCentreId'
      Visible = False
    end
    object DateTimeField2: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object WideStringField23: TWideStringField
      DisplayWidth = 255
      FieldName = 'DocketNumber'
      Visible = False
      Size = 255
    end
    object IntegerField9: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartSpecID'
      Visible = False
    end
    object WideStringField24: TWideStringField
      DisplayWidth = 255
      FieldName = 'SpecDescription'
      Visible = False
      Size = 255
    end
    object FloatField27: TFloatField
      DisplayWidth = 10
      FieldName = 'SpecValue'
      Visible = False
    end
    object FloatField28: TFloatField
      DisplayWidth = 10
      FieldName = 'NewForeignExchangeRate'
      Visible = False
    end
    object DateField1: TDateField
      DisplayWidth = 10
      FieldName = 'ETADate'
      Visible = False
    end
    object WideStringField25: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField1'
      Visible = False
      Size = 255
    end
    object WideStringField26: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField2'
      Visible = False
      Size = 255
    end
    object WideStringField27: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField3'
      Visible = False
      Size = 255
    end
    object WideStringField28: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField4'
      Visible = False
      Size = 255
    end
    object WideStringField29: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField5'
      Visible = False
      Size = 255
    end
    object WideStringField30: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField6'
      Visible = False
      Size = 255
    end
    object WideStringField31: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField7'
      Visible = False
      Size = 255
    end
    object WideStringField32: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField8'
      Visible = False
      Size = 255
    end
    object WideStringField33: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField9'
      Visible = False
      Size = 255
    end
    object WideStringField34: TWideStringField
      DisplayWidth = 255
      FieldName = 'CustomField10'
      Visible = False
      Size = 255
    end
    object WideMemoField2: TWideMemoField
      DisplayWidth = 10
      FieldName = 'LineNotes'
      Visible = False
      BlobType = ftWideMemo
    end
    object IntegerField10: TIntegerField
      DisplayWidth = 10
      FieldName = 'INCOMEACCNTID'
      Visible = False
    end
    object IntegerField11: TIntegerField
      DisplayWidth = 10
      FieldName = 'ASSETACCNTID'
      Visible = False
    end
    object IntegerField12: TIntegerField
      DisplayWidth = 10
      FieldName = 'COGSACCNTID'
      Visible = False
    end
    object IntegerField13: TIntegerField
      DisplayWidth = 10
      FieldName = 'SortID'
      Visible = False
    end
    object WideMemoField3: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MemoLine'
      Visible = False
      BlobType = ftWideMemo
    end
    object IntegerField14: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      Visible = False
    end
    object IntegerField15: TIntegerField
      DisplayWidth = 10
      FieldName = 'RelatedShipContainerID'
      Visible = False
    end
    object WideStringField35: TWideStringField
      DisplayWidth = 1
      FieldName = 'RelatedShipContainerIDUsed'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object IntegerField16: TIntegerField
      DisplayWidth = 10
      FieldName = 'RepairId'
      Visible = False
    end
    object IntegerField17: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerEquipmentID'
      Visible = False
    end
    object WideStringField36: TWideStringField
      DisplayWidth = 100
      FieldName = 'EquipmentName'
      Visible = False
      Size = 100
    end
    object IntegerField18: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcTreeId'
      Visible = False
    end
    object WideStringField37: TWideStringField
      DisplayWidth = 50
      FieldName = 'SupplierProductCode'
      Visible = False
      Size = 50
    end
    object WideStringField38: TWideStringField
      DisplayWidth = 50
      FieldName = 'SupplierProductName'
      Visible = False
      Size = 50
    end
    object WideStringField39: TWideStringField
      DisplayWidth = 255
      FieldName = 'RALineRef'
      Visible = False
      Size = 255
    end
    object FloatField29: TFloatField
      DisplayWidth = 10
      FieldName = 'PrintedValue'
      Visible = False
    end
    object FloatField30: TFloatField
      DisplayWidth = 10
      FieldName = 'DiscountPercent'
      Visible = False
    end
    object FloatField31: TFloatField
      DisplayWidth = 10
      FieldName = 'DiscountAmount'
      Visible = False
    end
    object FloatField32: TFloatField
      DisplayWidth = 10
      FieldName = 'OriginalCost'
      Visible = False
    end
    object WideMemoField4: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixDesc'
      Visible = False
      BlobType = ftWideMemo
    end
    object WideMemoField5: TWideMemoField
      DisplayWidth = 10
      FieldName = 'MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object FloatField33: TFloatField
      DisplayWidth = 10
      FieldName = 'MatrixPrice'
      Visible = False
    end
    object IntegerField19: TIntegerField
      DisplayWidth = 10
      FieldName = 'SmartOrderID'
      Visible = False
    end
    object IntegerField20: TIntegerField
      DisplayWidth = 10
      FieldName = 'SmartOrderLineID'
      Visible = False
    end
    object WideStringField40: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object IntegerField21: TIntegerField
      DisplayWidth = 10
      FieldName = 'formulaId'
      Visible = False
    end
    object WideStringField41: TWideStringField
      DisplayWidth = 255
      FieldName = 'FormulaName'
      Visible = False
      Size = 255
    end
    object FloatField34: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue1'
      Visible = False
    end
    object FloatField35: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue2'
      Visible = False
    end
    object FloatField36: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue3'
      Visible = False
    end
    object FloatField37: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue4'
      Visible = False
    end
    object FloatField38: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue5'
      Visible = False
    end
    object FloatField39: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtySoldValue'
      Visible = False
    end
    object FloatField40: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue1'
      Visible = False
    end
    object FloatField41: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue2'
      Visible = False
    end
    object FloatField42: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue3'
      Visible = False
    end
    object FloatField43: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue4'
      Visible = False
    end
    object FloatField44: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue5'
      Visible = False
    end
    object FloatField45: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyShippedValue'
      Visible = False
    end
    object IntegerField22: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
    object WideStringField42: TWideStringField
      DisplayWidth = 100
      FieldName = 'EmployeeName'
      Visible = False
      Size = 100
    end
    object WideStringField43: TWideStringField
      DisplayWidth = 50
      FieldName = 'AreaCode'
      Visible = False
      Size = 50
    end
    object IntegerField23: TIntegerField
      DisplayWidth = 10
      FieldName = 'LinesOrder'
      Visible = False
    end
    object IntegerField24: TIntegerField
      DisplayWidth = 10
      FieldName = 'ExpenseProductID'
      Visible = False
    end
    object WideStringField44: TWideStringField
      DisplayWidth = 100
      FieldName = 'ExpenseProductName'
      Visible = False
      Size = 100
    end
    object WideMemoField6: TWideMemoField
      DisplayWidth = 10
      FieldName = 'GeneralNotes'
      Visible = False
      BlobType = ftWideMemo
    end
    object IntegerField25: TIntegerField
      DisplayWidth = 10
      FieldName = 'BoxesReceived'
      Visible = False
    end
    object IntegerField26: TIntegerField
      DisplayWidth = 10
      FieldName = 'BoxesOrdered'
      Visible = False
    end
    object FloatField46: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTaxRate'
      Visible = False
    end
    object IntegerField27: TIntegerField
      DisplayWidth = 10
      FieldName = 'PurchaseLineID'
      Visible = False
    end
    object IntegerField28: TIntegerField
      DisplayWidth = 10
      FieldName = 'SEQNo'
      Visible = False
    end
    object WideStringField45: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object IntegerField29: TIntegerField
      DisplayWidth = 10
      FieldName = 'PurchaseOrderID'
      Visible = False
    end
    object IntegerField30: TIntegerField
      DisplayWidth = 10
      FieldName = 'BaseLineno'
      Visible = False
    end
    object WideStringField46: TWideStringField
      DisplayLabel = 'Product Type'
      DisplayWidth = 13
      FieldName = 'PARTTYPE'
      Visible = False
      Size = 13
    end
    object WideStringField47: TWideStringField
      DisplayWidth = 50
      FieldName = 'INCOMEACCNT'
      Visible = False
      Size = 50
    end
    object WideStringField48: TWideStringField
      DisplayWidth = 50
      FieldName = 'ASSETACCNT'
      Visible = False
      Size = 50
    end
    object WideStringField49: TWideStringField
      DisplayWidth = 50
      FieldName = 'COGSACCNT'
      Visible = False
      Size = 50
    end
    object WideStringField50: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProductGroup'
      Visible = False
      Size = 255
    end
    object WideStringField51: TWideStringField
      DisplayWidth = 60
      FieldName = 'ProductName'
      Visible = False
      Size = 60
    end
    object WideStringField52: TWideStringField
      DisplayWidth = 255
      FieldName = 'PartBarcode'
      Visible = False
      Size = 255
    end
    object WideStringField53: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountNumber'
      Visible = False
      Size = 50
    end
    object WideStringField54: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountName'
      Visible = False
      Size = 50
    end
    object WideStringField55: TWideStringField
      DisplayWidth = 255
      FieldName = 'AccountGroup'
      Visible = False
      Size = 255
    end
    object FloatField47: TFloatField
      DisplayWidth = 10
      FieldName = 'AvgCost'
      Visible = False
    end
    object FloatField48: TFloatField
      DisplayWidth = 10
      FieldName = 'StandardCost'
      Visible = False
    end
    object FloatField49: TFloatField
      DisplayWidth = 10
      FieldName = 'LineCostInc'
      Visible = False
    end
    object WideStringField56: TWideStringField
      DisplayWidth = 15
      FieldName = 'LineTaxCode'
      Visible = False
      Size = 15
    end
    object FloatField50: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTax'
      Visible = False
    end
    object FloatField51: TFloatField
      DisplayWidth = 10
      FieldName = 'QtySold'
      Visible = False
    end
  end
end
