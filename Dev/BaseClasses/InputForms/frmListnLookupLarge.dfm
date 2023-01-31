inherited fmListnLookupLarge: TfmListnLookupLarge
  Caption = 'fmListnLookupLarge'
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1350002
  inherited report1n2: TSplitter
    OnMoved = nil
  end
  inherited pnlSelection: TDNMPanel
    ExplicitLeft = 0
    ExplicitTop = 85
    HelpContext = 1350006
    inherited lblselection: TLabel
      Height = 29
      Font.Height = -24
      ExplicitLeft = 4
      ExplicitWidth = 77
      ExplicitHeight = 29
      HelpContext = 1350003
    end
    inherited pnlButtons: TDNMPanel
      Top = 131
      ExplicitLeft = 4
      ExplicitTop = 131
      HelpContext = 1350007
    end
    inherited DNMPanel2: TDNMPanel
      Top = 44
      Height = 65
      ExplicitTop = 44
      ExplicitHeight = 65
      DesignSize = (
        337
        65)
      HelpContext = 1350004
      inherited cboLookup: TwwDBLookupCombo
        Left = 10
        Top = 15
        Height = 40
        Font.Height = -27
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 10
        ExplicitTop = 15
        ExplicitHeight = 40
        HelpContext = 1350005
      end
    end
  end
  inherited pnllist: TDNMPanel
    ExplicitLeft = 345
    ExplicitWidth = 649
    HelpContext = 1350008
  end
  inherited pnlTop: TDNMPanel
    HelpContext = 1350009
    inherited pnlHeader: TPanel
      OnDblClick = nil
      HelpContext = 1350010
      inherited TitleShader: TShader
        ExplicitWidth = 783
        ExplicitHeight = 50
      end
    end
  end
  inherited c: TActionList
    inherited actSave: TDNMAction
      OnUpdate = nil
    end
  end
end
