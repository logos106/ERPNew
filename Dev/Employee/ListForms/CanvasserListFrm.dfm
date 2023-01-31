inherited CanvasserListGUI: TCanvasserListGUI
  Left = 144
  Top = 149
  HelpContext = 55000
  Caption = 'Canvasser List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 55001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 55002
    Color = 14155775
    inherited Label3: TLabel
      HelpContext = 55003
    end
    inherited lblTotal: TLabel
      HelpContext = 55004
    end
    inherited lblNote: TLabel
      HelpContext = 55005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 55006
    end
    inherited lblTime: TLabel
      HelpContext = 55007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 55008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 55009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 55010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 55011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 55012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 55013
      inherited LblChooseTemplate: TLabel
        HelpContext = 55014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 55015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 55016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 55017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 55018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 55019
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
    HelpContext = 55020
    Color = 14155775
    inherited lblFrom: TLabel
      HelpContext = 55021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 55022
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 55023
      Caption = 'Canvasser List'
      inherited TitleShader: TShader
        HelpContext = 55024
        inherited TitleLabel: TLabel
          HelpContext = 55025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 55026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 55027
        TabOrder = 1
      end
      inherited pnlButtons: TPanel
        HelpContext = 55028
        TabOrder = 0
        inherited lblcustomReport: TLabel
          HelpContext = 55029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 55030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 55031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 55032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 55033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 55034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 55035
      inherited lblFilter: TLabel
        HelpContext = 55036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 55037
      end
      inherited cboFilter: TComboBox
        HelpContext = 55038
      end
      inherited edtSearch: TEdit
        HelpContext = 55039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 55040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 55041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 55042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 55043
    inherited grdMain: TwwDBGrid
      HelpContext = 55044
      Selected.Strings = (
        'GlobalRef'#9'10'#9'GlobalRef'#9'F'
        'Employee Name'#9'25'#9'Employee Name'#9'F'
        'Address'#9'30'#9'Address'#9#9
        'Suburb'#9'25'#9'Suburb'#9'F'
        'State'#9'8'#9'State'#9'F'
        'Postcode'#9'6'#9'Postcode'#9'F'
        'Country'#9'15'#9'Country'#9'F'
        'Phone'#9'12'#9'Phone'#9'F'
        'Mobile'#9'12'#9'Mobile'#9'F'
        'Fax Number'#9'12'#9'Fax Number'#9'F')
      TitleColor = 14155775
      FooterColor = 14155775
      FooterCellColor = 14155775
    end
  end
  inherited dlgPrint: TPdtPrintDAT
    Left = 15
    Top = 2
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'Select tblEmployees.GlobalRef, EmployeeID, if(MiddleName<>'#39#39',Con' +
        'cat(FirstName,'#39' '#39',MiddleName,'#39' '#39',LastName),Concat(FirstName,'#39' '#39',' +
        'LastName)) AS '#39'Employee Name'#39','
      
        'if(Street2<>'#39#39',Concat(Street,'#39' '#39',if(Street3<>'#39#39',Concat(Street2,'#39 +
        ' '#39',Street3),Street2)),Street) AS Address,'
      'Suburb, State, Postcode, Country,'
      'Phone AS Phone, Active,  Mobile, FaxNumber AS '#39'Fax Number'#39
      'FROM tblEmployees WHERE tblEmployees.Canvasser = '#39'T'#39
      'ORDER By FirstName')
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 10
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainEmployeeName: TWideStringField
      DisplayWidth = 25
      FieldName = 'Employee Name'
      Size = 122
    end
    object qryMainAddress: TWideStringField
      DisplayWidth = 30
      FieldName = 'Address'
      Size = 767
    end
    object qryMainSuburb: TWideStringField
      DisplayWidth = 25
      FieldName = 'Suburb'
      Size = 255
    end
    object qryMainState: TWideStringField
      DisplayWidth = 8
      FieldName = 'State'
      Size = 255
    end
    object qryMainPostcode: TWideStringField
      DisplayWidth = 6
      FieldName = 'Postcode'
      Size = 255
    end
    object qryMainCountry: TWideStringField
      DisplayWidth = 15
      FieldName = 'Country'
      Size = 255
    end
    object qryMainPhone: TWideStringField
      DisplayWidth = 12
      FieldName = 'Phone'
      Size = 255
    end
    object qryMainMobile: TWideStringField
      DisplayWidth = 12
      FieldName = 'Mobile'
      Size = 255
    end
    object qryMainFaxNumber: TWideStringField
      DisplayWidth = 12
      FieldName = 'Fax Number'
      Size = 255
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
  end
end
