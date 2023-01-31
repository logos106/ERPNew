inherited EmployeesFixedAssetsList: TEmployeesFixedAssetsList
  Left = 118
  Top = 172
  HelpContext = 125000
  Caption = 'Employee Fixed Assets'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 125001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 125002
    Color = 14155775
    inherited Label3: TLabel
      HelpContext = 125003
    end
    inherited lblTotal: TLabel
      HelpContext = 125004
    end
    inherited lblNote: TLabel
      HelpContext = 125005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 125006
    end
    inherited lblTime: TLabel
      HelpContext = 125007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 125008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 125009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 125010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 125011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 125012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 125013
      inherited LblChooseTemplate: TLabel
        HelpContext = 125014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 125015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 125016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 125017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 125018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 125019
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
    HelpContext = 125020
    Color = 14155775
    inherited lblFrom: TLabel
      HelpContext = 125021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 125022
      Visible = False
    end
    inherited pnlHeader: TPanel
      Left = 274
      Width = 452
      HelpContext = 125023
      Caption = 'Employee Fixed Assets'
      Color = 14155775
      ParentColor = False
      inherited TitleShader: TShader
        Width = 450
        HelpContext = 125024
        inherited TitleLabel: TLabel
          Width = 450
          HelpContext = 125025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 125026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 125027
      end
      inherited pnlButtons: TPanel
        HelpContext = 125028
        inherited lblcustomReport: TLabel
          HelpContext = 125029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 125030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 125031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 125032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 125033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 125034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 125035
      inherited lblFilter: TLabel
        HelpContext = 125036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 125037
      end
      inherited cboFilter: TComboBox
        HelpContext = 125038
      end
      inherited edtSearch: TEdit
        HelpContext = 125039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 125040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 125041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 125042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 125043
    inherited grdMain: TwwDBGrid
      HelpContext = 125044
      Selected.Strings = (
        'Title'#9'5'#9'Title'#9#9
        'EmployeeName'#9'25'#9'EmployeeName'#9'F'#9
        'Position'#9'25'#9'Position'#9'F'#9
        'AssetName'#9'25'#9'AssetName'#9'F'#9
        'AssetCode'#9'15'#9'AssetCode'#9'F'#9
        'AssetType'#9'15'#9'AssetType'#9'F'#9
        'PurchaseDate'#9'15'#9'PurchaseDate'#9'F'#9
        'PurchaseCost'#9'15'#9'PurchaseCost'#9'F'#9)
      TitleColor = 14155775
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT '
      'E.FirstName,E.LastName,E.EmployeeID,E.Position,E.Title, '
      'CONCAT_WS(E.FirstName, " ", E.LastName) As EmployeeName,'
      'EFA.*,'
      
        'FA.AssetCode,FA.AssetType,FA.PurchDate as PurchaseDate,FA.PurchC' +
        'ost as PurchaseCost'
      'FROM tblEmployees E'
      'LEFT JOIN tblEmployeeFA EFA ON E.EmployeeID = EFA.EmpID'
      'INNER JOIN tblFixedAssets FA ON EFA.AssetID = FA.AssetID'
      'WHERE E.Active ="T" AND EFA.Active = "T"'
      'GROUP BY E.EmployeeID, EFA.EmployeeFAID'
      'ORDER BY E.EmployeeID'
      ''
      ''
      '#SELECT '
      '#E.*, '
      '#CONCAT_WS(E.FirstName, " ", E.LastName) As EmployeeName,'
      '#EFA.*,'
      '#FA.*'
      '#FROM tblEmployees E'
      '#LEFT JOIN tblEmployeeFA EFA ON E.EmployeeID = EFA.EmpID'
      '#INNER JOIN tblFixedAssets FA ON EFA.AssetID = FA.AssetID'
      '#WHERE E.Active ="T" AND EFA.Active = "T"'
      '#GROUP BY E.EmployeeID, EFA.EmployeeFAID'
      '#ORDER BY E.EmployeeID')
    object qryMainTitle: TWideStringField
      DisplayWidth = 5
      FieldName = 'Title'
      Size = 5
    end
    object qryMainEmployeeName: TWideStringField
      DisplayWidth = 25
      FieldName = 'EmployeeName'
      Size = 81
    end
    object qryMainPosition: TWideStringField
      DisplayWidth = 25
      FieldName = 'Position'
      Size = 30
    end
    object qryMainAssetName: TWideStringField
      DisplayWidth = 25
      FieldName = 'AssetName'
      Size = 255
    end
    object qryMainAssetCode: TWideStringField
      DisplayWidth = 15
      FieldName = 'AssetCode'
      Size = 50
    end
    object qryMainAssetType: TWideStringField
      DisplayWidth = 15
      FieldName = 'AssetType'
      Size = 50
    end
    object qryMainPurchaseDate: TDateField
      DisplayWidth = 15
      FieldName = 'PurchaseDate'
    end
    object qryMainPurchaseCost: TFloatField
      DisplayWidth = 15
      FieldName = 'PurchaseCost'
    end
    object qryMainFirstName: TWideStringField
      DisplayWidth = 40
      FieldName = 'FirstName'
      Visible = False
      Size = 40
    end
    object qryMainLastName: TWideStringField
      DisplayWidth = 40
      FieldName = 'LastName'
      Visible = False
      Size = 40
    end
    object qryMainEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryMainEmployeeFAID: TIntegerField
      DisplayWidth = 15
      FieldName = 'EmployeeFAID'
      Visible = False
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainAssetID: TIntegerField
      DisplayWidth = 15
      FieldName = 'AssetID'
      Visible = False
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object qryMainEmpID: TIntegerField
      DisplayWidth = 15
      FieldName = 'EmpID'
      Visible = False
    end
  end
end
