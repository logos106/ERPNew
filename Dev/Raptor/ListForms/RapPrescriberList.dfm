inherited RapPrescriberListGUI: TRapPrescriberListGUI
  Left = 146
  Top = 281
  Caption = 'Rap Prescriber List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 14144187
  end
  inherited HeaderPanel: TPanel
    Color = 14144187
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'Providernum'#9'20'#9'Provider~Number'#9'F'#9
        'PrescriberName'#9'46'#9'Prescriber~Name'#9#9
        'PrescriberCode'#9'17'#9'Prescriber~Type Code'#9#9
        'PrescriberType'#9'52'#9'Prescriber~Type Name'#9#9)
      TitleColor = 14144187
      TitleLines = 2
      UseTFields = False
      FooterColor = 14144187
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT 2 as DisplayCat, '
      '`tblrapprescriber`.PrescriberID,'
      '`tblrapprescriber`.Providernum,'
      '`tblrapprescriber`.`PrescriberName`,'
      '`tblrapprescribertype`.`PrescriberCode`,'
      '`tblrapprescribertype`.`PrescriberName` as PrescriberType'
      'FROM'
      '`tblrapprescriber`'
      
        'Inner Join `tblrapprescribertypes` ON `tblrapprescriber`.`Prescr' +
        'iberID` = `tblrapprescribertypes`.`PrescriberID`'
      
        'Inner Join `tblrapprescribertype` ON `tblrapprescribertypes`.`Pr' +
        'escriberTypeID` = `tblrapprescribertype`.`PrescriberID`'
      'union '
      'SELECT 1 as DisplayCat, '
      '`tblrapprescriber`.PrescriberID,'
      '`tblrapprescriber`.Providernum,'
      '`tblrapprescriber`.`PrescriberName`,'
      '"",""'
      ''
      'FROM'
      '`tblrapprescriber`'
      'order by PrescriberID, displayCat')
    object qryMainProvidernum: TStringField
      DisplayLabel = 'Provider~Number'
      DisplayWidth = 20
      FieldName = 'Providernum'
      Origin = 'tblrapprescriber.Providernum'
      Size = 10
    end
    object qryMainPrescriberName: TStringField
      DisplayLabel = 'Prescriber~Name'
      DisplayWidth = 46
      FieldName = 'PrescriberName'
      Origin = 'tblrapprescriber.PrescriberName'
      Size = 100
    end
    object qryMainPrescriberCode: TStringField
      DisplayLabel = 'Prescriber~Type Code'
      DisplayWidth = 17
      FieldName = 'PrescriberCode'
      Origin = 'tblrapprescribertype.PrescriberCode'
      Size = 6
    end
    object qryMainPrescriberType: TStringField
      DisplayLabel = 'Prescriber~Type Name'
      DisplayWidth = 52
      FieldName = 'PrescriberType'
      Origin = 'tblrapprescribertype.PrescriberType'
      Size = 100
    end
    object qryMainDisplayCat: TLargeIntField
      DisplayWidth = 15
      FieldName = 'DisplayCat'
      Origin = 'tblrapprescriber.DisplayCat'
      Visible = False
    end
    object qryMainPrescriberID: TIntegerField
      DisplayWidth = 15
      FieldName = 'PrescriberID'
      Origin = 'tblrapprescriber.PrescriberID'
      Visible = False
    end
  end
  inherited ExportDialog: TProgressDialog
    Left = 275
    Top = 10
  end
end
