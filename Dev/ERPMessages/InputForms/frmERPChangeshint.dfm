inherited fmERPChangeshint: TfmERPChangeshint
  Left = 802
  Top = 235
  BorderStyle = bsSingle
  Caption = 'Additions'
  ClientHeight = 477
  ClientWidth = 601
  Position = poMainFormCenter
  ExplicitLeft = 802
  ExplicitTop = 235
  ExplicitWidth = 609
  ExplicitHeight = 504
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1320002
  inherited lblSkingroupMsg: TLabel
    Top = 477
    Width = 601
    ExplicitTop = 443
    ExplicitWidth = 601
    HelpContext = 1320003
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 0
    Top = 0
    Width = 601
    Height = 477
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      601
      477)
    HelpContext = 1320004
    object cmdClose: TDNMSpeedButton
      Left = 257
      Top = 442
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
      HelpContext = 1320005
    end
    object pnlHeader: TPanel
      AlignWithMargins = True
      Left = 166
      Top = 4
      Width = 269
      Height = 49
      HelpContext = 1320006
      Margins.Left = 165
      Margins.Right = 165
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Accounts Receivable List'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 267
        Height = 47
        HelpContext = 1320007
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
          Width = 267
          Height = 47
          HelpContext = 1320008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Additions'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -1
          ExplicitTop = -2
        end
      end
    end
    object DNMPanel2: TDNMPanel
      AlignWithMargins = True
      Left = 12
      Top = 64
      Width = 577
      Height = 368
      Margins.Left = 11
      Margins.Top = 11
      Margins.Right = 11
      Margins.Bottom = 44
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      HelpContext = 1320009
      object GeneralNote: TRTFLabel
        AlignWithMargins = True
        Left = 2
        Top = 2
        Width = 573
        Height = 364
        HelpContext = 1320010
        Margins.Left = 1
        Margins.Top = 1
        Margins.Right = 1
        Margins.Bottom = 1
        RichText = 
          #6011#5980#6002#6004#5990#5937#5980#5985#5998#6003#5993#5980#5985#5998#6003#5993#5987#6000#5991#5937#5938#5941#5938#5980#5988#5989#5990#5990#5936#6011#5980#5990#5999#5998#6004#6004#5986#5996#6011#5980#5990#5936#5980#5990#5998#5993#5996#5980#5990#5987#5992#5985#6002#6003#5989#6004#5936#5920#5955#5999#6005#6002#5993#5989 +
          #6002#5920#5966#5989#6007#5947#6013#6013#5901#5898#5980#6006#5993#5989#6007#5995#5993#5998#5988#5940#5980#6005#5987#5937#5980#6000#5985#6002#5988#5980#5996#5985#5998#5991#5939#5936#5944#5937#5980#5986#5980#5990#5936#5980#5990#6003#5939#5938#5980#6000#5985#6002#5901#5898#5980#6000#5985#6002#5988#5980#6001#5987#5920#5962 +
          #5999#5986#6003#5920#6007#5993#5996#5996#5920#5997#5999#6006#5989#5920#6005#6000#5920#5999#6002#5920#5988#5999#6007#5998#5920#5986#5985#6003#5989#5988#5920#5999#5998#5920#6004#5992#5989#5920#5990#5999#5996#5996#5999#6007#5993#5998#5991#5934#5980#5990#6003#5940#5940#5980#6000#5985#6002#5901#5898#5980#6000#5985#6002#5988 +
          #5980#5990#6003#5937#5942#5980#6000#5985#6002#5901#5898#5980#5990#6003#5938#5940#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5958#5993#6002#6003#6004#5920#5920#5946#5920#5954#6005#5991#6003#5980#6000#5985#6002#5901#5898#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5971#5989#5987#5999#5998#5988#5920#5946 +
          #5920#5968#5985#5993#5988#5920#5971#5996#5999#6004#6003#5980#6000#5985#6002#5901#5898#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5972#5992#5993#6002#5988#5920#5920#5946#5920#5958#6002#5989#5989#5920#5953#5988#5993#6004#5993#5999#5998#6003#5980#6000#5985#6002#5901#5898#5980#6000#5985#6002#5901#5898#5980#6000#5985 +
          #6002#5988#5980#6001#5987#5980#5990#6003#5939#5938#5920#5971#5999#5920#5993#5990#5920#6009#5999#6005#5920#6007#5985#5998#6004#5920#6009#5999#6005#6002#5920#5985#5988#5988#5993#6004#5993#5999#5998#5920#5997#5999#6006#5989#5988#5920#5993#6004#5920#5993#6003#5920#5987#6005#6002#6002#5989#5998#6004#5996#6009#5980#6000#5985 +
          #6002#5901#5898#5980#6000#5985#6002#5988#5980#5990#6003#5937#5942#5980#6000#5985#6002#5901#5898#5980#5990#6003#5938#5940#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5937#6003#6004#5920#5971#5996#5999#6004#5920#5924#5944#5936#5936#5936#5980#6000#5985#6002#5901#5898#5920#5920#5920#5920#5920#5920#5920#5920#5920 +
          #5920#5938#5998#5988#5920#5971#5996#5999#6004#5920#5924#5943#5936#5936#5936#5980#6000#5985#6002#5901#5898#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5939#6002#5988#5920#5971#5996#5999#6004#5920#5924#5942#5936#5936#5936#5980#6000#5985#6002#5901#5898#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5940#6004#5992 +
          #5920#5971#5996#5999#6004#5920#5924#5941#5936#5936#5936#5980#6000#5985#6002#5901#5898#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5941#6004#5992#5920#5971#5996#5999#6004#5920#5924#5940#5936#5936#5936#5980#6000#5985#6002#5901#5898#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5942#6004#5992#5920#5971#5996#5999 +
          #6004#5920#5966#5999#5920#5955#5992#5985#6002#5991#5989#5980#6000#5985#6002#5901#5898#5920#5920#5920#5920#5920#5920#5920#5920#5920#5920#5943#6004#5992#5920#5971#5996#5999#6004#5920#5966#5999#5920#5955#5992#5985#6002#5991#5989#5980#5990#6003#5937#5942#5980#6000#5985#6002#5901#5898#5980#5996#5985#5998#5991#5937#5936#5939 +
          #5939#5980#5990#6003#5937#5936#5980#6000#5985#6002#5901#5898#6013#5901#5898#5888
        Align = alClient
        Color = clWhite
        Transparent = False
        WordWrap = True
        Version = '1.3.0.0'
        ExplicitLeft = 10
        ExplicitTop = 66
        ExplicitWidth = 577
        ExplicitHeight = 368
      end
    end
  end
end
