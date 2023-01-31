inherited frmProject: TfrmProject
  Left = 138
  Top = 248
  Caption = 'Project View & Gantt Chart'
  ClientHeight = 560
  ClientWidth = 1009
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 336000
  object Label9: TLabel [0]
    Left = 912
    Top = 16
    Width = 83
    Height = 15
    Caption = 'Show Address'
    Transparent = True
    HelpContext = 336002
  end
  object cmdCancel: TDNMSpeedButton [2]
    Left = 641
    Top = 516
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Caption = '&Cancel'
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
    OnClick = cmdCancelClick
    HelpContext = 336003
  end
  object btnPrint: TDNMSpeedButton [3]
    Left = 463
    Top = 516
    Width = 87
    Height = 27
    Caption = '&Print'
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
    OnClick = btnPrintClick
    HelpContext = 336004
  end
  object chkShowAddress: TCheckBox [4]
    Left = 896
    Top = 16
    Width = 15
    Height = 17
    Caption = 'chkShowAddress'
    TabOrder = 4
    OnClick = chkShowAddressClick
    HelpContext = 336005
  end
  object ProjectPageControl: TPageControl [5]
    Left = 0
    Top = 48
    Width = 1009
    Height = 449
    Hint = 'Match "Link To" and "Line No" to establish a link between tasks'
    ActivePage = tabAll
    ParentShowHint = False
    ShowHint = False
    TabHeight = 27
    TabIndex = 2
    TabOrder = 0
    TabWidth = 201
    OnChange = ProjectPageControlChange
    OnChanging = ProjectPageControlChanging
    HelpContext = 336006
    object tabGantt: TTabSheet
      Caption = '&Day'
      ImageIndex = 1
      HelpContext = 336007
      object DNMPanel1: TDNMPanel
        Left = 0
        Top = 0
        Width = 1001
        Height = 412
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        HelpContext = 336008
        object Splitter1: TSplitter
          Left = 153
          Top = 0
          Width = 8
          Height = 412
          Cursor = crHSplit
          Align = alRight
          HelpContext = 336009
        end
        object ProjectGant1: TFEGant
          Left = 161
          Top = 0
          Width = 840
          Height = 412
          About.Version = '1.0'
          About.Product = 'Project Plus 1'
          About.Url = 'http://www.fesoft.com/ProjPlus'
          About.Company = 'Fe Software & Development'
          About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
          BorderStyle = bsSingle
          Color = 13434367
          Align = alRight
          BarMilestone.Brush.Color = clLime
          BarMilestone.Layout = tlCenter
          BarMilestone.Height = 12
          BarMilestone.EndImageIndex = -1
          BarMilestone.StartImageIndex = -1
          BarMilestone.Pen.Color = clWindowText
          BarMilestone.Pen.Style = psInsideFrame
          BarMilestone.Pen.Width = 2
          BarMilestone.ProgressBrush.Color = clActiveCaption
          BarMilestone.ProgressPen.Style = psClear
          BarProjectSummary.Brush.Color = clRed
          BarProjectSummary.Layout = tlTop
          BarProjectSummary.Height = 12
          BarProjectSummary.EndImageIndex = -1
          BarProjectSummary.StartImageIndex = -1
          BarProjectSummary.Pen.Color = clWindowText
          BarProjectSummary.ProgressBrush.Color = clActiveCaption
          BarProjectSummary.ProgressPen.Style = psClear
          BarSummary.Brush.Color = clLime
          BarSummary.Layout = tlTop
          BarSummary.Height = 12
          BarSummary.EndImageIndex = -1
          BarSummary.StartImageIndex = -1
          BarSummary.Pen.Color = clWindowText
          BarSummary.ProgressBrush.Color = clInactiveCaption
          BarSummary.ProgressPen.Style = psClear
          BarTask.Brush.Color = clBlue
          BarTask.Layout = tlCenter
          BarTask.Height = 12
          BarTask.EndImageIndex = -1
          BarTask.StartImageIndex = -1
          BarTask.Pen.Color = clWindowText
          BarTask.ProgressBrush.Color = clYellow
          BarTask.ProgressPen.Style = psClear
          CaptionDetail.Color = clBtnFace
          CaptionDetail.DefaultDisplayFormat = False
          CaptionDetail.DisplayFormat = ' '
          CaptionDetail.Font.Charset = DEFAULT_CHARSET
          CaptionDetail.Font.Color = clWindowText
          CaptionDetail.Font.Height = -11
          CaptionDetail.Font.Name = 'MS Sans Serif'
          CaptionDetail.Font.Style = []
          CaptionDetail.LineColor = clBtnFace
          CaptionDetail.LinePenStyle = psSolid
          CaptionDetail.ParentFont = True
          CaptionDetail.Visible = True
          CaptionSummary.Color = clBtnFace
          CaptionSummary.DefaultDisplayFormat = False
          CaptionSummary.DisplayFormat = 'ddd d/MM/yyyy'
          CaptionSummary.Font.Charset = DEFAULT_CHARSET
          CaptionSummary.Font.Color = clWindowText
          CaptionSummary.Font.Height = -11
          CaptionSummary.Font.Name = 'MS Sans Serif'
          CaptionSummary.Font.Style = []
          CaptionSummary.LineColor = clBtnFace
          CaptionSummary.LinePenStyle = psSolid
          CaptionSummary.ParentFont = True
          CaptionSummary.Visible = True
          ColWidth = 5
          LineColor = clInfoText
          LinkLineType = ltSide
          LeftDateTime = 37630
          MaxRow = 0
          MinRow = 0
          Row = 1
          RowHeight = 21
          Scale = gsHour
          TaskList = ProjectTaskList1
          ParentColor = False
          PrintSettings.TitleHeight = 0.5
          PrintSettings.LeftMargin = 0.25
          PrintSettings.TopMargin = 0.025000000372529
          PrintSettings.RightMargin = 0.025000000372529
          PrintSettings.BottomMargin = 0.25
          PrintSettings.Text = '   Platinum1 Gantt Chart Printout'
          PrintSettings.Font.Charset = DEFAULT_CHARSET
          PrintSettings.Font.Color = clWindowText
          PrintSettings.Font.Height = -11
          PrintSettings.Font.Name = 'MS Sans Serif'
          PrintSettings.Font.Style = []
          PrintSettings.Alignment = taCenter
          TabOrder = 1
          OnClick = ProjectGant1Click
          OnMouseMove = ProjectGant1MouseMove
          HelpContext = 336010
        end
        object ProjectTaskGrid1: TFETaskGrid
          Left = 0
          Top = 0
          Width = 153
          Height = 412
          About.Version = '1.0'
          About.Product = 'Project Plus 1'
          About.Url = 'http://www.fesoft.com/ProjPlus'
          About.Company = 'Fe Software & Development'
          About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
          BorderStyle = bsSingle
          Align = alClient
          Col = 0
          Columns = <
            item
              Tag = 0
              TaskField = tfName
              Title.Caption = 'Task List'
              Width = 175
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfStartDateTime
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfEndDateTime
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfProgress
              Visible = True
            end>
          LeftCol = 0
          Options = [tgFixedVertLine, tgFixedHorzLine, tgColLines, tgRowLines, tgHighlightSelected, tgColSizing, tgColMoving, tgTabs, tgTitles, tgIndicator]
          ParentColor = False
          PopupMenu = TaskLisTAdvPopupMenu
          ReadOnly = True
          Row = 0
          RowHeight = 21
          TabOrder = 0
          TabStop = True
          TitleColor = clBtnFace
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitleAlignment = taLeftJustify
          TitleLayout = tlCenter
          TitleHeight = 42
          TopRow = 0
          TaskList = ProjectTaskList1
          OnDblClick = ProjectTaskGrid1DblClick
          HelpContext = 336011
        end
      end
    end
    object tabGanttWeek: TTabSheet
      Caption = '&Week'
      ImageIndex = 4
      HelpContext = 336012
      object DNMPanel2: TDNMPanel
        Left = 0
        Top = 0
        Width = 1001
        Height = 412
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        HelpContext = 336013
        object Splitter3: TSplitter
          Left = 153
          Top = 0
          Width = 8
          Height = 412
          Cursor = crHSplit
          Align = alRight
          HelpContext = 336014
        end
        object gantWeek: TFEGant
          Left = 161
          Top = 0
          Width = 840
          Height = 412
          About.Version = '1.0'
          About.Product = 'Project Plus 1'
          About.Url = 'http://www.fesoft.com/ProjPlus'
          About.Company = 'Fe Software & Development'
          About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
          BorderStyle = bsSingle
          Color = 13434367
          Align = alRight
          BarMilestone.Brush.Color = clLime
          BarMilestone.Layout = tlCenter
          BarMilestone.Height = 12
          BarMilestone.EndImageIndex = -1
          BarMilestone.StartImageIndex = -1
          BarMilestone.Pen.Color = clWindowText
          BarMilestone.Pen.Style = psInsideFrame
          BarMilestone.Pen.Width = 2
          BarMilestone.ProgressBrush.Color = clActiveCaption
          BarMilestone.ProgressPen.Style = psClear
          BarProjectSummary.Brush.Color = clRed
          BarProjectSummary.Layout = tlTop
          BarProjectSummary.Height = 12
          BarProjectSummary.EndImageIndex = -1
          BarProjectSummary.StartImageIndex = -1
          BarProjectSummary.Pen.Color = clWindowText
          BarProjectSummary.ProgressBrush.Color = clActiveCaption
          BarProjectSummary.ProgressPen.Style = psClear
          BarSummary.Brush.Color = clLime
          BarSummary.Layout = tlTop
          BarSummary.Height = 12
          BarSummary.EndImageIndex = -1
          BarSummary.StartImageIndex = -1
          BarSummary.Pen.Color = clWindowText
          BarSummary.ProgressBrush.Color = clInactiveCaption
          BarSummary.ProgressPen.Style = psClear
          BarTask.Brush.Color = clBlue
          BarTask.Layout = tlCenter
          BarTask.Height = 12
          BarTask.EndImageIndex = -1
          BarTask.StartImageIndex = -1
          BarTask.Pen.Color = clWindowText
          BarTask.ProgressBrush.Color = clYellow
          BarTask.ProgressPen.Style = psClear
          CaptionDetail.Color = clBtnFace
          CaptionDetail.DefaultDisplayFormat = True
          CaptionDetail.DisplayFormat = 'd'
          CaptionDetail.Font.Charset = DEFAULT_CHARSET
          CaptionDetail.Font.Color = clWindowText
          CaptionDetail.Font.Height = -11
          CaptionDetail.Font.Name = 'MS Sans Serif'
          CaptionDetail.Font.Style = []
          CaptionDetail.LineColor = clBtnFace
          CaptionDetail.LinePenStyle = psSolid
          CaptionDetail.ParentFont = True
          CaptionDetail.Visible = True
          CaptionSummary.Color = clBtnFace
          CaptionSummary.DefaultDisplayFormat = False
          CaptionSummary.DisplayFormat = 'd/MM/yyyy'
          CaptionSummary.Font.Charset = DEFAULT_CHARSET
          CaptionSummary.Font.Color = clWindowText
          CaptionSummary.Font.Height = -11
          CaptionSummary.Font.Name = 'MS Sans Serif'
          CaptionSummary.Font.Style = []
          CaptionSummary.LineColor = clBtnFace
          CaptionSummary.LinePenStyle = psSolid
          CaptionSummary.ParentFont = True
          CaptionSummary.Visible = True
          LineColor = clInfoText
          LinkLineType = ltSide
          LeftDateTime = 37630
          MaxRow = 0
          MinRow = 0
          Row = 1
          RowHeight = 21
          TaskList = ProjectTaskList1
          ParentColor = False
          PrintSettings.TitleHeight = 0.5
          PrintSettings.LeftMargin = 0.25
          PrintSettings.TopMargin = 0.025000000372529
          PrintSettings.RightMargin = 0.025000000372529
          PrintSettings.BottomMargin = 0.25
          PrintSettings.Text = '   Platinum1 Gantt Chart Printout'
          PrintSettings.Font.Charset = DEFAULT_CHARSET
          PrintSettings.Font.Color = clWindowText
          PrintSettings.Font.Height = -11
          PrintSettings.Font.Name = 'MS Sans Serif'
          PrintSettings.Font.Style = []
          PrintSettings.Alignment = taCenter
          TabOrder = 1
          OnClick = ProjectGant1Click
          OnMouseMove = ProjectGant1MouseMove
          HelpContext = 336015
        end
        object FETaskGrid1: TFETaskGrid
          Left = 0
          Top = 0
          Width = 153
          Height = 412
          About.Version = '1.0'
          About.Product = 'Project Plus 1'
          About.Url = 'http://www.fesoft.com/ProjPlus'
          About.Company = 'Fe Software & Development'
          About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
          BorderStyle = bsSingle
          Align = alClient
          Col = 0
          Columns = <
            item
              Tag = 0
              TaskField = tfName
              Title.Caption = 'Task List'
              Width = 175
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfStartDateTime
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfEndDateTime
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfProgress
              Visible = True
            end>
          LeftCol = 0
          Options = [tgFixedVertLine, tgFixedHorzLine, tgColLines, tgRowLines, tgHighlightSelected, tgColSizing, tgColMoving, tgTabs, tgTitles, tgIndicator]
          ParentColor = False
          PopupMenu = TaskLisTAdvPopupMenu
          ReadOnly = True
          Row = 0
          RowHeight = 21
          TabOrder = 0
          TabStop = True
          TitleColor = clBtnFace
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitleAlignment = taLeftJustify
          TitleLayout = tlCenter
          TitleHeight = 42
          TopRow = 0
          TaskList = ProjectTaskList1
          OnDblClick = ProjectTaskGrid1DblClick
          HelpContext = 336016
        end
      end
    end
    object tabAll: TTabSheet
      Caption = 'All P&rojects - Day'
      ImageIndex = 3
      HelpContext = 336017
      object DNMPanel4: TDNMPanel
        Left = 0
        Top = 0
        Width = 1001
        Height = 412
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        HelpContext = 336018
        object Splitter2: TSplitter
          Left = 178
          Top = 1
          Width = 7
          Height = 410
          Cursor = crHSplit
          HelpContext = 336019
        end
        object FETaskGridAll: TFETaskGrid
          Left = 1
          Top = 1
          Width = 177
          Height = 410
          About.Version = '1.0'
          About.Product = 'Project Plus 1'
          About.Url = 'http://www.fesoft.com/ProjPlus'
          About.Company = 'Fe Software & Development'
          About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
          BorderStyle = bsSingle
          Align = alLeft
          Col = 0
          Columns = <
            item
              Tag = 0
              TaskField = tfName
              Title.Caption = 'Project Name'
              Width = 175
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfStartDateTime
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfEndDateTime
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfProgress
              Visible = True
            end>
          LeftCol = 0
          Options = [tgFixedVertLine, tgFixedHorzLine, tgColLines, tgRowLines, tgHighlightSelected, tgColSizing, tgColMoving, tgTabs, tgTitles, tgIndicator]
          ParentColor = False
          PopupMenu = TaskLisTAdvPopupMenu
          ReadOnly = True
          Row = 0
          RowHeight = 21
          TabOrder = 0
          TabStop = True
          TitleColor = clBtnFace
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitleAlignment = taLeftJustify
          TitleLayout = tlCenter
          TitleHeight = 42
          TopRow = 0
          TaskList = TaskListAll
          OnDblClick = FETaskGridAllDblClick
          HelpContext = 336020
        end
        object gantAll: TFEGant
          Left = 185
          Top = 1
          Width = 815
          Height = 410
          About.Version = '1.0'
          About.Product = 'Project Plus 1'
          About.Url = 'http://www.fesoft.com/ProjPlus'
          About.Company = 'Fe Software & Development'
          About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
          BorderStyle = bsSingle
          Color = 14416872
          Align = alClient
          BarMilestone.Brush.Color = clLime
          BarMilestone.Layout = tlCenter
          BarMilestone.Height = 12
          BarMilestone.EndImageIndex = -1
          BarMilestone.StartImageIndex = -1
          BarMilestone.Pen.Color = clWindowText
          BarMilestone.Pen.Style = psInsideFrame
          BarMilestone.Pen.Width = 2
          BarMilestone.ProgressBrush.Color = clActiveCaption
          BarMilestone.ProgressPen.Style = psClear
          BarProjectSummary.Brush.Color = clRed
          BarProjectSummary.Layout = tlTop
          BarProjectSummary.Height = 12
          BarProjectSummary.EndImageIndex = -1
          BarProjectSummary.StartImageIndex = -1
          BarProjectSummary.Pen.Color = clWindowText
          BarProjectSummary.ProgressBrush.Color = clActiveCaption
          BarProjectSummary.ProgressPen.Style = psClear
          BarSummary.Brush.Color = clLime
          BarSummary.Layout = tlTop
          BarSummary.Height = 12
          BarSummary.EndImageIndex = -1
          BarSummary.StartImageIndex = -1
          BarSummary.Pen.Color = clWindowText
          BarSummary.ProgressBrush.Color = clInactiveCaption
          BarSummary.ProgressPen.Style = psClear
          BarTask.Brush.Color = clBlue
          BarTask.Layout = tlCenter
          BarTask.Height = 12
          BarTask.EndImageIndex = -1
          BarTask.StartImageIndex = -1
          BarTask.Pen.Color = clWindowText
          BarTask.ProgressBrush.Color = clYellow
          BarTask.ProgressPen.Style = psClear
          CaptionDetail.Color = clBtnFace
          CaptionDetail.DefaultDisplayFormat = False
          CaptionDetail.DisplayFormat = ' '
          CaptionDetail.Font.Charset = DEFAULT_CHARSET
          CaptionDetail.Font.Color = clWindowText
          CaptionDetail.Font.Height = -11
          CaptionDetail.Font.Name = 'MS Sans Serif'
          CaptionDetail.Font.Style = []
          CaptionDetail.LineColor = clBtnFace
          CaptionDetail.LinePenStyle = psSolid
          CaptionDetail.ParentFont = True
          CaptionDetail.Visible = True
          CaptionSummary.Color = clBtnFace
          CaptionSummary.DefaultDisplayFormat = False
          CaptionSummary.DisplayFormat = 'ddd d/MM/yyyy'
          CaptionSummary.Font.Charset = ANSI_CHARSET
          CaptionSummary.Font.Color = clWindowText
          CaptionSummary.Font.Height = -11
          CaptionSummary.Font.Name = 'Microsoft Sans Serif'
          CaptionSummary.Font.Style = []
          CaptionSummary.LineColor = clBtnFace
          CaptionSummary.LinePenStyle = psSolid
          CaptionSummary.ParentFont = False
          CaptionSummary.Visible = True
          ColWidth = 5
          LineColor = clSilver
          LinkLineType = ltSide
          LeftDateTime = 37630
          MaxRow = 0
          MinRow = 0
          Row = 1
          RowHeight = 21
          Scale = gsHour
          TaskList = TaskListAll
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          PrintSettings.TitleHeight = 0.5
          PrintSettings.LeftMargin = 0.25
          PrintSettings.TopMargin = 0.025000000372529
          PrintSettings.RightMargin = 0.025000000372529
          PrintSettings.BottomMargin = 0.25
          PrintSettings.Text = '   Platinum1 Gantt Chart Printout'
          PrintSettings.Font.Charset = ANSI_CHARSET
          PrintSettings.Font.Color = clWindowText
          PrintSettings.Font.Height = -11
          PrintSettings.Font.Name = 'Arial'
          PrintSettings.Font.Style = []
          PrintSettings.Alignment = taCenter
          ReadOnly = True
          TabOrder = 1
          HelpContext = 336021
        end
      end
    end
    object tabAllWeek: TTabSheet
      Caption = 'All Pr&ojects - Week'
      ImageIndex = 5
      HelpContext = 336022
      object DNMPanel5: TDNMPanel
        Left = 0
        Top = 0
        Width = 1001
        Height = 412
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        HelpContext = 336023
        object Splitter4: TSplitter
          Left = 178
          Top = 1
          Width = 7
          Height = 410
          Cursor = crHSplit
          HelpContext = 336024
        end
        object FETaskGrid2: TFETaskGrid
          Left = 1
          Top = 1
          Width = 177
          Height = 410
          About.Version = '1.0'
          About.Product = 'Project Plus 1'
          About.Url = 'http://www.fesoft.com/ProjPlus'
          About.Company = 'Fe Software & Development'
          About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
          BorderStyle = bsSingle
          Align = alLeft
          Col = 0
          Columns = <
            item
              Tag = 0
              TaskField = tfName
              Title.Caption = 'Project Name'
              Width = 175
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfStartDateTime
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfEndDateTime
              Visible = True
            end
            item
              Tag = 0
              TaskField = tfProgress
              Visible = True
            end>
          LeftCol = 0
          Options = [tgFixedVertLine, tgFixedHorzLine, tgColLines, tgRowLines, tgHighlightSelected, tgColSizing, tgColMoving, tgTabs, tgTitles, tgIndicator]
          ParentColor = False
          PopupMenu = TaskLisTAdvPopupMenu
          ReadOnly = True
          Row = 0
          RowHeight = 21
          TabOrder = 0
          TabStop = True
          TitleColor = clBtnFace
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          TitleAlignment = taLeftJustify
          TitleLayout = tlCenter
          TitleHeight = 42
          TopRow = 0
          TaskList = TaskListAll
          OnDblClick = FETaskGridAllDblClick
          HelpContext = 336025
        end
        object gantAllWeek: TFEGant
          Left = 185
          Top = 1
          Width = 815
          Height = 410
          About.Version = '1.0'
          About.Product = 'Project Plus 1'
          About.Url = 'http://www.fesoft.com/ProjPlus'
          About.Company = 'Fe Software & Development'
          About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
          BorderStyle = bsSingle
          Color = 14416872
          Align = alClient
          BarMilestone.Brush.Color = clLime
          BarMilestone.Layout = tlCenter
          BarMilestone.Height = 12
          BarMilestone.EndImageIndex = -1
          BarMilestone.StartImageIndex = -1
          BarMilestone.Pen.Color = clWindowText
          BarMilestone.Pen.Style = psInsideFrame
          BarMilestone.Pen.Width = 2
          BarMilestone.ProgressBrush.Color = clActiveCaption
          BarMilestone.ProgressPen.Style = psClear
          BarProjectSummary.Brush.Color = clRed
          BarProjectSummary.Layout = tlTop
          BarProjectSummary.Height = 12
          BarProjectSummary.EndImageIndex = -1
          BarProjectSummary.StartImageIndex = -1
          BarProjectSummary.Pen.Color = clWindowText
          BarProjectSummary.ProgressBrush.Color = clActiveCaption
          BarProjectSummary.ProgressPen.Style = psClear
          BarSummary.Brush.Color = clLime
          BarSummary.Layout = tlTop
          BarSummary.Height = 12
          BarSummary.EndImageIndex = -1
          BarSummary.StartImageIndex = -1
          BarSummary.Pen.Color = clWindowText
          BarSummary.ProgressBrush.Color = clInactiveCaption
          BarSummary.ProgressPen.Style = psClear
          BarTask.Brush.Color = clBlue
          BarTask.Layout = tlCenter
          BarTask.Height = 12
          BarTask.EndImageIndex = -1
          BarTask.StartImageIndex = -1
          BarTask.Pen.Color = clWindowText
          BarTask.ProgressBrush.Color = clYellow
          BarTask.ProgressPen.Style = psClear
          CaptionDetail.Color = clBtnFace
          CaptionDetail.DefaultDisplayFormat = False
          CaptionDetail.DisplayFormat = 'd'
          CaptionDetail.Height = -1
          CaptionDetail.Font.Charset = DEFAULT_CHARSET
          CaptionDetail.Font.Color = clWindowText
          CaptionDetail.Font.Height = -11
          CaptionDetail.Font.Name = 'MS Sans Serif'
          CaptionDetail.Font.Style = []
          CaptionDetail.LineColor = clBtnFace
          CaptionDetail.LinePenStyle = psSolid
          CaptionDetail.ParentFont = True
          CaptionDetail.Visible = True
          CaptionSummary.Color = clBtnFace
          CaptionSummary.DefaultDisplayFormat = False
          CaptionSummary.DisplayFormat = 'dd'
          CaptionSummary.Height = 42
          CaptionSummary.Font.Charset = ANSI_CHARSET
          CaptionSummary.Font.Color = clWindowText
          CaptionSummary.Font.Height = -8
          CaptionSummary.Font.Name = 'Small Fonts'
          CaptionSummary.Font.Style = []
          CaptionSummary.LineColor = clBtnFace
          CaptionSummary.LinePenStyle = psSolid
          CaptionSummary.ParentFont = False
          CaptionSummary.Visible = True
          ColWidth = 3
          LineColor = clSilver
          LinkLineType = ltSide
          LeftDateTime = 37630
          MaxRow = 0
          MinRow = 0
          Row = 1
          RowHeight = 21
          TaskList = TaskListAll
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          PrintSettings.TitleHeight = 0.5
          PrintSettings.LeftMargin = 0.25
          PrintSettings.TopMargin = 0.025000000372529
          PrintSettings.RightMargin = 0.025000000372529
          PrintSettings.BottomMargin = 0.25
          PrintSettings.Text = '   Platinum1 Gantt Chart Printout'
          PrintSettings.Font.Charset = ANSI_CHARSET
          PrintSettings.Font.Color = clWindowText
          PrintSettings.Font.Height = -11
          PrintSettings.Font.Name = 'Arial'
          PrintSettings.Font.Style = []
          PrintSettings.Alignment = taCenter
          ReadOnly = True
          TabOrder = 1
          HelpContext = 336026
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Project &View'
      TabVisible = False
      HelpContext = 336027
      object Label1: TLabel
        Left = 16
        Top = 64
        Width = 76
        Height = 15
        Caption = 'Manuf Part ID'
        HelpContext = 336028
      end
      object Label2: TLabel
        Left = 152
        Top = 64
        Width = 66
        Height = 15
        Caption = 'Manuf Time'
        HelpContext = 336029
      end
      object Label3: TLabel
        Left = 60
        Top = 120
        Width = 77
        Height = 15
        Caption = 'Overrun Time'
        HelpContext = 336030
      end
      object Label4: TLabel
        Left = 348
        Top = 64
        Width = 77
        Height = 15
        Caption = 'Creation Date'
        HelpContext = 336031
      end
      object PageControl2: TPageControl
        Left = -8
        Top = -30
        Width = 961
        Height = 473
        TabOrder = 0
        HelpContext = 336032
      end
    end
    object tabDesign: TTabSheet
      Caption = 'Project D&esign'
      ImageIndex = 2
      HelpContext = 336033
      object DNMPanel3: TDNMPanel
        Left = 0
        Top = 0
        Width = 1001
        Height = 412
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        HelpContext = 336034
        object Label25: TLabel
          Left = 32
          Top = 15
          Width = 101
          Height = 18
          AutoSize = False
          Caption = 'Project Name'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
          HelpContext = 336035
        end
        object Label6: TLabel
          Left = 32
          Top = 112
          Width = 101
          Height = 18
          Alignment = taCenter
          AutoSize = False
          Caption = 'Project Start Date'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
          HelpContext = 336036
        end
        object Label7: TLabel
          Left = 25
          Top = 64
          Width = 70
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Customer'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
          HelpContext = 336037
        end
        object Label8: TLabel
          Left = 30
          Top = 185
          Width = 93
          Height = 18
          AutoSize = False
          Caption = 'Project Notes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
          HelpContext = 336038
        end
        object Company: TDBEdit
          Left = 31
          Top = 30
          Width = 226
          Height = 23
          DataField = 'ProjectName'
          DataSource = DSProjects
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = CompanyChange
          HelpContext = 336039
        end
        object DBEdit1: TDBEdit
          Left = 31
          Top = 127
          Width = 114
          Height = 23
          DataField = 'ProjectStartDate'
          DataSource = DSProjects
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          OnChange = CompanyChange
          HelpContext = 336040
        end
        object DBEdit2: TDBEdit
          Left = 31
          Top = 78
          Width = 226
          Height = 23
          DataField = 'CustomerName'
          DataSource = DSProjects
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          OnChange = CompanyChange
          HelpContext = 336041
        end
        object grdManuf: TwwDBGrid
          Left = 280
          Top = 25
          Width = 689
          Height = 344
          ControlType.Strings = (
            'ProductID;CustomEdit;;F'
            'PartName;CustomEdit;cboManufProd;F')
          Selected.Strings = (
            'PartDescription'#9'20'#9'Project Item'
            'StartDay'#9'10'#9'Start Day'
            'EndDay'#9'10'#9'End Day'
            'Progress'#9'5'#9'Progress'
            'LineNo'#9'4'#9'Line No'
            'LinkTo'#9'4'#9'Link To'
            'TaskNotes'#9'29'#9'Task Notes'#9'F')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          DataSource = DSProjectLines
          KeyOptions = []
          TabOrder = 3
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 1
          TitleButtons = False
          OnExit = grdManufExit
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
          HelpContext = 336042
        end
        object DBMemo1: TDBMemo
          Left = 29
          Top = 208
          Width = 236
          Height = 161
          DataField = 'notes'
          DataSource = DSProjects
          TabOrder = 4
          HelpContext = 336043
        end
      end
    end
  end
  object cmdOk: TDNMSpeedButton [6]
    Left = 290
    Top = 516
    Width = 87
    Height = 27
    Anchors = [akTop, akRight]
    Caption = '&Save'
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
    OnClick = cmdOkClick
    HelpContext = 336044
  end
  object pnlTitle: TDNMPanel [7]
    Left = 200
    Top = 6
    Width = 607
    Height = 37
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    HelpContext = 336045
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 603
      Height = 33
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
      HelpContext = 336046
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 603
        Height = 33
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Project Name'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        HelpContext = 336047
      end
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 88
    Top = 440
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 24
    Top = 440
  end
  object qryProjects: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select '
      'ProjectID,'
      'CreationDate,'
      'ProjectName,'
      'ProjectStartDate,'
      'EndDate,'
      'notes,'
      'Progress,'
      'CustomerName,'
      'SaleOrderNumber,'
      'ProductID,'
      'OrderNumber'
      'from tblProjects '
      'where ProjectID=:ProjectID')
    Left = 237
    Top = 295
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProjectID'
      end>
  end
  object DSProjects: TDataSource
    DataSet = qryProjects
    Left = 261
    Top = 230
  end
  object ProjectTaskList1: TFETaskList
    About.Version = '1.0'
    About.Product = 'Project Plus 1'
    About.Url = 'http://www.fesoft.com/ProjPlus'
    About.Company = 'Fe Software & Development'
    About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
    Items = <>
    OnTaskChange = ProjectTaskList1TaskChange
    Left = 200
    SummaryItem = {}
    SuccessorList = {}
    DetailList = {}
  end
  object FEGantSetupDialog: TFEGantSetupDialog
    About.Version = '1.0'
    About.Product = 'Project Plus 1'
    About.Url = 'http://www.fesoft.com/ProjPlus'
    About.Company = 'Fe Software & Development'
    About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
    Gant = ProjectGant1
    HelpButtonVisible = False
    Title = 'Gant Properties'
    UserButton1Visible = False
    UserButton2Visible = False
    Left = 112
  end
  object qryProjectLines: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  * from tblProjectLines '
      'WHERE ProjectID=:ProjectID'
      'ORDER BY LineNo'
      '')
    Left = 237
    Top = 351
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ProjectID'
      end>
  end
  object DSProjectLines: TDataSource
    DataSet = qryProjectLines
    Left = 301
    Top = 390
  end
  object cboProductLookup: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select PartName, PartsID, PartType'
      'from tblParts '
      'order by partname')
    Left = 348
    Top = 439
  end
  object DSProductLookup: TDataSource
    DataSet = cboProductLookup
    Left = 349
    Top = 398
  end
  object GanTAdvPopupMenu1: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.0.1'
    Left = 640
    Top = 64
    object Linkwithpredecessor1: TMenuItem
      Caption = 'Link with predecessor'
    end
    object Removefromchart1: TMenuItem
      Caption = 'Remove from chart'
      OnClick = Removefromchart1Click
    end
    object PrintChart1: TMenuItem
      Caption = 'Print Chart'
      OnClick = PrintChart1Click
    end
  end
  object TaskLisTAdvPopupMenu: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.0.1'
    Left = 216
    Top = 240
    object GotoToday1: TMenuItem
      Caption = 'Go to Today'
      OnClick = GotoToday1Click
    end
  end
  object dsProjectsAll: TDataSource
    DataSet = qryProjectsAll
    Left = 477
    Top = 358
  end
  object qryProjectsAll: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblprojects.ProjectID, tblprojects.ProjectName, '
      'DATE_ADD(Min(StartDay),INTERVAL 0 SECOND)  as StartDate, '
      'DATE_ADD(Max(EndDay),INTERVAL 0 SECOND)  as EndDate,'
      'ClientID'
      'FROM tblprojects'
      'INNER JOIN tblProjectLines USING (ProjectID)'
      'GROUP BY ProjectID')
    Left = 485
    Top = 407
    object qryProjectsAllProjectID: TIntegerField
      FieldName = 'ProjectID'
    end
    object qryProjectsAllProjectName: TStringField
      FieldName = 'ProjectName'
      FixedChar = True
      Size = 50
    end
    object qryProjectsAllStartDate: TDateTimeField
      FieldName = 'StartDate'
      ReadOnly = True
    end
    object qryProjectsAllEndDate: TDateTimeField
      FieldName = 'EndDate'
      ReadOnly = True
    end
    object qryProjectsAllClientID: TIntegerField
      FieldName = 'ClientID'
    end
  end
  object dsProjectLinesAll: TDataSource
    DataSet = qryProjectLinesAll
    Left = 597
    Top = 358
  end
  object qryProjectLinesAll: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select  * from tblProjectLines '
      '')
    Left = 597
    Top = 407
  end
  object TaskListAll: TFETaskList
    About.Version = '1.0'
    About.Product = 'Project Plus 1'
    About.Url = 'http://www.fesoft.com/ProjPlus'
    About.Company = 'Fe Software & Development'
    About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
    Items = <>
    Left = 232
    SummaryItem = {}
    SuccessorList = {}
    DetailList = {}
  end
  object FEGantSetupDialogAll: TFEGantSetupDialog
    About.Version = '1.0'
    About.Product = 'Project Plus 1'
    About.Url = 'http://www.fesoft.com/ProjPlus'
    About.Company = 'Fe Software & Development'
    About.Copyright = 'Copyright '#169' 2000 Fe Software & Development, All rights reserved.'
    HelpButtonVisible = False
    Title = 'Gant Properties'
    UserButton1Visible = False
    UserButton2Visible = False
    Left = 656
  end
  object PrinterSetupDialog: TPrinterSetupDialog
    Left = 352
    Top = 88
  end
  inherited imgGridWatermark: TImage
    HelpContext = 336001
  end
end
