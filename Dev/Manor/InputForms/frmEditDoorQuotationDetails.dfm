inherited frmEditDoorQuotationDetailsGUI: TfrmEditDoorQuotationDetailsGUI
  Left = 1554
  Top = 0
  HelpContext = 265000
  Caption = 'Edit Door Quotation Details'
  ClientHeight = 636
  ClientWidth = 754
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  DesignSize = (
    754
    636)
  PixelsPerInch = 96
  TextHeight = 15
  inherited Bevel1: TBevel
    Top = 92
    Width = 721
    Height = 493
    HelpContext = 265001
  end
  object Bevel8: TBevel [1]
    Left = 217
    Top = 349
    Width = 201
    Height = 73
    HelpContext = 265007
    Shape = bsFrame
  end
  object Bevel6: TBevel [2]
    Left = 432
    Top = 349
    Width = 137
    Height = 73
    HelpContext = 265008
    Shape = bsFrame
  end
  object Bevel2: TBevel [3]
    Left = 17
    Top = 136
    Width = 719
    Height = 9
    HelpContext = 265009
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label1: TLabel [4]
    Left = 32
    Top = 104
    Width = 54
    Height = 15
    HelpContext = 265010
    Caption = 'Order No:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblOrderNumber: TLabel [5]
    Left = 96
    Top = 104
    Width = 57
    Height = 15
    HelpContext = 265011
    AutoSize = False
    Caption = 'lblOrderNumber'
    Transparent = True
  end
  object Label2: TLabel [6]
    Left = 168
    Top = 104
    Width = 57
    Height = 15
    HelpContext = 265012
    Caption = 'Door Type'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [7]
    Left = 560
    Top = 104
    Width = 48
    Height = 15
    HelpContext = 265013
    Caption = 'Door No:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object lblDoorNumber: TLabel [8]
    Left = 616
    Top = 104
    Width = 57
    Height = 15
    HelpContext = 265014
    AutoSize = False
    Caption = 'lblOrderNumber'
    Transparent = True
    Visible = False
  end
  object Bevel3: TBevel [9]
    Left = 582
    Top = 152
    Width = 138
    Height = 273
    HelpContext = 265015
  end
  object Bevel4: TBevel [10]
    Left = 281
    Top = 158
    Width = 291
    Height = 97
    HelpContext = 265016
    Shape = bsFrame
  end
  object Label4: TLabel [11]
    Left = 350
    Top = 166
    Width = 64
    Height = 15
    HelpContext = 265017
    Caption = 'Door 1 Size'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel [12]
    Left = 473
    Top = 166
    Width = 64
    Height = 15
    HelpContext = 265018
    Caption = 'Door 2 Size'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [13]
    Left = 297
    Top = 192
    Width = 33
    Height = 15
    HelpContext = 265020
    Caption = 'Width'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel [14]
    Left = 297
    Top = 224
    Width = 36
    Height = 15
    HelpContext = 265021
    Caption = 'Height'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label10: TLabel [15]
    Left = 419
    Top = 192
    Width = 22
    Height = 15
    HelpContext = 265024
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label11: TLabel [16]
    Left = 419
    Top = 224
    Width = 22
    Height = 15
    HelpContext = 265025
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label12: TLabel [17]
    Left = 542
    Top = 192
    Width = 22
    Height = 15
    HelpContext = 265026
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label13: TLabel [18]
    Left = 542
    Top = 224
    Width = 22
    Height = 15
    HelpContext = 265027
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label14: TLabel [19]
    Left = 232
    Top = 364
    Width = 59
    Height = 15
    HelpContext = 265028
    Caption = 'Thickness'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label15: TLabel [20]
    Left = 368
    Top = 364
    Width = 22
    Height = 15
    HelpContext = 265029
    Caption = 'mm'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblfinish: TLabel [21]
    Left = 170
    Top = 304
    Width = 78
    Height = 15
    HelpContext = 265032
    Caption = 'Special Finish'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label19: TLabel [22]
    Left = 448
    Top = 366
    Width = 45
    Height = 15
    HelpContext = 265033
    Caption = 'Number'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label20: TLabel [23]
    Left = 368
    Top = 104
    Width = 37
    Height = 15
    HelpContext = 265034
    Caption = 'Facing'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label21: TLabel [24]
    Left = 558
    Top = 476
    Width = 89
    Height = 15
    HelpContext = 265035
    Caption = 'Delivery Charge'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label22: TLabel [25]
    Left = 557
    Top = 508
    Width = 90
    Height = 15
    HelpContext = 265036
    Caption = 'Profit Added (%)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblTotalcost: TLabel [26]
    Left = 590
    Top = 540
    Width = 57
    Height = 15
    HelpContext = 265037
    Caption = 'Total Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label24: TLabel [27]
    Left = 32
    Top = 444
    Width = 157
    Height = 15
    HelpContext = 265038
    Caption = 'Door Types and References'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label25: TLabel [28]
    Left = 232
    Top = 394
    Width = 26
    Height = 15
    HelpContext = 265039
    Caption = 'Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label26: TLabel [29]
    Left = 170
    Top = 274
    Width = 60
    Height = 15
    HelpContext = 265040
    Caption = 'Fire Rating'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label27: TLabel [30]
    Left = 448
    Top = 396
    Width = 26
    Height = 15
    HelpContext = 265041
    Caption = 'Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label28: TLabel [31]
    Left = 432
    Top = 333
    Width = 77
    Height = 15
    HelpContext = 265042
    Caption = 'Plyseal Coats'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label30: TLabel [32]
    Left = 217
    Top = 333
    Width = 89
    Height = 15
    HelpContext = 265045
    Caption = 'Door Thickness'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label18: TLabel [33]
    Left = 393
    Top = 304
    Width = 105
    Height = 15
    HelpContext = 265040
    Alignment = taRightJustify
    Caption = 'Special finish Cost'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label16: TLabel [34]
    Left = 32
    Top = 273
    Width = 56
    Height = 15
    HelpContext = 265030
    Caption = 'Door Cost'
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel [35]
    Left = 558
    Top = 444
    Width = 89
    Height = 15
    HelpContext = 265035
    Caption = 'Basic door cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label31: TLabel [36]
    Left = 31
    Top = 333
    Width = 85
    Height = 15
    HelpContext = 265046
    Caption = 'Door Wrapping'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label29: TLabel [37]
    Left = 47
    Top = 393
    Width = 26
    Height = 15
    HelpContext = 265044
    Caption = 'Cost'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel7: TBevel [38]
    Left = 31
    Top = 349
    Width = 181
    Height = 73
    HelpContext = 265043
    Shape = bsFrame
  end
  inherited pnlHeader: TPanel
    Left = 140
    Width = 473
    HelpContext = 265002
    TabOrder = 34
    inherited TitleShader: TShader
      Width = 471
      HelpContext = 265003
      inherited TitleLabel: TLabel
        Width = 471
        HelpContext = 265004
        Caption = 'Edit Door Quotation Details'
      end
    end
  end
  inherited btnSave: TDNMSpeedButton
    Left = 228
    Top = 594
    HelpContext = 265005
    TabOrder = 32
  end
  inherited btnCancel: TDNMSpeedButton
    Left = 433
    Top = 594
    HelpContext = 265006
    TabOrder = 33
  end
  object cboDoorType: TwwDBLookupCombo
    Left = 232
    Top = 100
    Width = 121
    Height = 23
    HelpContext = 265047
    DropDownAlignment = taLeftJustify
    LookupTable = qryDoorType
    LookupField = 'ShortType'
    Style = csDropDownList
    DropDownWidth = 121
    TabOrder = 0
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object rdgDoorPairing: TwwRadioGroup
    Left = 152
    Top = 155
    Width = 122
    Height = 97
    HelpContext = 265048
    TransparentActiveItem = True
    Indents.TextX = 3
    Transparent = True
    Caption = 'Door Pairing'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'Single'
      'Pair'
      'Eccentric Pair')
    ParentFont = False
    TabOrder = 3
  end
  object btnFireRatingDetails: TDNMSpeedButton
    Left = 590
    Top = 235
    Width = 121
    Height = 28
    HelpContext = 265049
    Caption = 'Fire Rating Details'
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
    HotTrackFont.Style = []
    ParentFont = False
    TabOrder = 27
    OnClick = btnFireRatingDetailsClick
  end
  object edtDoorOneWidth: TAdvEdit
    Left = 350
    Top = 188
    Width = 65
    Height = 23
    HelpContext = 265050
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 4
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtDoorOneHeight: TAdvEdit
    Left = 350
    Top = 220
    Width = 65
    Height = 23
    HelpContext = 265051
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 5
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtDoorTwoWidth: TAdvEdit
    Left = 473
    Top = 188
    Width = 65
    Height = 23
    HelpContext = 265052
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 6
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtDoorTwoHeight: TAdvEdit
    Left = 473
    Top = 220
    Width = 65
    Height = 23
    HelpContext = 265053
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 7
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtDoorThickness: TAdvEdit
    Left = 296
    Top = 360
    Width = 65
    Height = 23
    HelpContext = 265054
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 15
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object btnOverPanels: TDNMSpeedButton
    Left = 590
    Top = 159
    Width = 121
    Height = 28
    HelpContext = 265056
    Caption = 'Overpanels'
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
    HotTrackFont.Style = []
    ParentFont = False
    TabOrder = 25
    OnClick = btnOverPanelsClick
  end
  object btnLippingsStiles: TDNMSpeedButton
    Left = 590
    Top = 197
    Width = 121
    Height = 28
    HelpContext = 265057
    Caption = 'Lippings/Stiles'
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
    HotTrackFont.Style = []
    ParentFont = False
    TabOrder = 26
    OnClick = btnLippingsStilesClick
  end
  object btnLaminatedFaces: TDNMSpeedButton
    Left = 590
    Top = 273
    Width = 121
    Height = 28
    HelpContext = 265058
    Caption = 'Laminated Faces'
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
    HotTrackFont.Style = []
    ParentFont = False
    TabOrder = 28
    OnClick = btnLaminatedFacesClick
  end
  object btnVeneerDetails: TDNMSpeedButton
    Left = 590
    Top = 311
    Width = 121
    Height = 28
    HelpContext = 265059
    Caption = 'Veneer Details'
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
    HotTrackFont.Style = []
    ParentFont = False
    TabOrder = 29
    OnClick = btnVeneerDetailsClick
  end
  object btnGlass: TDNMSpeedButton
    Left = 590
    Top = 349
    Width = 121
    Height = 28
    HelpContext = 265060
    Caption = 'Glass'
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
    HotTrackFont.Style = []
    ParentFont = False
    TabOrder = 30
    OnClick = btnGlassClick
  end
  object btnJoinery: TDNMSpeedButton
    Left = 590
    Top = 388
    Width = 121
    Height = 28
    HelpContext = 265061
    Caption = 'Joinery'
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
    HotTrackFont.Style = []
    ParentFont = False
    TabOrder = 31
    OnClick = btnJoineryClick
  end
  object cboSpecialFinish: TwwDBLookupCombo
    Left = 257
    Top = 300
    Width = 97
    Height = 23
    HelpContext = 265063
    DropDownAlignment = taLeftJustify
    LookupTable = qryFinish
    LookupField = 'FinishName'
    Style = csDropDownList
    TabOrder = 11
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = True
    OnCloseUp = cboSpecialFinishCloseUp
    OnExit = cboSpecialFinishExit
  end
  object edtPlysealCoatsNum: TAdvEdit
    Left = 504
    Top = 362
    Width = 49
    Height = 23
    HelpContext = 265065
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 17
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object cboFacing: TwwDBLookupCombo
    Left = 416
    Top = 100
    Width = 129
    Height = 23
    HelpContext = 265066
    DropDownAlignment = taLeftJustify
    LookupTable = qryFacing
    LookupField = 'Finish'
    Style = csDropDownList
    DropDownWidth = 129
    TabOrder = 1
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object chkFinishCostExtra: TwwCheckBox
    Left = 396
    Top = 272
    Width = 124
    Height = 19
    HelpContext = 265067
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Finish Cost Extra'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = chkFinishCostExtraClick
  end
  object edtDeliveryCharge: TAdvEdit
    Left = 655
    Top = 472
    Width = 65
    Height = 23
    HelpContext = 265068
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 22
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtProfitAdded: TAdvEdit
    Left = 655
    Top = 504
    Width = 65
    Height = 23
    HelpContext = 265069
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 23
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtTotalCost: TAdvEdit
    Left = 655
    Top = 536
    Width = 65
    Height = 23
    HelpContext = 265070
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 24
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object chkManualPrice: TwwCheckBox
    Left = 448
    Top = 442
    Width = 97
    Height = 19
    HelpContext = 265071
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Manual Price'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 20
    OnClick = chkManualPriceClick
  end
  object memDoorTypesRefs: TMemo
    Left = 32
    Top = 472
    Width = 513
    Height = 89
    HelpContext = 265072
    TabOrder = 19
  end
  object edtThickerDoorsAddCost: TAdvEdit
    Left = 296
    Top = 390
    Width = 65
    Height = 23
    HelpContext = 265073
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 16
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object cboFireRating: TwwDBLookupCombo
    Left = 257
    Top = 270
    Width = 97
    Height = 23
    HelpContext = 265074
    DropDownAlignment = taLeftJustify
    LookupTable = qryFireRating
    LookupField = 'FireRating'
    Style = csDropDownList
    TabOrder = 8
    AutoDropDown = False
    ShowButton = True
    AllowClearKey = False
  end
  object edtPlysealCoatsCost: TAdvEdit
    Left = 504
    Top = 392
    Width = 49
    Height = 23
    HelpContext = 265076
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 18
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object rdgDoorPlacement: TwwRadioGroup
    Left = 32
    Top = 156
    Width = 110
    Height = 97
    HelpContext = 265077
    TransparentActiveItem = True
    Indents.TextX = 3
    Transparent = True
    Caption = 'Door Placement'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'Internal'
      'External')
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object edtspecialfinishcost: TAdvEdit
    Left = 504
    Top = 300
    Width = 65
    Height = 23
    HelpContext = 265053
    EditAlign = eaRight
    EditType = etNumeric
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 12
    Text = '0'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtDoorCost: TAdvEdit
    Left = 32
    Top = 293
    Width = 65
    Height = 23
    HelpContext = 265055
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = False
    TabOrder = 10
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object edtBasicDoorCost: TAdvEdit
    Left = 655
    Top = 440
    Width = 65
    Height = 23
    HelpContext = 265068
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 21
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object chkWrapDoors: TwwCheckBox
    Left = 47
    Top = 361
    Width = 89
    Height = 19
    HelpContext = 265064
    AlwaysTransparent = True
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.FocusBorders = []
    Frame.NonFocusBorders = []
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Caption = 'Wrap Doors'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
  object edtWrapDoorsCost: TAdvEdit
    Left = 120
    Top = 389
    Width = 49
    Height = 23
    HelpContext = 265075
    EditAlign = eaRight
    EditType = etFloat
    Precision = 2
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'MS Sans Serif'
    LabelFont.Style = []
    Lookup.Separator = ';'
    Color = clWindow
    Enabled = True
    TabOrder = 14
    Text = '0.00'
    Visible = True
    Version = '2.7.5.0'
  end
  object qryFinish: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW * '
      'FROM vwDoorFinishList'
      'WHERE Left(FinishName, 2) <> '#39'FR'#39';')
    Left = 624
    Top = 16
  end
  object qryDoorType: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW ShortType '
      'FROM vwDoorDEtailList'
      
        'WHERE (InternalExternal = :InternalExternal) AND (Left(DoorType,' +
        ' 3) = '#39'MRK'#39') AND (Active = "T")'
      'ORDER BY ShortType')
    Left = 656
    Top = 16
    ParamData = <
      item
        DataType = ftString
        Name = 'InternalExternal'
      end>
  end
  object qryFacing: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW Finish'
      'FROM vwDoorDEtailList'
      
        'WHERE (ShortType = :DoorType) AND (InternalExternal = :InternalE' +
        'xternal) AND (Active = "T")'
      'ORDER BY Finish;')
    Left = 624
    Top = 48
    ParamData = <
      item
        DataType = ftString
        Name = 'DoorType'
      end
      item
        DataType = ftString
        Name = 'InternalExternal'
      end>
  end
  object qryFireRating: TERPQuery
    SQL.Strings = (
      'SELECT FireRating'
      'FROM vwdoorfireratinglist;')
    Left = 656
    Top = 48
  end
  object MyQuery1: TERPQuery
    SQL.Strings = (
      'SELECT DISTINCTROW * '
      'FROM vwDoorFinishList'
      'WHERE Left(FinishName, 2) <> '#39'FR'#39';')
    Left = 592
    Top = 16
  end
end
