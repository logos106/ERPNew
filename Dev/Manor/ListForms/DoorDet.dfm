inherited DoorDetGUI: TDoorDetGUI
  Left = 1420
  Top = 217
  HelpContext = 101000
  Caption = 'Door Detail List'
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 101001
  end
  inherited FooterPanel: TPanel
    HelpContext = 101002
    inherited Label3: TLabel
      HelpContext = 101003
    end
    inherited lblTotal: TLabel
      HelpContext = 101004
    end
    inherited lblNote: TLabel
      HelpContext = 101005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 101006
    end
    inherited lblTime: TLabel
      HelpContext = 101007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 101008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 101009
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 101010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 101011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 101012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 101013
      inherited LblChooseTemplate: TLabel
        HelpContext = 101014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 101015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 101016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 101017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 101018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 101019
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
    HelpContext = 101020
    inherited lblFrom: TLabel
      HelpContext = 101021
    end
    inherited lblTo: TLabel
      HelpContext = 101022
    end
    inherited pnlHeader: TPanel
      HelpContext = 101023
      inherited TitleShader: TShader
        HelpContext = 101024
        inherited TitleLabel: TLabel
          HelpContext = 101025
          Caption = 'Door Detail List'
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 101026
      inherited grpFilters: TRadioGroup
        HelpContext = 101027
      end
      inherited pnlButtons: TPanel
        HelpContext = 101028
        inherited lblcustomReport: TLabel
          HelpContext = 101029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 101030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 101031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 101032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 101033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 101034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 101035
      inherited Label1: TLabel
        HelpContext = 101036
      end
      inherited Label2: TLabel
        HelpContext = 101037
      end
      inherited cboFilter: TComboBox
        HelpContext = 101038
      end
      inherited edtSearch: TEdit
        HelpContext = 101039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 101040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 101041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 101042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 101043
    inherited grdMain: TwwDBGrid
      HelpContext = 101044
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'22'#9'GlobalRef'#9'F'
        'DoorType'#9'20'#9'DoorType'
        'ShortType'#9'10'#9'Short Type'#9'F'
        'Finish'#9'20'#9'Finish'
        'FrameType'#9'20'#9'Frame Type'#9'F'
        'InternalExternal'#9'10'#9'Internal/~External'#9'F'
        'Description'#9'20'#9'Description'
        'AddGoCost'#9'10'#9'Add Go Cost'#9'F'
        'BcsCostM'#9'10'#9'Bcs Cost M'#9'F'
        'BcsCostRb'#9'10'#9'Bcs Cost Rb'#9'F'
        'BcsCostSt'#9'10'#9'Bcs Cost St'#9'F'
        'BcsCostSy'#9'10'#9'Bcs Cost Sy'#9'F'
        'LabCost'#9'10'#9'Lab Cost'#9'F'
        'LamLabCost'#9'10'#9'Lam Lab Cost'#9'F'
        'ComputerCode'#9'20'#9'Computer Code'#9'F'
        'LippingStile'#9'10'#9'Lipping Stile'#9'F'
        'MaxHeight'#9'10'#9'Max'#9'F'#9'Height'
        'MinHeight'#9'10'#9'Min'#9'F'#9'Height'
        'MaxWidth'#9'10'#9'Max'#9'F'#9'Width'
        'MinWidth'#9'10'#9'Min'#9'F'#9'Width'
        'Thickness'#9'10'#9'Thickness'
        'MonoLux'#9'10'#9'MonoLux'
        'NoComp'#9'10'#9'NoComp'
        'PlyDepth'#9'10'#9'PlyDepth'
        'Rebated'#9'10'#9'Rebated'
        'ReportNotes'#9'10'#9'ReportNotes'
        'Standard'#9'10'#9'Standard'
        'Sundries'#9'10'#9'Sundries'
        'System90'#9'10'#9'System90'
        'TwinFastScrews'#9'10'#9'TwinFastScrews'
        'Active'#9'10'#9'Active'#9'F')
      TitleLines = 2
      UseTFields = False
    end
  end
  inherited qryMain: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select * from vwdoordetailList')
    object qryMainGlobalRef: TStringField
      Tag = 4
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'vwdoordetailList.GlobalRef'
      Size = 255
    end
    object qryMainAddGoCost: TStringField
      Tag = 4
      DisplayLabel = 'Add Go Cost'
      DisplayWidth = 10
      FieldName = 'AddGoCost'
      Origin = 'vwdoordetailList.AddGoCost'
      Size = 255
    end
    object qryMainBcsCostM: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'BcsCostM'
      Origin = 'vwdoordetailList.BcsCostM'
      Size = 255
    end
    object qryMainBcsCostRb: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'BcsCostRb'
      Origin = 'vwdoordetailList.BcsCostRb'
      Size = 255
    end
    object qryMainBcsCostSt: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'BcsCostSt'
      Origin = 'vwdoordetailList.BcsCostSt'
      Size = 255
    end
    object qryMainBcsCostSy: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'BcsCostSy'
      Origin = 'vwdoordetailList.BcsCostSy'
      Size = 255
    end
    object qryMainComputerCode: TStringField
      Tag = 4
      DisplayLabel = 'Computer Code'
      DisplayWidth = 20
      FieldName = 'ComputerCode'
      Origin = 'vwdoordetailList.ComputerCode'
      Size = 255
    end
    object qryMainDescription: TStringField
      Tag = 4
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'vwdoordetailList.Description'
      Size = 255
    end
    object qryMainDoorType: TStringField
      Tag = 4
      DisplayWidth = 20
      FieldName = 'DoorType'
      Origin = 'vwdoordetailList.DoorType'
      Size = 255
    end
    object qryMainFinish: TStringField
      Tag = 4
      DisplayWidth = 20
      FieldName = 'Finish'
      Origin = 'vwdoordetailList.Finish'
      Size = 255
    end
    object qryMainFrameType: TStringField
      Tag = 4
      DisplayWidth = 20
      FieldName = 'FrameType'
      Origin = 'vwdoordetailList.FrameType'
      Size = 255
    end
    object qryMainInternalExternal: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'InternalExternal'
      Origin = 'vwdoordetailList.InternalExternal'
      Size = 255
    end
    object qryMainLabCost: TStringField
      Tag = 4
      DisplayLabel = 'Lab Cost'
      DisplayWidth = 10
      FieldName = 'LabCost'
      Origin = 'vwdoordetailList.LabCost'
      Size = 255
    end
    object qryMainLamLabCost: TStringField
      Tag = 4
      DisplayLabel = 'Lam Lab Cost'
      DisplayWidth = 10
      FieldName = 'LamLabCost'
      Origin = 'vwdoordetailList.LamLabCost'
      Size = 255
    end
    object qryMainLippingStile: TStringField
      Tag = 4
      DisplayLabel = 'Lipping Stile'
      DisplayWidth = 10
      FieldName = 'LippingStile'
      Origin = 'vwdoordetailList.LippingStile'
      Size = 255
    end
    object qryMainMaxHeight: TStringField
      Tag = 4
      DisplayLabel = 'Maximum'
      DisplayWidth = 10
      FieldName = 'MaxHeight'
      Origin = 'vwdoordetailList.MaxHeight'
      Size = 255
    end
    object qryMainMaxWidth: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'MaxWidth'
      Origin = 'vwdoordetailList.MaxWidth'
      Size = 255
    end
    object qryMainMinHeight: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'MinHeight'
      Origin = 'vwdoordetailList.MinHeight'
      Size = 255
    end
    object qryMainMinWidth: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'MinWidth'
      Origin = 'vwdoordetailList.MinWidth'
      Size = 255
    end
    object qryMainMonoLux: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'MonoLux'
      Origin = 'vwdoordetailList.MonoLux'
      Size = 255
    end
    object qryMainNoComp: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'NoComp'
      Origin = 'vwdoordetailList.NoComp'
      Size = 255
    end
    object qryMainPlyDepth: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'PlyDepth'
      Origin = 'vwdoordetailList.PlyDepth'
      Size = 255
    end
    object qryMainRebated: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'Rebated'
      Origin = 'vwdoordetailList.Rebated'
      Size = 255
    end
    object qryMainReportNotes: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'ReportNotes'
      Origin = 'vwdoordetailList.ReportNotes'
      Size = 255
    end
    object qryMainShortType: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'ShortType'
      Origin = 'vwdoordetailList.ShortType'
      Size = 255
    end
    object qryMainStandard: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'Standard'
      Origin = 'vwdoordetailList.Standard'
      Size = 255
    end
    object qryMainSundries: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'Sundries'
      Origin = 'vwdoordetailList.Sundries'
      Size = 255
    end
    object qryMainSystem90: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'System90'
      Origin = 'vwdoordetailList.System90'
      Size = 255
    end
    object qryMainThickness: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'Thickness'
      Origin = 'vwdoordetailList.Thickness'
      Size = 255
    end
    object qryMainTwinFastScrews: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'TwinFastScrews'
      Origin = 'vwdoordetailList.TwinFastScrews'
      Size = 255
    end
    object qryMainActive: TStringField
      Tag = 4
      DisplayWidth = 10
      FieldName = 'Active'
      Origin = 'vwdoordetailList.Active'
      Size = 255
    end
  end
end
