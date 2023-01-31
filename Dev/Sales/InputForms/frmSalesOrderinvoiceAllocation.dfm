inherited fmSalesOrderinvoiceAllocation: TfmSalesOrderinvoiceAllocation
  Left = 279
  Top = 191
  HelpContext = 1157002
  Caption = 'Allocation'
  ClientHeight = 523
  ClientWidth = 574
  ExplicitLeft = 279
  ExplicitTop = 191
  ExplicitWidth = 590
  ExplicitHeight = 562
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 473
    Width = 574
    HelpContext = 1157003
    ExplicitTop = 473
    ExplicitWidth = 684
  end
  inherited shapehint: TShape
    Left = 0
    ExplicitLeft = 3
  end
  inherited shapehintextra1: TShape
    Left = 26
    ExplicitLeft = 34
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 473
    Width = 574
    Height = 50
    HelpContext = 1157008
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      574
      50)
    object btncancel: TDNMSpeedButton
      Left = 448
      Top = 8
      Width = 96
      Height = 29
      HelpContext = 1157009
      Anchors = [akBottom]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btncancelClick
    end
    object btnclose: TDNMSpeedButton
      Left = 26
      Top = 6
      Width = 96
      Height = 29
      HelpContext = 1157010
      Anchors = [akBottom]
      Caption = '&Save'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btncloseClick
    end
    object btnshipAll: TDNMSpeedButton
      Left = 168
      Top = 8
      Width = 96
      Height = 29
      HelpContext = 1157011
      Anchors = []
      Caption = 'Auto Allocate'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnshipAllClick
    end
    object btnAutoAllocate: TDNMSpeedButton
      Left = 308
      Top = 8
      Width = 96
      Height = 29
      HelpContext = 1157012
      Anchors = [akBottom]
      Caption = 'Allocation form'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = btnAutoAllocateClick
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 574
    Height = 131
    HelpContext = 1157013
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      574
      131)
    object Label1: TLabel
      Left = 16
      Top = 72
      Width = 84
      Height = 15
      HelpContext = 1157014
      Caption = 'Product Name '
    end
    object Label2: TLabel
      Left = 43
      Top = 107
      Width = 57
      Height = 15
      HelpContext = 1157015
      Caption = 'Shipment '
    end
    object Label3: TLabel
      Left = 212
      Top = 107
      Width = 63
      Height = 15
      HelpContext = 1157016
      Caption = 'of Total Qty'
    end
    object pnlHeader: TPanel
      Left = 87
      Top = 12
      Width = 400
      Height = 50
      HelpContext = 1157017
      Anchors = [akTop]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 398
        Height = 48
        HelpContext = 1157018
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
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 398
          Height = 48
          HelpContext = 1157019
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Allocation'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
    object edtShipment: TEdit
      Left = 117
      Top = 103
      Width = 87
      Height = 23
      HelpContext = 1157020
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'edtShipment'
    end
    object edttotalQty: TEdit
      Left = 281
      Top = 103
      Width = 87
      Height = 23
      HelpContext = 1157021
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = 'Edit1'
    end
    object edtProductName: TEdit
      Left = 117
      Top = 67
      Width = 251
      Height = 23
      HelpContext = 1157022
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      Text = 'Edit1'
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 131
    Width = 574
    Height = 342
    HelpContext = 1157004
    Align = alClient
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object lblMsg: TLabel
      Left = 1
      Top = 296
      Width = 572
      Height = 45
      HelpContext = 1157005
      Align = alBottom
      Alignment = taCenter
      Caption = 
        'List of allocation allcoated done for the Sale Sales Order for  ' +
        #39'Wagon'#39' is provided. Please allocate the quantity of this shipme' +
        'nt out of it. Or Select '#39'Allocation Form'#39' to allocate different ' +
        'Bin / Batch. Or Select '#39'Allocation Form'#39' to allocate different B' +
        'in / Batch'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 571
    end
    object edtDEsc: TEdit
      AlignWithMargins = True
      Left = 90
      Top = 1
      Width = 464
      Height = 23
      HelpContext = 1157006
      Margins.Left = 13
      Margins.Top = 0
      Margins.Right = 13
      Margins.Bottom = 0
      Alignment = taCenter
      AutoSize = False
      BevelEdges = [beBottom]
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvSpace
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'edtDEsc'
    end
    object grdallocation: TwwDBGrid
      Left = 1
      Top = 21
      Width = 572
      Height = 275
      HelpContext = 1157007
      Selected.Strings = (
        'Allocqty'#9'10'#9'Allocation~to Invoice'
        'batchno'#9'10'#9'No'
        'expirydate'#9'12'#9'Expiry Date'
        'batchqty'#9'10'#9'Quantity'
        'binlocation'#9'10'#9'Location'
        'binnumber'#9'10'#9'Number'
        'binqty'#9'10'#9'Qty'
        'serialnumber'#9'10'#9'Serial No')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnMultiSelectAllRecords = grdallocationMultiSelectAllRecords
      OnMultiSelectRecord = grdallocationMultiSelectRecord
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alBottom
      DataSource = dsallocation
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      OnCalcCellColors = grdallocationCalcCellColors
      OnCalcTitleAttributes = grdallocationCalcTitleAttributes
      FooterColor = clWhite
    end
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200D800F40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object Qryallocation: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tmp_salesorderinvoiceallocation_admin_27e98c2e')
    AfterOpen = QryallocationAfterOpen
    AfterPost = QryallocationAfterPost
    Left = 72
    Top = 257
    object QryallocationAllocqty: TFloatField
      DisplayLabel = 'Allocation~Quantity'
      DisplayWidth = 10
      FieldName = 'Allocqty'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.Allocqty'
    end
    object Qryallocationbatchno: TWideStringField
      DisplayLabel = 'No'
      DisplayWidth = 10
      FieldName = 'batchno'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.batchno'
      Size = 100
    end
    object Qryallocationexpirydate: TDateTimeField
      DisplayLabel = 'Expiry Date'
      DisplayWidth = 12
      FieldName = 'expirydate'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.expirydate'
    end
    object Qryallocationbatchqty: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 10
      FieldName = 'batchqty'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.batchqty'
    end
    object Qryallocationbinlocation: TWideStringField
      DisplayLabel = 'Location'
      DisplayWidth = 10
      FieldName = 'binlocation'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.binlocation'
      Size = 30
    end
    object Qryallocationbinnumber: TWideStringField
      DisplayLabel = 'Number'
      DisplayWidth = 10
      FieldName = 'binnumber'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.binnumber'
      Size = 30
    end
    object Qryallocationbinqty: TFloatField
      DisplayLabel = 'Qty'
      DisplayWidth = 10
      FieldName = 'binqty'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.binqty'
    end
    object Qryallocationserialnumber: TWideStringField
      DisplayLabel = 'Serial No'
      DisplayWidth = 10
      FieldName = 'serialnumber'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.serialnumber'
      Size = 100
    end
    object QryallocationCategory: TWideStringField
      DisplayWidth = 5
      FieldName = 'Category'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.Category'
      Visible = False
      Size = 5
    end
    object QryallocationDetailID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DetailID'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.DetailID'
      Visible = False
    end
    object QryallocationpqaSNID: TIntegerField
      DisplayWidth = 10
      FieldName = 'pqaSNID'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.pqaSNID'
      Visible = False
    end
    object Qryallocationpqabinid: TIntegerField
      DisplayWidth = 10
      FieldName = 'pqabinid'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.pqabinid'
      Visible = False
    end
    object QryallocationpqabatchID: TIntegerField
      DisplayWidth = 10
      FieldName = 'pqabatchID'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.pqabatchID'
      Visible = False
    end
    object Qryallocationbatchbin: TWideStringField
      FieldName = 'batchbin'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.batchbin'
      Visible = False
      Size = 221
    end
    object QryallocationKeydata: TWideStringField
      FieldName = 'Keydata'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.Keydata'
      Visible = False
      Size = 221
    end
    object Qryallocationbinid: TIntegerField
      FieldName = 'binid'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.binid'
      Visible = False
    end
    object QryallocationGlobalref: TWideStringField
      FieldName = 'Globalref'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.Globalref'
      Visible = False
      Size = 255
    end
    object QryallocationParentRef: TWideStringField
      FieldName = 'ParentRef'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.ParentRef'
      Visible = False
      Size = 255
    end
    object QryallocationID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.ID'
      Visible = False
    end
    object QryallocationHidebatch: TWideStringField
      FieldName = 'Hidebatch'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.Hidebatch'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object QryallocationHideBin: TWideStringField
      FieldName = 'HideBin'
      Origin = 'tmp_salesorderinvoiceallocation_admin_27e98c2e.HideBin'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsallocation: TDataSource
    DataSet = Qryallocation
    Left = 72
    Top = 289
  end
end
