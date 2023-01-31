inherited frmPickingSlipsPrn: TfrmPickingSlipsPrn
  Left = 1398
  Top = 269
  HelpContext = 326000
  Caption = 'Print Picking Slips'
  ClientHeight = 541
  ClientWidth = 681
  OldCreateOrder = True
  ExplicitLeft = 1398
  ExplicitTop = 269
  ExplicitWidth = 697
  ExplicitHeight = 580
  DesignSize = (
    681
    541)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 541
    Width = 681
    ExplicitTop = 541
    ExplicitWidth = 681
    HelpContext = 326033
  end
  object Bevel1: TBevel [1]
    Left = 6
    Top = 161
    Width = 671
    Height = 285
    HelpContext = 326002
  end
  object Label3: TLabel [2]
    Left = 228
    Top = 425
    Width = 231
    Height = 15
    HelpContext = 326003
    Caption = 'Hold down Ctrl and click to toggle Invoice'
    Transparent = True
  end
  object Label4: TLabel [3]
    Left = 62
    Top = 450
    Width = 559
    Height = 19
    HelpContext = 326004
    Alignment = taCenter
    AutoSize = False
    Caption = 'Emailing, Please Wait.... '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
  end
  object Label1: TLabel [4]
    Left = 23
    Top = 69
    Width = 29
    Height = 15
    HelpContext = 326005
    Caption = 'From'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [5]
    Left = 226
    Top = 69
    Width = 13
    Height = 15
    HelpContext = 326006
    Caption = 'To'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label42: TLabel [6]
    Left = 572
    Top = 71
    Width = 76
    Height = 15
    HelpContext = 326008
    Caption = 'Show Printed'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 326001
  end
  object btnAddFilter: TDNMSpeedButton [11]
    Left = 5
    Top = 128
    Width = 97
    Height = 27
    HelpContext = 326017
    Caption = '&Add To Filter'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
      000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000
      00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000000000
      1F7C1F7C1F7C1F7C1F7C1F7CEF3D000000000000EF3D1F7CE07FEF3D00001F7C
      1F7C1F7C1F7C1F7C1F7C0000EF3DEF3DEF3DEF3DEF3D00000000E07F1F7C1F7C
      1F7C1F7C1F7C1F7C0000EF3DFF7FF75EFF7FF75EFF7FEF3D00001F7C1F7C1F7C
      1F7C1F7C1F7CEF3DEF3DFF7FF75EFF7F007CFF7FF75EFF7FEF3DEF3D1F7C1F7C
      1F7C1F7C1F7C0000EF3DF75EFF7FF75E007CF75EFF7FF75EEF3D00001F7C1F7C
      1F7C1F7C1F7C0000EF3DFF7F007C007C007C007C007CFF7FEF3D00001F7C1F7C
      1F7C1F7C1F7C0000EF3DF75EFF7FF75E007CF75EFF7FF75EEF3D00001F7C1F7C
      1F7C1F7C1F7CEF3DEF3DFF7FF75EFF7F007CFF7FF75EFF7FEF3DEF3D1F7C1F7C
      1F7C1F7C1F7C1F7C0000EF3DFF7FF75EFF7FF75EFF7FEF3D00001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C0000EF3DEF3DEF3DEF3DEF3D00001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7CEF3D000000000000EF3D1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    AutoDisableParentOnclick = True
    OnClick = btnAddFilterClick
  end
  object btnExecute: TDNMSpeedButton [12]
    Left = 104
    Top = 128
    Width = 97
    Height = 27
    HelpContext = 326018
    Caption = '&Execute Filter'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C00001F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C007C00001F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C007C00001F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C007C007C007C007C007C00001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C007C007C007C007C007C007C00001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7CEF3D007C007C00001F7C007C007C007C00001F7C1F7C1F7C
      1F7C1F7C1F7CEF3D007C00001F7C1F7C1F7C1F7C007C007C00001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C007C00001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C00001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C007C007C00001F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CEF3D007C0000
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CEF3D007C
      00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      007C007C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    AutoDisableParentOnclick = True
    OnClick = btnExecuteClick
  end
  object btnClear: TDNMSpeedButton [13]
    Left = 203
    Top = 128
    Width = 97
    Height = 27
    HelpContext = 326019
    Caption = '&Clear Filter'
    DisableTransparent = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C00000000000000001F7C0000000000001F7C1F7C1F7C1F7C
      1F7C1F7C1F7C000000000000000000000000000000001F7C1F7C1F7C00001F7C
      1F7C1F7C1F7C000000001F7C1F7C0000000000001F7C1F7C00001F7C1F7C1F7C
      1F7C1F7C1F7C000000001F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C000000001F7C1F7C000000001F7C000000001F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C000000001F7C00001F7C00000040004000001F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C0000007C007C007C004000001F7C
      1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C0000007C007C007C007C00400000
      1F7C1F7C1F7C1F7C000000001F7C00001F7C1F7C0000007C007C007C00000042
      00001F7C1F7C1F7C1F7C000000001F7C00001F7C1F7C0000007C0000E07F0000
      004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07F0000E07F
      0000004200001F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C0000E07F0000
      E07F004200421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07F
      E07FE07F00421F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
      E07FE07FE07F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      0000E07FE07F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C0000E07F}
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    AutoDisableParentOnclick = True
    OnClick = btnClearClick
  end
  object dtFrom: TDateTimePicker [14]
    Left = 55
    Top = 66
    Width = 129
    Height = 23
    HelpContext = 326020
    Date = 37441.582759976900000000
    Time = 37441.582759976900000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnChange = dtFromChange
  end
  object dtTo: TDateTimePicker [15]
    Left = 242
    Top = 66
    Width = 129
    Height = 23
    HelpContext = 326021
    Date = 37441.582972777800000000
    Time = 37441.582972777800000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnChange = dtFromChange
  end
  object chkPrintFlag: TCheckBox [16]
    Left = 552
    Top = 72
    Width = 14
    Height = 16
    HelpContext = 326023
    Checked = True
    State = cbChecked
    TabOrder = 9
    OnClick = chkPrintFlagClick
  end
  object btnClose: TDNMSpeedButton [17]
    Left = 302
    Top = 509
    Width = 87
    Height = 27
    HelpContext = 326024
    Caption = '&Close'
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
    TabOrder = 10
    AutoDisableParentOnclick = True
    OnClick = btnCloseClick
  end
  object btnSend: TDNMSpeedButton [18]
    Left = 105
    Top = 472
    Width = 87
    Height = 27
    HelpContext = 326025
    Caption = 'Auto Send'
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
    TabOrder = 11
    AutoDisableParentOnclick = True
    OnClick = btnPreviewClick
  end
  object btnPreview: TDNMSpeedButton [19]
    Left = 203
    Top = 472
    Width = 87
    Height = 27
    HelpContext = 326026
    Caption = 'Pre&view'
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
    TabOrder = 12
    AutoDisableParentOnclick = True
    OnClick = btnPreviewClick
  end
  object btnPrint: TDNMSpeedButton [20]
    Left = 301
    Top = 471
    Width = 87
    Height = 27
    HelpContext = 326027
    Caption = 'Prin&t'
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
    TabOrder = 13
    AutoDisableParentOnclick = True
    OnClick = btnPreviewClick
  end
  object btnFax: TDNMSpeedButton [21]
    Left = 401
    Top = 472
    Width = 87
    Height = 27
    HelpContext = 326028
    Caption = '&Fax'
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
    TabOrder = 14
    AutoDisableParentOnclick = True
    OnClick = btnPreviewClick
  end
  object btnEmail: TDNMSpeedButton [22]
    Left = 500
    Top = 472
    Width = 87
    Height = 27
    HelpContext = 326029
    Caption = '&Email'
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
    TabOrder = 15
    AutoDisableParentOnclick = True
    OnClick = btnPreviewClick
  end
  object pnlTitle: TDNMPanel [23]
    Left = 202
    Top = 6
    Width = 281
    Height = 45
    HelpContext = 326030
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 277
      Height = 41
      HelpContext = 326031
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
        Width = 277
        Height = 41
        HelpContext = 326032
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Print Picking Slips'
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
  object grpFilters: TwwRadioGroup [24]
    Left = 323
    Top = 123
    Width = 353
    Height = 33
    DisableThemes = False
    ItemIndex = 0
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Items.Strings = (
      'Summary'
      'Details')
    ParentFont = False
    TabOrder = 17
    OnClick = grpFiltersClick
    HelpContext = 326034
  end
  object btnSelect: TDNMSpeedButton [25]
    Left = 232
    Top = 396
    Width = 87
    Height = 27
    HelpContext = 326010
    Caption = '&Select All'
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
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = btnSelectClick
  end
  object grd: TwwDBGrid [26]
    Left = 12
    Top = 167
    Width = 656
    Height = 225
    HelpContext = 326009
    ControlType.Strings = (
      'PrintFlag;CheckBox;T;F'
      'PickPrintFlag;CheckBox;T;F')
    Selected.Strings = (
      'Sale Date'#9'10'#9'Sale Date'#9'F'
      'SaleID'#9'5'#9'SaleID'#9'F'
      'Product Name'#9'25'#9'Product Name'#9'F'
      'Sales Description'#9'20'#9'Sales Description'#9'F'
      'Type'#9'11'#9'Type'#9'F'
      'PickPrintFlag'#9'5'#9'Printed'#9'F'
      'FirstColumn'#9'20'#9'First Column'#9'F'
      'SecondColumn'#9'20'#9'Second Column'#9'F'
      'ThirdColumn'#9'20'#9'Third Column'#9'F'
      'Comments'#9'20'#9'Comments'#9'F'
      'Shipping'#9'20'#9'Shipping'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    OnMultiSelectRecord = grdMultiSelectRecord
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akRight]
    DataSource = DSPickSlips
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MultiSelectOptions = [msoShiftSelect]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    ParentFont = False
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = True
    UseTFields = False
    OnCalcCellColors = grdCalcCellColors
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
  end
  object btnUnselect: TDNMSpeedButton [27]
    Left = 369
    Top = 396
    Width = 87
    Height = 27
    HelpContext = 326011
    Caption = '&Unselect All'
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
    AutoDisableParentOnclick = True
    OnClick = btnUnselectClick
  end
  object DNMPanel1: TDNMPanel [28]
    Left = 5
    Top = 92
    Width = 672
    Height = 30
    HelpContext = 326012
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      672
      30)
    object Label5: TLabel
      Left = 3
      Top = 8
      Width = 88
      Height = 16
      HelpContext = 326013
      AutoSize = False
      Caption = 'Search Column'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label6: TLabel
      Left = 356
      Top = 8
      Width = 72
      Height = 15
      HelpContext = 326014
      AutoSize = False
      Caption = 'Search Text'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object cboFilter: TComboBox
      Left = 93
      Top = 4
      Width = 146
      Height = 23
      HelpContext = 326015
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object edtSearch: TEdit
      Left = 426
      Top = 4
      Width = 240
      Height = 23
      Hint = '"Type In What To Filter This Column By"'
      HelpContext = 326016
      TabStop = False
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003000480010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryPickSlip: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '##dummy Query'
      'SELECT distinct 2 as Category, PARTNAME as '#39'Product Name'#39', '
      
        'if((LOCATE('#39'^'#39',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'#39'^'#39')+1)) >0, ' +
        'MID(P.PRODUCTGROUP,LOCATE('#39'^'#39',P.PRODUCTGROUP, InStr(P.PRODUCTGRO' +
        'UP,'#39'^'#39')+1)+1,   char_length(P.PRODUCTGROUP)- LOCATE('#39'^'#39',P.PRODUC' +
        'TGROUP,InStr(P.PRODUCTGROUP,'#39'^'#39')+1)),   Null)  AS '#39'ThirdColumn'#39' ' +
        ','
      
        'MID(P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'#39'^'#39')+1 ,   If(LOCATE('#39'^'#39 +
        ',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'#39'^'#39')+1) - InStr(P.PRODUCTGR' +
        'OUP,'#39'^'#39') >0,   LOCATE('#39'^'#39',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'#39'^' +
        #39')+1)-1 - InStr(P.PRODUCTGROUP,'#39'^'#39'),    IF(InStr(P.PRODUCTGROUP,' +
        #39'^'#39')<>0,char_length(P.PRODUCTGROUP) - InStr(P.PRODUCTGROUP,'#39'^'#39'),' +
        '0)))   AS '#39'SecondColumn'#39' ,   '
      
        'If(InStr(P.PRODUCTGROUP,'#39'^'#39') -1 >0,Left(P.PRODUCTGROUP,InStr(P.P' +
        'RODUCTGROUP,'#39'^'#39')-1),   P.PRODUCTGROUP) AS '#39'FirstColumn'#39' ,'
      'P.PARTSDESCRIPTION as '#39'Sales Description'#39',   '
      'S.SaleID, S.SaleDate AS '#39'Sale Date'#39',   '
      'S.isCashSale, '
      'S.isInvoice,'
      'S.ISSalesOrder,'
      'S.IsPos,'
      'S.ISQuote,'
      'CASE WHEN S.isCashSale = '#39'T'#39' THEN '#39'CashSale'#39'        '
      '     WHEN S.isInvoice = '#39'T'#39' THEN '#39'Invoice'#39' '
      '     WHEN S.ISSalesOrder = '#39'T'#39' THEN '#39'Sales Order'#39' '
      '     WHEN S.IsPos  = '#39'T'#39' THEN '#39'POS Sale'#39
      '     WHEN S.ISQuote = '#39'T'#39' THEN '#39'Quote'#39'  END AS Type,   '
      'S.Shipping,S.ClientID, S.Comments , '
      
        'ifnull(tblPrintDocs.docId , '#39'F'#39') PickPrintFlag,S.CustomerName,S.' +
        'GlobalRef'
      'FROM tblparts AS P '
      'INNER JOIN tblSalesLines AS SL ON P.PartsID = SL.ProductID '
      'INNER JOIN tblSales AS S ON S.SaleID = SL.SaleID '
      
        'left join tblPrintDocs on tblPrintDocs.docId = SL.SaleId and tbl' +
        'PrintDocs.DocName = '#39'TPickingSlip'#39
      'WHERE S.SaleDate Between '#39'2008/01/01'#39' and  '#39'2008/01/01'#39
      'AND ifnull(tblPrintDocs.DocId ,'#39'F'#39') <>  '#39't'#39
      'union all '
      'SELECT distinct 1 as Category, "", "","" ,   "" ,"",   '
      'S.SaleID, S.SaleDate AS '#39'Sale Date'#39',   '
      'S.isCashSale, '
      'S.isInvoice,'
      'S.ISSalesOrder,'
      'S.IsPos,'
      'S.ISQuote,'
      'CASE WHEN S.isCashSale = '#39'T'#39' THEN '#39'CashSale'#39'        '
      '     WHEN S.isInvoice = '#39'T'#39' THEN '#39'Invoice'#39' '
      '     WHEN S.ISSalesOrder = '#39'T'#39' THEN '#39'Sales Order'#39' '
      '     WHEN S.IsPos  = '#39'T'#39' THEN '#39'POS Sale'#39
      '     WHEN S.ISQuote = '#39'T'#39' THEN '#39'Quote'#39'  END AS Type,   '
      
        'S.Shipping,S.ClientID, S.Comments , if(isnull(tblPrintDocs.docId' +
        ') , '#39'F'#39' , '#39'T'#39') PickPrintFlag,S.CustomerName,S.GlobalRef'
      'FROM tblparts AS P '
      'INNER JOIN tblSalesLines AS SL ON P.PartsID = SL.ProductID '
      'INNER JOIN tblSales AS S ON S.SaleID = SL.SaleID '
      
        'left join tblPrintDocs on tblPrintDocs.docId = SL.SaleId and tbl' +
        'PrintDocs.DocName = '#39'TPickingSlip'#39
      'WHERE S.SaleDate Between '#39'2008/01/01'#39' and  '#39'2008/01/01'#39
      'AND ifnull(tblPrintDocs.DocId ,'#39'F'#39') <>  '#39't'#39
      'ORDER BY Category , SaleID, Type')
    Left = 554
    Top = 6
    object qryPickSlipProductName: TWideStringField
      FieldName = 'Product Name'
      Size = 60
    end
    object qryPickSlipThirdColumn: TWideStringField
      FieldName = 'ThirdColumn'
      Size = 255
    end
    object qryPickSlipSecondColumn: TWideStringField
      FieldName = 'SecondColumn'
      Size = 255
    end
    object qryPickSlipFirstColumn: TWideStringField
      FieldName = 'FirstColumn'
      Size = 255
    end
    object qryPickSlipSalesDescription: TWideStringField
      FieldName = 'Sales Description'
      Size = 255
    end
    object qryPickSlipSaleID: TIntegerField
      FieldName = 'SaleID'
    end
    object qryPickSlipSaleDate: TDateField
      FieldName = 'Sale Date'
    end
    object qryPickSlipType: TWideStringField
      FieldName = 'Type'
      Size = 11
    end
    object qryPickSlipShipping: TWideStringField
      FieldName = 'Shipping'
      Size = 255
    end
    object qryPickSlipComments: TWideMemoField
      FieldName = 'Comments'
      BlobType = ftWideMemo
    end
    object qryPickSlipPickPrintFlag: TWideStringField
      FieldName = 'PickPrintFlag'
      FixedChar = True
      Size = 1
    end
    object qryPickSlipClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryPickSlipCustomerName: TWideStringField
      FieldName = 'CustomerName'
    end
    object qryPickSlipGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
    end
    object qryPickSlipCategory: TLargeintField
      FieldName = 'Category'
    end
    object qryPickSlipisCashSale: TWideStringField
      FieldName = 'isCashSale'
      Size = 1
    end
    object qryPickSlipisInvoice: TWideStringField
      FieldName = 'isInvoice'
      Size = 1
    end
    object qryPickSlipISSalesOrder: TWideStringField
      FieldName = 'ISSalesOrder'
      Size = 1
    end
    object qryPickSlipIsPos: TWideStringField
      FieldName = 'IsPos'
      Size = 1
    end
    object qryPickSlipISQuote: TWideStringField
      FieldName = 'ISQuote'
      Size = 1
    end
  end
  object DSPickSlips: TDataSource
    DataSet = qryPickSlip
    Left = 594
    Top = 5
  end
end
