inherited fmRepAbilityList: TfmRepAbilityList
  Left = 95
  Top = 151
  HelpContext = 707000
  Caption = 'Rep Ability'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TDnMPanel
    HelpContext = 707001
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 707002
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
    HelpContext = 707003
    inherited lblFrom: TLabel
      HelpContext = 707004
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 707005
      Visible = False
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 707006
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 707007
      Visible = False
    end
  end
  inherited Panel1: TPanel
    HelpContext = 707008
    inherited grdMain: TwwDBGrid
      HelpContext = 707009
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'GlobalRef'#9'10'#9'GlobalRef'#9'F'#9
        'AbilityID'#9'10'#9'AbilityID'#9#9
        'AbilityDesc'#9'50'#9'AbilityDesc'#9#9
        'AbilityValue'#9'10'#9'AbilityValue'#9#9
        'Active'#9'1'#9'Active'#9#9)
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'select * from tblability')
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 10
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMainAbilityID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AbilityID'
    end
    object qryMainAbilityDesc: TWideStringField
      DisplayWidth = 50
      FieldName = 'AbilityDesc'
      Size = 50
    end
    object qryMainAbilityValue: TIntegerField
      DisplayWidth = 10
      FieldName = 'AbilityValue'
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
end
