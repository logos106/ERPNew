inherited RollaBlindHolePlugListGUI: TRollaBlindHolePlugListGUI
  Left = 83
  Top = 150
  Caption = 'Hole Plug List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = clSilver
  end
  inherited HeaderPanel: TPanel
    Color = clSilver
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Left = 223
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
      TitleColor = clSilver
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT *'
      'FROM tblrollaholeplugs')
    object qryMainHolePlugID: TIntegerField
      FieldName = 'HolePlugID'
      Visible = False
    end
    object qryMainGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainMinDrop: TFloatField
      DisplayLabel = 'Min Drop'
      DisplayWidth = 10
      FieldName = 'MinDrop'
    end
    object qryMainMaxDrop: TFloatField
      DisplayLabel = 'Max Drop'
      DisplayWidth = 10
      FieldName = 'MaxDrop'
    end
    object qryMainPlugNumber: TFloatField
      DisplayLabel = 'Number of Plugs'
      FieldName = 'PlugNumber'
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Visible = False
    end
  end
end
