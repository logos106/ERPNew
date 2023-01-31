inherited fmProcCapacityPlanning: TfmProcCapacityPlanning
  Left = 446
  Top = 193
  HelpContext = 184000
  Caption = 'Capacity Planning'
  OldCreateOrder = True
  ExplicitLeft = 446
  ExplicitTop = 193
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 558
    ExplicitTop = 558
    ExplicitWidth = 996
  end
  inherited imgGridWatermark: TImage
    HelpContext = 184001
  end
  inherited shapehintextra1: TShape
    Left = 42
    ExplicitLeft = 51
  end
  inherited lblMsg: TLabel
    AutoSize = False
    ExplicitLeft = -8
    ExplicitTop = 689
    ExplicitWidth = 998
  end
  inherited pnlTop: TDNMPanel
    HelpContext = 184008
    TabOrder = 2
    inherited Label1: TLabel
      Left = 828
      ExplicitLeft = 828
    end
    inherited pnlOptions: TDNMPanel
      Left = -3
      Top = 64
      Width = 715
      HelpContext = 184009
      ExplicitLeft = -3
      ExplicitTop = 64
      ExplicitWidth = 715
      DesignSize = (
        715
        60)
      inherited lblResource: TLabel
        Left = 144
        ExplicitLeft = 144
      end
      inherited Label3: TLabel
        Left = 281
        ExplicitLeft = 281
      end
      inherited lblSelectionoption: TLabel
        Width = 153
        HelpContext = 184010
        ExplicitWidth = 153
      end
      inherited cboCustomers: TComboBox
        Width = 134
        HelpContext = 184011
        ExplicitWidth = 134
      end
      inherited cboResource: TComboBox
        Left = 144
        Top = 24
        Width = 134
        HelpContext = 184012
        ExplicitLeft = 144
        ExplicitTop = 24
        ExplicitWidth = 134
      end
      inherited cboResourceProcess: TComboBox
        Left = 281
        Width = 134
        HelpContext = 184013
        ExplicitLeft = 281
        ExplicitWidth = 134
      end
      inherited cboSOIds: TComboBox
        Width = 103
        HelpContext = 184014
        ExplicitWidth = 103
      end
      inherited chkSelectionoption: TwwCheckBox
        Left = 685
        ExplicitLeft = 685
      end
    end
    inherited edtDateFrom: TwwDBDateTimePicker
      Left = 828
      ExplicitLeft = 828
    end
    inherited pnlTitle: TDNMPanel
      Left = 277
      HelpContext = 184015
      Anchors = []
      ExplicitLeft = 277
    end
    inherited btnPrevPage: TDNMSpeedButton
      Left = 733
      ExplicitLeft = 733
    end
    inherited btnNext: TDNMSpeedButton
      Left = 920
      ExplicitLeft = 920
    end
    inherited btnfirstpage: TDNMSpeedButton
      Left = 638
      ExplicitLeft = 638
    end
    inherited DNMPanel1: TDNMPanel
      HelpContext = 184016
      inherited grpGridDetail: TwwRadioGroup
        Height = 33
        HelpContext = 184017
        ExplicitHeight = 33
      end
      object btnCalcnshowAvailaibityinCapacityPlanner: TDNMSpeedButton
        Left = 0
        Top = 33
        Width = 289
        Height = 27
        HelpContext = 184018
        Align = alBottom
        Caption = 'Calculate and Show Availaibity'
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
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnCalcnshowAvailaibityinCapacityPlannerClick
      end
    end
  end
  object Grid: TAdvStringGrid [7]
    AlignWithMargins = True
    Left = 3
    Top = 136
    Width = 1010
    Height = 422
    Cursor = crDefault
    HelpContext = 184002
    Margins.Top = 0
    Margins.Bottom = 0
    Align = alClient
    Anchors = []
    ColCount = 14
    DefaultColWidth = 60
    DefaultRowHeight = 21
    DrawingStyle = gdsClassic
    FixedCols = 11
    RowCount = 20
    FixedRows = 5
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing]
    ParentFont = False
    ParentShowHint = False
    PopupMenu = popCustomiseGrid
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 0
    OnDragDrop = GridDragDrop
    OnDragOver = GridDragOver
    OnGetEditMask = GridGetEditMask
    OnGetEditText = GridGetEditText
    OnMouseDown = GridMouseDown
    OnMouseMove = GridMouseMove
    OnMouseUp = GridMouseUp
    OnGetDisplText = GridGetDisplText
    OnGetCellColor = GridGetCellColor
    OnGetAlignment = GridGetAlignment
    OnDblClickCell = GridDblClickCell
    OnCanEditCell = GridCanEditCell
    OnCellValidate = GridCellValidate
    OnRowDisjunctSelect = GridRowDisjunctSelect
    OnRowDisjunctSelected = GridRowDisjunctSelected
    HintShowCells = True
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'Tahoma'
    ActiveCellFont.Style = [fsBold]
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDownClear = '(All)'
    FixedColWidth = 60
    FixedFont.Charset = ANSI_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Arial'
    FixedFont.Style = []
    FloatFormat = '%.2f'
    MouseActions.AllColumnSize = True
    MouseActions.DisjunctRowSelect = True
    MouseActions.RangeSelectAndEdit = True
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'MS Sans Serif'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'MS Sans Serif'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'MS Sans Serif'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'MS Sans Serif'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    ScrollWidth = 16
    SearchFooter.FindNextCaption = 'Find next'
    SearchFooter.FindPrevCaption = 'Find previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'MS Sans Serif'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurence'
    SearchFooter.HintFindPrev = 'Find previous occurence'
    SearchFooter.HintHighlight = 'Highlight occurences'
    SearchFooter.MatchCaseCaption = 'Match case'
    ShowDesignHelper = False
    Version = '5.6.0.1'
    ColWidths = (
      60
      60
      60
      60
      60
      60
      60
      60
      60
      60
      60
      59
      60
      60)
    RowHeights = (
      21
      21
      21
      21
      21
      21
      21
      22
      21
      21
      21
      21
      21
      21
      21
      21
      21
      18
      21
      21)
  end
  object pnlBottom: TDNMPanel [8]
    Left = 0
    Top = 558
    Width = 1016
    Height = 44
    HelpContext = 184003
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      1016
      44)
    object Label6: TLabel
      Left = 875
      Top = 27
      Width = 100
      Height = 15
      HelpContext = 184019
      Alignment = taRightJustify
      Anchors = [akTop, akRight, akBottom]
      Caption = '(Ctrl A to select all)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitLeft = 857
    end
    object lblSelcount: TLabel
      Left = 886
      Top = 11
      Width = 89
      Height = 15
      HelpContext = 184020
      Alignment = taRightJustify
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Sales Selected :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitLeft = 868
    end
    object btnSave: TDNMSpeedButton
      Left = 516
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 184004
      Anchors = [akBottom]
      Caption = 'Save'
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
      AutoDisableParentOnclick = True
      OnClick = actSaveExecute
    end
    object btnAutoSchedule: TDNMSpeedButton
      Left = 20
      Top = 11
      Width = 110
      Height = 27
      HelpContext = 184006
      Anchors = [akLeft, akBottom]
      Caption = 'Auto Schedule'
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
      OnClick = actAutoScheduleExecute
    end
    object btnApply: TDNMSpeedButton
      Left = 380
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 184007
      Anchors = [akBottom]
      Caption = 'Apply'
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = actApplyExecute
    end
    object btnCancel: TDNMSpeedButton
      Left = 647
      Top = 8
      Width = 87
      Height = 27
      HelpContext = 184005
      Anchors = [akBottom]
      Caption = 'Close'
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
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = actCancelExecute
    end
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 192
    Top = 136
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 216
    Top = 136
  end
  inherited MyConnection: TERPConnection
    Left = 232
    Top = 135
  end
  inherited DataState: TDataState
    Left = 160
    Top = 136
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    OnPopup = popCustomiseGridPopup
    Left = 392
    Top = 176
    inherited CustomiseGrid: TMenuItem
      Visible = False
    end
    object N1: TMenuItem
      Caption = '-'
      HelpContext = 184021
    end
    object FlagasScheduled1: TMenuItem
      Caption = 'Flag as Scheduled'
      HelpContext = 184022
      OnClick = actScheduledExecute
    end
    object FlagasStarted1: TMenuItem
      Caption = 'Flag as Started'
      HelpContext = 184023
      OnClick = actStartExecute
    end
    object FlagasComplete1: TMenuItem
      Caption = 'Flag as Complete'
      HelpContext = 184024
      OnClick = actCompleteExecute
    end
    object FlagasCompleteandEdit1: TMenuItem
      Caption = 'Edit and Flag as Complete'
      HelpContext = 184025
      OnClick = FlagasCompleteandEdit1Click
    end
    object FlagasQualityAssurance1: TMenuItem
      Caption = 'Flag as Quality Assurance'
      HelpContext = 184026
      OnClick = actQualityAssuranceExecute
    end
    object FlagasNotScheduled1: TMenuItem
      Caption = 'Flag as Not Scheduled'
      HelpContext = 184027
      OnClick = actNotScheduledExecute
    end
    object N2: TMenuItem
      Caption = '-'
      HelpContext = 184028
    end
    object mnuGoodOrderStatus: TMenuItem
      Caption = 'Goods Order Status'
      HelpContext = 184029
      OnClick = mnuGoodOrderStatusClick
    end
    object OpenSale1: TMenuItem
      Caption = 'Open Sale'
      HelpContext = 184030
      OnClick = actOpenSaleExecute
    end
    object ProductTree1: TMenuItem
      Caption = 'Product Tree'
      HelpContext = 184031
      OnClick = actProductTreeExecute
    end
    object BinBatchSerialNoPickingSlip1: TMenuItem
      Action = actallocPickingSlip
    end
    object CreatePickingSlip1: TMenuItem
      Caption = 'Print Picking Slip'
      HelpContext = 184032
      OnClick = actCreatePickingSlipExecute
    end
    object ProductionWorkSheets1: TMenuItem
      Caption = 'Production Work Sheets'
      HelpContext = 184033
      OnClick = actPrintWorkSheetsExecute
    end
    object CompleteandInvoice1: TMenuItem
      Caption = 'Complete and Invoice'
      HelpContext = 184034
      OnClick = actInvoiceExecute
    end
    object OrderStatus1: TMenuItem
      Action = actOrderStatus
    end
    object PrintJobDetails1: TMenuItem
      Action = actPrintJobDetails
    end
    object N3: TMenuItem
      Caption = '-'
      HelpContext = 184035
    end
    object Roster1: TMenuItem
      Action = actRoster
    end
    object actLogTree1: TMenuItem
      Action = actLogTree
    end
    object StowAways1: TMenuItem
      Action = actStowAway
    end
    object PQAAllocation1: TMenuItem
      Action = actPQAllocation
    end
    object mnuPartialInvoice: TMenuItem
      Action = actPartialInvoice
    end
    object mnuPartialShipments: TMenuItem
      Caption = 'Partial Invoices Created'
      HelpContext = 184036
      OnClick = mnuPartialShipmentsClick
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102007401E00110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited ActionList: TActionList
    inherited actStart: TAction
      OnExecute = actStartExecute
    end
    inherited actComplete: TAction
      OnExecute = actCompleteExecute
    end
    inherited actScheduled: TAction
      OnExecute = actScheduledExecute
    end
    inherited actNotScheduled: TAction
      OnExecute = actNotScheduledExecute
    end
    inherited actOpenSale: TAction
      OnExecute = actOpenSaleExecute
    end
    inherited actProductTree: TAction
      OnExecute = actProductTreeExecute
    end
    inherited actAutoSchedule: TAction
      OnExecute = actAutoScheduleExecute
    end
    inherited actApply: TAction
      OnExecute = actApplyExecute
    end
    inherited actCreatePickingSlip: TAction
      OnExecute = actCreatePickingSlipExecute
    end
    inherited actPrintWorkSheets: TAction
      OnExecute = actPrintWorkSheetsExecute
    end
    inherited actInvoice: TAction
      OnExecute = actInvoiceExecute
    end
    inherited actQualityAssurance: TAction
      OnExecute = actQualityAssuranceExecute
    end
    object actOrderStatus: TDNMAction
      Caption = 'Order Status'
      HelpContext = 184037
      OnExecute = actOrderStatusExecute
      buttoncolor = clWhite
    end
    object actRoster: TDNMAction
      Caption = 'Roster'
      HelpContext = 184038
      OnExecute = actRosterExecute
      OnUpdate = actRosterUpdate
      buttoncolor = clWhite
    end
    object actLogTree: TDNMAction
      Caption = 'Log Tree'
      HelpContext = 184039
      OnExecute = actLogTreeExecute
      buttoncolor = clWhite
    end
    object actStowAway: TDNMAction
      Caption = 'Stow Aways'
      HelpContext = 184040
      OnExecute = actStowAwayExecute
      buttoncolor = clWhite
    end
    object actPrintJobDetails: TDNMAction
      Caption = 'Print Job Details'
      HelpContext = 184041
      OnExecute = actPrintJobDetailsExecute
      buttoncolor = clWhite
    end
    object actPQAllocation: TDNMAction
      Caption = 'Bin / Batch / Serial Number Allocation'
      HelpContext = 184042
      OnExecute = actPQAllocationExecute
      buttoncolor = clWhite
    end
    object actallocPickingSlip: TDNMAction
      Caption = #39'Bin / Batch / Serial No'#39' Picking Slip'
      HelpContext = 184043
      ImageIndex = 0
      OnExecute = actallocPickingSlipExecute
      buttoncolor = clWhite
    end
    object actPartialInvoice: TDNMAction
      Caption = 'Make a Partial Invoice'
      HelpContext = 184044
      OnExecute = actPartialInvoiceExecute
      buttoncolor = clWhite
    end
  end
end
