inherited SkillProviderGUI: TSkillProviderGUI
  Caption = 'Skill Providers'
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 800001
  inherited HeaderPanel: TPanel
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Skill Providers'
          HelpContext = 800002
        end
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'SkillProviderName'#9'40'#9'Name'
        'Skill'#9'40'#9'Skill'#9'F'
        'Active'#9'1'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select '
      '`skillProviderId`,`SkillProviderName`,SP.`Active`,`Skill`'
      'From `tblskillprovider` SP '
      'Left  join (`tblskillproviderskills` SPS  '
      
        'inner join `tblskills` S on s.`SkillID`=sps.`skillid`) on  SP.`s' +
        'killProviderId`=SPS.`ProviderID`')
    Active = True
    object qryMainSkillProviderName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 40
      FieldName = 'SkillProviderName'
      Origin = 'SP.SkillProviderName'
      Size = 100
    end
    object qryMainSkill: TWideStringField
      DisplayWidth = 40
      FieldName = 'Skill'
      Origin = 'S.Skill'
      Size = 255
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'SP.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainskillProviderId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'skillProviderId'
      Origin = 'SP.skillProviderId'
      Visible = False
    end
  end
end
