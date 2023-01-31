inherited EmailedReportScheduleListGUI: TEmailedReportScheduleListGUI
  Left = 221
  Top = 180
  Caption = 'Emailed Report Schedule List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 15527129
  end
  inherited HeaderPanel: TPanel
    Color = 15527129
    inherited pnlHeader: TPanel
      Caption = 'Emailed Report Schedule List'
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Active Only'
          'Inactive Only'
          'All')
      end
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      TitleColor = 15527129
      FooterColor = 15527129
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * FROM '
      'tblemailedreportsschedule')
  end
end
