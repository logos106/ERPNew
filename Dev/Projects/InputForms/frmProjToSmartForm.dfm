inherited ProjToSmartGUI: TProjToSmartGUI
  Left = 216
  Top = 185
  HelpContext = 454000
  Caption = ''
  ClientHeight = 388
  ClientWidth = 757
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 632
    Top = 352
    Width = 110
    Height = 15
    HelpContext = 454002
    Caption = 'Don'#39't Remind Again'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 454001
  end
  object btnCancel: TDNMSpeedButton [2]
    Left = 392
    Top = 344
    Width = 159
    Height = 27
    HelpContext = 454003
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
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pnlProject: TDNMPanel [3]
    Left = 116
    Top = 74
    Width = 497
    Height = 42
    HelpContext = 454004
    Caption = 'pnlProject'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 18
    Top = 130
    Width = 726
    Height = 198
    HelpContext = 454005
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object grdParts: TAdvStringGrid
      Left = 3
      Top = 3
      Width = 720
      Height = 191
      Cursor = crDefault
      HelpContext = 454006
      ColCount = 6
      DefaultRowHeight = 21
      FixedCols = 0
      RowCount = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing]
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      OnCellChanging = grdPartsCellChanging
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'MS Sans Serif'
      ActiveCellFont.Style = [fsBold]
      CellNode.ShowTree = False
      CellNode.TreeColor = clSilver
      ColumnHeaders.Strings = (
        'Part Name'
        'Description'
        'Required'
        'Stock'
        'Order')
      ControlLook.ControlStyle = csClassic
      EnhRowColMove = False
      Filter = <>
      FixedColWidth = 166
      FixedRowAlways = True
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = []
      FloatFormat = '%.2f'
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
      PrintSettings.Borders = pbNoborder
      PrintSettings.Centered = False
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
      SelectionColor = clHighlight
      SelectionTextColor = clHighlightText
      Version = '3.6.0.2'
      WordWrap = False
      ColWidths = (
        166
        376
        49
        46
        37
        64)
      RowHeights = (
        21
        21
        21
        21
        21)
    end
  end
  object chkNoRemind: TCheckBox [5]
    Left = 615
    Top = 352
    Width = 13
    Height = 17
    HelpContext = 454007
    Caption = 'Don'#39't Remind Again'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object btnOK: TDNMSpeedButton [6]
    Left = 192
    Top = 344
    Width = 159
    Height = 27
    HelpContext = 454008
    Action = actCreateSmartOrder
    Caption = 'C&reate Smart Order'
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
    TabOrder = 0
  end
  object pnlTitle: TDNMPanel [7]
    Left = 94
    Top = 12
    Width = 538
    Height = 45
    HelpContext = 454009
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 534
      Height = 41
      HelpContext = 454010
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
        Width = 534
        Height = 41
        HelpContext = 454011
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Project Smart Order Generation'
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
  object qryParts: TMyQuery
    SQL.Strings = (
      
        'SELECT GroupProductID, G.ProductID, G.Description, G.Qty as Rqd,' +
        ' '
      'd2.PartName, d2.PARTSID, d2.TaxCode, PartsDescription, ClientID,'
      'BuyQTY1, BuyQty2, BuyQty3, COST1, COST2, COST3, PARTTYPE'
      'FROM tblgroupings as G'
      'LEFT JOIN tblParts AS d2 ON G.GroupProductID = d2.PartsID'
      'LEFT JOIN tblClients ON d2.PreferedSupp = tblClients.Company'
      'WHERE GroupProductID = :xGroupProductID')
    Left = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xGroupProductID'
      end>
  end
  object qryPartsQty: TMyQuery
    SQL.Strings = (
      'SELECT G.ProductID, G.Description, G.Qty as Rqd, '
      'd1.ProductName, d1.ProductID, PartsDescription,'
      'ClientID, ClassID,'
      'BuyQTY1, BuyQty2, BuyQty3, COST1, COST2, COST3,'
      'InStockQty, SalesOrdersQty, InvoiceBOQty,'
      'OnOrderQty, ReOrderPoint, ReorderAmount, PreferredLevel,'
      'InStockQty - SalesOrdersQty - InvoiceBOQty + OnOrderQty as Qty'
      'FROM tblgroupings as G'
      
        'LEFT JOIN tblPartQtyLines AS d1 ON G.GroupProductID =  d1.Produc' +
        'tID'
      'LEFT JOIN tblParts AS d2 ON d1.ProductID = d2.PartsID'
      'LEFT JOIN tblClients ON d2.PreferedSupp = tblClients.Company'
      'WHERE ClassID = :xClassID and GroupProductID = :xGroupProductID'
      '')
    Left = 208
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xClassID'
      end
      item
        DataType = ftUnknown
        Name = 'xGroupProductID'
      end>
  end
  object ActionList1: TActionList
    Left = 16
    Top = 56
    object actCreateSmartOrder: TAction
      Caption = 'Create Smart Order'
      OnExecute = actCreateSmartOrderExecute
      OnUpdate = actCreateSmartOrderUpdate
    end
  end
end
