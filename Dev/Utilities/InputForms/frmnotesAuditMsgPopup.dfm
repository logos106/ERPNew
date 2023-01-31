inherited fmnotesAuditMsgPopup: TfmnotesAuditMsgPopup
  Left = 134
  Top = 288
  Caption = 'Changed Details'
  ClientHeight = 439
  ClientWidth = 604
  KeyPreview = True
  ExplicitLeft = 134
  ExplicitTop = 288
  ExplicitWidth = 612
  ExplicitHeight = 466
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 848001
  object DNMPanel2: TDNMPanel
    Left = 0
    Top = 95
    Width = 297
    Height = 294
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitTop = 70
    ExplicitHeight = 319
    HelpContext = 848002
    object lblFrom: TLabel
      Left = 1
      Top = 1
      Width = 295
      Height = 15
      Align = alTop
      Alignment = taCenter
      Caption = 'Before Change'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 4
      ExplicitTop = 5
      ExplicitWidth = 266
      HelpContext = 848003
    end
    object memoOld: TMemo
      Left = 1
      Top = 17
      Width = 295
      Height = 276
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitTop = 20
      HelpContext = 848004
    end
  end
  object DNMPanel3: TDNMPanel
    Left = 0
    Top = 389
    Width = 604
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      604
      50)
    HelpContext = 848005
    object cmdClose: TDNMSpeedButton
      Left = 256
      Top = 12
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
      HelpContext = 848006
    end
  end
  object DNMPanel1: TDNMPanel
    Left = 0
    Top = 0
    Width = 604
    Height = 95
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      604
      95)
    HelpContext = 848007
    object lblChangedby: TLabel
      Left = 4
      Top = 71
      Width = 76
      Height = 15
      Caption = 'Changed By : '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      HelpContext = 848008
    end
    object pnlHeader: TPanel
      Left = 26
      Top = 9
      Width = 550
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      HelpContext = 848009
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 548
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
        HelpContext = 848010
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 548
          Height = 47
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Notes Audit Trail'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -3
          HelpContext = 848011
        end
      end
    end
    object EdtChangedby: TEdit
      Left = 96
      Top = 67
      Width = 247
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'EdtChangedby'
      HelpContext = 848012
    end
  end
  object DNMPanel4: TDNMPanel
    Left = 307
    Top = 95
    Width = 297
    Height = 294
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    ExplicitTop = 70
    ExplicitHeight = 319
    HelpContext = 848013
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 295
      Height = 15
      Align = alTop
      Alignment = taCenter
      Caption = 'Changed To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 4
      ExplicitTop = 5
      ExplicitWidth = 266
      HelpContext = 848014
    end
    object memonew: TMemo
      Left = 1
      Top = 17
      Width = 295
      Height = 276
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitTop = 2
      HelpContext = 848015
    end
  end
  object DNMPanel5: TDNMPanel
    Left = 297
    Top = 95
    Width = 10
    Height = 294
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    ExplicitLeft = 232
    ExplicitTop = 215
    ExplicitWidth = 150
    ExplicitHeight = 50
    HelpContext = 848016
  end
end
