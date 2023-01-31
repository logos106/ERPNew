object Form1: TForm1
  Left = 236
  Top = 228
  Caption = 'Form1'
  ClientHeight = 648
  ClientWidth = 1154
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    1154
    648)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 400
    Width = 1154
    Height = 248
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'When Adding / Removing Images, Please Remember to Update The  Im' +
      'ageDLLLib.TotalImages'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -64
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Layout = tlCenter
    Visible = False
    WordWrap = True
  end
  object pnlHeader: TPanel
    Left = 263
    Top = 5
    Width = 514
    Height = 49
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 512
      Height = 47
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
      ExplicitWidth = 467
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 512
        Height = 47
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Image Test'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitLeft = -3
        ExplicitWidth = 548
      end
    end
  end
end
