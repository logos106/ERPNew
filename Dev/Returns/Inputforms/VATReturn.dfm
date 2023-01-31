inherited VATReturnGUI: TVATReturnGUI
  Left = 1739
  Top = 103
  HelpContext = 547000
  Caption = 'VAT Return'
  ClientHeight = 548
  ClientWidth = 722
  Color = clWhite
  OldCreateOrder = True
  ExplicitLeft = 1739
  ExplicitTop = 103
  ExplicitWidth = 730
  ExplicitHeight = 575
  DesignSize = (
    722
    548)
  PixelsPerInch = 96
  TextHeight = 15
  object Label73: TLabel [1]
    Left = 37
    Top = 50
    Width = 78
    Height = 15
    HelpContext = 547002
    Caption = 'For the peroid'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [2]
    Left = 673
    Top = 515
    Width = 38
    Height = 14
    HelpContext = 547003
    Alignment = taCenter
    Anchors = [akBottom]
    AutoSize = False
    Caption = 'Active'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
  end
  object lblMethod: TLabel [3]
    Left = 455
    Top = 49
    Width = 229
    Height = 15
    HelpContext = 547004
    Alignment = taRightJustify
    Caption = 'Accounting Method Non-Cash (Accruals)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 547001
  end
  object btnCompleted: TDNMSpeedButton [6]
    Left = 21
    Top = 517
    Width = 87
    Height = 27
    HelpContext = 547006
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = btnCompletedClick
  end
  object BtnRefresh: TDNMSpeedButton [7]
    Left = 235
    Top = 517
    Width = 87
    Height = 27
    HelpContext = 547007
    Anchors = [akBottom]
    Caption = 'Re&fresh'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BtnRefreshClick
  end
  object btnPrint: TDNMSpeedButton [8]
    Left = 450
    Top = 517
    Width = 87
    Height = 27
    HelpContext = 547008
    Anchors = [akBottom]
    Caption = 'Prin&t'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnPrintClick
  end
  object btnClose: TDNMSpeedButton [9]
    Left = 558
    Top = 517
    Width = 87
    Height = 27
    HelpContext = 547009
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
    OnClick = btnCloseClick
  end
  object chkActive: TwwCheckBox [10]
    Left = 684
    Top = 528
    Width = 15
    Height = 14
    HelpContext = 547010
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
    NullAndBlankState = cbChecked
    Anchors = [akBottom]
    Checked = True
    DataField = 'Active'
    DataSource = DSMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 5
  end
  object Panel1: TPanel [11]
    Left = 84
    Top = 115
    Width = 541
    Height = 41
    HelpContext = 547011
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 6
    DesignSize = (
      541
      41)
    object Label77: TLabel
      Left = 12
      Top = 7
      Width = 333
      Height = 27
      HelpContext = 547012
      AutoSize = False
      Caption = 'VAT due in this period on sales and other outputs'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Button2: TDNMSpeedButton
      Left = 375
      Top = 7
      Width = 32
      Height = 26
      HelpContext = 547013
      Anchors = [akTop]
      Caption = '1'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ShadowColor = clBtnShadow
      SlowDecease = True
      TabOrder = 0
      TabStop = False
      OnClick = Button2Click
    end
    object VAT1: TDBEdit
      Left = 425
      Top = 9
      Width = 102
      Height = 23
      HelpContext = 547014
      Anchors = [akTop, akRight]
      DataField = 'VAT1'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnDblClick = VATDblClick
    end
  end
  object Panel2: TPanel [12]
    Left = 84
    Top = 159
    Width = 541
    Height = 41
    HelpContext = 547015
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 7
    DesignSize = (
      541
      41)
    object Label78: TLabel
      Left = 12
      Top = 6
      Width = 279
      Height = 28
      HelpContext = 547016
      AutoSize = False
      Caption = 
        'VAT due in this period on acquisitions from other EC Member Stat' +
        'es'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 375
      Top = 7
      Width = 32
      Height = 26
      HelpContext = 547017
      Anchors = [akTop]
      Caption = '2'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ShadowColor = clBtnShadow
      SlowDecease = True
      TabOrder = 0
      TabStop = False
      OnClick = DNMSpeedButton1Click
    end
    object VAT2: TDBEdit
      Left = 425
      Top = 9
      Width = 102
      Height = 23
      HelpContext = 547018
      Anchors = [akTop, akRight]
      DataField = 'VAT2'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnDblClick = VATDblClick
    end
  end
  object Panel3: TPanel [13]
    Left = 84
    Top = 203
    Width = 541
    Height = 41
    HelpContext = 547019
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 8
    DesignSize = (
      541
      41)
    object Label79: TLabel
      Left = 12
      Top = 8
      Width = 354
      Height = 27
      HelpContext = 547020
      AutoSize = False
      Caption = 'Total VAT due (the sum of boxes 1 and 2)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label21: TLabel
      Left = 375
      Top = 9
      Width = 32
      Height = 26
      HelpContext = 547021
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = '3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      Layout = tlCenter
    end
    object VAT3: TDBEdit
      Left = 425
      Top = 9
      Width = 102
      Height = 23
      HelpContext = 547022
      Anchors = [akTop, akRight]
      DataField = 'VAT3'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Panel4: TPanel [14]
    Left = 84
    Top = 247
    Width = 541
    Height = 41
    HelpContext = 547023
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 9
    DesignSize = (
      541
      41)
    object Label80: TLabel
      Left = 12
      Top = 5
      Width = 354
      Height = 29
      HelpContext = 547024
      AutoSize = False
      Caption = 
        'VAT reclaimed in this period on purchases and other inputs (incl' +
        'uding acquisitions from the EC)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object DNMSpeedButton3: TDNMSpeedButton
      Left = 375
      Top = 7
      Width = 32
      Height = 26
      HelpContext = 547025
      Anchors = [akTop]
      Caption = '4'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ShadowColor = clBtnShadow
      SlowDecease = True
      TabOrder = 0
      TabStop = False
      OnClick = DNMSpeedButton3Click
    end
    object VAT4: TDBEdit
      Left = 425
      Top = 9
      Width = 102
      Height = 23
      HelpContext = 547026
      Anchors = [akTop, akRight]
      DataField = 'VAT4'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnDblClick = VATDblClick
    end
  end
  object Panel5: TPanel [15]
    Left = 84
    Top = 291
    Width = 541
    Height = 41
    HelpContext = 547027
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 10
    DesignSize = (
      541
      41)
    object Label81: TLabel
      Left = 12
      Top = 7
      Width = 292
      Height = 28
      HelpContext = 547028
      AutoSize = False
      Caption = 
        'Net VAT to be paid to Customs or reclaimed by you (Difference be' +
        'tween boxes 3 and 4)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label3: TLabel
      Left = 375
      Top = 9
      Width = 32
      Height = 26
      HelpContext = 547029
      Alignment = taCenter
      Anchors = [akTop]
      AutoSize = False
      Caption = '5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = False
      Layout = tlCenter
    end
    object VAT5: TDBEdit
      Left = 425
      Top = 9
      Width = 102
      Height = 23
      HelpContext = 547030
      Anchors = [akTop, akRight]
      DataField = 'VAT5'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Panel6: TPanel [16]
    Left = 84
    Top = 335
    Width = 541
    Height = 41
    HelpContext = 547031
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 11
    DesignSize = (
      541
      41)
    object Label82: TLabel
      Left = 12
      Top = 6
      Width = 325
      Height = 29
      HelpContext = 547032
      AutoSize = False
      Caption = 
        'Total value of sales and all other outputs excluding any VAT.  I' +
        'nclude your box 8 figure'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object DNMSpeedButton5: TDNMSpeedButton
      Left = 376
      Top = 7
      Width = 32
      Height = 26
      HelpContext = 547033
      Anchors = [akTop]
      Caption = '6'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ShadowColor = clBtnShadow
      SlowDecease = True
      TabOrder = 0
      TabStop = False
      OnClick = DNMSpeedButton5Click
    end
    object VAT6: TDBEdit
      Left = 425
      Top = 9
      Width = 102
      Height = 23
      HelpContext = 547034
      Anchors = [akTop, akRight]
      DataField = 'VAT6'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnDblClick = VATDblClick
    end
  end
  object Panel7: TPanel [17]
    Left = 84
    Top = 379
    Width = 541
    Height = 41
    HelpContext = 547035
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 12
    DesignSize = (
      541
      41)
    object Label83: TLabel
      Left = 12
      Top = 6
      Width = 325
      Height = 29
      HelpContext = 547036
      AutoSize = False
      Caption = 
        'Total value of purchases and all other inputs excluding any VAT.' +
        ' Including your box 9 figure'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object DNMSpeedButton6: TDNMSpeedButton
      Left = 376
      Top = 7
      Width = 32
      Height = 26
      HelpContext = 547037
      Anchors = [akTop]
      Caption = '7'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ShadowColor = clBtnShadow
      SlowDecease = True
      TabOrder = 0
      TabStop = False
      OnClick = DNMSpeedButton6Click
    end
    object VAT7: TDBEdit
      Left = 425
      Top = 9
      Width = 102
      Height = 23
      HelpContext = 547038
      Anchors = [akTop, akRight]
      DataField = 'VAT7'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnDblClick = VATDblClick
    end
  end
  object Panel8: TPanel [18]
    Left = 84
    Top = 423
    Width = 541
    Height = 41
    HelpContext = 547039
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 13
    DesignSize = (
      541
      41)
    object Label84: TLabel
      Left = 12
      Top = 5
      Width = 325
      Height = 29
      HelpContext = 547040
      AutoSize = False
      Caption = 
        'Total value of all supplies of goods and related costs.  Excludi' +
        'ng any VAT. To other EC Member States.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object DNMSpeedButton7: TDNMSpeedButton
      Left = 376
      Top = 7
      Width = 32
      Height = 26
      HelpContext = 547041
      Anchors = [akTop]
      Caption = '8'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ShadowColor = clBtnShadow
      SlowDecease = True
      TabOrder = 0
      TabStop = False
      OnClick = DNMSpeedButton7Click
    end
    object VAT8: TDBEdit
      Left = 425
      Top = 9
      Width = 102
      Height = 23
      HelpContext = 547042
      Anchors = [akTop, akRight]
      DataField = 'VAT8'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnDblClick = VATDblClick
    end
  end
  object Panel9: TPanel [19]
    Left = 84
    Top = 467
    Width = 541
    Height = 41
    HelpContext = 547043
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 14
    DesignSize = (
      541
      41)
    object Label85: TLabel
      Left = 12
      Top = 5
      Width = 325
      Height = 29
      HelpContext = 547044
      AutoSize = False
      Caption = 
        'Total value of all acquisitions of goods and related costs.  Exc' +
        'luding any VAT. From other EC Member States'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object DNMSpeedButton8: TDNMSpeedButton
      Left = 376
      Top = 7
      Width = 32
      Height = 26
      HelpContext = 547045
      Anchors = [akTop]
      Caption = '9'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ShadowColor = clBtnShadow
      SlowDecease = True
      TabOrder = 0
      TabStop = False
      OnClick = DNMSpeedButton8Click
    end
    object VAT9: TDBEdit
      Left = 425
      Top = 9
      Width = 102
      Height = 23
      HelpContext = 547046
      Anchors = [akTop, akRight]
      DataField = 'VAT9'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnDblClick = VATDblClick
    end
  end
  object Panel10: TPanel [20]
    Left = 34
    Top = 67
    Width = 653
    Height = 42
    HelpContext = 547047
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 15
    DesignSize = (
      653
      42)
    object YearLabel: TLabel
      Left = 436
      Top = 16
      Width = 78
      Height = 15
      HelpContext = 547048
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Current Year'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object MonthLabel: TLabel
      Left = 212
      Top = 16
      Width = 102
      Height = 15
      HelpContext = 547049
      Alignment = taRightJustify
      Anchors = [akTop]
      Caption = 'Quarter beginning'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Period: TwwRadioGroup
      Left = 15
      Top = 15
      Width = 186
      Height = 20
      HelpContext = 547050
      DisableThemes = False
      TransparentActiveItem = True
      Frame.Transparent = True
      ButtonFrame.Transparent = True
      ShowGroupCaption = False
      ShowFocusRect = False
      Transparent = True
      Columns = 2
      DataField = 'Type'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      Items.Strings = (
        'Quarterly'
        'Monthly')
      ParentFont = False
      TabOrder = 0
      OnChange = PeriodChange
    end
    object Month: TwwDBComboBox
      Left = 316
      Top = 12
      Width = 120
      Height = 24
      HelpContext = 547051
      Anchors = [akTop]
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'Month'
      DataSource = DSMaster
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      ParentFont = False
      Sorted = False
      TabOrder = 1
      UnboundDataType = wwDefault
    end
    object Year: TwwDBComboBox
      Left = 516
      Top = 12
      Width = 120
      Height = 24
      HelpContext = 547052
      Anchors = [akTop, akRight]
      ShowButton = True
      Style = csDropDown
      MapList = False
      AllowClearKey = False
      DataField = 'Year'
      DataSource = DSMaster
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        '2000'
        '2001'
        '2002'
        '2003'
        '2004'
        '2005'
        '2006'
        '2007'
        '2008'
        '2009'
        '2010'
        '2011'
        '2012'
        '2013'
        '2014'
        '2015'
        '2016'
        '2017'
        '2018'
        '2019'
        '2020')
      ParentFont = False
      Sorted = False
      TabOrder = 2
      UnboundDataType = wwDefault
    end
  end
  object pnlTitle: TDNMPanel [21]
    Left = 244
    Top = 3
    Width = 238
    Height = 45
    HelpContext = 547053
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 41
      HelpContext = 547054
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
        Width = 234
        Height = 41
        HelpContext = 547055
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'VAT Return'
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
  object btnOptions: TDNMSpeedButton [22]
    Left = 128
    Top = 517
    Width = 87
    Height = 27
    HelpContext = 547005
    Anchors = [akBottom]
    Caption = '&Options'
    DisableTransparent = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = btnOptionsClick
  end
  object btnElectronic: TDNMSpeedButton [23]
    Left = 342
    Top = 514
    Width = 87
    Height = 28
    HelpContext = 547056
    Anchors = [akRight, akBottom]
    Caption = 'Electronic'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 17
    Visible = False
    OnClick = btnElectronicClick
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblvatreturns'
      'WHERE ID = :ID;'
      '')
    Left = 8
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblvatreturns.GlobalRef'
      Size = 255
    end
    object tblMasterID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblvatreturns.ID'
    end
    object tblMasterType: TWideStringField
      FieldName = 'Type'
      Origin = 'tblvatreturns.Type'
      Size = 50
    end
    object tblMasterMonth: TWideStringField
      FieldName = 'Month'
      Origin = 'tblvatreturns.Month'
      Size = 50
    end
    object tblMasterYear: TIntegerField
      FieldName = 'Year'
      Origin = 'tblvatreturns.Year'
    end
    object tblMasterAccMethod: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'AccMethod'
      Origin = 'tblvatreturns.AccMethod'
      FixedChar = True
      Size = 7
    end
    object tblMasterAllClass: TWideStringField
      FieldName = 'AllClass'
      Origin = 'tblvatreturns.AllClass'
      FixedChar = True
      Size = 1
    end
    object tblMasterClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblvatreturns.ClassID'
    end
    object tblMasterVAT1: TFloatField
      FieldName = 'VAT1'
      Origin = 'tblvatreturns.VAT1'
      OnChange = tblMasterVAT1Change
      currency = True
    end
    object tblMasterVAT1Selected: TWideStringField
      FieldName = 'VAT1Selected'
      Origin = 'tblvatreturns.VAT1Selected'
      Size = 50
    end
    object tblMasterVAT2: TFloatField
      FieldName = 'VAT2'
      Origin = 'tblvatreturns.VAT2'
      OnChange = tblMasterVAT1Change
      currency = True
    end
    object tblMasterVAT2Selected: TWideStringField
      FieldName = 'VAT2Selected'
      Origin = 'tblvatreturns.VAT2Selected'
      Size = 50
    end
    object tblMasterVAT3: TFloatField
      FieldName = 'VAT3'
      Origin = 'tblvatreturns.VAT3'
      currency = True
    end
    object tblMasterVAT3Selected: TWideStringField
      FieldName = 'VAT3Selected'
      Origin = 'tblvatreturns.VAT3Selected'
      Size = 50
    end
    object tblMasterVAT4: TFloatField
      FieldName = 'VAT4'
      Origin = 'tblvatreturns.VAT4'
      OnChange = tblMasterVAT1Change
      currency = True
    end
    object tblMasterVAT4Selected: TWideStringField
      FieldName = 'VAT4Selected'
      Origin = 'tblvatreturns.VAT4Selected'
      Size = 50
    end
    object tblMasterVAT5: TFloatField
      FieldName = 'VAT5'
      Origin = 'tblvatreturns.VAT5'
      currency = True
    end
    object tblMasterVAT5Selected: TWideStringField
      FieldName = 'VAT5Selected'
      Origin = 'tblvatreturns.VAT5Selected'
      Size = 50
    end
    object tblMasterVAT6: TFloatField
      FieldName = 'VAT6'
      Origin = 'tblvatreturns.VAT6'
      OnChange = tblMasterVAT1Change
      currency = True
    end
    object tblMasterVAT6Selected: TWideStringField
      FieldName = 'VAT6Selected'
      Origin = 'tblvatreturns.VAT6Selected'
      Size = 50
    end
    object tblMasterVAT7: TFloatField
      FieldName = 'VAT7'
      Origin = 'tblvatreturns.VAT7'
      OnChange = tblMasterVAT1Change
      currency = True
    end
    object tblMasterVAT7Selected: TWideStringField
      FieldName = 'VAT7Selected'
      Origin = 'tblvatreturns.VAT7Selected'
      Size = 50
    end
    object tblMasterVAT8: TFloatField
      FieldName = 'VAT8'
      Origin = 'tblvatreturns.VAT8'
      OnChange = tblMasterVAT1Change
      currency = True
    end
    object tblMasterVAT8Selected: TWideStringField
      FieldName = 'VAT8Selected'
      Origin = 'tblvatreturns.VAT8Selected'
      Size = 50
    end
    object tblMasterVAT9: TFloatField
      FieldName = 'VAT9'
      Origin = 'tblvatreturns.VAT9'
      OnChange = tblMasterVAT1Change
      currency = True
    end
    object tblMasterVAT9Selected: TWideStringField
      FieldName = 'VAT9Selected'
      Origin = 'tblvatreturns.VAT9Selected'
      Size = 255
    end
    object tblMasterActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblvatreturns.Active'
      FixedChar = True
      Size = 1
    end
    object tblMasterVATDesc: TWideStringField
      FieldName = 'VATDesc'
      Size = 255
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 8
    Top = 151
  end
  object CustomInputBox: TCustomInputBox
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
    Left = 38
    Top = 36
  end
end
