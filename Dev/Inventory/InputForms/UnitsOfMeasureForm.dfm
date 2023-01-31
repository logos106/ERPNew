inherited UnitsOfMeasureGUI: TUnitsOfMeasureGUI
  Left = 2141
  Top = 115
  HelpContext = 541000
  Caption = 'Units Of Measure'
  ClientHeight = 509
  ClientWidth = 405
  OldCreateOrder = True
  ExplicitLeft = 2141
  ExplicitTop = 115
  ExplicitWidth = 421
  ExplicitHeight = 548
  DesignSize = (
    405
    509)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel3: TBevel [0]
    Left = 40
    Top = 267
    Width = 321
    Height = 41
    HelpContext = 541002
    Shape = bsFrame
  end
  object Bevel2: TBevel [1]
    Left = 40
    Top = 306
    Width = 321
    Height = 140
    HelpContext = 541029
    Shape = bsFrame
  end
  object Bevel1: TBevel [2]
    Left = 40
    Top = 76
    Width = 321
    Height = 193
    HelpContext = 541030
    Shape = bsFrame
  end
  object Label1: TLabel [3]
    Left = 54
    Top = 86
    Width = 22
    Height = 15
    HelpContext = 541003
    Caption = 'Unit'
    FocusControl = edtUnit
    Transparent = True
  end
  object Label2: TLabel [4]
    Left = 54
    Top = 196
    Width = 65
    Height = 15
    HelpContext = 541004
    Caption = 'Description'
    FocusControl = edtDesc
    Transparent = True
  end
  object Label3: TLabel [5]
    Left = 54
    Top = 149
    Width = 77
    Height = 15
    HelpContext = 541005
    Caption = 'Unit Multiplier'
    FocusControl = edtMultipleir
    Transparent = True
  end
  object Label4: TLabel [6]
    Left = 147
    Top = 171
    Width = 42
    Height = 15
    HelpContext = 541006
    Alignment = taCenter
    AutoSize = False
    Caption = 'of'
    FocusControl = edtMultipleir
    Transparent = True
    Visible = False
  end
  object Label11: TLabel [7]
    Left = 363
    Top = 466
    Width = 40
    Height = 17
    HelpContext = 541007
    Alignment = taCenter
    Anchors = [akRight, akBottom]
    AutoSize = False
    Caption = 'Active'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  inherited lblSkingroupMsg: TLabel
    Top = 509
    Width = 405
    HelpContext = 541025
    ExplicitTop = 509
    ExplicitWidth = 405
  end
  object Label5: TLabel [9]
    Left = 196
    Top = 85
    Width = 38
    Height = 15
    HelpContext = 541008
    Caption = 'Link to'
    FocusControl = edtUnit
    Transparent = True
  end
  object lblSalesDefault: TLabel [10]
    Left = 75
    Top = 246
    Width = 75
    Height = 15
    HelpContext = 541009
    Caption = 'Sales Default'
    Transparent = True
  end
  object lblPurchasesDefault: TLabel [11]
    Left = 233
    Top = 246
    Width = 105
    Height = 15
    HelpContext = 541010
    Caption = 'Purchases Default'
    Transparent = True
  end
  object Label121: TLabel [12]
    Left = 192
    Top = 123
    Width = 121
    Height = 31
    HelpContext = 541026
    Alignment = taCenter
    AutoSize = False
    Caption = 'If Left Blank Can be Used with All Products'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object lblDimension: TLabel [13]
    Left = 54
    Top = 314
    Width = 104
    Height = 15
    HelpContext = 541031
    Caption = 'Dimension  in  mm'
    FocusControl = edtUnit
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel [14]
    Left = 70
    Top = 345
    Width = 36
    Height = 15
    HelpContext = 541032
    Caption = 'Height'
    FocusControl = DBEdit2
    Transparent = True
  end
  object Label7: TLabel [15]
    Left = 177
    Top = 345
    Width = 33
    Height = 15
    HelpContext = 541033
    Caption = 'Width'
    FocusControl = DBEdit3
    Transparent = True
  end
  object Label8: TLabel [16]
    Left = 285
    Top = 345
    Width = 39
    Height = 15
    HelpContext = 541034
    Caption = 'Length'
    FocusControl = DBEdit4
    Transparent = True
  end
  object Label9: TLabel [17]
    Left = 69
    Top = 410
    Width = 42
    Height = 15
    HelpContext = 541035
    Caption = 'Volume'
    FocusControl = DBEdit5
    Transparent = True
  end
  object Label10: TLabel [18]
    Left = 54
    Top = 280
    Width = 40
    Height = 15
    HelpContext = 541036
    Caption = 'Weight'
    FocusControl = DBEdit6
    Transparent = True
  end
  object lblvolumeUOM: TLabel [19]
    Left = 252
    Top = 410
    Width = 21
    Height = 15
    HelpContext = 541037
    Caption = 'Mm'
    FocusControl = DBEdit5
    Transparent = True
  end
  object lblvolumeUOM1: TLabel [20]
    Left = 272
    Top = 405
    Width = 6
    Height = 14
    HelpContext = 541038
    Caption = '3'
    FocusControl = DBEdit5
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lblWeightUOM: TLabel [21]
    Left = 183
    Top = 280
    Width = 14
    Height = 15
    HelpContext = 541039
    Caption = 'kg'
    FocusControl = DBEdit5
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 541001
  end
  object Label12: TLabel [25]
    Left = 221
    Top = 280
    Width = 68
    Height = 15
    HelpContext = 541027
    Caption = 'No of Boxes'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object cboUnitOfMeasure: TwwDBLookupCombo [27]
    Left = 196
    Top = 167
    Width = 157
    Height = 23
    HelpContext = 541015
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'UnitName'#9'15'#9'Unit Name'#9'F')
    DataField = 'BaseUnitName'
    DataSource = dsUnitsOfMeasure
    LookupTable = qrycboUnitOfMeasure
    LookupField = 'UnitName'
    Style = csDropDownList
    ParentFont = False
    TabOrder = 3
    Visible = False
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = True
    OnCloseUp = cboUnitOfMeasureCloseUp
    OnNotInList = cboUnitOfMeasureNotInList
  end
  object edtUnit: TDBEdit [28]
    Left = 54
    Top = 101
    Width = 97
    Height = 23
    HelpContext = 541016
    DataField = 'UnitName'
    DataSource = dsUnitsOfMeasure
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object chkActive: TwwCheckBox [29]
    Left = 377
    Top = 480
    Width = 13
    Height = 16
    HelpContext = 541017
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
    NullAndBlankState = cbChecked
    Anchors = [akRight, akBottom]
    Checked = True
    DataField = 'Active'
    DataSource = dsUnitsOfMeasure
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    State = cbChecked
    TabOrder = 13
  end
  object edtDesc: TDBEdit [30]
    Left = 54
    Top = 211
    Width = 297
    Height = 23
    HelpContext = 541018
    DataField = 'UnitDescription'
    DataSource = dsUnitsOfMeasure
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object SalesDefault: TwwCheckBox [31]
    Left = 54
    Top = 245
    Width = 15
    Height = 16
    HelpContext = 541019
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
    DataField = 'SalesDefault'
    DataSource = dsUnitsOfMeasure
    TabOrder = 5
  end
  object PurchasesDefault: TwwCheckBox [32]
    Left = 216
    Top = 245
    Width = 15
    Height = 16
    HelpContext = 541020
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
    DataField = 'PurchasesDefault'
    DataSource = dsUnitsOfMeasure
    TabOrder = 6
  end
  object cboParts: TwwDBLookupCombo [33]
    Left = 196
    Top = 101
    Width = 154
    Height = 23
    HelpContext = 541021
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    Selected.Strings = (
      'PartName'#9'30'#9'Product'#9'F')
    DataField = 'PartID'
    DataSource = dsUnitsOfMeasure
    LookupTable = qryParts
    LookupField = 'PartsID'
    DropDownWidth = 300
    ParentFont = False
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = True
    OnChange = cboPartsChange
    OnDblClick = cboPartsDblClick
  end
  object pnlTitle: TDNMPanel [34]
    Left = 74
    Top = 6
    Width = 256
    Height = 45
    HelpContext = 541022
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 17
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 252
      Height = 41
      HelpContext = 541023
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
        Width = 252
        Height = 41
        HelpContext = 541024
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Units Of Measure'
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
  object DBEdit2: TDBEdit [35]
    Left = 70
    Top = 368
    Width = 68
    Height = 23
    HelpContext = 541040
    DataField = 'Height'
    DataSource = dsUnitsOfMeasure
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object DBEdit3: TDBEdit [36]
    Left = 177
    Top = 368
    Width = 68
    Height = 23
    HelpContext = 541041
    DataField = 'Width'
    DataSource = dsUnitsOfMeasure
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object DBEdit4: TDBEdit [37]
    Left = 285
    Top = 368
    Width = 68
    Height = 23
    HelpContext = 541042
    DataField = 'Length'
    DataSource = dsUnitsOfMeasure
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
  end
  object DBEdit5: TDBEdit [38]
    Left = 133
    Top = 406
    Width = 114
    Height = 23
    HelpContext = 541043
    DataField = 'Volume'
    DataSource = dsUnitsOfMeasure
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 12
  end
  object DBEdit6: TDBEdit [39]
    Left = 109
    Top = 276
    Width = 68
    Height = 23
    HelpContext = 541044
    DataField = 'Weight'
    DataSource = dsUnitsOfMeasure
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object btnCancel: TDNMSpeedButton [40]
    Left = 270
    Top = 468
    Width = 85
    Height = 27
    HelpContext = 541012
    Anchors = [akLeft, akBottom]
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
    TabOrder = 16
    AutoDisableParentOnclick = True
    OnClick = btnCancelClick
  end
  object btnSave: TDNMSpeedButton [41]
    Left = 44
    Top = 468
    Width = 87
    Height = 27
    HelpContext = 541011
    Anchors = [akLeft, akBottom]
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
    TabOrder = 14
    AutoDisableParentOnclick = True
    OnClick = btnSaveClick
  end
  object btnNew: TDNMSpeedButton [42]
    Left = 156
    Top = 468
    Width = 87
    Height = 27
    HelpContext = 541013
    Anchors = [akLeft, akBottom]
    Caption = '&New'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 15
    AutoDisableParentOnclick = True
    OnClick = btnNewClick
  end
  object wwDBSpinEdit1: TwwDBSpinEdit [43]
    Left = 295
    Top = 276
    Width = 58
    Height = 23
    HelpContext = 541028
    Increment = 1.000000000000000000
    DataField = 'NoOfBoxes'
    DataSource = dsUnitsOfMeasure
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    UnboundDataType = wwDefault
  end
  object edtMultipleir: TDBEdit [44]
    Left = 54
    Top = 167
    Width = 87
    Height = 23
    HelpContext = 541014
    DataField = 'Multiplier'
    DataSource = dsUnitsOfMeasure
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 57
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 39
    Top = 58
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 5
    Top = 2
  end
  inherited DataState: TDataState
    Left = 9
    Top = 33
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 70
    Top = 57
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102006C00740010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryUnitsOfMeasure: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblunitsofmeasure'
      'WHERE UnitID = :xUnitID')
    AfterOpen = qryUnitsOfMeasureAfterOpen
    BeforePost = qryUnitsOfMeasureBeforePost
    Left = 354
    Top = 9
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xUnitID'
      end>
    object qryUnitsOfMeasureUnitID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'UnitID'
      Origin = 'tblunitsofmeasure.UnitID'
      ReadOnly = True
    end
    object qryUnitsOfMeasureUnitName: TWideStringField
      FieldName = 'UnitName'
      Origin = 'tblunitsofmeasure.UnitName'
      Size = 15
    end
    object qryUnitsOfMeasureUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Origin = 'tblunitsofmeasure.UnitDescription'
      Size = 35
    end
    object qryUnitsOfMeasureMultiplier: TFloatField
      FieldName = 'Multiplier'
      Origin = 'tblunitsofmeasure.Multiplier'
      OnChange = qryUnitsOfMeasureMultiplierChange
    end
    object qryUnitsOfMeasureGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblunitsofmeasure.GlobalRef'
      Size = 255
    end
    object qryUnitsOfMeasureEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblunitsofmeasure.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryUnitsOfMeasureBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Origin = 'tblunitsofmeasure.BaseUnitName'
      OnChange = qryUnitsOfMeasureBaseUnitNameChange
      Size = 15
    end
    object qryUnitsOfMeasureActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblunitsofmeasure.Active'
      FixedChar = True
      Size = 1
    end
    object qryUnitsOfMeasurePartID: TIntegerField
      FieldName = 'PartID'
      Origin = 'tblunitsofmeasure.PartID'
      OnChange = qryUnitsOfMeasurePartIDChange
    end
    object qryUnitsOfMeasureBaseUnitID: TIntegerField
      FieldName = 'BaseUnitID'
      Origin = 'tblunitsofmeasure.BaseUnitID'
    end
    object qryUnitsOfMeasureSalesDefault: TWideStringField
      FieldName = 'SalesDefault'
      Origin = 'tblunitsofmeasure.SalesDefault'
      FixedChar = True
      Size = 1
    end
    object qryUnitsOfMeasurePurchasesDefault: TWideStringField
      FieldName = 'PurchasesDefault'
      Origin = 'tblunitsofmeasure.PurchasesDefault'
      FixedChar = True
      Size = 1
    end
    object qryUnitsOfMeasureHeight: TFloatField
      FieldName = 'Height'
      Origin = 'tblunitsofmeasure.Height'
      OnChange = qryUnitsOfMeasureHeightChange
    end
    object qryUnitsOfMeasureWidth: TFloatField
      FieldName = 'Width'
      Origin = 'tblunitsofmeasure.Width'
      OnChange = qryUnitsOfMeasureHeightChange
    end
    object qryUnitsOfMeasureLength: TFloatField
      FieldName = 'Length'
      Origin = 'tblunitsofmeasure.Length'
      OnChange = qryUnitsOfMeasureHeightChange
    end
    object qryUnitsOfMeasureWeight: TFloatField
      FieldName = 'Weight'
      Origin = 'tblunitsofmeasure.Weight'
    end
    object qryUnitsOfMeasureVolume: TFloatField
      FieldName = 'Volume'
      Origin = 'tblunitsofmeasure.Volume'
    end
    object qryUnitsOfMeasureUnitProductKeyName: TWideStringField
      FieldName = 'UnitProductKeyName'
      Size = 255
    end
    object qryUnitsOfMeasureNoOfBoxes: TIntegerField
      FieldName = 'NoOfBoxes'
    end
    object qryUnitsOfMeasureUseforAutoSplitQtyinSales: TWideStringField
      FieldName = 'UseforAutoSplitQtyinSales'
      FixedChar = True
      Size = 1
    end
  end
  object dsUnitsOfMeasure: TDataSource
    DataSet = qryUnitsOfMeasure
    Left = 354
    Top = 36
  end
  object memQryUnitsOfMeasure: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'UnitID'
        Attributes = [faReadonly, faFixed]
        DataType = ftAutoInc
      end
      item
        Name = 'UnitName'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'UnitDescription'
        DataType = ftString
        Size = 35
      end
      item
        Name = 'GlobalRef'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'EditedFlag'
        Attributes = [faFixed]
        DataType = ftFixedChar
        Size = 1
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 65533
    Top = 355
  end
  object qrycboUnitOfMeasure: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '/*SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND (ifnull(U.PartID,0) = :xPartID or ifnu' +
        'll(U.PartID,0) = 0)  and U.Multiplier = 1'
      'Group By U.UnitName Desc'
      'Order By UnitID desc ,U.UnitName'
      '*/'
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :xPartID and U.Mu' +
        'ltiplier = 1'
      'union all '
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and U.Multiplie' +
        'r = 1 and Unitname not  in (Select unitname from  tblunitsofmeas' +
        'ure where  ifnull(PartID,0) = :xPartID )'
      'Order By UnitID desc ,UnitName;')
    Left = 314
    Top = 157
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end>
    object qrycboUnitOfMeasureUnitName: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 15
      FieldName = 'UnitName'
      Size = 15
    end
    object qrycboUnitOfMeasureUnitID: TIntegerField
      FieldName = 'UnitID'
      Visible = False
    end
    object qrycboUnitOfMeasureMultiplier: TFloatField
      FieldName = 'Multiplier'
      Visible = False
    end
    object qrycboUnitOfMeasureUnitDescription: TWideStringField
      FieldName = 'UnitDescription'
      Visible = False
      Size = 35
    end
    object qrycboUnitOfMeasureBaseUnitName: TWideStringField
      FieldName = 'BaseUnitName'
      Visible = False
      Size = 15
    end
  end
  object qryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PartsID, PartName'
      'FROM tblParts'
      'WHERE Active = "T"'
      'Order By PartName;')
    Left = 316
    Top = 96
    object qryPartsPartName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 30
      FieldName = 'PartName'
      Origin = 'tblParts.PartName'
      Size = 60
    end
    object qryPartsPartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PartsID'
      Origin = 'tblParts.PartsID'
      Visible = False
    end
  end
  object dsParts: TDataSource
    DataSet = qryParts
    Left = 346
    Top = 97
  end
end
