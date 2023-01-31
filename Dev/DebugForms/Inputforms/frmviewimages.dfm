inherited fmviewimages: Tfmviewimages
  Left = 2541
  Top = 128
  HelpContext = 1117002
  Caption = 'fmviewimages'
  ClientHeight = 565
  ClientWidth = 996
  ExplicitLeft = 2541
  ExplicitTop = 128
  ExplicitWidth = 1012
  ExplicitHeight = 603
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 565
    Width = 996
    HelpContext = 1117003
    ExplicitTop = 565
    ExplicitWidth = 996
  end
  inherited shapehint: TShape
    Left = 322
    Top = 186
    ExplicitLeft = 322
    ExplicitTop = 186
  end
  inherited shapehintextra1: TShape
    Left = 362
    Top = 186
    ExplicitLeft = 362
    ExplicitTop = 186
  end
  object sbButtons: TScrollBox [4]
    Left = 0
    Top = 0
    Width = 996
    Height = 565
    HelpContext = 1117004
    HorzScrollBar.Visible = False
    VertScrollBar.Style = ssHotTrack
    Align = alClient
    BevelEdges = []
    BevelInner = bvLowered
    BevelKind = bkSoft
    TabOrder = 0
    object pnlButtons1: TDNMPanel
      Left = 0
      Top = 0
      Width = 992
      Height = 561
      HelpContext = 1117005
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Transparent = False
    end
    object pnlmain: TDNMPanel
      Left = 0
      Top = 0
      Width = 992
      Height = 561
      HelpContext = 1117006
      Align = alClient
      Anchors = []
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      Transparent = False
      DesignSize = (
        992
        561)
      object cmdExport: TDNMSpeedButton
        Left = 280
        Top = 30
        Width = 110
        Height = 95
        HelpContext = 1117007
        Action = acttest
        Anchors = [akBottom]
        Caption = 'acttest'
        Color = 16758783
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Layout = blGlyphTop
        MaxTextDisplay = False
        ParentColor = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        SlowDecease = True
        Style = bsOld
        TabOrder = 0
        TabStop = False
        Visible = False
        WordWrap = True
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 313
    Top = 187
  end
  inherited tmrdelay: TTimer
    Left = 368
    Top = 192
  end
  object ActionList1: TActionList
    Left = 248
    Top = 48
    object acttest: TDNMAction
      Category = 'DNMAction'
      Caption = 'acttest'
      HelpContext = 1117008
      ImageIndex = 312
      buttoncolor = clBlack
    end
  end
end
