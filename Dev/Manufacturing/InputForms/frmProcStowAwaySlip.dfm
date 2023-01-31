inherited fmProcStowAwaySlip: TfmProcStowAwaySlip
  Left = 11
  Top = 374
  HelpContext = 193000
  Caption = 'Production Stow Away Slip'
  ClientHeight = 493
  ClientWidth = 998
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 193001
  end
  object pnlBottom: TDNMPanel [1]
    Left = 0
    Top = 449
    Width = 998
    Height = 44
    HelpContext = 193002
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      998
      44)
    object btnSave: TDNMSpeedButton
      Left = 401
      Top = 10
      Width = 87
      Height = 28
      HelpContext = 193003
      Action = actOk
      Anchors = [akBottom]
      Caption = 'Ok'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 0
    end
    object btnCancel: TDNMSpeedButton
      Left = 510
      Top = 10
      Width = 87
      Height = 28
      HelpContext = 193004
      Action = actCancel
      Anchors = [akBottom]
      Caption = 'Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
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
      TabOrder = 1
    end
    object btnPrint: TDNMSpeedButton
      Left = 17
      Top = 8
      Width = 87
      Height = 28
      HelpContext = 193005
      Action = actPrint
      Anchors = [akBottom]
      Caption = 'Print'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object chkPreview: TwwCheckBox
      Left = 120
      Top = 14
      Width = 81
      Height = 17
      HelpContext = 193006
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'Preview'
      TabOrder = 3
    end
  end
  object pnlTop: TDNMPanel [2]
    Left = 0
    Top = 0
    Width = 998
    Height = 121
    HelpContext = 193007
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      998
      121)
    object Label2: TLabel
      Left = 112
      Top = 64
      Width = 26
      Height = 15
      HelpContext = 193008
      Caption = 'Date'
      Transparent = True
    end
    object Label1: TLabel
      Left = 256
      Top = 64
      Width = 65
      Height = 15
      HelpContext = 193009
      Caption = 'Description'
      Transparent = True
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 45
      Height = 15
      HelpContext = 193010
      Caption = 'Number'
      Transparent = True
    end
    object pnlTitle: TDNMPanel
      Left = 235
      Top = 6
      Width = 527
      Height = 41
      HelpContext = 193011
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 523
        Height = 37
        HelpContext = 193012
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
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 523
          Height = 37
          HelpContext = 193013
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Production Stow Away Slip'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
    object edtDate: TwwDBEdit
      Left = 112
      Top = 80
      Width = 121
      Height = 23
      HelpContext = 193014
      DataField = 'Date'
      DataSource = dsPickSlip
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtDescription: TwwDBEdit
      Left = 256
      Top = 80
      Width = 441
      Height = 23
      HelpContext = 193015
      DataField = 'Description'
      DataSource = dsPickSlip
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit1: TwwDBEdit
      Left = 16
      Top = 80
      Width = 73
      Height = 23
      HelpContext = 193016
      DataField = 'ProcPickSlipId'
      DataSource = dsPickSlip
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object chkPicked: TwwCheckBox
      Left = 752
      Top = 80
      Width = 81
      Height = 17
      HelpContext = 193017
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Caption = 'Stowed'
      DataField = 'Picked'
      DataSource = dsPickSlip
      TabOrder = 4
      OnClick = chkPickedClick
    end
    object btnPickAll: TDNMSpeedButton
      Left = 880
      Top = 74
      Width = 87
      Height = 27
      HelpContext = 193018
      Action = actPickAll
      Caption = 'Stow All'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
  object Grid: TwwDBGrid [3]
    Left = 0
    Top = 121
    Width = 998
    Height = 328
    HelpContext = 193019
    Selected.Strings = (
      'ItemCaption'#9'15'#9'Item'#9#9
      'ItemDescription'#9'20'#9'Description'#9#9
      'ItemTotalQtyOriginal'#9'10'#9'Qty Planned'#9'F'
      'ItemTotalQtyUsed'#9'10'#9'Qty Stowed'#9'F'
      'ItemPartUom'#9'8'#9'UOM'#9#9
      'StepDescription'#9'20'#9'Process'#9#9
      'SaleLineProductName'#9'20'#9'Line Product'#9#9
      'SaleLineProductDescription'#9'30'#9'Line Description'#9#9
      'SaleLineQuantity'#9'10'#9'Line Quantity'#9#9
      'SaleLineShipDate'#9'10'#9'Line Ship Date'#9'F'#9
      'SaleDocNumber'#9'10'#9'Doc Number'#9#9
      'SaleCustomerName'#9'30'#9'Customer Name'#9#9
      'SaleShipDate'#9'10'#9'SaleShipDate'#9'F'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = dsPickSlipLines
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    KeyOptions = [dgAllowDelete]
    ParentFont = False
    TabOrder = 2
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnDblClick = GridDblClick
    OnFieldChanged = GridFieldChanged
  end
  object ActionList: TActionList
    OnUpdate = ActionListUpdate
    Left = 136
    Top = 56
    object actOk: TAction
      Caption = 'Ok'
      OnExecute = actOkExecute
    end
    object actCancel: TAction
      Caption = 'Cancel'
      OnExecute = actCancelExecute
    end
    object actPickAll: TAction
      Caption = 'Pick All'
      OnExecute = actPickAllExecute
    end
    object actPrint: TAction
      Caption = 'Print'
      OnExecute = actPrintExecute
    end
  end
  object qryPickSlip: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblProcPickSlip')
    Left = 496
    Top = 8
  end
  object qryPickSlipLines: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblProcPickSlipLine')
    Left = 536
    Top = 8
    object qryPickSlipLinesItemCaption: TStringField
      DisplayLabel = 'Item'
      DisplayWidth = 15
      FieldName = 'ItemCaption'
      Size = 255
    end
    object qryPickSlipLinesItemDescription: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldName = 'ItemDescription'
      Size = 255
    end
    object qryPickSlipLinesItemTotalQtyOriginal: TFloatField
      DisplayLabel = 'Qty Planned'
      DisplayWidth = 10
      FieldName = 'ItemTotalQtyOriginal'
    end
    object qryPickSlipLinesItemTotalQtyUsed: TFloatField
      DisplayLabel = 'Qty Stowed'
      DisplayWidth = 10
      FieldName = 'ItemTotalQtyUsed'
    end
    object qryPickSlipLinesItemPartUom: TStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 8
      FieldName = 'ItemPartUom'
      Size = 255
    end
    object qryPickSlipLinesStepDescription: TStringField
      DisplayLabel = 'Process'
      DisplayWidth = 20
      FieldName = 'StepDescription'
      Size = 255
    end
    object qryPickSlipLinesSaleLineProductName: TStringField
      DisplayLabel = 'Line Product'
      DisplayWidth = 20
      FieldName = 'SaleLineProductName'
      Size = 255
    end
    object qryPickSlipLinesSaleLineProductDescription: TStringField
      DisplayLabel = 'Line Description'
      DisplayWidth = 30
      FieldName = 'SaleLineProductDescription'
      Size = 255
    end
    object qryPickSlipLinesSaleLineQuantity: TFloatField
      DisplayLabel = 'Line Quantity'
      DisplayWidth = 10
      FieldName = 'SaleLineQuantity'
    end
    object qryPickSlipLinesSaleLineShipDate: TDateField
      DisplayLabel = 'Line Ship Date'
      DisplayWidth = 10
      FieldName = 'SaleLineShipDate'
    end
    object qryPickSlipLinesSaleDocNumber: TStringField
      DisplayLabel = 'Doc Number'
      DisplayWidth = 10
      FieldName = 'SaleDocNumber'
      Size = 255
    end
    object qryPickSlipLinesSaleCustomerName: TStringField
      DisplayLabel = 'Customer Name'
      DisplayWidth = 30
      FieldName = 'SaleCustomerName'
      Size = 255
    end
    object qryPickSlipLinesSaleShipDate: TDateField
      DisplayWidth = 10
      FieldName = 'SaleShipDate'
    end
    object qryPickSlipLinesProcPickSlipLineId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcPickSlipLineId'
      Visible = False
    end
    object qryPickSlipLinesProcPickSlipId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcPickSlipId'
      Visible = False
    end
    object qryPickSlipLinesProcTreeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcTreeId'
      Visible = False
    end
    object qryPickSlipLinesSaleId: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleId'
      Visible = False
    end
    object qryPickSlipLinesSaleLineId: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineId'
      Visible = False
    end
    object qryPickSlipLinesItemRoot: TStringField
      DisplayWidth = 1
      FieldName = 'ItemRoot'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPickSlipLinesItemTotalQty: TFloatField
      DisplayWidth = 10
      FieldName = 'ItemTotalQty'
      Visible = False
    end
    object qryPickSlipLinesItemPartId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ItemPartId'
      Visible = False
    end
  end
  object dsPickSlip: TDataSource
    DataSet = qryPickSlip
    Left = 496
    Top = 48
  end
  object dsPickSlipLines: TDataSource
    DataSet = qryPickSlipLines
    Left = 544
    Top = 48
  end
end
