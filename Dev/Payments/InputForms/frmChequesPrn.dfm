inherited ChequesPrnGUI: TChequesPrnGUI
  Left = 252
  Top = 138
  HelpContext = 66000
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Print Cheques'
  ClientHeight = 538
  ClientWidth = 582
  OldCreateOrder = True
  ExplicitLeft = 252
  ExplicitTop = 138
  ExplicitWidth = 590
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 15
  object Shape1: TShape [0]
    Left = 472
    Top = 481
    Width = 102
    Height = 56
    Brush.Style = bsClear
  end
  object Bevel1: TBevel [1]
    Left = 16
    Top = 172
    Width = 553
    Height = 305
    HelpContext = 66002
  end
  object Label1: TLabel [2]
    Left = 41
    Top = 74
    Width = 29
    Height = 15
    HelpContext = 66003
    Caption = 'From'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel [3]
    Left = 241
    Top = 74
    Width = 13
    Height = 15
    HelpContext = 66004
    Caption = 'To'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [4]
    Left = 166
    Top = 454
    Width = 231
    Height = 15
    HelpContext = 66005
    Caption = 'Hold down Ctrl and click to toggle Invoice'
    Transparent = True
  end
  object Label4: TLabel [5]
    Left = 450
    Top = 74
    Width = 76
    Height = 15
    HelpContext = 66006
    Caption = 'Show Printed'
    Transparent = True
  end
  object Label7: TLabel [6]
    Left = 450
    Top = 54
    Width = 98
    Height = 15
    HelpContext = 66007
    Caption = 'Choose Template'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 66001
  end
  inherited lblSkingroupMsg: TLabel
    Top = 538
    Width = 582
    ExplicitTop = 521
    ExplicitWidth = 582
  end
  object Label8: TLabel [11]
    Left = 499
    Top = 487
    Width = 71
    Height = 45
    HelpContext = 66006
    Caption = 'Use Cheque Number in Sequence'
    Transparent = True
    WordWrap = True
  end
  object dtFrom: TDateTimePicker [12]
    Left = 81
    Top = 66
    Width = 129
    Height = 23
    HelpContext = 66011
    Date = 37441.582759976900000000
    Time = 37441.582759976900000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnChange = dtFromChange
  end
  object dtTo: TDateTimePicker [13]
    Left = 265
    Top = 66
    Width = 129
    Height = 23
    HelpContext = 66012
    Date = 37441.582972777800000000
    Time = 37441.582972777800000000
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnChange = dtToChange
  end
  object grd: TwwDBGrid [14]
    Left = 30
    Top = 184
    Width = 525
    Height = 231
    HelpContext = 66013
    Selected.Strings = (
      'Company'#9'21'#9'Company'#9'F'
      'ChequeNumber'#9'10'#9'Cheque No'#9'F'
      'ReferenceNo'#9'12'#9'Reference No'#9'F'
      'OrderDate'#9'9'#9'Order Date'#9'F'
      'Total Amount (Inc)'#9'10'#9'Total Amount (Inc)'#9'F')
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = dsCheques
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    MultiSelectOptions = [msoAutoUnselect]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
    ParentFont = False
    TabOrder = 6
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = True
    OnCalcCellColors = grdCalcCellColors
    OnColEnter = grdColEnter
    PaintOptions.BackgroundOptions = [coBlendFixedRow]
  end
  object btnSelect: TDNMSpeedButton [15]
    Left = 182
    Top = 424
    Width = 87
    Height = 27
    HelpContext = 66014
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
    TabOrder = 7
    OnClick = btnSelectClick
  end
  object btnUnselect: TDNMSpeedButton [16]
    Left = 302
    Top = 424
    Width = 87
    Height = 27
    HelpContext = 66015
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
    TabOrder = 8
    OnClick = btnUnselectClick
  end
  object chkPrintFlag: TCheckBox [17]
    Left = 433
    Top = 72
    Width = 14
    Height = 16
    HelpContext = 66016
    TabOrder = 9
    OnClick = chkPrintFlagClick
  end
  object HeaderPanel: TDNMPanel [18]
    Left = 1
    Top = 94
    Width = 581
    Height = 75
    HelpContext = 66017
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    BevelWidth = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 10
    object Panel2: TDNMPanel
      Left = 0
      Top = 39
      Width = 581
      Height = 36
      HelpContext = 66018
      Align = alBottom
      Anchors = [akLeft, akRight]
      BevelOuter = bvNone
      BevelWidth = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object pnlButtons: TDNMPanel
        Left = 27
        Top = 0
        Width = 305
        Height = 34
        HelpContext = 66019
        BevelOuter = bvNone
        BevelWidth = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        object btnAddFilter: TDNMSpeedButton
          Left = 8
          Top = 8
          Width = 97
          Height = 25
          HelpContext = 66020
          Action = actAddToFilter
          Caption = 'Add To Filter'
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
          TabOrder = 0
        end
        object btnExecute: TDNMSpeedButton
          Left = 107
          Top = 8
          Width = 97
          Height = 25
          HelpContext = 66021
          Action = actExecuteFilter
          Caption = 'Execute Filter'
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
          TabOrder = 1
        end
        object btnClear: TDNMSpeedButton
          Left = 206
          Top = 8
          Width = 97
          Height = 25
          HelpContext = 66022
          Action = actClearFilter
          Caption = 'Clear Filter'
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
          TabOrder = 2
        end
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 35
      Top = 8
      Width = 508
      Height = 37
      HelpContext = 66023
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        508
        37)
      object Label5: TLabel
        Left = 3
        Top = 12
        Width = 88
        Height = 16
        HelpContext = 66024
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
        Left = 252
        Top = 12
        Width = 72
        Height = 15
        HelpContext = 66025
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
        Top = 6
        Width = 146
        Height = 23
        HelpContext = 66026
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
        Left = 326
        Top = 5
        Width = 176
        Height = 23
        Hint = '"Type In What To Filter This Column By"'
        HelpContext = 66027
        TabStop = False
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnChange = edtSearchChange
      end
    end
  end
  object chkChooseRpt: TCheckBox [19]
    Left = 433
    Top = 52
    Width = 14
    Height = 16
    HelpContext = 66028
    TabOrder = 11
  end
  object btnPrint: TDNMSpeedButton [20]
    Left = 15
    Top = 496
    Width = 87
    Height = 27
    HelpContext = 66029
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
    TabOrder = 0
    OnClick = btnPreviewPrintClick
  end
  object pnlTitle: TDNMPanel [21]
    Left = 176
    Top = 6
    Width = 238
    Height = 45
    HelpContext = 66030
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 236
      Height = 43
      HelpContext = 66031
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
        Width = 236
        Height = 43
        HelpContext = 66032
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Print Cheques'
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
  object btnClose: TDNMSpeedButton [22]
    Left = 375
    Top = 496
    Width = 87
    Height = 27
    HelpContext = 66009
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
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object btnPreview: TDNMSpeedButton [23]
    Left = 135
    Top = 496
    Width = 87
    Height = 27
    HelpContext = 66008
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
    TabOrder = 1
    OnClick = btnPreviewPrintClick
  end
  object btnEmail: TDNMSpeedButton [24]
    Left = 255
    Top = 496
    Width = 87
    Height = 27
    HelpContext = 66010
    Caption = '&Email'
    DisableTransparent = False
    Enabled = False
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
    OnClick = btnEmailClick
  end
  object chkUseChequeNo: TCheckBox [25]
    Left = 477
    Top = 501
    Width = 14
    Height = 16
    HelpContext = 66016
    TabOrder = 13
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004C004C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object dsCheques: TDataSource
    DataSet = qryCheques
    Left = 473
    Top = 35
  end
  object qryCheques: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblPurchaseOrders.PurchaseOrderID, tblClients.ClientID, t' +
        'blClients.Company,'
      
        'tblPurchaseOrders.PurchaseOrderNumber AS '#39'P/O Num'#39', tblPurchaseO' +
        'rders.OrderDate, tblPurchaseOrders.Comments,'
      
        'tblClients.Contact1, tblPurchaseOrders.PrintFlag, tblPurchaseOrd' +
        'ers.ETADate, tblClients.Phone, tblPurchaseLines.Invoiced,'
      
        'tblPurchaseOrders.InvoiceNumber, tblPurchaseOrders.IsRA, tblPurc' +
        'haseOrders.Deleted,'
      
        'tblPurchaseOrders.SalesComments,tblPurchaseOrders.RefNo as Refer' +
        'enceNo,InvoiceNumber as ChequeNumber,'
      
        'tblPurchaseOrders.TotalAmount as '#39'Total Amount (Ex)'#39', tblPurchas' +
        'eOrders.TotalTax as '#39'Total Tax'#39','
      
        'tblPurchaseOrders.TotalAmountInc as '#39'Total Amount (Inc)'#39', tblPur' +
        'chaseOrders.EditedFlag'
      'FROM tblPurchaseOrders'
      
        'INNER JOIN tblPurchaseLines  ON  (tblPurchaseOrders.PurchaseOrde' +
        'rID = tblPurchaseLines.PurchaseOrderID)'
      
        'LEFT JOIN tblClients ON  (tblPurchaseOrders.SupplierName = tblCl' +
        'ients.Company)'
      
        'LEFT JOIN tblParts ON  (tblPurchaseLines.ProductName = tblParts.' +
        'PARTName)'
      
        'WHERE tblPurchaseOrders.OrderDate And tblPurchaseOrders.IsCheque' +
        ' = '#39'T'#39
      'And  OrderDate  Between :dtfrom  AND  :dtto'
      'And PrintFlag<> :PrintFlag'
      'Group By tblPurchaseOrders.PurchaseOrderID'
      '')
    Left = 408
    Top = 11
    ParamData = <
      item
        DataType = ftString
        Name = 'dtfrom'
        Size = 255
      end
      item
        DataType = ftString
        Name = 'dtto'
        Size = 255
      end
      item
        DataType = ftString
        Name = 'PrintFlag'
        Size = 255
      end>
    object qryChequesCompany: TWideStringField
      DisplayWidth = 21
      FieldName = 'Company'
      Origin = 'tblClients.Company'
      Size = 80
    end
    object qryChequesChequeNumber: TWideStringField
      DisplayLabel = 'Cheque No'
      DisplayWidth = 10
      FieldName = 'ChequeNumber'
      Origin = 'tblpurchaseorders.InvoiceNumber'
      Size = 30
    end
    object qryChequesReferenceNo: TWideStringField
      DisplayLabel = 'Reference No'
      DisplayWidth = 12
      FieldName = 'ReferenceNo'
      Origin = 'tblpurchaseorders.RefNo'
      Size = 50
    end
    object qryChequesOrderDate: TDateTimeField
      DisplayLabel = 'Order Date'
      DisplayWidth = 9
      FieldName = 'OrderDate'
      Origin = 'tblpurchaseorders.OrderDate'
    end
    object qryChequesTotalAmountInc: TFloatField
      DisplayWidth = 10
      FieldName = 'Total Amount (Inc)'
      Origin = 'tblpurchaseorders.TotalAmountInc'
      currency = True
    end
    object qryChequesPurchaseOrderID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'PurchaseOrderID'
      Origin = 'tblpurchaseorders.PurchaseOrderID'
      ReadOnly = True
      Visible = False
    end
    object qryChequesClientID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblClients.ClientID'
      ReadOnly = True
      Visible = False
    end
    object qryChequesPONum: TWideStringField
      FieldName = 'P/O Num'
      Origin = 'tblpurchaseorders.PurchaseOrderNumber'
      Visible = False
      Size = 30
    end
    object qryChequesComments: TWideStringField
      FieldName = 'Comments'
      Origin = 'tblpurchaseorders.Comments'
      Visible = False
      Size = 255
    end
    object qryChequesContact1: TWideStringField
      FieldName = 'Contact1'
      Origin = 'tblClients.Contact1'
      Visible = False
      Size = 50
    end
    object qryChequesPrintFlag: TWideStringField
      FieldName = 'PrintFlag'
      Origin = 'tblpurchaseorders.PrintFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryChequesETADate: TDateField
      FieldName = 'ETADate'
      Origin = 'tblpurchaseorders.ETADate'
      Visible = False
    end
    object qryChequesPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblClients.Phone'
      Visible = False
    end
    object qryChequesInvoiced: TWideStringField
      FieldName = 'Invoiced'
      Origin = 'tblPurchaseLines.Invoiced'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryChequesInvoiceNumber: TWideStringField
      FieldName = 'InvoiceNumber'
      Origin = 'tblpurchaseorders.InvoiceNumber'
      Visible = False
      Size = 30
    end
    object qryChequesIsRA: TWideStringField
      FieldName = 'IsRA'
      Origin = 'tblpurchaseorders.IsRA'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryChequesDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblpurchaseorders.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryChequesSalesComments: TWideStringField
      FieldName = 'SalesComments'
      Origin = 'tblpurchaseorders.SalesComments'
      Visible = False
      Size = 255
    end
    object qryChequesTotalAmountEx: TFloatField
      FieldName = 'Total Amount (Ex)'
      Origin = 'tblpurchaseorders.TotalAmount'
      Visible = False
    end
    object qryChequesTotalTax: TFloatField
      FieldName = 'Total Tax'
      Origin = 'tblpurchaseorders.TotalTax'
      Visible = False
    end
  end
  object actlstFilters: TActionList
    Images = imgPopup
    Left = 325
    Top = 272
    object actAddToFilter: TAction
      Caption = '&Add To Filter'
      ImageIndex = 0
      OnExecute = actAddToFilterExecute
      OnUpdate = actAddToFilterUpdate
    end
    object actExecuteFilter: TAction
      Caption = '&Execute Filter'
      ImageIndex = 1
      OnExecute = actExecuteFilterExecute
      OnUpdate = actExecuteFilterUpdate
    end
    object actClearFilter: TAction
      Caption = '&Clear Filter'
      ImageIndex = 2
      OnExecute = actClearFilterExecute
      OnUpdate = actClearFilterUpdate
    end
  end
  object imgPopup: TImageList
    Left = 369
    Top = 275
    Bitmap = {
      494C010105001800180010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000007B7B7B000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000007B7B7B000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008484000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF0000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000084840000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000848400000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      000000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000848400008484000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      00000000000000000000000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FDFF000000000000F8FF000000000000
      F8FF000000000000F87F000000000000F81F000000000000F80F000000000000
      F00F000000000000E00F000000000000E00F000000000000E00F000000000000
      F01F000000000000F00F000000000000F00F000000000000F007000000000000
      F007000000000000F007000000000000FFFDFFFF847FE00FFFF8FFFF00EFE00F
      FFF1F9FF31BFE00FFFE3F0FF39FFF00FFFC7F0FF993FF00FE08FE07FCA1FF80F
      C01FC07FF40FF007803F843F9C07F007001F1E3F9603F007001FFE1FCB01F00F
      001FFF1FFF80F01F001FFF8FF7C0F81F001FFFC7FFE0FE1F803FFFE3EFF0FF1F
      C07FFFF8FFF8FF1FE0FFFFFFFFFCFFBF00000000000000000000000000000000
      000000000000}
  end
  object mnuFilter: TAdvPopupMenu
    Images = imgPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 369
    Top = 315
    object mnuAddFilter: TMenuItem
      Action = actAddToFilter
    end
    object mnuExecute: TMenuItem
      Action = actExecuteFilter
    end
    object mnuClear: TMenuItem
      Action = actClearFilter
    end
  end
end
