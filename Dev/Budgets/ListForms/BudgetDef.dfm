inherited BudgetDefGUI: TBudgetDefGUI
  Left = 146
  Top = 136
  HelpContext = 48000
  Caption = 'Budget Definition List'
  Color = 14153215
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 48001
  end
  inherited FooterPanel: TDnMPanel
    HelpContext = 48002
    Color = 14153215
    inherited Label3: TLabel
      HelpContext = 48003
    end
    inherited lblTotal: TLabel
      HelpContext = 48004
    end
    inherited lblNote: TLabel
      HelpContext = 48005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 48006
    end
    inherited lblTime: TLabel
      HelpContext = 48007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 48008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 48009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 48010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 48011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 48012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 48013
      inherited LblChooseTemplate: TLabel
        HelpContext = 48014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 48015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 48016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 48017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 48018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 48019
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
    HelpContext = 48020
    Color = 14153215
    inherited lblFrom: TLabel
      HelpContext = 48021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 48022
      Visible = False
    end
    inherited pnlHeader: TPanel
      Top = 3
      Height = 50
      HelpContext = 48023
      Caption = 'Budget Definition List'
      inherited TitleShader: TShader
        Height = 48
        HelpContext = 48024
        inherited TitleLabel: TLabel
          Height = 48
          HelpContext = 48025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 48026
      inherited grpFilters: TwwRadioGroup
        HelpContext = 48027
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'All')
      end
      inherited pnlButtons: TPanel
        HelpContext = 48028
        inherited lblcustomReport: TLabel
          HelpContext = 48029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 48030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 48031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 48032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 48033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 48034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 48035
      inherited lblFilter: TLabel
        HelpContext = 48036
      end
      inherited lblSearchoptions: TLabel
        HelpContext = 48037
      end
      inherited cboFilter: TComboBox
        HelpContext = 48038
      end
      inherited edtSearch: TEdit
        HelpContext = 48039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 48040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 48041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 48042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 48043
    inherited grdMain: TwwDBGrid
      HelpContext = 48044
      ControlType.Strings = (
        'ShowAmount1;CheckBox;T;F'
        'ShowAmount2;CheckBox;T;F'
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'15'#9'GlobalRef'#9#9
        'Name'#9'20'#9'Name'#9#9
        'Description'#9'20'#9'Description'#9#9
        'ShowAmount1'#9'1'#9'Show Amount1'#9#9
        'Amount1Label'#9'25'#9'Amount 1 Description'#9'F'#9
        'ShowAmount2'#9'1'#9'Show Amount2'#9#9
        'Amount2Label'#9'50'#9'Amount 2 Description'#9'F'#9
        'StartDate'#9'18'#9'Start Date'#9#9
        'EndDate'#9'18'#9'End Date'#9#9
        'IntervalDuration'#9'10'#9'Interval'#9#9
        'IntervalPeriod'#9'11'#9'IntervalPeriod'#9#9
        'Active'#9'1'#9'Active'#9#9)
      TitleColor = 14153215
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select '
      'GlobalRef as GlobalRef, '
      'BudgetID as BudgetID, '
      'name as name , '
      'Description as Description, '
      'if(Showamount1 = '#39'T'#39' , Amount1Label, '#39#39') as Amount1Label , '
      'if(Showamount2 = '#39'T'#39' , Amount2Label, '#39#39') as Amount2Label , '
      'Showamount1 as Showamount1, '
      'ShowAmount2  as ShowAmount2,'
      'StartDate as StartDate,  '
      'EndDate as EndDate ,  '
      'IntervalDuration as IntervalDuration , '
      'Active as Active ,  '
      
        'if(IntervalPeriod = 1 , '#39'Daily'#39' , if(IntervalPeriod = 2 , '#39'Weekl' +
        'y'#39' , if(IntervalPeriod = 3 , '#39'Fortnightly'#39' , if(IntervalPeriod =' +
        ' 4 , '#39'Monthly'#39' , if(IntervalPeriod = 5 , '#39'Quarterly'#39' , if(Interv' +
        'alPeriod = 6 , '#39'Half Yearly'#39' , if(IntervalPeriod = 7 , '#39'Yearly'#39' ' +
        ', '#39'Unknown'#39'))))))) as IntervalPeriod'
      'from tblBudgets')
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 15
      FieldName = 'GlobalRef'
      Origin = 'tblBudgets.GlobalRef'
      Size = 255
    end
    object qryMainName: TWideStringField
      DisplayWidth = 20
      FieldName = 'Name'
      Origin = 'tblBudgets.name'
      Size = 25
    end
    object qryMainDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tblBudgets.Description'
      Size = 50
    end
    object qryMainShowAmount1: TWideStringField
      DisplayLabel = 'Show Amount1'
      DisplayWidth = 1
      FieldName = 'ShowAmount1'
      Origin = 'tblBudgets.Showamount1'
      FixedChar = True
      Size = 1
    end
    object qryMainAmount1Label: TWideStringField
      DisplayLabel = 'Amount 1 Description'
      DisplayWidth = 25
      FieldName = 'Amount1Label'
      Origin = 'tblBudgets.Amount1Label'
      Size = 50
    end
    object qryMainShowAmount2: TWideStringField
      DisplayLabel = 'Show Amount2'
      DisplayWidth = 1
      FieldName = 'ShowAmount2'
      Origin = 'tblBudgets.ShowAmount2'
      FixedChar = True
      Size = 1
    end
    object qryMainAmount2Label: TWideStringField
      DisplayLabel = 'Amount 2 Description'
      DisplayWidth = 50
      FieldName = 'Amount2Label'
      Origin = 'tblBudgets.Amount2Label'
      Size = 50
    end
    object qryMainStartDate: TDateTimeField
      DisplayLabel = 'Start Date'
      DisplayWidth = 18
      FieldName = 'StartDate'
      Origin = 'tblBudgets.StartDate'
    end
    object qryMainEndDate: TDateTimeField
      DisplayLabel = 'End Date'
      DisplayWidth = 18
      FieldName = 'EndDate'
      Origin = 'tblBudgets.EndDate'
    end
    object qryMainIntervalDuration: TSmallintField
      DisplayLabel = 'Interval'
      DisplayWidth = 10
      FieldName = 'IntervalDuration'
      Origin = 'tblBudgets.IntervalDuration'
    end
    object qryMainIntervalPeriod: TWideStringField
      DisplayWidth = 11
      FieldName = 'IntervalPeriod'
      Origin = 'tblBudgets.IntervalPeriod'
      Size = 11
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblBudgets.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainBudgetID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'BudgetID'
      Origin = 'tblBudgets.BudgetID'
      Visible = False
    end
  end
end
