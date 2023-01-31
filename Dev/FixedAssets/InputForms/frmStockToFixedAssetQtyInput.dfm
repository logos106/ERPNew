inherited fmStockToFixedAssetQtyInput: TfmStockToFixedAssetQtyInput
  BorderStyle = bsDialog
  Caption = 'Product Quantity'
  ClientHeight = 214
  ClientWidth = 413
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Position = poScreenCenter
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 419
  ExplicitHeight = 242
  DesignSize = (
    413
    214)
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1408002
  inherited lblSkingroupMsg: TLabel
    Top = 214
    Width = 413
    ExplicitTop = 214
    ExplicitWidth = 413
    HelpContext = 1408003
  end
  object Label1: TLabel [3]
    Left = 114
    Top = 123
    Width = 109
    Height = 15
    Caption = 'Quantity of Product'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 1408004
  end
  object Label2: TLabel [4]
    Left = 24
    Top = 67
    Width = 363
    Height = 30
    Alignment = taCenter
    AutoSize = False
    Caption = 'Select the quantity'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    HelpContext = 1408005
  end
  object cmdClose: TDNMSpeedButton [5]
    Left = 92
    Top = 177
    Width = 93
    Height = 29
    Anchors = [akBottom]
    Caption = '&Save'
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
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    HelpContext = 1408006
  end
  object cmdCancel: TDNMSpeedButton [6]
    Left = 228
    Top = 177
    Width = 93
    Height = 29
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
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    HelpContext = 1408007
  end
  object pnlTitle: TDNMPanel [7]
    Left = 24
    Top = 9
    Width = 365
    Height = 39
    HelpContext = 1408008
    Anchors = [akLeft, akTop, akRight]
    
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 3
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 363
      Height = 37
      HelpContext = 1408009
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
        Width = 363
        Height = 37
        HelpContext = 1408010
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Product Quantity'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 171
      end
    end
  end
  object edtQty: TAdvEdit [8]
    Left = 240
    Top = 120
    Width = 49
    Height = 23
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 0
    Text = '0'
    Visible = True
    Version = '2.8.6.9'
    HelpContext = 1408011
  end
  inherited popSpelling: TPopupMenu
    Left = 200
    Top = 65512
  end
  inherited tmrdelayMsg: TTimer
    Left = 96
    Top = 65528
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 41
    Top = 24
  end
end
