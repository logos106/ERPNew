inherited PCCDeliveryList: TPCCDeliveryList
  Left = 144
  Top = 323
  Caption = 'Fuel Delivery List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TPanel
    Color = 13092579
  end
  inherited HeaderPanel: TPanel
    Color = 13092579
    inherited pnlHeader: TPanel
      Caption = 'Fuel Delivery List'
    end
    inherited Panel2: TPanel
      inherited grpFilters: TRadioGroup
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'All')
      end
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'TabkNo'#9'15'#9'TabkNo'
        'Volume'#9'10'#9'Volume'
        'DeliveryDateTime'#9'18'#9'DeliveryDateTime'
        'InvoiceNo'#9'255'#9'InvoiceNo'
        'Active'#9'1'#9'Active')
      TitleColor = 13092579
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT '
      'PCCDeliveryID as PCCDeliveryID, '
      'TankNo as TabkNo,'
      'Volume as Volume,'
      'DeliveryDateTime as DeliveryDateTime,'
      'InvoiceNo as InvoiceNo,'
      'Active '
      'FROM tblPCCDelivery')
    object qryMainPCCDeliveryID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PCCDeliveryID'
      Origin = 'tblPCCDelivery.PCCDeliveryID'
      Visible = False
    end
    object qryMainTabkNo: TIntegerField
      FieldName = 'TabkNo'
      Origin = 'tblPCCDelivery.TabkNo'
    end
    object qryMainVolume: TFloatField
      FieldName = 'Volume'
      Origin = 'tblPCCDelivery.Volume'
    end
    object qryMainDeliveryDateTime: TDateTimeField
      FieldName = 'DeliveryDateTime'
      Origin = 'tblPCCDelivery.DeliveryDateTime'
    end
    object qryMainInvoiceNo: TStringField
      FieldName = 'InvoiceNo'
      Origin = 'tblPCCDelivery.InvoiceNo'
      Size = 255
    end
    object qryMainActive: TStringField
      FieldName = 'Active'
      Origin = 'tblPCCDelivery.Active'
      FixedChar = True
      Size = 1
    end
  end
end
