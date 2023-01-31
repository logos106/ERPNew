inherited fmListnLookup: TfmListnLookup
  Caption = 'fmListnLookup'
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1351002
  inherited report1n2: TSplitter
    OnMoved = nil
  end
  inherited pnlSelection: TDNMPanel
    ExplicitLeft = 0
    ExplicitTop = 85
    HelpContext = 1351004
    inherited lblselection: TLabel
      Height = 15
      Font.Height = -12
      ExplicitLeft = 4
      ExplicitWidth = 39
      ExplicitHeight = 15
      HelpContext = 1351003
    end
    inherited pnlButtons: TDNMPanel
      Top = 96
      ExplicitLeft = 4
      ExplicitTop = 105
      HelpContext = 1351005
    end
    inherited DNMPanel2: TDNMPanel
      Top = 30
      ExplicitTop = 39
      HelpContext = 1351006
      inherited cboLookup: TwwDBLookupCombo
        Top = 11
        Font.Style = []
        ParentFont = False
        ExplicitTop = 11
      end
    end
  end
  inherited pnllist: TDNMPanel
    ExplicitLeft = 345
    ExplicitWidth = 649
    HelpContext = 1351007
  end
  inherited pnlTop: TDNMPanel
    HelpContext = 1351008
    inherited pnlHeader: TPanel
      OnDblClick = nil
      HelpContext = 1351009
      inherited TitleShader: TShader
        ExplicitWidth = 783
        ExplicitHeight = 50
      end
    end
    inherited chkHideDetails: TCheckBox
      OnClick = nil
    end
  end
  inherited c: TActionList
    inherited actSave: TDNMAction
      OnUpdate = nil
    end
  end
end
