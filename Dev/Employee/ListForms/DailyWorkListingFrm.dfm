inherited DailyWorkListingGUI: TDailyWorkListingGUI
  Left = 113
  Top = 231
  Caption = 'Daily Work Summary'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 92000
  inherited FooterPanel: TPanel
    Color = 14155775
    HelpContext = 92002
    inherited barStatus: TAdvOfficeStatusBar
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
      HelpContext = 92019
    end
    inherited Label3: TLabel
      HelpContext = 92003
    end
    inherited lblTotal: TLabel
      HelpContext = 92004
    end
    inherited Label121: TLabel
      HelpContext = 92005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 92006
    end
    inherited lblTime: TLabel
      HelpContext = 92007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 92008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 92009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 92010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 92011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 92012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 92013
      inherited LblChooseTemplate: TLabel
        HelpContext = 92014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 92015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 92016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 92017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 92018
    end
  end
  inherited HeaderPanel: TPanel
    Color = 14155775
    HelpContext = 92020
    inherited pnlHeader: TPanel
      Caption = 'Daily Work Summary'
      HelpContext = 92023
      inherited TitleShader: TShader
        HelpContext = 92024
        inherited TitleLabel: TLabel
          HelpContext = 92025
        end
      end
    end
    inherited lblFrom: TLabel
      HelpContext = 92021
    end
    inherited lblTo: TLabel
      HelpContext = 92022
    end
    inherited Panel2: TPanel
      HelpContext = 92026
      inherited grpFilters: TRadioGroup
        HelpContext = 92027
      end
      inherited pnlButtons: TPanel
        HelpContext = 92028
        inherited lblcustomReport: TLabel
          HelpContext = 92029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 92030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 92031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 92032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 92033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 92034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 92035
      inherited Label1: TLabel
        HelpContext = 92036
      end
      inherited Label2: TLabel
        HelpContext = 92037
      end
      inherited cboFilter: TComboBox
        HelpContext = 92038
      end
      inherited edtSearch: TEdit
        HelpContext = 92039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 92040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 92041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 92042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 92043
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'EmployeeID;CustomEdit;wwDBEmployeeLookup;F'
        'IssuedTo;CustomEdit;wwDBIssueToLookup;F')
      Selected.Strings = (
        'Name'#9'45'#9'Name'#9'F'
        'Issued To'#9'40'#9'Issued To'
        'Zone'#9'40'#9'Zone'
        'Week Ending'#9'10'#9'Week Ending')
      TitleColor = 14155775
      HelpContext = 92044
    end
  end
  inherited dsMain: TDataSource
    Left = 36
    Top = 1
  end
  inherited dlgSave: TSaveDialog
    Left = 94
    Top = 1
  end
  inherited imgPopup: TImageList
    Left = 280
    Top = 216
  end
  inherited dlgPrint: TPdtPrintDAT
    Left = 6
    Top = 1
  end
  inherited actlstFilters: TActionList
    Left = 122
    Top = 1
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 6
  end
  inherited wwLocateDialog1: TwwLocateDialog
    Left = 149
    Top = 1
  end
  inherited CloseModalTimer: TTimer
    Left = 95
    Top = 31
  end
  inherited qryMain: TMyQuery
    SQLDelete.Strings = (
      'DELETE FROM tbldailyworkrecord'
      'WHERE'
      '  DailyWorkRecordID = :Old_DailyWorkRecordID')
    SQLUpdate.Strings = (
      'UPDATE tbldailyworkrecord'
      'SET'
      
        '  GlobalRef = :GlobalRef, DailyWorkRecordID = :DailyWorkRecordID' +
        ', IssuedTo = :IssuedTo, EmployeeID = :EmployeeID, Zone = :Zone, ' +
        'WeekEnding = :WeekEnding'
      'WHERE'
      '  DailyWorkRecordID = :Old_DailyWorkRecordID')
    SQLRefresh.Strings = (
      
        'SELECT tbldailyworkrecord.GlobalRef, tbldailyworkrecord.DailyWor' +
        'kRecordID, tbldailyworkrecord.IssuedTo, tbldailyworkrecord.Emplo' +
        'yeeID, tbldailyworkrecord.Zone, tbldailyworkrecord.WeekEnding FR' +
        'OM tbldailyworkrecord'
      'WHERE'
      '  tbldailyworkrecord.DailyWorkRecordID = :Old_DailyWorkRecordID')
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT'
      'tbldailyworkrecord.DailyWorkRecordID, '
      'E.EmployeeName AS "Name",'
      'IE.EmployeeName AS "Issued To",'
      'tbldailyworkrecord.Zone AS "Zone",'
      'tbldailyworkrecord.Weekending AS "Week Ending"'
      'FROM tbldailyworkrecord'
      'INNER JOIN tblemployees E USING(EmployeeID)'
      
        'LEFT JOIN tblemployees IE ON IE.EmployeeID=tbldailyworkrecord.Is' +
        'suedTo;')
    FetchRows = 1
    Filtered = True
    Left = 65
  end
  inherited qryPersonalPrefs: TMyQuery
    Left = 66
    Top = 31
  end
  inherited MyConnection1: TMyConnection
    Left = 36
    Top = 31
  end
  inherited ExportDialog: TProgressDialog
    Left = 177
    Top = 1
  end
  inherited mnuFilter: TAdvPopupMenu
    Left = 312
  end
  inherited FilterLabel: TLabel
    HelpContext = 92001
  end
end
