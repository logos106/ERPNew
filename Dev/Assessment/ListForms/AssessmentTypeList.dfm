inherited AssessmentTypeListGUI: TAssessmentTypeListGUI
  Left = 97
  Top = 151
  Caption = 'Assessment Type List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 23000
  inherited FooterPanel: TPanel
    Color = 15527129
    HelpContext = 23002
    inherited Label3: TLabel
      HelpContext = 23003
    end
    inherited lblTotal: TLabel
      HelpContext = 23004
    end
    inherited lblNote: TLabel
      HelpContext = 23005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 23006
    end
    inherited lblTime: TLabel
      HelpContext = 23007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 23008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 23009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 23010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 23011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 23012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 23013
      inherited LblChooseTemplate: TLabel
        HelpContext = 23014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 23015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 23016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 23017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 23018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 23019
    end
  end
  inherited HeaderPanel: TPanel
    Color = 15527129
    HelpContext = 23020
    inherited lblFrom: TLabel
      Visible = False
      HelpContext = 23021
    end
    inherited lblTo: TLabel
      Visible = False
      HelpContext = 23022
    end
    inherited pnlHeader: TPanel
      Caption = 'Assessment Type List'
      HelpContext = 23023
      inherited TitleShader: TShader
        HelpContext = 23024
        inherited TitleLabel: TLabel
          HelpContext = 23025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 23026
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'All')
        HelpContext = 23027
      end
      inherited pnlButtons: TPanel
        HelpContext = 23028
        inherited lblcustomReport: TLabel
          HelpContext = 23029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 23030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 23031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 23032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 23033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 23034
        end
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
      HelpContext = 23040
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
      HelpContext = 23041
    end
    inherited Panel3: TPanel
      HelpContext = 23035
      inherited Label1: TLabel
        HelpContext = 23036
      end
      inherited Label2: TLabel
        HelpContext = 23037
      end
      inherited cboFilter: TComboBox
        HelpContext = 23038
      end
      inherited edtSearch: TEdit
        HelpContext = 23039
      end
    end
    inherited cboDateRange: TComboBox
      HelpContext = 23042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 23043
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'TypeName'#9'50'#9'Type Name'#9'F'
        'Product'#9'60'#9'Product'
        'Active'#9'1'#9'Active')
      TitleColor = 15527129
      FooterColor = 15527129
      HelpContext = 23044
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT tblassessmenttypes.*,tblparts.Partname as Product '
      'FROM tblassessmenttypes'
      'LEFT JOIN tblparts ON ProductID=PartsID')
    object qryMainTypeName: TWideStringField
      DisplayLabel = 'Type Name'
      DisplayWidth = 50
      FieldName = 'TypeName'
      Origin = 'tblassessmenttypes.TypeName'
      Size = 50
    end
    object qryMainProduct: TWideStringField
      DisplayWidth = 60
      FieldName = 'Product'
      Origin = 'tblparts.Product'
      Size = 60
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblassessmenttypes.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainTypeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TypeID'
      Origin = 'tblassessmenttypes.TypeID'
      Visible = False
    end
  end
  inherited FilterLabel: TLabel
    HelpContext = 23001
  end
end
