inherited ProductgroupdiscountListGUI: TProductgroupdiscountListGUI
  Caption = 'Product group discount'
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
          Caption = 'Product group discount'
        end
      end
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'Company'#9'20'#9'Company'#9'F'
        'Col1'#9'20'#9'Col1'#9'F'
        'Col2'#9'20'#9'Col2'#9'F'
        'Col3'#9'20'#9'Col3'#9'F'
        'Discount'#9'10'#9'Discount'#9#9)
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      'C.Company as Company ,'
      'GD.GlobalRef as GlobalRef ,'
      'GD.GrpDiscID as GrpDiscID ,'
      'GD.ClientID as ClientID ,'
      'GD.Col1 as Col1 ,'
      'GD.Col2 as Col2 ,'
      'GD.Col3 as Col3 ,'
      'GD.Discount as Discount '
      ''
      
        'from tblProdGroupdiscs GD inner join tblclients C on C.ClientID ' +
        '= GD.ClientID')
    object qryMainCompany: TWideStringField
      DisplayWidth = 20
      FieldName = 'Company'
      Size = 160
    end
    object qryMainCol1: TWideStringField
      DisplayWidth = 20
      FieldName = 'Col1'
      Size = 125
    end
    object qryMainCol2: TWideStringField
      DisplayWidth = 20
      FieldName = 'Col2'
      Size = 125
    end
    object qryMainCol3: TWideStringField
      DisplayWidth = 20
      FieldName = 'Col3'
      Size = 125
    end
    object qryMainDiscount: TFloatField
      DisplayWidth = 10
      FieldName = 'Discount'
    end
    object qryMainGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainGrpDiscID: TIntegerField
      DisplayWidth = 10
      FieldName = 'GrpDiscID'
      Visible = False
    end
    object qryMainClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
  end
end
