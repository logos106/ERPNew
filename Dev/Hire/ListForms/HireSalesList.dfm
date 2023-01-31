inherited HireSalesListGUI: THireSalesListGUI
  Left = 398
  Top = 567
  Caption = 'Hire Sales List'
  ExplicitLeft = 398
  ExplicitTop = 567
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1340002
  inherited pnlGraph: TDNMPanel
    Top = 153
    Height = 317
    ExplicitTop = 153
    ExplicitHeight = 317
    HelpContext = 1340003
  end
  inherited HeaderPanel: TPanel
    Height = 153
    ExplicitHeight = 153
    HelpContext = 1340004
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    object lblhireID: TLabel [3]
      Left = 0
      Top = 49
      Width = 996
      Height = 34
      Align = alBottom
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 8
      HelpContext = 1340005
    end
    inherited pnlHeader: TPanel
      Height = 47
      ExplicitHeight = 47
      HelpContext = 1340006
      inherited TitleShader: TShader
        Height = 45
        ExplicitHeight = 45
        HelpContext = 1340007
        inherited TitleLabel: TLabel
          Height = 45
          ExplicitHeight = 45
          HelpContext = 1340008
        end
      end
    end
    inherited Panel2: TPanel
      Top = 116
      ExplicitTop = 116
      HelpContext = 1340011
    end
    inherited Panel3: TPanel
      Top = 83
      ExplicitTop = 83
      HelpContext = 1340012
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
    inherited chkIgnoreDates: TCheckBox
      Visible = False
    end
  end
  inherited Panel1: TPanel
    Top = 153
    Height = 317
    ExplicitTop = 153
    ExplicitHeight = 317
    HelpContext = 1340009
    inherited lblDateComments: TLabel
      Top = 301
      ExplicitTop = 301
    end
    inherited grdMain: TwwDBGrid
      Height = 132
      ControlType.Strings = (
        'IsBO;CheckBox;T;F')
      Selected.Strings = (
        'SaleID'#9'20'#9'Sale #'
        'CustomerName'#9'30'#9'Customer'
        'SaleDate'#9'18'#9'Sale Date'
        'TotalAmountInc'#9'20'#9'Sales Amount'
        'Type'#9'20'#9'Type'
        'IsBO'#9'5'#9'Is Back Order?')
      ExplicitHeight = 132
      HelpContext = 1340010
    end
  end
  inherited FooterPanel: TDNMPanel
    HelpContext = 1340013
    inherited cmdNew: TDNMSpeedButton
      Enabled = False
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'Select '
      's.sAleID as SaleID, '
      'S.CustomerName as  CustomerName, '
      'S.SaleDate as SaleDate,'
      'S.TotalAmountInc as TotalAmountInc,'
      
        'if(S.IsInvoice="T", "Invoice" , if(S.IsSalesOrder="T", "Sales Or' +
        'der" ,if(S.isCashSale="T", "Cash Sale" ,if(S.IsPOS="T", "POS" , ' +
        '"") ) )) as Type,'
      'Sum(SL.shipped) as Shipped'
      'from '
      'tblsales S  '
      'inner join tblsaleslines SL on s.saleId = sl.saleID'
      'Where S.HireGlobalref =:HireGlobalref'
      'group by s.saleID')
    OnCalcFields = qryMainCalcFields
    Active = True
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'HireGlobalref'
      end>
    object qryMainSaleID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Sale #'
      DisplayWidth = 20
      FieldName = 'SaleID'
      Origin = 'S.SaleID'
    end
    object qryMainCustomerName: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 30
      FieldName = 'CustomerName'
      Origin = 'S.CustomerName'
      Size = 255
    end
    object qryMainSaleDate: TDateField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 18
      FieldName = 'SaleDate'
      Origin = 'S.SaleDate'
    end
    object qryMainTotalAmountInc: TFloatField
      DisplayLabel = 'Sales Amount'
      DisplayWidth = 20
      FieldName = 'TotalAmountInc'
      Origin = 'S.TotalAmountInc'
      currency = True
    end
    object qryMainType: TWideStringField
      DisplayWidth = 20
      FieldName = 'Type'
      Origin = 'Type'
      Size = 11
    end
    object qryMainIsBO: TBooleanField
      DisplayLabel = 'Is Back Order?'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'IsBO'
      Calculated = True
    end
    object qryMainShipped: TFloatField
      FieldName = 'Shipped'
      Origin = 'Shipped'
      Visible = False
    end
  end
  inherited MyConnection1: TERPConnection
    Server = 'localhost'
    Connected = True
  end
end
