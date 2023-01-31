inherited SpecialProductsGUI: TSpecialProductsGUI
  Caption = 'Special Products'
  OldCreateOrder = True
  ExplicitHeight = 596
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TDnMPanel
    inherited barStatus: TAdvOfficeStatusBar
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
    inherited pnlHeader: TPanel
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Special Products'
        end
      end
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'Company'#9'30'#9'Customer'#9#9
        'Name'#9'20'#9'Product'#9#9
        'Description'#9'20'#9'Product~Descriptiom'#9#9
        'OrigPrice'#9'10'#9'Original~Price'#9#9
        'LinePrice'#9'10'#9'Special~Price'#9#9)
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      '`tblcustomerlines`.`CustomerLinesID`,'
      '`tblcustomerlines`.`Name`,'
      '`tblcustomerlines`.`Description`,'
      '`tblcustomerlines`.`OrigPrice`,'
      '`tblcustomerlines`.`LinePrice`,'
      '`tblclients`.`Company`,'
      '`tblcustomerlines`.`CustomerId`'
      'FROM `tblcustomerlines`'
      
        'Inner Join `tblclients` ON `tblcustomerlines`.`CustomerId` = `tb' +
        'lclients`.`ClientID`')
    object qryMainCompany: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 30
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 160
    end
    object qryMainName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'Name'
      Origin = 'tblcustomerlines.Name'
      Size = 40
    end
    object qryMainDescription: TWideStringField
      DisplayLabel = 'Product~Descriptiom'
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tblcustomerlines.Description'
      Size = 255
    end
    object qryMainOrigPrice: TFloatField
      DisplayLabel = 'Original~Price'
      DisplayWidth = 10
      FieldName = 'OrigPrice'
      Origin = 'tblcustomerlines.OrigPrice'
    end
    object qryMainLinePrice: TFloatField
      DisplayLabel = 'Special~Price'
      DisplayWidth = 10
      FieldName = 'LinePrice'
      Origin = 'tblcustomerlines.LinePrice'
    end
    object qryMainCustomerLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'CustomerLinesID'
      Origin = 'tblcustomerlines.CustomerLinesID'
      Visible = False
    end
    object qryMainCustomerId: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerId'
      Visible = False
    end
  end
end
