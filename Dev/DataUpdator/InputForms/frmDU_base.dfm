inherited fmDU_base: TfmDU_base
  Left = 1088
  Top = 32
  Caption = 'fmDU_base'
  ClientWidth = 824
  ExplicitWidth = 840
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Width = 824
    ExplicitWidth = 824
  end
  object pnlMain: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 824
    Height = 155
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object pnlTop: TDNMPanel
      Left = 1
      Top = 1
      Width = 822
      Height = 47
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object Shader1: TShader
        Left = 1
        Top = 1
        Width = 820
        Height = 45
        Align = alClient
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object lblCaption: TLabel
          Left = 0
          Top = 0
          Width = 820
          Height = 45
          Align = alClient
          AutoSize = False
          Caption = 'page caption'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 803
          ExplicitHeight = 28
        end
      end
    end
    object pnlDEtails: TDNMPanel
      Left = 1
      Top = 48
      Width = 822
      Height = 106
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 177
    Top = 11
  end
  inherited tmrdelay: TTimer
    Left = 136
  end
end
