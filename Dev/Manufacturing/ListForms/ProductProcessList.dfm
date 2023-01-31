inherited ProductProcessListGUI: TProductProcessListGUI
  Caption = 'Product Process List'
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
          Caption = 'Product Process List'
        end
      end
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      ControlType.Strings = (
        'IsTemplate;CheckBox;T;F')
      Selected.Strings = (
        'Mastertype'#9'20'#9'Master~Type'
        'Caption'#9'20'#9'Caption'
        'ProcTreePart'#9'10'#9'Product'
        'Description'#9'20'#9'Description'
        'ProcessPart'#9'10'#9'Process~Part'
        'Seq'#9'1'#9'Seq'
        'IsTemplate'#9'1'#9'Is~Template'
        'duration'#9'10'#9'Duration'
        'setupDuration'#9'10'#9'Setup~Duration'
        'breakdownduration'#9'10'#9'Break Down~Duration'
        'fixedAmount'#9'10'#9'Fixed~Amount'
        'timestart'#9'12'#9'Time Start'#9'F'
        'timeEnd'#9'12'#9'Time End'
        'Status'#9'10'#9'Status')
      TitleLines = 2
      inherited btnGrid: TwwIButton
        Height = 33
      end
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      '`PP`.`ID`,'
      '`PP`.`PartId`,'
      '`PT`.`MasterType` AS `Mastertype`,'
      '`PT`.`Caption` AS `Caption`,'
      '`PPP`.`PARTNAME` ProcTreePart,'
      '`PS`.`Description` Description,'
      '`P`.`PARTNAME` ProcessPart,'
      '`PP`.`ProcessStepSeq` Seq,'
      '`PP`.`IsTemplate` IsTemplate,'
      '`PP`.`Duration` duration,'
      '`PP`.`SetupDuration` setupDuration,'
      '`PP`.`BreakdownDuration` breakdownduration,'
      '`PP`.`FixedAmount` fixedAmount,'
      '`PP`.`TimeStart` timestart,'
      '`PP`.`TimeEnd` timeEnd,'
      '`PP`.`Status` Status'
      'FROM `tblprocesspart` AS `PP`'
      'Inner Join `tblparts` AS `P` ON `PP`.`PartId` = `P`.`PARTSID`'
      
        'LEft Join `tblprocessstep` AS `PS` ON `PP`.`ProcessStepID` = `PS' +
        '`.`ID`'
      
        'Left Join `tblproctree` AS `PT` ON `PP`.`ProcTreeId` = `PT`.`Pro' +
        'cTreeId`'
      
        'Left Join `tblparts` AS `PPP` ON `PT`.`PartsId` = `PPP`.`PARTSID' +
        '`'
      
        'Left Join `tblsaleslines` AS `SL` ON `PT`.`SaleLineId` = `SL`.`S' +
        'aleLineID`'
      'where IfNull(PP.PartID,0) <> 0')
    object qryMainMastertype: TWideStringField
      DisplayLabel = 'Master~Type'
      DisplayWidth = 20
      FieldName = 'Mastertype'
      Origin = 'PT.Mastertype'
      Size = 255
    end
    object qryMainCaption: TWideStringField
      DisplayWidth = 20
      FieldName = 'Caption'
      Origin = 'PT.Caption'
      Size = 255
    end
    object qryMainProcTreePart: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 10
      FieldName = 'ProcTreePart'
      Origin = 'PPP.ProcTreePart'
      Size = 60
    end
    object qryMainDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'PS.Description'
      Size = 255
    end
    object qryMainProcessPart: TWideStringField
      DisplayLabel = 'Process~Part'
      DisplayWidth = 10
      FieldName = 'ProcessPart'
      Origin = 'P.ProcessPart'
      Size = 60
    end
    object qryMainSeq: TIntegerField
      DisplayWidth = 1
      FieldName = 'Seq'
      Origin = 'tblprocesspart.Seq'
    end
    object qryMainIsTemplate: TWideStringField
      DisplayLabel = 'Is~Template'
      DisplayWidth = 1
      FieldName = 'IsTemplate'
      Origin = 'tblprocesspart.IsTemplate'
      FixedChar = True
      Size = 1
    end
    object qryMainduration: TFloatField
      DisplayLabel = 'Duration'
      DisplayWidth = 10
      FieldName = 'duration'
      Origin = 'tblprocesspart.duration'
    end
    object qryMainsetupDuration: TFloatField
      DisplayLabel = 'Setup~Duration'
      DisplayWidth = 10
      FieldName = 'setupDuration'
      Origin = 'tblprocesspart.setupDuration'
    end
    object qryMainbreakdownduration: TFloatField
      DisplayLabel = 'Break Down~Duration'
      DisplayWidth = 10
      FieldName = 'breakdownduration'
      Origin = 'tblprocesspart.breakdownduration'
    end
    object qryMainfixedAmount: TFloatField
      DisplayLabel = 'Fixed~Amount'
      DisplayWidth = 10
      FieldName = 'fixedAmount'
      Origin = 'tblprocesspart.fixedAmount'
    end
    object qryMaintimestart: TDateTimeField
      DisplayLabel = 'Time Start'
      DisplayWidth = 12
      FieldName = 'timestart'
      Origin = 'tblprocesspart.timestart'
    end
    object qryMaintimeEnd: TDateTimeField
      DisplayLabel = 'Time End'
      DisplayWidth = 12
      FieldName = 'timeEnd'
      Origin = 'tblprocesspart.timeEnd'
    end
    object qryMainStatus: TWideStringField
      DisplayWidth = 10
      FieldName = 'Status'
      Origin = 'tblprocesspart.Status'
      Size = 255
    end
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblprocesspart.ID'
      Visible = False
    end
    object qryMainPartId: TIntegerField
      FieldName = 'PartId'
    end
  end
end
