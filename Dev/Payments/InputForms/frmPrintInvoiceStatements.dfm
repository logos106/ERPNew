inherited PrintStatement: TPrintStatement
  Left = 416
  Top = 162
  HelpContext = 507000
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Print Statements'
  ClientHeight = 472
  ClientWidth = 626
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 416
  ExplicitTop = 162
  ExplicitWidth = 642
  ExplicitHeight = 511
  DesignSize = (
    626
    472)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 422
    Width = 626
    HelpContext = 507039
    ExplicitTop = 498
    ExplicitWidth = 623
  end
  object Label7: TLabel [1]
    Left = 536
    Top = 17
    Width = 88
    Height = 15
    HelpContext = 507005
    Anchors = [akTop, akRight]
    Caption = 'Statement Date'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    ExplicitLeft = 533
  end
  inherited imgGridWatermark: TImage
    HelpContext = 507001
  end
  object dtCurDate: TwwDBDateTimePicker [6]
    Left = 536
    Top = 30
    Width = 88
    Height = 23
    HelpContext = 507034
    Anchors = [akTop, akRight]
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'MS Sans Serif'
    CalendarAttributes.Font.Style = []
    Date = 37441.000000000000000000
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 1
    UnboundDataType = wwDTEdtDate
  end
  object Pagecontrol: TPageControl [7]
    Left = 0
    Top = 60
    Width = 626
    Height = 370
    HelpContext = 507040
    ActivePage = tabGeneral
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    MultiLine = True
    ParentFont = False
    TabHeight = 25
    TabOrder = 0
    TabWidth = 309
    object tabGeneral: TTabSheet
      HelpContext = 507041
      Caption = 'General'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 618
        Height = 335
        HelpContext = 507042
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Bevel4: TBevel
          Left = 12
          Top = 73
          Width = 595
          Height = 15
          HelpContext = 507043
        end
        object lblCustomfilter: TLabel
          Left = 15
          Top = 73
          Width = 589
          Height = 18
          HelpContext = 507004
          Alignment = taCenter
          AutoSize = False
          Caption = 'Custom Filter'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Bevel1: TBevel
          Left = 12
          Top = 90
          Width = 595
          Height = 237
          HelpContext = 507003
        end
        object Label3: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 311
          Width = 610
          Height = 15
          HelpContext = 507051
          Margins.Bottom = 8
          Align = alBottom
          Alignment = taCenter
          AutoSize = False
          Caption = 'Hold down  Ctrl key  and click to Select'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 10
          ExplicitTop = 284
          ExplicitWidth = 595
        end
        object grd: TwwDBGrid
          Left = 21
          Top = 99
          Width = 572
          Height = 175
          HelpContext = 507014
          Selected.Strings = (
            'CompanyName'#9'22'#9'Customer'#9'F'
            'JobName'#9'22'#9'Job Name'#9'F'
            'TypeName'#9'18'#9'Type'#9'F'
            'Amountdue'#9'12'#9'Amount Due'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = dsStatements
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          MultiSelectOptions = [msoAutoUnselect]
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
          OnTitleButtonClick = grdTitleButtonClick
          OnColEnter = grdColEnter
          OnDblClick = grdDblClick
          OnCalcTitleImage = grdCalcTitleImage
          TitleImageList = imgPopup
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
        end
        object btnSelect: TDNMSpeedButton
          Left = 160
          Top = 283
          Width = 87
          Height = 27
          HelpContext = 507015
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
        object btnUnselect: TDNMSpeedButton
          Left = 372
          Top = 283
          Width = 87
          Height = 27
          HelpContext = 507016
          Caption = '&Deselect All'
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
        object DNMPanel4: TDNMPanel
          AlignWithMargins = True
          Left = 4
          Top = 42
          Width = 610
          Height = 32
          HelpContext = 507076
          Align = alTop
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object lblFilter: TLabel
            Left = 322
            Top = 0
            Width = 70
            Height = 32
            HelpContext = 507007
            Align = alRight
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Search by Customer'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            WordWrap = True
            ExplicitLeft = 321
            ExplicitTop = -2
            ExplicitHeight = 30
          end
          object DNMSpeedButton1: TDNMSpeedButton
            AlignWithMargins = True
            Left = 523
            Top = 3
            Width = 84
            Height = 26
            HelpContext = 507054
            Align = alRight
            Caption = 'Custom Filter'
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
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
            TabOrder = 0
            AutoDisableParentOnclick = True
            OnClick = DNMSpeedButton1Click
          end
          object edtSearch: TEdit
            AlignWithMargins = True
            Left = 395
            Top = 3
            Width = 122
            Height = 26
            HelpContext = 507018
            Align = alRight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = edtSearchChange
            ExplicitHeight = 23
          end
          object btnClear: TDNMSpeedButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 87
            Height = 26
            HelpContext = 507020
            Align = alLeft
            Caption = 'Clear &Filter'
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
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
            AutoDisableParentOnclick = True
            OnClick = btnClearClick
          end
          object btnExecute: TDNMSpeedButton
            AlignWithMargins = True
            Left = 189
            Top = 3
            Width = 87
            Height = 26
            HelpContext = 507019
            Align = alLeft
            Caption = 'E&xecute Filter'
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
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
            TabOrder = 3
            AutoDisableParentOnclick = True
            OnClick = btnExecuteClick
          end
          object btnAddFilter: TDNMSpeedButton
            AlignWithMargins = True
            Left = 96
            Top = 3
            Width = 87
            Height = 26
            HelpContext = 507021
            Align = alLeft
            Caption = '&Add To Filter'
            DisableTransparent = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
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
        end
        object DNMPanel5: TDNMPanel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 610
          Height = 32
          HelpContext = 507077
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object Label1: TLabel
            Left = 375
            Top = 9
            Width = 29
            Height = 15
            HelpContext = 507052
            Caption = 'From'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Label2: TLabel
            Left = 499
            Top = 9
            Width = 13
            Height = 15
            HelpContext = 507006
            Caption = 'To'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object Panel4: TDNMPanel
            Left = 1
            Top = 1
            Width = 264
            Height = 30
            HelpContext = 507025
            Align = alLeft
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
            object lblClassTitle: TLabel
              Left = 0
              Top = 0
              Width = 32
              Height = 30
              HelpContext = 507026
              Align = alLeft
              Alignment = taRightJustify
              Caption = 'Class'
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              ExplicitHeight = 15
            end
            object chkAllClass: TCheckBox
              Left = 232
              Top = 0
              Width = 32
              Height = 30
              HelpContext = 507028
              Align = alRight
              Alignment = taLeftJustify
              Caption = 'All'
              Checked = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              State = cbChecked
              TabOrder = 0
              OnClick = chkAllClassClick
            end
            object cboClass: TwwDBLookupCombo
              Left = 92
              Top = 4
              Width = 114
              Height = 23
              HelpContext = 507029
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              DropDownAlignment = taLeftJustify
              LookupTable = cboClassQry
              LookupField = 'ClassName'
              Enabled = False
              ParentFont = False
              TabOrder = 1
              AutoDropDown = False
              ShowButton = True
              PreciseEditRegion = False
              AllowClearKey = False
              OnCloseUp = cboClassCloseUp
            end
          end
          object dtFrom: TwwDBDateTimePicker
            Left = 408
            Top = 5
            Width = 85
            Height = 23
            HelpContext = 507053
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            Date = 37441.000000000000000000
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 1
            UnboundDataType = wwDTEdtDate
          end
          object dtTo: TwwDBDateTimePicker
            Left = 518
            Top = 5
            Width = 85
            Height = 23
            HelpContext = 507035
            CalendarAttributes.Font.Charset = DEFAULT_CHARSET
            CalendarAttributes.Font.Color = clWindowText
            CalendarAttributes.Font.Height = -11
            CalendarAttributes.Font.Name = 'MS Sans Serif'
            CalendarAttributes.Font.Style = []
            Date = 37441.000000000000000000
            Epoch = 1950
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            ShowButton = True
            TabOrder = 2
            UnboundDataType = wwDTEdtDate
            OnCloseUp = dtToCloseUp
            OnChange = dtToChange
          end
        end
      end
    end
    object TabOptions: TTabSheet
      HelpContext = 507044
      Caption = 'Options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentFont = False
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 618
        Height = 335
        HelpContext = 507045
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        DesignSize = (
          618
          335)
        object Bevel3: TBevel
          Left = 28
          Top = 37
          Width = 159
          Height = 99
          HelpContext = 507055
        end
        object Label12: TLabel
          Left = 87
          Top = -55
          Width = 41
          Height = 15
          HelpContext = 507059
          Anchors = [akRight, akBottom]
          Caption = 'Include'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitLeft = 84
          ExplicitTop = -58
        end
        object Bevel5: TBevel
          Left = 341
          Top = 154
          Width = 250
          Height = 113
          HelpContext = 507060
        end
        object lblBalOnDaterangehint: TLabel
          Left = 44
          Top = 291
          Width = 284
          Height = 14
          HelpContext = 507071
          Alignment = taCenter
          Caption = '(The report can be very slow when this option is selected)'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
        end
        object Label18: TLabel
          Left = 349
          Top = 147
          Width = 98
          Height = 15
          HelpContext = 507048
          Caption = 'Grouping Options'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label15: TLabel
          Left = 39
          Top = 29
          Width = 132
          Height = 15
          HelpContext = 507047
          Caption = 'Transactions to Include'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel6: TBevel
          AlignWithMargins = True
          Left = 12
          Top = 12
          Width = 594
          Height = 311
          HelpContext = 507073
          Margins.Left = 11
          Margins.Top = 11
          Margins.Right = 11
          Margins.Bottom = 11
          Align = alClient
          ExplicitLeft = 4
        end
        object grpbasedonoptions: TRadioGroup
          Left = 227
          Top = 31
          Width = 159
          Height = 105
          HelpContext = 507049
          Caption = 'Statement Based On'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Sale Date'
            'Due Date')
          ParentFont = False
          TabOrder = 10
        end
        object grpOrderOptions: TRadioGroup
          Left = 432
          Top = 31
          Width = 159
          Height = 105
          Hint = 'The order is not applicable for the '#39'Running Balalnce Templates'#39
          HelpContext = 507050
          Caption = 'Print Sales in Order of'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Days Outstanding'
            'Sale #'
            'Sales Date')
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
        end
        object chkOutstandingInv: TCheckBox
          Left = 28
          Top = 173
          Width = 222
          Height = 13
          HelpContext = 507033
          TabStop = False
          Caption = 'Print All Invoices with Statement'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
        end
        object chkincludeSOBO: TCheckBox
          Left = 41
          Top = 118
          Width = 109
          Height = 13
          HelpContext = 507064
          TabStop = False
          Caption = 'SO BO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = chkincludeSalesOrderClick
        end
        object chkincludeinvoiceBO: TCheckBox
          Left = 41
          Top = 87
          Width = 109
          Height = 13
          HelpContext = 507065
          TabStop = False
          Caption = 'Invoice BO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = chkincludeSalesOrderClick
        end
        object chkincludeSalesOrder: TCheckBox
          Left = 41
          Top = 56
          Width = 109
          Height = 13
          HelpContext = 507066
          TabStop = False
          Caption = 'Sales Orders '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = chkincludeSalesOrderClick
        end
        object chkshowPaid: TCheckBox
          Left = 28
          Top = 207
          Width = 222
          Height = 13
          HelpContext = 507067
          TabStop = False
          Caption = 'Show Paid Invoices on Statements'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
        end
        object chkGroupJobs: TCheckBox
          Left = 365
          Top = 173
          Width = 192
          Height = 13
          HelpContext = 507032
          TabStop = False
          Caption = 'Group Jobs With Customer'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = chkGroupJobsClick
        end
        object chkRelatedCustomer: TCheckBox
          Left = 365
          Top = 207
          Width = 192
          Height = 13
          HelpContext = 507068
          TabStop = False
          Caption = 'Group Related Customers'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          OnClick = chkRelatedCustomerClick
        end
        object chk0Balancecustomers: TCheckBox
          Left = 28
          Top = 241
          Width = 222
          Height = 13
          HelpContext = 507069
          TabStop = False
          Caption = 'Show Customers with 0 Balance'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = chk0BalancecustomersClick
        end
        object chkGroupType: TCheckBox
          Left = 365
          Top = 241
          Width = 192
          Height = 13
          HelpContext = 507070
          TabStop = False
          Caption = 'Group by Customer Type'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          OnClick = chkGroupTypeClick
        end
        object chkBalOnDaterange: TCheckBox
          Left = 28
          Top = 276
          Width = 309
          Height = 13
          Hint = 'The report can be very slow when this option is selected'
          HelpContext = 507072
          TabStop = False
          Caption = 'Calculate Sales balance as on the Statement Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          OnClick = chk0BalancecustomersClick
        end
      end
    end
  end
  object pnlTitle: TDNMPanel [8]
    Left = 101
    Top = 5
    Width = 410
    Height = 49
    HelpContext = 507036
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 406
      Height = 45
      HelpContext = 507037
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
        Width = 406
        Height = 45
        HelpContext = 507038
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Print Statements'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -35
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 403
      end
    end
  end
  object DNMPanel3: TDNMPanel [9]
    Left = 0
    Top = 422
    Width = 626
    Height = 50
    HelpContext = 507074
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label8: TLabel
      Left = 1
      Top = 1
      Width = 624
      Height = 16
      HelpContext = 507009
      Align = alTop
      Alignment = taRightJustify
      Caption = 'Emailing, Please Wait... '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitLeft = 469
      ExplicitWidth = 156
    end
    object btnClose: TDNMSpeedButton
      Left = 376
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 507031
      Caption = '&Close'
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
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object btnReport: TDNMSpeedButton
      Left = 270
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 507075
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
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnReportClick
    end
    object btnSend: TDNMSpeedButton
      Left = 164
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 507023
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnSendClick
    end
    object chkChooseRpt: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 20
      Width = 120
      Height = 26
      HelpContext = 507022
      TabStop = False
      Align = alLeft
      Caption = 'Choose Template'
      TabOrder = 3
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 40
    Top = 260
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 244
    Top = 260
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 285
    Top = 260
  end
  inherited DataState: TDataState
    Left = 80
    Top = 260
  end
  inherited imgsort: TImageList
    Left = 203
    Top = 260
    Bitmap = {
      494C010102007400080110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object dsStatements: TDataSource
    DataSet = qryStatements
    Left = 366
    Top = 260
  end
  object qryStatements: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '###### Dummy #####'
      '#################'
      'SELECT'
      'C.GlobalRef as GlobalRef,'
      'SUBSTRING_INDEX(C.Company,"^",1) as CompanyName,'
      '`CT`.`TypeName`,'
      'C.JobName AS JobName,'
      'C.JobNumber AS JobNumber,'
      'C.SerialNumber AS "Serial #", '
      'C.ModelNumber AS "Model #", '
      'C.Manufacture AS "Manufacture",'
      'C.ARBalance AS "AR Balance",'
      'C.APBalance AS "AP Balance",'
      'C.Balance AS Balance,'
      'C.FirstName as Firstname, '
      'C.LastName as LastName,'
      'C.Email AS Email,'
      'C.Street AS Street,'
      'C.Street2 AS Street2,'
      'C.Street3 AS Street3,'
      'C.Suburb AS Suburb,'
      'C.State AS State,'
      'C.Postcode AS Postcode,'
      'C.Country AS Country,'
      'C.Phone AS Phone,'
      'C.FaxNumber AS FaxNumber,'
      'C.Mobile AS Mobile,'
      'C.AltContact AS AltContact,'
      'C.AltPhone AS AltPhone,'
      'C.BillStreet AS BillStreet,'
      'C.BillStreet2 AS BillStreet2,'
      'C.BillStreet3 AS BillStreet3,'
      'C.BillSuburb AS BillSuburb,'
      'C.BillState AS BillState,'
      'C.BillPostcode AS BillPostcode,'
      'C.BillCountry AS BillCountry,'
      'C.ClientNo as AccountNo,'
      'C.CUSTFLD1 AS CUSTFLD1,'
      'C.CUSTFLD2 AS CUSTFLD2,'
      'C.CUSTFLD3 AS CUSTFLD3,'
      'C.CUSTFLD4 AS CUSTFLD4,'
      'C.CUSTFLD5 AS CUSTFLD5,'
      'C.CUSTFLD6 AS CUSTFLD6,'
      'C.CUSTFLD7 AS CUSTFLD7,'
      'C.CUSTFLD8 AS CUSTFLD8,'
      'C.CUSTFLD9 AS CUSTFLD9,'
      'C.CUSTFLD10 AS CUSTFLD10,'
      'C.CUSTFLD11 AS CUSTFLD11,'
      'C.CUSTFLD12 AS CUSTFLD12,'
      'C.CUSTFLD13 AS CUSTFLD13,'
      'C.CUSTFLD14 AS CUSTFLD14,'
      'C.CUSTFLD15 AS CUSTFLD15,'
      'C.CUSTDATE1 AS CUSTDATE1,'
      'C.CUSTDATE2 AS CUSTDATE2,'
      'C.CUSTDATE3 AS CUSTDATE3,'
      'C.IsJob AS IsJob,'
      'C.Active AS Active,'
      'C.ClientID AS ClientID,'
      'C.ParentClientID AS ParentClientID,'
      'C.ParentRelatedClientID AS ParentRelatedClientID,'
      'C.CreditLimit AS CreditLimit,'
      'C.TermsID AS TermsID,'
      'C.GracePeriod AS GracePeriod,'
      'C.PickingPriority AS PickingPriority,'
      'C.DefaultClass AS DefaultClass,'
      'C.Area AS Area,'
      'C.StopCredit,'
      'C.CardNumber AS CardNumber,'
      'C.DischargeDate AS DischargeDate,'
      'C.CreationDate AS CreationDate,'
      'C.CreditCardType AS CreditCardType,'
      'C.CreditCardNumber AS CreditCardNumber,'
      'C.CreditCardExpiryDate AS CreditCardExpiryDate,'
      'C.CreditCardNotes AS CreditCardNotes,'
      'C.ABN AS ABN,'
      'C.SOBalance AS SOBalance,'
      
        'sum((select Sum(ifnull(`S`.`Balance`,0))    from `tblsales` AS `' +
        'S` '
      'Where  `C`.`ClientID` = `S`.`ClientID`'
      'and  s.SaleDate <='#39'2009-05-31'#39
      ' and S.ClassId in (3,1,5,9,4,8,6)'
      
        ' and (((isinvoice="T" or isrefund="T"  or issalesorder="T") and ' +
        '(ifnull(PayMethod,"") = "")))'
      ' and converted = "F")) as Salessum, '
      
        'sum((select Sum(ifnull(SL.QtySold,0)*ifnull(SL.LinePriceInc,0)) ' +
        '   '
      
        'from tblsales AS S  inner join tblSaleslines SL on SL.SaleId = S' +
        '.SaleId '
      'Where  `C`.`ClientID` = `S`.`ClientID`'
      
        'and ifnull(SL.shipped,0) = 0  and ifnull(S.BOID,"") = "" and  S.' +
        'ISInvoice = "T"  '
      'and  s.SaleDate <='#39'2009-05-31'#39
      ' and S.ClassId in (3,1,5,9,4,8,6)'
      ' and converted = "F")) as BOINVSum, '
      
        'sum((select Sum(ifnull(SL.QtySold,0)*ifnull(SL.LinePriceInc,0)) ' +
        '   '
      
        'from tblsales AS S  inner join tblSaleslines SL on SL.SaleId = S' +
        '.SaleId '
      'Where  `C`.`ClientID` = `S`.`ClientID`'
      
        'and ifnull(SL.shipped,0) = 0  and ifnull(S.BOID,"") = "" and  S.' +
        'IsSalesOrder = "T"  and ifnull(S.converted, "T") = "F" '
      'and  s.SaleDate <='#39'2009-05-31'#39
      ' and S.ClassId in (3,1,5,9,4,8,6)'
      ' and converted = "F")) as BOSOSum, '
      
        'sum((Select Sum(ifnull(`PR`.`Balance`,0)) from `tblprepayments` ' +
        'AS `PR` '
      'Where `C`.`ClientID` = `PR`.`ClientID`'
      ' and ifnull(PR.Deleted,"F") <> "T"'
      'and  `PR`.`PrePaymentDate` <= '#39'2009-05-31'#39
      ' and PR.ClassId in (3,1,5,9,4,8,6))) as PrepaySum'
      'FROM'
      '`tblclients` AS `C`'
      
        'Left Join `tblclienttype` AS `CT` ON `C`.`ClientTypeID` = `CT`.`' +
        'ClientTypeID`'
      
        ' where  C.ClientID in (Select S.ClientID from tblSales S where P' +
        'aid ="F")'
      'group by `CT`.`TypeName`,'
      'SUBSTRING_INDEX(C.Company,'#39'^'#39',1)'
      'Order by  Companyname')
    Filtered = True
    BeforeOpen = qryStatementsBeforeOpen
    AfterOpen = qryStatementsAfterOpen
    BeforeClose = qryStatementsBeforeClose
    OnCalcFields = qryStatementsCalcFields
    Left = 325
    Top = 260
    object qryStatementsAmountdue: TFloatField
      DisplayLabel = 'Amount Due'
      DisplayWidth = 11
      FieldKind = fkCalculated
      FieldName = 'Amountdue'
      currency = True
      Calculated = True
    end
    object qryStatementsSalesSum: TFloatField
      DisplayWidth = 10
      FieldName = 'SalesSum'
      Origin = '.Salessum'
      Visible = False
    end
    object qryStatementsPrepaysum: TFloatField
      DisplayWidth = 10
      FieldName = 'PrepaySum'
      Origin = '.PrepaySum'
      Visible = False
    end
    object qryStatementsBOINVSum: TFloatField
      DisplayWidth = 10
      FieldName = 'BOINVSum'
      Origin = '.BOINVSum'
      Visible = False
    end
    object qryStatementsBOSOSum: TFloatField
      DisplayWidth = 10
      FieldName = 'BOSOSum'
      Origin = '.BOSOSum'
      Visible = False
    end
    object qryStatementstotalamountdue: TFloatField
      FieldKind = fkCalculated
      FieldName = 'totalamountdue'
      Calculated = True
    end
    object qryStatementsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'C.GlobalRef'
      Size = 255
    end
    object qryStatementsCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Origin = '.CompanyName'
      Size = 80
    end
    object qryStatementsTypeName: TWideStringField
      FieldName = 'TypeName'
      Origin = 'CT.TypeName'
      Size = 50
    end
    object qryStatementsJobName: TWideStringField
      FieldName = 'JobName'
      Origin = 'C.JobName'
      Size = 39
    end
    object qryStatementsJobNumber: TIntegerField
      FieldName = 'JobNumber'
      Origin = 'C.JobNumber'
    end
    object qryStatementsSerial: TWideStringField
      FieldName = 'Serial #'
      Origin = 'C.`Serial #`'
      Size = 255
    end
    object qryStatementsModel: TWideStringField
      FieldName = 'Model #'
      Origin = 'C.`Model #`'
      Size = 255
    end
    object qryStatementsManufacture: TWideStringField
      FieldName = 'Manufacture'
      Origin = 'C.Manufacture'
      Size = 255
    end
    object qryStatementsARBalance: TFloatField
      FieldName = 'AR Balance'
      Origin = 'C.`AR Balance`'
    end
    object qryStatementsAPBalance: TFloatField
      FieldName = 'AP Balance'
      Origin = 'C.`AP Balance`'
    end
    object qryStatementsBalance: TFloatField
      FieldName = 'Balance'
      Origin = 'C.Balance'
    end
    object qryStatementsFirstname: TWideStringField
      FieldName = 'Firstname'
      Origin = 'C.Firstname'
      Size = 40
    end
    object qryStatementsMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Origin = 'C.MiddleName'
      Size = 40
    end
    object qryStatementsStreet: TWideStringField
      FieldName = 'Street'
      Origin = 'C.Street'
      Size = 40
    end
    object qryStatementsStreet2: TWideStringField
      FieldName = 'Street2'
      Origin = 'C.Street2'
      Size = 40
    end
    object qryStatementsStreet3: TWideStringField
      FieldName = 'Street3'
      Origin = 'C.Street3'
      Size = 40
    end
    object qryStatementsSuburb: TWideStringField
      FieldName = 'Suburb'
      Origin = 'C.Suburb'
      Size = 40
    end
    object qryStatementsState: TWideStringField
      FieldName = 'State'
      Origin = 'C.State'
      Size = 40
    end
    object qryStatementsCountry: TWideStringField
      FieldName = 'Country'
      Origin = 'C.Country'
      Size = 40
    end
    object qryStatementsPostcode: TWideStringField
      FieldName = 'Postcode'
      Origin = 'C.Postcode'
      Size = 40
    end
    object qryStatementsLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'C.LastName'
      Size = 40
    end
    object qryStatementsEmail: TWideStringField
      FieldName = 'Email'
      Origin = 'C.Email'
      Size = 80
    end
    object qryStatementsIsJob: TWideStringField
      FieldName = 'IsJob'
      Origin = 'C.IsJob'
      FixedChar = True
      Size = 1
    end
    object qryStatementsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'C.Active'
      FixedChar = True
      Size = 1
    end
    object qryStatementsClientID: TLargeintField
      FieldName = 'ClientID'
      Origin = 'C.ClientID'
    end
    object qryStatementsParentClientID: TIntegerField
      FieldName = 'ParentClientID'
      Origin = 'C.ParentClientID'
    end
    object qryStatementsParentRelatedClientID: TIntegerField
      FieldName = 'ParentRelatedClientID'
      Origin = 'C.ParentRelatedClientID'
    end
    object qryStatementsSOBalance: TFloatField
      FieldName = 'SOBalance'
      Origin = 'C.SOBalance'
    end
    object qryStatementsStopCredit: TWideStringField
      FieldName = 'StopCredit'
      Origin = 'C.StopCredit'
      FixedChar = True
      Size = 1
    end
  end
  object imgPopup: TImageList
    Left = 121
    Top = 260
    Bitmap = {
      494C010104006C00000110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
      0000000000008080800080808000000000000000000080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000080000000000080808000000000000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000008000000080000080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF0000008000808080000000FF000000800000000000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000000080000000800000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000800000008000008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000080008080800080808000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008000008000000000FF0000008000000080000080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000008000000080000000800080808000808080000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000800000800000000000000000FF00000080000000800000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000FF0000008000808080000000FF0000008000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000800000008000008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000800000008000808080000000FF0000008000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008000000080
      0000808080000000000000000000000000000000000000000000000000000000
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
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000E00FFDFFFFFFFFFFE00FF8FFFFFFFFFF
      E00FF8FFFFFFFFFFF00FF87FFFFFFFFFF00FF81FF98FF9FFF80FF80FE10FF0FF
      F007F00FF01FE07FF007E00FF83FE03FF007E00FFC3FE01FF00FE00FF81FE20F
      F01FF01FF00FFF07F81FF00FF00FFF87FE1FF00FFFFFFFFFFF1FF007FFFFFFFF
      FF1FF007FFFFFFFFFFBFF007FFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object cboClassQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClassID, ClassName '
      'FROM tblClass '
      'WHERE Active='#39'T'#39' AND ClassName Is Not Null'
      'ORDER BY ClassName;')
    Left = 407
    Top = 260
  end
  object memExportALL: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
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
    DefaultFormat = kbmCSVStreamFormat1
    Left = 530
    Top = 260
  end
  object kbmCSVStreamFormat1: TkbmCSVStreamFormat
    CommentChar = #0
    EscapeChar = '%'
    DefaultStringFieldSize = 255
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    sfLocalFormat = []
    sfQuoteOnlyStrings = [sfSaveQuoteOnlyStrings]
    sfNoHeader = []
    Version = '3.10'
    sfData = [sfSaveData]
    sfCalculated = []
    sfLookup = []
    sfNonVisible = [sfSaveNonVisible, sfLoadNonVisible]
    sfBlobs = []
    sfDef = []
    sfIndexDef = []
    sfPlaceHolders = []
    sfFiltered = []
    sfIgnoreRange = []
    sfIgnoreMasterDetail = []
    sfDeltas = []
    sfDontFilterDeltas = []
    sfAppend = []
    sfFieldKind = []
    sfFromStart = []
    sfDisplayWidth = []
    Left = 448
    Top = 260
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'ERP Statements Data (*.csv)|*.csv|All Files (*.*)|*.*'
    Left = 489
    Top = 260
  end
  object qryStatement2: TERPQuery
    ParamCheck = False
    SQL.Strings = (
      'SELECT CustomerName as '#39'Customer Name'#39','
      'Sum(tblsales.Balance) AS '#39'Total Amount'#39','
      'tblClients.ClientID'
      'FROM tblsales'
      
        'LEFT JOIN tblClients  ON  tblsales.ClientID = tblClients.ClientI' +
        'D'
      'WHERE ( IsRefund ='#39'T'#39' OR IsInvoice='#39'T'#39') AND IsCashSale='#39'F'#39'  AND'
      
        'IsSalesOrder='#39'F'#39' AND IsQuote='#39'F'#39' AND tblsales.Deleted<>"T" AND T' +
        'otalAmountInc <> 0'
      'GROUP BY tblClients.ClientID'
      'Order by CustomerName;')
    Options.LongStrings = False
    Left = 162
    Top = 260
  end
end
