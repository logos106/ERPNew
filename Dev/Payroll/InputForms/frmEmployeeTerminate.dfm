inherited frmEmployeeTerminateGUI: TfrmEmployeeTerminateGUI
  Top = 290
  HelpContext = 274000
  Caption = 'Employee Termination'
  ClientHeight = 427
  ClientWidth = 998
  OldCreateOrder = True
  OnMouseWheel = FormMouseWheel
  ExplicitTop = 290
  ExplicitWidth = 1014
  ExplicitHeight = 466
  DesignSize = (
    998
    427)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 427
    Width = 998
    HelpContext = 274023
    ExplicitTop = 427
    ExplicitWidth = 998
  end
  object Label1: TLabel [1]
    Left = 199
    Top = 36
    Width = 41
    Height = 15
    HelpContext = 274002
    Caption = 'Search'
    Transparent = True
    Visible = False
  end
  object Bevel1: TBevel [2]
    Left = 177
    Top = 0
    Width = 9
    Height = 427
    HelpContext = 274003
    Anchors = [akLeft, akTop, akBottom]
    Shape = bsLeftLine
    ExplicitHeight = 422
  end
  object Label2: TLabel [3]
    Left = 185
    Top = 10
    Width = 48
    Height = 15
    HelpContext = 274004
    Alignment = taCenter
    AutoSize = False
    Caption = 'Scroll'
    Transparent = True
    Visible = False
  end
  object imgPrefs: TImage [4]
    Left = 185
    Top = 28
    Width = 48
    Height = 105
    HelpContext = 274005
    Visible = False
  end
  inherited imgGridWatermark: TImage
    Left = 196
    Top = 511
    HelpContext = 274001
    ExplicitLeft = 196
    ExplicitTop = 511
  end
  object cboSearch: TwwDBComboBox [9]
    Left = 247
    Top = 26
    Width = 133
    Height = 23
    HelpContext = 274011
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
  object Shader1: TShader [10]
    Left = 185
    Top = 54
    Width = 800
    Height = 31
    HelpContext = 274012
    BevelOuter = bvNone
    TabOrder = 9
    FromColor = clBtnFace
    ToColor = clWhite
    FromColorMirror = clWhite
    ToColorMirror = clBtnFace
    Steps = 10
    Direction = False
    Version = '1.4.0.0'
    object pnlActiveForm: TLabel
      Left = 5
      Top = 3
      Width = 793
      Height = 25
      HelpContext = 274013
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
    end
    object AdvPicture1: TAdvPicture
      Left = 3
      Top = 6
      Width = 25
      Height = 23
      HelpContext = 274014
      Animate = True
      Picture.Stretch = False
      Picture.Frame = 0
      PicturePosition = bpTopLeft
      StretchMode = smShrink
      Version = '1.4.0.0'
    end
  end
  object pnlTitle: TDNMPanel [11]
    Left = 394
    Top = 6
    Width = 479
    Height = 45
    HelpContext = 274015
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 475
      Height = 41
      HelpContext = 274016
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
        Width = 475
        Height = 41
        HelpContext = 274017
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Employee Termination Wizard'
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
  object DNMPanel2: TDNMPanel [12]
    Left = 184
    Top = 385
    Width = 233
    Height = 27
    HelpContext = 274018
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label51: TLabel
      Left = 34
      Top = 6
      Width = 96
      Height = 15
      HelpContext = 274019
      Caption = 'Print Statements'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label19: TLabel
      Left = 165
      Top = 5
      Width = 54
      Height = 17
      HelpContext = 274020
      Alignment = taCenter
      AutoSize = False
      Caption = 'Deleted'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object chkPrint: TCheckBox
      Left = 16
      Top = 6
      Width = 14
      Height = 16
      HelpContext = 274021
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object chkDeleted: TwwCheckBox
      Left = 150
      Top = 4
      Width = 15
      Height = 17
      HelpContext = 274022
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
      Caption = 'chkApplycredits'
      DataField = 'Deleted'
      DataSource = DSTerminations
      TabOrder = 1
      OnClick = chkDeletedClick
    end
  end
  object btnHold: TDNMSpeedButton [13]
    Left = 692
    Top = 385
    Width = 87
    Height = 27
    HelpContext = 274009
    Caption = 'Hold'
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
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
    AutoDisableParentOnclick = True
    OnClick = btnHoldClick
  end
  object btnNext: TDNMSpeedButton [14]
    Left = 532
    Top = 385
    Width = 87
    Height = 27
    HelpContext = 274024
    Caption = 'Next >>'
    Default = True
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
    ModalResult = 1
    ParentFont = False
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = btnNextClick
  end
  object btnPrior: TDNMSpeedButton [15]
    Left = 436
    Top = 385
    Width = 87
    Height = 27
    HelpContext = 274025
    Caption = '<< Prior'
    Default = True
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
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = btnPriorClick
  end
  object sbPrefs: TScrollBox [16]
    Left = 185
    Top = 92
    Width = 801
    Height = 285
    HelpContext = 274008
    HorzScrollBar.Visible = False
    BevelInner = bvNone
    BevelKind = bkSoft
    BorderStyle = bsNone
    TabOrder = 8
  end
  object sbButtons: TScrollBox [17]
    Left = 0
    Top = 0
    Width = 177
    Height = 426
    HelpContext = 274006
    HorzScrollBar.Visible = False
    Anchors = [akLeft, akTop, akBottom]
    BorderStyle = bsNone
    TabOrder = 7
    object pnlButtons: TDNMPanel
      Left = 0
      Top = 0
      Width = 177
      Height = 426
      HelpContext = 274007
      Align = alClient
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
  object btnOK: TDNMSpeedButton [18]
    Left = 796
    Top = 385
    Width = 87
    Height = 27
    HelpContext = 274026
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
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = btnOKClick
  end
  object btnCancel: TDNMSpeedButton [19]
    Left = 899
    Top = 385
    Width = 87
    Height = 27
    HelpContext = 274010
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
  inherited dlgReportSelect: TSelectionDialog
    Left = 191
    Top = 261
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 191
    Top = 297
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 223
    Top = 296
  end
  inherited DataState: TDataState
    Left = 231
    Top = 245
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 193
    Top = 332
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102001400300010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object ImageScroll: TImageScroll
    Enabled = False
    Left = 225
    Top = 332
  end
  object qryPays: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblpays')
    Left = 832
    Top = 8
    object qryPaysPayID: TIntegerField
      FieldName = 'PayID'
    end
    object qryPaysEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryPaysPayDate: TDateField
      FieldName = 'PayDate'
    end
    object qryPaysDatePaid: TDateTimeField
      FieldName = 'DatePaid'
    end
    object qryPaysPayPeriods: TWordField
      FieldName = 'PayPeriods'
    end
    object qryPaysWages: TFloatField
      FieldName = 'Wages'
      currency = True
    end
    object qryPaysCommission: TFloatField
      FieldName = 'Commission'
      currency = True
    end
    object qryPaysDeductions: TFloatField
      FieldName = 'Deductions'
      currency = True
    end
    object qryPaysAllowances: TFloatField
      FieldName = 'Allowances'
      currency = True
    end
    object qryPaysAllowancesBeforeTax: TFloatField
      FieldName = 'AllowancesBeforeTax'
    end
    object qryPaysSundries: TFloatField
      FieldName = 'Sundries'
      currency = True
    end
    object qryPaysSuperannuation: TFloatField
      FieldName = 'Superannuation'
      currency = True
    end
    object qryPaysGross: TFloatField
      FieldName = 'Gross'
      currency = True
    end
    object qryPaysGrossTaxable: TFloatField
      FieldName = 'GrossTaxable'
    end
    object qryPaysTax: TFloatField
      FieldName = 'Tax'
      currency = True
    end
    object qryPaysNet: TFloatField
      FieldName = 'Net'
      currency = True
    end
    object qryPaysPay: TWideStringField
      FieldName = 'Pay'
      FixedChar = True
      Size = 1
    end
    object qryPaysPaid: TWideStringField
      FieldName = 'Paid'
      FixedChar = True
      Size = 1
    end
    object qryPaysEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryPaysPrinted: TWideStringField
      FieldName = 'Printed'
      FixedChar = True
      Size = 1
    end
    object qryPaysEmpName: TWideStringField
      FieldName = 'EmpName'
      Size = 50
    end
    object qryPaysLeaveLoading: TFloatField
      FieldName = 'LeaveLoading'
    end
    object qryPaysClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryPaysClass: TWideStringField
      FieldName = 'Class'
      Size = 255
    end
    object qryPaysIsTimesheet: TWideStringField
      FieldName = 'IsTimesheet'
      FixedChar = True
      Size = 1
    end
    object qryPaysPayPeriod: TWideStringField
      FieldName = 'PayPeriod'
      Size = 255
    end
    object qryPaysAnnualLeaveRate: TFloatField
      FieldName = 'AnnualLeaveRate'
    end
    object qryPaysCDEPGross: TFloatField
      FieldName = 'CDEPGross'
    end
    object qryPaysLumpA: TFloatField
      FieldName = 'LumpA'
    end
    object qryPaysLumpB: TFloatField
      FieldName = 'LumpB'
    end
    object qryPaysLumpD: TFloatField
      FieldName = 'LumpD'
    end
    object qryPaysLumpE: TFloatField
      FieldName = 'LumpE'
    end
    object qryPaysETP: TFloatField
      FieldName = 'ETP'
    end
    object qryPaysManualTax: TWideStringField
      FieldName = 'ManualTax'
      FixedChar = True
      Size = 1
    end
    object qryPaysDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object qryPaysIsNewTypePay: TWideStringField
      FieldName = 'IsNewTypePay'
      FixedChar = True
      Size = 1
    end
    object qryPaysmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryPaysPaySuperOnLeaveLoading: TWideStringField
      FieldName = 'PaySuperOnLeaveLoading'
      FixedChar = True
      Size = 1
    end
    object qryPaysPayVersion: TIntegerField
      FieldName = 'PayVersion'
    end
    object qryPaysPayNotes: TWideMemoField
      FieldName = 'PayNotes'
      BlobType = ftWideMemo
    end
    object qryPaysUKTaxCodeUsed: TWideStringField
      FieldName = 'UKTaxCodeUsed'
      Size = 255
    end
    object qryPaysPrepared: TWideStringField
      FieldName = 'Prepared'
      FixedChar = True
      Size = 1
    end
    object qryPaysUKNICsClass1: TFloatField
      FieldName = 'UKNICsClass1'
      currency = True
    end
    object qryPaysIsContractedOut: TWideStringField
      FieldName = 'IsContractedOut'
      FixedChar = True
      Size = 1
    end
    object qryPaysUKNICsOther: TFloatField
      FieldName = 'UKNICsOther'
      currency = True
    end
    object qryPaysUKEmployerNICsClass1: TFloatField
      FieldName = 'UKEmployerNICsClass1'
      currency = True
    end
    object qryPaysUKEmployerNICsOther: TFloatField
      FieldName = 'UKEmployerNICsOther'
      currency = True
    end
    object qryPaysRegion: TWideStringField
      FieldName = 'Region'
      Size = 255
    end
    object qryPaysIsContractedOut2: TWideStringField
      FieldName = 'IsContractedOut2'
      FixedChar = True
      Size = 1
    end
  end
  object DSPays: TDataSource
    DataSet = qryPays
    Left = 904
    Top = 8
  end
  object qryEmpTerminate: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblemployeeterminations')
    Left = 584
    object qryEmpTerminateTerminationID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TerminationID'
      Origin = 'tblemployeeterminations.TerminationID'
    end
    object qryEmpTerminateEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblemployeeterminations.EmployeeID'
    end
    object qryEmpTerminateGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblemployeeterminations.GlobalRef'
      Size = 255
    end
    object qryEmpTerminateEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblemployeeterminations.EmployeeName'
      Size = 255
    end
    object qryEmpTerminateETPpre071983: TFloatField
      FieldName = 'ETPpre071983'
      Origin = 'tblemployeeterminations.ETPpre071983'
      currency = True
    end
    object qryEmpTerminateETPpost061983Untaxed: TFloatField
      FieldName = 'ETPpost061983Untaxed'
      Origin = 'tblemployeeterminations.ETPpost061983Untaxed'
      currency = True
    end
    object qryEmpTerminateETPpost061994Component: TFloatField
      FieldName = 'ETPpost061994Component'
      Origin = 'tblemployeeterminations.ETPpost061994Component'
      currency = True
    end
    object qryEmpTerminateETPEarlyRetirement: TFloatField
      FieldName = 'ETPEarlyRetirement'
      Origin = 'tblemployeeterminations.ETPEarlyRetirement'
      currency = True
    end
    object qryEmpTerminateETPInvalidity: TFloatField
      FieldName = 'ETPInvalidity'
      Origin = 'tblemployeeterminations.ETPInvalidity'
      currency = True
    end
    object qryEmpTerminateETPRedundancy: TFloatField
      FieldName = 'ETPRedundancy'
      Origin = 'tblemployeeterminations.ETPRedundancy'
      currency = True
    end
    object qryEmpTerminateETPUnusedRDOs: TFloatField
      FieldName = 'ETPUnusedRDOs'
      Origin = 'tblemployeeterminations.ETPUnusedRDOs'
      currency = True
    end
    object qryEmpTerminateETPDeath: TFloatField
      FieldName = 'ETPDeath'
      Origin = 'tblemployeeterminations.ETPDeath'
      currency = True
    end
    object qryEmpTerminateETPPayInLieu: TFloatField
      FieldName = 'ETPPayInLieu'
      Origin = 'tblemployeeterminations.ETPPayInLieu'
      currency = True
    end
    object qryEmpTerminateETPGoldenHandshake: TFloatField
      FieldName = 'ETPGoldenHandshake'
      Origin = 'tblemployeeterminations.ETPGoldenHandshake'
      currency = True
    end
    object qryEmpTerminateETPJobLossComp: TFloatField
      FieldName = 'ETPJobLossComp'
      Origin = 'tblemployeeterminations.ETPJobLossComp'
      currency = True
    end
    object qryEmpTerminateETPUnusedSick: TFloatField
      FieldName = 'ETPUnusedSick'
      Origin = 'tblemployeeterminations.ETPUnusedSick'
      currency = True
    end
    object qryEmpTerminateETPOther: TFloatField
      FieldName = 'ETPOther'
      Origin = 'tblemployeeterminations.ETPOther'
      currency = True
    end
    object qryEmpTerminateETPTotal: TFloatField
      FieldName = 'ETPTotal'
      Origin = 'tblemployeeterminations.ETPTotal'
      currency = True
    end
    object qryEmpTerminateETPRollover: TFloatField
      FieldName = 'ETPRollover'
      Origin = 'tblemployeeterminations.ETPRollover'
      currency = True
    end
    object qryEmpTerminateStartDate: TDateTimeField
      FieldName = 'StartDate'
      Origin = 'tblemployeeterminations.StartDate'
    end
    object qryEmpTerminateEndDate: TDateTimeField
      FieldName = 'EndDate'
      Origin = 'tblemployeeterminations.EndDate'
    end
    object qryEmpTerminateDaysServicePre01071983: TIntegerField
      FieldName = 'DaysServicePre01071983'
      Origin = 'tblemployeeterminations.DaysServicePre01071983'
    end
    object qryEmpTerminateDaysServicePost30061983: TIntegerField
      FieldName = 'DaysServicePost30061983'
      Origin = 'tblemployeeterminations.DaysServicePost30061983'
    end
    object qryEmpTerminateGrossTermination: TFloatField
      FieldName = 'GrossTermination'
      Origin = 'tblemployeeterminations.GrossTermination'
    end
    object qryEmpTerminateTaxWithheld: TFloatField
      FieldName = 'TaxWithheld'
      Origin = 'tblemployeeterminations.TaxWithheld'
    end
    object qryEmpTerminateETPAssessable: TFloatField
      FieldName = 'ETPAssessable'
      Origin = 'tblemployeeterminations.ETPAssessable'
    end
    object qryEmpTerminateDeathBenefit: TWideStringField
      FieldName = 'DeathBenefit'
      Origin = 'tblemployeeterminations.DeathBenefit'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateTypeOfDeathBenefit: TWideStringField
      FieldName = 'TypeOfDeathBenefit'
      Origin = 'tblemployeeterminations.TypeOfDeathBenefit'
      Size = 64
    end
    object qryEmpTerminateLumpSumA: TFloatField
      FieldName = 'LumpSumA'
      Origin = 'tblemployeeterminations.LumpSumA'
      currency = True
    end
    object qryEmpTerminateLumpSumB: TFloatField
      FieldName = 'LumpSumB'
      Origin = 'tblemployeeterminations.LumpSumB'
      currency = True
    end
    object qryEmpTerminateLumpSumD: TFloatField
      FieldName = 'LumpSumD'
      Origin = 'tblemployeeterminations.LumpSumD'
      currency = True
    end
    object qryEmpTerminateLumpSumE: TFloatField
      FieldName = 'LumpSumE'
      Origin = 'tblemployeeterminations.LumpSumE'
      currency = True
    end
    object qryEmpTerminateReasonLeft: TWideStringField
      FieldName = 'ReasonLeft'
      Origin = 'tblemployeeterminations.ReasonLeft'
      Size = 32
    end
    object qryEmpTerminateGrossETP: TFloatField
      FieldName = 'GrossETP'
      Origin = 'tblemployeeterminations.GrossETP'
      currency = True
    end
    object qryEmpTerminateCDEP: TFloatField
      FieldName = 'CDEP'
      Origin = 'tblemployeeterminations.CDEP'
    end
    object qryEmpTerminateReportableFB: TFloatField
      FieldName = 'ReportableFB'
      Origin = 'tblemployeeterminations.ReportableFB'
    end
    object qryEmpTerminateTotalAllowances: TFloatField
      FieldName = 'TotalAllowances'
      Origin = 'tblemployeeterminations.TotalAllowances'
    end
    object qryEmpTerminatemsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblemployeeterminations.msTimeStamp'
    end
    object qryEmpTerminateDeathBeneficiaryHasTFN: TWideStringField
      FieldName = 'DeathBeneficiaryHasTFN'
      Origin = 'tblemployeeterminations.DeathBeneficiaryHasTFN'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateIsPayEntitled: TWideStringField
      FieldName = 'IsPayEntitled'
      Origin = 'tblemployeeterminations.IsPayEntitled'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateIsETPEntitled: TWideStringField
      FieldName = 'IsETPEntitled'
      Origin = 'tblemployeeterminations.IsETPEntitled'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateIsManualLongService: TWideStringField
      FieldName = 'IsManualLongService'
      Origin = 'tblemployeeterminations.IsManualLongService'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateIsManualAnnualLeave: TWideStringField
      FieldName = 'IsManualAnnualLeave'
      Origin = 'tblemployeeterminations.IsManualAnnualLeave'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateOtherPaymentType: TWideStringField
      FieldName = 'OtherPaymentType'
      Origin = 'tblemployeeterminations.OtherPaymentType'
      Size = 255
    end
    object qryEmpTerminateLongServicePre16081978: TFloatField
      FieldName = 'LongServicePre16081978'
      Origin = 'tblemployeeterminations.LongServicePre16081978'
    end
    object qryEmpTerminateLongServicePost16081978: TFloatField
      FieldName = 'LongServicePost16081978'
      Origin = 'tblemployeeterminations.LongServicePost16081978'
    end
    object qryEmpTerminateLongServicePost17081993: TFloatField
      FieldName = 'LongServicePost17081993'
      Origin = 'tblemployeeterminations.LongServicePost17081993'
    end
    object qryEmpTerminateAnnualLeavePre18081993: TFloatField
      FieldName = 'AnnualLeavePre18081993'
      Origin = 'tblemployeeterminations.AnnualLeavePre18081993'
      currency = True
    end
    object qryEmpTerminateAnnualLeavePost17081993: TFloatField
      FieldName = 'AnnualLeavePost17081993'
      Origin = 'tblemployeeterminations.AnnualLeavePost17081993'
      currency = True
    end
    object qryEmpTerminateAnnLeaveLoadingPre18081993: TFloatField
      FieldName = 'AnnLeaveLoadingPre18081993'
      Origin = 'tblemployeeterminations.AnnLeaveLoadingPre18081993'
      currency = True
    end
    object qryEmpTerminateAnnLeaveLoadingPost17081993: TFloatField
      FieldName = 'AnnLeaveLoadingPost17081993'
      Origin = 'tblemployeeterminations.AnnLeaveLoadingPost17081993'
      currency = True
    end
    object qryEmpTerminateOtherPaymentAmount: TFloatField
      FieldName = 'OtherPaymentAmount'
      Origin = 'tblemployeeterminations.OtherPaymentAmount'
    end
    object qryEmpTerminateGross: TFloatField
      FieldName = 'Gross'
      Origin = 'tblemployeeterminations.Gross'
      currency = True
    end
    object qryEmpTerminateTax: TFloatField
      FieldName = 'Tax'
      Origin = 'tblemployeeterminations.Tax'
      currency = True
    end
    object qryEmpTerminateNet: TFloatField
      FieldName = 'Net'
      Origin = 'tblemployeeterminations.Net'
      currency = True
    end
    object qryEmpTerminateTotalLumpSums: TFloatField
      FieldName = 'TotalLumpSums'
      Origin = 'tblemployeeterminations.TotalLumpSums'
      currency = True
    end
    object qryEmpTerminatePayID: TIntegerField
      FieldName = 'PayID'
      Origin = 'tblemployeeterminations.PayID'
    end
    object qryEmpTerminateLumpSumC: TFloatField
      FieldName = 'LumpSumC'
      Origin = 'tblemployeeterminations.LumpSumC'
      currency = True
    end
    object qryEmpTerminateETPtaxfree: TFloatField
      FieldName = 'ETPtaxfree'
      Origin = 'tblemployeeterminations.ETPtaxfree'
      currency = True
    end
    object qryEmpTerminateDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblemployeeterminations.Deleted'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminatePayGross: TFloatField
      FieldName = 'PayGross'
      currency = True
    end
    object qryEmpTerminateComplete: TWideStringField
      FieldName = 'Complete'
      FixedChar = True
      Size = 1
    end
    object qryEmpTerminateData: TWideMemoField
      FieldName = 'Data'
      BlobType = ftWideMemo
    end
  end
  object DSTerminations: TDataSource
    DataSet = qryEmpTerminate
    Left = 512
    Top = 8
  end
end
