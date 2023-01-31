inherited fmBudgetExportImportSelect: TfmBudgetExportImportSelect
  BorderStyle = bsDialog
  Caption = 'File Select'
  ClientHeight = 206
  ClientWidth = 450
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Position = poScreenCenter
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 456
  ExplicitHeight = 234
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1240002
  inherited lblSkingroupMsg: TLabel
    Top = 206
    Width = 450
    HelpContext = 1240003
  end
  object Label1: TLabel [3]
    Left = 50
    Top = 79
    Width = 58
    Height = 15
    Caption = 'File Name:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    HelpContext = 1240004
  end
  object pnlTitle: TDNMPanel [4]
    Left = 101
    Top = 2
    Width = 238
    Height = 45
    HelpContext = 1240005
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
      Height = 41
      HelpContext = 1240006
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
        HelpContext = 1240007
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'File Select'
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
  object btnOk: TDNMSpeedButton [5]
    Left = 124
    Top = 171
    Width = 87
    Height = 27
    Hint = '"Close The List"'
    Anchors = [akBottom]
    Caption = 'Ok'
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
    TabOrder = 1
    TabStop = False
    OnClick = btnOkClick
    ExplicitLeft = 120
    ExplicitTop = 197
    HelpContext = 1240008
  end
  object btnCancel: TDNMSpeedButton [6]
    Left = 238
    Top = 171
    Width = 87
    Height = 27
    Hint = '"Close The List"'
    Anchors = [akBottom]
    Caption = 'Cancel'
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
    ModalResult = 2
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TabStop = False
    ExplicitLeft = 232
    ExplicitTop = 197
    HelpContext = 1240009
  end
  object edtFileName: TEdit [7]
    Left = 50
    Top = 95
    Width = 289
    Height = 23
    TabOrder = 3
    Text = 'edtFileName'
    HelpContext = 1240010
  end
  object btnFile: TButton [8]
    Left = 338
    Top = 94
    Width = 34
    Height = 25
    Caption = '...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnFileClick
    HelpContext = 1240011
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '.csv'
    Filter = 'CSV Files|*.csv|All Files|*.*'
    Left = 376
    Top = 24
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.csv'
    Filter = 'CSV Files|*.CSV|All Files|*.*'
    Left = 392
    Top = 80
  end
end
