inherited BarcodePickingListGUI: TBarcodePickingListGUI
  Left = 113
  Top = 130
  HelpContext = 36000
  Caption = 'Barcode Picking List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 36001
  end
  inherited FooterPanel: TPanel
    HelpContext = 36002
    Color = 15588572
    inherited Label3: TLabel
      HelpContext = 36003
    end
    inherited lblTotal: TLabel
      HelpContext = 36004
    end
    inherited Label121: TLabel
      HelpContext = 36005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 36006
    end
    inherited lblTime: TLabel
      HelpContext = 36007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 36008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 36009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 36010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 36011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 36012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 36013
      inherited LblChooseTemplate: TLabel
        HelpContext = 36014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 36015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 36016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 36017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 36018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 36019
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
    end
  end
  inherited HeaderPanel: TPanel
    HelpContext = 36020
    Color = 15588572
    inherited lblFrom: TLabel
      HelpContext = 36021
    end
    inherited lblTo: TLabel
      HelpContext = 36022
    end
    inherited pnlHeader: TPanel
      HelpContext = 36023
      Caption = 'Barcode Picking List'
      inherited TitleShader: TShader
        HelpContext = 36024
        inherited TitleLabel: TLabel
          HelpContext = 36025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 36026
      inherited grpFilters: TRadioGroup
        HelpContext = 36027
        Columns = 5
        ItemIndex = 0
        Items.Strings = (
          'Printed'
          'Picking'
          'Packing'
          'Finished'
          'Not Printed')
      end
      inherited pnlButtons: TPanel
        HelpContext = 36028
        inherited lblcustomReport: TLabel
          HelpContext = 36029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 36030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 36031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 36032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 36033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 36034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 36035
      inherited Label1: TLabel
        HelpContext = 36036
      end
      inherited Label2: TLabel
        HelpContext = 36037
      end
      inherited cboFilter: TComboBox
        HelpContext = 36038
      end
      inherited edtSearch: TEdit
        HelpContext = 36039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 36040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 36041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 36042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 36043
    inherited grdMain: TwwDBGrid
      HelpContext = 36044
      TitleColor = 15588572
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      '#####################'
      '### Dummy ############'
      '#####################'
      'SELECT PickingAssemblyID,SaleID as InvoiceNo, '
      
        'E.EmployeeName as PickingEmployee, StartPickingTime,FinishedPick' +
        'ingTime,'
      
        'TIME_FORMAT(SEC_TO_TIME(FinishedPickingTime-StartPickingTime),'#39'%' +
        'T'#39')  as PickingDuration,'
      
        'TIME_FORMAT((Extract(DAY_MINUTE From StartPackingTime)-Extract(D' +
        'AY_MINUTE From FinishedPickingTime)),'#39'%T'#39') as PickingToPackingDu' +
        'ration,'
      
        'E2.EmployeeName as PackingEmployee, StartPackingTime,FinishedPac' +
        'kingTime,'
      
        'TIME_FORMAT(SEC_TO_TIME(FinishedPackingTime-StartPackingTime),'#39'%' +
        'T'#39')  as PackingDuration'
      'S.ConNote, S.Shipping as Via, S.ShippingCost as ShipCost'
      'FROM tblpickingassembly PA'
      'INNER JOIN tblSales S ON S.SaleId = PA.SaleID'
      'LEFT JOIN tblemployees E ON E.EmployeeID = PA.PickingEmployeeID'
      
        'LEFT JOIN tblemployees E2 ON E2.EmployeeID = PA.PackingEmployeeI' +
        'D'
      'Order By PickingAssemblyID DESC;')
    Top = 65535
  end
end
