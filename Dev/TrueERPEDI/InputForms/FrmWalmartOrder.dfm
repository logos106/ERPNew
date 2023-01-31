inherited FmWalmartOrder: TFmWalmartOrder
  Left = 295
  Top = 143
  Caption = 'Walmart Order'
  ClientHeight = 565
  ClientWidth = 1184
  ExplicitLeft = 295
  ExplicitTop = 143
  ExplicitWidth = 1200
  ExplicitHeight = 604
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1678002
  inherited lblSkingroupMsg: TLabel
    Top = 515
    Width = 1184
    ExplicitTop = 223
    ExplicitWidth = 455
    HelpContext = 1678003
  end
  inherited shapehint: TShape
    Left = 154
    Top = 10
    ExplicitLeft = 49
    ExplicitTop = 10
  end
  inherited imgGridWatermark: TImage
    Left = 305
    Top = 10
    ExplicitLeft = 305
    ExplicitTop = 10
  end
  inherited shapehintextra1: TShape
    Left = 321
    Top = 10
    ExplicitLeft = 113
    ExplicitTop = 10
  end
  inherited pnlMain: TDNMPanel
    Width = 1184
    Height = 465
    ExplicitLeft = 499
    ExplicitTop = 309
    ExplicitWidth = 1184
    ExplicitHeight = 356
    HelpContext = 1678004
    object DNMPanel1: TDNMPanel
      Left = 1
      Top = 1
      Width = 1182
      Height = 463
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      HelpContext = 1678005
      object pnlHeader: TDNMPanel
        Left = 1
        Top = 1
        Width = 1180
        Height = 160
        HelpContext = 1678006
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        Transparent = False
        DesignSize = (
          1180
          160)
        object Bvlshipto: TBevel
          Left = 906
          Top = 0
          Width = 274
          Height = 160
          HelpContext = 1678007
          Align = alRight
          ExplicitLeft = 545
        end
        object SaleDate_Label: TLabel
          Left = 39
          Top = 66
          Width = 62
          Height = 15
          HelpContext = 1678008
          Alignment = taRightJustify
          Caption = 'Order Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label8: TLabel
          Left = 46
          Top = 24
          Width = 55
          Height = 15
          HelpContext = 1678009
          Alignment = taRightJustify
          Caption = 'Employee'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label1: TLabel
          Left = 915
          Top = 4
          Width = 41
          Height = 15
          Anchors = [akTop, akRight]
          Caption = 'Ship To'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1678010
        end
        object Label2: TLabel
          Left = 14
          Top = 108
          Width = 87
          Height = 18
          HelpContext = 1678011
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'ERP Sales Ref'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
        end
        object txtShipTo: TDBMemo
          Left = 915
          Top = 21
          Width = 250
          Height = 128
          HelpContext = 1678012
          Anchors = [akTop, akRight]
          DataField = 'PostalAddress'
          DataSource = dsediorders
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object edtEmployeename: TDBEdit
          Left = 107
          Top = 23
          Width = 195
          Height = 23
          HelpContext = 1678013
          DataField = 'EmployeeName'
          DataSource = dsediorders
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object edtERPSalesRef: TDBEdit
          Left = 107
          Top = 107
          Width = 130
          Height = 23
          HelpContext = 1678014
          DataField = 'ERPSalesRef'
          DataSource = dsediorders
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnDblClick = edtERPSalesRefDblClick
        end
        object edtorderDate: TDBEdit
          Left = 107
          Top = 65
          Width = 130
          Height = 23
          HelpContext = 1678015
          DataField = 'orderDate'
          DataSource = dsediorders
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
      end
      object DNMPanel2: TDNMPanel
        Left = 1
        Top = 174
        Width = 1180
        Height = 288
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        HelpContext = 1678016
        object pnlWalmartOrderStatus: TDNMPanel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 1172
          Height = 280
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          HelpContext = 1678017
          object Label7: TLabel
            Left = 0
            Top = 265
            Width = 1172
            Height = 15
            HelpContext = 1678018
            Align = alBottom
            Alignment = taCenter
            Caption = '( Double Click on Item To Re-Activate  )'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Transparent = True
            ExplicitWidth = 211
          end
          object grdWalmartOrderStatus: TwwDBGrid
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1166
            Height = 259
            Selected.Strings = (
              'Linenumber'#9'10'#9'Line #'
              'ProductName'#9'10'#9'Product'
              'sku'#9'10'#9'SKU'
              'QtySold'#9'10'#9'Quantity'
              'UOM'#9'10'#9'UOM'
              'ShipMethod'#9'10'#9'Ship Method'
              'status'#9'10'#9'Status'
              'statusDate'#9'18'#9'Status Date'
              'OriginalCarrierMethod'#9'10'#9'Original~Carrier Method'
              'FulfillmentOption'#9'10'#9'Fulfillment~Option'
              'IntentToCancel'#9'10'#9'Intent To~Cancel?'
              'PickUpBy'#9'10'#9'PickUp By'
              'PickUpDateTime'#9'18'#9'PickUp Date'
              'RefundComments'#9'10'#9'Refund Comments'
              'StoreId'#9'10'#9'Store')
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 0
            ShowHorzScrollBar = True
            Align = alClient
            DataSource = dsWalmartOrderStatus
            KeyOptions = []
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 2
            TitleButtons = False
            HelpContext = 1678019
          end
        end
      end
    end
  end
  inherited pnlbottom: TDNMPanel
    Top = 515
    Width = 1184
    ExplicitTop = 465
    ExplicitWidth = 1184
    HelpContext = 1678020
    object cmdClose: TDNMSpeedButton
      Left = 305
      Top = 10
      Width = 203
      Height = 29
      HelpContext = 1678021
      Anchors = []
      Caption = 'Make ERP Order'
      Default = True
      DisableTransparent = False
      Enabled = False
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
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = cmdCloseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 779
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 1678022
      Anchors = []
      Cancel = True
      Caption = '&Cancel'
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = cmdCancelClick
    end
    object pnlChooseRpt: TDNMPanel
      Left = 1007
      Top = 15
      Width = 128
      Height = 21
      HelpContext = 1678023
      Anchors = [akRight]
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object chkChooseRpt: TCheckBox
        Left = 5
        Top = 3
        Width = 120
        Height = 17
        HelpContext = 1678024
        TabStop = False
        Caption = 'Choose Template'
        TabOrder = 0
      end
    end
  end
  inherited pnltop: TDNMPanel
    Width = 1184
    ExplicitTop = 59
    ExplicitWidth = 1184
    HelpContext = 1678025
    object Label3: TLabel [0]
      Left = 1036
      Top = 23
      Width = 51
      Height = 15
      HelpContext = 1678026
      Anchors = [akTop, akRight]
      Caption = 'Order No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object txtCustomID: TDBEdit
      Left = 1093
      Top = 19
      Width = 78
      Height = 23
      Hint = 'Double Click For The Transaction Sequence List'
      HelpContext = 1678027
      Anchors = [akTop, akRight]
      DataField = 'OrderId'
      DataSource = dsediorders
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 151
    Top = 13
  end
  inherited tmrdelay: TTimer
    Left = 316
    Top = 13
  end
  inherited popSpelling: TPopupMenu
    Left = 118
    Top = 13
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 184
    Top = 13
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 349
    Top = 13
  end
  inherited MyConnection: TERPConnection
    Left = 24
    Top = 79
  end
  inherited DataState: TDataState
    Left = 250
    Top = 13
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 382
    Top = 13
  end
  inherited imgsort: TImageList
    Left = 283
    Top = 13
    Bitmap = {
      494C010102009400280110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  inherited QryCustomField: TERPQuery
    Left = 85
    Top = 13
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 415
    Top = 13
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 217
    Top = 13
  end
  inherited qryMemTrans: TERPQuery
    Left = 52
    Top = 13
  end
  object Actionlist: TActionList
    Left = 318
    Top = 346
  end
  object qrywalmartorders: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *  FROM tblWalmartOrders')
    OnCalcFields = qrywalmartordersCalcFields
    Active = True
    Left = 19
    Top = 332
    object qrywalmartordersOrderId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'OrderId'
      Origin = 'tblwalmartorders.OrderId'
    end
    object qrywalmartordersGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblwalmartorders.GlobalRef'
      Size = 255
    end
    object qrywalmartordersEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblwalmartorders.EmployeeName'
      Size = 255
    end
    object qrywalmartorderspurchaseOrderId: TWideStringField
      FieldName = 'purchaseOrderId'
      Origin = 'tblwalmartorders.purchaseOrderId'
      Size = 255
    end
    object qrywalmartorderscustomerOrderId: TWideStringField
      FieldName = 'customerOrderId'
      Origin = 'tblwalmartorders.customerOrderId'
      Size = 255
    end
    object qrywalmartorderscustomerEmailId: TWideStringField
      FieldName = 'customerEmailId'
      Origin = 'tblwalmartorders.customerEmailId'
      Size = 255
    end
    object qrywalmartordersorderDate: TDateTimeField
      FieldName = 'orderDate'
      Origin = 'tblwalmartorders.orderDate'
    end
    object qrywalmartordersBuyerId: TIntegerField
      FieldName = 'BuyerId'
      Origin = 'tblwalmartorders.BuyerId'
    end
    object qrywalmartordersMart: TWideStringField
      FieldName = 'Mart'
      Origin = 'tblwalmartorders.Mart'
      Size = 255
    end
    object qrywalmartordersIsGuest: TWideStringField
      FieldName = 'IsGuest'
      Origin = 'tblwalmartorders.IsGuest'
      FixedChar = True
      Size = 1
    end
    object qrywalmartordersShippingphone: TWideStringField
      FieldName = 'Shippingphone'
      Origin = 'tblwalmartorders.Shippingphone'
      Size = 100
    end
    object qrywalmartordersestimatedDeliveryDate: TDateTimeField
      FieldName = 'estimatedDeliveryDate'
      Origin = 'tblwalmartorders.estimatedDeliveryDate'
    end
    object qrywalmartordersestimatedShipDate: TDateTimeField
      FieldName = 'estimatedShipDate'
      Origin = 'tblwalmartorders.estimatedShipDate'
    end
    object qrywalmartordersShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Origin = 'tblwalmartorders.ShippingMethod'
      Size = 255
    end
    object qrywalmartordersPostalAddressName: TWideStringField
      FieldName = 'PostalAddressName'
      Origin = 'tblwalmartorders.PostalAddressName'
      Size = 255
    end
    object qrywalmartordersPostalAddressAddress1: TWideStringField
      FieldName = 'PostalAddressAddress1'
      Origin = 'tblwalmartorders.PostalAddressAddress1'
      Size = 255
    end
    object qrywalmartordersPostalAddressAddress2: TWideStringField
      FieldName = 'PostalAddressAddress2'
      Origin = 'tblwalmartorders.PostalAddressAddress2'
      Size = 255
    end
    object qrywalmartordersPostalAddressCity: TWideStringField
      FieldName = 'PostalAddressCity'
      Origin = 'tblwalmartorders.PostalAddressCity'
      Size = 255
    end
    object qrywalmartordersPostalAddressstate: TWideStringField
      FieldName = 'PostalAddressstate'
      Origin = 'tblwalmartorders.PostalAddressstate'
      Size = 255
    end
    object qrywalmartordersPostalAddressPostcode: TWideStringField
      FieldName = 'PostalAddressPostcode'
      Origin = 'tblwalmartorders.PostalAddressPostcode'
      Size = 255
    end
    object qrywalmartordersPostalAddressCountry: TWideStringField
      FieldName = 'PostalAddressCountry'
      Origin = 'tblwalmartorders.PostalAddressCountry'
      Size = 255
    end
    object qrywalmartordersPostalAddressAddresstype: TWideStringField
      FieldName = 'PostalAddressAddresstype'
      Origin = 'tblwalmartorders.PostalAddressAddresstype'
      Size = 255
    end
    object qrywalmartordersSalesSource: TWideStringField
      FieldName = 'SalesSource'
      Origin = 'tblwalmartorders.SalesSource'
      Size = 255
    end
    object qrywalmartordersERPSalesRef: TWideStringField
      FieldName = 'ERPSalesRef'
      Origin = 'tblwalmartorders.ERPSalesRef'
      Size = 255
    end
    object qrywalmartordersPostalAddress: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'PostalAddress'
      Origin = 'PostalAddress'
      Size = 1791
      Calculated = True
    end
    object qrywalmartordersValidateOrderStatusCode: TIntegerField
      FieldName = 'ValidateOrderStatusCode'
      Origin = 'tblwalmartorders.ValidateOrderStatusCode'
    end
  end
  object dsediorders: TDataSource
    DataSet = qrywalmartorders
    Left = 19
    Top = 361
  end
  object qryWalmartOrderStatus: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT WOL.* , WOL_ERP.status from  tblwalmartorderlines WOL lef' +
        't join  tblWalmartOrderStatus_ERP WOL_ERP on WOL.OrderId = WOL_E' +
        'RP.woId and WOL.OrderLineId = WOL_ERP.wolineid')
    Active = True
    Left = 76
    Top = 340
    object qryWalmartOrderStatusLinenumber: TWideStringField
      DisplayLabel = 'Line #'
      DisplayWidth = 10
      FieldName = 'Linenumber'
      Origin = 'WOL.Linenumber'
      Size = 255
    end
    object qryWalmartOrderStatusProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 10
      FieldName = 'ProductName'
      Origin = 'WOL.ProductName'
      Size = 255
    end
    object qryWalmartOrderStatussku: TWideStringField
      DisplayLabel = 'SKU'
      DisplayWidth = 10
      FieldName = 'sku'
      Origin = 'WOL.sku'
      Size = 255
    end
    object qryWalmartOrderStatusQtySold: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 10
      FieldName = 'QtySold'
      Origin = 'WOL.QtySold'
    end
    object qryWalmartOrderStatusUOM: TWideStringField
      DisplayWidth = 10
      FieldName = 'UOM'
      Origin = 'WOL.UOM'
      Size = 255
    end
    object qryWalmartOrderStatusShipMethod: TWideStringField
      DisplayLabel = 'Ship Method'
      DisplayWidth = 10
      FieldName = 'ShipMethod'
      Origin = 'WOL.ShipMethod'
      Size = 255
    end
    object qryWalmartOrderStatusstatus: TWideStringField
      DisplayLabel = 'Status'
      DisplayWidth = 10
      FieldName = 'status'
      Origin = 'WOL_ERP.Status'
      Size = 255
    end
    object qryWalmartOrderStatusstatusDate: TDateTimeField
      DisplayLabel = 'Status Date'
      DisplayWidth = 18
      FieldName = 'statusDate'
      Origin = 'WOL.statusDate'
    end
    object qryWalmartOrderStatusOriginalCarrierMethod: TWideStringField
      DisplayLabel = 'Original~Carrier Method'
      DisplayWidth = 10
      FieldName = 'OriginalCarrierMethod'
      Origin = 'WOL.OriginalCarrierMethod'
      Size = 255
    end
    object qryWalmartOrderStatusFulfillmentOption: TWideStringField
      DisplayLabel = 'Fulfillment~Option'
      DisplayWidth = 10
      FieldName = 'FulfillmentOption'
      Origin = 'WOL.FulfillmentOption'
      Size = 255
    end
    object qryWalmartOrderStatusIntentToCancel: TWideStringField
      DisplayLabel = 'Intent To~Cancel?'
      DisplayWidth = 10
      FieldName = 'IntentToCancel'
      Origin = 'WOL.IntentToCancel'
      Size = 255
    end
    object qryWalmartOrderStatusPickUpBy: TWideStringField
      DisplayLabel = 'PickUp By'
      DisplayWidth = 10
      FieldName = 'PickUpBy'
      Origin = 'WOL.PickUpBy'
      Size = 255
    end
    object qryWalmartOrderStatusPickUpDateTime: TDateTimeField
      DisplayLabel = 'PickUp Date'
      DisplayWidth = 18
      FieldName = 'PickUpDateTime'
      Origin = 'WOL.PickUpDateTime'
    end
    object qryWalmartOrderStatusRefundComments: TWideStringField
      DisplayLabel = 'Refund Comments'
      DisplayWidth = 10
      FieldName = 'RefundComments'
      Origin = 'WOL.RefundComments'
      Size = 255
    end
    object qryWalmartOrderStatusStoreId: TWideStringField
      DisplayLabel = 'Store'
      DisplayWidth = 10
      FieldName = 'StoreId'
      Origin = 'WOL.StoreId'
      Size = 255
    end
    object qryWalmartOrderStatusmstimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimeStamp'
      Origin = 'WOL.mstimeStamp'
      Visible = False
    end
    object qryWalmartOrderStatusmsUpdatesitecode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdatesitecode'
      Origin = 'WOL.msUpdatesitecode'
      Visible = False
      Size = 3
    end
    object qryWalmartOrderStatusOfferId: TWideStringField
      DisplayWidth = 255
      FieldName = 'OfferId'
      Origin = 'WOL.OfferId'
      Visible = False
      Size = 255
    end
    object qryWalmartOrderStatusOrderId: TIntegerField
      DisplayWidth = 10
      FieldName = 'OrderId'
      Origin = 'WOL.OrderId'
      Visible = False
    end
    object qryWalmartOrderStatusOrderLineId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'OrderLineId'
      Origin = 'WOL.OrderLineId'
      Visible = False
    end
    object qryWalmartOrderStatusReferenceLineId: TWideStringField
      DisplayWidth = 255
      FieldName = 'ReferenceLineId'
      Origin = 'WOL.ReferenceLineId'
      Visible = False
      Size = 255
    end
    object qryWalmartOrderStatusRefundId: TIntegerField
      DisplayWidth = 10
      FieldName = 'RefundId'
      Origin = 'WOL.RefundId'
      Visible = False
    end
    object qryWalmartOrderStatusValidateOrderStatusCode: TIntegerField
      DisplayWidth = 10
      FieldName = 'ValidateOrderStatusCode'
      Origin = 'WOL.ValidateOrderStatusCode'
      Visible = False
    end
    object qryWalmartOrderStatusGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'WOL.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryWalmartOrderStatusConfigId: TWideStringField
      FieldName = 'ConfigId'
      Origin = 'WOL.ConfigId'
      Visible = False
      Size = 255
    end
    object qryWalmartOrderStatusERPSalesLineRef: TWideStringField
      FieldName = 'ERPSalesLineRef'
      Origin = 'WOL.ERPSalesLineRef'
      Visible = False
      Size = 255
    end
  end
  object dsWalmartOrderStatus: TDataSource
    DataSet = qryWalmartOrderStatus
    Left = 76
    Top = 361
  end
end
