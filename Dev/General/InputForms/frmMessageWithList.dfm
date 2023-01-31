inherited fmMessageWithList: TfmMessageWithList
  Left = 572
  Top = 67
  HelpContext = 930001
  Caption = 'fmMessageWithList'
  ClientHeight = 373
  ClientWidth = 655
  OnCloseQuery = FormCloseQuery
  ExplicitLeft = 572
  ExplicitTop = 67
  ExplicitWidth = 671
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 373
    Width = 655
    ExplicitTop = 373
    ExplicitWidth = 655
    HelpContext = 930003
  end
  inherited DnMPanel1: TDNMPanel
    Width = 655
    Height = 373
    ExplicitWidth = 655
    ExplicitHeight = 373
    HelpContext = 930004
    inherited lbltop: TLabel
      Width = 639
      Caption = ''
      ExplicitWidth = 5
      HelpContext = 930005
    end
    inherited lblBottom: TLabel
      Top = 274
      Width = 639
      ExplicitTop = 274
      HelpContext = 930006
    end
    inherited pnlFooter: TDNMPanel
      Top = 316
      Width = 645
      ExplicitTop = 307
      ExplicitWidth = 644
      HelpContext = 930007
    end
    inherited pnlDetails: TDNMPanel
      Width = 645
      Height = 240
      ExplicitWidth = 644
      ExplicitHeight = 219
      HelpContext = 930008
      inherited Bevel1: TBevel
        Width = 643
        ExplicitWidth = 642
        HelpContext = 930009
      end
      object lblDetails: TLabel
        Left = 1
        Top = 224
        Width = 643
        Height = 15
        Align = alBottom
        Alignment = taCenter
        Caption = 'lblDetails'
        Visible = False
        WordWrap = True
        ExplicitWidth = 52
        HelpContext = 930010
      end
      object grd: TStringGrid
        Left = 1
        Top = 2
        Width = 643
        Height = 222
        HelpContext = 930002
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnDblClick = grdDblClick
      end
    end
    inherited chk: TCheckBox
      Top = 299
      Width = 645
      ExplicitTop = 287
      ExplicitWidth = 644
      HelpContext = 930011
    end
  end
end
