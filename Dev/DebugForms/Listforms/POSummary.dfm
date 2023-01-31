inherited POSummaryGUI: TPOSummaryGUI
  Left = 205
  Top = 242
  HelpContext = 741000
  Caption = 'PO Summary'
  OldCreateOrder = True
  ExplicitLeft = 205
  ExplicitTop = 242
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TDnMPanel
    HelpContext = 741001
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 741002
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
    HelpContext = 741003
    inherited lblFrom: TLabel
      HelpContext = 741004
      Visible = False
    end
    inherited lblTo: TLabel
      HelpContext = 741005
      Visible = False
    end
    inherited Panel2: TPanel
      HelpContext = 741006
      inherited grpFilters: TwwRadioGroup
        HelpContext = 741007
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'POs with Mismatch'
          'All')
      end
    end
    inherited Panel3: TPanel
      HelpContext = 741008
      object btnPayments: TDNMSpeedButton
        Left = 886
        Top = 3
        Width = 87
        Height = 27
        HelpContext = 741009
        Anchors = [akTop, akRight]
        Caption = 'Payments'
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          55555555FFFFFFFF5555555000000005555555577777777FF555550999999900
          55555575555555775F55509999999901055557F55555557F75F5001111111101
          105577FFFFFFFF7FF75F00000000000011057777777777775F755070FFFFFF0F
          01105777F555557F75F75500FFFFFF0FF0105577F555FF7F57575550FF700008
          8F0055575FF7777555775555000888888F005555777FFFFFFF77555550000000
          0F055555577777777F7F555550FFFFFF0F05555557F5FFF57F7F555550F000FF
          0005555557F777557775555550FFFFFF0555555557F555FF7F55555550FF7000
          05555555575FF777755555555500055555555555557775555555}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ModalResult = 1
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 2
        TabStop = False
        Visible = False
        OnClick = btnPaymentsClick
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 741010
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 741011
      Visible = False
    end
  end
  inherited Panel1: TPanel
    HelpContext = 741012
    inherited grdMain: TwwDBGrid
      Width = 813
      HelpContext = 741013
      Selected.Strings = (
        'PurchaseOrderID'#9'10'#9'ID'#9'F'
        'Company'#9'15'#9'Client'#9'F'
        'OrderDate'#9'10'#9'OrderDate'#9'F'
        'POTotalAmount'#9'10'#9'Amount(Ex)'#9'F'#9'PO'
        'POTotalAmountInc'#9'10'#9'Amount(Inc)'#9'F'#9'PO'
        'POBalance'#9'10'#9'POBalance'#9'F'#9'PO'
        'POPayment'#9'10'#9'Payment'#9'F'#9'PO'
        'PaymentTotal'#9'10'#9'Payment~Total'#9'F'
        'LinestotalAmountInc'#9'10'#9'Amount(Inc)'#9'F'#9'Lines'
        'LinesTotalAmount'#9'10'#9'Amount(Ex)'#9'F'#9'Lines'
        'ErrorCode'#9'10'#9'ErrorCode'#9'F'
        'ErrorCodeDesc'#9'255'#9'ErrorCodeDesc'#9'F')
      TitleLines = 2
      UseTFields = False
      ExplicitWidth = 813
    end
    object DBMemo1: TDBMemo
      Left = 813
      Top = 0
      Width = 185
      Height = 326
      HelpContext = 741014
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
      
        'select T.*, C.Company, " " as Saletype from tmp_POsummary T inne' +
        'r join tblclients c on C.clientId = T.ClientID order by Purchase' +
        'OrderId')
    AfterOpen = qryMainAfterOpen
    object qryMainID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tmp_POsummary.ID'
    end
    object qryMainPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
      Origin = 'tmp_POsummary.PurchaseOrderID'
    end
    object qryMainClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tmp_POsummary.ClientID'
    end
    object qryMainOrderDate: TDateTimeField
      FieldName = 'OrderDate'
      Origin = 'tmp_POsummary.OrderDate'
    end
    object qryMainPOTotalAmount: TFloatField
      FieldName = 'POTotalAmount'
      Origin = 'tmp_POsummary.POTotalAmount'
    end
    object qryMainPOTotalAmountInc: TFloatField
      FieldName = 'POTotalAmountInc'
      Origin = 'tmp_POsummary.POTotalAmountInc'
    end
    object qryMainPOBalance: TFloatField
      FieldName = 'POBalance'
      Origin = 'tmp_POsummary.POBalance'
    end
    object qryMainPOPayment: TFloatField
      FieldName = 'POPayment'
      Origin = 'tmp_POsummary.POPayment'
    end
    object qryMainLinesTotalAmount: TFloatField
      FieldName = 'LinesTotalAmount'
      Origin = 'tmp_POsummary.LinesTotalAmount'
    end
    object qryMainLinestotalAmountInc: TFloatField
      FieldName = 'LinestotalAmountInc'
      Origin = 'tmp_POsummary.LinestotalAmountInc'
    end
    object qryMainPaymentTotal: TFloatField
      FieldName = 'PaymentTotal'
      Origin = 'tmp_POsummary.PaymentTotal'
    end
    object qryMainErrorCode: TIntegerField
      FieldName = 'ErrorCode'
      Origin = 'tmp_POsummary.ErrorCode'
    end
    object qryMainErrorCodeDesc: TWideStringField
      FieldName = 'ErrorCodeDesc'
      Origin = 'tmp_POsummary.ErrorCodeDesc'
      Size = 255
    end
    object qryMainCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'c.Company'
      Size = 80
    end
  end
end
