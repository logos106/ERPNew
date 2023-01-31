inherited SalesSummaryGUI: TSalesSummaryGUI
  Left = 166
  Top = 280
  HelpContext = 740000
  Caption = 'Sales Summary'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TDnMPanel
    HelpContext = 740001
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 740002
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
    HelpContext = 740003
    inherited lblFrom: TLabel
      HelpContext = 740004
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 740005
      Visible = False
    end
    inherited Panel2: TPanel
      HelpContext = 740006
      inherited grpFilters: TwwRadioGroup
        HelpContext = 740007
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Sales with Mismatch'
          'All')
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 740008
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 740009
      Visible = False
    end
  end
  inherited Panel1: TPanel
    HelpContext = 740010
    inherited grdMain: TwwDBGrid
      Width = 813
      HelpContext = 740011
      Selected.Strings = (
        'saleID'#9'10'#9'ID'#9'F'
        'Company'#9'15'#9'Client'#9'F'
        'SaleDate'#9'10'#9'Sale Date'#9'F'
        'SalesTotalAmount'#9'10'#9'Amount(Ex)'#9'F'#9'Sales'
        'SalesTotalAmountInc'#9'10'#9'Amount(Inc)'#9'F'#9'Sales'
        'SalesBalance'#9'10'#9'Balance'#9'F'#9'Sales'
        'SalesPayment'#9'10'#9'Payment'#9'F'#9'Sales'
        'LinesTotalAmount'#9'10'#9'Amount(Ex)'#9'F'#9'Lines'
        'LinestotalAmountInc'#9'10'#9'Amount(Inc)'#9'F'#9'Lines'
        'PaymentTotal'#9'10'#9'Payment~Total'#9'F'
        'Saletype'#9'1'#9'Saletype'#9'F')
      TitleLines = 2
      UseTFields = False
      ExplicitWidth = 813
    end
    object DBMemo1: TDBMemo
      Left = 813
      Top = 0
      Width = 185
      Height = 342
      HelpContext = 740012
      Align = alRight
      DataField = 'ErrorCodeDesc'
      DataSource = dsMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      
        'select T.*, C.Company, " " as Saletype from tmp_salessummary T i' +
        'nner join tblclients c on C.clientId = T.ClientID order by SaleI' +
        'D')
    AfterOpen = qryMainAfterOpen
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tmp_salessummary_david_324707b0.ID'
    end
    object qryMainsaleID: TIntegerField
      DisplayLabel = 'ID'
      DisplayWidth = 10
      FieldName = 'saleID'
      Origin = 'tmp_salessummary_david_324707b0.SALEID'
    end
    object qryMainClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tmp_salessummary_david_324707b0.CLIENTID'
    end
    object qryMainSaleDate: TDateTimeField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 18
      FieldName = 'SaleDate'
      Origin = 'tmp_salessummary_david_324707b0.SALEDATE'
    end
    object qryMainSalesTotalAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'SalesTotalAmount'
      Origin = 'tmp_salessummary_david_324707b0.SALESTOTALAMOUNT'
      currency = True
    end
    object qryMainSalesTotalAmountInc: TFloatField
      DisplayWidth = 10
      FieldName = 'SalesTotalAmountInc'
      Origin = 'tmp_salessummary_david_324707b0.SALESTOTALAMOUNTINC'
      currency = True
    end
    object qryMainSalesBalance: TFloatField
      DisplayWidth = 10
      FieldName = 'SalesBalance'
      Origin = 'tmp_salessummary_david_324707b0.SALESBALANCE'
      currency = True
    end
    object qryMainSalesPayment: TFloatField
      DisplayWidth = 10
      FieldName = 'SalesPayment'
      Origin = 'tmp_salessummary_david_324707b0.SALESPAYMENT'
      currency = True
    end
    object qryMainLinesTotalAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'LinesTotalAmount'
      Origin = 'tmp_salessummary_david_324707b0.LINESTOTALAMOUNT'
      currency = True
    end
    object qryMainLinestotalAmountInc: TFloatField
      DisplayWidth = 10
      FieldName = 'LinestotalAmountInc'
      Origin = 'tmp_salessummary_david_324707b0.LINESTOTALAMOUNTINC'
      currency = True
    end
    object qryMainPaymentTotal: TFloatField
      DisplayWidth = 10
      FieldName = 'PaymentTotal'
      Origin = 'tmp_salessummary_david_324707b0.PAYMENTTOTAL'
      currency = True
    end
    object qryMainCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'c.Company'
      Size = 80
    end
    object qryMainErrorCodeDesc: TWideStringField
      FieldName = 'ErrorCodeDesc'
      Size = 255
    end
    object qryMainErrorCode: TIntegerField
      FieldName = 'ErrorCode'
    end
  end
end
