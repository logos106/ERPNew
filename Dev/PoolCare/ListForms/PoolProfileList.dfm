inherited PoolProfileListGUI: TPoolProfileListGUI
  Left = 82
  Top = 464
  Caption = 'Pool Profile List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 15527129
  end
  inherited HeaderPanel: TPanel
    Color = 15527129
    inherited pnlHeader: TPanel
      Caption = 'Pool Profile List'
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'UsesMSA;CheckBox;Yes;No'
        'IsSpa;CheckBox;Yes;No')
      Selected.Strings = (
        'client'#9'22'#9'Customer'
        'Location'#9'10'#9'Location'
        'construction'#9'22'#9'Construction'
        'Sanitizer'#9'20'#9'Sanitizer'
        'Volume'#9'15'#9'Volume'
        'SanitizerLvl'#9'15'#9'Sanitizer Level'
        'UsesMSA'#9'1'#9'Uses MSA'
        'IsSpa'#9'1'#9'IsSpa'
        'SaltRequired'#9'15'#9'Salt Required')
      TitleColor = 15527129
      FooterColor = 15527129
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      
        'Select  PP.PoolProfileId, tblClients.Company as client , PP.Loca' +
        'tion,  PTC.Name as construction ,  PTCS.Name as Sanitizer, '
      
        'Volume*1000 as Volume , SanitizerLvl, UsesMSA, IsSpa, SaltRequir' +
        'ed'
      'from tblPoolProfile PP '
      'inner join tblClients on PP.ClientId = tblClients.ClientID'
      
        'left join tblpooltestCategories PTC on PP.construction = PTC.Tes' +
        'tCategoriesID'
      
        'Left join tblpooltestCategories PTCS on PP.Sanitizer = PTCS.Test' +
        'CategoriesID')
    object qryMainclient: TStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 22
      FieldName = 'client'
      Origin = 'tblClients.client'
      Size = 80
    end
    object qryMainLocation: TStringField
      DisplayWidth = 10
      FieldName = 'Location'
      Origin = 'tblPoolProfile.Location'
      Size = 10
    end
    object qryMainconstruction: TStringField
      DisplayLabel = 'Construction'
      DisplayWidth = 22
      FieldName = 'construction'
      Origin = 'PTC.construction'
      Size = 30
    end
    object qryMainSanitizer: TStringField
      DisplayWidth = 20
      FieldName = 'Sanitizer'
      Origin = 'PTCS.Sanitizer'
      Size = 30
    end
    object qryMainVolume: TIntegerField
      DisplayWidth = 15
      FieldName = 'Volume'
      Origin = '.Volume'
    end
    object qryMainSanitizerLvl: TIntegerField
      DisplayLabel = 'Sanitizer Level'
      DisplayWidth = 15
      FieldName = 'SanitizerLvl'
      Origin = 'tblPoolProfile.SanitizerLvl'
    end
    object qryMainUsesMSA: TStringField
      DisplayLabel = 'Uses MSA'
      DisplayWidth = 1
      FieldName = 'UsesMSA'
      Origin = 'tblPoolProfile.UsesMSA'
      FixedChar = True
      Size = 1
    end
    object qryMainIsSpa: TStringField
      DisplayWidth = 1
      FieldName = 'IsSpa'
      Origin = 'tblPoolProfile.IsSpa'
      FixedChar = True
      Size = 1
    end
    object qryMainSaltRequired: TIntegerField
      DisplayLabel = 'Salt Required'
      DisplayWidth = 15
      FieldName = 'SaltRequired'
      Origin = 'tblPoolProfile.SaltRequired'
    end
    object qryMainPoolProfileId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'PoolProfileId'
      Origin = 'tblPoolProfile.PoolProfileId'
      Visible = False
    end
  end
end
