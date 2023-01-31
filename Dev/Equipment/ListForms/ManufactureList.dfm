inherited ManufactureListGUI: TManufactureListGUI
  Top = 255
  HelpContext = 736000
  Caption = 'Manufacture List'
  OldCreateOrder = True
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TDnMPanel
    HelpContext = 736001
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 736002
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
    HelpContext = 736003
    inherited lblFrom: TLabel
      HelpContext = 736004
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 736005
      Visible = False
    end
    inherited Panel2: TPanel
      HelpContext = 736009
      inherited grpFilters: TwwRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Avtive'
          'Inactive'
          'Both')
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 736006
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 736007
      Visible = False
    end
  end
  inherited Panel1: TPanel
    HelpContext = 736008
    inherited grdMain: TwwDBGrid
      HelpContext = 736009
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'ID'#9'10'#9'Manufacture #'#9'F'
        'Name'#9'70'#9'Name'#9'F'#9
        'Active'#9'1'#9'Active'#9#9
        'CreatedOn'#9'18'#9'Created On'#9#9)
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select * from tblManufacture')
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Manufacture #'
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblManufacture.ID'
    end
    object qryMainName: TWideStringField
      DisplayWidth = 70
      FieldName = 'Name'
      Origin = 'tblManufacture.Name'
      Size = 50
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblManufacture.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainCreatedOn: TDateTimeField
      DisplayLabel = 'Created On'
      DisplayWidth = 18
      FieldName = 'CreatedOn'
      Origin = 'tblManufacture.CreatedOn'
    end
    object qryMainGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblManufacture.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblManufacture.msTimeStamp'
      Visible = False
    end
  end
end
