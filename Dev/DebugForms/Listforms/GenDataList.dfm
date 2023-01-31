inherited GenDataListGUI: TGenDataListGUI
  Caption = 'Gen Data'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 771001
  inherited FooterPanel: TDnMPanel
    HelpContext = 771002
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
  inherited Panel1: TPanel
    HelpContext = 771003
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'Description'#9'20'#9'Description'
        'EmployeeName'#9'13'#9'Employee'#9'F'
        'Value1'#9'20'#9'Value1'
        'Value2'#9'20'#9'Value2'
        'Value3'#9'20'#9'Value3'
        'Value4'#9'20'#9'Value4'
        'Value5'#9'20'#9'Value5')
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      
        'Select G.*  , concat(E.firstname, middlename, LastName) as Emplo' +
        'yeeName'
      'from tblGendata G'
      'Left join tblemployees e on E.EmployeeId = G.employeeId')
    object qryMainDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tblGendata.Description'
      Size = 50
    end
    object qryMainEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 13
      FieldName = 'EmployeeName'
      Origin = '.EmployeeName'
      Size = 120
    end
    object qryMainValue1: TWideStringField
      DisplayWidth = 20
      FieldName = 'Value1'
      Origin = 'tblGendata.Value1'
      Size = 255
    end
    object qryMainValue2: TWideStringField
      DisplayWidth = 20
      FieldName = 'Value2'
      Origin = 'tblGendata.Value2'
      Size = 255
    end
    object qryMainValue3: TWideStringField
      DisplayWidth = 20
      FieldName = 'Value3'
      Origin = 'tblGendata.Value3'
      Size = 255
    end
    object qryMainValue4: TWideStringField
      DisplayWidth = 20
      FieldName = 'Value4'
      Origin = 'tblGendata.Value4'
      Size = 255
    end
    object qryMainValue5: TWideStringField
      DisplayWidth = 20
      FieldName = 'Value5'
      Origin = 'tblGendata.Value5'
      Size = 255
    end
    object qryMainEmployeeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeId'
      Origin = 'tblGendata.EmployeeId'
      Visible = False
    end
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblGendata.ID'
      Visible = False
    end
    object qryMainmstimestamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimestamp'
      Origin = 'tblGendata.mstimestamp'
      Visible = False
    end
  end
end
