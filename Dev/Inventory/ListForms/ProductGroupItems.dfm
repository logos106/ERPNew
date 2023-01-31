inherited ProductGroupItemsGUI: TProductGroupItemsGUI
  Left = 1346
  Top = 96
  Caption = 'Product Groups'
  ExplicitLeft = 1346
  ExplicitTop = 96
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 852001
  inherited HeaderPanel: TPanel
    HelpContext = 852003
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 852004
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Product Groups'
          HelpContext = 852002
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
    HelpContext = 852005
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'Groupname'#9'20'#9'Name'#9#9
        'GroupValue'#9'50'#9'Value'#9'F'#9)
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select  '
      #39'GroupName'#39' as Groupname,'
      'ProductGroup as GroupValue'
      'from tblParts')
    object qryMainGroupname: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'Groupname'
      Origin = 'Groupname'
      Size = 9
    end
    object qryMainGroupValue: TWideStringField
      DisplayLabel = 'Value'
      DisplayWidth = 50
      FieldName = 'GroupValue'
      Origin = 'tblparts.PRODUCTGROUP'
      Size = 255
    end
  end
end
