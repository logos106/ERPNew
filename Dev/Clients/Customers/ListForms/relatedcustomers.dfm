inherited relatedcustomersGUI: TrelatedcustomersGUI
  Caption = 'Related Customers'
  OldCreateOrder = True
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
          Caption = 'Related Customers'
        end
      end
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'MasterCompany'#9'60'#9'Customer'#9#9
        'ChildCompany'#9'60'#9'Related Customer'#9'F'#9)
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      '`RC`.`MasterCompany`,'
      '`RC`.`ChildCompany`,'
      '`RC`.`RelatedClientID`,'
      '`RC`.`MasterClientID`,'
      '`RC`.`ChildClientID`'
      'FROM `tblrelatedclients` AS `RC`')
    object qryMainMasterCompany: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 60
      FieldName = 'MasterCompany'
      Origin = 'tblrelatedclients.MasterCompany'
      Size = 80
    end
    object qryMainChildCompany: TWideStringField
      DisplayLabel = 'Related Customer'
      DisplayWidth = 60
      FieldName = 'ChildCompany'
      Origin = 'tblrelatedclients.ChildCompany'
      Size = 80
    end
    object qryMainRelatedClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'RelatedClientID'
      Origin = 'tblrelatedclients.RelatedClientID'
      Visible = False
    end
    object qryMainMasterClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'MasterClientID'
      Origin = 'tblrelatedclients.MasterClientID'
      Visible = False
    end
    object qryMainChildClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ChildClientID'
      Origin = 'tblrelatedclients.ChildClientID'
      Visible = False
    end
  end
end
