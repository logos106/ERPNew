inherited fmMessageWithGrid: TfmMessageWithGrid
  Left = 264
  Top = 210
  HelpContext = 1456002
  Caption = ''
  ClientHeight = 372
  ClientWidth = 655
  ExplicitLeft = 264
  ExplicitTop = 210
  ExplicitWidth = 671
  ExplicitHeight = 411
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 372
    Width = 655
    HelpContext = 1456003
    ExplicitTop = 372
    ExplicitWidth = 655
  end
  inherited DnMPanel1: TDNMPanel
    Width = 655
    Height = 372
    HelpContext = 1456004
    ExplicitWidth = 655
    ExplicitHeight = 372
    inherited lbltop: TLabel
      Width = 639
      HelpContext = 1456005
    end
    inherited lblBottom: TLabel
      Top = 273
      Width = 639
      HelpContext = 1456006
      ExplicitTop = 273
    end
    inherited pnlFooter: TDNMPanel
      Top = 298
      Width = 645
      HelpContext = 1456007
      ExplicitTop = 301
      ExplicitWidth = 645
    end
    inherited pnlDetails: TDNMPanel
      Width = 645
      Height = 239
      HelpContext = 1456008
      ExplicitWidth = 645
      ExplicitHeight = 239
      inherited Bevel1: TBevel
        Width = 643
        HelpContext = 1456009
        ExplicitWidth = 643
      end
      object grdmain: TwwDBGrid
        AlignWithMargins = True
        Left = 4
        Top = 5
        Width = 637
        Height = 230
        HelpContext = 1456010
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = dsMain
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        FooterColor = clWhite
        FooterCellColor = clWhite
      end
    end
    inherited chk: TCheckBox
      Top = 348
      Width = 645
      HelpContext = 1456011
      ExplicitLeft = 2
      ExplicitTop = 347
      ExplicitWidth = 645
    end
  end
  object dsMain: TDataSource
    Left = 195
    Top = 111
  end
end
