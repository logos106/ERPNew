inherited WooCommerceInvoicesGUI: TWooCommerceInvoicesGUI
  Left = 577
  Top = 208
  Caption = 'WooCommerce Orders'
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 1002
  ExplicitHeight = 592
  PixelsPerInch = 96
  TextHeight = 13
  inherited HeaderPanel: TPanel
    inherited imgReportTablesMsg: TImage
      Picture.Data = {
        0954474946496D6167654749463839611100120077000021F904010000FC002C
        0000000011001200870000000000330000660000990000CC0000FF002B00002B
        33002B66002B99002BCC002BFF0055000055330055660055990055CC0055FF00
        80000080330080660080990080CC0080FF00AA0000AA3300AA6600AA9900AACC
        00AAFF00D50000D53300D56600D59900D5CC00D5FF00FF0000FF3300FF6600FF
        9900FFCC00FFFF3300003300333300663300993300CC3300FF332B00332B3333
        2B66332B99332BCC332BFF3355003355333355663355993355CC3355FF338000
        3380333380663380993380CC3380FF33AA0033AA3333AA6633AA9933AACC33AA
        FF33D50033D53333D56633D59933D5CC33D5FF33FF0033FF3333FF6633FF9933
        FFCC33FFFF6600006600336600666600996600CC6600FF662B00662B33662B66
        662B99662BCC662BFF6655006655336655666655996655CC6655FF6680006680
        336680666680996680CC6680FF66AA0066AA3366AA6666AA9966AACC66AAFF66
        D50066D53366D56666D59966D5CC66D5FF66FF0066FF3366FF6666FF9966FFCC
        66FFFF9900009900339900669900999900CC9900FF992B00992B33992B66992B
        99992BCC992BFF9955009955339955669955999955CC9955FF99800099803399
        80669980999980CC9980FF99AA0099AA3399AA6699AA9999AACC99AAFF99D500
        99D53399D56699D59999D5CC99D5FF99FF0099FF3399FF6699FF9999FFCC99FF
        FFCC0000CC0033CC0066CC0099CC00CCCC00FFCC2B00CC2B33CC2B66CC2B99CC
        2BCCCC2BFFCC5500CC5533CC5566CC5599CC55CCCC55FFCC8000CC8033CC8066
        CC8099CC80CCCC80FFCCAA00CCAA33CCAA66CCAA99CCAACCCCAAFFCCD500CCD5
        33CCD566CCD599CCD5CCCCD5FFCCFF00CCFF33CCFF66CCFF99CCFFCCCCFFFFFF
        0000FF0033FF0066FF0099FF00CCFF00FFFF2B00FF2B33FF2B66FF2B99FF2BCC
        FF2BFFFF5500FF5533FF5566FF5599FF55CCFF55FFFF8000FF8033FF8066FF80
        99FF80CCFF80FFFFAA00FFAA33FFAA66FFAA99FFAACCFFAAFFFFD500FFD533FF
        D566FFD599FFD5CCFFD5FFFFFF00FFFF33FFFF66FFFF99FFFFCCFFFFFF000000
        000000000000000000084B0025081C48B0E0C07D08132A5C28709FC1870E2544
        7C4830E2448A0D33623CA851A144841C2576D43852E4C48B161B262429B265CA
        96255FA28CC9F2E54697374BDEB4B8B0E7CA9C050302003B}
    end
    inherited pnlHeader: TPanel
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'WooCommerce Orders'
        end
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Height = 23
      ExplicitHeight = 23
    end
    inherited dtTo: TwwDBDateTimePicker
      Height = 23
      ExplicitHeight = 23
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'ID'#9'10'#9'ERP #'#9'F'#9
        'MagentoID'#9'30'#9'WooCommerce #'#9'F'
        'TransType'#9'10'#9'Type'#9'F'#9
        'TransDate'#9'10'#9'Sale Date'#9'F'#9
        'Name'#9'30'#9'Name'#9'F'#9
        'TotalAmountInc'#9'10'#9'TotalAmountInc'#9'F'#9
        'SynchState'#9'7'#9'Synch State'#9'F'#9
        'Estimatedprice'#9'10'#9'Estimated Price'#9'F'#9)
      TitleLines = 2
    end
    inherited pnlMultiSelectList: TDNMPanel
      inherited lblMultiSelectList: TLabel
        Width = 253
      end
    end
    inherited pnlExtraButtons: TDNMPanel
      inherited btnSynch: TDNMSpeedButton
        Left = 1
        Caption = 'Synch Orders'
        OnClick = btnSynchClick
        ExplicitLeft = 1
      end
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT Distinct S.SaleID as ID,'
      ':SaleType AS TransType,'
      'S.SaleDate AS TransDate,'
      'S.ClientPrintName AS Name,'
      'S.TotalAmountInc,'
      'S.PONumber as MagentoID,'
      
        'If(IsNull(XRefS.SynchState),"New",XRefS.SynchState) AS SynchStat' +
        'e ,'
      'sum(sl.LinePriceInc * sl.QtySold) as Estimatedprice'
      'from tblSales S'
      'INNER JOIN tblExternalXRef XRefS'
      'ON XRefS.ExternalType = "WooCommerce"'
      'AND XRefS.ObjectType in ( "SalesOrder" , "Invoice")'
      'AND XRefS.ERPID = S.SaleID'
      'inner join tblsaleslines sl on s.saleId  = sl.saleId'
      'WHERE S.Cancelled = "F"'
      'AND S.Deleted = "F"'
      'AND S.SaleDate between :DateFrom and :DateTo'
      'group by s.saleId')
    Left = 91
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SaleType'
      end
      item
        DataType = ftUnknown
        Name = 'DateFrom'
      end
      item
        DataType = ftUnknown
        Name = 'DateTo'
      end>
    object qryMainID: TIntegerField
      DisplayLabel = 'ERP #'
      DisplayWidth = 10
      FieldName = 'ID'
    end
    object qryMainMagentoID: TWideStringField
      DisplayLabel = 'WooCommerce #'
      DisplayWidth = 30
      FieldName = 'MagentoID'
      Size = 30
    end
    object qryMainTransType: TWideStringField
      DisplayLabel = 'Type'
      DisplayWidth = 10
      FieldName = 'TransType'
      Size = 65530
    end
    object qryMainTransDate: TDateField
      DisplayLabel = 'Sale Date'
      DisplayWidth = 10
      FieldName = 'TransDate'
    end
    object qryMainName: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Size = 255
    end
    object qryMainTotalAmountInc: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalAmountInc'
      currency = True
    end
    object qryMainSynchState: TWideStringField
      DisplayLabel = 'Synch State'
      DisplayWidth = 7
      FieldName = 'SynchState'
      Size = 7
    end
    object qryMainEstimatedprice: TFloatField
      DisplayLabel = 'Estimated Price'
      DisplayWidth = 10
      FieldName = 'Estimatedprice'
      currency = True
    end
  end
  inherited qryPersonalPrefs: TERPQuery
    Left = 191
    Top = 312
  end
  inherited MyConnection1: TERPConnection
    Database = 'magento_test_db'
    Server = 'localhost'
    Left = 17
    Top = 328
  end
  inherited qryCustomReports: TERPQuery
    Left = 149
    Top = 296
  end
  inherited qryCurrencyConversion: TERPQuery
    Left = 274
    Top = 336
  end
  inherited qryFConReport: TERPQuery
    Left = 156
    Top = 336
  end
  inherited dsMain: TDataSource
    Top = 303
  end
  object wsJobClient: TsgcWebSocketClient
    Host = 'localhost'
    Port = 4556
    ConnectTimeout = 0
    ReadTimeout = -1
    TLS = True
    Proxy.Enabled = False
    Proxy.Port = 8080
    Proxy.ProxyType = pxyHTTP
    HeartBeat.Enabled = False
    HeartBeat.Interval = 300
    HeartBeat.Timeout = 0
    IPVersion = Id_IPv4
    OnMessage = wsJobClientMessage
    OnException = wsJobClientException
    Authentication.Enabled = False
    Authentication.URL.Enabled = True
    Authentication.Session.Enabled = False
    Authentication.Basic.Enabled = True
    Authentication.Token.Enabled = False
    Authentication.Token.AuthName = 'Bearer'
    Extensions.DeflateFrame.Enabled = False
    Extensions.DeflateFrame.WindowBits = 15
    Extensions.PerMessage_Deflate.Enabled = False
    Extensions.PerMessage_Deflate.ClientMaxWindowBits = 15
    Extensions.PerMessage_Deflate.ClientNoContextTakeOver = False
    Extensions.PerMessage_Deflate.MemLevel = 9
    Extensions.PerMessage_Deflate.ServerMaxWindowBits = 15
    Extensions.PerMessage_Deflate.ServerNoContextTakeOver = False
    Options.CleanDisconnect = False
    Options.FragmentedMessages = frgOnlyBuffer
    Options.Parameters = '/'
    Options.RaiseDisconnectExceptions = True
    Options.ValidateUTF8 = False
    Specifications.Drafts.Hixie76 = False
    Specifications.RFC6455 = True
    NotifyEvents = neAsynchronous
    LogFile.Enabled = False
    QueueOptions.Binary.Level = qmNone
    QueueOptions.Ping.Level = qmNone
    QueueOptions.Text.Level = qmNone
    WatchDog.Attempts = 0
    WatchDog.Enabled = False
    WatchDog.Interval = 10
    Throttle.BitsPerSec = 0
    Throttle.Enabled = False
    LoadBalancer.Enabled = False
    LoadBalancer.Port = 0
    TLSOptions.VerifyCertificate = False
    TLSOptions.Version = tlsUndefined
    TLSOptions.IOHandler = iohOpenSSL
    Left = 464
    Top = 320
  end
  object wsClient: TsgcWebSocketClient
    Host = 'localhost'
    Port = 4556
    ConnectTimeout = 0
    ReadTimeout = -1
    TLS = True
    Proxy.Enabled = False
    Proxy.Port = 8080
    Proxy.ProxyType = pxyHTTP
    HeartBeat.Enabled = False
    HeartBeat.Interval = 300
    HeartBeat.Timeout = 0
    IPVersion = Id_IPv4
    OnException = wsJobClientException
    Authentication.Enabled = False
    Authentication.URL.Enabled = True
    Authentication.Session.Enabled = False
    Authentication.Basic.Enabled = True
    Authentication.Token.Enabled = False
    Authentication.Token.AuthName = 'Bearer'
    Extensions.DeflateFrame.Enabled = False
    Extensions.DeflateFrame.WindowBits = 15
    Extensions.PerMessage_Deflate.Enabled = False
    Extensions.PerMessage_Deflate.ClientMaxWindowBits = 15
    Extensions.PerMessage_Deflate.ClientNoContextTakeOver = False
    Extensions.PerMessage_Deflate.MemLevel = 9
    Extensions.PerMessage_Deflate.ServerMaxWindowBits = 15
    Extensions.PerMessage_Deflate.ServerNoContextTakeOver = False
    Options.CleanDisconnect = False
    Options.FragmentedMessages = frgOnlyBuffer
    Options.Parameters = '/'
    Options.RaiseDisconnectExceptions = True
    Options.ValidateUTF8 = False
    Specifications.Drafts.Hixie76 = False
    Specifications.RFC6455 = True
    NotifyEvents = neAsynchronous
    LogFile.Enabled = False
    QueueOptions.Binary.Level = qmNone
    QueueOptions.Ping.Level = qmNone
    QueueOptions.Text.Level = qmNone
    WatchDog.Attempts = 0
    WatchDog.Enabled = False
    WatchDog.Interval = 10
    Throttle.BitsPerSec = 0
    Throttle.Enabled = False
    LoadBalancer.Enabled = False
    LoadBalancer.Port = 0
    TLSOptions.VerifyCertificate = False
    TLSOptions.Version = tlsUndefined
    TLSOptions.IOHandler = iohOpenSSL
    Left = 528
    Top = 312
  end
end
