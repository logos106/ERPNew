object frameTree: TframeTree
  Left = 0
  Top = 0
  Width = 435
  Height = 265
  Align = alClient
  Anchors = []
  TabOrder = 0
  TabStop = True
  object Label1: TLabel
    Left = 0
    Top = 24
    Width = 435
    Height = 13
    Align = alTop
    Caption = 'Label1'
    Visible = False
    ExplicitWidth = 31
  end
  object lblFooterMsg: TLabel
    Left = 0
    Top = 49
    Width = 435
    Height = 15
    Align = alBottom
    Alignment = taCenter
    Caption = 'lblFooterMsg'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    Visible = False
    OnDblClick = lblTotalQtyDblClick
    ExplicitWidth = 73
  end
  object vstProcessPart: TVirtualStringTree
    Left = 0
    Top = 37
    Width = 435
    Height = 12
    Align = alClient
    Anchors = []
    BiDiMode = bdLeftToRight
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clWhite
    Ctl3D = True
    DefaultNodeHeight = 25
    DragMode = dmAutomatic
    DragOperations = [doMove]
    DragType = dtVCL
    EditDelay = 100
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Header.AutoSizeIndex = 0
    Header.DefaultHeight = 30
    Header.Font.Charset = ANSI_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -12
    Header.Font.Name = 'Arial'
    Header.Font.Style = [fsBold]
    Header.Height = 60
    Header.Options = [hoColumnResize, hoDrag, hoVisible]
    Header.Style = hsXPStyle
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    ParentShowHint = False
    PopupMenu = mnuTree
    RootNodeCount = 1
    ShowHint = True
    TabOrder = 0
    TreeOptions.AutoOptions = [toAutoDropExpand, toAutoHideButtons, toAutoDeleteMovedNodes, toDisableAutoscrollOnFocus, toDisableAutoscrollOnEdit]
    TreeOptions.MiscOptions = [toAcceptOLEDrop, toCheckSupport, toEditable, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toWheelPanning]
    TreeOptions.PaintOptions = [toHideFocusRect, toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toShowVertGridLines, toThemeAware, toUseBlendedImages, toUseBlendedSelection]
    TreeOptions.SelectionOptions = [toRightClickSelect]
    Visible = False
    OnAfterCellPaint = vstProcessPartAfterCellPaint
    OnAfterPaint = vstProcessPartAfterPaint
    OnBeforeCellPaint = vstProcessPartBeforeCellPaint
    OnClick = vstProcessPartClick
    OnCollapsed = vstProcessPartCollapsed
    OnColumnClick = vstProcessPartColumnClick
    OnCreateEditor = vstProcessPartCreateEditor
    OnDblClick = HandleDblClick
    OnDragOver = vstProcessPartDragOver
    OnDragDrop = vstProcessPartDragDrop
    OnDrawText = vstProcessPartDrawText
    OnEditing = vstProcessPartEditing
    OnExit = vstProcessPartExit
    OnFreeNode = vstProcessPartFreeNode
    OnGetText = vstProcessPartGetText
    OnInitNode = vstProcessPartInitNode
    OnMouseDown = vstProcessPartMouseDown
    OnNewText = vstProcessPartNewText
    Columns = <
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 0
        Width = 130
        WideText = 'Tree'
        WideHint = 'Double click to select product'
      end
      item
        Alignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 1
        Width = 45
        WideText = 'Qty Per'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 2
        Width = 105
        WideText = 'Description'
      end
      item
        Position = 3
        WideText = 'Formula Qty'
      end
      item
        Position = 4
        WideText = 'Formula Qty1'
      end
      item
        Position = 5
        WideText = 'Formula Qty2'
      end
      item
        Position = 6
        WideText = 'Formula Qty3'
      end
      item
        Position = 7
        WideText = 'Formula Qty4'
      end
      item
        Position = 8
        WideText = 'Formula Qty5'
      end
      item
        Alignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 9
        Width = 77
        WideText = 'Qty'
      end
      item
        Alignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 10
        Width = 77
        WideText = 'From Stock Qty'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 11
        Width = 70
        WideText = 'FormulaQty'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 12
        WideText = 'FormulaQty1'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 13
        WideText = 'FormulaQty2'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 14
        WideText = 'FormulaQty3'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 15
        WideText = 'FormulaQty4'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 16
        WideText = 'FormulaQty5'
      end
      item
        Alignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 17
        Width = 77
        WideText = 'To Build Qty'
      end
      item
        Color = clWhite
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 18
        Width = 70
        WideText = 'FormulaQty'
      end
      item
        Color = clWhite
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 19
        Width = 70
        WideText = 'FormulaQty1'
      end
      item
        Color = clWhite
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 20
        Width = 70
        WideText = 'FormulaQty2'
      end
      item
        Color = clWhite
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 21
        Width = 70
        WideText = 'FormulaQty3'
      end
      item
        Color = clWhite
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 22
        Width = 70
        WideText = 'FormulaQty4'
      end
      item
        Color = clWhite
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 23
        Width = 70
        WideText = 'FormulaQty5'
      end
      item
        Alignment = taCenter
        Color = clWhite
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 24
        Width = 77
        WideText = 'To Order Qty'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 25
        Width = 80
        WideText = 'UOM (Multi)'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 26
        Width = 140
        WideText = 'Option'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 27
        Width = 75
        WideText = 'Avg. Cost'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 28
        Width = 75
        WideText = 'Cost for Qty'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 29
        Width = 75
        WideText = 'Labour'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 30
        Width = 75
        WideText = 'Unit Price'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 31
        Width = 75
        WideText = 'Total Price'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 32
        Width = 108
        WideText = 'Process Steps'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 33
        Width = 75
        WideText = 'Labour Extra Info'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 34
        WideText = 'Input Type'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 35
        Width = 81
        WideText = 'Price Matrix'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 36
        Width = 105
        WideText = 'Show on Sale'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 37
        Width = 100
        WideText = 'Hide On Print'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 38
        Width = 80
        WideText = 'UOM Parent'
      end
      item
        Alignment = taRightJustify
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 39
        Width = 80
        WideText = 'Total Qty'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 40
        Width = 96
        WideText = 'Source'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 41
        Width = 80
        WideText = 'Details'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 42
        Width = 100
        WideText = 'Custom input'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 43
        WideText = 'Qty / Coupon'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 44
        WideText = 'Rate / coupon'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 45
        WideText = 'Make Coupons'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 46
        WideText = '0 when < 1'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 47
        WideText = 'Round to Next'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 48
        WideText = 'Round to Previous'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 49
        Width = 140
        WideText = 'Info'
      end
      item
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAllowFocus, coWrapCaption]
        Position = 50
        WideText = 'IgnoreItemCommentsforDescription'
      end
      item
        Position = 51
        WideText = 'SubBOMProcessOrder'
      end>
  end
  object pnlOptions: TDNMPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 24
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    Transparent = False
    object lblDetails: TLabel
      Left = 858
      Top = 1
      Width = 881
      Height = 22
      Align = alClient
      Alignment = taRightJustify
      Caption = 'Tot Qty'
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitWidth = 34
      ExplicitHeight = 14
    end
    object lblHint: TLabel
      Left = 246
      Top = 1
      Width = 267
      Height = 22
      Align = alLeft
      Alignment = taCenter
      AutoSize = False
      Caption = '[UOM Parent] = [Qty] * ["UOM (Multi)" Parent Quantity]'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      WordWrap = True
      ExplicitLeft = 248
      ExplicitTop = -4
    end
    object Bevel1: TBevel
      Left = 242
      Top = 1
      Width = 4
      Height = 22
      Align = alLeft
      Shape = bsLeftLine
      ExplicitLeft = 265
      ExplicitTop = 0
    end
    object Bevel2: TBevel
      Left = 513
      Top = 1
      Width = 1
      Height = 22
      Align = alLeft
      Shape = bsLeftLine
      ExplicitLeft = 536
      ExplicitTop = 0
    end
    object lblmsg: TLabel
      Left = 514
      Top = 1
      Width = 344
      Height = 22
      Align = alLeft
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Msh'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      Visible = False
      WordWrap = True
      ExplicitLeft = 98
      ExplicitTop = 0
    end
    object chkHideQtyPercolumn: TCheckBox
      Left = 1
      Top = 1
      Width = 90
      Height = 22
      HelpContext = 507028
      Align = alLeft
      Caption = 'Hide Qty Per'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 0
      OnClick = chkHideQtyPercolumnClick
    end
    object chkHideFormulacolumns: TCheckBox
      Left = 91
      Top = 1
      Width = 151
      Height = 22
      Hint = 
        'To Add or remove fomula columns :  Preference -> Inventory -> Pr' +
        'oducts: fields to calculate Quantity'
      HelpContext = 507028
      Align = alLeft
      Caption = 'Hide Formula Columns'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 1
      OnClick = chkHideFormulacolumnsClick
    end
    object btnBOMcostnPriceCalc: TDNMSpeedButton
      Left = 254
      Top = 1
      Width = 180
      Height = 22
      HelpContext = 314704
      Align = alRight
      Caption = 'Calc BOM Cost n Price'
      Color = clMaroon
      ColorWhenDown = clRed
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 2
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnBOMcostnPriceCalcClick
    end
  end
  object pnlFooter: TDNMPanel
    Left = 0
    Top = 245
    Width = 435
    Height = 20
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    OnDblClick = pnlFooterDblClick
    Transparent = False
    object lblTotalCost: TLabel
      Left = 430
      Top = 1
      Width = 35
      Height = 15
      Alignment = taRightJustify
      Caption = 'Cost : '
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      OnDblClick = lblTotalCostDblClick
    end
    object lblTotalPrice: TLabel
      Left = 720
      Top = 1
      Width = 99
      Height = 15
      Alignment = taRightJustify
      Caption = 'Price Inc Labour :'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      OnDblClick = lblTotalPriceDblClick
    end
    object lblTotalQty: TLabel
      Left = 210
      Top = 1
      Width = 28
      Height = 15
      Alignment = taRightJustify
      Caption = 'Qty : '
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      OnDblClick = lblTotalQtyDblClick
    end
    object lblcostIncLabour: TLabel
      Left = 545
      Top = 1
      Width = 89
      Height = 15
      Alignment = taRightJustify
      Caption = 'Cost Inc Labour'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      OnDblClick = lblcostIncLabourDblClick
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 64
    Width = 435
    Height = 181
    Align = alBottom
    Color = clGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      '                       EVENTS OF THE VIRTUAL STRING TREE'
      '             ====================================='
      'BeginEdit            : To make the column enabled / disabled'
      'DisplayForMode : Make columns visible / invisible'
      'GetText             : To Set the text for columns'
      'NewText            : On change'
      'CreateEditor      : Creates the editor : combo/editbox etc'
      'Cell colour         :  BeforeCellPaint and DrawText'
      'Loading Tree    : GetProcTree in Product and Sales extender'
      'Treecolumn      : to set focus to a column'
      'Scroll to column :  vstProcessPart.ScrollIntoView')
    ParentFont = False
    TabOrder = 3
    Visible = False
  end
  object mnuTree: TAdvPopupMenu
    OnPopup = mnuTreePopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 313
    Top = 202
    object miAddBranch: TMenuItem
      Caption = 'Add Branch'
      Enabled = False
      OnClick = miAddBranchClick
    end
    object AddProduct1: TMenuItem
      Caption = 'Add Product'
      OnClick = AddProduct1Click
    end
    object miInsert: TMenuItem
      Caption = 'Insert'
      Enabled = False
      OnClick = miInsertClick
    end
    object miDelete: TMenuItem
      Caption = 'Delete'
      Enabled = False
      OnClick = miDeleteClick
    end
    object mnuRecalculatePricefromProduct: TMenuItem
      Caption = 'Recalculate Price from Product'
      OnClick = mnuRecalculatePricefromProductClick
    end
    object mnutreeProductsAvgCostList1: TMenuItem
      Caption = 'Tree Products Avg Cost List'
      OnClick = mnutreeProductsAvgCostList1Click
    end
    object mnuInfosep: TMenuItem
      Caption = '-'
    end
    object mnuInfoToSales: TMenuItem
      Caption = 'Copy Info To Sales Comments'
      OnClick = mnuInfoToSalesClick
    end
    object mnuInfofromSales: TMenuItem
      Caption = 'Copy Info From Sales Comments'
      OnClick = mnuInfofromSalesClick
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 361
    Top = 202
  end
  object dlgInfo: TwwMemoDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    DlgLeft = 0
    DlgTop = 0
    DlgWidth = 561
    DlgHeight = 396
    OnUserButton1Click = dlgInfoUserButton1Click
    UserButton1Caption = ' Choose From List '
    Left = 313
    Top = 174
  end
  object TmrMsg: TTimer
    Enabled = False
    Interval = 2000
    Left = 361
    Top = 174
  end
end
