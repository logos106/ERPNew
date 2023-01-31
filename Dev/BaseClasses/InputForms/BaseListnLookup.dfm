inherited BaseListnLookupGUI: TBaseListnLookupGUI
  Left = 592
  Top = 301
  HelpContext = 1349002
  Caption = 'BaseListnLookupGUI'
  ClientHeight = 565
  ClientWidth = 996
  KeyPreview = True
  Position = poMainFormCenter
  ExplicitLeft = 592
  ExplicitTop = 301
  ExplicitWidth = 1012
  ExplicitHeight = 604
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 565
    Width = 996
    HelpContext = 1349003
    ExplicitTop = 565
    ExplicitWidth = 996
  end
  object report1n2: TSplitter [3]
    Left = 345
    Top = 85
    Width = 2
    Height = 480
    HelpContext = 1349004
    ExplicitLeft = 189
    ExplicitTop = 1
    ExplicitHeight = 254
  end
  object pnllist: TDNMPanel [5]
    Left = 347
    Top = 85
    Width = 649
    Height = 480
    HelpContext = 1349010
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object pnlTop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 996
    Height = 85
    HelpContext = 1349011
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      996
      85)
    object pnlHeader: TPanel
      Left = 120
      Top = 6
      Width = 737
      Height = 49
      HelpContext = 1349012
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
        Width = 735
        Height = 47
        HelpContext = 1349013
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
          Width = 735
          Height = 47
          HelpContext = 1349014
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -1
          ExplicitWidth = 783
          ExplicitHeight = 50
        end
      end
    end
    object chkHideDetails: TCheckBox
      Left = 880
      Top = 62
      Width = 108
      Height = 17
      HelpContext = 1349015
      Anchors = [akTop, akRight]
      Caption = 'Hide Details (F5)'
      TabOrder = 1
      OnClick = chkHideDetailsClick
    end
  end
  object pnlSelection: TDNMPanel [7]
    Left = 0
    Top = 85
    Width = 345
    Height = 480
    HelpContext = 1349005
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lblselection: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 12
      Width = 337
      Height = 24
      HelpContext = 1349006
      Margins.Top = 11
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Select '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 68
    end
    object pnlButtons: TDNMPanel
      AlignWithMargins = True
      Left = 4
      Top = 105
      Width = 337
      Height = 108
      HelpContext = 1349007
      Margins.Top = 11
      Margins.Bottom = 11
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object DNMPanel2: TDNMPanel
      AlignWithMargins = True
      Left = 4
      Top = 39
      Width = 337
      Height = 44
      HelpContext = 1349008
      Margins.Bottom = 11
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        337
        44)
      object cboLookup: TwwDBLookupCombo
        Left = 6
        Top = 10
        Width = 324
        Height = 23
        HelpContext = 1349009
        Anchors = [akLeft, akTop, akRight, akBottom]
        DropDownAlignment = taLeftJustify
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
    end
  end
  object c: TActionList
    Left = 200
    Top = 40
    object actSave: TDNMAction
      Caption = 'CHOOSE'
      HelpContext = 1349016
      ImageIndex = 765
      OnExecute = actSaveExecute
      buttoncolor = clWhite
    end
    object actclose: TDNMAction
      Caption = 'CANCEL'
      HelpContext = 1349017
      ImageIndex = 766
      OnExecute = actcloseExecute
      buttoncolor = clWhite
    end
  end
end
