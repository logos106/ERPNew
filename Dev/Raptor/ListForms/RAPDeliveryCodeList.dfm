inherited RAPDeliveryCodeListGUI: TRAPDeliveryCodeListGUI
  Left = 88
  Top = 262
  Caption = 'RAP Delivery Code'
  Color = 14144187
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 14144187
  end
  inherited HeaderPanel: TPanel
    Color = 14144187
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      Caption = 'RAP Delivery Codes'
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
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'DeliveryCode'#9'20'#9'Delivery  Code'#9'F'
        'Description'#9'110'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9#9)
      TitleColor = 14144187
      UseTFields = False
      FooterColor = 14144187
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select * from tblRAPDeliveryCodes')
    object qryMainDeliveryCode: TStringField
      DisplayLabel = 'Delivery Code'
      DisplayWidth = 4
      FieldName = 'DeliveryCode'
      Origin = 'tblRAPDeliveryCodes.DeliveryCode'
      Size = 4
    end
    object qryMainDescription: TStringField
      DisplayWidth = 120
      FieldName = 'Description'
      Origin = 'tblRAPDeliveryCodes.Description'
      Size = 100
    end
    object qryMainActive: TStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblRAPDeliveryCodes.Active'
      FixedChar = True
      Size = 1
    end
    object qryMainDeliveryCodeID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'DeliveryCodeID'
      Origin = 'tblRAPDeliveryCodes.DeliveryCodeID'
      Visible = False
    end
  end
  inherited ExportDialog: TProgressDialog
    Left = 243
  end
end
