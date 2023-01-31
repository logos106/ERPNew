inherited fmReportOptions: TfmReportOptions
  Left = 289
  Top = 124
  Caption = 'Report Options '
  ClientHeight = 265
  ClientWidth = 268
  Position = poMainFormCenter
  ExplicitLeft = 289
  ExplicitTop = 124
  ExplicitWidth = 276
  ExplicitHeight = 292
  PixelsPerInch = 96
  TextHeight = 13
  inherited shapehint: TShape
    Left = -6
    ExplicitLeft = -6
  end
  inherited shapehintextra1: TShape
    Left = 5
    ExplicitLeft = 5
  end
  inherited lblSkingroupMsg: TLabel
    Top = 222
    Width = 268
    ExplicitTop = 184
    ExplicitWidth = 268
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 0
    Top = 0
    Width = 268
    Height = 55
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlTitle: TDNMPanel
      Left = 34
      Top = 7
      Width = 216
      Height = 39
      HelpContext = 267014
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -25
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 212
        Height = 35
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
          Width = 212
          Height = 35
          HelpContext = 267016
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Report Options '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -25
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 213
          ExplicitHeight = 36
        end
      end
    end
  end
  object DNMPanel2: TDNMPanel [4]
    Left = 0
    Top = 55
    Width = 268
    Height = 167
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object chkprint: TCheckBox
      Left = 73
      Top = 31
      Width = 145
      Height = 14
      Caption = 'P&rint Report'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object chkpreview: TCheckBox
      Left = 73
      Top = 62
      Width = 145
      Height = 15
      Caption = 'Pre&view Report'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object chkemail: TCheckBox
      Left = 73
      Top = 93
      Width = 145
      Height = 15
      Caption = '&Email Report'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object chkPDF: TCheckBox
      Left = 73
      Top = 124
      Width = 145
      Height = 15
      Caption = '&PDF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 222
    Width = 268
    Height = 43
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      268
      43)
    object cmdClose: TDNMSpeedButton
      Left = 146
      Top = 6
      Width = 87
      Height = 27
      Hint = '"Close The List"'
      Anchors = [akBottom]
      Caption = '&Close'
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = cmdCloseClick
    end
    object cmdPrint: TDNMSpeedButton
      Left = 36
      Top = 6
      Width = 87
      Height = 27
      Hint = '"Print The List"'
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
      OnClick = cmdPrintClick
    end
  end
  inherited tmrdelay: TTimer
    Left = 16
    Top = 96
  end
end
