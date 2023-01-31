inherited fmGoodsReceiptPrintPO: TfmGoodsReceiptPrintPO
  BorderStyle = bsDialog
  Caption = 'Print Purchase Order'
  ClientHeight = 229
  ClientWidth = 488
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Position = poScreenCenter
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 494
  ExplicitHeight = 258
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1644002
  inherited lblSkingroupMsg: TLabel
    Top = 229
    Width = 488
    ExplicitTop = 229
    ExplicitWidth = 488
    HelpContext = 1644003
  end
  object pnlTitle: TDNMPanel [4]
    Left = 50
    Top = 6
    Width = 388
    Height = 45
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    HelpContext = 1644004
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 384
      Height = 41
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.4.0.0'
      HelpContext = 1644005
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 384
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Print Purchase Order'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 483
        HelpContext = 1644006
      end
    end
  end
  object btnCompleted: TDNMSpeedButton [5]
    Left = 127
    Top = 193
    Width = 97
    Height = 29
    Anchors = []
    Caption = '&Ok'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    TabStop = False
    OnClick = btnCompletedClick
    HelpContext = 1644007
  end
  object btnCancel: TDNMSpeedButton [6]
    Left = 263
    Top = 193
    Width = 97
    Height = 29
    Anchors = []
    Cancel = True
    Caption = '&Close'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    TabStop = False
    HelpContext = 1644008
  end
  object cboPO: TwwDBLookupCombo [7]
    Left = 16
    Top = 96
    Width = 129
    Height = 44
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'PurchaseOrderNumber'#9'10'#9'PO Number'#9'F'
      'ClientPrintName'#9'30'#9'Supplier'#9'F')
    LookupTable = qryPO
    LookupField = 'PurchaseOrderNumber'
    ParentFont = False
    TabOrder = 3
    AutoDropDown = False
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
    HelpContext = 1644009
  end
  object wwDBEdit1: TwwDBEdit [8]
    Left = 151
    Top = 96
    Width = 314
    Height = 44
    DataField = 'ClientPrintName'
    DataSource = dsPO
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 4
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    HelpContext = 1644010
  end
  object qryPO: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select CAST(0 as UNSIGNED) as PurchaseOrderID, NULL as PurchaseO' +
        'rderNumber, NULL as ClientPrintName'
      'union all'
      
        'select distinct PO.PurchaseOrderID, PO.PurchaseOrderNumber, PO.C' +
        'lientPrintName from tblpurchaseorders PO'
      
        'inner join tblpurchaselines POL on POL.PurchaseOrderID = PO.Purc' +
        'haseOrderID and POL.Deleted = "F" and POL.BackOrder > 0'
      'where PO.IsPO = "T"'
      'and PO.Deleted ="F"'
      'order by PurchaseOrderID')
    Left = 416
    Top = 168
    object qryPOPurchaseOrderNumber: TWideStringField
      DisplayLabel = 'PO Number'
      DisplayWidth = 10
      FieldName = 'PurchaseOrderNumber'
      Size = 30
    end
    object qryPOClientPrintName: TWideStringField
      DisplayLabel = 'Supplier'
      DisplayWidth = 30
      FieldName = 'ClientPrintName'
      Size = 255
    end
    object qryPOPurchaseOrderID: TLargeintField
      FieldName = 'PurchaseOrderID'
      Visible = False
    end
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Connected = True
    LoginPrompt = False
    Left = 322
    Top = 63
  end
  object dsPO: TDataSource
    DataSet = qryPO
    Left = 288
    Top = 152
  end
end
