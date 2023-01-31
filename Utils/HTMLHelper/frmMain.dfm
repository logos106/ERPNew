object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'fmMain'
  ClientHeight = 603
  ClientWidth = 855
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 855
    Height = 603
    ActivePage = tabHTMLToStr
    Align = alClient
    TabOrder = 0
    object tabHTMLToStr: TTabSheet
      Caption = 'HTML to String'
      object Splitter1: TSplitter
        Left = 0
        Top = 297
        Width = 847
        Height = 4
        Cursor = crVSplit
        Align = alTop
        ExplicitTop = 262
        ExplicitWidth = 810
      end
      object memHTML: TMemo
        Left = 0
        Top = 41
        Width = 847
        Height = 256
        Align = alTop
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
      object memString: TMemo
        Left = 0
        Top = 301
        Width = 847
        Height = 272
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 1
        WordWrap = False
      end
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 847
        Height = 41
        Align = alTop
        TabOrder = 2
        object btnConvertToStr: TButton
          Left = 0
          Top = 7
          Width = 121
          Height = 25
          Caption = 'Convert To String'
          TabOrder = 0
          OnClick = btnConvertToStrClick
        end
        object btnFixReturns: TButton
          Left = 136
          Top = 7
          Width = 113
          Height = 25
          Caption = 'Fix Line Returns'
          TabOrder = 1
          OnClick = btnFixReturnsClick
        end
      end
    end
  end
end
