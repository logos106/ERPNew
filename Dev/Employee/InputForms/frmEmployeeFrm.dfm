inherited frmEmployee: TfrmEmployee
  Left = 218
  Top = 165
  HelpContext = 267000
  Caption = 'Employee Settings'
  ClientHeight = 558
  ClientWidth = 998
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 1004
  ExplicitHeight = 587
  DesignSize = (
    998
    558)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 558
    Width = 998
    HelpContext = 267024
    ExplicitTop = 558
    ExplicitWidth = 998
  end
  object Label1: TLabel [1]
    Left = 208
    Top = 30
    Width = 41
    Height = 15
    HelpContext = 267002
    Caption = 'Search'
    Transparent = True
    Visible = False
  end
  object Bevel1: TBevel [2]
    Left = 177
    Top = 0
    Width = 9
    Height = 557
    HelpContext = 267003
    Anchors = [akLeft, akTop, akBottom]
    Shape = bsLeftLine
  end
  object Label2: TLabel [3]
    Left = 185
    Top = 10
    Width = 48
    Height = 15
    HelpContext = 267004
    Alignment = taCenter
    AutoSize = False
    Caption = 'Scroll'
    Transparent = True
    Visible = False
  end
  object imgPrefs: TImage [4]
    Left = 183
    Top = 31
    Width = 48
    Height = 105
    HelpContext = 267005
    Visible = False
  end
  inherited imgGridWatermark: TImage
    Left = 196
    Top = 511
    HelpContext = 267001
    ExplicitLeft = 196
    ExplicitTop = 511
  end
  object Shader1: TShader [9]
    Left = 184
    Top = 58
    Width = 804
    Height = 30
    HelpContext = 267012
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 2
    FromColor = clBtnFace
    ToColor = clWhite
    FromColorMirror = clWhite
    ToColorMirror = clBtnFace
    Steps = 10
    Direction = False
    Version = '1.4.0.0'
    object pnlActiveForm: TLabel
      Left = 0
      Top = 0
      Width = 804
      Height = 30
      HelpContext = 267013
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitLeft = -1
    end
  end
  object pnlTitle: TDNMPanel [10]
    Left = 410
    Top = 6
    Width = 392
    Height = 45
    HelpContext = 267014
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 388
      Height = 41
      HelpContext = 267015
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
        Width = 388
        Height = 41
        HelpContext = 267016
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Employee'
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
  object sbButtons: TScrollBox [11]
    Left = 0
    Top = 0
    Width = 177
    Height = 557
    HelpContext = 267006
    HorzScrollBar.Visible = False
    Anchors = [akLeft, akTop, akBottom]
    BorderStyle = bsNone
    TabOrder = 1
    object pnlButtons: TDNMPanel
      Left = 0
      Top = 0
      Width = 160
      Height = 556
      HelpContext = 267007
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Transparent = False
    end
  end
  object OptionScrollbox: TScrollBox [12]
    Left = 183
    Top = 94
    Width = 804
    Height = 425
    HelpContext = 267008
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvLowered
    BevelKind = bkSoft
    BorderStyle = bsNone
    DragMode = dmAutomatic
    TabOrder = 4
    OnDblClick = OptionScrollboxDblClick
    OnResize = OptionScrollboxResize
  end
  object pnlBottom: TDNMPanel [13]
    Left = 183
    Top = 522
    Width = 734
    Height = 34
    HelpContext = 267027
    Anchors = [akLeft, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    DesignSize = (
      734
      34)
    object btnOK: TDNMSpeedButton
      Left = 4
      Top = 3
      Width = 83
      Height = 27
      HelpContext = 267009
      Anchors = [akBottom]
      Caption = 'Save'
      Default = True
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
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnOKClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 100
      Top = 3
      Width = 83
      Height = 27
      HelpContext = 267017
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
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdNewClick
    end
    object cmdPrint: TDNMSpeedButton
      Left = 195
      Top = 3
      Width = 83
      Height = 27
      HelpContext = 267018
      Anchors = [akBottom]
      Caption = 'Prin&t'
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = cmdPrintClick
    end
    object cmdPassword: TDNMSpeedButton
      Left = 289
      Top = 3
      Width = 83
      Height = 27
      HelpContext = 267021
      Anchors = [akBottom]
      Caption = 'Passwor&d'
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
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = cmdPasswordClick
    end
    object btnSupplier: TDNMSpeedButton
      Left = 385
      Top = 3
      Width = 83
      Height = 27
      Hint = 'Make this Customer a Supplier'
      HelpContext = 267026
      Anchors = [akBottom]
      Caption = 'Make S&upp'
      DisableTransparent = False
      Font.Charset = RUSSIAN_CHARSET
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
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnSupplierClick
    end
    object btnPrintBarcode: TDNMSpeedButton
      Left = 481
      Top = 3
      Width = 83
      Height = 27
      HelpContext = 267020
      Anchors = [akBottom]
      Caption = 'Barcode'
      DisableTransparent = False
      Enabled = False
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
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnPrintBarcodeClick
    end
    object btnW4: TDNMSpeedButton
      Left = 570
      Top = 3
      Width = 83
      Height = 27
      HelpContext = 267020
      Anchors = [akBottom]
      Caption = 'W-4'
      DisableTransparent = False
      Enabled = False
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
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = btnW4Click
    end
    object btnCancel: TDNMSpeedButton
      Left = 658
      Top = 3
      Width = 83
      Height = 27
      HelpContext = 267010
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 6
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
  end
  object cboSearch: TwwDBComboBox [14]
    Left = 256
    Top = 26
    Width = 145
    Height = 23
    HelpContext = 267011
    ShowButton = True
    Style = csDropDown
    MapList = False
    AllowClearKey = False
    AutoDropDown = True
    ShowMatchText = True
    DropDownCount = 8
    DropDownWidth = 400
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    ParentFont = False
    Sorted = True
    TabOrder = 0
    UnboundDataType = wwDefault
    Visible = False
    OnCloseUp = cboSearchCloseUp
  end
  object DNMPanel1: TDNMPanel [15]
    Left = 919
    Top = 522
    Width = 68
    Height = 34
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object chkActive: TwwCheckBox
      Left = 4
      Top = 11
      Width = 59
      Height = 13
      HelpContext = 267023
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
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Active'
      TabOrder = 0
      OnClick = chkActiveClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 225
    Top = 300
  end
  inherited tmrdelay: TTimer
    Left = 323
    Top = 300
  end
  inherited popSpelling: TPopupMenu
    Left = 487
    Top = 300
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 356
    Top = 300
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 290
    Top = 300
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 189
    Top = 269
  end
  inherited DataState: TDataState
    Left = 454
    Top = 300
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 421
    Top = 300
  end
  inherited imgsort: TImageList
    Left = 257
    Top = 300
    Bitmap = {
      494C010102003401F40110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 202
    Top = 221
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 520
    Top = 300
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 388
    Top = 300
  end
  inherited qryMemTrans: TERPQuery
    Left = 258
    Top = 237
  end
  object qryemployee: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * From tblemployees'
      'Where EmployeeID=:xID;')
    AfterInsert = qryemployeeAfterInsert
    Left = 290
    Top = 237
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryemployeeEmployeeID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmployeeID'
      Origin = 'tblemployees.EmployeeID'
      ReadOnly = True
      OnChange = qryemployeeEmployeeIDChange
    end
    object qryemployeeTitle: TWideStringField
      FieldName = 'Title'
      Origin = 'tblemployees.Title'
      Size = 5
    end
    object qryemployeeFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'tblemployees.FirstName'
      Size = 40
    end
    object qryemployeeMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Origin = 'tblemployees.MiddleName'
      Size = 40
    end
    object qryemployeeLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblemployees.LastName'
      Size = 40
    end
    object qryemployeeABN: TWideStringField
      FieldName = 'ABN'
      Origin = 'tblemployees.ABN'
      Size = 15
    end
    object qryemployeeCanvasser: TWideStringField
      FieldName = 'Canvasser'
      Origin = 'tblemployees.Canvasser'
      FixedChar = True
      Size = 1
    end
    object qryemployeeRep: TWideStringField
      FieldName = 'Rep'
      Origin = 'tblemployees.Rep'
      FixedChar = True
      Size = 1
    end
    object qryemployeeDateStarted: TDateField
      FieldName = 'DateStarted'
      Origin = 'tblemployees.DateStarted'
    end
    object qryemployeeDateFinished: TDateField
      FieldName = 'DateFinished'
      Origin = 'tblemployees.DateFinished'
    end
    object qryemployeeNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblemployees.Notes'
      BlobType = ftWideMemo
    end
    object qryemployeeActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblemployees.Active'
      FixedChar = True
      Size = 1
    end
    object qryemployeeCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Origin = 'tblemployees.CUSTFLD1'
      Size = 50
    end
    object qryemployeeCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Origin = 'tblemployees.CUSTFLD2'
      Size = 50
    end
    object qryemployeeCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Origin = 'tblemployees.CUSTFLD3'
      Size = 50
    end
    object qryemployeeCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Origin = 'tblemployees.CUSTFLD4'
      Size = 50
    end
    object qryemployeeCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Origin = 'tblemployees.CUSTFLD5'
      Size = 50
    end
    object qryemployeeCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Origin = 'tblemployees.CUSTFLD6'
      Size = 50
    end
    object qryemployeeCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Origin = 'tblemployees.CUSTFLD7'
      Size = 50
    end
    object qryemployeeCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Origin = 'tblemployees.CUSTFLD8'
      Size = 50
    end
    object qryemployeeCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Origin = 'tblemployees.CUSTFLD9'
      Size = 50
    end
    object qryemployeeCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Origin = 'tblemployees.CUSTFLD10'
      Size = 50
    end
    object qryemployeeCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Origin = 'tblemployees.CUSTFLD11'
      Size = 50
    end
    object qryemployeeCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Origin = 'tblemployees.CUSTFLD12'
      Size = 50
    end
    object qryemployeeCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Origin = 'tblemployees.CUSTFLD13'
      Size = 50
    end
    object qryemployeeCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Origin = 'tblemployees.CUSTFLD14'
      Size = 50
    end
    object qryemployeeCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Origin = 'tblemployees.CUSTFLD15'
      Size = 50
    end
    object qryemployeeEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblemployees.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryemployeeEmployeeNo: TIntegerField
      FieldName = 'EmployeeNo'
      Origin = 'tblemployees.EmployeeNo'
    end
    object qryemployeeTFN: TWideStringField
      FieldName = 'TFN'
      Origin = 'tblemployees.TFN'
      Size = 15
    end
    object qryemployeeDOB: TDateField
      FieldName = 'DOB'
      Origin = 'tblemployees.DOB'
    end
    object qryemployeeInitials: TWideStringField
      FieldName = 'Initials'
      Origin = 'tblemployees.Initials'
      FixedChar = True
      Size = 3
    end
    object qryemployeeSex: TWideStringField
      FieldName = 'Sex'
      Origin = 'tblemployees.Sex'
      FixedChar = True
      Size = 11
    end
    object qryemployeeOptionNo: TWordField
      FieldName = 'OptionNo'
      Origin = 'tblemployees.OptionNo'
    end
    object qryemployeeTax: TFloatField
      FieldName = 'Tax'
      Origin = 'tblemployees.Tax'
    end
    object qryemployeeGross: TFloatField
      FieldName = 'Gross'
      Origin = 'tblemployees.Gross'
    end
    object qryemployeeNet: TFloatField
      FieldName = 'Net'
      Origin = 'tblemployees.Net'
    end
    object qryemployeeWages: TFloatField
      FieldName = 'Wages'
      Origin = 'tblemployees.Wages'
    end
    object qryemployeeCommission: TFloatField
      FieldName = 'Commission'
      Origin = 'tblemployees.Commission'
    end
    object qryemployeeDeductions: TFloatField
      FieldName = 'Deductions'
      Origin = 'tblemployees.Deductions'
    end
    object qryemployeeAllowances: TFloatField
      FieldName = 'Allowances'
      Origin = 'tblemployees.Allowances'
    end
    object qryemployeeSundries: TFloatField
      FieldName = 'Sundries'
      Origin = 'tblemployees.Sundries'
    end
    object qryemployeeSuper: TFloatField
      FieldName = 'Super'
      Origin = 'tblemployees.Super'
    end
    object qryemployeeCDEProject: TWideStringField
      FieldName = 'CDEProject'
      Origin = 'tblemployees.CDEProject'
      FixedChar = True
      Size = 1
    end
    object qryemployeeFringeBenefits: TFloatField
      FieldName = 'FringeBenefits'
      Origin = 'tblemployees.FringeBenefits'
    end
    object qryemployeeDaysPre01071983: TIntegerField
      FieldName = 'DaysPre01071983'
      Origin = 'tblemployees.DaysPre01071983'
    end
    object qryemployeeDaysPost30061983: TIntegerField
      FieldName = 'DaysPost30061983'
      Origin = 'tblemployees.DaysPost30061983'
    end
    object qryemployeeCGTExempt: TFloatField
      FieldName = 'CGTExempt'
      Origin = 'tblemployees.CGTExempt'
    end
    object qryemployeeNonQualifyingComponent: TFloatField
      FieldName = 'NonQualifyingComponent'
      Origin = 'tblemployees.NonQualifyingComponent'
    end
    object qryemployeeUndeductedContribution: TFloatField
      FieldName = 'UndeductedContribution'
      Origin = 'tblemployees.UndeductedContribution'
    end
    object qryemployeeConcessionalComponent: TFloatField
      FieldName = 'ConcessionalComponent'
      Origin = 'tblemployees.ConcessionalComponent'
    end
    object qryemployeeRepCode: TWideStringField
      FieldName = 'RepCode'
      Origin = 'tblemployees.RepCode'
      Size = 25
    end
    object qryemployeeResident: TWideStringField
      FieldName = 'Resident'
      Origin = 'tblemployees.Resident'
      FixedChar = True
      Size = 1
    end
    object qryemployeeTFNApplicationMade: TWideStringField
      FieldName = 'TFNApplicationMade'
      Origin = 'tblemployees.TFNApplicationMade'
      FixedChar = True
      Size = 1
    end
    object qryemployeeUnder18: TWideStringField
      FieldName = 'Under18'
      Origin = 'tblemployees.Under18'
      FixedChar = True
      Size = 1
    end
    object qryemployeePensioner: TWideStringField
      FieldName = 'Pensioner'
      Origin = 'tblemployees.Pensioner'
      FixedChar = True
      Size = 1
    end
    object qryemployeeIncomeType: TWideStringField
      FieldName = 'IncomeType'
      Origin = 'tblemployees.IncomeType'
      FixedChar = True
      Size = 1
    end
    object qryemployeeBasisOfPayment: TWideStringField
      FieldName = 'BasisOfPayment'
      Origin = 'tblemployees.BasisOfPayment'
      FixedChar = True
      Size = 1
    end
    object qryemployeeTaxFreeThreshold: TWideStringField
      FieldName = 'TaxFreeThreshold'
      Origin = 'tblemployees.TaxFreeThreshold'
      FixedChar = True
      Size = 1
    end
    object qryemployeeFamilyTaxBenefit: TWideStringField
      FieldName = 'FamilyTaxBenefit'
      Origin = 'tblemployees.FamilyTaxBenefit'
      FixedChar = True
      Size = 1
    end
    object qryemployeeZoneDependentSpecial: TWideStringField
      FieldName = 'ZoneDependentSpecial'
      Origin = 'tblemployees.ZoneDependentSpecial'
      FixedChar = True
      Size = 1
    end
    object qryemployeeHECSIndicator: TWideStringField
      FieldName = 'HECSIndicator'
      Origin = 'tblemployees.HECSIndicator'
      FixedChar = True
      Size = 1
    end
    object qryemployeeStudentLoanIndicator: TWideStringField
      FieldName = 'StudentLoanIndicator'
      Origin = 'tblemployees.StudentLoanIndicator'
      FixedChar = True
      Size = 1
    end
    object qryemployeeUseOfTFNForSuper: TWideStringField
      FieldName = 'UseOfTFNForSuper'
      Origin = 'tblemployees.UseOfTFNForSuper'
      FixedChar = True
      Size = 1
    end
    object qryemployeeAnnuitySuperPension: TWideStringField
      FieldName = 'AnnuitySuperPension'
      Origin = 'tblemployees.AnnuitySuperPension'
      FixedChar = True
      Size = 1
    end
    object qryemployeeSignaturePresent: TWideStringField
      FieldName = 'SignaturePresent'
      Origin = 'tblemployees.SignaturePresent'
      FixedChar = True
      Size = 1
    end
    object qryemployeeDateSigned: TDateField
      FieldName = 'DateSigned'
      Origin = 'tblemployees.DateSigned'
    end
    object qryemployeePayVia: TWideStringField
      FieldName = 'PayVia'
      Origin = 'tblemployees.PayVia'
      FixedChar = True
      Size = 1
    end
    object qryemployeeEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblemployees.EmployeeName'
      Size = 62
    end
    object qryemployeeReportsTo: TIntegerField
      FieldName = 'ReportsTo'
      Origin = 'tblemployees.ReportsTo'
    end
    object qryemployeePayPeriod: TWideStringField
      FieldName = 'PayPeriod'
      Origin = 'tblemployees.PayPeriod'
      Size = 11
    end
    object qryemployeeAward: TIntegerField
      FieldName = 'Award'
      Origin = 'tblemployees.Award'
    end
    object qryemployeeClassification: TWideStringField
      FieldName = 'Classification'
      Origin = 'tblemployees.Classification'
      Size = 255
    end
    object qryemployeeWorkersCompInsurer: TIntegerField
      FieldName = 'WorkersCompInsurer'
      Origin = 'tblemployees.WorkersCompInsurer'
    end
    object qryemployeeUseAward: TWideStringField
      FieldName = 'UseAward'
      Origin = 'tblemployees.UseAward'
      FixedChar = True
      Size = 1
    end
    object qryemployeeNextOfKin: TWideStringField
      FieldName = 'NextOfKin'
      Origin = 'tblemployees.NextOfKin'
      Size = 150
    end
    object qryemployeeNextOfKinRelationship: TWideStringField
      FieldName = 'NextOfKinRelationship'
      Origin = 'tblemployees.NextOfKinRelationship'
      Size = 100
    end
    object qryemployeeNextOfKinPhone: TWideStringField
      FieldName = 'NextOfKinPhone'
      Origin = 'tblemployees.NextOfKinPhone'
      EditMask = '## #### ####;0;_'
    end
    object qryemployeeTaxScaleID: TIntegerField
      FieldName = 'TaxScaleID'
      Origin = 'tblemployees.TaxScaleID'
    end
    object qryemployeeLeaveLoading: TFloatField
      DefaultExpression = '0.00'
      FieldName = 'LeaveLoading'
      Origin = 'tblemployees.LeaveLoading'
      DisplayFormat = '####0.00%'
      EditFormat = '####0.00'
    end
    object qryemployeeExtraTax: TFloatField
      FieldName = 'ExtraTax'
      Origin = 'tblemployees.ExtraTax'
    end
    object qryemployeeSickHours: TFloatField
      FieldName = 'SickHours'
      Origin = 'tblemployees.SickHours'
    end
    object qryemployeeALHours: TFloatField
      FieldName = 'ALHours'
      Origin = 'tblemployees.ALHours'
    end
    object qryemployeeLastPaid: TDateField
      FieldName = 'LastPaid'
      Origin = 'tblemployees.LastPaid'
    end
    object qryemployeeCommissionOnValue: TWideStringField
      FieldName = 'CommissionOnValue'
      Origin = 'tblemployees.CommissionOnValue'
      FixedChar = True
      Size = 9
    end
    object qryemployeeCommissionLastPaid: TDateField
      FieldName = 'CommissionLastPaid'
      Origin = 'tblemployees.CommissionLastPaid'
    end
    object qryemployeeGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblemployees.GlobalRef'
      Size = 255
    end
    object qryemployeePayNotes: TWideMemoField
      FieldName = 'PayNotes'
      Origin = 'tblemployees.PayNotes'
      BlobType = ftWideMemo
    end
    object qryemployeeIsOnTheRoster: TWideStringField
      FieldName = 'IsOnTheRoster'
      Origin = 'tblemployees.IsOnTheRoster'
      FixedChar = True
      Size = 1
    end
    object qryemployeeonPMRoster: TWideStringField
      FieldName = 'onPMRoster'
      Origin = 'tblemployees.onPMRoster'
      FixedChar = True
      Size = 1
    end
    object qryemployeeLoadHoursFromRoster: TWideStringField
      FieldName = 'LoadHoursFromRoster'
      Origin = 'tblemployees.LoadHoursFromRoster'
      FixedChar = True
      Size = 1
    end
    object qryemployeeLoadLeaveFromRoster: TWideStringField
      FieldName = 'LoadLeaveFromRoster'
      Origin = 'tblemployees.LoadLeaveFromRoster'
      FixedChar = True
      Size = 1
    end
    object qryemployeeMealBreakHours: TFloatField
      FieldName = 'MealBreakHours'
      Origin = 'tblemployees.MealBreakHours'
    end
    object qryemployeeMealBreakThreshold: TFloatField
      FieldName = 'MealBreakThreshold'
      Origin = 'tblemployees.MealBreakThreshold'
    end
    object qryemployeeAreaRange: TWideStringField
      FieldName = 'AreaRange'
      Origin = 'tblemployees.AreaRange'
      Size = 255
    end
    object qryemployeeEmpPicture: TBlobField
      FieldName = 'EmpPicture'
      Origin = 'tblemployees.EmpPicture'
    end
    object qryemployeePhotoIDVaildFromDate: TDateField
      FieldName = 'PhotoIDVaildFromDate'
      Origin = 'tblemployees.PhotoIDVaildFromDate'
    end
    object qryemployeePhotoIDVaildToDate: TDateField
      FieldName = 'PhotoIDVaildToDate'
      Origin = 'tblemployees.PhotoIDVaildToDate'
    end
    object qryemployeeCDEPWageTotal: TFloatField
      FieldName = 'CDEPWageTotal'
      Origin = 'tblemployees.CDEPWageTotal'
    end
    object qryemployeeIsTerminated: TWideStringField
      FieldName = 'IsTerminated'
      Origin = 'tblemployees.IsTerminated'
      FixedChar = True
      Size = 1
    end
    object qryemployeeDefaultClassName: TWideStringField
      FieldName = 'DefaultClassName'
      Origin = 'tblemployees.DefaultClassName'
      Size = 255
    end
    object qryemployeeDefaultClassID: TIntegerField
      FieldName = 'DefaultClassID'
      Origin = 'tblemployees.DefaultClassID'
    end
    object qryemployeeExtraTaxOptions: TWideStringField
      FieldName = 'ExtraTaxOptions'
      Origin = 'tblemployees.ExtraTaxOptions'
      FixedChar = True
      Size = 5
    end
    object qryemployeeUseClassificationAdvance: TWideStringField
      FieldName = 'UseClassificationAdvance'
      Origin = 'tblemployees.UseClassificationAdvance'
      FixedChar = True
      Size = 1
    end
    object qryemployeeLastPayPeriod: TSmallintField
      FieldName = 'LastPayPeriod'
      Origin = 'tblemployees.LastPayPeriod'
    end
    object qryemployeeCommissionFlatRate: TFloatField
      FieldName = 'CommissionFlatRate'
      Origin = 'tblemployees.CommissionFlatRate'
      DisplayFormat = '#0.00'
      EditFormat = '#0.00'
    end
    object qryemployeeCommissionInvoiceExPrice: TWideStringField
      FieldName = 'CommissionInvoiceExPrice'
      Origin = 'tblemployees.CommissionInvoiceExPrice'
      FixedChar = True
      Size = 1
    end
    object qryemployeeCommissionUseEmp: TWideStringField
      FieldName = 'CommissionUseEmp'
      Origin = 'tblemployees.CommissionUseEmp'
      FixedChar = True
      Size = 1
    end
    object qryemployeeCommissionUseProd: TWideStringField
      FieldName = 'CommissionUseProd'
      Origin = 'tblemployees.CommissionUseProd'
      FixedChar = True
      Size = 1
    end
    object qryemployeeDefaultInvoiceTemplateID: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
      Origin = 'tblemployees.DefaultInvoiceTemplateID'
    end
    object qryemployeePaySuperOnLeaveLoading: TWideStringField
      FieldName = 'PaySuperOnLeaveLoading'
      Origin = 'tblemployees.PaySuperOnLeaveLoading'
      Size = 1
    end
    object qryemployeeLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
      Origin = 'tblemployees.LastUpdated'
    end
    object qryemployeeSalesTarget: TFloatField
      FieldName = 'SalesTarget'
      Origin = 'tblemployees.SalesTarget'
      DisplayFormat = '#,###,##0.00'
      currency = True
    end
    object qryemployeeSendPaySlipViaEmail: TWideStringField
      FieldName = 'SendPaySlipViaEmail'
      Origin = 'tblemployees.SendPaySlipViaEmail'
      FixedChar = True
      Size = 1
    end
    object qryemployeeEmailsFromEmployeeAddress: TWideStringField
      FieldName = 'EmailsFromEmployeeAddress'
      Origin = 'tblemployees.EmailsFromEmployeeAddress'
      FixedChar = True
      Size = 1
    end
    object qryemployeeStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'tblemployees.Street'
      Size = 255
    end
    object qryemployeeStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'tblemployees.Street2'
      Size = 255
    end
    object qryemployeeSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'tblemployees.Suburb'
      Size = 255
    end
    object qryemployeePostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'tblemployees.Postcode'
      Size = 255
    end
    object qryemployeeState: TWideStringField
      FieldName = 'State'
      Origin = 'tblemployees.State'
      Size = 255
    end
    object qryemployeeCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'tblemployees.Country'
      Size = 255
    end
    object qryemployeePhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblemployees.Phone'
      Size = 255
    end
    object qryemployeeAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblemployees.AltPhone'
      Size = 255
    end
    object qryemployeeFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblemployees.FaxNumber'
      Size = 255
    end
    object qryemployeeMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblemployees.Mobile'
      Size = 255
    end
    object qryemployeeEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'tblemployees.Email'
      Size = 80
    end
    object qryemployeeAltContact: TWideStringField
      FieldName = 'AltContact'
      Origin = 'tblemployees.AltContact'
      Size = 255
    end
    object qryemployeeCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblemployees.Company'
      Size = 35
    end
    object qryemployeePosition: TWideStringField
      FieldName = 'Position'
      Origin = 'tblemployees.Position'
      Size = 30
    end
    object qryemployeeStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'tblemployees.Street3'
      Size = 255
    end
    object qryemployeeHECSTaxScale: TIntegerField
      FieldName = 'HECSTaxScale'
      Origin = 'tblemployees.HECSTaxScale'
    end
    object qryemployeeStudentLoanTaxScale: TIntegerField
      FieldName = 'StudentLoanTaxScale'
      Origin = 'tblemployees.StudentLoanTaxScale'
    end
    object qryemployeeWorkPhone: TWideStringField
      FieldName = 'WorkPhone'
      Origin = 'tblemployees.WorkPhone'
      Size = 255
    end
    object qryemployeeCommissionOn: TWideStringField
      FieldName = 'CommissionOn'
      Origin = 'tblemployees.CommissionOn'
      FixedChar = True
      Size = 1
    end
    object qryemployeeOverheadbaserate: TFloatField
      FieldName = 'Overheadbaserate'
      Origin = 'tblemployees.Overheadbaserate'
    end
    object qryemployeeCommissionOnPaid: TWideStringField
      FieldName = 'CommissionOnPaid'
      Origin = 'tblemployees.CommissionOnPaid'
      FixedChar = True
      Size = 1
    end
    object qryemployeeCallPriority: TIntegerField
      FieldName = 'CallPriority'
      Origin = 'tblemployees.CallPriority'
    end
    object qryemployeeDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Origin = 'tblemployees.DefaultContactMethod'
    end
    object qryemployeeSkypeName: TWideStringField
      FieldName = 'SkypeName'
      Origin = 'tblemployees.SkypeName'
      Size = 100
    end
    object qryemployeeTrackEmails: TWideStringField
      FieldName = 'TrackEmails'
      Origin = 'tblemployees.TrackEmails'
      FixedChar = True
      Size = 1
    end
    object qryemployeeArea: TWideStringField
      FieldName = 'Area'
      Origin = 'tblemployees.Area'
    end
    object qryemployeeGoogleEmail: TWideStringField
      FieldName = 'GoogleEmail'
      Origin = 'tblemployees.GoogleEmail'
      Size = 255
    end
    object qryemployeeGooglePassword: TWideStringField
      FieldName = 'GooglePassword'
      Origin = 'tblemployees.GooglePassword'
      Size = 255
    end
    object qryemployeeSynchWithGoogle: TWideStringField
      FieldName = 'SynchWithGoogle'
      Origin = 'tblemployees.SynchWithGoogle'
      FixedChar = True
      Size = 1
    end
    object qryemployeemsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblemployees.msTimeStamp'
    end
    object qryemployeemsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblemployees.msUpdateSiteCode'
      Size = 3
    end
    object qryemployeeClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblemployees.ClientID'
    end
    object qryemployeeGoogleRefreshPassword: TWideStringField
      FieldName = 'GoogleRefreshPassword'
      Origin = 'tblemployees.GoogleRefreshPassword'
      Size = 255
    end
    object qryemployeeOverheadRate: TFloatField
      FieldName = 'OverheadRate'
      Origin = 'tblemployees.OverheadRate'
    end
    object qryemployeeTrackSales: TWideStringField
      FieldName = 'TrackSales'
      Origin = 'tblemployees.TrackSales'
      FixedChar = True
      Size = 1
    end
    object qryemployeeAssessableTermination: TFloatField
      FieldName = 'AssessableTermination'
    end
    object qryemployeeCommissionUseBoth: TWideStringField
      FieldName = 'CommissionUseBoth'
      FixedChar = True
      Size = 1
    end
    object qryemployeeEmployeeTypeID: TIntegerField
      FieldName = 'EmployeeTypeID'
    end
    object qryemployeeCreationDate: TDateTimeField
      FieldName = 'CreationDate'
    end
  end
  object qryEmployeePaySplit: TERPQuery
    SQL.Strings = (
      'Select * From tblpaysplit'
      'Where EmployeeID=:xID;')
    Left = 543
    Top = 269
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryEmployeePaySplittype: TWideStringField
      FieldName = 'type'
    end
    object qryEmployeePaySplitBank: TWideStringField
      DisplayWidth = 7
      FieldKind = fkLookup
      FieldName = 'Bank'
      LookupDataSet = qryBankCodes
      LookupKeyFields = 'CodeID'
      LookupResultField = 'BankCode'
      KeyFields = 'BankID'
      Lookup = True
    end
    object qryEmployeePaySplitGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblpaysplit.GlobalRef'
      Size = 255
    end
    object qryEmployeePaySplitSplitID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'SplitID'
      Origin = 'tblpaysplit.SplitID'
    end
    object qryEmployeePaySplitEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblpaysplit.EmployeeID'
    end
    object qryEmployeePaySplitSplit: TWideStringField
      FieldName = 'Split'
      Origin = 'tblpaysplit.Split'
      FixedChar = True
      Size = 16
    end
    object qryEmployeePaySplitBankID: TIntegerField
      FieldName = 'BankID'
      Origin = 'tblpaysplit.BankID'
    end
    object qryEmployeePaySplitBranch: TWideStringField
      FieldName = 'Branch'
      Origin = 'tblpaysplit.Branch'
      Size = 100
    end
    object qryEmployeePaySplitBSB: TWideStringField
      FieldName = 'BSB'
      Origin = 'tblpaysplit.BSB'
      EditMask = '!>000\-000;1; '
      Size = 16
    end
    object qryEmployeePaySplitAccountNo: TWideStringField
      DisplayLabel = 'BankAccountNo'
      FieldName = 'AccountNo'
      Origin = 'tblpaysplit.AccountNo'
      EditMask = '999999999;1; '
      Size = 50
    end
    object qryEmployeePaySplitAmount: TFloatField
      FieldName = 'Amount'
      Origin = 'tblpaysplit.Amount'
    end
    object qryEmployeePaySplitEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblpaysplit.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryEmployeePaySplitAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      FieldName = 'AccountName'
      Origin = 'tblpaysplit.AccountName'
      Size = 255
    end
  end
  object qryBankCodes: TERPQuery
    SQL.Strings = (
      'Select CodeID,BankCode,BankName'
      'FROM tblBankCodes'
      'Where RegionId = :XRegionID')
    BeforeOpen = qryBankCodesBeforeOpen
    Left = 705
    Top = 269
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'XRegionID'
      end>
  end
  object qryBasedOn: TERPQuery
    SQL.Strings = (
      'Select BasedOnID, BasedOn'
      'FROM tblAllowanceBasedOn')
    Left = 575
    Top = 269
  end
  object qryCustomers: TERPQuery
    SQL.Strings = (
      'Select ClientID,Company,IsJob'
      'FROM tblClients'
      'WHERE Customer='#39'T'#39' AND Active = '#39'T'#39';')
    Left = 834
    Top = 269
  end
  object qryemployeepayallowances: TERPQuery
    SQL.Strings = (
      'Select * '
      'From tblemployeeallowances'
      'Where EmployeeID=:xID;')
    Left = 355
    Top = 237
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryemployeepayallowancesEAID: TAutoIncField
      FieldName = 'EAID'
      ReadOnly = True
    end
    object qryemployeepayallowancesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryemployeepayallowancesAllowanceID: TIntegerField
      FieldName = 'AllowanceID'
    end
    object qryemployeepayallowancesQty: TFloatField
      FieldName = 'Qty'
    end
    object qryemployeepayallowancesBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
    end
    object qryemployeepayallowancesAmount: TFloatField
      FieldName = 'Amount'
      DisplayFormat = '0.00'
      EditFormat = '0.00'
    end
    object qryemployeepayallowancesCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryemployeepayallowancesArea: TWideStringField
      FieldName = 'Area'
      FixedChar = True
      Size = 50
    end
    object qryemployeepayallowancesSuperInc: TWideStringField
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryemployeepayallowancesTaxExempt: TWideStringField
      FieldName = 'TaxExempt'
      FixedChar = True
      Size = 1
    end
    object qryemployeepayallowancesClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryemployeepayallowancesClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryemployeepayallowancesBasedOn: TWideStringField
      FieldKind = fkLookup
      FieldName = 'BasedOn'
      LookupDataSet = qryBasedOn
      LookupKeyFields = 'BasedOnID'
      LookupResultField = 'BasedOn'
      KeyFields = 'BasedOnID'
      Lookup = True
    end
    object qryemployeepayallowancesAllowanceJob: TWideStringField
      FieldKind = fkLookup
      FieldName = 'AllowanceJob'
      LookupDataSet = qryCustomers
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Lookup = True
    end
    object qryemployeepayallowancesClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object qryemployeepayallowancesAllowance: TWideStringField
      FieldName = 'Allowance'
      Size = 255
    end
    object qryemployeepayallowancesUseStartEndDates: TWideStringField
      FieldName = 'UseStartEndDates'
      FixedChar = True
      Size = 1
    end
    object qryemployeepayallowancesStartDate: TDateField
      FieldName = 'StartDate'
    end
    object qryemployeepayallowancesEndDate: TDateField
      FieldName = 'EndDate'
    end
  end
  object qryFBT: TERPQuery
    SQL.Strings = (
      'SELECT'
      'GlobalRef, FBTID, EmployeeID, YearEnding, Notes, Amount, '
      'FBTReportable, EditedFlag, ClassID, ClassName, Type'
      'FROM tblfbt'
      'WHERE EmployeeID = :xEmpID')
    Left = 323
    Top = 237
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xEmpID'
      end>
    object qryFBTYearEnding: TDateField
      DisplayLabel = 'Year Ending'
      DisplayWidth = 12
      FieldName = 'YearEnding'
    end
    object qryFBTNotes: TWideStringField
      DisplayWidth = 35
      FieldName = 'Notes'
      Size = 150
    end
    object qryFBTAmount: TFloatField
      DisplayWidth = 15
      FieldName = 'Amount'
      currency = True
    end
    object qryFBTFBTReportable: TFloatField
      DisplayLabel = 'Reportable FBT'
      DisplayWidth = 15
      FieldName = 'FBTReportable'
      currency = True
    end
    object qryFBTClassName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ClassName'
      Size = 255
    end
    object qryFBTGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryFBTFBTID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'FBTID'
      ReadOnly = True
      Visible = False
    end
    object qryFBTEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryFBTEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryFBTClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object qryFBTType: TIntegerField
      FieldName = 'Type'
    end
  end
  object qryEmployeePayDeductions: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * '
      'From tblemployeedeductions'
      'Where EmployeeID=:xID;')
    Left = 640
    Top = 213
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryemployeedeductionsNotes: TWideStringField
      DisplayWidth = 15
      FieldName = 'Notes'
      Origin = 'tblemployeedeductions.Notes'
      Size = 50
    end
    object qryemployeedeductionsQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblemployeedeductions.Qty'
    end
    object qryemployeedeductionsBasedOnLookup: TWideStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'BasedOnLookup'
      LookupDataSet = qryBasedOn
      LookupKeyFields = 'BasedOnID'
      LookupResultField = 'BasedOn'
      KeyFields = 'BasedOnID'
      Lookup = True
    end
    object qryemployeedeductionsAmount: TFloatField
      DisplayWidth = 8
      FieldName = 'Amount'
      Origin = 'tblemployeedeductions.Amount'
      DisplayFormat = '0.00'
    end
    object qryemployeedeductionsCalcBy: TWideStringField
      FieldName = 'CalcBy'
      Origin = 'tblemployeedeductions.CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryemployeedeductionsArea: TWideStringField
      FieldName = 'Area'
      Origin = 'tblemployeedeductions.Area'
      FixedChar = True
      Size = 50
    end
    object qryemployeedeductionsEDID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'EDID'
      Origin = 'tblemployeedeductions.EDID'
      ReadOnly = True
      Visible = False
    end
    object qryemployeedeductionsEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblemployeedeductions.EmployeeID'
      Visible = False
    end
    object qryemployeedeductionsDeductionID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DeductionID'
      Origin = 'tblemployeedeductions.DeductionID'
      Visible = False
    end
    object qryEmployeePayDeductionsTaxExempt: TWideStringField
      DisplayWidth = 1
      FieldName = 'TaxExempt'
      Origin = 'tblemployeedeductions.TaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryemployeedeductionsIsWorkPlacegiving: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsWorkplacegiving'
      Origin = 'tblemployeedeductions.IsWorkPlacegiving'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryemployeedeductionsUnionFees: TWideStringField
      DisplayWidth = 1
      FieldName = 'UnionFees'
      Origin = 'tblemployeedeductions.UnionFees'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryemployeedeductionsBasedOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BasedOnID'
      Origin = 'tblemployeedeductions.BasedOnID'
      Visible = False
    end
    object qryemployeedeductionsClassID: TIntegerField
      FieldName = 'ClassID'
      Origin = 'tblemployeedeductions.ClassID'
    end
    object qryemployeedeductionsClassName: TWideStringField
      FieldName = 'ClassName'
      Origin = 'tblemployeedeductions.ClassName'
      Size = 255
    end
    object qryemployeedeductionsDeduction: TWideStringField
      FieldName = 'Deduction'
      Origin = 'tblemployeedeductions.Deduction'
      Size = 255
    end
    object qryemployeedeductionsUseStartEndDates: TWideStringField
      FieldName = 'UseStartEndDates'
      Origin = 'tblemployeedeductions.UseStartEndDates'
      FixedChar = True
      Size = 1
    end
    object qryemployeedeductionsStartDate: TDateField
      FieldName = 'StartDate'
      Origin = 'tblemployeedeductions.StartDate'
    end
    object qryemployeedeductionsEndDate: TDateField
      FieldName = 'EndDate'
      Origin = 'tblemployeedeductions.EndDate'
    end
    object qryEmployeePayDeductionsBox12CodeID: TIntegerField
      FieldName = 'Box12CodeID'
    end
    object qryEmployeePayDeductionsTaxExemptFederal: TWideStringField
      FieldName = 'TaxExemptFederal'
      FixedChar = True
      Size = 1
    end
    object qryEmployeePayDeductionsTaxExemptState: TWideStringField
      FieldName = 'TaxExemptState'
      FixedChar = True
      Size = 1
    end
    object qryEmployeePayDeductionsTaxExemptSocial: TWideStringField
      FieldName = 'TaxExemptSocial'
      FixedChar = True
      Size = 1
    end
    object qryEmployeePayDeductionsTaxExemptMedicare: TWideStringField
      FieldName = 'TaxExemptMedicare'
      FixedChar = True
      Size = 1
    end
  end
  object qryreference: TERPQuery
    SQL.Strings = (
      'Select * '
      'From tblreference'
      'Where (EmployeeID = :xID)'
      'AND (IsNull(ContactID) or (ContactID < 1)) '
      'AND (IsNull(CusID) or (CusID < 1))'
      'AND (IsNull(SupID) or (SupID < 1))')
    Filtered = True
    Filter = 'Active ='#39'T'#39
    Left = 672
    Top = 269
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryreferenceRef_Date: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'Ref_Date'
    end
    object qryreferenceRef_type: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'Ref_type'
      FixedChar = True
      Size = 50
    end
    object qryreferenceReferencetxt: TWideStringField
      DisplayLabel = 'Reference'
      DisplayWidth = 30
      FieldName = 'Referencetxt'
      FixedChar = True
      Size = 50
    end
    object qryreferenceRefID: TAutoIncField
      FieldName = 'RefID'
      ReadOnly = True
      Visible = False
    end
    object qryreferenceContactID: TIntegerField
      FieldName = 'ContactID'
      Visible = False
    end
    object qryreferenceCusID: TIntegerField
      FieldName = 'CusID'
      Visible = False
    end
    object qryreferenceSupID: TIntegerField
      FieldName = 'SupID'
      Visible = False
    end
    object qryreferenceEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryreferenceEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryreferenceOtherContactID: TIntegerField
      FieldName = 'OtherContactID'
      Visible = False
    end
    object qryreferenceGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryreferenceLoyaltyProgram: TWideStringField
      FieldName = 'LoyaltyProgram'
      FixedChar = True
      Size = 1
    end
    object qryreferencemsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryreferencemsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryreferenceActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryreferenceReferenceData: TBlobField
      FieldName = 'ReferenceData'
    end
    object qryreferenceMessageId: TWideStringField
      FieldName = 'MessageId'
      Size = 255
    end
    object qryreferenceMessageFrom: TWideStringField
      FieldName = 'MessageFrom'
      Size = 255
    end
    object qryreferenceMessageTo: TWideStringField
      FieldName = 'MessageTo'
      Size = 255
    end
    object qryreferenceStatus: TWideStringField
      FieldName = 'Status'
    end
    object qryreferenceHRFormID: TIntegerField
      FieldName = 'HRFormID'
    end
  end
  object qryemployeepayrates: TERPQuery
    SQL.Strings = (
      'Select * '
      'From tblemployeepayrates'
      'Where EmployeeID=:xID;')
    Left = 478
    Top = 269
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryemployeepayratesPayRate: TWideStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'PayRate'
      LookupDataSet = qryPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'PayRateID'
      Size = 100
      Lookup = True
    end
    object qryemployeepayratesRateType: TWideStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'RateType'
      LookupDataSet = qryPayRateType
      LookupKeyFields = 'TypeID'
      LookupResultField = 'Description'
      KeyFields = 'TypeID'
      Lookup = True
    end
    object qryemployeepayratesQty: TFloatField
      DisplayLabel = 'Hours'
      DisplayWidth = 10
      FieldName = 'Qty'
      DisplayFormat = '#0.00##'
      EditFormat = '#0.00##'
    end
    object qryemployeepayratesHourlyRate: TFloatField
      DisplayLabel = 'Rate/Salary'
      DisplayWidth = 10
      FieldName = 'HourlyRate'
      DisplayFormat = '#0.00##'
    end
    object qryemployeepayratesAmount: TFloatField
      DisplayLabel = 'Wages'
      DisplayWidth = 10
      FieldName = 'Amount'
      currency = True
    end
    object qryemployeepayratesRateJob: TWideStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'RateJob'
      LookupDataSet = qryJobs
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Lookup = True
    end
    object qryemployeepayratesClassName: TWideStringField
      DisplayWidth = 15
      FieldName = 'ClassName'
      Size = 255
    end
    object qryemployeepayratesSuper: TWideStringField
      DisplayWidth = 1
      FieldName = 'Super'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryemployeepayratesLineTotal: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTotal'
      Visible = False
      currency = True
    end
    object qryemployeepayratesClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object qryemployeepayratesClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object qryemployeepayratesEmployeeRateID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'EmployeeRateID'
      ReadOnly = True
      Visible = False
    end
    object qryemployeepayratesEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryemployeepayratesPayRateID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayRateID'
      Visible = False
    end
    object qryemployeepayratesTypeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TypeID'
      Visible = False
    end
    object qryemployeepayratesNICs: TWideStringField
      DisplayWidth = 1
      FieldName = 'NICs'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryPayRates: TERPQuery
    SQL.Strings = (
      'Select RateID, Description'
      'FROM tblPayRates'
      'WHERE Active = '#39'T'#39' AND IsLeave <> '#39'T'#39
      'ORDER BY Description'
      '')
    Left = 802
    Top = 269
    object qryPayRatesDescription: TWideStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Size = 100
    end
    object qryPayRatesRateID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'RateID'
      ReadOnly = True
      Visible = False
    end
  end
  object qryPayRateType: TERPQuery
    SQL.Strings = (
      'Select TypeID,Description'
      'FROM tblPayRateType')
    Left = 867
    Top = 269
  end
  object qryJobs: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, JobNumber, DefaultClass'
      'FROM tblclients'
      
        'WHERE Active = '#39'T'#39' AND Customer='#39'T'#39' AND (Company NOT LIKE '#39'Table' +
        '%'#39')'
      'ORDER BY Company')
    Left = 737
    Top = 269
  end
  object qryLeave: TERPQuery
    SQL.Strings = (
      'Select * '
      'From tblleave'
      'Where EmployeeID=:xID;')
    Left = 511
    Top = 269
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryLeaveAccrueAfterNo: TFloatField
      DisplayLabel = 'No'
      DisplayWidth = 6
      FieldName = 'AccrueAfterNo'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object qryLeaveAccrueAfterPeriod: TWideStringField
      DisplayLabel = 'Period'
      DisplayWidth = 9
      FieldName = 'AccrueAfterPeriod'
      FixedChar = True
      Size = 28
    end
    object qryLeaveAccrueNo: TFloatField
      DisplayLabel = 'Every'
      DisplayWidth = 6
      FieldName = 'AccrueNo'
    end
    object qryLeaveAccruePeriod: TWideStringField
      DisplayLabel = 'Period'
      DisplayWidth = 9
      FieldName = 'AccruePeriod'
      FixedChar = True
      Size = 28
    end
    object qryLeaveAccrueHours: TFloatField
      DisplayLabel = 'Hours'
      DisplayWidth = 7
      FieldName = 'AccrueHours'
      DisplayFormat = '#0.00###'
      EditFormat = '#0.00##'
    end
    object qryLeaveAccruedHours: TFloatField
      DisplayLabel = 'Accrued~Hrs'
      DisplayWidth = 9
      FieldName = 'AccruedHours'
      DisplayFormat = '#0.00##'
      EditFormat = '#0.00##'
    end
    object qryLeaveLeaveLoading: TFloatField
      DisplayLabel = 'Leave Loading'
      DisplayWidth = 5
      FieldName = 'LeaveLoading'
    end
    object qryLeaveAccruedDate: TDateField
      DisplayLabel = 'Accrued~Date'
      DisplayWidth = 9
      FieldName = 'AccruedDate'
      ReadOnly = True
    end
    object qryLeaveClassName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ClassName'
      Size = 255
    end
    object qryLeaveOpenningBalanceHrs: TFloatField
      DisplayWidth = 10
      FieldName = 'OpenningBalanceHrs'
    end
    object qryLeaveOpenningBalanceDate: TDateField
      DisplayWidth = 10
      FieldName = 'OpenningBalanceDate'
    end
    object qryLeaveUseStartEndDates: TWideStringField
      DisplayWidth = 1
      FieldName = 'UseStartEndDates'
      FixedChar = True
      Size = 1
    end
    object qryLeaveStartDate: TDateField
      DisplayWidth = 10
      FieldName = 'StartDate'
    end
    object qryLeaveEndDate: TDateField
      DisplayWidth = 10
      FieldName = 'EndDate'
    end
    object qryLeaveTypeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TypeID'
      Visible = False
    end
    object qryLeaveClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object qryLeaveGlobalRef: TWideStringField
      DisplayWidth = 10
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryLeaveMaxHours: TFloatField
      FieldName = 'MaxHours'
      Visible = False
    end
    object qryLeaveLeaveID: TAutoIncField
      FieldName = 'LeaveID'
      ReadOnly = True
      Visible = False
    end
    object qryLeaveEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryLeaveType: TWideStringField
      FieldName = 'Type'
    end
  end
  object qryempPaySettings: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblemployeepaysettings'
      'WHERE EmployeeID = :EmployeeID;')
    Options.StrictUpdate = False
    Left = 276
    Top = 181
    ParamData = <
      item
        DataType = ftString
        Name = 'EmployeeID'
        Value = ''
      end>
    object qryempPaySettingsSTPJobkeeperStartFN: TWideStringField
      FieldName = 'STPJobkeeperStartFN'
      Origin = 'tblemployeepaysettings.STPJobkeeperStartFN'
      Size = 3
    end
    object qryempPaySettingsSTPJobkeeperFinishFN: TWideStringField
      FieldName = 'STPJobkeeperFinishFN'
      Origin = 'tblemployeepaysettings.STPJobkeeperFinishFN'
      Size = 3
    end
    object qryempPaySettingsSTPTier: TIntegerField
      FieldName = 'STPTier'
      Origin = 'tblemployeepaysettings.STPTier'
    end
    object qryempPaySettingsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblemployeepaysettings.EmployeeID'
    end
    object qryempPaySettingsUKTaxCode: TWideStringField
      FieldName = 'UKTaxCode'
      Origin = 'tblemployeepaysettings.UKTaxCode'
      Size = 255
    end
    object qryempPaySettingsABN: TIntegerField
      FieldName = 'ABN'
      Origin = 'tblemployeepaysettings.ABN'
    end
    object qryempPaySettingsPayPeriod: TWideStringField
      FieldName = 'PayPeriod'
      Origin = 'tblemployeepaysettings.PayPeriod'
      FixedChar = True
      Size = 11
    end
    object qryempPaySettingsEmployeePayNotes: TWideMemoField
      FieldName = 'EmployeePayNotes'
      Origin = 'tblemployeepaysettings.EmployeePayNotes'
      BlobType = ftWideMemo
    end
    object qryempPaySettingsIsOnTheRoster: TWideStringField
      FieldName = 'IsOnTheRoster'
      Origin = 'tblemployeepaysettings.IsOnTheRoster'
      FixedChar = True
      Size = 1
    end
    object qryempPaySettingsFirstPayDate: TDateField
      FieldName = 'FirstPayDate'
      Origin = 'tblemployeepaysettings.FirstPayDate'
    end
    object qryempPaySettingsLastPaid: TDateField
      FieldName = 'LastPaid'
      Origin = 'tblemployeepaysettings.LastPaid'
    end
    object qryempPaySettingsNICTableLetter: TWideStringField
      FieldName = 'NICTableLetter'
      Origin = 'tblemployeepaysettings.NICTableLetter'
      Size = 8
    end
    object qryempPaySettingsIsDirector: TWideStringField
      FieldName = 'IsDirector'
      Origin = 'tblemployeepaysettings.IsDirector'
      FixedChar = True
      Size = 1
    end
    object qryempPaySettingsIsMarriedWoman: TWideStringField
      FieldName = 'IsMarriedWoman'
      Origin = 'tblemployeepaysettings.IsMarriedWoman'
      FixedChar = True
      Size = 1
    end
    object qryempPaySettingsIsContractedOut: TWideStringField
      FieldName = 'IsContractedOut'
      Origin = 'tblemployeepaysettings.IsContractedOut'
      FixedChar = True
      Size = 1
    end
    object qryempPaySettingsUKNINO: TWideStringField
      FieldName = 'UKNINO'
      Origin = 'tblemployeepaysettings.UKNINO'
      Size = 255
    end
    object qryempPaySettingsCIS: TWideStringField
      FieldName = 'CIS'
      Origin = 'tblemployeepaysettings.CIS'
      FixedChar = True
      Size = 1
    end
    object qryempPaySettingsStudent: TWideStringField
      FieldName = 'Student'
      Origin = 'tblemployeepaysettings.Student'
      FixedChar = True
      Size = 1
    end
    object qryempPaySettingsMaritalStatus: TWideStringField
      FieldName = 'MaritalStatus'
      Origin = 'tblemployeepaysettings.MaritalStatus'
      FixedChar = True
      Size = 1
    end
    object qryempPaySettingsIRPR: TWideStringField
      FieldName = 'IRPR'
      Origin = 'tblemployeepaysettings.IRPR'
      Size = 255
    end
    object qryempPaySettingsDateLastActuallyPaid: TDateField
      FieldName = 'DateLastActuallyPaid'
      Origin = 'tblemployeepaysettings.DateLastActuallyPaid'
    end
    object qryempPaySettingsEmployeePaySettingID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmployeePaySettingID'
      Origin = 'tblemployeepaysettings.EmployeePaySettingID'
    end
    object qryempPaySettingsWorkersCompRate: TFloatField
      FieldName = 'WorkersCompRate'
      Origin = 'tblemployeepaysettings.WorkersCompRate'
    end
    object qryempPaySettingsNonWageIncome: TFloatField
      FieldName = 'NonWageIncome'
      Origin = 'tblemployeepaysettings.NonWageIncome'
    end
  end
  object qryEmpSkills: TERPQuery
    SQL.Strings = (
      
        'Select EmpSkillID,SkillID, SkillName, SkillLevel, SkillExpDate, ' +
        'ReminderDays, SecurityLevel, '
      'SecurityExpDate, EmployeeID From tblemployeeskills '
      'WHERE EmployeeID=:xEmployeeID;')
    Left = 317
    Top = 269
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xEmployeeID'
      end>
    object qryEmpSkillsEmpSkillID: TAutoIncField
      FieldName = 'EmpSkillID'
      ReadOnly = True
    end
    object qryEmpSkillsSkillID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SkillID'
      Visible = False
    end
    object qryEmpSkillsSkillName: TWideStringField
      FieldName = 'SkillName'
      Size = 255
    end
    object qryEmpSkillsSkillLevel: TIntegerField
      FieldName = 'SkillLevel'
    end
    object qryEmpSkillsSkillExpDate: TDateField
      FieldName = 'SkillExpDate'
    end
    object qryEmpSkillsSecurityLevel: TIntegerField
      FieldName = 'SecurityLevel'
    end
    object qryEmpSkillsSecurityExpDate: TDateField
      FieldName = 'SecurityExpDate'
    end
    object qryEmpSkillsEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryEmpSkillsReminderDays: TIntegerField
      FieldName = 'ReminderDays'
    end
  end
  object qrysuperannuation: TERPQuery
    SQL.Strings = (
      'Select * '
      'From tblsuperannuation'
      'Where EmployeeID=:xID;')
    Left = 492
    Top = 189
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qrysuperannuationSuperType: TWideStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'SuperType'
      LookupDataSet = qrySuperType
      LookupKeyFields = 'SuperTypeID'
      LookupResultField = 'Description'
      KeyFields = 'SuperTypeID'
      Lookup = True
    end
    object qrysuperannuationSuperFund: TWideStringField
      FieldName = 'SuperFund'
      LookupDataSet = qrySuppliers
      Size = 255
    end
    object qrysuperannuationAccountNo: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountNo'
      Size = 50
    end
    object qrysuperannuationDateJoined: TDateField
      DisplayLabel = 'Date Joined'
      DisplayWidth = 10
      FieldName = 'DateJoined'
    end
    object qrysuperannuationAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
    end
    object qrysuperannuationCalcBy: TWideStringField
      DisplayWidth = 1
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qrysuperannuationArea: TWideStringField
      FieldName = 'Area'
      FixedChar = True
      Size = 50
    end
    object qrysuperannuationSuperID: TAutoIncField
      FieldName = 'SuperID'
      ReadOnly = True
      Visible = False
    end
    object qrysuperannuationEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qrysuperannuationSuperTypeID: TIntegerField
      FieldName = 'SuperTypeID'
      Visible = False
    end
    object qrysuperannuationClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object qrysuperannuationTaxExempt: TWideStringField
      FieldName = 'TaxExempt'
      FixedChar = True
      Size = 1
    end
    object qrysuperannuationTaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object qrysuperannuationClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qrysuperannuationAllClasses: TWideStringField
      FieldName = 'AllClasses'
      Size = 1
    end
    object qrysuperannuationClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object qrysuperannuationAmountToPaid: TFloatField
      FieldName = 'AmountToPaid'
    end
  end
  object qrySuperType: TERPQuery
    SQL.Strings = (
      'Select SuperTypeID, Description'
      'FROM tblSuperType')
    Left = 387
    Top = 237
  end
  object qrySuppliers: TERPQuery
    SQL.Strings = (
      'Select ClientID, Company'
      'FROM tblClients'
      'WHERE Supplier='#39'T'#39
      'Order by Company;')
    Left = 769
    Top = 269
  end
  object qryworkerscompensation: TERPQuery
    SQL.Strings = (
      'Select * '
      'From tblworkerscompensation'
      'Where EmployeeID=:xID;')
    Left = 381
    Top = 269
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
    object qryworkerscompensationWCDate: TDateField
      Alignment = taRightJustify
      DisplayLabel = 'Date'
      DisplayWidth = 10
      FieldName = 'WCDate'
    end
    object qryworkerscompensationDescription: TWideStringField
      DisplayLabel = 'Details'
      DisplayWidth = 48
      FieldName = 'Description'
      Size = 150
    end
    object qryworkerscompensationAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      currency = True
    end
    object qryworkerscompensationType: TWideStringField
      DisplayLabel = 'Payment/Cliam'
      DisplayWidth = 13
      FieldName = 'Type'
      FixedChar = True
      Size = 13
    end
    object qryworkerscompensationWCID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'WCID'
      ReadOnly = True
      Visible = False
    end
    object qryworkerscompensationEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryworkerscompensationClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryworkerscompensationClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
  end
  object qryProductCommission: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PC.*'
      'FROM tblProductCommission PC '
      'Where Active = "T" and '
      'ifnull(EmployeeId,0) = 0 or  ifnull(EmployeeId,0) = :EmployeeID')
    OnCalcFields = Calccommission
    Left = 284
    Top = 269
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmployeeID'
      end>
    object qryProductCommissionPartname: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 20
      FieldName = 'Partname'
      Origin = 'tblProductCommission.Partname'
      Size = 100
    end
    object qryProductCommissionCommissionRate: TFloatField
      DisplayLabel = 'Commission~Rate'
      DisplayWidth = 13
      FieldName = 'CommissionRate'
      Origin = 'tblProductCommission.CommissionRate'
    end
    object qryProductCommissionIsPercentage: TWideStringField
      DisplayLabel = 'Percentage?'
      DisplayWidth = 10
      FieldName = 'IsPercentage'
      Origin = 'tblProductCommission.IsPercentage'
      FixedChar = True
      Size = 1
    end
    object qryProductCommissionForAllEmployees: TWideStringField
      DisplayLabel = 'For All?'
      DisplayWidth = 6
      FieldName = 'ForAllEmployees'
      Origin = 'tblProductCommission.ForAllEmployees'
      FixedChar = True
      Size = 1
    end
    object qryProductCommissionProductCommissionId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ProductCommissionId'
      Origin = 'tblProductCommission.ProductCommissionId'
      Visible = False
    end
    object qryProductCommissionPartsId: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsId'
      Origin = 'tblProductCommission.PartsId'
      Visible = False
    end
    object qryProductCommissionGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblProductCommission.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryProductCommissionActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblProductCommission.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryProductCommissionmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblProductCommission.msTimeStamp'
      Visible = False
    end
    object qryProductCommissionEmployeeId: TLargeintField
      DisplayWidth = 15
      FieldName = 'EmployeeId'
      Origin = 'tblProductCommission.EmployeeId'
      Visible = False
    end
    object qryProductCommissionCommission: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Commission'
      Calculated = True
    end
  end
  object qryemployeeProductCommission: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PC.*'
      'FROM tblProductCommission PC '
      'Where Active = "T" and '
      'ifnull(EmployeeId,0) = 0 or  ifnull(EmployeeId,0) = :EmployeeID')
    OnCalcFields = Calccommission
    Left = 349
    Top = 269
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmployeeID'
      end>
    object StringField1: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 20
      FieldName = 'Partname'
      Origin = 'tblProductCommission.Partname'
      Size = 100
    end
    object FloatField1: TFloatField
      DisplayLabel = 'Commission~Rate'
      DisplayWidth = 13
      FieldName = 'CommissionRate'
      Origin = 'tblProductCommission.CommissionRate'
    end
    object StringField2: TWideStringField
      DisplayLabel = 'Percentage?'
      DisplayWidth = 10
      FieldName = 'IsPercentage'
      Origin = 'tblProductCommission.IsPercentage'
      FixedChar = True
      Size = 1
    end
    object StringField3: TWideStringField
      DisplayLabel = 'For All?'
      DisplayWidth = 6
      FieldName = 'ForAllEmployees'
      Origin = 'tblProductCommission.ForAllEmployees'
      FixedChar = True
      Size = 1
    end
    object IntegerField1: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ProductCommissionId'
      Origin = 'tblProductCommission.ProductCommissionId'
      Visible = False
    end
    object IntegerField2: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsId'
      Origin = 'tblProductCommission.PartsId'
      Visible = False
    end
    object StringField4: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblProductCommission.GlobalRef'
      Visible = False
      Size = 255
    end
    object StringField5: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblProductCommission.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object DateTimeField1: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblProductCommission.msTimeStamp'
      Visible = False
    end
    object LargeintField1: TLargeintField
      DisplayWidth = 15
      FieldName = 'EmployeeId'
      Origin = 'tblProductCommission.EmployeeId'
      Visible = False
    end
    object qryemployeeProductCommissionCommission: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Commission'
      Calculated = True
    end
  end
  object QryEmployeeNoCommissionProducts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblEmpNoCommsProducts')
    Left = 446
    Top = 269
    object QryEmployeeNoCommissionProductsGlobalref: TWideStringField
      FieldName = 'Globalref'
      Origin = 'tblEmpNoCommsProducts.Globalref'
      Size = 255
    end
    object QryEmployeeNoCommissionProductsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblEmpNoCommsProducts.ID'
    end
    object QryEmployeeNoCommissionProductsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblEmpNoCommsProducts.EmployeeID'
    end
    object QryEmployeeNoCommissionProductsProductID: TIntegerField
      FieldName = 'ProductID'
      Origin = 'tblEmpNoCommsProducts.ProductID'
    end
    object QryEmployeeNoCommissionProductsProductName: TWideStringField
      FieldName = 'ProductName'
      Origin = 'tblEmpNoCommsProducts.ProductName'
      Size = 100
    end
    object QryEmployeeNoCommissionProductsmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
      Origin = 'tblEmpNoCommsProducts.mstimestamp'
    end
    object QryEmployeeNoCommissionProductsCommission: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Commission'
      Size = 100
      Calculated = True
    end
  end
  object Qryemployeeskills: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from `tblemployeeskills`')
    AfterInsert = QryemployeeskillsAfterInsert
    Left = 414
    Top = 269
    object QryemployeeskillsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblemployeeskills.GlobalRef'
      Size = 255
    end
    object QryemployeeskillsEmpSkillID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'EmpSkillID'
      Origin = 'tblemployeeskills.EmpSkillID'
    end
    object QryemployeeskillsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblemployeeskills.EmployeeID'
    end
    object QryemployeeskillsSkillID: TIntegerField
      FieldName = 'SkillID'
      Origin = 'tblemployeeskills.SkillID'
    end
    object QryemployeeskillsSkillLevelName: TWideStringField
      DisplayLabel = 'Skill Level'
      DisplayWidth = 10
      FieldName = 'SkillLevelName'
      Origin = 'tblemployeeskills.SkillName'
    end
    object QryemployeeskillsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblemployeeskills.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object QryemployeeskillsSkillLevel: TIntegerField
      DisplayLabel = 'Skill Level'
      FieldName = 'SkillLevel'
      Origin = 'tblemployeeskills.SkillLevel'
    end
    object QryemployeeskillsSkillName: TWideStringField
      DisplayLabel = 'Skill'
      DisplayWidth = 10
      FieldName = 'SkillName'
      Origin = 'tblemployeeskills.SkillName'
      Size = 255
    end
    object QryemployeeskillsSkillExpDate: TDateField
      DisplayLabel = 'Skill Expires on'
      FieldName = 'SkillExpDate'
      Origin = 'tblemployeeskills.SkillExpDate'
    end
    object QryemployeeskillsSecurityLevel: TIntegerField
      FieldName = 'SecurityLevel'
      Origin = 'tblemployeeskills.SecurityLevel'
    end
    object QryemployeeskillsSecurityExpDate: TDateField
      FieldName = 'SecurityExpDate'
      Origin = 'tblemployeeskills.SecurityExpDate'
    end
    object QryemployeeskillsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblemployeeskills.msTimeStamp'
    end
    object QryemployeeskillsProviderID: TIntegerField
      FieldName = 'ProviderID'
      Origin = 'tblemployeeskills.ProviderID'
    end
    object QryemployeeskillsProviderName: TWideStringField
      DisplayLabel = 'Provider'
      DisplayWidth = 10
      FieldName = 'ProviderName'
      Origin = 'tblemployeeskills.ProviderName'
      Size = 100
    end
    object QryemployeeskillsTestMethod: TWideStringField
      DisplayLabel = 'Test Method'
      DisplayWidth = 10
      FieldName = 'TestMethod'
      Origin = 'tblemployeeskills.TestMethod'
      FixedChar = True
      Size = 1
    end
    object QryemployeeskillsCertificate: TWideStringField
      DisplayWidth = 10
      FieldName = 'Certificate'
      Origin = 'tblemployeeskills.Certificate'
      Size = 255
    end
    object QryemployeeskillsScheduledDate: TDateField
      DisplayLabel = 'Date Scheduled'
      FieldName = 'ScheduledDate'
      Origin = 'tblemployeeskills.ScheduledDate'
    end
    object QryemployeeskillsCompletedDate: TDateField
      DisplayLabel = 'Completed On'
      FieldName = 'CompletedDate'
      Origin = 'tblemployeeskills.CompletedDate'
    end
    object QryemployeeskillsRenewalDate: TDateField
      DisplayLabel = 'Renewal Date'
      FieldName = 'RenewalDate'
      Origin = 'tblemployeeskills.RenewalDate'
    end
    object QryemployeeskillsRenewalOptions: TIntegerField
      DisplayLabel = 'Renewal Options'
      FieldName = 'RenewalOptions'
      Origin = 'tblemployeeskills.RenewalOptions'
    end
    object QryemployeeskillsRenewed: TWideStringField
      FieldName = 'Renewed'
      Origin = 'tblemployeeskills.Renewed'
      FixedChar = True
      Size = 1
    end
    object QryemployeeskillsComments: TWideStringField
      DisplayWidth = 10
      FieldName = 'Comments'
      Origin = 'tblemployeeskills.Comments'
      Size = 255
    end
    object QryemployeeskillsReminderDays: TIntegerField
      FieldName = 'ReminderDays'
    end
  end
  object qryPersonalPreferences: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select * from tblpersonalpreferences where EmployeeID = :Employe' +
        'eID')
    Left = 608
    Top = 269
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmployeeID'
      end>
  end
end
