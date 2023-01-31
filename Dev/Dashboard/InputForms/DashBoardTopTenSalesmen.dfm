inherited DashBoardTopTenSalesmenGUI: TDashBoardTopTenSalesmenGUI
  Left = 638
  Top = 162
  HelpContext = 677000
  Caption = 'SALES MAN'
  ExplicitLeft = 638
  ExplicitTop = 162
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlmain: TDNMPanel
    HelpContext = 677001
    inherited pnlHeader: TDNMPanel
      HelpContext = 677002
      Caption = 'Top Ten Salesman'
    end
    inherited pnlDetails: TDNMPanel
      HelpContext = 677003
      inherited pnldata: TDNMPanel
        HelpContext = 677004
        inherited lblProductname: TLabel
          Width = 95
          HelpContext = 677005
          Caption = 'Sales man name'
          ExplicitWidth = 95
        end
        inherited Label3: TLabel
          HelpContext = 677006
          Visible = False
        end
        inherited Bevel2: TBevel
          HelpContext = 677007
          Visible = False
        end
      end
    end
    inherited pnltop: TDNMPanel
      HelpContext = 677008
      inherited grpFilters: TwwRadioGroup
        HelpContext = 677009
        Columns = 2
        Items.Strings = (
          'Price'
          'Margin')
      end
    end
  end
end
