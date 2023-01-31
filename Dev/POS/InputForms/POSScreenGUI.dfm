inherited POSScreenForm: TPOSScreenForm
  Left = 312
  Top = 213
  HelpContext = 432000
  Caption = 'POSScreenForm'
  ClientHeight = 699
  ClientWidth = 1008
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  ExplicitLeft = 312
  ExplicitTop = 213
  ExplicitWidth = 1024
  ExplicitHeight = 738
  DesignSize = (
    1008
    699)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel6: TBevel [0]
    Left = 8
    Top = 570
    Width = 377
    Height = 113
    HelpContext = 432003
    Anchors = [akLeft, akRight, akBottom]
  end
  object lblMemoText: TLabel [1]
    Left = 10
    Top = 585
    Width = 180
    Height = 89
    HelpContext = 432002
    Anchors = [akLeft, akBottom]
    AutoSize = False
    Caption = 'lblMemoText'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object lblSubLabel: TLabel [2]
    Left = 455
    Top = 598
    Width = 143
    Height = 41
    HelpContext = 432004
    Anchors = [akRight, akBottom]
    Caption = 'SubTotal'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblDefaultFont: TLabel [3]
    Left = 530
    Top = 563
    Width = 75
    Height = 14
    HelpContext = 432005
    Anchors = [akRight, akBottom]
    Caption = 'lblDefaultFont'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object lblOnHold: TLabel [4]
    Left = 912
    Top = 160
    Width = 83
    Height = 15
    HelpContext = 432006
    Caption = 'Interrupt Mode'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  inherited lblSkingroupMsg: TLabel
    Top = 699
    Width = 1008
    HelpContext = 432078
    ExplicitTop = 680
    ExplicitWidth = 1008
  end
  object lblSplit: TLabel [6]
    Left = 518
    Top = 599
    Width = 82
    Height = 29
    HelpContext = 432007
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'lblSplit'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object lblSplitLabel: TLabel [7]
    Left = 451
    Top = 570
    Width = 151
    Height = 29
    HelpContext = 432008
    Anchors = [akRight, akBottom]
    Caption = 'Split Balance'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblLineDetails: TLabel [8]
    Left = 190
    Top = 570
    Width = 186
    Height = 113
    HelpContext = 432079
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited imgGridWatermark: TImage
    Left = 160
    HelpContext = 432001
    ExplicitLeft = 160
  end
  object lblTotalQuantity: TLabel [11]
    Left = 31
    Top = 570
    Width = 100
    Height = 16
    HelpContext = 432057
    Anchors = [akLeft, akBottom]
    Caption = 'lblTotalQuantity'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object edtClientID: TEdit [14]
    Left = 464
    Top = 489
    Width = 49
    Height = 21
    HelpContext = 432023
    TabStop = False
    Enabled = False
    ReadOnly = True
    TabOrder = 1
    Text = 'edtClientID'
    Visible = False
    OnChange = edtClientIDChange
  end
  object edtPartID: TEdit [15]
    Left = 464
    Top = 465
    Width = 41
    Height = 21
    HelpContext = 432080
    TabStop = False
    Enabled = False
    ReadOnly = True
    TabOrder = 0
    Text = 'edtPartID'
    Visible = False
    OnChange = edtPartIDChange
  end
  object edtLaybyID: TEdit [16]
    Left = 475
    Top = 514
    Width = 33
    Height = 21
    HelpContext = 432025
    Enabled = False
    TabOrder = 7
    Text = 'edtLaybyID'
    Visible = False
    OnChange = edtLaybyIDChange
  end
  object edtReceipt: TMemo [17]
    Left = 280
    Top = 314
    Width = 121
    Height = 25
    HelpContext = 432026
    Lines.Strings = (
      'edtReceipt')
    TabOrder = 11
    Visible = False
    WordWrap = False
  end
  object pnlImage1: TDNMPanel [18]
    Left = 8
    Top = 1
    Width = 187
    Height = 162
    HelpContext = 432028
    Caption = 'pnlImage1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    Visible = False
    object Image1: TImage
      Left = 1
      Top = 2
      Width = 185
      Height = 160
      HelpContext = 432029
      Enabled = False
      Stretch = True
    end
  end
  object pnlPOSBtns: TDNMPanel [19]
    Left = 608
    Top = 321
    Width = 390
    Height = 353
    HelpContext = 432031
    Anchors = [akTop, akRight, akBottom]
    BevelOuter = bvLowered
    Color = 15722703
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = pnlPOSBtnsClick
    Transparent = False
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 388
      Height = 351
      HelpContext = 432061
      Align = alClient
      Caption = 
        'tblsales.POS    = "F" : EOP Done   tblsales.IsPOS = "T" :POS Tra' +
        'nsaction '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
      ExplicitWidth = 384
      ExplicitHeight = 87
    end
  end
  object pnlFnKeyBtns: TDNMPanel [20]
    Left = 608
    Top = 174
    Width = 390
    Height = 136
    HelpContext = 432032
    Anchors = [akTop, akRight]
    BevelOuter = bvLowered
    Color = 15722703
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = pnlFnKeyBtnsClick
    Transparent = False
  end
  object btnKeyPad: TDNMSpeedButton [21]
    Left = 390
    Top = 571
    Width = 60
    Height = 49
    HelpContext = 432049
    Anchors = [akRight, akBottom]
    Caption = 'Numeric Key Pad'
    Color = 14810111
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackColor = clBtnShadow
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    ParentColor = False
    ParentFont = False
    SlowDecease = True
    Style = bsModern
    TabOrder = 10
    WordWrap = True
    AutoDisableParentOnclick = True
    OnClick = btnKeyPadClick
  end
  object Bevel5: TShader [22]
    Left = 8
    Top = 174
    Width = 593
    Height = 75
    HelpContext = 432050
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    TabOrder = 14
    FromColor = 15722703
    ToColor = clWhite
    FromColorMirror = clWhite
    ToColorMirror = 15722703
    Direction = False
    Version = '1.4.0.0'
    object Bevel1: TBevel
      Left = 65
      Top = 7
      Width = 129
      Height = 25
      HelpContext = 432051
    end
    object Bevel2: TBevel
      Left = 208
      Top = 39
      Width = 130
      Height = 25
      HelpContext = 432052
    end
    object Bevel3: TBevel
      Left = 417
      Top = 7
      Width = 161
      Height = 25
      HelpContext = 432053
    end
    object Bevel4: TBevel
      Left = 433
      Top = 39
      Width = 145
      Height = 25
      HelpContext = 432054
    end
    object Label9: TLabel
      Left = 9
      Top = 12
      Width = 54
      Height = 16
      HelpContext = 432055
      Caption = 'Sale No.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 169
      Top = 44
      Width = 34
      Height = 16
      HelpContext = 432056
      Caption = 'Store'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label11: TLabel
      Left = 381
      Top = 12
      Width = 29
      Height = 16
      HelpContext = 432081
      Caption = 'Date'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label12: TLabel
      Left = 349
      Top = 44
      Width = 77
      Height = 16
      HelpContext = 432058
      Caption = 'Sale Person'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblStore: TLabel
      Left = 216
      Top = 44
      Width = 42
      Height = 15
      HelpContext = 432059
      Caption = 'lblStore'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblSalesPerson: TLabel
      Left = 441
      Top = 44
      Width = 85
      Height = 15
      HelpContext = 432060
      Caption = 'lblSalesPerson'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblSaleNo: TLabel
      Left = 73
      Top = 12
      Width = 54
      Height = 15
      HelpContext = 432093
      Caption = 'lblSaleNo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblDate: TLabel
      Left = 425
      Top = 13
      Width = 39
      Height = 15
      HelpContext = 432062
      Caption = 'lblDate'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblTime: TLabel
      Left = 505
      Top = 13
      Width = 41
      Height = 15
      HelpContext = 432063
      Caption = 'lblTime'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblTillHead: TLabel
      Left = 201
      Top = 12
      Width = 16
      Height = 15
      HelpContext = 432064
      Caption = 'Till'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel7: TBevel
      Left = 222
      Top = 6
      Width = 148
      Height = 25
      HelpContext = 432065
    end
    object lblTillName: TLabel
      Left = 228
      Top = 12
      Width = 63
      Height = 15
      HelpContext = 432066
      Caption = 'lblTillName'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 9
      Top = 44
      Width = 95
      Height = 16
      HelpContext = 432067
      Caption = 'Receipt Printer'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel8: TBevel
      Left = 108
      Top = 39
      Width = 54
      Height = 25
      HelpContext = 432068
    end
    object lblPrn: TLabel
      Left = 112
      Top = 44
      Width = 32
      Height = 15
      HelpContext = 432069
      Caption = 'lblPrn'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object pnlCustomer: TShader [23]
    Left = 8
    Top = 253
    Width = 593
    Height = 25
    HelpContext = 432070
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsSingle
    Color = 15722703
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    FromColor = 15722703
    ToColor = clWhite
    FromColorMirror = clWhite
    ToColorMirror = 15722703
    Direction = False
    Version = '1.4.0.0'
    object Label6: TLabel
      Left = 6
      Top = 4
      Width = 56
      Height = 15
      HelpContext = 432071
      Caption = 'Customer'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblCustomer: TLabel
      Left = 68
      Top = 4
      Width = 227
      Height = 15
      HelpContext = 432072
      AutoSize = False
      Caption = 'lblCustomer'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 283
      Top = 4
      Width = 90
      Height = 15
      HelpContext = 432073
      Alignment = taRightJustify
      Caption = 'Customer Disc: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblCustDisc: TLabel
      Left = 372
      Top = 4
      Width = 46
      Height = 15
      HelpContext = 432074
      AutoSize = False
      Caption = 'lblCustDisc'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 494
      Top = 4
      Width = 55
      Height = 15
      HelpContext = 432075
      Caption = '(Included)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object lblSpecDisc: TLabel
      Left = 541
      Top = 4
      Width = 46
      Height = 15
      HelpContext = 432076
      AutoSize = False
      Caption = 'lblSpecDisc'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object lblTotCustDisc: TLabel
      Left = 428
      Top = 4
      Width = 59
      Height = 15
      HelpContext = 432077
      AutoSize = False
      Caption = 'lblCustDisc'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
  end
  object pnlNumericKeyPad: TDNMPanel [24]
    Left = 68
    Top = 592
    Width = 377
    Height = 113
    HelpContext = 432033
    Anchors = [akLeft, akRight, akBottom]
    Color = 15722703
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    Visible = False
    OnClick = pnlNumericKeyPadClick
    Transparent = False
    object btnNum2: TDNMSpeedButton
      Left = 66
      Top = 6
      Width = 60
      Height = 49
      HelpContext = 432035
      Caption = '2'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 0
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNum3: TDNMSpeedButton
      Left = 127
      Top = 6
      Width = 60
      Height = 49
      HelpContext = 432036
      Caption = '3'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 1
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNum4: TDNMSpeedButton
      Left = 188
      Top = 6
      Width = 60
      Height = 49
      HelpContext = 432037
      Caption = '4'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 2
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNum5: TDNMSpeedButton
      Left = 249
      Top = 6
      Width = 60
      Height = 49
      HelpContext = 432038
      Caption = '5'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 3
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNumDot: TDNMSpeedButton
      Left = 310
      Top = 6
      Width = 60
      Height = 49
      HelpContext = 432039
      Caption = '.'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 4
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNum6: TDNMSpeedButton
      Left = 5
      Top = 57
      Width = 60
      Height = 49
      HelpContext = 432040
      Caption = '6'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 5
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNum7: TDNMSpeedButton
      Left = 66
      Top = 57
      Width = 60
      Height = 49
      HelpContext = 432041
      Caption = '7'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 6
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNum8: TDNMSpeedButton
      Left = 127
      Top = 57
      Width = 60
      Height = 49
      HelpContext = 432042
      Caption = '8'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 7
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNum9: TDNMSpeedButton
      Left = 188
      Top = 57
      Width = 60
      Height = 49
      HelpContext = 432043
      Caption = '9'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 8
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNum0: TDNMSpeedButton
      Left = 249
      Top = 57
      Width = 60
      Height = 49
      HelpContext = 432044
      Caption = '0'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 9
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNumBS: TDNMSpeedButton
      Left = 310
      Top = 57
      Width = 60
      Height = 49
      HelpContext = 432045
      Caption = 'BS'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 10
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
    object btnNum1: TDNMSpeedButton
      Left = 5
      Top = 6
      Width = 60
      Height = 49
      HelpContext = 432034
      Caption = '1'
      Color = 14810111
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 11
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNumPadClick
    end
  end
  object eft: TCsdEft [25]
    Left = 105
    Top = 102
    Width = 32
    Height = 32
    HelpContext = 432030
    OnGetLastTransactionEvent = eftGetLastTransactionEvent
    OnReprintReceiptEvent = eftReprintReceiptEvent
    OnTransactionEvent = eftTransactionEvent
    OnGetLastReceiptEvent = eftGetLastReceiptEvent
    OnPrintReceiptEvent = eftPrintReceiptEvent
    ControlData = {00000100560A00002B05000000000000}
  end
  object pnlVC: TDNMPanel [26]
    Left = 9
    Top = 1
    Width = 989
    Height = 162
    HelpContext = 432014
    Anchors = [akLeft, akTop, akRight]
    Caption = 'pnlVC'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    Visible = False
  end
  object edtPOSMemo: TMemo [27]
    Left = 11
    Top = 6
    Width = 989
    Height = 162
    HelpContext = 432022
    TabStop = False
    Alignment = taRightJustify
    Anchors = [akLeft, akTop, akRight]
    Color = clWhite
    Font.Charset = ARABIC_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Arial'
    Font.Pitch = fpFixed
    Font.Style = []
    Lines.Strings = (
      'Line1'
      'Line2')
    ParentFont = False
    PopupMenu = popCustomiseGrid
    ReadOnly = True
    TabOrder = 3
    WordWrap = False
  end
  object grdTrans: TAdvStringGrid [28]
    Left = 8
    Top = 280
    Width = 594
    Height = 284
    Cursor = crDefault
    HelpContext = 432015
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = clWhite
    ColCount = 8
    DefaultRowHeight = 21
    DrawingStyle = gdsClassic
    FixedColor = clWhite
    FixedCols = 0
    RowCount = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpFixed
    Font.Style = [fsBold]
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    OnDrawCell = grdTransDrawCell
    OnMouseUp = grdTransMouseUp
    OnClickCell = grdTransClickCell
    OnDblClickCell = grdTransDblClickCell
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'MS Sans Serif'
    ActiveCellFont.Style = [fsBold]
    BackGround.Display = bdFixed
    CellNode.ShowTree = False
    CellNode.TreeColor = clSilver
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.ControlStyle = csClassic
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    ControlLook.NoDisabledButtonLook = True
    EnhRowColMove = False
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDownClear = '(All)'
    FixedColWidth = 22
    FixedFont.Charset = ANSI_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Arial'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'MS Sans Serif'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'MS Sans Serif'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'MS Sans Serif'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'MS Sans Serif'
    PrintSettings.FooterFont.Style = []
    PrintSettings.Borders = pbNoborder
    PrintSettings.Centered = False
    PrintSettings.PageNumSep = '/'
    ScrollWidth = 16
    SearchFooter.FindNextCaption = 'Find next'
    SearchFooter.FindPrevCaption = 'Find previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'MS Sans Serif'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurence'
    SearchFooter.HintFindPrev = 'Find previous occurence'
    SearchFooter.HintHighlight = 'Highlight occurences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SelectionColor = clHighlight
    SelectionTextColor = clHighlightText
    ShowSelection = False
    Version = '5.6.0.1'
    WordWrap = False
    ColWidths = (
      22
      55
      276
      376
      115
      115
      64
      64)
    RowHeights = (
      21
      21)
    object imgDelete: TImage
      Left = 2
      Top = 23
      Width = 18
      Height = 18
      HelpContext = 432016
      Picture.Data = {
        07544269746D6170DE010000424DDE0100000000000076000000280000002400
        0000120000000100040000000000680100000000000000000000100000000000
        000000000000000080000080000000808000800000008000800080800000C0C0
        C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
        FF00333333333333333333333333333333333333000033338833333333333333
        333F3333333333330000333911833333983333333388F333333F333300003339
        111833391183333338F38F333F88F33300003339111183911118333338F338F3
        F8338F3300003333911118111118333338F3338F833338F30000333339111111
        11833333338F33383333F8330000333333911111183333333338F333333F8333
        00003333333111118333333333338F3333383333000033333339111183333333
        333338F33383333300003333339111118333333333333833338F333300003333
        391118111833333333338333338F333300003333911183911183333333383338
        F338F333000033339118333911183333338F33838F338F330000333339133333
        91113333338FF83338F338F300003333333333333919333333388333338FFF83
        0000333333333333333333333333333333388833000033333333333333333333
        33333333333333330000}
      Transparent = True
      Visible = False
    end
    object CompletedSmallPic: TImage
      Left = 21
      Top = 146
      Width = 157
      Height = 64
      HelpContext = 432017
      Picture.Data = {
        07544269746D61705A9D0000424D5A9D00000000000036040000280000008A01
        000063000000010008000000000024990000C1990000C1990000000100000000
        000000000000FFFFFF0056524A003A362B00826E2E006A5A2600867232006E5E
        2A006A5A2A0072622E002A261A00EAE6DA006E5E2600A68E3A008E7A3200A28A
        3A00C2A646008A763200CAAE4A00BEA24600B29A4200927E360072622A00C6AA
        4A00A68E3E00C2A64A008E7A3600B69E4600C6AA4E0076662F00D6BE6500433C
        22007A6A2A009A863600BAA2420082722E00C3AA4600A28E3A0076662A00B69E
        4200AB953E00958236009E8A3A007E6E2E00BEA64600CBB24C00C6AE4A00A692
        3E0086763200BAA246009A863A007A6A2E00C2AA4A00CFB75000827232006256
        26005D522400A18E3F008A7A3600BCA64B00C6AE5000AF9A4700C1AA4F00564C
        230085763700D2BA5800665A2B00CBB35600B5A14D00958540006A5E2E007F71
        3800C2AD5700BDA9550082753D00C4B05E00A9975100CBB66300D7C26900B8A6
        5D00DAC670008E814A00AF9F5D00DBC87600DECA7A00D5C27500DECA7E009286
        5300D8C57C00A2955E00D4C48300E1D292003A362600E5D79B008E7E3200AE9A
        3E006A5E26008A7A3200BEAA4600B6A24300B29E420072662A00665A2600BAA6
        4600AE9A42008E7E36006E622A00C2AE4C006A5E2A00B29E470072662F004D45
        20006E622E00433C1D0060562A00776B3500877A3E00D2BD6200332E18002E2A
        16003E381E007A6F3D009A8C4E0037321C006D643800CFBD6D0080754500DACA
        7A00877C4C00DECE7F00524C2F00DACA7E00C1B27100CABC7900DECE8700B4A7
        6E00E0D18D00CBBF8700A1986B0098906800D7CB9400E0D49C00E6DCAA00E7DE
        B300E3DCBB00EEEAD600EAE6D4007E722E00766A2B007A6E2E0029261500645D
        36005A54330049452D00B5AD8000E3D9A400BDB58B00E2DAAA00D6CEA500C9C2
        9B00EAE3BB00EBE5C500EEE9CF00E2DEC600F2EED8006A622F0047422200201E
        1100242215006D684700E7DEA600B1AD9000DAD5B400A8A47E00A29E7A00EEEA
        C900D3D1BE005957430062604B00ABA88700BDBBA1004F4E4400C4C2AD00CCCA
        B5002B2A1B00302F200036352500777554003C3B2D00F2F1DD00E3E2D100E6E5
        D5005D5C3F00EAE9D10025251C002A2A220030302700525246003E3E35005656
        4A00EEEED200EEEED6007373680052524A00EAEAD600ECECDC00F2F2E4005252
        4E00FAFAF300FEFEFA0080817200D6D7C80042433800B4B69A008C8D8200F5F6
        E800EEEFE200DBDCD00034352B0048494100EAEED20056575000ADB29600EAEE
        D60061625C00E4E6DC00B2B5AA0043453E00F4F6EF00EBEDE600262A1E00383A
        34005A5C5600999D9200686A65004A4E46004C4E4A00EEF1EB00C4CBBE00DCE1
        D800E5EAE2004E524C0052565100FAFEF900F6FAF500CAD8C800464C4600A2A4
        A200EEF6F000464E4A0050545400F6FAFA00F4F6F600FEFEFE00FAFAFA000000
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01019F0101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101EF9FFA77DA770077C277F7F5010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101F7770077007777770077007700
        77EE010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101010101E977
        DA60112511251111A56FC2770077FADC01010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101EEA5A5104F352510A525A511A5A5A56F0077E6F5010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101018B57104F108B251111A560
        82608260A560DA77C29F01010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        A48B544F352510A511A511A511A511A5A5A511DA77A78B010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101F54E4F104F2511A58260EA8BE99FD6A58260A511
        8277C2E90101010101010101010101010101019FE9DADAA5DA77F7E9EF010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101AA4E354F101125A5
        A5A525E9A4F5DC8B11A511A510A577DA01010101010101010101010101E9F6A7
        77A777A77700770077DA9FF50101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101F54E4F355711A560A560EAA40101F59FEA60A5045725DA77D6010101
        0101010101010101E977DA60A5251125A560DA7700770077E201010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101F8AA4E358B25A511A511DADA010101A4E9
        25A511A5252525E67701010101010101010101F5A5A5108B352510A525A511A5
        60DA770077EAA401010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101A49F4E4F10
        110482A5A57700010101FC9F576082A5A5104F77C2F5010101010101010101E9
        8B104F10252511A5A56082608260826F0077DAA4010101010101010101010101
        F701010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101AA4E352525A511A511DA7701010101E98BA5A5A5252535A5
        77D60101010101010101019F544F352510A525A525EA8B8B25A511A511DA77DA
        0101010101010101010101F5DADAA5DA9FEE9F01010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101A49F4E4F101160A511A5770001
        0101EF875760A560A5254F25C28B0101010101010101014E4F354F101104A560
        EA8BF59FE911A5041125DA77FA01010101010101010101A4E96F007700770077
        DAEA010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101F8
        AA4E352525A511A525DA7701010101E98BA511A52525351177EA010101010101
        0101A49F4E10101125A511DAA5F501EFDC8B11A5252525DA77F5010101010101
        010101F8AA4E10A56077770077A7010101F8A5EAF5EEA4010101010101010101
        010101010101010101010101010101010101A4F5010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101A49F4E4F25A560A511A577C2010101FC8B5704A560
        A5254F25DA770101010101010101A14E4F358B25A560826FDA010101F54FEA60
        A525576000A5010101010101010101019F544F1011048260C277FC0101A4EA77
        0077C2DADAEAE2F501010101010101010101010101010101010101010101D677
        DADAF79FF7010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101AA4E352525A525A5
        25DA7701010101E98BA511A525253525A5E60101010101010101A49F4E8B10A5
        11A511DA77010101F5E925A511A5102577E6A4010101010101010101AA4E3525
        25A511A56F00010101F89FA560DA7700770077E601010101F5EE010101010101
        01010101010101010101A4A5770077A777DAF6DA9F0101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101A49F4E4F101160A525117700010101F8875760A56011254F3582770101
        010101010101F5544F1025048260A57700010101F58BA560821125108277D601
        01010101010101A4F54E4F101160A560DA77010101A4E94F5725A560DA770077
        FC0101A4DA77DADAF99FE2DC01010101010101010101A1544F118277C2770077
        C2A4010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101F8AA4E352525A511A525DA7701010101E9
        8BA511A52525358B60DA0101010101010101A49F352510A560A511DA77010101
        9F8B11A5A5A5108B25A7E90101010101010101F8AA4E352525A511A577000101
        01019F8B251125A511A56F00010101F84EDA7700770077E6A5EA010101010101
        0101A49F4E101011A5A511E677EF010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101A49F544F25
        A5601125116FC2010101FCF5F54EE98B8B104F10DA770101010101010101A14E
        4F1057A58204A57700010101F58B5760820411101177F9010101010101010101
        9F4E4F25A560A5A5DA77FC0101A49C8BA504A560A504DAA7EF0101019C1011A5
        DA77C2770077FC01010101010101FC9F4F358B25A504116F00A4010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101AA4E352525A5252510DA7701010101F8A4F5A4F5A4F5AA9F
        25E60101010101010101A49F4E2525A511A511DA77010101F58B25A5A5A52525
        10DA77F80101010101010101AA4E352525A525A56F00010101F89F8B25A511A5
        11A560A7010101F89F8B252525A525116FE6A401010101010101A49F542510A5
        11A525DA77EF0101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101A49F4E4F25A560A5258B6FDA01
        01010101010101A4FCA4FCA4A18B0101010101010101F54E4F1011048260A577
        00010101F58BEA60826011104F60C2A401010101010101A4F54E4F251160A504
        DA77FC0101A4E925A511A560A504DA77FC0101A4E98B1125A56011108277EF01
        010101010101A1544F108B258260A57700A40101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101F8
        AA4E352525A5252510DADA010101010101010101010101F8A4F8010101010101
        0101A49F352525A5A5A511DA770101019F8B25A5A5A5252535A577F801010101
        010101F8AA4E352525A511A57700010101F89F8B25A511A525A58200A40101F8
        9F8B25A5A5A51025A5A70101010101010101A49F4E2510A511A511DA77EF0101
        F5FAEADAD2F50101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101A49F4E4F25A56011258B60C2010101010101010101
        0101010101010101010101010101A14E4F1057A58204A57700A40101F58B5760
        A56011104F60C20101010101010101019F4E4F25A560A5A5DA77FC0101A4E98B
        A5048260A504DA77EF010101E92511A5A50457108277FC01010101010101FC4E
        4F105711A560827700A401EA007700000077F99F010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101AA4E352525A52525
        10DA770101010101010101010101010101010101010101010101A49F4E2525A5
        11A511DA77010101F58B25A511A5252535DA77010101010101010101AA4E3525
        25A525A56F00010101F89F8B25A5A5A525A560E6010101F89F8B25A5A5A51025
        A5E6A401010101010101A49F542510A511A5A5DA77E9A50077DA60DA770077DA
        A401010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101A49F4E4F101160A525116FC20101010101010101010101010101010101
        010101010101F5544F1011608260A57700010101F58BEA04826011104F60C201
        01010101010101A4F54E4F25A560A504DA77010101A4E98BA511A560A504DA77
        FC0101A4E98BA504821125108277EF01010101010101A1544F101104A560A560
        C2A7C26F8260A560A560DA77F9A4010101010101010101DCE2F5010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101F8AA4E352525A5111125DA770101010101
        010101010101010101010101010101010101A49F352525A5A5A511DA77010101
        9F8B25A5A5A5252535A5DAF801010101010101F8AA4E352525A511A577000101
        01F89F8B25A511A525A58200010101F89F8B11A5A5A5108BA5E6010101010101
        0101A49F4E2510A511A511A5A5A58BE925A511A511A525DA77F6010101010101
        010101E97700A5F9A5E9F5EE0101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101A49F544F25
        A560A525116FC2010101FCF5F50101010101010101010101010101010101A14E
        4F1057A5A504A57700010101F58B57A5A56011104F60C2010101010101010101
        F54E4F25A560A5A5DA77FC0101A4E98BA5048260A504DAA7EF010101E92511A5
        82258B108277FC01010101010101FC4E4F105711A5608260A58BF5F5F5258260
        A5045725DA77E20101010101010101A48B6FC27700770000DAA5F70101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101AA4E352525A525A525DA77010101A4E677DAA5DAF5EE0101
        01010101010101010101A49F4E2525A511A511DA77010101F58B25A511A52525
        35DA77F80101010101010101AA4E352525A525A56F00010101F89F8B25A5A5A5
        11A560A7010101F89F8B25A5A5A51025A5E6A401010101010101A49F4E2525A5
        11A511A5A5EE01F8A4E925A511A525251100D20101010101010101DCAA4F10A5
        A5DA77777700EA01010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101A49F4E4F251160A52511770001
        0101FC25DA77007700A7DAA5F98B0101010101010101F5544F1011048260A577
        00010101F58BEA60826011104F60C2A401010101010101A4F54E4F101160A504
        DA77FC0101A4E925A560A560A504DA77FC0101A4E98BA50482118B108277EF01
        010101010101A14E4F1011048260A560DAA40101EF8BEA60820411105777EA01
        01010101010101A49F4E4F101160A525A577EA01010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101F8
        AA4E352525A511A525DA7701010101E925A511DA77A7770077E6010101010101
        0101A49F352510A5A5A511DA770101019F8B25A5A5A5258B35A577F801010101
        010101F8AA4E352525A511A57700010101F89F8B25A511A525A58200A40101F8
        9F8B11A560A5108BA5E60101010101010101A49F4E2510A5A5A511DA77EF0101
        DC8B25A5A5A5258B10DA77EF01010101010101F5AA4E352525A525252577EA01
        0101010101010101010101F89FE9EAF9A5FAA5F7F5F501010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101A49F544F25A560A511A57700010101FC8B57251111
        A50411A5DA770101010101010101A19F4F1057A58204827700A40101F58B57A5
        A56011104F60C20101010101010101019F4E4F25A560A5A5DA77FC0101A4E98B
        A5048260A504DA77EF010101E92511A5822157108277FC01010101010101FC4E
        4F1057A58204A57700A40101F58BEA60820457104F60C2F501010101010101A4
        9F354F25A56057101177FA01010101010101010101A4EADA0077C2770077C277
        0077E2F501010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101AA4E352525A511A5
        11DA7701010101E98BA525A511A51025A5E60101010101010101A49F542525A5
        A5A511DA77010101F58B25A511A5252535DA77010101010101010101AA4E3525
        25A525A56F00010101F89F8B25A5A5A525A560E6010101F89F8B25A5A5A53525
        A5E6A401010101010101A49F4E2525A511A525DA77EF0101DC8B25A5A5A52525
        35A577EF01010101010101DC5D4E352511A5252510DAEA010101010101010101
        01FA77DAA5A525A511A5A5DA770077E6A5F50101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101A4F54E4F101160A504A57700010101F84E5711A50482258B1082770101
        01010101010101AA9F1025048260A57700010101F58BEA60826011104F60C2A4
        01010101010101A4F54E4F25A560A504DA77010101A4E98BA511A560A504DA77
        FC0101A4E98BA50482118B108277EF01010101010101F5544F1011048260A577
        00A40101F58BEA60826011104F60C2A401010101010101A49F4E4F25A5601110
        5777EA010101010101010101E9A5A5104F1025251111A5608277DA7700DAF501
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101F8AA9F352525A511A511777701010101E9
        8BA525A5A511108B60DA010101010101010101F55D4F10A511A511DA77010101
        9F8B25A5A5A5252535A5DAF801010101010101F8AA4E352525A511A577000101
        01F89F8B25A511A525A58200010101F89F8B11A5A5A5108BA5E6010101010101
        0101A49F4E2510A5A5A511DA77EF0101DC8B25A5A5A5252535A577EF01010101
        010101F55D4E102511A5108B10DAEA0101010101010101EF8B25358B352525A5
        11A511A5A5A511A56FA777F70101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101F5544F25
        11048260A57700010101FC8B57041160A5254F1082770101010101010101FCA4
        F5355711A560827700010101F58B5760820457104F60C2010101010101010101
        F54E4F25A560A5A5DA77FC0101A4E98BA5048260A504DAA7EF010101E92511A5
        82258B108277FC01010101010101FC4E4F1057A58204A57700A40101F58B5760
        A56011104F60C2F501010101010101A49F354F25A50457101177EA0101010101
        0101019F8B354F102525A5A5A525E98B57A582A5A560C277F501010101010101
        01010101010101F5F79FEFF50101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101A49F4E2525A5A5A511E67701010101E98BA525A511253510
        A5E6010101010101010101F8A49F351111A5A577770101019F8B25A511A51025
        35A577010101010101010101AA4E352525A525A56F00010101F89F8B25A5A5A5
        11A560E6010101F89F8B25A5A5A51025A5E6A401010101010101A49F4E2525A5
        11A525DA77EF0101DCE925A511A5252535A577EF01010101010101DC5D4E3525
        11A5252510DAEA01010101010101019F544F352525A511A525E99FF59F8B11A5
        25A560A7A5F80101010101010101010101EEA5E6770077A7A5FAA5EEA4EF0101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101FC5D9F101111A56082770001
        0101EF8B5704A560A5254F35827701010101010101010101A15D4F251160A577
        008B0101EA11A560A5258B354FA5DAA401010101010101A4F54E4F251160A560
        DA77FC0101A4E925A560A560A504DA77FC0101A4E98BA50482118B108277EF01
        010101010101A14E4F1011048260A57700A40101F58B5760A56011104F60C2A4
        01010101010101A49F358B25A56011105777EA01010101010101FC4E4F354F25
        11608260FA9F01A4EF9FEA60A5251177C2E901010101010101010101F777DA77
        DA6FDA77000000770077EF010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01F5AA8B25A511A5607777F70101A4EA25A511A52525358BA5DA010101010101
        01010101A4F55D8B25A511DA7700A5DAA5A511A52525104F35A5E90101010101
        010101F8AA4E352525A511A57700010101F89F8B25A511A511A58200A40101F8
        9F8B25A560A5108BA5E60101010101010101A49F4E2510A5A5A511DA77EF0101
        DC8B25A511A5252535A577EF01010101010101F5AA4E101111A5108B1077EA01
        010101010101A49F4E10101111A511DADAF50101A49F8BA511A510A577DAA401
        01010101010101F88BA5108B352525A560A5A5DA77A7F5010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101A4A14E8B21A560826F00F6EFA4EAA5A56082A5
        11104F10DA8B0101010101010101010101A4A14E57048260DA770077DA60A511
        11104F358BA5F70101010101010101019F544F25116082A5DA77FC0101A4E98B
        A5048260A504DA77EF010101E92511A5822157108277FC01010101010101FC4E
        4F1057A58204A57700A40101F58B5760A56011254F60C2F501010101010101A4
        9F354F25A50457101177FA01010101010101FC4E4F108B11A560A56F00F50101
        019FD6A5A5045710DA77F70101010101010101A49C354F108B251160A5104F10
        8277F501010101010101010101A4EF9FEA9FFA9FEFF501010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101A4F54E1125A5
        11F67700770077A511A511A51025352560D6010101010101010101010101A4DC
        9F8B25A5A5F6A5A511A52525108B354E10EA01010101010101010101AA4E3525
        25A5A5A56F00010101F89F8B11A511A511A56FA7010101F89F8B25A5A5A53525
        A5E6A401010101010101A49F4E2525A511A525DA77EF0101DC8B25A511A52525
        35A577EF01010101010101DC5D4E352511A5252510DAEA01010101010101A49F
        4E2510A5A5A525DA77F5010101E98BA511A5252525E6A50101010101010101DC
        544E352510A511A52525354E2500F50101010101010101019FDA77E6770077A7
        7700A5D6A4010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101A4F54F1160A5608277C277DA608260A5258B104F25DA8B0101
        0101010101010101010101A4EF9FE925A560A504A51111254F354F358BF50101
        01010101010101A4F54E4F101160A560C277010101A4E925A5A5A560A560DA77
        FC0101A4E98BA50482118B108277EF01010101010101F5544F1011048260A577
        00A40101F58B5760826011104F60C2A401010101010101A49F4E4F25A5601110
        5777EA01010101010101F5544F108B118211A56F00F5010101DE8B6082041110
        8B77DAA401010101010101A49F4E4F1057A5A52557359F5D9CA5F50101010101
        0101EFA5C277DA608260DA77C277007700EAEF01010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101F8A4F54FA511A511A5A5A511A5
        11A525253510358BA5010101010101010101010101010101A4DCA4EE4E8B25A5
        2525108B4E4E5D9F9F01010101010101010101F8AA4E352525A511A57700A401
        01F84FEA11A511A511A56F00010101F89F8B11A5A5A5108BA5E6010101010101
        0101A49F4E2510A5A5A511DA77EF0101DC8B25A5A5A5252535A577EF01010101
        010101F55D4E352511A5108B25DAEA01010101010101A49F4E2510A5A5A525DA
        77F5010101E98BA560A5108B35DA77F501010101010101DCAA4E352525A51125
        354E5DF5A4F5A401010101010101A5DAA525108B102525A511A5A5E6770077E9
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01A4F54FEA608260A560A5A5A52557104F354F25E90101010101010101010101
        0101010101A4FCA4F55DF59F9F9FF59F9F5DF5A4010101010101010101010101
        9F4E4F2511048260DA77FAF501E9EA11A5608260A560C2A7EF010101E925A5A5
        A5258B108277FC01010101010101FC4E4F1057A58204A57700A40101F58B57A5
        A56011104F60C2F501010101010101A49F354F25A50457101177EA0101010101
        0101FC4E4F1057118204A57700F50101019F57A5820457104F60C2F501010101
        010101A49F354F25A56011251125F5010101010101010101019FEA254F354F25
        1104A560A56082608277C277EA01010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101F8A4F59F8B25A511A525A52525354F544E549F
        010101010101010101010101010101010101010101F8A4DCA4F5A4DCA4F80101
        010101010101010101010101AA4E352525A5A5A5A5DA7700DADAA5A511A5A5A5
        11A57700A40101F88BEA25A511A53525A5E6A401010101010101A49F4E2525A5
        11A511DA77EF0101DCE925A511A5252535A577EF01010101010101DC5D4E3525
        11A5252510DAEA01010101010101A49F542510A5A5A525DA77F5010101DE4EA5
        11A5252535A577F501010101010101DC5D4E352511A5252525DADC0101010101
        01010101018B354F352510A511A525EA25EA25A511A5A5A777E9010101010101
        0101010101010101F5F78BEA9FF8010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101A4EFF5F54E
        E9258B104F4E9F4E9F5DF5010101010101010101010101010101010101010101
        01010101FC010101010101010101010101010101010101A4F54E4F2511608260
        82A5A560DA778260826082608260DAA7EA0101E9EA11A560A5258B358277EF01
        010101010101A14E4F1011048260A57700A40101F58B5760A56011104F60C2A4
        01010101010101A49F354F25A56011105777EA01010101010101EF4E4F101104
        8260A56F00F5010101F5F59FE94F9C4E4F1100F501010101010101A49F4E4F25
        A5601110A577F5010101010101010101F54F4F354F25110482A5EA4EE29FE925
        A5111160C277F70101010101010101010101EFA5C277C277C2DAEA0101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101F8A4F5A4F5A4F5AAF5AAF5A4DC01010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101F8AA9F4E8B25A511A5A58BF5F54EA5A5A5A5A511A511A5A50077FAEADA
        A5A511A52525108BA5E60101010101010101A49F4E2510A5A5A511DA77EF0101
        DC8B25A511A5252535A577EF01010101010101F55D4E101111A5108B25DAEA01
        010101010101A49F4E2510A5A5A511DA77F5010101F801F5A4F5A4F5AA4EA5F5
        01010101010101EFAA4E101111A5108B11A7A1010101010101010101A44E548B
        102511A560A58BEEA4F8A18B11A52511A5A7A501010101010101010101F5A5DA
        60A511DA770077F9A40101EAEAEEA4EF01010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101A4FCA4FCA4FCA4FCA4
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101EFA4F5F5F59F9C4FEA25FCA4F54EEA60
        A504A5A5A5045725EA770077826082A511104F10A577FC01010101010101FC4E
        4F1057118260827700A40101F58B57A5A56011104F60C2F501010101010101A4
        9F354F25A50457101177FA01010101010101FC9F4F105711A560827700A40101
        0101010101A4FCA4FCAAF5A401010101010101A49F354F25A5045710A577F501
        0101010101010101F54E4F10252182608260EA010101EF9CEA601125116FC28B
        0101010101010101014E57258B354F25A560C200DA9F01770077C277EAA5EAA4
        EFA4010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101F8A4F8
        A4F5A4F59FE90101A4F59F8B25A525A525A58BF5A4DE8BA5A5A511A525253510
        11DA0101010101010101A49F4E2510A511A5A5DA77EF0101DCE925A511A52525
        35A577EF01010101010101DC5D4E352511A5252510DAEA01010101010101A49F
        4E2510A511A5A5DA77FAEAF5A4EF0101010101010101010101010101010101DC
        5D4E352511A5101011E6DC010101010101010101AA9F352510A5A5A511DAA501
        0101A4E925A525A510A577DA010101010101010101E94E4E3525101125A560A7
        77009FDAA5DA77A7770077A777FA010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101A4FCA4010101A4EF9F9C4F8B4FE98BE201
        01A4F58BA560A52557104F35A5D20101010101010101F5544F101104A560A577
        00A40101F58BEA60826011104F60C2A401010101010101A49F4E4F25A5601110
        5777EA01010101010101EF544F108B25A560A560DA0000770077FAEAEAF5EFA4
        0101010101010101010101A49F4E4F25A5112535A577F5010101010101010101
        F54E4F101160A5048277F9010101EF8BEA60A5258B10DA77EF01010101010101
        FC4E4F354F101111A560A560DA770060A560A5608260DA77C2DA010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101F8A4F5A4F5AAF501010101A4F58BA525111010548B25E9010101010101
        0101A49F4E2510A511A511DA77F501019F8B25A5A5A5252535A577EF01010101
        010101F55D4E352511A5108B25DAEA01010101010101A49F4E2510A511A511A5
        60DA6FE677007700770077E68BEAE90101010101010101DCAA4E101111A5108B
        11A7A10101010101010101F8AA9F352525A511A5A5A7A5010101A4E925A511A5
        102511008B01010101010101A49F544F352525A5A5A511EA8B8B25A5A5A511A5
        2525102577DA0101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101FCA4FCA4010101010101FCA4F54E8B10
        4F359C4EE9A40101010101010101FC4E4F105711A560827700EAFC01D611EA60
        820457104F60C2F501010101010101A49F354F25A50457101177EA0101010101
        0101FC9F4F105711A5608260A56082608260DA77DA77C2770077C2F501010101
        010101A49F354F25A5048B10A577EF010101010101010101F5544F1011048211
        A577F9010101EF8BEA60821125105777F901010101010101FC544F108B25A560
        8260EA8BF5A4F58BEA608260A5254F10DADA0101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101A4F5A49FAA9FAAF501010101010101010101A49F4E2525A5
        11A5A5F6770077F9A5A511A511A5252535A577EF01010101010101DC5D4E3525
        11A5252510DAEA01010101010101A49F542510A511A5A5A511A525A511A5A5A5
        11A525A525DA77F501010101010101DC5D4E352511A5101011E6DC0101010101
        01010101AA9F352525A511A511E6A5010101A48B25A5A5A5108B10DAA5010101
        01010101A49F541010A511A511A5A5E90101A4F58BA5A5A52511352560DA0101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101A4FCA4F5A4FC0101010101
        010101010101F54E4F1011048260A560826FDA77DA60A560A5118B354FA5C2A4
        01010101010101A49F358B25A56011355777EA01010101010101EF544F108B11
        A560A560578BE29FE911A560821111104FA5C2F501010101010101A49F4E4F25
        A5118B35A577F5010101010101010101F54E4F101160A504A577F9010101EF8B
        5760820457108B77F901010101010101FC9F4F105711A560A560DAF50101019F
        E9A58260A5254F10DADA01010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101F80101010101010101010101010101A4F55D8B10A5A5A511A525E99F8B
        11A511A52525108B35A577EF01010101010101F5AA4E101111A5108B10DAEA01
        010101010101A49F4E2510A511A511A525DEA4EFDC8B11A5A5A5252535A577F5
        01010101010101EFAA4E102511A5108B11A7A1010101010101010101AA9F3525
        25A511A5A5A7A5010101A4EE9FE98B8B354F10DAA501010101010101A49F548B
        10A511A525DA77F7010101EE8BA511A52525352560DA01010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101010101FCA4
        F55DF59FE94F8B1157A4FCF5E911A51111104F104F11EA0101010101010101A4
        9F354F25A50457102577FA01010101010101FC9F4F105711A5608260DAA40101
        EF4EEA60820411104F60C2F501010101010101A49F354F25A5045710A577F501
        0101010101010101F5544F10110482608277F9010101FCA4EFF5F59FF55D9F25
        F901010101010101FC544F10110482A5A560009F0101019F8B048260A5254F10
        DADA010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101F8A4F5A4F5A49F9F0101F8A4E98B111025354E
        35A5E90101010101010101DC5D4E352511A5252510DAEA0101010101010101F5
        542510A511A5A5DA77F50101A4E925A511A5252535A577F501010101010101DC
        5D4E352511A5101011E6DC010101010101010101AA9F352525A5A5A5A500A501
        0101010101F8A4F8A4DCA49F9C01010101010101A49F542510A5A5A525DA77EE
        010101DE8BA511A511253525A5DA010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101A4FCA4
        EF0101A4FCA4F54E4F4E4F4E9C4EEF0101010101010101A49F4E4F25A5601110
        5777EA0101010101010101AA9F358B25A560A57700F50101EF8BEA60A5111110
        4FA5C2F501010101010101A49F4E4F25A5118B35A577F5010101010101010101
        F54E4F101111A5608277C2F5FCA4010101010101010101A4FC01010101010101
        FC9F4F105711A504A56F009F0101019FD611A560A5254F10DADA010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101A4F5A4F5AA9FAAF8010101010101
        010101F55D4E352511A5108B10DAEA0101010101010101F5AA4E10A511A5A5DA
        77F50101DC8B25A511A5108B35A577F501010101010101DCAA4E102511A5108B
        11A7A10101010101010101F8AA9F352525A511A5A5DA77007700EAEAD2F501EF
        010101010101010101010101A49F542525A511A525DA77EE010101E98BA511A5
        1125102560DA0101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101010101FCA4
        FCA4FCA40101010101010101010101A49F354F25A50457101177EA0101010101
        010101A4F5544F25A560827700A40101F525EA60A52157104F11DAF501010101
        010101A49F354F25A5045710A577EF010101010101010101F5544F1011048260
        8260DA770077000000770077EA8BD6010101010101010101FC544F10110482A5
        A560009F0101019F8B11A560A5254F10DADA0101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101DC5D4E3525
        11A5102510DAEA010101010101010101A4F54E2525A5A5DA77E901018BA511A5
        1111351035A5EA0101010101010101DC5D4E352511A525251100DC0101010101
        01010101AA9F352525A511A5A5A5A5A5A5DA60DA77E677A7770077E6EA010101
        01010101A49F4E2510A5A5A525DA77EE010101DE4FA525A51111352560DA0101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101A49F4E4F25A56011355777EA010101010101010101FCA4F510
        1160A560C2A700A5DAA5A50411254F358BA5EA0101010101010101A49F4E4F25
        A5601110A577F5010101010101010101F54E4F101111A5608260A5A58260A560
        8260A560A560DA77F901010101010101FC9F4F105711A504A560009F0101019F
        E911A560A5254F10DADA01010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101F5AA4E101111A5108B10DAEA01
        01010101010101010101A49F10A511A56077770060A511A52525354F10A5F501
        01010101010101F5544E101111A52525A5A7A1010101010101010101AA9F4E25
        25A511A5A5A58BE99F8B8BA560A511A5101010DAA501010101010101A49F5425
        25A511A525DA77EE010101DE8BA511A51111102560DA01010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101A4
        9F354F25A50457102577FA0101010101010101010101FCA4F54F576082608260
        A50411258B104F358B8BFC010101010101A4FC9F4F354F25A56011258277F501
        0101010101010101F5544F10110482608260579FF5A1E2258260821111105777
        F901010101010101FC544F1011048211A560009F0101019F8B25A5A5A5254F10
        DADA010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101DC5D4E352511A5102510DAEA010101010101010101
        010101F8A4F54EEA11A511A525A52525354F544E9FF501010101010101EEA5A5
        104F101111A52525A500DC010101010101010101A49F352525A5A5A5A5DA8B01
        01F8DC8B11A511A5102510DAA501010101010101A49F4E2510A5A5A525DA77EE
        010101DE4FA525A511113525A5DA010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101A49F4E8B25A5118B35
        5777EA0101010101010101010101010101A4F59FE98B572557254F4E9C4E9F5D
        FC0101010101010101A48B104F108B25A560A5258277F5010101010101010101
        A15D4F101104A5608277F9010101F58B8260A52157108B77F901010101010101
        FC9F4F105704A504A560009F0101019FE911A560A5254F10DADA010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101F55D4E10A5A5A5108B10DAEA01010101010101010101010101010101EF
        A4F5A4F5AA9FAA9FAAF5A4F8010101010101010101DC5D4E352510A511A511A5
        257777EA8BF5010101010101A49F542525A511A560A7A50101019FD2A5A511A5
        101010DAA501010101010101A49F542525A511A525DA77EE010101E98BA511A5
        1111102560DA0101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101A49F35571182214F102577EA0101010101
        01010101010101010101010101A4FCA4F5A4FCA4FCA401010101010101010101
        01A4F54E4F105711A560A5111104C27700A5010101010101FCAA9F1011048260
        8277F9010101F78BA560A51125354F77F901010101010101EF544F10110482A5
        A560009F0101019F8B25A5A5A5254F10DADA0101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101F8A49F4E8B
        258B354F10DAEA01010101010101010101010101010101010101010101010101
        01010101010101010101010101F8A4F5548B25A511A525A5102510A577FA0101
        0101010101F5AA4F10A511A5A500A50101019FD211A52525104F10DAA5010101
        01010101A49F4E2510A511A525DA77EE010101DE4FA525A51111352560DA0101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101A4FCA4F59FF59FF55D9C60EA01010101010101010101010101
        010101010101010101010101010101010101010101010101010101A4F5101104
        8260A5258B104F35DAA501010101010101A4F54E8B25A5608277DA0101A4EA11
        8260A5254F358B60F701010101010101FC9F4F105711A560A56F009F0101019F
        E911A560A5254F10DADA01010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101EFA4DCA4F5A49FE901
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101F8AA4F10A5A5A52511354E5D9F10EA0101010101010101A4F5
        4E2511A5A57777FA8BDAA5A511A52525351025DAF501010101010101A49F548B
        10A511A511DA77F7010101DE8BA511A51111352560DA01010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101FC0101A4FC010101010101010101010101010101010101010101
        01010101010101010101010101010101010101A49F355711820411258B35A1A4
        F59F0101010101010101FCA4F54E1160A560C20000778260A51157104F3557A5
        EF01010101010101FC544F1011048260A56F009F0101019F8B11A5A5A5254F10
        DADA010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101DC
        5D8B25A511A5102510A5A4010101010101010101010101F8A4F54EA511A560DA
        60DAA5A525253510354F25D60101010101010101A49F542510A511A511DA77EE
        010101DE4FA525A511113525A5DA010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101A49F35110482258B35A577F5010101010101010101
        01010101FCA4F54E57A5A560A560A52557104F354F4EE9A40101010101010101
        FC5D9F355711A5608277009F0101019F8B11A560A5254F10DADA010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101F8AA9F4ED2258B358B
        11A7A101010101010101010101010101010101F5DCE98BEA25A52525354F549F
        549F01010101010101010101A4F55D8B101111A5A5DA77EE010101E98BA511A5
        1125102560DA0101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101A4EFA4EFF5F55DF59F8B77E2010101010101010101010101010101FCA4
        EFA4F59F9F4E9C9F9F5DF55DF5010101010101010101010101AAF5352525A5A5
        826000DA0101F5A5A5608260A5254F10DADA0101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101A4F8A4F8A4DCAA8BDC0101010101
        01010101010101010101010101F8A4DCA4F5A4DCA4F5A4010101010101010101
        0101010101F8A49F101125A5A5DA7700770077DA11A5A5A51111352560DA0101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101A4FCA401010101010101010101010101010101010101010101010101A4
        010101010101010101010101010101010101FCAA9C25A56082608277C277DA60
        82608260A5254F10DADA01010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101F5
        AA8B25A560A51182A5A58BEA11A511A52525358B60DA01010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101A4EFAA9C25A5A5EA11574EF59F57608260A5254F10
        DADA010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101F8A4F59FE99FE9
        9FF501F54FA560A525253525A5DA010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101A4EFF5F5DCEF01019FE9A58260A5254F10DADA010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101EE8BA511A5
        2525358B60DA0101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101019F8B118260A5254F10DADA0101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101019F4EA525A51111352560DA0101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101010101019F
        9C25A560A5254F10DADA01010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101F54E2525A52525352560DA01010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101015D9C1011A5A5104F10
        DADA010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101F55D8B25A525253525A5DA010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101A4F59F9C8B8B104F10DADA010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101F8A4F5A4F5
        A4F5A49F25DA0101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101FC01EFA4FCA4F58B0101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010000}
      Stretch = True
      Transparent = True
      Visible = False
    end
    object Completedpic: TImage
      Left = 23
      Top = 56
      Width = 120
      Height = 84
      HelpContext = 432018
      Picture.Data = {
        07544269746D6170266D0100424D266D01000000000036040000280000002A01
        0000340100000100080000000000F0680100C1990000C1990000000100000000
        000000000000FFFFFF00FFFDFD00F7F6F40065615400A3A09700EEECE600F2F1
        EE00372F13009F8939007363290067592500BFA545007D6B2D00716129003A32
        1500A18B3B00816F2F00C1A74700A58F3D008573310075652B0051461E007363
        2B001D190B003D351800362F16001F1B0D00231F11005F5C510069665B00EAE4
        CE008D8A7F0099968C00B9B7B0007F6F2D0079692B001F1B0B00A58F3B009F8B
        390083732F006D5F2700352E1300BFA74500B9A14300B39D41009D8939009884
        37008D7B33007D6D2D0077672B0071632900483F1A00C7AE4900C2AA4700BDA5
        4500B29B4100AA953E00A28E3B00917F35008B7A33008675310081712F007B6B
        2D006B5E27006558250060542300584D200029240F00BAA34500B69F4300AE99
        4000A6923D009F8B3B009A8639008F7D35007F6F2F0075672B006F6129002E28
        110026210E00BFA74700B7A1440094823700897733008373310079692D007365
        2B00695C27007D6D2F006D5F290040381800A28F3E009D893C0071632B00221E
        0D00D0B65000CAB24E008C7B36007B6C30006F612B00312B130075672E00C7AF
        4F00BCA64B00B29D4700897937007F70330072652E008273350071632E00D4BB
        5700C1AA50008677380084753700766931008C7C3B007C6E3400796B3300B6A1
        4D00A89547009E8C4300A18F4700D7C06000C6B059009282420098874500B9A5
        55007E703A007A6D380082743C00AD9B5100D7C16700CBB6610038321B00D3BE
        6700877A4200A2925200DDC8710082754300DAC67100DDC87300D7C270009A8C
        5100DDC97600DBC77500BEAC65008D804B00B3A36000AA9A5B00D9C575009285
        4F006D633B00DBC77700D6C27500877B4A002B27180096895400C8B67200DCC9
        8000DFCD83005F573800312D1D008D82540091865700D4C48000CEBE7C009F93
        6000746B4700DFCE8900968B5D009A8E6000B1A46F00BCAE7700E0D08F00D8C9
        8A00A79B6B00E2D396004E493500CABE8C00C1B58600E5D8A200D4C89700A79E
        780080795C00635E4A00D7CDA200534F3F0059554500E8DEB5006F6A5700B8B0
        9100BDB69900E8E0BE00ECE4C500DBD5BE00D3CEB900E2DDC900F3EFDE00D8D5
        C900F6F3E700E8E6DE00F9F7EF008E7D3300675B2500BFA945009D8B39007769
        2B0071652900BDA745007B6D2D00BBA545009B8939007F712F007D6F2E006F63
        2900796B2D00332D13006D612900675B270083753200373115006F632B008778
        36006F632D0025221400393523003F3B2800E5D7970046422F009D946B008E86
        6300E7DCAC00AEA68300B3AB8800C5BD980076715B006A665400DBD3B000C6C0
        A500CEC8AE0078756600716E6000EFEAD300C5C4BF00FBFAF500817F73001B19
        0B00DFDED7001D1B0B00ADACA400FDFDFA00FFFFFD00FBFBF900FDFDFD000000
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        01C7E6E21E050101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010000010101010101C72AE12A002AE1E2070101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010000010101010101CE98CE9898E22A00
        2AE2C60101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        010101C6E60C926092CE982A000000E601010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010100000101010101C7608460E660CECE98CC2A2A0098010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010100000101010101E49260920C
        CECE9898B2CCB22A002A22010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        00000101010101848A8460CECE9854989898549816002A050101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010100000101010101849260920C545498CCB2CC9823
        9816002A05010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010100000101010101B6
        8A8460CECE98549898985498CE9898002A050101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010000010101010184B66092CE98CCB2CC9854B8E605CE54CC002AC701
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101848A8460CECE989898
        5498E6B6C6FAE69898002A070101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        01010184B66092CE98CC98CCB22A050107B605CE5416002A0101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010100000101010101B68A846054CE985498CC00B60101C7B6E6
        CE98160098010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010000010101010184B66092CE
        98CC9854E200FA0101C605E698CE982A00C20101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        00000101010101848A9260CE5498CE98CC00B601010184E65498CE982AE20101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010184B660E6CE98CC9854E200FA01
        0101E6E698CC98CEE22A1E010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010184
        8A840C5454985498CC00B6010101E6F6CE985454CEF72A010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010000010101010184B66092CE98CC5454E20022010101B8E698CCB254
        CECCE1E601010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101848A9260CE5498CE98
        9800B6010101E6E6CE9898980C982AF701010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        01010184B660E6CE98CC98CEB200FA010101B8CEB8239823540CE22A22010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010100000101010101B68A840C545498CE98CC00B6010101E6E6
        CE985498CECE5400050101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010000010101010184B66092CE
        982354CEB200FA010101B8E6B82398CC540CB82AE20101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        00000101010101848A9260CE5498CECE9800B6010101E6E6CE985498CECE0C2A
        1601010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010184B660E6CEB25454CEB200FA01
        010105B6BFCE98CC540CE62AE101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010184
        8A840C5498980CCE5400B6010101C6C7C6B6E698CECE60E22AC7010101010101
        01010107E61EB6F8010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010000010101010184B66092CEB223B80C982A220101010101C7E422E6
        B80C92CC00B601010101010101010798002AE12AE2B601010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101848A9260CE5498CECE
        5400B6010101010101F8C6C7B6E660982AFA0101010101010101B69898E2CCF7
        2A0098FA01010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        01010184B660E6CEB254540C9818220101010101010101B6C7B6B6CE00B60101
        0101010101019260920CE6CEE22A00001E010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010100000101010101B68A840C5498980CE65400B60101010101
        01010101C6C7C6E62A0501010101010101018A92600C0CCECE982A002AE2C601
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010000010101010184B66092CE
        9823B8CE982A2201010101010101010101C6F8B6B2B601010101010101E89284
        9260E6CE98CCB2CCE12AE1E60101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        00000101010101B6E48460CE5498CECE5400B6010101010101010101010101F8
        84F401010101010101C7848460CE0C985498989854E22A009801010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010100000101010101C6B68492CE98CC54CEB200FA01
        010122010101010101010101C7B601010101010101C69284920C542398CC98CC
        9854B22A00980101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010100000101010101C7
        8AB660CE5498CE54CC00B60101012A1E01010101010101010101010101010101
        01F88A8460CECE9898985498CEE6E6982A00B207010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101C6B6E492CE98CC54CEB20022010101B200E2C20101
        01010101010101010101010101C69284920C5498B2CCB298E6B62292982AE198
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010000010101010101E8B684CECE98CE98
        9800B6010101CEE21800E60101010101010101010101010101C78A8460CECE98
        989898E2E607C6C792982A00E601010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010107E4B60C54CC9854B200FA010101B8CEE20000980701010101010101
        0101010101C6848492CE54CCB2CCB22A220101B6BFCE982A0005010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101B6E8E6CE985498CC00B6010101E6E6
        CEE22A002A050101010101010101010101F88A8460CECE9898989800B60101F4
        84E6CE982A00C201010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101E8C784
        E623B298E20022010101B8E6B823B22A002A1E01010101010101010101C69284
        920C54CC9823E200FA0101C7E6CE98CEB22AE101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        00000101010101010107E8C784985498CC00B6010101E6E6CE985498CC002AE2
        C20101010101010101C78A8460CECE985498CC00B60101C7E61E5498CEE22A05
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010100000101010101010101C2E8B6CE98CCE2000501
        0101B8CEB82398CC5454E22A00C701010101010101C6928492CE98CC9823E200
        FA0101B61ECEB223B854E12A0101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        010101C7C6B6CE98CC002A010101E6F6CE985498CECE0CE22A05010101010101
        01F88A8460CECE9854989800B60101C7CEB85498CECE9800B601010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101000001010101010101010101C7E4BF54982A00C7010198CE9823B2CC
        540C929800B601010101010101C69284920C54CC9823E200FA0101C71ECEB2CC
        980C542AE2010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101000001010101010101010101C6C7E8E6
        CEE22AF7C601989854989898CECE60982AFA01010101010101C78A8460CECE98
        5498CC00B60101C7CE1ECE9854CE0CE22AF80101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        010101010101010101C6C7B6E6CCE20000B2E2CC98CC98CC540C925400B60101
        0101010101C6848492CE98CC9854E200FA0101B6B8CE98CC98CEE6CC18E60101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010000010101010101010101010101C6C7B6E654E22A2A9898
        98985498CECE60982AF401010101010101F88A8460CECE985498CC00B60101C7
        CEE6549898540C542AE2010101010101010101E2C60101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        010101C6C7B6B8CC98CCB298B2CCB254540C925400B601010101010101C6BF84
        920C54CC9823E200FA0101C71ECE98CC98CEE60CE22A010101010101010101CC
        00BF010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        00000101010101010101010101010101C6C7E8E6CE985498989854980CCE6098
        2AFA01010101010101C78AB660CECE985498CC00B60101C7CEE6CE9854980CCE
        CC00010101010101010101E61600980101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101C6C7B6
        055498CCB2CC98CEB80C92CE18B60101010101010101B68A92CE54CC9854E200
        FA0101B6B8CE98CCB254E660B22AFA010101010101010184922A002A22010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        01010101010101010101C6C7C605CE98CC9854980C0C60982AC7010101010101
        0101E4B684CECE9854989800B60101C7CEE6549898980CE65400B60101010101
        010101848ACE2A002A1E01010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101C6C7E422E6982354CE
        E66092CCE2010101010101010101B6B6920C54CC9823E200FA0101C71ECE9898
        B223B80C982A22010101010101010184BF60B82A0018E2C70101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101C7C6C7B6050CCE6092609898010101010101010101C6B6E4CECE98
        5498CC00B60101C7CEE6CE9898980C0CCE00B60101010101010101848A926098
        CCF72AF7BF010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        01010101010101010101010101010101010107C2C7B6C7B6B68484CE05010101
        01010101010101E4B6605423B298E200FA0101B6B8CE98CCB254E660982A2201
        0101010101010184B660E6CEB254E22A00B60101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        C6C7C6C7E8B68AE60101010101010101010101C7E8840C9898981600B60101C7
        CEE65498CC980CE6CE00B60101010101010101848A840C9898980CE22AFA0101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        010101010101010101010101010107C607E807010101010101010101010101C6
        B68A925498CCE200FA0101C71ECE98CCB223B80C982A22010101010101010184
        B6609254B223B8CC00B6010101C6010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101E8C784CE5498CC00B60101C7CEF6CE9898980C0C
        CE00B60101010101010101848A9260989898CE982AFA010101E2F80101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010107E4C70C54CCE200
        220101B6B8CE98CCB254E660982AFA010101010101010184BF60E6CEB25454CC
        00B60101011600E6010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101C7C6B60C98CC00B60101C7CEE6549898980CE6CE00B60101010101
        010101B68A920C98CC98CEE2F705010101982A00980701010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101C6C2E4BFCEB200E10101B698CEB2CC
        B254B80C982A22010101010101010184B66092CEB223541600B6010101CE982A
        002AFA0101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101C7
        C605CEF72A050105CC98549854980C92CE00B60101010101010101848A926054
        5498CEE218FA0101011EE6982A002A1E01010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101C6C2E4E6CC00001E2AB29898CC98CEE660982A2201
        0101010101010184B660E6CEB29898CC00B6010101CEE6CE982A002AE1C70101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101C6C7C6E6CCF72AE2
        CC985498CE540CE6CE00B60101010101010101848A840C989898CEE2F7050101
        01E69298CE9898E22A00E6010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101C6C2E4E623B2CC98CCB2CC98CE9260982A22010101010101010184
        B66092CEB223541600B6010101CEB8CE98CC9854E22A00B60101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101C6C7C605CE9854989898CECE6084
        CE00B60101010101010101848A9260549898CEE218FA010101F6E69854985454
        0CE22AF401010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101C6
        C2C2B6CE98CC982354CE9260542AFA010101010101010184BF60E6CEB2CC98CC
        00B6010101CEE6CE98CC98CEB8CC00B6010101C6010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101C7C6C784985498CECE6092CE2AC70101010101
        010101848A920C989898CEE20005010101E6921ECE985498CE982AFA010101E2
        B601010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010107C7C7B605CE
        E60C926054CC01010101010101010184B66092CEB223541600B6010101CEB8CE
        98CCB25454CC00B6010101160098010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010107C6C7C6B6E4B68A84CEE6010101010101010101848A926054
        9898CEE218FA010101E6E698CE989898CEE22AFA010101982A00E2C701010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101C6C7C6C7E8C78492010101
        0101010101010184B660E6CEB29898CC00B6010101CEE6CE98CC9823541600B6
        010101CE1E2A002A050101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010107C6C7C6B6C601010101010101010101848A840C989898CEE2F7050101
        01E6E698CE985498CEE218FA0101011EE6982A002AE201010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010184
        B66092CEB223541600B6010101CEB8CE9823B29898CC00B6010101CEB8CE982A
        002AE1B601010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101848A9260549898CEE218FA010101F6E69854989898
        CEE2F7FA010101E6E698CE9898E22A00E6010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101018ABF60E6CEB2CC98CC
        00B6010101CEE6CE98CC9823541600B6010101CEB8CE98CC98CEB22A00B60101
        0101010101C60101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101B68A920C98CC98CEE20005010101E6921ECE985498CEE218FA0101011E
        E6545498CECE0CE22AFA0101010101010105B801010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010184B66092CEB223541600B6010101CEB8CE
        9823B29898CC00B6010101CEB8CE98CC98CE925400B601010101010101E400E2
        F801010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101848A926054
        5498CEE218FA010101E6E698CE989898CEE2F7FA010101E6E698CE98CECE6098
        2AFA01010101010101C7CE002A05010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010184B660E6CEB2CC98CC00B6010101CEE6CE98CC9823541600B6
        010101CEB8CE98CC98CE925400B601010101010101C692230000BBC601010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101848A920C98989854E2F7050101
        01E6E698CE985498CEE218FA0101011EE6985498CECE60982AF4010101010101
        01F88A8498F71800B60101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010184
        B66092CE98CC981600B6010101CEB8CE9823B29898CC00B6010101CEB8CE98CC
        980C925400B601010101010101C69284CE23E10000B801010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101B6E4B660CE549854E218FA010101F6E69854989898
        CEE2F7FA010101E6E698CE9854CE60982AF401010101010101C7848460CE54E2
        2A0098C701010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101E8C7E4B6CE98CC9816
        00B6010101CEB8CE98CC9823541600B6010101CEB8CE98CC98CE922300B60101
        0101010101C6928492CE98CC982A002AF8010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010107C6C7C6B6CE9854E22AE20101011EE69854985498CEE218FA010101F6
        E6545498CECE60982AF401010101010101F88A8460CE54980CCE1600B6010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101C607C6C7CE98CC000022010123B854
        98CCB25498CC00B6010101CEB8CE98CC98CE925400B601010101010101C69284
        920C98CC540C9818FA0101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101F8
        C6C78498CC002AC701E2CE9854985498CEE22AFA010101E6E698CE98CECE6098
        2AFA01010101010101C78A8460CECE98CECECE00B60101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010107C2C7B6B8CEE218E22A98CCB2CC9854541600B6
        010101CEB8CE98CC98CE925400B601010101010101C6848492CE98CC98CE982A
        2201010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101C6C78407E41E
        CCE25498CC985498CEE218FA0101011EE6985498CECE60982AF4010101010101
        01C78A8460CECE9854989800B601010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101C6BFC607B6055498CC98CC989898CC00B6010101CEB8CE98CC
        980C929800B601010101010101C69284920C54CC9823B200FA01010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101C6F801C7B6E6CE9854985498
        CEE2F7FA010101E6E698CE9854CE60982AF401010101010101C78A8460CECE98
        9898CC00B6010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101C6C7B6E623B2CC9823981600B6010101CEB8CE98CC98CE922300B60101
        0101010101C69284920C54CCB2CCB2001E051D981EC601010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101C6C7E4E65498549854E218FA0101011E
        E6985498CECE60982AF401010101010101C78A8460CECE98CC9898E22A002A00
        2A00980701010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101E8C7B6
        B8CCB2CC981600E6010101CEB8CE98CC98CE925400B601010101010101C69284
        920C5498B2CCB2CC98541ECCE22A002A22010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101C6C7E4E6549854E22A0001010198E6985498CECE6098
        2AFA01010101010101C78A8460CECE9898989898E6C7C6FACEB22A002AFA0101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101C6C7B605CE1E98E200
        FA0101CC1E5498CC54CE925400B601010101010101C6848492CE54CCB2CCB22A
        0501F8B605549816E12AFA010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101C6C7C2C7B60592E22AF405E254985498CECE60982AF4010101010101
        01C78A8460CECE9898989800B60101C7B61E5498CC002A070101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101C607C7C784F8C6B82AE12A9823B2CC
        540C925400B601010101010101C69284920C54CC9823E200FA0101C705CEB254
        5416E19801010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01F80101C2E6549854989898CECE60982AF401010101010101C78A8460CECE98
        5498CC00B60101C7E61E9898CE542A00C7010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010107B6BFCE98CCB2CC540C922300B60101
        0101010101C6928492CE98CC9854E200FA0101B61ECEB2CC54CE982AE2010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101C7E405
        CE985498CECE60982AF401010101010101F88A8460CECE9854989800B60101C7
        CEE65498CECE0CE22AC701010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101C6C7B6E623B298540C925400B601010101010101C69284
        920C54CC9823E200FA0101C71ECE98CC98CE9298009801010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101C6C7E4E69898CECE6098
        2AFA01010101010101C78A8460CECE985498CC00B60101C7CE1ECE98549860CE
        2AE2010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101C6C7B6B823540C92CE18B601010101010101C6848492CE98CC9854E200
        FA0101B6B8CE98CCB2CEE60CE22A010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101C6C7B6E60CCE60982A05010101010101
        01C78A8460CECE985498CC00B60101C7CEE65498CC980CE6CC00B60101010101
        0101C7F401010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101C6C7B6
        B68492CEB20101010101010101C69284920C54CC9823E200FA0101C71ECE98CC
        B223B80C982A2201010101010101220005010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101C6C7C6C7E8CECE0101010101010101C78A8460CECE98
        5498CC00B60101C7CEE6CE9898980C0CCE00B601010101010101C62A18E2C601
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101C607C2C7B607010101
        0101010101C6928492CE98CC9823E200FA0101B6B8CE98CCB254E660982A2201
        010101010101C260B200E1B60101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101F88A8460CECE9854989800B60101C7
        CEE6549898980CE6CE00B601010101010101C692602A2A009801010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101C69284
        920C54CC9823E200FA0101C71ECE9898B223B80C982A22010101010101010784
        920CB218002AF801010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101C78A8460CECE985498CC00B60101C7CEE6CE9898980C0C
        CE00B601010101010101C6848ACE0C982A002A20010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101C6848492CE98CC9854E200
        FA0101B6B8CE98CCB254E660982A2201010101010101C284BF0CE654B216E12A
        1DC6010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01F88A8460CECE985498CC00B60101C7CEE65498CC980CE6CE00B60101010101
        0101C6848A0C0C98985454E22AE2010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101C69284920C54CC9823E200FA0101C71ECE9898
        B223B80C982A2201010101010101C284840CB85498CE92CE182A010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101C78A8460CECE98
        5498CC00B60101C7CEF6CE9898980C0CCE00B601010101010101C6848AE60C98
        985460CE16E20101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101C6B6E4920C54CCB2CCE200FA0101B6B8CE98CCB254E660982A2201
        010101010101C284BF0CE623B2CE920CE22A0101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101C6C7E8E6CE98CC981600B60101C7
        CEE6549898980CE6CE00B601010101010101C684840C0C9898CE0CE616E20101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010107C6
        C7E4BF5498CCE200F60101B61ECE98CCB223B80C982A22010101010101010784
        920CB854B2CE920CE22A01010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101C6C7C6FACE98CC002A0101C7541E549854980C0C
        CE00B601010101010101C6848ACE0C98985460CE16E201010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101C6C7C622E6982A
        009801B6B25498CC9854E660982A2201010101010101C284BF0CE654B2CE920C
        E22A010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101C7C6C79298CC002AE2CC98549854980CE6CE00B60101010101
        0101C6848A0C0C9898CE60CECCE2010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010107E4C792BF921E16B2CCB2CC
        98CEE60C982A2201010101010101C2848460B854B2CE920CE22A010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0107C6B6C6F8B6E65498549854980C0CCE00B601010101010101C6848AE60C98
        985460CE16E201010101010101010107E61EE605010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101C60701C7B6B8CC98CC98CEE660982AFA01
        010101010101C284BF0CE623B2CE920CE22A01010101010101010198002A002A
        E198070101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101010101C6C7
        B654549854540C92CE00B601010101010101C684840C0C9898CE0CCE16E20101
        010101010101B698989898E22A002AE2C6010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101B6C784B8CC98CE9260982A22010101010101010784
        920CB854B2CE920CE22A0101010101010101B80C926092CEB22A000000E60101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101C6C7B69854CE6092
        CE00B601010101010101C6848ACE0C98985460CE16E201010101010101C76084
        609260CECE98CC2A2A0098070101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101C2C784B8CE9260542A2201010101010101C284BF0CE654B2CE920C
        E22A01010101010101C69284920CE6CE98CC98CCE22A002A2201010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101C6C7B6E684E6CE2AB60101010101
        0101C6848A0C0C9898CE0CCECCE201010101010101F88A8460CE0C9854985498
        54982A002AFA0101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010107C7
        C7E4C784CECC0101010101010101C2848460B854B2CE920CE22A010101010101
        01C6BF84920CB85498CCB29898CE5416002AFA01010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101C6C7C6B684E60101010101010101C6848AE60C98
        985460CE16E201010101010101C78A8460CECE9854985498E605B6E6CC002A05
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010107C6C7010101
        010101010101C284BF0CE623B2CE920CE22A01010101010101C69284920C54CC
        B2CC98CCB8C7C7B6B8CCE12A0501010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101C684840C0C9898CE0CCE16E20101
        0101010101C78A8460CECE989898982AB601C6C7B65498002AF8010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010784
        920CB854B2CE920CE22A01010101010101C69284920C54CC9823B200FA0101B6
        BFE6541600160101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101C6848ACE0C98985460CE16E201010101010101C78484
        60CECE985498CC00B60101F8B6E6CE981600F601010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101C284BF0CE654B2CE920C
        E22A01010101010101C6928492CE98CC9854E200FA01010105E698CE982A00C6
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101C6848A0C0C9898CE0CCECCE201010101010101F88A8460CECE98CE989800
        B6010101E6E65498CE982AE20101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101C2848460B854B2CE920CE22A010101010101
        01C69284920C54CC9823B200FA010101B8CE1ECC54CEE118C701010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101C6848ACE0C98
        985460CE16E201010101010101C78A8460CECE985498CC00B6010101E6E6CE98
        CECE540098010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101C284BF0CE623B2CE920CE22A01010101010101C6928492CE54CC
        9854E200FA010101B8E61ECC98CE542A00C70101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101C6848A0C0C9898CE0CCE16E20101
        0101010101C78A8460CECE9898989800B6010101E6E6CE9898540CE22A050101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010784
        B60CB854B2CE920CE22A01010101010101C69284920C54CCB223E200FA010101
        0592B898B2CE9254009801010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101C6848ACE0C98985460CE16E201010101010101C78484
        60CECE989898CC00BF010101B6C7B6E6CE9860CE2AF701010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101C284BF0CE654B2CE920C
        E22A01010101010101C6B684920C54CCB2CCB22A0005010101C6C7B605CEE60C
        E22AC701010101010101010101C6010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101C6848A0C0C9898CE60CECCE201010101010101F88AB660CECE98CC9854E2
        2A009807010101C7C6B68492CC00B60101010101010101F698E21EC701010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101C2848460B854B2CE920CE22A010101010101
        0101B684920C549898CCB2CCE22A002AC7010101C7C6C7B6542A220101010101
        010107CCE12A0018E2C601010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101C6B68AE60C98
        985460CE16E20101010101010101E8B684CECE985498549854E22A00181E0101
        0107C6F88A2AB601010101010101C6CE6098CCF72A00B6010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010107E4C284E6CEB2CE920CE22A0101010101010101C78ABF0C5423
        B2CC9854B8E6B82A0000E2F8010101C6C2CEFA01010101010101C260BF6092CE
        E200009807010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101C7C6C7E4E698540CCE16E20101
        010101010101C6B6E4CE0C989898989884B6C205CC002A0005010101C684E401
        010101010101C6848A0C60CECE2A2A002AC70101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        07C6C7B6B8CE920CE22A010101010101010101B6B660B85498CCB22AC7C6C7B6
        05CCE1180098070101C6C2010101010101010784846092CE98CCB22A002A2001
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101C6C7B60584CE16E2010101010101010101C7
        E8B60C985498CC00B60101C7B61E98E22A002AF401010101010101010101C684
        8A9260CE5498CE9898F72AE2C601010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101C6C7C7C760
        E22A010101010101010101C6C7E492CE98CCE200FA0101C605CEB2CCB22AE12A
        1E010101010101010101C284BF0CE6CE98CC98CEE654E22A18C7010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101C7C6C7CE2A01010101010101010101C6C7E4E6CE981600
        B60101C7CEE65498CE9898002AE20101010101010101C6848A0C0C985498CE98
        0C0C0CE22AFA0101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010107C6BFCC010101010101
        0101010101E4C2845423E200FA0101C71ECEB2CC98CEE654E22A220101010101
        010107849260E65498CC54CE9284B60C00B60101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101C254010101010101010101010107C6C78498CC00BF0101C7CE1E5498
        54980C0C5400B601010101010101C6848AE60C989898CECE60B6C6B623FA0101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101B601010101010101010101010107E8
        C70CB22A000101B6B25498CC98CEE66098182201010101010101C284BF0CE654
        B254CECE548401C692B601010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101C7C6B60CE22A2A011ECC98549854540C92CE00B601
        010101010101C6848A0C0C9898540C98CCC70101C6C701010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101C7E82254E118002A
        B2CCB2CC98CEE60C982A22010101010101010784840CB85498CE925400B60101
        01C6010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101C7C6B6CEE2CCE29898989854546060CE00B601010101010101C684
        8AE60C9854CE60982AF401010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101C7C6C7CE98CC98CC98CC54CE9260
        542A2201010101010101C284BF0CCE2398CE925400B601010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101C7
        C6C7849854985498CECE6092CEF7B601010101010101C6848A0C0C98CECE6098
        2AF4010101010101010101010105981EE6050101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101F8C6C7B6B8CCB254540C92609816070101010101
        01010784920CB898980C925400B601010101010101010101222AE12A002AE1E6
        0701010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010107C6C7B6E6CECE
        0CCE600C54E20101010101010101C6848AE60C9854CE60982AF4010101010101
        01010107CE98CE98982A2A002A1E010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101C6C7B6C784BF84926054E60101010101010101C284BF0CE623
        98CE922300B6010101010101010101E4540C9260E6CEB22A0000E2C701010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101C6C7C6C7E8B6E48460C70101
        010101010101C6848A0C0C9854CE60982AF401010101010101010184608460E6
        0C545498CCF72A00E60101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010107C6C7E8C7E4C701010101010101010107848460B89898CE925400B60101
        01010101010101849260920C542398CC98CCE22A009807010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101010101C684
        8AE60C9854CE60982AFA010101010101010101848A8460CECE9854985498CEE2
        2A002A0101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101C284BF0CCECC98CE922300B601010101010101010184
        B660920C54CC98CC9854B8CE982A002AF8010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101C69284CE0C98CECE6098
        2AF4010101010101010101848A8460CECE98989854B8B60584982A002A010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        C7B6C70C920CB8CC980C925400B601010101010101010184B66092CE98CCB2CC
        B22322C7C784542A002A07010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101C62AE6CE60CECE98CECE60982AF4010101010101
        010101848A9260CE54985498CCE20101C6C784982A0098010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101C20C54CE92CE54CC
        54CE922300B601010101010101010184B660E6CE98CC98CCE12A010107B605CE
        982A00E601010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101C6848AE660CECE98CECE60982AF4010101010101010101848A840C54
        549854982AF701010105B61ECE982A00C6010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010107E4C78492CE54CC98CE925400B60101
        0101010101010184B66092CE98CC5498002A010101E420E698CEB22AE2010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101C7C6B6
        84CECE9854CE60982AF4010101010101010101848A8460CE5498CE982AE10101
        01C7CEF65498CE2A2AFA01010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101C7E892CE98CC98CEE62300B601010101010101010184
        B660E6CE98CC9823E12A010101C71ECEB2CC54CCE12A01010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101C6B684CECE9898980C98
        2AF4010101010101010101848A840C98549854982AF7010101C7CE1E9898CECE
        2A00C20101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010784920C5498B223B89800B601010101010101010184B66092CE98CC9898
        182A010101B6B8CE98CC54CE982AB20101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101C6848ACECE989898CE982AE2010101010101
        010101848A9260CE549854982AE1010101C7CEE65498CECE0CF72A0101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101C284BF0C5454
        B2CC54CEE22AE2B60101010101010184BF60E6CE98CC98CCE12A010101C70584
        B8CC98CE921600B6010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101C6B6E4920C989898CECECEE22A00E6010101010101848A920C54
        CE9854982A0001010107B6C7B6B8CECE60982A05010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010107E4C78A9254B2CC54CE9260B22A
        E101010101010184B66092CE98CCB2CCE218E1C7010107C7C7B605CE92CEE12A
        010101010101010101B61E050701010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        C6C7E8E65498CECE84B68A982A010101010101B6E48460CECE98989898F72A00
        05010101C6C7C6B684CE2AE20101010101010101E6002A002AE2C60101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101C6C7B605CE54CE92E4C78AB2010101010101C6
        B684E6CE54CC98CC98CCE22A0098010101C6C7C6C784E22A0101010101010101
        B823B22AE10000B6010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101C6C7F8B68454
        23C701C760010101010101C78AB660CECE989898549854E22A002AFA010101C7
        C6C7CEE101010101010101C7608460CECE2A2A00E60101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101C6C7E4C70C2AB60101C701010101010101B68A92CE54CCB2CC
        98CE05E6982A00001E01010107C6B6CC01010101010101C69284920CCE23E218
        00E6010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101C7C6B6CCFA010101010101
        01010101E4B684CECE989898981EB6C7B6E6CC002AE2C6010101C6E601010101
        010101F88A8460CE0C9898E22A00B60101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010107C6B8B601010101010101010101C2E4B60C54CC98CCE2CC01C6C7B6B8CC
        E11800E6010101E401010101010101C69284920C545498CCE22A00B601010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101B6B60101010101010101010101B6E8E6
        CE9854E22AE20101C6FA9298CC2A2A009807010101010101010101C7848460CE
        CE98549854E22A00010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101C60101
        010101010101010101C6C2B6E623B2CC002A010101920598B223B22A002AFA01
        01010101010101C69284920C5423B29898CCE100E201E2C70101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101E8C78454CE982AE10101
        01E6E6989898CE98CC002A1E01010101010101F88A8460CECE989898549854F7
        00F42A00E6010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010107E8C70C54CC002A010101CEB854B2CC98CEE6CCE12A01010101010101C6
        9284920C54CC98CC9854E6E6982AE22A00E2F801010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101C7C6B60C982A0001010198E698CC9854CE
        60CE2AE201010101010101C78A8460CECE985498CC98E6C7C60554E22A002AFA
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101C7E8BFCE
        E200F60101CC1E98B2CC98CEE60CE22A01010101010101C6928492CE98CCB298
        B22A2201F8B6BF54B22A00001EC6010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101C7C6B65400F71EC7E254985498CECE60CECCE201010101
        010101F88A8460CECE985498CC00B60101C7B6E65498CCF72AE2F80101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101C6C7E8BFCC0000002A98CC
        B2CC98CE920CE22A01010101010101C6928492CE98CC9823E200FA01010105E6
        98CC98CCE22A00E6010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101C6C7C6E654E2CC9854989898CECE60CE16E201010101010101C7848460CE
        CE985498CC00B601010192E6CE985498CE982A00980101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101C6C7E4BFCE98CCB2CC9823540C920CE22A
        01010101010101C6928492CE98CC9854E200FA010101B8E698CCB254540C982A
        E201010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101C6C7C6B6
        929898985498CECE60CECCE201010101010101F88A8460CECE98CE98CC00B601
        0101E6E6CE989898CECE602A1601010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101C6C7C6C7E698CC98CEE66092CEE2E601010101010101C6
        928492CE98CC98CEE200FA010101B8CEB8CC98CC540CE62AE201010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101F8C6C7B6E6CECE0CE6
        60CE16FA01010101010101C7848460CECE985498CC00B6010101E6E6CE985498
        CECE0CE22A010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010107E4C7B6C784BF84840C98C601010101010101C6928492CE98CC9854
        E20022010101B8E6B823B298540C922AE2010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101C6C7C6C7E8B6E492840101010101
        010101F88A8460CECE98CE98CC00B6010101E6E6CE985498CECE602A16010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        07C6C7E8C7C6010101010101010101C6928492CE98CC9854B200FA010101B8CE
        B85498CC540CE62AE20101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101C7848460CE
        CE985498CC00B6010101E6E6CE985498CECE0CE22A0101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101C6928492CE98CC9854E20022010101B8E6B823B298540C922A
        E201010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101F88A8460CECE98CE98CC00B601
        0101E6E6CE985498CECE602A1601010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101010101C6
        BF8492CE54CC98CEB200FA010101B8CEB82398CC540CE62AE201010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101C78AB660CECE985498CC00B6010101E6E6CE985498
        CECE0CE22A010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101C6B68A92CE98CC9854
        E20022010101B8E6B823B298540C922AE2010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101E8B68ACECE985498CC00B6010101E6E6CE985498CECE602A16010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101C2E4B60C54CC9823E200FA010101B8CE
        B85498CC540CE62AE20101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101C6B6E8E6
        CE985498CC00B6010101E6E6CE985498CECE0CE22A0101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101E8C284E623B2CCE20022010101B8E6B823B2CC540C922A
        E201010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101E8C78454CE98CC00B601
        0101E6E6CE985498CECE602A1601010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010107E8C79254CCE2001D010101B8CEB8CC98CC540CE62AE201010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101C7C6B69298CC0018010101541ECE985498
        CECE0CE22A010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101010101010101C7E8C7CE
        982A0000C7C6B29898CCB298540C922AE2010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101C7C6C792982A0018E22A9854989898CECE602A16010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010107C6C7B6B8CCE12AB2CC
        B2CC9823540CE62AE20101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010107C6C7C2FA8405921E54985498CECE0CE22A0101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101C6C7B6C7E4C7E698CCB254540C922A
        E201010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101B6E6CE989898CEE6602A1601010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101BF92B8CCB254B80CE62AE201010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010184E6CE985498
        CECE0CE22A010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101BF84E6CEB298540C922AE2010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101018A846054CE98CECE602A16010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101010101010101010101B684
        92CE98CC540CE62AE20101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101018AB660CECE98CECE0CE22A0101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101010101010101010101010101BF84920C54CC540C922A
        E201010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01018A8484CECE98CECE602A1601010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101B6E4B60C54CC540CE62AE201010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101C6C7E8B60C98
        CECE0CE22A010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101C6C7E8BF54540C922AE2010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010101010101C7C6B684E6602A16010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101C2B6C7B6922AE20101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101F8C6C7E4982A0101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101C6F892
        E201010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        01010101010101010101C6B6CE01010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101C60501010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010100000101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010100000101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101000001010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101000001010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0000010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010000010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010000010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010100000101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        010101010101010101010101010101010000}
      Stretch = True
      Transparent = True
      Visible = False
    end
    object edtVoucherID: TEdit
      Left = 456
      Top = 155
      Width = 33
      Height = 24
      HelpContext = 432019
      TabStop = False
      Enabled = False
      ReadOnly = True
      TabOrder = 2
      Text = 'edtVoucherID'
      Visible = False
      OnChange = edtVoucherIDChange
    end
    object edtUnitID: TEdit
      Left = 464
      Top = 256
      Width = 41
      Height = 24
      HelpContext = 432024
      TabStop = False
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      Text = 'edtPartID'
      Visible = False
      OnChange = edtUnitIDChange
    end
  end
  object pnlMediaHost: TPanel [29]
    Left = 518
    Top = 180
    Width = 185
    Height = 96
    HelpContext = 432094
    Caption = 'pnlMediaHost'
    TabOrder = 16
    object pnlDisplay: TPanel
      Left = 0
      Top = 55
      Width = 185
      Height = 41
      HelpContext = 432095
      Caption = 'pnlDisplay'
      TabOrder = 0
      OnMouseDown = pnlDisplayMouseDown
    end
    object Player: TMediaPlayer
      Left = 0
      Top = 6
      Width = 253
      Height = 30
      HelpContext = 432096
      DoubleBuffered = True
      Display = pnlDisplay
      Shareable = True
      ParentDoubleBuffered = False
      TabOrder = 1
      OnNotify = PlayerNotify
    end
  end
  object Panel1: TDNMPanel [30]
    Left = 394
    Top = 646
    Width = 209
    Height = 36
    HelpContext = 432020
    Anchors = [akRight, akBottom]
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Caption = 'Panel1'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object lblRunTot: TLabel
      Left = 2
      Top = 2
      Width = 205
      Height = 32
      HelpContext = 432021
      Align = alClient
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'lblRunTot'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -32
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = -1
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 0
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 64
    Top = 96
  end
  inherited MyConnection: TERPConnection
    Username = ''
    Password = ''
    Left = 96
  end
  inherited DataState: TDataState
    Left = 0
  end
  object POSMenu: TAdvMainMenu [39]
    MenuStyler = MainMenuStyler
    Version = '2.5.3.4'
    Left = 163
    Top = 9
    object File1: TMenuItem
      AutoHotkeys = maManual
      Caption = '&File'
      HelpContext = 432082
      object mnuCustomPOS: TMenuItem
        Caption = 'Customi&se POS ...'
        HelpContext = 432083
        OnClick = mnuCustomPOSClick
      end
      object mnuCustomiseList: TMenuItem
        Caption = 'Customise List'
        HelpContext = 432084
        OnClick = mnuCustomiseListClick
      end
      object N2: TMenuItem
        Caption = '-'
        HelpContext = 432085
      end
      object mnuExitPOS: TMenuItem
        Caption = 'E&xit POS'
        HelpContext = 432086
        OnClick = mnuExitPOSClick
      end
    end
    object DrillDownLists1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Drill Down Lists'
      HelpContext = 432087
      object ProductList1: TMenuItem
        Caption = 'Drill Down &Product List'
        HelpContext = 432088
        OnClick = ProductList1Click
      end
      object CustomerList1: TMenuItem
        Caption = 'Drill Down &Customer List'
        HelpContext = 432089
        OnClick = CustomerList1Click
      end
    end
    object Repair: TMenuItem
      Caption = '&Repair'
      HelpContext = 432090
      Visible = False
    end
    object RepairList: TMenuItem
      Caption = 'Repair &List'
      HelpContext = 432091
      Visible = False
    end
    object Appointment: TMenuItem
      Caption = '&Appointment'
      HelpContext = 432092
      OnClick = AppointmentClick
    end
  end
  object dlgPassword: TCustomInputBox [40]
    Caption = 'Enter Password'
    PasswordCharacter = '*'
    EditBoxFont.Charset = ANSI_CHARSET
    EditBoxFont.Color = clWindowText
    EditBoxFont.Height = -24
    EditBoxFont.Name = 'Arial'
    EditBoxFont.Style = [fsBold]
    Message = 'Password'
    MessageFont.Charset = ANSI_CHARSET
    MessageFont.Color = clWindowText
    MessageFont.Height = -21
    MessageFont.Name = 'Arial'
    MessageFont.Style = [fsBold]
    Buttons = [sbOK, sbCancel]
    Width = 350
    Height = 180
    Color = 15527129
    Left = 33
    Top = 93
  end
  object qryProduct: TERPQuery [41]
    SQL.Strings = (
      'SELECT PARTSDESCRIPTION, PARTTYPE, PARTNAME, PRICE1,'
      'PRODUCTCODE, PRODUCTGROUP, COST1, SNTracking,'
      'BARCODE, TAXCODE, PURCHTAXCODE, PARTSID, INCOMEACCNT,'
      
        'ASSETACCNT, COGSACCNT, SpecialDiscount, Area,AvgCost FROM tblpar' +
        'ts'
      'Where PARTSID =:ID;')
    Options.LongStrings = False
    Left = 86
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
  object MainMenuStyler: TAdvMenuFantasyStyler [42]
    AntiAlias = aaNone
    Style = fsWindowsClassic
    Background.Position = bpTiled
    Background.Color = clMenu
    Background.ColorTo = clMenu
    Background.GradientDirection = gdHorizontal
    ButtonAppearance.CaptionFont.Charset = DEFAULT_CHARSET
    ButtonAppearance.CaptionFont.Color = clWindowText
    ButtonAppearance.CaptionFont.Height = -11
    ButtonAppearance.CaptionFont.Name = 'Tahoma'
    ButtonAppearance.CaptionFont.Style = []
    IconBar.Color = clMenu
    IconBar.ColorTo = clNone
    IconBar.CheckColor = clNone
    IconBar.CheckBorder = clNone
    IconBar.CheckGradientDirection = gdHorizontal
    IconBar.RadioColor = clNone
    IconBar.RadioBorder = clNone
    IconBar.RadioGradientDirection = gdHorizontal
    SelectedItem.Color = 10577994
    SelectedItem.GradientDirection = gdHorizontal
    SelectedItem.BorderColor = clNone
    SelectedItem.Font.Charset = DEFAULT_CHARSET
    SelectedItem.Font.Color = clWhite
    SelectedItem.Font.Height = -11
    SelectedItem.Font.Name = 'Tahoma'
    SelectedItem.Font.Style = []
    SelectedItem.NotesFont.Charset = DEFAULT_CHARSET
    SelectedItem.NotesFont.Color = clWindowText
    SelectedItem.NotesFont.Height = -8
    SelectedItem.NotesFont.Name = 'Tahoma'
    SelectedItem.NotesFont.Style = []
    SelectedItem.UseSystemFont = False
    SelectedItem.CheckColor = clNone
    SelectedItem.CheckBorder = clNone
    SelectedItem.CheckGradientDirection = gdHorizontal
    SelectedItem.RadioColor = clNone
    SelectedItem.RadioBorder = clNone
    RootItem.Color = clMenu
    RootItem.ColorTo = clNone
    RootItem.GradientDirection = gdVertical
    RootItem.Font.Charset = DEFAULT_CHARSET
    RootItem.Font.Color = clBlack
    RootItem.Font.Height = -11
    RootItem.Font.Name = 'Tahoma'
    RootItem.Font.Style = []
    RootItem.UseSystemFont = False
    RootItem.SelectedColor = 10577994
    RootItem.SelectedColorTo = clNone
    RootItem.SelectedBorderColor = clNone
    RootItem.SelectedTextColor = clWhite
    RootItem.HoverColor = 10577994
    RootItem.HoverColorTo = clNone
    RootItem.HoverBorderColor = clNone
    RootItem.HoverTextColor = clWhite
    Glyphs.SubMenu.Data = {
      5A000000424D5A000000000000003E0000002800000004000000070000000100
      0100000000001C0000000000000000000000020000000200000000000000FFFF
      FF0070000000300000001000000000000000100000003000000070000000}
    Glyphs.Check.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FDFF0000F8FF0000F07F0000F23F
      0000F71F0000FF8F0000FFCF0000FFEF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    Glyphs.Radio.Data = {
      7E000000424D7E000000000000003E0000002800000010000000100000000100
      010000000000400000000000000000000000020000000200000000000000FFFF
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FC3F0000F81F0000F81F
      0000F81F0000F81F0000FC3F0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000}
    SideBar.Caption = 'TMS Menu'
    SideBar.Font.Charset = DEFAULT_CHARSET
    SideBar.Font.Color = clWhite
    SideBar.Font.Height = -19
    SideBar.Font.Name = 'Tahoma'
    SideBar.Font.Style = [fsBold, fsItalic]
    SideBar.Visible = True
    SideBar.Image.Position = bpCenter
    SideBar.Image.Color = 15582889
    SideBar.Image.ColorTo = 6956042
    SideBar.Background.Position = bpCenter
    SideBar.Background.GradientDirection = gdHorizontal
    SideBar.SplitterColorTo = clBlack
    Separator.Color = clBlack
    Separator.GradientType = gtBoth
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clGray
    NotesFont.Height = -8
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    UseSystemFont = False
    MenuBorderColor = clBlack
    Left = 155
    Top = 47
  end
  object FontDialog: TFontDialog [43]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 216
    Top = 65528
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    MenuStyler = MainMenuStyler
    Left = 127
    inherited CustomiseGrid: TMenuItem
      Visible = False
    end
  end
  inherited imgsort: TImageList
    Left = 12
    Top = 92
    Bitmap = {
      494C0101020054014C0210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object tmrMedia: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrMediaTimer
    Left = 548
    Top = 216
  end
end
