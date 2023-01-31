object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Lead Sync'
  ClientHeight = 409
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object sbMain: TStatusBar
    Left = 0
    Top = 390
    Width = 742
    Height = 19
    Panels = <
      item
        Style = psOwnerDraw
        Text = 'Active'
        Width = 100
      end
      item
        Style = psOwnerDraw
        Text = 'Status'
        Width = 300
      end>
    OnDrawPanel = sbMainDrawPanel
  end
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 742
    Height = 390
    ActivePage = tabMain
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object tabMain: TTabSheet
      Caption = 'Main'
      DesignSize = (
        734
        360)
      object grdSites: TAdvStringGrid
        Left = 0
        Top = 0
        Width = 734
        Height = 297
        Cursor = crDefault
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColCount = 4
        DrawingStyle = gdsClassic
        FixedCols = 0
        RowCount = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
        OnDblClick = grdSitesDblClick
        OnGetEditorType = grdSitesGetEditorType
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ColumnHeaders.Strings = (
          'Site Name'
          'Status'
          'Message'
          'Active')
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
        FixedColWidth = 228
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
          228
          63
          371
          64)
      end
      object btnAddSite: TButton
        Left = 571
        Top = 303
        Width = 49
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Add'
        TabOrder = 1
        OnClick = btnAddSiteClick
      end
      object btnDeleteSite: TButton
        Left = 682
        Top = 303
        Width = 49
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Delete'
        TabOrder = 2
        OnClick = btnDeleteSiteClick
      end
      object btnStart: TButton
        Left = 3
        Top = 330
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Start'
        TabOrder = 3
        OnClick = btnStartClick
      end
      object btnStop: TButton
        Left = 84
        Top = 330
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Stop'
        TabOrder = 4
        OnClick = btnStopClick
      end
      object btnEdit: TButton
        Left = 627
        Top = 303
        Width = 49
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Edit'
        TabOrder = 5
        OnClick = btnEditClick
      end
    end
    object tabLog: TTabSheet
      Caption = 'Log'
      ImageIndex = 1
      object memLog: TMemo
        Left = 0
        Top = 0
        Width = 193
        Height = 153
        ScrollBars = ssBoth
        TabOrder = 0
        Visible = False
      end
    end
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 336
    Top = 80
  end
end
