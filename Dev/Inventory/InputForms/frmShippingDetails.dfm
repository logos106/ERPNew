inherited ShippingDetailsGUI: TShippingDetailsGUI
  Left = 330
  Top = 202
  Caption = 'Shipping Details'
  ClientHeight = 242
  ClientWidth = 329
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 498000
  object Bevel1: TBevel [0]
    Left = 16
    Top = 64
    Width = 297
    Height = 121
    HelpContext = 498002
  end
  inherited imgGridWatermark: TImage
    Left = 264
    Top = 0
    HelpContext = 498001
  end
  object Label1: TLabel [2]
    Left = 40
    Top = 120
    Width = 123
    Height = 15
    Caption = 'Consignment Number'
    Transparent = True
    HelpContext = 498003
  end
  object Label2: TLabel [3]
    Left = 40
    Top = 152
    Width = 98
    Height = 15
    Caption = 'Number of Boxes'
    Transparent = True
    HelpContext = 498004
  end
  object Label3: TLabel [4]
    Left = 40
    Top = 88
    Width = 98
    Height = 15
    Caption = 'Courier Company'
    Transparent = True
    HelpContext = 498005
  end
  object wwDBEdit2: TwwDBEdit [5]
    Left = 176
    Top = 112
    Width = 113
    Height = 23
    DataField = 'ConsignmentNumber'
    DataSource = dsMain
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    HelpContext = 498006
  end
  object wwDBEdit3: TwwDBEdit [6]
    Left = 176
    Top = 144
    Width = 113
    Height = 23
    DataField = 'BoxNumber'
    DataSource = dsMain
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
    HelpContext = 498007
  end
  object btnSave: TDNMSpeedButton [7]
    Left = 37
    Top = 201
    Width = 87
    Height = 27
    Caption = 'Save'
    Default = True
    DisableTransparent = False
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
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    NumGlyphs = 2
    TabOrder = 2
    OnClick = btnSaveClick
    HelpContext = 498008
  end
  object btnCancel: TDNMSpeedButton [8]
    Left = 204
    Top = 201
    Width = 87
    Height = 27
    Cancel = True
    Caption = 'Cancel'
    DisableTransparent = False
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
    NumGlyphs = 2
    TabOrder = 3
    OnClick = btnCancelClick
    HelpContext = 498009
  end
  object cboCourierCompany: TwwDBLookupCombo [9]
    Left = 176
    Top = 80
    Width = 113
    Height = 23
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    DataField = 'CourierCompany'
    DataSource = dsMain
    LookupTable = qryShippingMethod
    LookupField = 'ShippingMethod'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 4
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
    HelpContext = 498010
  end
  object pnlTitle: TDNMPanel [10]
    Left = 45
    Top = 6
    Width = 238
    Height = 45
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    HelpContext = 498011
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 234
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
      Version = '1.2.1.1'
      HelpContext = 498012
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 234
        Height = 41
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Shipping Details'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        HelpContext = 498013
      end
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 232
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 0
  end
  inherited MyConnection: TERPConnection
    Left = 168
    Top = 0
  end
  inherited DataState: TDataState
    Left = 40
    Top = 0
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 200
    Top = 0
  end
  object qryMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblshippingdetails'
      'WHERE SaleID = :SaleID')
    Left = 104
    ParamData = <
      item
        DataType = ftString
        Name = 'SaleID'
        Value = ''
      end>
    object qryMainShippingDetailsID: TIntegerField
      FieldName = 'ShippingDetailsID'
      Visible = False
    end
    object qryMainGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryMainSaleID: TIntegerField
      FieldName = 'SaleID'
      Visible = False
    end
    object qryMainCourierCompany: TWideStringField
      Alignment = taCenter
      FieldName = 'CourierCompany'
      Size = 255
    end
    object qryMainConsignmentNumber: TWideStringField
      FieldName = 'ConsignmentNumber'
      Size = 255
    end
    object qryMainBoxNumber: TIntegerField
      FieldName = 'BoxNumber'
    end
    object qryMainDateTime: TDateTimeField
      FieldName = 'DateTime'
      Visible = False
    end
    object qryMainActive: TWideStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryMainmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Visible = False
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 136
  end
  object qrySales: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Shipping'
      'FROM tblsales'
      'WHERE SaleID = :SaleID')
    Left = 104
    Top = 32
    ParamData = <
      item
        DataType = ftString
        Name = 'SaleID'
        Value = ''
      end>
    object qrySalesShipping: TWideStringField
      FieldName = 'Shipping'
      Size = 255
    end
  end
  object qryShippingMethod: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ShippingMethodID, ShippingMethod'
      'FROM tblShippingMethods '
      'WHERE Active = '#39'T'#39' '
      'ORDER BY ShippingMethod')
    Left = 136
    Top = 32
    object qryShippingMethodShippingMethodID: TIntegerField
      FieldName = 'ShippingMethodID'
    end
    object qryShippingMethodShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
    end
  end
end
