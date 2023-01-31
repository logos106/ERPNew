inherited fmSalesShippingDetail: TfmSalesShippingDetail
  Left = 372
  Top = 248
  HelpContext = 750000
  Caption = 'Sales Shipping Details'
  ClientHeight = 424
  ClientWidth = 537
  OldCreateOrder = True
  ExplicitLeft = 372
  ExplicitTop = 248
  ExplicitWidth = 553
  ExplicitHeight = 463
  DesignSize = (
    537
    424)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 374
    Width = 537
    HelpContext = 750018
    ExplicitTop = 370
    ExplicitWidth = 537
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 50
    Width = 537
    Height = 324
    HelpContext = 750002
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitHeight = 466
    object Label1: TLabel
      Left = 320
      Top = 64
      Width = 207
      Height = 128
      HelpContext = 750003
      Alignment = taCenter
      Caption = 
        'This form is used from salesorder or invoice and should use Sale' +
        's object from there and so the connection from those forms. This' +
        ' form is in a nested Transaction and should be commited or rollb' +
        'acked before closed'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object Label2: TLabel
      Left = 104
      Top = 13
      Width = 92
      Height = 15
      HelpContext = 750021
      Alignment = taRightJustify
      Caption = 'Customer Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label3: TLabel
      Left = 77
      Top = 43
      Width = 119
      Height = 15
      HelpContext = 750022
      Alignment = taRightJustify
      Caption = 'Flight/Vessel Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 48
      Top = 73
      Width = 148
      Height = 15
      HelpContext = 750023
      Alignment = taRightJustify
      Caption = 'Estimated Time Departure'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 68
      Top = 104
      Width = 128
      Height = 15
      HelpContext = 750024
      Alignment = taRightJustify
      Caption = 'Estimated Time Arrival'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 37
      Top = 164
      Width = 159
      Height = 15
      HelpContext = 750025
      Alignment = taRightJustify
      Caption = 'Bill of Lading / A WB number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 134
      Top = 195
      Width = 62
      Height = 15
      HelpContext = 750026
      Alignment = taRightJustify
      Caption = 'Net Weight'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 119
      Top = 225
      Width = 77
      Height = 15
      HelpContext = 750027
      Alignment = taRightJustify
      Caption = 'Gross Weight'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label9: TLabel
      Left = 142
      Top = 255
      Width = 54
      Height = 15
      HelpContext = 750028
      Alignment = taRightJustify
      Caption = 'Total Size'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblSizeUOM: TLabel
      Left = 298
      Top = 255
      Width = 51
      Height = 15
      HelpContext = 750029
      Caption = 'In  Cubic '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblGrossWeightUOM: TLabel
      Left = 298
      Top = 225
      Width = 10
      Height = 15
      HelpContext = 750030
      Caption = 'In'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblWeightUOM: TLabel
      Left = 298
      Top = 195
      Width = 10
      Height = 15
      HelpContext = 750031
      Caption = 'In'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label13: TLabel
      Left = 72
      Top = 286
      Width = 124
      Height = 15
      HelpContext = 750032
      Alignment = taRightJustify
      Caption = 'Additional Order Cost '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 108
      Top = 134
      Width = 88
      Height = 15
      HelpContext = 750033
      Alignment = taRightJustify
      Caption = 'Ex Factory Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edtFlightno: TwwDBEdit
      Left = 208
      Top = 39
      Width = 185
      Height = 23
      HelpContext = 750004
      DataField = 'FlightNo'
      DataSource = dssalesshippingdetails
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
    object wwDBEdit5: TwwDBEdit
      Left = 208
      Top = 160
      Width = 121
      Height = 23
      HelpContext = 750005
      DataField = 'Description'
      DataSource = dssalesshippingdetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit6: TwwDBEdit
      Left = 208
      Top = 191
      Width = 84
      Height = 23
      HelpContext = 750006
      DataField = 'NetWeight'
      DataSource = dssalesshippingdetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit7: TwwDBEdit
      Left = 208
      Top = 221
      Width = 84
      Height = 23
      HelpContext = 750007
      DataField = 'GrossWeight'
      DataSource = dssalesshippingdetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit8: TwwDBEdit
      Left = 208
      Top = 251
      Width = 84
      Height = 23
      HelpContext = 750008
      DataField = 'TotalCubicsize'
      DataSource = dssalesshippingdetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit9: TwwDBEdit
      Left = 202
      Top = 280
      Width = 121
      Height = 23
      HelpContext = 750009
      DataField = 'AdditionalOrderCost'
      DataSource = dssalesshippingdetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object wwDBEdit1: TwwDBEdit
      Left = 208
      Top = 9
      Width = 313
      Height = 23
      HelpContext = 750010
      DataField = 'CustomerName'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = wwDBEdit1Enter
    end
    object cboDefaultWeightUOM1: TwwDBLookupCombo
      Left = 312
      Top = 191
      Width = 166
      Height = 23
      HelpContext = 750011
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'unitname'#9'15'#9'unitname'#9'F')
      DataField = 'WeightUOM'
      DataSource = dssalesshippingdetails
      LookupTable = QryWeightUOM
      LookupField = 'unitname'
      ParentFont = False
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboDefaultWeightUOM1CloseUp
    end
    object cboDefaultWeightUOM2: TwwDBLookupCombo
      Left = 312
      Top = 221
      Width = 166
      Height = 23
      HelpContext = 750012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'unitname'#9'15'#9'unitname'#9'F')
      DataField = 'WeightUOM'
      DataSource = dssalesshippingdetails
      LookupTable = QryWeightUOM
      LookupField = 'unitname'
      ParentFont = False
      TabOrder = 9
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboDefaultWeightUOM1CloseUp
    end
    object cboDefaultSizeUOM: TwwDBLookupCombo
      Left = 352
      Top = 251
      Width = 126
      Height = 23
      HelpContext = 750013
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'unitname'#9'15'#9'unitname'#9'F')
      DataField = 'SizeUOM'
      DataSource = dssalesshippingdetails
      LookupTable = QrySizeUOM
      LookupField = 'unitname'
      ParentFont = False
      TabOrder = 11
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboDefaultsizeUOMCloseUp
    end
    object dtExFactoryDate: TwwDBDateTimePicker
      Left = 208
      Top = 130
      Width = 113
      Height = 23
      HelpContext = 750014
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ExFactoryDate'
      DataSource = dssalesshippingdetails
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 4
      UnboundDataType = wwDTEdtDate
    end
    object dtETA: TwwDBDateTimePicker
      Left = 208
      Top = 100
      Width = 113
      Height = 23
      HelpContext = 750015
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ETA'
      DataSource = dssalesshippingdetails
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 3
      UnboundDataType = wwDTEdtDate
    end
    object dtETD: TwwDBDateTimePicker
      Left = 208
      Top = 69
      Width = 113
      Height = 23
      HelpContext = 750016
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ETD'
      DataSource = dssalesshippingdetails
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
      UnboundDataType = wwDTEdtDate
    end
    object mem_Note: TMemo
      Left = 1
      Top = 1
      Width = 535
      Height = 93
      Align = alTop
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = []
      Lines.Strings = (
        'frmSalesShippingDetailWalmart form has the walmart '
        'shipping detials.'
        'This from is not used at the moment')
      ParentFont = False
      TabOrder = 13
      Visible = False
      HelpContext = 750037
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 537
    Height = 50
    HelpContext = 750001
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlTitle: TDNMPanel
      Left = 108
      Top = 6
      Width = 323
      Height = 36
      HelpContext = 750034
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
        Width = 319
        Height = 32
        HelpContext = 750035
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
          Width = 319
          Height = 32
          HelpContext = 750036
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sales Shipping Details '
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
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 374
    Width = 537
    Height = 50
    HelpContext = 750017
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object btnSave: TDNMSpeedButton
      Left = 162
      Top = 14
      Width = 87
      Height = 27
      Hint = 'Save this Address against this client and Close'
      HelpContext = 750019
      Caption = '&Save'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 285
      Top = 14
      Width = 87
      Height = 27
      Hint = 'Cancel and Close'
      HelpContext = 750020
      Cancel = True
      Caption = '&Cancel'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 28
    Top = 271
  end
  inherited tmrdelay: TTimer
    Left = 61
    Top = 271
  end
  inherited popSpelling: TPopupMenu
    Left = 28
    Top = 207
  end
  inherited tmrdelayMsg: TTimer
    Left = 129
    Top = 271
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 197
    Top = 207
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 129
    Top = 207
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 28
    Top = 239
  end
  inherited DataState: TDataState
    Left = 231
    Top = 207
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 61
    Top = 207
  end
  inherited imgsort: TImageList
    Left = 163
    Top = 207
    Bitmap = {
      494C010102008800A40010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 129
    Top = 239
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 265
    Top = 207
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 95
    Top = 207
  end
  inherited qryMemTrans: TERPQuery
    Left = 163
    Top = 239
  end
  inherited tmrOnshow: TTimer
    Left = 95
    Top = 271
  end
  object DSMaster: TDataSource
    Left = 95
    Top = 239
  end
  object dssalesshippingdetails: TDataSource
    Left = 61
    Top = 239
  end
  object QryWeightUOM: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select unitId, unitname  from tblunitsofmeasure where ifnull(Par' +
        'tID,0) = 0')
    Left = 231
    Top = 239
    object QryWeightUOMunitname: TWideStringField
      DisplayWidth = 15
      FieldName = 'unitname'
      Origin = 'tblunitsofmeasure.UnitName'
      Size = 15
    end
    object QryWeightUOMunitId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'unitId'
      Origin = 'tblunitsofmeasure.UnitID'
      Visible = False
    end
  end
  object QrySizeUOM: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select unitId, unitname  from tblunitsofmeasure where ifnull(Par' +
        'tID,0) = 0')
    Left = 197
    Top = 239
    object QrySizeUOMunitId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'unitId'
      Origin = 'tblunitsofmeasure.UnitID'
    end
    object QrySizeUOMunitname: TWideStringField
      FieldName = 'unitname'
      Origin = 'tblunitsofmeasure.UnitName'
      Size = 15
    end
  end
end
