inherited CustomerNotesReportGUI: TCustomerNotesReportGUI
  Left = 111
  Top = 162
  HelpContext = 80000
  Caption = 'Customer Notes Report'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 80001
  end
  inherited FooterPanel: TPanel
    HelpContext = 80002
    Color = 15527129
    inherited Label3: TLabel
      HelpContext = 80003
    end
    inherited lblTotal: TLabel
      HelpContext = 80004
    end
    inherited Label121: TLabel
      HelpContext = 80005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 80006
    end
    inherited lblTime: TLabel
      HelpContext = 80007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 80008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 80009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 80010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 80011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 80012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 80013
      inherited LblChooseTemplate: TLabel
        HelpContext = 80014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 80015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 80016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 80017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 80018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 80019
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
    HelpContext = 80020
    Color = 15527129
    inherited lblFrom: TLabel
      HelpContext = 80021
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 80022
      Visible = False
    end
    inherited pnlHeader: TPanel
      Top = 4
      HelpContext = 80023
      Caption = 'Customer Notes Report'
      inherited TitleShader: TShader
        HelpContext = 80024
        inherited TitleLabel: TLabel
          HelpContext = 80025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 80026
      inherited grpFilters: TRadioGroup
        HelpContext = 80027
      end
      inherited pnlButtons: TPanel
        HelpContext = 80028
        inherited lblcustomReport: TLabel
          HelpContext = 80029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 80030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 80031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 80032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 80033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 80034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 80035
      inherited Label1: TLabel
        HelpContext = 80036
      end
      inherited Label2: TLabel
        HelpContext = 80037
      end
      inherited cboFilter: TComboBox
        HelpContext = 80038
      end
      inherited edtSearch: TEdit
        Left = 448
        HelpContext = 80039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 80040
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 80041
      Visible = False
    end
    inherited cboDateRange: TComboBox
      HelpContext = 80042
    end
  end
  inherited Panel1: TPanel
    HelpContext = 80043
    inherited grdMain: TwwDBGrid
      HelpContext = 80044
      Selected.Strings = (
        'ID'#9'10'#9'ID'
        'ClientID'#9'10'#9'ClientID'
        'Company'#9'80'#9'Company'
        'EquipmentName'#9'40'#9'EquipmentName'
        'Description'#9'40'#9'Description'
        'NotesExtract'#9'300'#9'NotesExtract'
        'Notes'#9'10'#9'Notes')
      TitleColor = 15527129
      FooterColor = 15527129
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'Select '
      'tblcustomerequip.ID as ID,'
      'tblcustomerequip.ClientID as ClientID,'
      'tblclients.Company as Company,'
      'tblcustomerequip.EquipName as EquipmentName,'
      'tblcustomerequip.Description as Description,'
      'SUBSTRING(tblcustomerequip.Notes,1,300) as NotesExtract,'
      'tblcustomerequip.Notes as Notes,'
      'IsJob as IsJob'
      'From tblcustomerequip'
      'Inner Join tblclients Using(ClientID)'
      'Where tblclients.Customer='#39'T'#39)
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblcustomerequip.ID'
    end
    object qryMainClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tblcustomerequip.ClientID'
    end
    object qryMainCompany: TStringField
      DisplayWidth = 80
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object qryMainEquipmentName: TStringField
      DisplayWidth = 40
      FieldName = 'EquipmentName'
      Origin = 'tblcustomerequip.EquipmentName'
      Size = 255
    end
    object qryMainDescription: TStringField
      DisplayWidth = 40
      FieldName = 'Description'
      Origin = 'tblcustomerequip.Description'
      Size = 255
    end
    object qryMainNotesExtract: TStringField
      DisplayWidth = 300
      FieldName = 'NotesExtract'
      Origin = 'tblcustomerequip.NotesExtract'
      ReadOnly = True
      Size = 300
    end
    object qryMainNotes: TMemoField
      DisplayWidth = 10
      FieldName = 'Notes'
      Origin = 'tblcustomerequip.Notes'
      BlobType = ftMemo
    end
    object qryMainIsJob: TStringField
      FieldName = 'IsJob'
      Origin = 'tblclients.IsJob'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
end
