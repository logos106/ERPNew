inherited PaymentsofDeletedsalesGUI: TPaymentsofDeletedsalesGUI
  Left = 250
  Top = 279
  HelpContext = 710000
  Caption = 'Payments of Deleted Sales'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TDnMPanel
    HelpContext = 710001
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 710002
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
    HelpContext = 710003
    inherited lblFrom: TLabel
      HelpContext = 710004
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 710005
      Visible = False
    end
    inherited pnlHeader: TPanel
      HelpContext = 710006
      inherited TitleShader: TShader
        HelpContext = 710007
        inherited TitleLabel: TLabel
          HelpContext = 710008
          Caption = 'Payments of Deleted Sales'
        end
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 710009
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 710010
      Visible = False
    end
  end
  inherited Panel1: TPanel
    HelpContext = 710011
    inherited grdMain: TwwDBGrid
      HelpContext = 710012
      Selected.Strings = (
        'PaymentId'#9'20'#9'Payment#'
        'SaleId'#9'20'#9'Sale#'
        'totalamountINc'#9'20'#9'Total Sales amount'
        'Payment'#9'20'#9'Payment'
        'PaymentDate'#9'10'#9'Payment Date'
        'SaleDate'#9'10'#9'Sale Date'#9'F')
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      
        'select DL.PaymentId, DL.SaleId, S.totalamountINc , DL.Payment, `' +
        'D`.`PaymentDate`,`S`.`SaleDate`'
      ''
      'from tblsales S'
      'left join tblsaleslines SL on S.SaleId = Sl.saleId '
      'inner join tbldepositline DL on Dl.saleId = S.SaleId '
      
        'inner join tbldeposits D on d.PaymentId = DL.PaymentId and ifnul' +
        'l(D.Deleted,"F")= "F"'
      'where ifnull(SL.SaleID,0) = 0 or ifnull(S.SaleID,0) = 0')
    object qryMainPaymentId: TIntegerField
      DisplayLabel = 'Payment#'
      DisplayWidth = 20
      FieldName = 'PaymentId'
      Origin = 'DL.PaymentId'
    end
    object qryMainSaleId: TIntegerField
      DisplayLabel = 'Sale#'
      DisplayWidth = 20
      FieldName = 'SaleId'
      Origin = 'DL.SaleId'
    end
    object qryMaintotalamountINc: TFloatField
      DisplayLabel = 'Total Sales amount'
      DisplayWidth = 20
      FieldName = 'totalamountINc'
      Origin = 'tblsales.totalamountINc'
    end
    object qryMainPayment: TFloatField
      DisplayWidth = 20
      FieldName = 'Payment'
      Origin = 'DL.Payment'
    end
    object qryMainPaymentDate: TDateField
      DisplayLabel = 'Payment Date'
      DisplayWidth = 10
      FieldName = 'PaymentDate'
      Origin = 'D.PaymentDate'
    end
    object qryMainSaleDate: TDateField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 10
      FieldName = 'SaleDate'
      Origin = 'tblsales.SaleDate'
    end
  end
end
