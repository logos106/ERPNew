object frEDIMap: TfrEDIMap
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  Align = alClient
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object pnlMain: TDNMPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 304
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    DesignSize = (
      451
      304)
    object lblColumnCount: TLabel
      Left = 6
      Top = 12
      Width = 93
      Height = 15
      HelpContext = 845016
      Caption = 'ERP Target Item:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object grdMap: TAdvStringGrid
      Left = 214
      Top = 8
      Width = 1332
      Height = 398
      Cursor = crDefault
      Anchors = [akLeft, akTop, akRight, akBottom]
      DrawingStyle = gdsClassic
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      ParentFont = False
      PopupMenu = popMap
      ScrollBars = ssBoth
      TabOrder = 0
      OnDblClickCell = grdMapDblClickCell
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Tahoma'
      ActiveCellFont.Style = [fsBold]
      ColumnHeaders.Strings = (
        'Index'
        'Source'
        'Source Function'
        'Target'
        'Target Function')
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
      FixedColWidth = 43
      FixedRowHeight = 22
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWindowText
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = [fsBold]
      FloatFormat = '%.2f'
      PrintSettings.DateFormat = 'dd/mm/yyyy'
      PrintSettings.Font.Charset = DEFAULT_CHARSET
      PrintSettings.Font.Color = clWindowText
      PrintSettings.Font.Height = -11
      PrintSettings.Font.Name = 'Tahoma'
      PrintSettings.Font.Style = []
      PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
      PrintSettings.FixedFont.Color = clWindowText
      PrintSettings.FixedFont.Height = -11
      PrintSettings.FixedFont.Name = 'Tahoma'
      PrintSettings.FixedFont.Style = []
      PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
      PrintSettings.HeaderFont.Color = clWindowText
      PrintSettings.HeaderFont.Height = -11
      PrintSettings.HeaderFont.Name = 'Tahoma'
      PrintSettings.HeaderFont.Style = []
      PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
      PrintSettings.FooterFont.Color = clWindowText
      PrintSettings.FooterFont.Height = -11
      PrintSettings.FooterFont.Name = 'Tahoma'
      PrintSettings.FooterFont.Style = []
      PrintSettings.PageNumSep = '/'
      SearchFooter.FindNextCaption = 'Find &next'
      SearchFooter.FindPrevCaption = 'Find &previous'
      SearchFooter.Font.Charset = DEFAULT_CHARSET
      SearchFooter.Font.Color = clWindowText
      SearchFooter.Font.Height = -11
      SearchFooter.Font.Name = 'Tahoma'
      SearchFooter.Font.Style = []
      SearchFooter.HighLightCaption = 'Highlight'
      SearchFooter.HintClose = 'Close'
      SearchFooter.HintFindNext = 'Find next occurence'
      SearchFooter.HintFindPrev = 'Find previous occurence'
      SearchFooter.HintHighlight = 'Highlight occurences'
      SearchFooter.MatchCaseCaption = 'Match case'
      Version = '5.6.0.1'
      ColWidths = (
        43
        118
        214
        152
        258)
    end
    object cboERPClassName: TComboBox
      Left = 6
      Top = 28
      Width = 187
      Height = 23
      Style = csDropDownList
      TabOrder = 1
      OnChange = cboERPClassNameChange
      Items.Strings = (
        'ERPInvoice'
        'TPurchaseOrder')
    end
    object pagesChange: TPageControl
      Left = 6
      Top = 70
      Width = 205
      Height = 260
      ActivePage = tabHeader
      TabOrder = 2
      object tabHeader: TTabSheet
        Caption = 'Header'
        object pnlHeader: TDNMPanel
          Left = 0
          Top = 0
          Width = 197
          Height = 230
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          Transparent = False
          object Label1: TLabel
            Left = 6
            Top = 7
            Width = 163
            Height = 15
            HelpContext = 845016
            Caption = 'New ERP Item On Change Of:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lblInputColumnsHeader: TLabel
            Left = 6
            Top = 53
            Width = 84
            Height = 15
            HelpContext = 845016
            Caption = 'Input Columns:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lblColumnChangeTypeHeader: TLabel
            Left = 9
            Top = 184
            Width = 121
            Height = 15
            HelpContext = 845016
            Caption = 'Column Change Type:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object cboHeaderChangeType: TwwDBComboBox
            Left = 6
            Top = 24
            Width = 185
            Height = 23
            ShowButton = True
            Style = csDropDownList
            MapList = True
            AllowClearKey = False
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            Items.Strings = (
              'Change of Column Data'#9'Column'
              'Input File Row Change'#9'Row')
            ParentFont = False
            Sorted = False
            TabOrder = 0
            UnboundDataType = wwDefault
            OnChange = cboHeaderChangeTypeChange
          end
          object lstColsHeader: TCheckListBox
            Left = 6
            Top = 70
            Width = 185
            Height = 111
            OnClickCheck = lstColsHeaderClickCheck
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            TabOrder = 1
          end
          object cboChangeTypeHeader: TwwDBComboBox
            Left = 6
            Top = 201
            Width = 185
            Height = 23
            ShowButton = True
            Style = csDropDownList
            MapList = True
            AllowClearKey = False
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            Items.Strings = (
              'Any of Selected Cols Change'#9'or'
              'All of Selected Cols Change'#9'and')
            ParentFont = False
            Sorted = False
            TabOrder = 2
            UnboundDataType = wwDefault
            OnChange = cboChangeTypeHeaderChange
          end
        end
      end
      object tabLines: TTabSheet
        Caption = 'Lines'
        ImageIndex = 1
        object pnlLines: TDNMPanel
          Left = 0
          Top = 0
          Width = 197
          Height = 230
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
          Transparent = False
          object Label2: TLabel
            Left = 6
            Top = 7
            Width = 136
            Height = 15
            HelpContext = 845016
            Caption = 'New Line On Change Of:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lblInputColumnsLine: TLabel
            Left = 6
            Top = 53
            Width = 84
            Height = 15
            HelpContext = 845016
            Caption = 'Input Columns:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object lblColumnChangeTypeLine: TLabel
            Left = 9
            Top = 184
            Width = 121
            Height = 15
            HelpContext = 845016
            Caption = 'Column Change Type:'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
          end
          object cboLineChangeType: TwwDBComboBox
            Left = 6
            Top = 24
            Width = 185
            Height = 23
            ShowButton = True
            Style = csDropDownList
            MapList = True
            AllowClearKey = False
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            Items.Strings = (
              'Change of Column Data'#9'Column'
              'Input File Row Change'#9'Row')
            ParentFont = False
            Sorted = False
            TabOrder = 0
            UnboundDataType = wwDefault
            OnChange = cboLineChangeTypeChange
          end
          object lstColsLine: TCheckListBox
            Left = 6
            Top = 70
            Width = 185
            Height = 111
            OnClickCheck = lstColsLineClickCheck
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 15
            ParentFont = False
            TabOrder = 1
          end
          object cboChangeTypeLine: TwwDBComboBox
            Left = 6
            Top = 201
            Width = 185
            Height = 23
            ShowButton = True
            Style = csDropDownList
            MapList = True
            AllowClearKey = False
            DropDownCount = 8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ItemHeight = 0
            Items.Strings = (
              'Any of Selected Cols Change'#9'or'
              'All of Selected Cols Change'#9'and')
            ParentFont = False
            Sorted = False
            TabOrder = 2
            UnboundDataType = wwDefault
            OnChange = cboChangeTypeLineChange
          end
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 264
    Top = 64
    object actEdit: TAction
      Caption = 'Edit'
      OnExecute = actEditExecute
    end
    object actNew: TAction
      Caption = 'New'
      OnExecute = actNewExecute
    end
    object actDelete: TAction
      Caption = 'Delete'
      OnExecute = actDeleteExecute
    end
  end
  object popMap: TPopupMenu
    Left = 320
    Top = 64
    object Edit1: TMenuItem
      Action = actEdit
    end
    object New1: TMenuItem
      Action = actNew
    end
    object Delete1: TMenuItem
      Action = actDelete
    end
  end
end
