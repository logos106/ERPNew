inherited BaseListingDoorLookupGUI: TBaseListingDoorLookupGUI
  Caption = 'BaseListingDoorLookupGUI'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited HeaderPanel: TPanel
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 2
        Items.Strings = (
          'Active'
          'Inactive'
          'All')
      end
    end
  end
end
