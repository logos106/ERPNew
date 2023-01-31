inherited ProgressPaymentPopUp: TProgressPaymentPopUp
  Left = 353
  Top = 224
  BorderStyle = bsSingle
  Caption = 'Project To Invoice Conversion'
  ClientHeight = 381
  ClientWidth = 465
  Color = 15527129
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 453000
  object pnlConvert: TDNMPanel
    Left = 48
    Top = 80
    Width = 361
    Height = 241
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    HelpContext = 453001
    object Label2: TLabel
      Left = 257
      Top = 114
      Width = 14
      Height = 14
      Caption = 'All'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      HelpContext = 453002
    end
    object Label4: TLabel
      Left = 72
      Top = 116
      Width = 73
      Height = 15
      Caption = '% To Convert'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      HelpContext = 453003
    end
    object Label6: TLabel
      Left = 99
      Top = 73
      Width = 46
      Height = 15
      Caption = 'Balance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      HelpContext = 453004
    end
    object Label1: TLabel
      Left = 51
      Top = 44
      Width = 95
      Height = 15
      Caption = 'Total Amount Inc'
      Transparent = True
      HelpContext = 453005
    end
    object Label3: TLabel
      Left = 35
      Top = 146
      Width = 108
      Height = 15
      Caption = 'Amount To Convert'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      HelpContext = 453006
    end
    object Label5: TLabel
      Left = 32
      Top = 184
      Width = 194
      Height = 15
      Caption = 'Description Shown on Invoice Line'
      HelpContext = 453007
    end
    object chkConvertAll: TCheckBox
      Left = 240
      Top = 112
      Width = 17
      Height = 17
      Caption = 'chkConvertAll'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkConvertAllClick
      HelpContext = 453008
    end
    object edtPercent: TEdit
      Left = 152
      Top = 110
      Width = 65
      Height = 23
      AutoSelect = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'edtPercent'
      OnChange = edtPercentChange
      HelpContext = 453009
    end
    object edtBalance: TEdit
      Left = 152
      Top = 68
      Width = 121
      Height = 23
      TabStop = False
      Color = 15724272
      Enabled = False
      TabOrder = 4
      Text = 'edtBalance'
      HelpContext = 453010
    end
    object edtTotal: TEdit
      Left = 152
      Top = 40
      Width = 121
      Height = 23
      TabStop = False
      Color = 15724272
      Enabled = False
      TabOrder = 5
      Text = 'edtTotal'
      HelpContext = 453011
    end
    object edtAmount: TEdit
      Left = 152
      Top = 140
      Width = 121
      Height = 23
      AutoSelect = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'edtAmount'
      OnChange = edtAmountChange
      OnEnter = edtAmountEnter
      OnExit = edtAmountExit
      HelpContext = 453012
    end
    object edtDesc: TEdit
      Left = 32
      Top = 200
      Width = 241
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      MaxLength = 255
      ParentFont = False
      TabOrder = 3
      Text = 'edtDesc'
      HelpContext = 453013
    end
  end
  object btnSave: TDNMSpeedButton
    Left = 120
    Top = 336
    Width = 87
    Height = 27
    Caption = 'OK'
    Default = True
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    HelpContext = 453014
  end
  object btnCancel: TDNMSpeedButton
    Left = 248
    Top = 336
    Width = 87
    Height = 27
    Cancel = True
    Caption = 'Cancel'
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    HelpContext = 453015
  end
  object pnlTitle: TDNMPanel
    Left = 91
    Top = 9
    Width = 280
    Height = 45
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    HelpContext = 453016
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 276
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
      Version = '1.2.1.1'
      HelpContext = 453017
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 276
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Progress Payment'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        HelpContext = 453018
      end
    end
  end
end
