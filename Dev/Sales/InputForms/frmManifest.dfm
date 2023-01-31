inherited ManifestGUI: TManifestGUI
  Left = 414
  Top = 172
  HelpContext = 393000
  Caption = 'Manifest'
  ClientHeight = 556
  ClientWidth = 813
  OldCreateOrder = True
  ExplicitWidth = 819
  ExplicitHeight = 585
  DesignSize = (
    813
    556)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 474
    Width = 813
    ExplicitTop = 474
    ExplicitWidth = 813
    HelpContext = 393048
  end
  inherited imgGridWatermark: TImage
    HelpContext = 393001
  end
  object pnlDetail: TDNMPanel [5]
    Left = 0
    Top = 249
    Width = 813
    Height = 225
    HelpContext = 393002
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object grdTransactions: TwwDBGrid
      Left = 1
      Top = 1
      Width = 811
      Height = 223
      HelpContext = 393003
      ControlType.Strings = (
        'ETA;CustomEdit;cboETA;F')
      Selected.Strings = (
        'ETA'#9'10'#9'ETA'#9#9
        'PageNo'#9'1'#9'Page No'#9#9
        'SOID'#9'10'#9'ID'#9'T'#9'Sales Order'
        'PickupFrom'#9'10'#9'Pickup From'#9'T'#9'Sales Order'
        'ShipTo'#9'10'#9'Ship To'#9'T'#9'Sales Order'
        'ProductName'#9'13'#9'Product Name'#9'T'#9'Sales Order'
        'UnitOfMeasure'#9'8'#9'UOM'#9'T'#9'Sales Order'
        'Qty'#9'1'#9'Quantity'#9'T'#9'Sales Order'
        'Value'#9'10'#9'Value'#9'T'#9'Sales Order'
        'Product_Description'#9'20'#9'Description'#9'T'#9'Sales Order'
        'InvoiceID'#9'10'#9'ID'#9'T'#9'Invoice'
        'InvPickupFrom'#9'10'#9'Pickup From'#9'T'#9'Invoice'
        'InvShipTo'#9'10'#9'Ship To'#9'T'#9'Invoice'
        'InvProductName'#9'13'#9'Product Name'#9'T'#9'Invoice'
        'InvUnitOfMeasure'#9'8'#9'UOM'#9'T'#9'Invoice'
        'InvQty'#9'1'#9'Quantity'#9'T'#9'Invoice'
        'InvValue'#9'10'#9'Value'#9'T'#9'Invoice'
        'InvProduct_Description'#9'20'#9'Description'#9'T'#9'Invoice'
        'PreferedSupplier'#9'20'#9'Preferred Supplier'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgEnterToTab]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgRowResize]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      UseTFields = False
      OnCalcCellColors = grdTransactionsCalcCellColors
      OnCalcTitleAttributes = grdTransactionsCalcTitleAttributes
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object btnDelete: TwwIButton
        Left = -2
        Top = -1
        Width = 20
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          C6030000424DC603000000000000360000002800000010000000130000000100
          18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
          666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
          99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
          CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
          333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
          99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
          C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
          C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
          77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
          8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
          B2B2B2808080333366000080333366777777777777333366000080333399C0C0
          C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
          0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
          CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
          0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
          868686808080666699333399333399000080333366666666808080969696C0C0
          C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
          8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
          B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
          80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
          CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
          99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
          D7CCCCCCCCCCCCCCCCCC}
        OnClick = btnDeleteClick
        HelpContext = 393049
      end
    end
    object cboETA: TwwDBDateTimePicker
      Left = 9
      Top = 37
      Width = 121
      Height = 26
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'ETA'
      DataSource = DSDetails
      Epoch = 1950
      ShowButton = True
      TabOrder = 1
      HelpContext = 393050
    end
  end
  object pnlHeader: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 813
    Height = 249
    HelpContext = 393007
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      813
      249)
    object Bevel3: TBevel
      Left = 354
      Top = 86
      Width = 349
      Height = 113
      HelpContext = 393008
      Shape = bsFrame
    end
    object Bevel1: TBevel
      Left = 354
      Top = 210
      Width = 184
      Height = 39
      HelpContext = 393009
      Shape = bsFrame
    end
    object Bevel2: TBevel
      Left = 11
      Top = 56
      Width = 335
      Height = 163
      HelpContext = 393010
      Shape = bsFrame
    end
    object Label38: TLabel
      Left = 27
      Top = 70
      Width = 83
      Height = 23
      HelpContext = 393011
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Supplier Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label160: TLabel
      Left = 626
      Top = 42
      Width = 75
      Height = 18
      HelpContext = 393012
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Manifest No'
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
      Left = 492
      Top = 39
      Width = 90
      Height = 23
      HelpContext = 393013
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Despatch Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label2: TLabel
      Left = 27
      Top = 144
      Width = 83
      Height = 23
      HelpContext = 393014
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Driver Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label31: TLabel
      Left = 18
      Top = 180
      Width = 92
      Height = 23
      HelpContext = 393015
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Phone Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label6: TLabel
      Left = 67
      Top = 106
      Width = 43
      Height = 23
      HelpContext = 393016
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Vehicle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label4: TLabel
      Left = 380
      Top = 223
      Width = 29
      Height = 15
      HelpContext = 393017
      Caption = 'Done'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      Left = 364
      Top = 147
      Width = 63
      Height = 23
      HelpContext = 393018
      AutoSize = False
      Caption = 'Final ETA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label7: TLabel
      Left = 364
      Top = 95
      Width = 124
      Height = 20
      HelpContext = 393019
      AutoSize = False
      Caption = 'Route'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object Label8: TLabel
      Left = 594
      Top = 94
      Width = 92
      Height = 23
      HelpContext = 393020
      AutoSize = False
      Caption = 'Distance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
    end
    object lblBill: TLabel
      Left = 196
      Top = 225
      Width = 159
      Height = 19
      HelpContext = 393021
      Caption = 'Bill has been created'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object txtCustomID: TDBEdit
      Left = 625
      Top = 57
      Width = 78
      Height = 23
      HelpContext = 393022
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'ManifestID'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 17
    end
    object btnNext: TDNMSpeedButton
      Left = 721
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 393023
      Anchors = [akTop, akRight]
      Caption = '&New'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      TabStop = False
      OnClick = btnNextClick
    end
    object btnCompleted: TDNMSpeedButton
      Left = 721
      Top = 41
      Width = 87
      Height = 27
      HelpContext = 393024
      Anchors = [akTop, akRight]
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
      TabOrder = 11
      TabStop = False
      OnClick = btnCompletedClick
    end
    object btnClose: TDNMSpeedButton
      Left = 721
      Top = 72
      Width = 87
      Height = 27
      HelpContext = 393025
      Anchors = [akTop, akRight]
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
      TabOrder = 12
      TabStop = False
      OnClick = btnCloseClick
    end
    object btnPreview: TDNMSpeedButton
      Left = 721
      Top = 103
      Width = 87
      Height = 27
      HelpContext = 393026
      Anchors = [akTop, akRight]
      Caption = 'Pre&view'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      TabStop = False
      OnClick = btnPreviewClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 721
      Top = 134
      Width = 87
      Height = 27
      HelpContext = 393027
      Anchors = [akTop, akRight]
      Caption = 'Prin&t'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 14
      TabStop = False
      OnClick = btnPrintClick
    end
    object cboShipDate: TwwDBDateTimePicker
      Left = 499
      Top = 57
      Width = 116
      Height = 23
      HelpContext = 393028
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DespatchDate'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 4
    end
    object Trailer: TwwRadioGroup
      Left = 544
      Top = 205
      Width = 160
      Height = 44
      HelpContext = 393029
      DisableThemes = False
      TransparentActiveItem = True
      Frame.FocusStyle = efsFrameSunken
      Indents.ButtonX = 7
      Indents.ButtonY = -1
      Indents.TextY = -1
      Transparent = True
      Caption = 'Trailer'
      Columns = 2
      DataField = 'Trailer'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Items.Strings = (
        'Single'
        'B Double')
      ParentFont = False
      TabOrder = 9
      Values.Strings = (
        'Single  '
        'B Double')
    end
    object Phone: TDBEdit
      Left = 113
      Top = 181
      Width = 128
      Height = 23
      HelpContext = 393030
      DataField = 'Phone'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object cboVehicle: TwwDBLookupCombo
      Left = 112
      Top = 108
      Width = 218
      Height = 23
      HelpContext = 393031
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'VehicleName'#9'20'#9'Vehicle Name'#9'F'#9
        'RegistrationNo'#9'10'#9'Reg No.'#9'F'#9)
      DataField = 'VehicleName'
      DataSource = DSMaster
      LookupTable = qryVehicles
      LookupField = 'VehicleName'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object Driver: TDBEdit
      Left = 113
      Top = 145
      Width = 218
      Height = 23
      HelpContext = 393032
      DataField = 'Driver'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object pnlChooseRpt: TDNMPanel
      Left = 353
      Top = 57
      Width = 132
      Height = 23
      HelpContext = 393033
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 18
      object lblChooseRpt: TLabel
        Left = 25
        Top = 5
        Width = 98
        Height = 15
        HelpContext = 393034
        Caption = 'Choose Template'
        Transparent = True
      end
      object chkChooseRpt: TCheckBox
        Left = 7
        Top = 4
        Width = 14
        Height = 17
        HelpContext = 393035
        TabStop = False
        TabOrder = 0
      end
    end
    object chkCompleted: TwwCheckBox
      Left = 361
      Top = 223
      Width = 14
      Height = 15
      HelpContext = 393036
      DisableThemes = False
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
      Caption = 'chkCompleted'
      DataField = 'Completed'
      DataSource = DSMaster
      TabOrder = 8
    end
    object wwDBDateTimePicker1: TwwDBDateTimePicker
      Left = 364
      Top = 165
      Width = 116
      Height = 23
      HelpContext = 393037
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'FinalETA'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 7
    end
    object cboRoute: TwwDBLookupCombo
      Left = 364
      Top = 111
      Width = 216
      Height = 23
      HelpContext = 393038
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'RouteDesc'#9'30'#9'RouteDesc'#9'F')
      DataField = 'ManifestRouteID'
      DataSource = DSMaster
      LookupTable = qryRoutes
      LookupField = 'ManifestRouteID'
      ParentFont = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object DBEdit1: TDBEdit
      Left = 594
      Top = 111
      Width = 95
      Height = 23
      HelpContext = 393039
      DataField = 'Distance'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object cboOwnerName: TwwDBLookupCombo
      Left = 113
      Top = 71
      Width = 218
      Height = 23
      HelpContext = 393040
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'OwnerName'#9'20'#9'Owner'#9'F')
      DataField = 'OwnerName'
      DataSource = DSMaster
      LookupTable = qryOwners
      LookupField = 'Company'
      Style = csDropDownList
      DropDownWidth = 40
      ParentFont = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboOwnerNameCloseUp
    end
    object cmdEmail: TDNMSpeedButton
      Left = 721
      Top = 165
      Width = 87
      Height = 27
      HelpContext = 393041
      Anchors = [akTop, akRight]
      Caption = '&Email'
      DisableTransparent = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 15
    end
    object cmdFax: TDNMSpeedButton
      Left = 721
      Top = 196
      Width = 87
      Height = 27
      HelpContext = 393042
      Anchors = [akTop, akRight]
      Caption = '&Fax'
      DisableTransparent = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 16
    end
    object btnCreateBill: TDNMSpeedButton
      Left = 247
      Top = 180
      Width = 87
      Height = 24
      HelpContext = 393043
      Caption = 'Create Bill'
      DisableTransparent = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 19
      Visible = False
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 415
      Top = 220
      Width = 113
      Height = 23
      HelpContext = 393044
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'30'#9'EmployeeName'#9'F')
      DataField = 'EmployeeId'
      DataSource = DSMaster
      LookupTable = qryEmployees
      LookupField = 'EmployeeId'
      Style = csDropDownList
      ParentFont = False
      TabOrder = 20
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object pnlTitle: TDNMPanel
      Left = 301
      Top = 6
      Width = 190
      Height = 42
      HelpContext = 393045
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 21
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 186
        Height = 38
        HelpContext = 393046
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
          Width = 186
          Height = 38
          HelpContext = 393047
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Manifest'
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
    object rbSummary: TRadioButton
      Left = 27
      Top = 225
      Width = 113
      Height = 17
      Caption = 'Summary'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 22
      OnClick = rbSummaryClick
      HelpContext = 393051
    end
    object rbDetails: TRadioButton
      Left = 146
      Top = 225
      Width = 113
      Height = 17
      Caption = 'Details'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 23
      TabStop = True
      OnClick = rbDetailsClick
      HelpContext = 393052
    end
  end
  object pnlFooter: TDNMPanel [7]
    Left = 0
    Top = 474
    Width = 813
    Height = 82
    HelpContext = 393004
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      813
      82)
    object Label1: TLabel
      Left = 11
      Top = 5
      Width = 67
      Height = 18
      HelpContext = 393005
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Notes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object txtComments: TDBMemo
      Left = 10
      Top = 22
      Width = 791
      Height = 53
      HelpContext = 393006
      Anchors = [akLeft, akBottom]
      DataField = 'Notes'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 10
    Top = 7
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 74
    Top = 7
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200E0000C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblmanifest'
      'Where ManifestID = :ID;')
    Left = 19
    Top = 348
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Size = 255
      end>
    object tblMasterManifestID: TAutoIncField
      FieldName = 'ManifestID'
      ReadOnly = True
    end
    object tblMasterDespatchDate: TDateField
      FieldName = 'DespatchDate'
    end
    object tblMasterOwnerName: TWideStringField
      FieldName = 'OwnerName'
      Size = 255
    end
    object tblMasterDriver: TWideStringField
      FieldName = 'Driver'
      Size = 255
    end
    object tblMasterPhone: TWideStringField
      FieldName = 'Phone'
      Size = 30
    end
    object tblMasterNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object tblMasterVehicleID: TIntegerField
      FieldName = 'VehicleID'
    end
    object tblMasterVehicleName: TWideStringField
      FieldName = 'VehicleName'
      Size = 255
    end
    object tblMasterTrailer: TWideStringField
      FieldName = 'Trailer'
      FixedChar = True
      Size = 8
    end
    object tblMasterFromCity: TWideStringField
      FieldName = 'FromCity'
      Size = 100
    end
    object tblMasterFromPostcode: TWideStringField
      FieldName = 'FromPostcode'
      Size = 4
    end
    object tblMasterToCity: TWideStringField
      FieldName = 'ToCity'
      Size = 100
    end
    object tblMasterToPostcode: TWideStringField
      FieldName = 'ToPostcode'
      Size = 4
    end
    object tblMasterFromState: TWideStringField
      FieldName = 'FromState'
      Size = 30
    end
    object tblMasterToState: TWideStringField
      FieldName = 'ToState'
      Size = 30
    end
    object tblMasterCompleted: TWideStringField
      FieldName = 'Completed'
      FixedChar = True
      Size = 1
    end
    object tblMasterFinalETA: TDateField
      FieldName = 'FinalETA'
    end
    object tblMasterManifestRouteID: TIntegerField
      FieldName = 'ManifestRouteID'
    end
    object tblMasterDistance: TIntegerField
      FieldName = 'Distance'
    end
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterBillID: TIntegerField
      FieldName = 'BillID'
    end
    object tblMasterEmployeeId: TIntegerField
      FieldName = 'EmployeeId'
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 19
    Top = 383
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 57
    Top = 383
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select '
      'ML.GlobalRef,  '
      'ML.ManifestLineId,'
      'ML.ManifestId, '
      'ML.SaleLineId,'
      'ML.InvoiceLineId,'
      'ML.ETA, '
      'ML.PageNo, '
      'ML.EditedFlag,'
      'ML.msTimeStamp, '
      'ML.Deleted, '
      'ML.msUpdateSiteCode'
      'from tblManifestLines ML'
      'Where ML.ManifestID= :ID'
      ''
      '/*'
      'SELECT'
      '*'
      'FROM'
      '`tblmanifestlines` ML '
      'Where ML.ManifestID= :ID'
      '*/')
    Filtered = True
    Filter = 'Deleted ='#39'F'#39
    BeforeOpen = tblDetailsBeforeOpen
    AfterPost = tblDetailsAfterPost
    Left = 57
    Top = 348
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblDetailsETA: TDateField
      DisplayWidth = 10
      FieldName = 'ETA'
      Origin = 'ML.ETA'
    end
    object tblDetailsPageNo: TIntegerField
      DisplayLabel = 'Page No'
      DisplayWidth = 1
      FieldName = 'PageNo'
      Origin = 'ML.PageNo'
    end
    object tblDetailsPickupFrom: TWideStringField
      DisplayLabel = 'Pickup From'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'PickupFrom'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'PickupFrom'
      KeyFields = 'SaleLineID'
      Size = 100
      Lookup = True
    end
    object tblDetailsShipTo: TWideStringField
      DisplayLabel = 'Ship To'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'ShipTo'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'ShipTo'
      KeyFields = 'SaleLineID'
      Size = 100
      Lookup = True
    end
    object tblDetailsProductName: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 13
      FieldKind = fkLookup
      FieldName = 'ProductName'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'ProductName'
      KeyFields = 'SaleLineID'
      Size = 100
      Lookup = True
    end
    object tblDetailsUnitOfMeasure: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 8
      FieldKind = fkLookup
      FieldName = 'UnitOfMeasure'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'UnitOfMeasure'
      KeyFields = 'SaleLineID'
      Size = 100
      Lookup = True
    end
    object tblDetailsQty: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 1
      FieldKind = fkLookup
      FieldName = 'Qty'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Qty'
      KeyFields = 'SaleLineID'
      Lookup = True
    end
    object tblDetailsValue: TFloatField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Value'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Value'
      KeyFields = 'SaleLineID'
      currency = True
      Lookup = True
    end
    object tblDetailsProduct_Description: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Product_Description'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Product_Description'
      KeyFields = 'SaleLineID'
      Size = 100
      Lookup = True
    end
    object tblDetailsInvPickupFrom: TWideStringField
      DisplayLabel = 'Pickup From'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'InvPickupFrom'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'PickupFrom'
      KeyFields = 'InvoiceLineID'
      Size = 100
      Lookup = True
    end
    object tblDetailsInvShipTo: TWideStringField
      DisplayLabel = 'Ship To'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'InvShipTo'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'ShipTo'
      KeyFields = 'InvoiceLineID'
      Size = 100
      Lookup = True
    end
    object tblDetailsInvProductName: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 13
      FieldKind = fkLookup
      FieldName = 'InvProductName'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'ProductName'
      KeyFields = 'InvoiceLineID'
      Size = 100
      Lookup = True
    end
    object tblDetailsInvUnitOfMeasure: TWideStringField
      DisplayLabel = 'UOM'
      DisplayWidth = 8
      FieldKind = fkLookup
      FieldName = 'InvUnitOfMeasure'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'UnitOfMeasure'
      KeyFields = 'InvoiceLineID'
      Size = 100
      Lookup = True
    end
    object tblDetailsInvQty: TFloatField
      DisplayLabel = 'Quantity'
      DisplayWidth = 1
      FieldKind = fkLookup
      FieldName = 'InvQty'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Qty'
      KeyFields = 'InvoiceLineID'
      Lookup = True
    end
    object tblDetailsInvValue: TFloatField
      DisplayLabel = 'Value'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'InvValue'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Value'
      KeyFields = 'InvoiceLineID'
      currency = True
      Lookup = True
    end
    object tblDetailsInvProduct_Description: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'InvProduct_Description'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Product_Description'
      KeyFields = 'InvoiceLineID'
      Size = 100
      Lookup = True
    end
    object tblDetailsDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'ML.Deleted'
      FixedChar = True
      Size = 1
    end
    object tblDetailsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'ML.msTimeStamp'
    end
    object tblDetailsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'ML.msUpdateSiteCode'
      Size = 3
    end
    object tblDetailsAttrib1sale: TFloatField
      DisplayLabel = 'Attrib 1'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Attrib1sale'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Attrib1sale'
      KeyFields = 'SaleLineID'
      Visible = False
      Lookup = True
    end
    object tblDetailsAttrib2sale: TFloatField
      DisplayLabel = 'Attrib 2'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Attrib2sale'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Attrib2sale'
      KeyFields = 'SaleLineID'
      Visible = False
      Lookup = True
    end
    object tblDetailsAttrib1saleRate: TFloatField
      DisplayLabel = 'Attrib1 Rate'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Attrib1saleRate'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Attrib1saleRate'
      KeyFields = 'SaleLineID'
      Visible = False
      Lookup = True
    end
    object tblDetailsInvAttrib1sale: TFloatField
      DisplayLabel = 'Attrib 1'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'InvAttrib1sale'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Attrib1sale'
      KeyFields = 'InvoiceLineID'
      Visible = False
      Lookup = True
    end
    object tblDetailsInvAttrib2sale: TFloatField
      DisplayLabel = 'Attrib 2'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'InvAttrib2sale'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Attrib2sale'
      KeyFields = 'InvoiceLineID'
      Visible = False
      Lookup = True
    end
    object tblDetailsInvAttrib1saleRate: TFloatField
      DisplayLabel = 'Attrib1 Rate'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'InvAttrib1saleRate'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineId'
      LookupResultField = 'Attrib1saleRate'
      KeyFields = 'InvoiceLineID'
      Visible = False
      Lookup = True
    end
    object tblDetailsGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'ML.GlobalRef'
      Size = 255
    end
    object tblDetailsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'ML.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblDetailsManifestLineID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ManifestLineID'
      Origin = 'ML.ManifestLineID'
      ReadOnly = True
    end
    object tblDetailsManifestID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ManifestID'
      Origin = 'ML.ManifestID'
    end
    object tblDetailsSOID: TIntegerField
      FieldKind = fkLookup
      FieldName = 'SOID'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'SaleID'
      KeyFields = 'SaleLineID'
      Lookup = True
    end
    object tblDetailsInvoiceID: TIntegerField
      FieldKind = fkLookup
      FieldName = 'InvoiceID'
      LookupDataSet = QryInvLookup
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'SaleID'
      KeyFields = 'InvoiceLineID'
      Lookup = True
    end
    object tblDetailsPreferedSupplier: TStringField
      FieldKind = fkLookup
      FieldName = 'PreferedSupplier'
      LookupDataSet = QrySalesLookup
      LookupKeyFields = 'SaleLineID'
      LookupResultField = 'PreferedSupplier'
      KeyFields = 'SaleLineID'
      Size = 255
      Lookup = True
    end
    object tblDetailsSaleLineId: TIntegerField
      FieldName = 'SaleLineId'
    end
    object tblDetailsInvoiceLineId: TIntegerField
      FieldName = 'InvoiceLineId'
    end
  end
  object qryVehicles: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT VehicleID, VehicleName, OwnerName, Driver, Phone, '
      'RegistrationNo, Trailer, Notes, PercentageRate   '
      'FROM tblmanifestvehicles'
      'WHERE (OwnerName = :xOwner AND Active = '#39'T'#39')')
    BeforeOpen = qryVehiclesBeforeOpen
    Left = 340
    Top = 356
    ParamData = <
      item
        DataType = ftString
        Name = 'xOwner'
        Size = 255
      end>
    object qryVehiclesVehicleName: TWideStringField
      DisplayLabel = 'Vehicle Name'
      DisplayWidth = 20
      FieldName = 'VehicleName'
      Size = 255
    end
    object qryVehiclesRegistrationNo: TWideStringField
      DisplayLabel = 'Reg No.'
      DisplayWidth = 10
      FieldName = 'RegistrationNo'
      Size = 10
    end
    object qryVehiclesOwnerName: TWideStringField
      DisplayLabel = 'Owner'
      DisplayWidth = 20
      FieldName = 'OwnerName'
      Visible = False
      Size = 255
    end
    object qryVehiclesVehicleID: TAutoIncField
      FieldName = 'VehicleID'
      ReadOnly = True
      Visible = False
    end
    object qryVehiclesDriver: TWideStringField
      FieldName = 'Driver'
      Visible = False
      Size = 255
    end
    object qryVehiclesPhone: TWideStringField
      FieldName = 'Phone'
      Visible = False
      Size = 30
    end
    object qryVehiclesTrailer: TWideStringField
      FieldName = 'Trailer'
      Visible = False
      FixedChar = True
      Size = 8
    end
    object qryVehiclesNotes: TWideMemoField
      FieldName = 'Notes'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryVehiclesPercentageRate: TFloatField
      FieldName = 'PercentageRate'
    end
  end
  object DSVehicles: TDataSource
    DataSet = qryVehicles
    Left = 340
    Top = 391
  end
  object qryRoutes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ManifestRouteID, RouteDesc, Distance, PaletteRate  FROM t' +
        'blmanifestroutes')
    Left = 301
    Top = 356
  end
  object qryOwners: TERPQuery
    Connection = MyConnection
    ParamCheck = False
    SQL.Strings = (
      'SELECT tblclients.ClientID, tblclients.Company,'
      'tblmanifestvehicles.SupplierID'
      'FROM tblclients'
      
        'INNER JOIN tblmanifestvehicles ON tblclients.ClientID = tblmanif' +
        'estvehicles.SupplierID'
      'WHERE (tblclients.Supplier = '#39'T'#39' AND tblclients.Active = '#39'T'#39')'
      'GROUP BY tblclients.Company'
      'ORDER BY tblclients.Company')
    AutoCalcFields = False
    Left = 262
    Top = 356
    object qryOwnersCompany: TWideStringField
      FieldName = 'Company'
      Size = 80
    end
    object qryOwnersSupplierID: TIntegerField
      FieldName = 'SupplierID'
    end
  end
  object dsOwners: TDataSource
    DataSet = qryOwners
    Left = 262
    Top = 391
  end
  object qryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeId, EmployeeName FROM tblEmployees')
    Left = 223
    Top = 356
  end
  object QrySalesLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'tblmanifestlines.GlobalRef,'
      'ManifestLineID,'
      'ManifestID, '
      'ETA, '
      'PageNo,'
      'PickupFrom,'
      'ShipTo,'
      'InvoiceDocNumber as InvoiceNumber,'
      'ProductName,'
      'tblparts.PREFEREDSUPP as PreferedSupplier,'
      'Product_Description,'
      'UnitofMeasureSaleLines as UnitOfMeasure,'
      'UnitofMeasureShipped as Qty,'
      'TotalLineAmountInc as Value,'
      'tblsaleslines.Attrib1Sale,'
      'tblsaleslines.Attrib2Sale,'
      'tblsaleslines.Attrib1SaleRate,'
      'tblsales.SaleID,'
      'tblsaleslines.SaleLineID,'
      'tblmanifestlines.EditedFlag'
      'FROM tblmanifestlines'
      'INNER JOIN tblsaleslines Using(SaleLineID)'
      'INNER JOIN tblsales Using(SaleID)'
      
        'inner join tblparts on tblsaleslines.ProductID = tblparts.PARTSI' +
        'D'
      'Where ManifestID = :ID'
      'ORDER BY tblsales.SaleID, tblsaleslines.SortID')
    BeforeOpen = QrySalesLookupBeforeOpen
    Left = 96
    Top = 348
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        Value = 11
      end>
    object QrySalesLookupGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblmanifestlines.GlobalRef'
      Size = 255
    end
    object QrySalesLookupManifestLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ManifestLineID'
      Origin = 'tblmanifestlines.ManifestLineID'
    end
    object QrySalesLookupManifestID: TIntegerField
      FieldName = 'ManifestID'
      Origin = 'tblmanifestlines.ManifestID'
    end
    object QrySalesLookupETA: TDateField
      FieldName = 'ETA'
      Origin = 'tblmanifestlines.ETA'
    end
    object QrySalesLookupPageNo: TIntegerField
      FieldName = 'PageNo'
      Origin = 'tblmanifestlines.PageNo'
    end
    object QrySalesLookupPickupFrom: TWideStringField
      FieldName = 'PickupFrom'
      Origin = 'tblsales.PickupFrom'
      Size = 255
    end
    object QrySalesLookupShipTo: TWideStringField
      FieldName = 'ShipTo'
      Origin = 'tblsales.ShipTo'
      Size = 255
    end
    object QrySalesLookupInvoiceNumber: TWideStringField
      FieldName = 'InvoiceNumber'
      Origin = 'tblsales.InvoiceDocNumber'
      Size = 30
    end
    object QrySalesLookupProductName: TWideStringField
      FieldName = 'ProductName'
      Origin = 'tblsaleslines.ProductName'
      Size = 60
    end
    object QrySalesLookupProduct_Description: TWideStringField
      FieldName = 'Product_Description'
      Origin = 'tblsaleslines.Product_Description'
      Size = 255
    end
    object QrySalesLookupUnitOfMeasure: TWideStringField
      FieldName = 'UnitOfMeasure'
      Origin = 'tblsaleslines.UnitofMeasureSaleLines'
      Size = 255
    end
    object QrySalesLookupQty: TFloatField
      FieldName = 'Qty'
      Origin = 'tblsaleslines.UnitofMeasureShipped'
    end
    object QrySalesLookupValue: TFloatField
      FieldName = 'Value'
      Origin = 'tblsaleslines.TotalLineAmountInc'
    end
    object QrySalesLookupAttrib1Sale: TFloatField
      FieldName = 'Attrib1Sale'
      Origin = 'tblsaleslines.Attrib1Sale'
    end
    object QrySalesLookupAttrib2Sale: TFloatField
      FieldName = 'Attrib2Sale'
      Origin = 'tblsaleslines.Attrib2Sale'
    end
    object QrySalesLookupAttrib1SaleRate: TFloatField
      FieldName = 'Attrib1SaleRate'
      Origin = 'tblsaleslines.Attrib1SaleRate'
    end
    object QrySalesLookupSaleID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleID'
      Origin = 'tblsales.SaleID'
    end
    object QrySalesLookupSaleLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleLineID'
      Origin = 'tblsaleslines.SaleLineID'
    end
    object QrySalesLookupEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblmanifestlines.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object QrySalesLookupPreferedSupplier: TWideStringField
      FieldName = 'PreferedSupplier'
      Origin = 'tblparts.PREFEREDSUPP'
      Size = 55
    end
  end
  object QryInvLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'tblmanifestlines.GlobalRef,'
      'ManifestLineID,'
      'ManifestID, '
      'ETA, '
      'PageNo,'
      'PickupFrom,'
      'ShipTo,'
      'InvoiceDocNumber as InvoiceNumber,'
      'ProductName,'
      'Product_Description,'
      'UnitofMeasureSaleLines as UnitOfMeasure,'
      'UnitofMeasureShipped as Qty,'
      'TotalLineAmountInc as Value,'
      'tblsaleslines.Attrib1Sale,'
      'tblsaleslines.Attrib2Sale,'
      'tblsaleslines.Attrib1SaleRate,'
      'tblsales.SaleID,'
      'tblsaleslines.SaleLineID,'
      'tblmanifestlines.EditedFlag'
      'FROM tblmanifestlines'
      
        'INNER JOIN tblsaleslines  on tblsaleslines.saleLineId = tblmanif' +
        'estlines.InvoiceLineID'
      'INNER JOIN tblsales Using(SaleID)'
      'Where ManifestID= :ID'
      'ORDER BY tblsales.SaleID, tblsaleslines.SortID')
    BeforeOpen = QryInvLookupBeforeOpen
    Left = 136
    Top = 348
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        Value = 11
      end>
    object QryInvLookupGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblmanifestlines.GlobalRef'
      Size = 255
    end
    object QryInvLookupManifestLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ManifestLineID'
      Origin = 'tblmanifestlines.ManifestLineID'
    end
    object QryInvLookupManifestID: TIntegerField
      FieldName = 'ManifestID'
      Origin = 'tblmanifestlines.ManifestID'
    end
    object QryInvLookupETA: TDateField
      FieldName = 'ETA'
      Origin = 'tblmanifestlines.ETA'
    end
    object QryInvLookupPageNo: TIntegerField
      FieldName = 'PageNo'
      Origin = 'tblmanifestlines.PageNo'
    end
    object QryInvLookupPickupFrom: TWideStringField
      FieldName = 'PickupFrom'
      Origin = 'tblsales.PickupFrom'
      Size = 255
    end
    object QryInvLookupShipTo: TWideStringField
      FieldName = 'ShipTo'
      Origin = 'tblsales.ShipTo'
      Size = 255
    end
    object QryInvLookupInvoiceNumber: TWideStringField
      FieldName = 'InvoiceNumber'
      Origin = 'tblsales.InvoiceDocNumber'
      Size = 30
    end
    object QryInvLookupProductName: TWideStringField
      FieldName = 'ProductName'
      Origin = 'tblsaleslines.ProductName'
      Size = 60
    end
    object QryInvLookupProduct_Description: TWideStringField
      FieldName = 'Product_Description'
      Origin = 'tblsaleslines.Product_Description'
      Size = 255
    end
    object QryInvLookupUnitOfMeasure: TWideStringField
      FieldName = 'UnitOfMeasure'
      Origin = 'tblsaleslines.UnitofMeasureSaleLines'
      Size = 255
    end
    object QryInvLookupQty: TFloatField
      FieldName = 'Qty'
      Origin = 'tblsaleslines.UnitofMeasureShipped'
    end
    object QryInvLookupValue: TFloatField
      FieldName = 'Value'
      Origin = 'tblsaleslines.TotalLineAmountInc'
    end
    object QryInvLookupAttrib1Sale: TFloatField
      FieldName = 'Attrib1Sale'
      Origin = 'tblsaleslines.Attrib1Sale'
    end
    object QryInvLookupAttrib2Sale: TFloatField
      FieldName = 'Attrib2Sale'
      Origin = 'tblsaleslines.Attrib2Sale'
    end
    object QryInvLookupAttrib1SaleRate: TFloatField
      FieldName = 'Attrib1SaleRate'
      Origin = 'tblsaleslines.Attrib1SaleRate'
    end
    object QryInvLookupSaleID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleID'
      Origin = 'tblsales.SaleID'
    end
    object QryInvLookupSaleLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'SaleLineID'
      Origin = 'tblsaleslines.SaleLineID'
    end
    object QryInvLookupEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblmanifestlines.EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
end
