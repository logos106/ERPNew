inherited GoogleAnalytic_SummaryGUI: TGoogleAnalytic_SummaryGUI
  HelpContext = 953001
  Caption = 'GoogleAnalytic_SummaryGUI'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited Horizontal1: TSplitter
    ExplicitLeft = 8
    ExplicitTop = 242
    ExplicitWidth = 998
  end
  object report1n2: TSplitter [4]
    Left = 510
    Top = 241
    Width = 2
    Height = 283
    HelpContext = 953002
    Align = alRight
    ExplicitLeft = 710
    ExplicitTop = 240
    ExplicitHeight = 288
  end
  inherited pnltop: TDNMPanel
    HelpContext = 953010
    inherited pnlTitle: TDNMPanel
      HelpContext = 953011
      inherited TitleShader: TShader
        inherited lblTitle: TLabel
          HelpContext = 953003
          Caption = 'GoogleAnalytic_SummaryGUI'
        end
      end
    end
  end
  inherited pnlgraph: TDNMPanel
    HelpContext = 953012
    object Splitter1: TSplitter
      Left = 151
      Top = 1
      Width = 2
      Height = 181
      HelpContext = 953004
      ExplicitLeft = 1
      ExplicitHeight = 996
    end
    object pnlSeries: TDNMPanel
      Left = 1
      Top = 1
      Width = 150
      Height = 181
      Hint = 
        'This selection for current view Only.  Double click on List Data' +
        ' to Edit chart.  '
      HelpContext = 953005
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  inherited pnlList: TDNMPanel
    Width = 510
    HelpContext = 953006
    ExplicitWidth = 510
  end
  object pnlSubgraph: TDNMPanel [9]
    Left = 512
    Top = 241
    Width = 486
    Height = 283
    Hint = 'Double click on List Data to Edit chart'
    HelpContext = 953007
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    object lblGraph: TLabel
      Left = 1
      Top = 1
      Width = 484
      Height = 24
      HelpContext = 953008
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Analytic Report'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitWidth = 292
    end
    object optcharts: TRadioGroup
      Left = 1
      Top = 229
      Width = 484
      Height = 53
      HelpContext = 953009
      Align = alBottom
      Columns = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Items.Strings = (
        'Visits'
        'New Visits'
        'Pageviews'
        'Impressions'
        'Duration'
        'Bounces'
        'Pages/visit')
      ParentFont = False
      TabOrder = 0
      OnClick = optchartsClick
    end
  end
end
