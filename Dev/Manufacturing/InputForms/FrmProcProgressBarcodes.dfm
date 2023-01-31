inherited FmProcProgressBarcodes: TFmProcProgressBarcodes
  Left = 374
  Top = 290
  Caption = 'Reprint'
  ClientHeight = 565
  ClientWidth = 909
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  OnKeyUp = FormKeyUp
  ExplicitLeft = 374
  ExplicitTop = 290
  ExplicitWidth = 925
  ExplicitHeight = 604
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1654002
  inherited lblSkingroupMsg: TLabel
    Top = 415
    Width = 909
    ExplicitTop = 542
    ExplicitWidth = 818
    HelpContext = 1654003
  end
  object DNMPanel2: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 909
    Height = 71
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 539
    DesignSize = (
      909
      71)
    HelpContext = 1654004
    object pnlTitle: TDNMPanel
      Left = 164
      Top = 10
      Width = 582
      Height = 53
      HelpContext = 1654005
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Reprint'
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
        Width = 580
        Height = 51
        HelpContext = 1654006
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
          Width = 580
          Height = 51
          HelpContext = 1654007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Reprint'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -37
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 171
          ExplicitHeight = 37
        end
      end
    end
  end
  object pnlReport: TDNMPanel [5]
    Left = 0
    Top = 71
    Width = 909
    Height = 344
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    HelpContext = 1654008
  end
  object pnlFooter: TDNMPanel [6]
    Left = 0
    Top = 415
    Width = 909
    Height = 150
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    HelpContext = 1654009
    object pnlButtons: TDNMPanel
      AlignWithMargins = True
      Left = 246
      Top = 68
      Width = 417
      Height = 80
      Margins.Left = 245
      Margins.Top = 1
      Margins.Right = 245
      Margins.Bottom = 1
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      Transparent = False
      HelpContext = 1654010
    end
    object pnlAdvPrinting: TDNMPanel
      AlignWithMargins = True
      Left = 4
      Top = 35
      Width = 901
      Height = 29
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      Visible = False
      Transparent = False
      HelpContext = 1654011
      object chkPreview: TCheckBox
        AlignWithMargins = True
        Left = 12
        Top = 4
        Width = 885
        Height = 21
        Margins.Left = 11
        Align = alClient
        Caption = 'Show Previe&w'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Visible = False
        HelpContext = 1654012
      end
    end
    object DNMPanel1: TDNMPanel
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 905
      Height = 29
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      Transparent = False
      HelpContext = 1654013
      object ChkShowCurrentOnly: TCheckBox
        AlignWithMargins = True
        Left = 15
        Top = 3
        Width = 887
        Height = 23
        Margins.Left = 15
        Align = alClient
        Caption = 'Show Current                 Only'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        WordWrap = True
        OnClick = ChkShowCurrentOnlyClick
        HelpContext = 1654014
      end
    end
  end
  object Actions: TActionList
    Left = 216
    Top = 165
    object actPrint: TDNMAction
      Caption = 'Print Barcode'
      HelpContext = 1654015
      Hint = 'This will Flag 1 Qty as Finished and will be available in Stock'
      ImageIndex = 744
      OnExecute = actPrintExecute
      buttoncolor = clWhite
    end
    object actclose: TDNMAction
      Caption = 'Close'
      HelpContext = 1654016
      Hint = 'close'
      ImageIndex = 238
      OnExecute = actcloseExecute
      buttoncolor = clWhite
    end
  end
end
