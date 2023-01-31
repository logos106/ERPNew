inherited AnalyticReportGUI: TAnalyticReportGUI
  Left = 409
  Top = 162
  BorderStyle = bsSingle
  Caption = 'Analytic report'
  ClientHeight = 564
  ClientWidth = 998
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  ExplicitLeft = 409
  ExplicitTop = 162
  ExplicitWidth = 1006
  ExplicitHeight = 591
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 937001
  inherited lblSkingroupMsg: TLabel
    Top = 524
    Width = 998
    ExplicitTop = 524
    ExplicitWidth = 998
    HelpContext = 937002
  end
  object Horizontal1: TSplitter [3]
    Left = 0
    Top = 239
    Width = 998
    Height = 2
    Cursor = crVSplit
    HelpContext = 937003
    Align = alTop
    ExplicitLeft = 1
    ExplicitTop = 184
    ExplicitWidth = 996
  end
  object pnlbottom: TDNMPanel [4]
    Left = 0
    Top = 524
    Width = 998
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      998
      40)
    HelpContext = 937004
    object cmdClose: TDNMSpeedButton
      Left = 540
      Top = 7
      Width = 87
      Height = 27
      Hint = '"Close The List"'
      Anchors = [akBottom]
      Cancel = True
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
      HelpContext = 937005
    end
    object cmdPrint: TDNMSpeedButton
      Left = 369
      Top = 7
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
      HelpContext = 937006
    end
  end
  object pnltop: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 998
    Height = 56
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      998
      56)
    HelpContext = 937007
    object pnlTitle: TDNMPanel
      Left = 204
      Top = 5
      Width = 589
      Height = 38
      HelpContext = 937008
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Purchase Order'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 587
        Height = 36
        HelpContext = 937009
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
        object lblTitle: TLabel
          Left = 0
          Top = 0
          Width = 587
          Height = 36
          HelpContext = 937010
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Analytic Report'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 549
        end
      end
    end
  end
  object pnlgraph: TDNMPanel [6]
    Left = 0
    Top = 56
    Width = 998
    Height = 183
    Hint = 'Double click on List Data to Edit chart'
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    HelpContext = 937011
  end
  object pnlList: TDNMPanel [7]
    Left = 0
    Top = 241
    Width = 998
    Height = 283
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    HelpContext = 937012
  end
end
