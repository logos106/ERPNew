inherited DashBoardTopTenCustomerGUI: TDashBoardTopTenCustomerGUI
  HelpContext = 674000
  Caption = 'CUSTOMERS'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlmain: TDNMPanel
    HelpContext = 674001
    inherited pnlHeader: TDNMPanel
      HelpContext = 674002
      Caption = 'Top Ten Customers'
    end
    inherited pnlDetails: TDNMPanel
      HelpContext = 674003
      inherited pnldata: TDNMPanel
        HelpContext = 674004
        inherited lblProductname: TLabel
          Width = 92
          HelpContext = 674005
          Caption = 'Customer Name'
          ExplicitWidth = 92
        end
        inherited Label3: TLabel
          HelpContext = 674006
          Visible = False
        end
        inherited Bevel2: TBevel
          HelpContext = 674007
          Visible = False
        end
      end
    end
    inherited pnltop: TDNMPanel
      HelpContext = 674008
      inherited grpFilters: TwwRadioGroup
        HelpContext = 674009
        Columns = 2
        Items.Strings = (
          'Price'
          'Margin')
      end
    end
  end
end
