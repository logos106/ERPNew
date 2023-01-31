inherited CustomFiltersListGUI: TCustomFiltersListGUI
  Left = 54
  Top = 142
  HelpContext = 86000
  Caption = 'Custom Filter List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 86001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 86002
    inherited Label3: TLabel
      HelpContext = 86003
    end
    inherited lblTotal: TLabel
      HelpContext = 86004
    end
    inherited lblNote: TLabel
      HelpContext = 86005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 86006
    end
    inherited lblTime: TLabel
      HelpContext = 86007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 86008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 86009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 86010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 86011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 86012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 86013
      inherited LblChooseTemplate: TLabel
        HelpContext = 86014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 86015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 86016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 86017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 86018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 86019
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
    HelpContext = 86020
    inherited lblFrom: TLabel
      HelpContext = 86021
    end
    inherited lblTo: TLabel
      HelpContext = 86022
    end
    inherited pnlHeader: TPanel
      HelpContext = 86023
      inherited TitleShader: TShader
        HelpContext = 86024
        inherited TitleLabel: TLabel
          HelpContext = 86025
          Caption = 'Custom Filter List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 86026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 86027
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'All')
      end
      inherited pnlButtons: TPanel
        HelpContext = 86028
        inherited lblcustomReport: TLabel
          HelpContext = 86029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 86030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 86031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 86032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 86033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 86034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 86035
      inherited lblFilter: TLabel
        HelpContext = 86036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 86037
      end
      inherited cboFilter: TComboBox
        HelpContext = 86038
      end
      inherited edtSearch: TEdit
        HelpContext = 86039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 86040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 86041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 86042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 86043
    inherited grdMain: TwwDBGrid
      HelpContext = 86044
      Selected.Strings = (
        'ID'#9'10'#9'ID'
        'FilterName'#9'30'#9'FilterName'
        'ListName'#9'30'#9'ListName'#9'F'
        'FilterStatement'#9'30'#9'FilterStatement'
        'DefaultFilter'#9'1'#9'DefaultFilter'
        'AllUsers'#9'1'#9'AllUsers'
        'EmployeeName'#9'30'#9'EmployeeName'
        'Active'#9'1'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select CF.*,tblForms.Description as ListName,E.EmployeeName'
      'from tblCustomFilters CF'
      'INNER JOIN tblForms on  tblForms.FormName = CF.ReportName'
      'LEFT JOIN tblemployees E On UserID=EmployeeID'
      
        'WHERE ReportName = :xReportName AND (UserId = :xUSERID or AllUse' +
        'rs = "T")')
    Left = 86
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xReportName'
      end
      item
        DataType = ftUnknown
        Name = 'xUSERID'
      end>
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblCustomFilters.ID'
    end
    object qryMainFilterName: TWideStringField
      DisplayWidth = 30
      FieldName = 'FilterName'
      Origin = 'tblCustomFilters.FilterName'
      Size = 255
    end
    object qryMainListName: TWideStringField
      DisplayWidth = 30
      FieldName = 'ListName'
      Origin = 'tblForms.Description'
      Size = 50
    end
    object qryMainFilterStatement: TWideMemoField
      DisplayWidth = 30
      FieldName = 'FilterStatement'
      Origin = 'tblCustomFilters.FilterStatement'
      BlobType = ftWideMemo
    end
    object qryMainDefaultFilter: TWideStringField
      DisplayWidth = 1
      FieldName = 'DefaultFilter'
      Origin = 'tblCustomFilters.DefaultFilter'
      FixedChar = True
      Size = 1
    end
    object qryMainAllUsers: TWideStringField
      DisplayWidth = 1
      FieldName = 'AllUsers'
      Origin = 'tblCustomFilters.AllUsers'
      FixedChar = True
      Size = 1
    end
    object qryMainEmployeeName: TWideStringField
      DisplayWidth = 30
      FieldName = 'EmployeeName'
      Origin = 'E.EmployeeName'
      Size = 255
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblCustomFilters.Active'
      FixedChar = True
      Size = 1
    end
  end
end
