inherited SupportModulesGUI: TSupportModulesGUI
  Caption = 'Phone Support Module List'
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 825001
  inherited HeaderPanel: TPanel
    HelpContext = 825003
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 825004
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Phone Support Module List'
          HelpContext = 825002
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
    HelpContext = 825005
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'ModuleName'#9'50'#9'Module Name'
        'Active'#9'1'#9'Active')
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select  '
      '* '
      'from tblSupportModules'
      'order by modulename')
    object qryMainModuleName: TWideStringField
      DisplayLabel = 'Module Name'
      DisplayWidth = 50
      FieldName = 'ModuleName'
      Origin = 'tblsupportmodules.ModuleName'
      Size = 255
    end
    object qryMainActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblsupportmodules.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblsupportmodules.ID'
      Visible = False
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblsupportmodules.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainmstimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimeStamp'
      Origin = 'tblsupportmodules.mstimeStamp'
      Visible = False
    end
  end
end
