inherited fmEmpResProcRoster: TfmEmpResProcRoster
  HelpContext = 1366002
  Caption = 'Employee Allocation'
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 185
    ExplicitTop = 482
    ExplicitWidth = 944
  end
  object lblMsg: TLabel [5]
    Left = 0
    Top = 185
    Width = 945
    Height = 15
    HelpContext = 1366009
    Align = alBottom
    Alignment = taCenter
    Caption = 'lblMsg'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    Visible = False
    WordWrap = True
    ExplicitWidth = 37
  end
  inherited pnltop: TDNMPanel
    Visible = True
    OnDblClick = pnltopDblClick
    HelpContext = 1366045
    inherited pnlTitle: TDNMPanel
      HelpContext = 1366046
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Employee Allocation'
          ExplicitWidth = 428
          HelpContext = 1366032
        end
      end
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 457
    Height = 75
    HelpContext = 1366003
    ExplicitTop = 457
    ExplicitHeight = 75
    DesignSize = (
      945
      75)
    object Label1: TLabel [0]
      Left = 1
      Top = 1
      Width = 943
      Height = 30
      HelpContext = 1366004
      Align = alTop
      Alignment = taCenter
      Caption = 
        'Roster can be Made for a Single Day and Copied to Other Days.  C' +
        'lick on an Item to Select It.  Hold Down CTRL and Click on the I' +
        'tem to Choose Multiple. Right Click for Option to Copy to Other ' +
        'Days'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitWidth = 930
    end
    inherited cmdClose: TDNMSpeedButton
      Left = 119
      Top = 37
      Height = 27
      HelpContext = 1366005
      Caption = 'Save'
      ExplicitLeft = 119
      ExplicitTop = 37
      ExplicitHeight = 27
    end
    inherited cmdCancel: TDNMSpeedButton
      Left = 732
      Top = 37
      Height = 27
      ExplicitLeft = 732
      ExplicitTop = 37
      ExplicitHeight = 27
      HelpContext = 1366033
    end
    object btnShowResouce: TDNMSpeedButton
      Left = 506
      Top = 37
      Width = 152
      Height = 27
      HelpContext = 1366006
      Action = actShowResouce
      Anchors = [akBottom]
      Caption = 'Show Resource List'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
    end
    object btnCreateDEfaultAllocation: TDNMSpeedButton
      Left = 288
      Top = 37
      Width = 152
      Height = 27
      HelpContext = 1366029
      Anchors = [akBottom]
      Caption = 'Create Default Schedule'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCreateDEfaultAllocationClick
    end
  end
  inherited pgeRosters: TPageControl
    Width = 692
    Height = 126
    HelpContext = 1366007
    ExplicitWidth = 692
    ExplicitHeight = 126
    inherited tabDaily: TTabSheet
      inherited pnlMain: TDNMPanel
        Width = 684
        Height = 86
        HelpContext = 1366008
        ExplicitWidth = 684
        ExplicitHeight = 86
        inherited Planner: TDBPlanner
          Left = 32
          Width = 620
          Height = 82
          Hint = 
            'Planner is Read Only - Shows the Employee Roster, Scheduled Jobs' +
            '  and Employee Leaves'
          HelpContext = 1366010
          Caption.Title = 'BOM Schedule Roster'
          Caption.Font.Charset = ANSI_CHARSET
          Caption.Font.Name = 'Arial'
          Caption.Alignment = taLeftJustify
          Caption.BackgroundTo = clWhite
          DefaultItem.CaptionType = ctNone
          DefaultItem.ItemBegin = 0
          DefaultItem.ItemEnd = 0
          DefaultItem.SelectColor = 11075496
          DefaultItem.SelectColorTo = 11075496
          DirectMove = True
          Display.DisplayScale = 10
          GridPopup = popPlanner
          Header.AllowResize = True
          Header.AutoSizeGroupCaption = True
          Header.Height = 34
          HintOnItemChange = False
          ItemPopup = popupPlannerItem
          Sidebar.RotateOnTop = False
          OnEnter = PlannerEnter
          OnItemSize = PlannerItemSize
          OnItemMove = PlannerItemMove
          OnItemSizing = PlannerItemSizing
          OnItemMoving = PlannerItemMoving
          OnItemStartEdit = PlannerItemStartEdit
          OnItemSelect = PlannerItemSelect
          ExplicitLeft = 32
          ExplicitWidth = 620
          ExplicitHeight = 82
          DesignSize = (
            620
            82)
          object pnlbuttons: TDNMPanel
            AlignWithMargins = True
            Left = 28
            Top = 0
            Width = 599
            Height = 33
            HelpContext = 1366011
            Margins.Left = 270
            Margins.Top = 0
            Margins.Right = 1
            Anchors = [akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentColor = True
            ParentFont = False
            TabOrder = 4
            Transparent = False
            object btnsunday: TAdvGlowButton
              AlignWithMargins = True
              Left = 4
              Top = 2
              Width = 83
              Height = 29
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Action = actSunday
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              NotesFont.Charset = DEFAULT_CHARSET
              NotesFont.Color = clWindowText
              NotesFont.Height = -11
              NotesFont.Name = 'Tahoma'
              NotesFont.Style = []
              ParentFont = False
              TabOrder = 0
              Appearance.Color = 4259584
              Appearance.ColorChecked = 16111818
              Appearance.ColorCheckedTo = clWhite
              Appearance.ColorDisabled = 15066597
              Appearance.ColorDisabledTo = 11599792
              Appearance.ColorDown = 16111818
              Appearance.ColorDownTo = 16367008
              Appearance.ColorHot = 16117985
              Appearance.ColorHotTo = 16372402
              Appearance.ColorMirror = 4259584
              Appearance.ColorMirrorHot = 16107693
              Appearance.ColorMirrorHotTo = 16775412
              Appearance.ColorMirrorDown = 16102556
              Appearance.ColorMirrorDownTo = 16768988
              Appearance.ColorMirrorChecked = 16102556
              Appearance.ColorMirrorCheckedTo = clWhite
              Appearance.ColorMirrorDisabled = 15066597
              Appearance.ColorMirrorDisabledTo = 11599792
              HelpContext = 1366034
            end
            object btnMonday: TAdvGlowButton
              Tag = 1
              AlignWithMargins = True
              Left = 89
              Top = 2
              Width = 83
              Height = 29
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Action = actMonday
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              NotesFont.Charset = DEFAULT_CHARSET
              NotesFont.Color = clWindowText
              NotesFont.Height = -11
              NotesFont.Name = 'Tahoma'
              NotesFont.Style = []
              ParentFont = False
              TabOrder = 1
              Appearance.Color = 11599792
              Appearance.ColorChecked = 16111818
              Appearance.ColorCheckedTo = clWhite
              Appearance.ColorDisabled = 15066597
              Appearance.ColorDisabledTo = 11599792
              Appearance.ColorDown = 16111818
              Appearance.ColorDownTo = 16367008
              Appearance.ColorHot = 16117985
              Appearance.ColorHotTo = 16372402
              Appearance.ColorMirror = 11599792
              Appearance.ColorMirrorHot = 16107693
              Appearance.ColorMirrorHotTo = 16775412
              Appearance.ColorMirrorDown = 16102556
              Appearance.ColorMirrorDownTo = 16768988
              Appearance.ColorMirrorChecked = 16102556
              Appearance.ColorMirrorCheckedTo = clWhite
              Appearance.ColorMirrorDisabled = 15066597
              Appearance.ColorMirrorDisabledTo = 11599792
              HelpContext = 1366035
            end
            object btnTuesday: TAdvGlowButton
              Tag = 2
              AlignWithMargins = True
              Left = 174
              Top = 2
              Width = 83
              Height = 29
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Action = actTuesday
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              NotesFont.Charset = DEFAULT_CHARSET
              NotesFont.Color = clWindowText
              NotesFont.Height = -11
              NotesFont.Name = 'Tahoma'
              NotesFont.Style = []
              ParentFont = False
              TabOrder = 2
              Appearance.Color = 11599792
              Appearance.ColorChecked = 16111818
              Appearance.ColorCheckedTo = clWhite
              Appearance.ColorDisabled = 15066597
              Appearance.ColorDisabledTo = 11599792
              Appearance.ColorDown = 16111818
              Appearance.ColorDownTo = 16367008
              Appearance.ColorHot = 16117985
              Appearance.ColorHotTo = 16372402
              Appearance.ColorMirror = 11599792
              Appearance.ColorMirrorHot = 16107693
              Appearance.ColorMirrorHotTo = 16775412
              Appearance.ColorMirrorDown = 16102556
              Appearance.ColorMirrorDownTo = 16768988
              Appearance.ColorMirrorChecked = 16102556
              Appearance.ColorMirrorCheckedTo = clWhite
              Appearance.ColorMirrorDisabled = 15066597
              Appearance.ColorMirrorDisabledTo = 11599792
              HelpContext = 1366036
            end
            object btnWednesday: TAdvGlowButton
              Tag = 3
              AlignWithMargins = True
              Left = 259
              Top = 2
              Width = 83
              Height = 29
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Action = actWednesday
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              NotesFont.Charset = DEFAULT_CHARSET
              NotesFont.Color = clWindowText
              NotesFont.Height = -11
              NotesFont.Name = 'Tahoma'
              NotesFont.Style = []
              ParentFont = False
              TabOrder = 3
              Appearance.Color = 11599792
              Appearance.ColorChecked = 16111818
              Appearance.ColorCheckedTo = clWhite
              Appearance.ColorDisabled = 15066597
              Appearance.ColorDisabledTo = 11599792
              Appearance.ColorDown = 16111818
              Appearance.ColorDownTo = 16367008
              Appearance.ColorHot = 16117985
              Appearance.ColorHotTo = 16372402
              Appearance.ColorMirror = 11599792
              Appearance.ColorMirrorHot = 16107693
              Appearance.ColorMirrorHotTo = 16775412
              Appearance.ColorMirrorDown = 16102556
              Appearance.ColorMirrorDownTo = 16768988
              Appearance.ColorMirrorChecked = 16102556
              Appearance.ColorMirrorCheckedTo = clWhite
              Appearance.ColorMirrorDisabled = 15066597
              Appearance.ColorMirrorDisabledTo = 11599792
              HelpContext = 1366037
            end
            object btnThursday: TAdvGlowButton
              Tag = 4
              AlignWithMargins = True
              Left = 344
              Top = 2
              Width = 83
              Height = 29
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Action = actThursday
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              NotesFont.Charset = DEFAULT_CHARSET
              NotesFont.Color = clWindowText
              NotesFont.Height = -11
              NotesFont.Name = 'Tahoma'
              NotesFont.Style = []
              ParentFont = False
              TabOrder = 4
              Appearance.Color = 11599792
              Appearance.ColorChecked = 16111818
              Appearance.ColorCheckedTo = clWhite
              Appearance.ColorDisabled = 15066597
              Appearance.ColorDisabledTo = 11599792
              Appearance.ColorDown = 16111818
              Appearance.ColorDownTo = 16367008
              Appearance.ColorHot = 16117985
              Appearance.ColorHotTo = 16372402
              Appearance.ColorMirror = 11599792
              Appearance.ColorMirrorHot = 16107693
              Appearance.ColorMirrorHotTo = 16775412
              Appearance.ColorMirrorDown = 16102556
              Appearance.ColorMirrorDownTo = 16768988
              Appearance.ColorMirrorChecked = 16102556
              Appearance.ColorMirrorCheckedTo = clWhite
              Appearance.ColorMirrorDisabled = 15066597
              Appearance.ColorMirrorDisabledTo = 11599792
              HelpContext = 1366038
            end
            object btnFriday: TAdvGlowButton
              Tag = 5
              AlignWithMargins = True
              Left = 429
              Top = 2
              Width = 83
              Height = 29
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Action = actFriday
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              NotesFont.Charset = DEFAULT_CHARSET
              NotesFont.Color = clWindowText
              NotesFont.Height = -11
              NotesFont.Name = 'Tahoma'
              NotesFont.Style = []
              ParentFont = False
              TabOrder = 5
              Appearance.Color = 11599792
              Appearance.ColorChecked = 16111818
              Appearance.ColorCheckedTo = clWhite
              Appearance.ColorDisabled = 15066597
              Appearance.ColorDisabledTo = 11599792
              Appearance.ColorDown = 16111818
              Appearance.ColorDownTo = 16367008
              Appearance.ColorHot = 16117985
              Appearance.ColorHotTo = 16372402
              Appearance.ColorMirror = 11599792
              Appearance.ColorMirrorHot = 16107693
              Appearance.ColorMirrorHotTo = 16775412
              Appearance.ColorMirrorDown = 16102556
              Appearance.ColorMirrorDownTo = 16768988
              Appearance.ColorMirrorChecked = 16102556
              Appearance.ColorMirrorCheckedTo = clWhite
              Appearance.ColorMirrorDisabled = 15066597
              Appearance.ColorMirrorDisabledTo = 11599792
              HelpContext = 1366039
            end
            object btnSaturday: TAdvGlowButton
              Tag = 6
              AlignWithMargins = True
              Left = 514
              Top = 2
              Width = 83
              Height = 29
              Margins.Left = 1
              Margins.Top = 1
              Margins.Right = 1
              Margins.Bottom = 1
              Align = alRight
              Action = actSaturday
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              NotesFont.Charset = DEFAULT_CHARSET
              NotesFont.Color = clWindowText
              NotesFont.Height = -11
              NotesFont.Name = 'Tahoma'
              NotesFont.Style = []
              ParentFont = False
              TabOrder = 6
              Appearance.Color = 11599792
              Appearance.ColorChecked = 16111818
              Appearance.ColorCheckedTo = clWhite
              Appearance.ColorDisabled = 15066597
              Appearance.ColorDisabledTo = 11599792
              Appearance.ColorDown = 16111818
              Appearance.ColorDownTo = 16367008
              Appearance.ColorHot = 16117985
              Appearance.ColorHotTo = 16372402
              Appearance.ColorMirror = 11599792
              Appearance.ColorMirrorHot = 16107693
              Appearance.ColorMirrorHotTo = 16775412
              Appearance.ColorMirrorDown = 16102556
              Appearance.ColorMirrorDownTo = 16768988
              Appearance.ColorMirrorChecked = 16102556
              Appearance.ColorMirrorCheckedTo = clWhite
              Appearance.ColorMirrorDisabled = 15066597
              Appearance.ColorMirrorDisabledTo = 11599792
              HelpContext = 1366040
            end
          end
        end
        object btnnext: TAdvGlowButton
          AlignWithMargins = True
          Left = 653
          Top = 34
          Width = 29
          Height = 50
          Margins.Left = 1
          Margins.Top = 33
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alRight
          Action = actNext
          Caption = 'SUNDAY'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          TabOrder = 1
          Visible = False
          Appearance.BorderColorHot = clNavy
          Appearance.Color = clNavy
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = clWhite
          Appearance.ColorDisabled = 15066597
          Appearance.ColorDisabledTo = 11599792
          Appearance.ColorDown = clBlue
          Appearance.ColorDownTo = 11796479
          Appearance.ColorHot = clNavy
          Appearance.ColorHotTo = clWhite
          Appearance.ColorMirror = clNavy
          Appearance.ColorMirrorHot = clNavy
          Appearance.ColorMirrorHotTo = clWhite
          Appearance.ColorMirrorDown = clBlue
          Appearance.ColorMirrorDownTo = 11796479
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = clWhite
          Appearance.ColorMirrorDisabled = 15066597
          Appearance.ColorMirrorDisabledTo = 11599792
          Appearance.Gradient = ggDiagonalBackward
          Appearance.GradientMirror = ggDiagonalForward
          Appearance.GradientHot = ggDiagonalBackward
          Appearance.GradientMirrorHot = ggDiagonalForward
          Appearance.GradientDown = ggDiagonalBackward
          Appearance.GradientMirrorDown = ggDiagonalForward
          Appearance.GradientChecked = ggDiagonalBackward
          Appearance.GradientMirrorChecked = ggDiagonalForward
          Appearance.GradientDisabled = ggDiagonalBackward
          Appearance.GradientMirrorDisabled = ggDiagonalForward
          Layout = blGlyphTop
          HelpContext = 1366041
        end
        object btnPrevious: TAdvGlowButton
          AlignWithMargins = True
          Left = 2
          Top = 34
          Width = 29
          Height = 50
          Margins.Left = 1
          Margins.Top = 33
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alLeft
          Action = actPrevious
          Caption = 'SUNDAY'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          NotesFont.Charset = DEFAULT_CHARSET
          NotesFont.Color = clWindowText
          NotesFont.Height = -11
          NotesFont.Name = 'Tahoma'
          NotesFont.Style = []
          ParentFont = False
          TabOrder = 2
          Visible = False
          Appearance.BorderColorHot = clNavy
          Appearance.Color = clNavy
          Appearance.ColorChecked = 16111818
          Appearance.ColorCheckedTo = clWhite
          Appearance.ColorDisabled = 15066597
          Appearance.ColorDisabledTo = 11599792
          Appearance.ColorDown = clBlue
          Appearance.ColorDownTo = 11796479
          Appearance.ColorHot = clNavy
          Appearance.ColorHotTo = clWhite
          Appearance.ColorMirror = clNavy
          Appearance.ColorMirrorHot = clNavy
          Appearance.ColorMirrorHotTo = clWhite
          Appearance.ColorMirrorDown = clBlue
          Appearance.ColorMirrorDownTo = 11796479
          Appearance.ColorMirrorChecked = 16102556
          Appearance.ColorMirrorCheckedTo = clWhite
          Appearance.ColorMirrorDisabled = 15066597
          Appearance.ColorMirrorDisabledTo = 11599792
          Appearance.Gradient = ggDiagonalForward
          Appearance.GradientMirror = ggDiagonalBackward
          Appearance.GradientHot = ggDiagonalForward
          Appearance.GradientMirrorHot = ggDiagonalBackward
          Appearance.GradientDown = ggDiagonalForward
          Appearance.GradientMirrorDown = ggDiagonalBackward
          Appearance.GradientChecked = ggDiagonalForward
          Appearance.GradientMirrorChecked = ggDiagonalBackward
          Appearance.GradientDisabled = ggDiagonalForward
          Appearance.GradientMirrorDisabled = ggDiagonalBackward
          HelpContext = 1366042
        end
      end
    end
  end
  inherited pnlright: TDNMPanel
    Left = 692
    Width = 253
    Height = 126
    ExplicitLeft = 692
    ExplicitWidth = 253
    ExplicitHeight = 126
    HelpContext = 1366043
    object grdResources: TwwDBGrid
      Left = 1
      Top = 1
      Width = 251
      Height = 124
      HelpContext = 1366021
      Selected.Strings = (
        'ResourceName'#9'15'#9'Resource'#9#9
        'Processstep'#9'15'#9'Process'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = dsREsources
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnCalcCellColors = grdResourcesCalcCellColors
      FooterColor = clWhite
    end
  end
  inherited Memo1: TMemo
    Top = 200
    ExplicitTop = 200
  end
  inherited MyConnection: TERPConnection
    Left = 432
    Top = 295
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004002840210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryProcessEmployees: TERPQuery
    SQL.Strings = (
      'select CONVERT(@rownum:=@rownum+1,SIGNED) EmpPosNo, a.*'
      'from  (Select '
      'Distinct E.EmployeeID , E.EmployeeName'
      'From  tblProcessStep'#9'PS'#9
      
        'inner join tblemployeeprocesssteps'#9'EPS'#9' on EPS.ProcessStepID = P' +
        's.ID'
      'inner join tblemployees E on E.EmployeeID = EPS.EmployeeID'
      'order by E.EmployeeName'
      ') A , (SELECT @rownum:=0) r'
      'order by EmpPosNo')
  end
  object QryProcessResourceResDetails: TERPQuery [26]
    Connection = MyConnection
    SQL.Strings = (
      'select CONVERT(@rownum:=@rownum+1,SIGNED) rownum , a.*'
      'from  '
      '(Select '
      'PS.ID as ProcessStepID, '
      'PS.Description as ProcessStep, '
      'Pr.ProcresourceId as ResourceId,'
      'PR.ResourceName , '
      'PRDT.Id as REsourceDetailID,'
      'PRDT.Description as REsourceDetailDescription'
      
        'From tblProcResource PR inner join tblProcResourceProcess'#9'RP'#9' on' +
        ' PR.ProcResourceId = RP.ProcResourceId'
      'inner join tblProcessStep'#9'PS'#9'on RP.ProcessStepId = PS.Id'
      
        'inner join tblprocresourcedetails'#9'PRDT'#9'on PR.ProcResourceId = PR' +
        'DT.ProcResourceId'
      
        'Order by ProcessStep , if(REsourceDetailDescription='#39#39' , Resourc' +
        'eName , REsourceDetailDescription)) A , (SELECT @rownum:=0) r')
    Left = 199
    Top = 216
    object QryProcessResourceResDetailsProcessStepID: TIntegerField
      FieldName = 'ProcessStepID'
    end
    object QryProcessResourceResDetailsProcessStep: TWideStringField
      FieldName = 'ProcessStep'
      Size = 255
    end
    object QryProcessResourceResDetailsResourceId: TIntegerField
      FieldName = 'ResourceId'
    end
    object QryProcessResourceResDetailsResourceName: TWideStringField
      FieldName = 'ResourceName'
      Size = 255
    end
    object QryProcessResourceResDetailsREsourceDetailID: TIntegerField
      FieldName = 'REsourceDetailID'
    end
    object QryProcessResourceResDetailsREsourceDetailDescription: TWideStringField
      FieldName = 'REsourceDetailDescription'
      Size = 255
    end
    object QryProcessResourceResDetailsrownum: TLargeintField
      FieldName = 'rownum'
    end
  end
  object QryEmpProcesses: TERPQuery [27]
    Connection = MyConnection
    SQL.Strings = (
      'select CONVERT(@rownum:=@rownum+1,SIGNED) rownum , a.*'
      'from  '
      '(Select '
      'PS.ID as ProcessStepID, '
      'PS.Description as ProcessStep, '
      'Pr.ProcresourceId as ResourceId,'
      'PR.ResourceName , '
      'PRDT.Id as REsourceDetailID,'
      'PRDT.Description as REsourceDetailDescription,'
      'EPS.employeeId'
      
        'From tblProcResource PR inner join tblProcResourceProcess'#9'RP'#9' on' +
        ' PR.ProcResourceId = RP.ProcResourceId and PR.active ="T"'
      
        'inner join tblProcessStep'#9'PS'#9'on RP.ProcessStepId = PS.Id and PS.' +
        'active ="T"'
      
        'inner join tblprocresourcedetails'#9'PRDT'#9'on PR.ProcResourceId = PR' +
        'DT.ProcResourceId'
      
        'inner join tblemployeeprocesssteps'#9'EPS'#9' on EPS.ProcessStepID = P' +
        's.ID'
      'Where EPS.employeeId = :employeeId'
      
        'Order by ProcessStep , if(REsourceDetailDescription='#39#39' , Resourc' +
        'eName , REsourceDetailDescription)) A , (SELECT @rownum:=0) r')
    Left = 234
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'employeeId'
      end>
    object QryEmpProcessesrownum: TLargeintField
      FieldName = 'rownum'
    end
    object QryEmpProcessesProcessStepID: TIntegerField
      FieldName = 'ProcessStepID'
    end
    object QryEmpProcessesProcessStep: TWideStringField
      FieldName = 'ProcessStep'
      Size = 255
    end
    object QryEmpProcessesResourceId: TIntegerField
      FieldName = 'ResourceId'
    end
    object QryEmpProcessesResourceName: TWideStringField
      FieldName = 'ResourceName'
      Size = 255
    end
    object QryEmpProcessesREsourceDetailID: TIntegerField
      FieldName = 'REsourceDetailID'
    end
    object QryEmpProcessesREsourceDetailDescription: TWideStringField
      FieldName = 'REsourceDetailDescription'
      Size = 255
    end
    object QryEmpProcessesemployeeId: TIntegerField
      FieldName = 'employeeId'
    end
  end
  object popPlanner: TPopupMenu [28]
    OnPopup = popPlannerPopup
    Left = 664
    Top = 216
  end
  inherited RosterSource: TDBDaySource
    StartTimeField = 'TimeFrom'
    EndTimeField = 'TimeTo'
    KeyField = 'PlannerId'
    ResourceField = 'EmployeeId'
    OnResourceToPosition = RosterSourceResourceToPosition
    OnPositionToResource = RosterSourcePositionToResource
  end
  inherited QryRoster: TERPQuery
    SQL.Strings = (
      'Select * from tblempresprocschedule')
    AfterInsert = QryRosterAfterInsert
    OnCalcFields = QryRosterCalcFields
    object QryRosterID: TIntegerField
      FieldName = 'ID'
    end
    object QryRosterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QryRosterPlannerId: TWideStringField
      FieldName = 'PlannerId'
      Size = 255
    end
    object QryRosterEmployeeId: TIntegerField
      FieldName = 'EmployeeId'
    end
    object QryRosterWeekDayNo: TIntegerField
      FieldName = 'WeekDayNo'
    end
    object QryRosterProcessStepId: TIntegerField
      FieldName = 'ProcessStepId'
    end
    object QryRosterResourceID: TIntegerField
      FieldName = 'ResourceID'
    end
    object QryRosterResourceDetailId: TIntegerField
      FieldName = 'ResourceDetailId'
    end
    object QryRosterTimeFrom: TDateTimeField
      FieldName = 'TimeFrom'
    end
    object QryRosterTimeTo: TDateTimeField
      FieldName = 'TimeTo'
    end
    object QryRosterActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QryRostermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QryRostermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object QryRosterProcessStep: TStringField
      FieldKind = fkLookup
      FieldName = 'ProcessStep'
      LookupDataSet = QryProcessResourceResDetails
      LookupKeyFields = 'ProcessStepID'
      LookupResultField = 'ProcessStep'
      KeyFields = 'ProcessStepId'
      Size = 100
      Lookup = True
    end
    object QryRosterResourceName: TStringField
      FieldKind = fkLookup
      FieldName = 'ResourceName'
      LookupDataSet = QryProcessResourceResDetails
      LookupKeyFields = 'ResourceId'
      LookupResultField = 'ResourceName'
      KeyFields = 'ResourceID'
      Size = 100
      Lookup = True
    end
    object QryRosterREsourceDetailDescription: TStringField
      FieldKind = fkLookup
      FieldName = 'REsourceDetailDescription'
      LookupDataSet = QryProcessResourceResDetails
      LookupKeyFields = 'REsourceDetailID'
      LookupResultField = 'REsourceDetailDescription'
      KeyFields = 'ResourceDetailId'
      Size = 100
      Lookup = True
    end
    object QryRosterNotes: TStringField
      FieldKind = fkCalculated
      FieldName = 'Notes'
      Size = 255
      Calculated = True
    end
  end
  object lsTDNMSpeedButtonActions: TActionList
    Left = 332
    Top = 272
    object actSunday: TDNMAction
      Tag = 1
      Category = 'Days'
      Caption = 'Sunday'
      HelpContext = 1366022
      OnExecute = OnDaySelect
      OnUpdate = OnDayupdate
      buttoncolor = clWhite
    end
    object actMonday: TDNMAction
      Tag = 2
      Category = 'Days'
      Caption = 'Monday'
      HelpContext = 1366023
      OnExecute = OnDaySelect
      OnUpdate = OnDayupdate
      buttoncolor = clWhite
    end
    object actTuesday: TDNMAction
      Tag = 3
      Category = 'Days'
      Caption = 'Tuesday'
      HelpContext = 1366024
      OnExecute = OnDaySelect
      OnUpdate = OnDayupdate
      buttoncolor = clWhite
    end
    object actWednesday: TDNMAction
      Tag = 4
      Category = 'Days'
      Caption = 'Wednesday'
      HelpContext = 1366025
      OnExecute = OnDaySelect
      OnUpdate = OnDayupdate
      buttoncolor = clWhite
    end
    object actThursday: TDNMAction
      Tag = 5
      Category = 'Days'
      Caption = 'Thursday'
      HelpContext = 1366026
      OnExecute = OnDaySelect
      OnUpdate = OnDayupdate
      buttoncolor = clWhite
    end
    object actFriday: TDNMAction
      Tag = 6
      Category = 'Days'
      Caption = 'Friday'
      HelpContext = 1366027
      OnExecute = OnDaySelect
      OnUpdate = OnDayupdate
      buttoncolor = clWhite
    end
    object actSaturday: TDNMAction
      Tag = 7
      Category = 'Days'
      Caption = 'Saturday'
      HelpContext = 1366028
      OnExecute = OnDaySelect
      OnUpdate = OnDayupdate
      buttoncolor = clWhite
    end
    object actNext: TDNMAction
      Category = 'Days'
      OnExecute = OnDaySelect
      buttoncolor = clWhite
    end
    object actShowResouce: TDNMAction
      Category = 'General'
      Caption = 'Show Resource List'
      HelpContext = 1366044
      OnExecute = actShowResouceExecute
      OnUpdate = actShowResouceUpdate
      buttoncolor = clWhite
    end
    object actPrevious: TDNMAction
      Category = 'Days'
      OnExecute = OnDaySelect
      buttoncolor = clWhite
    end
  end
  object popupPlannerItem: TPopupMenu
    OnPopup = popPlannerPopup
    Left = 704
    Top = 216
    object mnuDeleteItem: TMenuItem
      Caption = 'Delete'
      HelpContext = 1366030
      OnClick = mnuDeleteItemClick
    end
    object Copy1: TMenuItem
      Caption = 'Copy'
      HelpContext = 1366031
      OnClick = Copy1Click
    end
  end
  object QryResources: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tmp_ProcResource_Admin_3C1163BA')
    Left = 368
    Top = 273
    object QryResourcesResourceName: TWideStringField
      DisplayLabel = 'Resource'
      DisplayWidth = 15
      FieldName = 'ResourceName'
      Origin = 'tmp_procresource_admin_3c1163ba.ResourceName'
      Size = 255
    end
    object QryResourcesProcessstep: TWideStringField
      DisplayLabel = 'Process'
      DisplayWidth = 15
      FieldName = 'Processstep'
      Origin = 'tmp_procresource_admin_3c1163ba.Processstep'
      Size = 255
    end
    object QryResourcesNo: TIntegerField
      DisplayWidth = 15
      FieldName = 'No'
      Origin = 'tmp_procresource_admin_3c1163ba.No'
      Visible = False
    end
    object QryResourcesProcResourceId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcResourceId'
      Origin = 'tmp_procresource_admin_3c1163ba.ProcResourceId'
      Visible = False
    end
    object QryResourcesProcessStepId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcessStepId'
      Origin = 'tmp_procresource_admin_3c1163ba.ProcessStepId'
      Visible = False
    end
  end
  object dsREsources: TDataSource
    DataSet = QryResources
    Left = 365
    Top = 304
  end
end
