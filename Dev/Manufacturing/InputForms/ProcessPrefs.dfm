inherited ProcessPrefsGUI: TProcessPrefsGUI
  Left = 206
  Top = 61
  HelpContext = 440000
  Caption = 'Process Preferences'
  ClientHeight = 861
  ClientWidth = 1070
  ExplicitLeft = 206
  ExplicitTop = 61
  ExplicitWidth = 1086
  ExplicitHeight = 900
  PixelsPerInch = 96
  TextHeight = 13
  object lblWidth: TLabel [0]
    Left = 15
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 440001
    Caption = 
      'All panels should have a width of 545.  Panel TabOrder is used f' +
      'or panel placement sequence.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited lblSkingroupMsg: TLabel
    Top = 861
    Width = 1070
    HelpContext = 440022
    ExplicitTop = 836
    ExplicitWidth = 880
  end
  inherited sbpanels: TAdvScrollBox
    Width = 1070
    Height = 861
    HelpContext = 440103
    VertScrollBar.Position = 2155
    ExplicitWidth = 1084
    ExplicitHeight = 861
    object pnlGanttchart: TDNMPanel
      Left = 0
      Top = 360
      Width = 1051
      Height = 261
      HelpContext = 440070
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Bevel7: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1037
        Height = 247
        HelpContext = 440071
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitWidth = 531
        ExplicitHeight = 772
      end
      object Label15: TLabel
        Left = 30
        Top = 29
        Width = 64
        Height = 15
        HelpContext = 440072
        Caption = 'Gantt Chart'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label16: TLabel
        Left = 135
        Top = 108
        Width = 84
        Height = 15
        HelpContext = 440048
        Caption = 'Bar Draw Style'
        Transparent = True
      end
      object Label7: TLabel
        Left = 74
        Top = 154
        Width = 145
        Height = 15
        HelpContext = 440049
        Caption = 'Bar Gradient Start Colour '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 81
        Top = 204
        Width = 135
        Height = 15
        HelpContext = 440050
        Caption = 'Bar Gradient End Colour'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtBarHeight: TAdvSpinEdit
        Left = 246
        Top = 55
        Width = 61
        Height = 24
        HelpContext = 440073
        Value = 1
        FloatValue = 1.000000000000000000
        TimeValue = 0.041666666666666660
        HexValue = 0
        Enabled = True
        IncrementFloat = 0.100000000000000000
        IncrementFloatPage = 1.000000000000000000
        LabelCaption = 'Bar Height       '
        LabelPosition = lpLeftCenter
        LabelTransparent = True
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = [fsBold]
        TabOrder = 0
        Visible = True
        Version = '1.4.7.0'
        OnChange = edtBarHeightChange
      end
      object cboGanttChartDrawStyle: TwwDBComboBox
        Left = 244
        Top = 104
        Width = 275
        Height = 23
        HelpContext = 440051
        ShowButton = True
        Style = csDropDown
        MapList = True
        AllowClearKey = False
        DropDownCount = 8
        ItemHeight = 0
        Items.Strings = (
          'Solid'#9'1'
          'Gradient'#9'2'
          'Pattern'#9'3'
          '3D'#9'4'
          'Hatch'#9'5')
        Sorted = False
        TabOrder = 1
        UnboundDataType = wwDefault
        OnChange = cboGanttChartDrawStyleChange
      end
      object GanttChartGFStartColourColorselector: TAdvOfficeColorSelector
        Left = 244
        Top = 150
        Width = 26
        Height = 26
        HelpContext = 440052
        AntiAlias = aaAntiAlias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.3.1.1'
        TabOrder = 2
        AllowFloating = False
        CloseOnSelect = True
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
      object GanttChartGFStartColourIntensity: TAdvTrackBar
        Left = 299
        Top = 150
        Width = 160
        Height = 27
        HelpContext = 440053
        BorderColor = clBlack
        BorderColorDisabled = clBlack
        Buttons.BorderColor = clBlack
        Buttons.BorderColorHot = 10079963
        Buttons.BorderColorDown = 4548219
        Buttons.Color = 15653832
        Buttons.ColorTo = 16178633
        Buttons.ColorHot = 15465983
        Buttons.ColorHotTo = 11332863
        Buttons.ColorDown = 7778289
        Buttons.ColorDownTo = 4296947
        Buttons.ColorMirror = 15586496
        Buttons.ColorMirrorTo = 16245200
        Buttons.ColorMirrorHot = 5888767
        Buttons.ColorMirrorHotTo = 10807807
        Buttons.ColorMirrorDown = 946929
        Buttons.ColorMirrorDownTo = 5021693
        Buttons.GradientMirror = ggVertical
        ColorTo = clWhite
        ColorDisabled = clWhite
        ColorDisabledTo = clWhite
        Direction = gdHorizontal
        Color = clWhite
        Max = 240
        Slider.BorderColor = 12752500
        Slider.BorderColorDisabled = clBlack
        Slider.Color = clWhite
        Slider.ColorTo = clBlack
        Slider.ColorDisabled = clBlack
        Slider.ColorDisabledTo = clBlack
        Slider.ColorCompleted = clNone
        Slider.ColorCompletedTo = clNone
        Slider.ColorCompletedDisabled = clNone
        Slider.ColorCompletedDisabledTo = clNone
        Slider.Direction = gdHorizontal
        TabOrder = 3
        Thumb.BorderColor = 10317632
        Thumb.BorderColorHot = 10079963
        Thumb.BorderColorDown = 4548219
        Thumb.BorderColorDisabled = clBlack
        Thumb.Color = 15653832
        Thumb.ColorTo = 16178633
        Thumb.ColorDown = 7778289
        Thumb.ColorDownTo = 4296947
        Thumb.ColorHot = 15465983
        Thumb.ColorHotTo = 11332863
        Thumb.ColorDisabled = clBlack
        Thumb.ColorDisabledTo = clBlack
        Thumb.ColorMirror = 15586496
        Thumb.ColorMirrorTo = 16245200
        Thumb.ColorMirrorHot = 5888767
        Thumb.ColorMirrorHotTo = 10807807
        Thumb.ColorMirrorDown = 946929
        Thumb.ColorMirrorDownTo = 5021693
        Thumb.ColorMirrorDisabled = clBlack
        Thumb.ColorMirrorDisabledTo = clBlack
        Thumb.Gradient = ggVertical
        Thumb.GradientMirror = ggRadial
        Thumb.Shape = tsPointer
        TickMark.Color = clWhite
        TickMark.ColorDisabled = clWhite
        TickMark.Font.Charset = DEFAULT_CHARSET
        TickMark.Font.Color = clWindowText
        TickMark.Font.Height = -11
        TickMark.Font.Name = 'Tahoma'
        TickMark.Font.Style = []
        TickMark.Line3D = True
        TickMark.ShowImageAtSteps = 15
        TickMark.Spacing = 10
        TickMark.Size = 10
        TrackHint = True
        TrackLabel.Font.Charset = DEFAULT_CHARSET
        TrackLabel.Font.Color = clWindowText
        TrackLabel.Font.Height = -11
        TrackLabel.Font.Name = 'Tahoma'
        TrackLabel.Font.Style = []
        TrackLabel.Format = 'Pos: %d'
        Transparent = False
        Version = '1.6.2.0'
      end
      object GanttChartGFEndcolourColorSelector: TAdvOfficeColorSelector
        Left = 244
        Top = 200
        Width = 26
        Height = 26
        HelpContext = 440054
        AntiAlias = aaAntiAlias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.3.1.1'
        TabOrder = 4
        AllowFloating = False
        CloseOnSelect = True
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
      object GanttChartGFEndcolourIntensity: TAdvTrackBar
        Left = 299
        Top = 200
        Width = 160
        Height = 27
        HelpContext = 440055
        BorderColor = clBlack
        BorderColorDisabled = clBlack
        Buttons.BorderColor = clBlack
        Buttons.BorderColorHot = 10079963
        Buttons.BorderColorDown = 4548219
        Buttons.Color = 15653832
        Buttons.ColorTo = 16178633
        Buttons.ColorHot = 15465983
        Buttons.ColorHotTo = 11332863
        Buttons.ColorDown = 7778289
        Buttons.ColorDownTo = 4296947
        Buttons.ColorMirror = 15586496
        Buttons.ColorMirrorTo = 16245200
        Buttons.ColorMirrorHot = 5888767
        Buttons.ColorMirrorHotTo = 10807807
        Buttons.ColorMirrorDown = 946929
        Buttons.ColorMirrorDownTo = 5021693
        Buttons.GradientMirror = ggVertical
        ColorTo = clWhite
        ColorDisabled = clWhite
        ColorDisabledTo = clWhite
        Direction = gdHorizontal
        Color = clWhite
        Max = 240
        Slider.BorderColor = 12752500
        Slider.BorderColorDisabled = clBlack
        Slider.Color = clWhite
        Slider.ColorTo = clBlack
        Slider.ColorDisabled = clBlack
        Slider.ColorDisabledTo = clBlack
        Slider.ColorCompleted = clNone
        Slider.ColorCompletedTo = clNone
        Slider.ColorCompletedDisabled = clNone
        Slider.ColorCompletedDisabledTo = clNone
        Slider.Direction = gdHorizontal
        TabOrder = 5
        Thumb.BorderColor = 10317632
        Thumb.BorderColorHot = 10079963
        Thumb.BorderColorDown = 4548219
        Thumb.BorderColorDisabled = clBlack
        Thumb.Color = 15653832
        Thumb.ColorTo = 16178633
        Thumb.ColorDown = 7778289
        Thumb.ColorDownTo = 4296947
        Thumb.ColorHot = 15465983
        Thumb.ColorHotTo = 11332863
        Thumb.ColorDisabled = clBlack
        Thumb.ColorDisabledTo = clBlack
        Thumb.ColorMirror = 15586496
        Thumb.ColorMirrorTo = 16245200
        Thumb.ColorMirrorHot = 5888767
        Thumb.ColorMirrorHotTo = 10807807
        Thumb.ColorMirrorDown = 946929
        Thumb.ColorMirrorDownTo = 5021693
        Thumb.ColorMirrorDisabled = clBlack
        Thumb.ColorMirrorDisabledTo = clBlack
        Thumb.Gradient = ggVertical
        Thumb.GradientMirror = ggRadial
        Thumb.Shape = tsPointer
        TickMark.Color = clWhite
        TickMark.ColorDisabled = clWhite
        TickMark.Font.Charset = DEFAULT_CHARSET
        TickMark.Font.Color = clWindowText
        TickMark.Font.Height = -11
        TickMark.Font.Name = 'Tahoma'
        TickMark.Font.Style = []
        TickMark.Line3D = True
        TickMark.ShowImageAtSteps = 15
        TickMark.Spacing = 10
        TickMark.Size = 10
        TrackHint = True
        TrackLabel.Font.Charset = DEFAULT_CHARSET
        TrackLabel.Font.Color = clWindowText
        TrackLabel.Font.Height = -11
        TrackLabel.Font.Name = 'Tahoma'
        TrackLabel.Font.Style = []
        TrackLabel.Format = 'Pos: %d'
        Transparent = False
        Version = '1.6.2.0'
      end
    end
    object PnlPlanning: TDNMPanel
      Left = 0
      Top = -821
      Width = 1051
      Height = 287
      HelpContext = 440068
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label1: TLabel
        Left = 30
        Top = 30
        Width = 114
        Height = 15
        HelpContext = 440007
        Caption = 'Production Planning'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1037
        Height = 273
        HelpContext = 440069
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 6
        ExplicitWidth = 1051
      end
      object Label3: TLabel
        Left = 53
        Top = 229
        Width = 467
        Height = 30
        HelpContext = 440087
        Caption = 
          '(When Checked, the List Shows All Employees Assigned to any Proc' +
          'ess Steps and       When Unchecked, Shows the Employees Schedule' +
          'd for any Jobs during the period)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object edtCapacityPlanningWeeks: TAdvSpinEdit
        Left = 40
        Top = 76
        Width = 57
        Height = 24
        HelpContext = 440017
        Value = 1
        FloatValue = 1.000000000000000000
        TimeValue = 0.041666666666666660
        HexValue = 0
        Enabled = True
        IncrementFloat = 0.100000000000000000
        IncrementFloatPage = 1.000000000000000000
        LabelCaption = 'Capacity Planning Weeks to Display'
        LabelPosition = lpTopLeft
        LabelTransparent = True
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = [fsBold]
        MaxValue = 52
        MinValue = 1
        TabOrder = 0
        Visible = True
        Version = '1.4.7.0'
        OnChange = edtCapacityPlanningWeeksChange
      end
      object chkResourceAvailableForHolidays: TwwCheckBox
        Left = 40
        Top = 106
        Width = 265
        Height = 17
        HelpContext = 440012
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Resource Un-Available For Holidays'
        TabOrder = 1
        OnClick = chkResourceAvailableForHolidaysClick
      end
      object chkProductionOnSaturdays: TwwCheckBox
        Left = 40
        Top = 140
        Width = 265
        Height = 17
        HelpContext = 440015
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Schedule Production On Weekend Days'
        DataField = 'ScheduleProductionOnWeekendDays'
        TabOrder = 2
        OnClick = chkProductionOnSaturdaysClick
      end
      object chkProdPlanConfirmSave: TwwCheckBox
        Left = 40
        Top = 174
        Width = 265
        Height = 17
        HelpContext = 440021
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Ask For Confirmation Before Saving'
        TabOrder = 3
        OnClick = chkProdPlanConfirmSaveClick
      end
      object chkShowAllEmployeesinProductionScheduler: TwwCheckBox
        Left = 40
        Top = 208
        Width = 265
        Height = 17
        HelpContext = 440088
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Production Scheduler : Show All Employees '
        DataField = 'ShowAllEmployeesinProductionScheduler'
        TabOrder = 4
        OnClick = chkShowAllEmployeesinProductionSchedulerClick
      end
    end
    object pnlStockRequirement: TDNMPanel
      Left = 0
      Top = -534
      Width = 1051
      Height = 281
      HelpContext = 440060
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1037
        Height = 267
        HelpContext = 440061
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 9
        ExplicitWidth = 1051
        ExplicitHeight = 153
      end
      object Label5: TLabel
        Left = 24
        Top = 24
        Width = 116
        Height = 15
        HelpContext = 440011
        Caption = 'Stock Requirements'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label4: TLabel
        Left = 20
        Top = 206
        Width = 100
        Height = 15
        HelpContext = 440063
        Caption = 'Product Template'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object edtAllocationWarningDays: TAdvSpinEdit
        Left = 34
        Top = 66
        Width = 57
        Height = 24
        HelpContext = 440018
        Value = 1
        FloatValue = 1.000000000000000000
        TimeValue = 0.041666666666666660
        HexValue = 0
        Enabled = True
        IncrementFloat = 0.100000000000000000
        IncrementFloatPage = 1.000000000000000000
        LabelCaption = 'Product Delivery Grace Days'
        LabelPosition = lpTopLeft
        LabelTransparent = True
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = [fsBold]
        TabOrder = 0
        Visible = True
        Version = '1.4.7.0'
        OnChange = edtAllocationWarningDaysChange
      end
      object chkAutoCreateSmartOrderFromSalesOrderTree: TwwCheckBox
        Left = 34
        Top = 100
        Width = 449
        Height = 17
        HelpContext = 440014
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Automatically create the Smart Order when Sales Order is created'
        TabOrder = 1
        OnClick = chkAutoCreateSmartOrderFromSalesOrderTreeClick
      end
      object chkOpenTreeOnSmartOrdercreation: TwwCheckBox
        Left = 34
        Top = 133
        Width = 460
        Height = 17
        HelpContext = 440065
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 
          'Open '#39'Process Tree'#39' on Creation of Smart Order in '#39'Production St' +
          'atus'#39' Report'
        TabOrder = 2
        OnClick = chkOpenTreeOnSmartOrdercreationClick
      end
      object chkWarnTemplateOptionDefaultNotDefined: TwwCheckBox
        Left = 42
        Top = 231
        Width = 231
        Height = 17
        HelpContext = 440066
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Prompt if No Process Steps Defined'
        TabOrder = 3
        OnClick = chkWarnTemplateOptionDefaultNotDefinedClick
      end
      object chkWarnTemplateProcessesNotDefined: TwwCheckBox
        Left = 273
        Top = 191
        Width = 225
        Height = 17
        HelpContext = 440013
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Prompt for Default Option Values'
        TabOrder = 4
        Visible = False
        OnClick = chkWarnTemplateProcessesNotDefinedClick
      end
    end
    object pnlautoScheduling: TDNMPanel
      Left = 0
      Top = 621
      Width = 1051
      Height = 224
      HelpContext = 440002
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1037
        Height = 210
        HelpContext = 440003
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 47
        ExplicitTop = 23
        ExplicitWidth = 557
      end
      object Label2: TLabel
        Left = 18
        Top = 12
        Width = 92
        Height = 15
        HelpContext = 440005
        Caption = 'Auto Scheduling'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object edtAutoSchedGraceDays: TAdvSpinEdit
        Left = 28
        Top = 54
        Width = 57
        Height = 24
        HelpContext = 440019
        Value = 1
        FloatValue = 1.000000000000000000
        TimeValue = 0.041666666666666660
        HexValue = 0
        Enabled = True
        IncrementFloat = 0.100000000000000000
        IncrementFloatPage = 1.000000000000000000
        LabelCaption = 'Auto Production Scheduling Grace Days'
        LabelPosition = lpTopLeft
        LabelTransparent = True
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'MS Sans Serif'
        LabelFont.Style = [fsBold]
        MaxValue = 52
        MinValue = 1
        TabOrder = 0
        Visible = True
        Version = '1.4.7.0'
        OnChange = edtAutoSchedGraceDaysChange
      end
      object rgAutoSchedType: TAdvOfficeRadioGroup
        Left = 32
        Top = 86
        Width = 185
        Height = 65
        HelpContext = 440020
        Version = '1.3.0.0'
        Caption = ' Auto Scheduling Type '
        ParentBackground = False
        TabOrder = 1
        OnClick = rgAutoSchedTypeClick
        Items.Strings = (
          'Forward'
          'Reverse')
        Ellipsis = False
      end
      object chkAutoScheduleBasedonBOMEmpRoster: TwwCheckBox
        Left = 29
        Top = 175
        Width = 424
        Height = 17
        HelpContext = 440081
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Auto Schedule Based on BOM Schedule Roster'
        DataField = 'AutoScheduleBasedonBOMEmpRoster'
        TabOrder = 2
        OnClick = chkAutoScheduleBasedonBOMEmpRosterClick
      end
    end
    object pnlcolours: TDNMPanel
      Left = 0
      Top = -253
      Width = 1051
      Height = 261
      HelpContext = 440057
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Bevel6: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1037
        Height = 247
        HelpContext = 440058
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 9
        ExplicitTop = 3
        ExplicitWidth = 523
      end
      object Label6: TLabel
        Left = 30
        Top = 29
        Width = 212
        Height = 15
        HelpContext = 440059
        Caption = 'BOM Product Status Report  : Colours'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 70
        Top = 57
        Width = 148
        Height = 15
        HelpContext = 440033
        Caption = 'Product Quantity Columns'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label12: TLabel
        Left = 83
        Top = 97
        Width = 135
        Height = 15
        HelpContext = 440034
        Caption = 'Sales Quantity Columns'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label11: TLabel
        Left = 79
        Top = 138
        Width = 139
        Height = 15
        HelpContext = 440035
        Caption = 'Order Quantity Columns '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label13: TLabel
        Left = 43
        Top = 178
        Width = 175
        Height = 15
        HelpContext = 440036
        Caption = 'Colour when ETA not exceeded'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 64
        Top = 219
        Width = 154
        Height = 15
        HelpContext = 440037
        Caption = 'Colour when ETA exceeded'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object ProductStatusPartQtyColour: TAdvOfficeColorSelector
        Left = 244
        Top = 53
        Width = 26
        Height = 26
        HelpContext = 440038
        AntiAlias = aaAntiAlias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.3.1.1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        AllowFloating = False
        CloseOnSelect = True
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
      object ProductStatusPartQtyColourIntensity: TAdvTrackBar
        Left = 299
        Top = 53
        Width = 160
        Height = 27
        HelpContext = 440039
        BorderColor = clBlack
        BorderColorDisabled = clBlack
        Buttons.BorderColor = clBlack
        Buttons.BorderColorHot = 10079963
        Buttons.BorderColorDown = 4548219
        Buttons.Color = 15653832
        Buttons.ColorTo = 16178633
        Buttons.ColorHot = 15465983
        Buttons.ColorHotTo = 11332863
        Buttons.ColorDown = 7778289
        Buttons.ColorDownTo = 4296947
        Buttons.ColorMirror = 15586496
        Buttons.ColorMirrorTo = 16245200
        Buttons.ColorMirrorHot = 5888767
        Buttons.ColorMirrorHotTo = 10807807
        Buttons.ColorMirrorDown = 946929
        Buttons.ColorMirrorDownTo = 5021693
        Buttons.GradientMirror = ggVertical
        ColorTo = clWhite
        ColorDisabled = clWhite
        ColorDisabledTo = clWhite
        Direction = gdHorizontal
        Color = clWhite
        Max = 240
        ParentShowHint = False
        ShowHint = True
        Slider.BorderColor = 12752500
        Slider.BorderColorDisabled = clBlack
        Slider.Color = clWhite
        Slider.ColorTo = clBlack
        Slider.ColorDisabled = clBlack
        Slider.ColorDisabledTo = clBlack
        Slider.ColorCompleted = clNone
        Slider.ColorCompletedTo = clNone
        Slider.ColorCompletedDisabled = clNone
        Slider.ColorCompletedDisabledTo = clNone
        Slider.Direction = gdHorizontal
        TabOrder = 1
        Thumb.BorderColor = 10317632
        Thumb.BorderColorHot = 10079963
        Thumb.BorderColorDown = 4548219
        Thumb.BorderColorDisabled = clBlack
        Thumb.Color = 15653832
        Thumb.ColorTo = 16178633
        Thumb.ColorDown = 7778289
        Thumb.ColorDownTo = 4296947
        Thumb.ColorHot = 15465983
        Thumb.ColorHotTo = 11332863
        Thumb.ColorDisabled = clBlack
        Thumb.ColorDisabledTo = clBlack
        Thumb.ColorMirror = 15586496
        Thumb.ColorMirrorTo = 16245200
        Thumb.ColorMirrorHot = 5888767
        Thumb.ColorMirrorHotTo = 10807807
        Thumb.ColorMirrorDown = 946929
        Thumb.ColorMirrorDownTo = 5021693
        Thumb.ColorMirrorDisabled = clBlack
        Thumb.ColorMirrorDisabledTo = clBlack
        Thumb.Gradient = ggVertical
        Thumb.GradientMirror = ggRadial
        Thumb.Shape = tsPointer
        TickMark.Color = clWhite
        TickMark.ColorDisabled = clWhite
        TickMark.Font.Charset = DEFAULT_CHARSET
        TickMark.Font.Color = clWindowText
        TickMark.Font.Height = -11
        TickMark.Font.Name = 'Tahoma'
        TickMark.Font.Style = []
        TickMark.Line3D = True
        TickMark.ShowImageAtSteps = 15
        TickMark.Spacing = 10
        TickMark.Size = 10
        TrackHint = True
        TrackLabel.Font.Charset = DEFAULT_CHARSET
        TrackLabel.Font.Color = clWindowText
        TrackLabel.Font.Height = -11
        TrackLabel.Font.Name = 'Tahoma'
        TrackLabel.Font.Style = []
        TrackLabel.Format = 'Pos: %d'
        Transparent = False
        Version = '1.6.2.0'
      end
      object ProductStatusTransQtyColour: TAdvOfficeColorSelector
        Left = 244
        Top = 93
        Width = 26
        Height = 26
        HelpContext = 440040
        AntiAlias = aaAntiAlias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.3.1.1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        AllowFloating = False
        CloseOnSelect = True
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
      object ProductStatusTransQtyColourIntensity: TAdvTrackBar
        Left = 299
        Top = 93
        Width = 160
        Height = 27
        HelpContext = 440041
        BorderColor = clBlack
        BorderColorDisabled = clBlack
        Buttons.BorderColor = clBlack
        Buttons.BorderColorHot = 10079963
        Buttons.BorderColorDown = 4548219
        Buttons.Color = 15653832
        Buttons.ColorTo = 16178633
        Buttons.ColorHot = 15465983
        Buttons.ColorHotTo = 11332863
        Buttons.ColorDown = 7778289
        Buttons.ColorDownTo = 4296947
        Buttons.ColorMirror = 15586496
        Buttons.ColorMirrorTo = 16245200
        Buttons.ColorMirrorHot = 5888767
        Buttons.ColorMirrorHotTo = 10807807
        Buttons.ColorMirrorDown = 946929
        Buttons.ColorMirrorDownTo = 5021693
        Buttons.GradientMirror = ggVertical
        ColorTo = clWhite
        ColorDisabled = clWhite
        ColorDisabledTo = clWhite
        Direction = gdHorizontal
        Color = clWhite
        Max = 240
        ParentShowHint = False
        ShowHint = True
        Slider.BorderColor = 12752500
        Slider.BorderColorDisabled = clBlack
        Slider.Color = clWhite
        Slider.ColorTo = clBlack
        Slider.ColorDisabled = clBlack
        Slider.ColorDisabledTo = clBlack
        Slider.ColorCompleted = clNone
        Slider.ColorCompletedTo = clNone
        Slider.ColorCompletedDisabled = clNone
        Slider.ColorCompletedDisabledTo = clNone
        Slider.Direction = gdHorizontal
        TabOrder = 3
        Thumb.BorderColor = 10317632
        Thumb.BorderColorHot = 10079963
        Thumb.BorderColorDown = 4548219
        Thumb.BorderColorDisabled = clBlack
        Thumb.Color = 15653832
        Thumb.ColorTo = 16178633
        Thumb.ColorDown = 7778289
        Thumb.ColorDownTo = 4296947
        Thumb.ColorHot = 15465983
        Thumb.ColorHotTo = 11332863
        Thumb.ColorDisabled = clBlack
        Thumb.ColorDisabledTo = clBlack
        Thumb.ColorMirror = 15586496
        Thumb.ColorMirrorTo = 16245200
        Thumb.ColorMirrorHot = 5888767
        Thumb.ColorMirrorHotTo = 10807807
        Thumb.ColorMirrorDown = 946929
        Thumb.ColorMirrorDownTo = 5021693
        Thumb.ColorMirrorDisabled = clBlack
        Thumb.ColorMirrorDisabledTo = clBlack
        Thumb.Gradient = ggVertical
        Thumb.GradientMirror = ggRadial
        Thumb.Shape = tsPointer
        TickMark.Color = clWhite
        TickMark.ColorDisabled = clWhite
        TickMark.Font.Charset = DEFAULT_CHARSET
        TickMark.Font.Color = clWindowText
        TickMark.Font.Height = -11
        TickMark.Font.Name = 'Tahoma'
        TickMark.Font.Style = []
        TickMark.Line3D = True
        TickMark.ShowImageAtSteps = 15
        TickMark.Spacing = 10
        TickMark.Size = 10
        TrackHint = True
        TrackLabel.Font.Charset = DEFAULT_CHARSET
        TrackLabel.Font.Color = clWindowText
        TrackLabel.Font.Height = -11
        TrackLabel.Font.Name = 'Tahoma'
        TrackLabel.Font.Style = []
        TrackLabel.Format = 'Pos: %d'
        Transparent = False
        Version = '1.6.2.0'
      end
      object ProductStatusOrderQtyColour: TAdvOfficeColorSelector
        Left = 244
        Top = 134
        Width = 26
        Height = 26
        HelpContext = 440042
        AntiAlias = aaAntiAlias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.3.1.1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        AllowFloating = False
        CloseOnSelect = True
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
      object ProductStatusETAWithinPeriodColour: TAdvOfficeColorSelector
        Left = 244
        Top = 174
        Width = 26
        Height = 26
        HelpContext = 440043
        AntiAlias = aaAntiAlias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.3.1.1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        AllowFloating = False
        CloseOnSelect = True
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
      object ProductStatusOrderQtyColourIntensity: TAdvTrackBar
        Left = 299
        Top = 134
        Width = 160
        Height = 27
        HelpContext = 440044
        BorderColor = clBlack
        BorderColorDisabled = clBlack
        Buttons.BorderColor = clBlack
        Buttons.BorderColorHot = 10079963
        Buttons.BorderColorDown = 4548219
        Buttons.Color = 15653832
        Buttons.ColorTo = 16178633
        Buttons.ColorHot = 15465983
        Buttons.ColorHotTo = 11332863
        Buttons.ColorDown = 7778289
        Buttons.ColorDownTo = 4296947
        Buttons.ColorMirror = 15586496
        Buttons.ColorMirrorTo = 16245200
        Buttons.ColorMirrorHot = 5888767
        Buttons.ColorMirrorHotTo = 10807807
        Buttons.ColorMirrorDown = 946929
        Buttons.ColorMirrorDownTo = 5021693
        Buttons.GradientMirror = ggVertical
        ColorTo = clWhite
        ColorDisabled = clWhite
        ColorDisabledTo = clWhite
        Direction = gdHorizontal
        Color = clWhite
        Max = 240
        ParentShowHint = False
        ShowHint = True
        Slider.BorderColor = 12752500
        Slider.BorderColorDisabled = clBlack
        Slider.Color = clWhite
        Slider.ColorTo = clBlack
        Slider.ColorDisabled = clBlack
        Slider.ColorDisabledTo = clBlack
        Slider.ColorCompleted = clNone
        Slider.ColorCompletedTo = clNone
        Slider.ColorCompletedDisabled = clNone
        Slider.ColorCompletedDisabledTo = clNone
        Slider.Direction = gdHorizontal
        TabOrder = 6
        Thumb.BorderColor = 10317632
        Thumb.BorderColorHot = 10079963
        Thumb.BorderColorDown = 4548219
        Thumb.BorderColorDisabled = clBlack
        Thumb.Color = 15653832
        Thumb.ColorTo = 16178633
        Thumb.ColorDown = 7778289
        Thumb.ColorDownTo = 4296947
        Thumb.ColorHot = 15465983
        Thumb.ColorHotTo = 11332863
        Thumb.ColorDisabled = clBlack
        Thumb.ColorDisabledTo = clBlack
        Thumb.ColorMirror = 15586496
        Thumb.ColorMirrorTo = 16245200
        Thumb.ColorMirrorHot = 5888767
        Thumb.ColorMirrorHotTo = 10807807
        Thumb.ColorMirrorDown = 946929
        Thumb.ColorMirrorDownTo = 5021693
        Thumb.ColorMirrorDisabled = clBlack
        Thumb.ColorMirrorDisabledTo = clBlack
        Thumb.Gradient = ggVertical
        Thumb.GradientMirror = ggRadial
        Thumb.Shape = tsPointer
        TickMark.Color = clWhite
        TickMark.ColorDisabled = clWhite
        TickMark.Font.Charset = DEFAULT_CHARSET
        TickMark.Font.Color = clWindowText
        TickMark.Font.Height = -11
        TickMark.Font.Name = 'Tahoma'
        TickMark.Font.Style = []
        TickMark.Line3D = True
        TickMark.ShowImageAtSteps = 15
        TickMark.Spacing = 10
        TickMark.Size = 10
        TrackHint = True
        TrackLabel.Font.Charset = DEFAULT_CHARSET
        TrackLabel.Font.Color = clWindowText
        TrackLabel.Font.Height = -11
        TrackLabel.Font.Name = 'Tahoma'
        TrackLabel.Font.Style = []
        TrackLabel.Format = 'Pos: %d'
        Transparent = False
        Version = '1.6.2.0'
      end
      object ProductStatusETAWithinPeriodColourIntensity: TAdvTrackBar
        Left = 299
        Top = 174
        Width = 160
        Height = 27
        HelpContext = 440045
        BorderColor = clBlack
        BorderColorDisabled = clBlack
        Buttons.BorderColor = clBlack
        Buttons.BorderColorHot = 10079963
        Buttons.BorderColorDown = 4548219
        Buttons.Color = 15653832
        Buttons.ColorTo = 16178633
        Buttons.ColorHot = 15465983
        Buttons.ColorHotTo = 11332863
        Buttons.ColorDown = 7778289
        Buttons.ColorDownTo = 4296947
        Buttons.ColorMirror = 15586496
        Buttons.ColorMirrorTo = 16245200
        Buttons.ColorMirrorHot = 5888767
        Buttons.ColorMirrorHotTo = 10807807
        Buttons.ColorMirrorDown = 946929
        Buttons.ColorMirrorDownTo = 5021693
        Buttons.GradientMirror = ggVertical
        ColorTo = clWhite
        ColorDisabled = clWhite
        ColorDisabledTo = clWhite
        Direction = gdHorizontal
        Color = clWhite
        Max = 240
        ParentShowHint = False
        ShowHint = True
        Slider.BorderColor = 12752500
        Slider.BorderColorDisabled = clBlack
        Slider.Color = clWhite
        Slider.ColorTo = clBlack
        Slider.ColorDisabled = clBlack
        Slider.ColorDisabledTo = clBlack
        Slider.ColorCompleted = clNone
        Slider.ColorCompletedTo = clNone
        Slider.ColorCompletedDisabled = clNone
        Slider.ColorCompletedDisabledTo = clNone
        Slider.Direction = gdHorizontal
        TabOrder = 7
        Thumb.BorderColor = 10317632
        Thumb.BorderColorHot = 10079963
        Thumb.BorderColorDown = 4548219
        Thumb.BorderColorDisabled = clBlack
        Thumb.Color = 15653832
        Thumb.ColorTo = 16178633
        Thumb.ColorDown = 7778289
        Thumb.ColorDownTo = 4296947
        Thumb.ColorHot = 15465983
        Thumb.ColorHotTo = 11332863
        Thumb.ColorDisabled = clBlack
        Thumb.ColorDisabledTo = clBlack
        Thumb.ColorMirror = 15586496
        Thumb.ColorMirrorTo = 16245200
        Thumb.ColorMirrorHot = 5888767
        Thumb.ColorMirrorHotTo = 10807807
        Thumb.ColorMirrorDown = 946929
        Thumb.ColorMirrorDownTo = 5021693
        Thumb.ColorMirrorDisabled = clBlack
        Thumb.ColorMirrorDisabledTo = clBlack
        Thumb.Gradient = ggVertical
        Thumb.GradientMirror = ggRadial
        Thumb.Shape = tsPointer
        TickMark.Color = clWhite
        TickMark.ColorDisabled = clWhite
        TickMark.Font.Charset = DEFAULT_CHARSET
        TickMark.Font.Color = clWindowText
        TickMark.Font.Height = -11
        TickMark.Font.Name = 'Tahoma'
        TickMark.Font.Style = []
        TickMark.Line3D = True
        TickMark.ShowImageAtSteps = 15
        TickMark.Spacing = 10
        TickMark.Size = 10
        TrackHint = True
        TrackLabel.Font.Charset = DEFAULT_CHARSET
        TrackLabel.Font.Color = clWindowText
        TrackLabel.Font.Height = -11
        TrackLabel.Font.Name = 'Tahoma'
        TrackLabel.Font.Style = []
        TrackLabel.Format = 'Pos: %d'
        Transparent = False
        Version = '1.6.2.0'
      end
      object ProductStatusETAExceededColour: TAdvOfficeColorSelector
        Left = 244
        Top = 215
        Width = 26
        Height = 26
        HelpContext = 440046
        AntiAlias = aaAntiAlias
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Version = '1.3.1.1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        AllowFloating = False
        CloseOnSelect = True
        CaptionAppearance.BorderColor = clNone
        CaptionAppearance.Color = 13198890
        CaptionAppearance.ColorTo = clNone
        CaptionAppearance.Direction = gdHorizontal
        CaptionAppearance.TextColor = clWhite
        CaptionAppearance.TextColorHot = clBlack
        CaptionAppearance.TextColorDown = clBlack
        CaptionAppearance.ButtonAppearance.ColorChecked = 16111818
        CaptionAppearance.ButtonAppearance.ColorCheckedTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorDisabled = 15921906
        CaptionAppearance.ButtonAppearance.ColorDisabledTo = 15921906
        CaptionAppearance.ButtonAppearance.ColorDown = 16111818
        CaptionAppearance.ButtonAppearance.ColorDownTo = 16367008
        CaptionAppearance.ButtonAppearance.ColorHot = 16117985
        CaptionAppearance.ButtonAppearance.ColorHotTo = 16372402
        CaptionAppearance.ButtonAppearance.ColorMirrorHot = 16107693
        CaptionAppearance.ButtonAppearance.ColorMirrorHotTo = 16775412
        CaptionAppearance.ButtonAppearance.ColorMirrorDown = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorDownTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorChecked = 16102556
        CaptionAppearance.ButtonAppearance.ColorMirrorCheckedTo = 16768988
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabled = 11974326
        CaptionAppearance.ButtonAppearance.ColorMirrorDisabledTo = 15921906
        DragGripAppearance.BorderColor = clGray
        DragGripAppearance.Color = clWhite
        DragGripAppearance.ColorTo = clWhite
        DragGripAppearance.ColorMirror = clSilver
        DragGripAppearance.ColorMirrorTo = clWhite
        DragGripAppearance.Gradient = ggVertical
        DragGripAppearance.GradientMirror = ggVertical
        DragGripAppearance.BorderColorHot = clBlue
        DragGripAppearance.ColorHot = 16117985
        DragGripAppearance.ColorHotTo = 16372402
        DragGripAppearance.ColorMirrorHot = 16107693
        DragGripAppearance.ColorMirrorHotTo = 16775412
        DragGripAppearance.GradientHot = ggRadial
        DragGripAppearance.GradientMirrorHot = ggRadial
        DragGripPosition = gpTop
        Appearance.ColorChecked = 16111818
        Appearance.ColorCheckedTo = 16367008
        Appearance.ColorDisabled = 15921906
        Appearance.ColorDisabledTo = 15921906
        Appearance.ColorDown = 16111818
        Appearance.ColorDownTo = 16367008
        Appearance.ColorHot = 16117985
        Appearance.ColorHotTo = 16372402
        Appearance.ColorMirrorHot = 16107693
        Appearance.ColorMirrorHotTo = 16775412
        Appearance.ColorMirrorDown = 16102556
        Appearance.ColorMirrorDownTo = 16768988
        Appearance.ColorMirrorChecked = 16102556
        Appearance.ColorMirrorCheckedTo = 16768988
        Appearance.ColorMirrorDisabled = 11974326
        Appearance.ColorMirrorDisabledTo = 15921906
        SelectedColor = clNone
        ShowRGBHint = True
        ColorDropDown = 16251129
        ColorDropDownFloating = 16374724
        SelectionAppearance.ColorChecked = 16111818
        SelectionAppearance.ColorCheckedTo = 16367008
        SelectionAppearance.ColorDisabled = 15921906
        SelectionAppearance.ColorDisabledTo = 15921906
        SelectionAppearance.ColorDown = 16111818
        SelectionAppearance.ColorDownTo = 16367008
        SelectionAppearance.ColorHot = 16117985
        SelectionAppearance.ColorHotTo = 16372402
        SelectionAppearance.ColorMirrorHot = 16107693
        SelectionAppearance.ColorMirrorHotTo = 16775412
        SelectionAppearance.ColorMirrorDown = 16102556
        SelectionAppearance.ColorMirrorDownTo = 16768988
        SelectionAppearance.ColorMirrorChecked = 16102556
        SelectionAppearance.ColorMirrorCheckedTo = 16768988
        SelectionAppearance.ColorMirrorDisabled = 11974326
        SelectionAppearance.ColorMirrorDisabledTo = 15921906
        SelectionAppearance.TextColor = clBlack
        SelectionAppearance.TextColorHot = clWhite
        SelectionAppearance.TextColorDown = clWhite
        SelectionAppearance.TextColorChecked = clBlack
        SelectionAppearance.TextColorDisabled = clGray
        SelectionAppearance.Rounded = False
        Tools = <
          item
            BackGroundColor = clBlack
            Caption = 'Automatic'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'Automatic'
            Enable = True
            ItemType = itFullWidthButton
          end
          item
            BackGroundColor = clBlack
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13209
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13107
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13056
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697728
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clNavy
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3486515
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 3355443
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clMaroon
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 26367
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clOlive
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGreen
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clTeal
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clBlue
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10053222
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clGray
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clRed
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 39423
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52377
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6723891
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13421619
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16737843
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clPurple
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10066329
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clFuchsia
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 52479
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clYellow
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clLime
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clAqua
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16763904
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 6697881
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clSilver
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13408767
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10079487
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 10092543
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 13434828
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16777164
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16764057
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = 16751052
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            BackGroundColor = clWhite
            CaptionAlignment = taCenter
            ImageIndex = -1
            Enable = True
          end
          item
            Caption = 'More Colors...'
            CaptionAlignment = taCenter
            ImageIndex = -1
            Hint = 'More Colors'
            Enable = True
            ItemType = itFullWidthButton
          end>
      end
      object ProductStatusETAExceededColourIntensity: TAdvTrackBar
        Left = 299
        Top = 215
        Width = 160
        Height = 27
        HelpContext = 440047
        BorderColor = clBlack
        BorderColorDisabled = clBlack
        Buttons.BorderColor = clBlack
        Buttons.BorderColorHot = 10079963
        Buttons.BorderColorDown = 4548219
        Buttons.Color = 15653832
        Buttons.ColorTo = 16178633
        Buttons.ColorHot = 15465983
        Buttons.ColorHotTo = 11332863
        Buttons.ColorDown = 7778289
        Buttons.ColorDownTo = 4296947
        Buttons.ColorMirror = 15586496
        Buttons.ColorMirrorTo = 16245200
        Buttons.ColorMirrorHot = 5888767
        Buttons.ColorMirrorHotTo = 10807807
        Buttons.ColorMirrorDown = 946929
        Buttons.ColorMirrorDownTo = 5021693
        Buttons.GradientMirror = ggVertical
        ColorTo = clWhite
        ColorDisabled = clWhite
        ColorDisabledTo = clWhite
        Direction = gdHorizontal
        Color = clWhite
        Max = 240
        ParentShowHint = False
        ShowHint = True
        Slider.BorderColor = 12752500
        Slider.BorderColorDisabled = clBlack
        Slider.Color = clWhite
        Slider.ColorTo = clBlack
        Slider.ColorDisabled = clBlack
        Slider.ColorDisabledTo = clBlack
        Slider.ColorCompleted = clNone
        Slider.ColorCompletedTo = clNone
        Slider.ColorCompletedDisabled = clNone
        Slider.ColorCompletedDisabledTo = clNone
        Slider.Direction = gdHorizontal
        TabOrder = 9
        Thumb.BorderColor = 10317632
        Thumb.BorderColorHot = 10079963
        Thumb.BorderColorDown = 4548219
        Thumb.BorderColorDisabled = clBlack
        Thumb.Color = 15653832
        Thumb.ColorTo = 16178633
        Thumb.ColorDown = 7778289
        Thumb.ColorDownTo = 4296947
        Thumb.ColorHot = 15465983
        Thumb.ColorHotTo = 11332863
        Thumb.ColorDisabled = clBlack
        Thumb.ColorDisabledTo = clBlack
        Thumb.ColorMirror = 15586496
        Thumb.ColorMirrorTo = 16245200
        Thumb.ColorMirrorHot = 5888767
        Thumb.ColorMirrorHotTo = 10807807
        Thumb.ColorMirrorDown = 946929
        Thumb.ColorMirrorDownTo = 5021693
        Thumb.ColorMirrorDisabled = clBlack
        Thumb.ColorMirrorDisabledTo = clBlack
        Thumb.Gradient = ggVertical
        Thumb.GradientMirror = ggRadial
        Thumb.Shape = tsPointer
        TickMark.Color = clWhite
        TickMark.ColorDisabled = clWhite
        TickMark.Font.Charset = DEFAULT_CHARSET
        TickMark.Font.Color = clWindowText
        TickMark.Font.Height = -11
        TickMark.Font.Name = 'Tahoma'
        TickMark.Font.Style = []
        TickMark.Line3D = True
        TickMark.ShowImageAtSteps = 15
        TickMark.Spacing = 10
        TickMark.Size = 10
        TrackHint = True
        TrackLabel.Font.Charset = DEFAULT_CHARSET
        TrackLabel.Font.Color = clWindowText
        TrackLabel.Font.Height = -11
        TrackLabel.Font.Name = 'Tahoma'
        TrackLabel.Font.Style = []
        TrackLabel.Format = 'Pos: %d'
        Transparent = False
        Version = '1.6.2.0'
      end
    end
    object DNMPanel1: TDNMPanel
      Left = 0
      Top = 8
      Width = 1051
      Height = 352
      HelpContext = 440089
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      DesignSize = (
        1051
        352)
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1037
        Height = 338
        HelpContext = 440090
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = -25
        ExplicitTop = 60
        ExplicitWidth = 1051
      end
      object Label17: TLabel
        Left = 30
        Top = 30
        Width = 120
        Height = 15
        HelpContext = 440091
        Caption = 'Progress Build Setup'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label19: TLabel
        Left = 109
        Top = 144
        Width = 84
        Height = 15
        HelpContext = 440092
        Anchors = [akLeft, akBottom]
        Caption = 'Progress Build'
      end
      object Label20: TLabel
        Left = 55
        Top = 184
        Width = 138
        Height = 15
        HelpContext = 440093
        Anchors = [akLeft, akBottom]
        Caption = 'Progress Build Wastage'
      end
      object Label21: TLabel
        Left = 69
        Top = 239
        Width = 124
        Height = 15
        HelpContext = 440104
        Anchors = [akLeft, akBottom]
        Caption = 'Production Templates'
        ExplicitTop = 227
      end
      object Label24: TLabel
        Left = 228
        Top = 90
        Width = 79
        Height = 15
        HelpContext = 440105
        Anchors = [akLeft, akBottom]
        Caption = 'Send Email To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Bevel9: TBevel
        Left = 7
        Top = 122
        Width = 1037
        Height = 2
        HelpContext = 440106
        Anchors = [akLeft, akTop, akRight]
        Shape = bsFrame
        ExplicitWidth = 1051
      end
      object Bevel10: TBevel
        Left = 8
        Top = 223
        Width = 1037
        Height = 2
        HelpContext = 440107
        Anchors = [akLeft, akTop, akRight]
        Shape = bsFrame
        ExplicitWidth = 1051
      end
      object btnSetupReportProgressBuild: TDNMSpeedButton
        Left = 199
        Top = 138
        Width = 110
        Height = 27
        HelpContext = 440094
        Anchors = [akLeft, akBottom]
        Caption = 'Choose Report(s)'
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
        TabOrder = 0
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = DoReportOptionsforProgressbuild
      end
      object btnSetupReportProgressBuildWastage: TDNMSpeedButton
        Left = 199
        Top = 178
        Width = 110
        Height = 27
        HelpContext = 440095
        Anchors = [akLeft, akBottom]
        Caption = 'Choose Report(s)'
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
        TabOrder = 1
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = DoReportOptionsforProgressbuildWastage
      end
      object btnSetupReportProductionprogress: TDNMSpeedButton
        Left = 315
        Top = 230
        Width = 110
        Height = 27
        HelpContext = 440108
        Anchors = [akLeft, akBottom]
        Caption = 'Choose Report(s)'
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
        OnClick = btnSetupReportProductionprogressClick
      end
      object chkPrintOnItemcompletion: TwwCheckBox
        Left = 106
        Top = 311
        Width = 194
        Height = 17
        HelpContext = 440101
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
        Caption = 'Print on Production complete'
        DataField = 'PrintOnItemcompletion'
        TabOrder = 3
        OnClick = chkPrintOnItemcompletionClick
      end
      object chkPrintOnItemProgress: TwwCheckBox
        Left = 106
        Top = 270
        Width = 194
        Height = 17
        HelpContext = 440109
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Anchors = [akLeft, akBottom]
        Caption = 'Print on Production Progress'
        DataField = 'PrintOnItemProgress'
        TabOrder = 4
        OnClick = chkPrintOnItemProgressClick
      end
      object Panel1: TPanel
        Left = 315
        Top = 133
        Width = 194
        Height = 70
        HelpContext = 440110
        Anchors = [akLeft, akBottom]
        BevelKind = bkFlat
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 5
        object lblHint1: TLabel
          Left = 0
          Top = 0
          Width = 190
          Height = 66
          HelpContext = 440111
          Align = alClient
          Alignment = taCenter
          Caption = 'These Reports are Printed from "Progress Build"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          OnMouseDown = lblHint1MouseDown
          ExplicitWidth = 182
          ExplicitHeight = 30
        end
      end
      object Panel2: TPanel
        Left = 315
        Top = 263
        Width = 194
        Height = 70
        HelpContext = 440112
        Anchors = [akLeft, akBottom]
        BevelKind = bkFlat
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 6
        object lblHint2: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 184
          Height = 60
          HelpContext = 440113
          Align = alClient
          Alignment = taCenter
          Caption = 'These Reports are Printed from "Production Order Report"'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          WordWrap = True
          ExplicitWidth = 182
          ExplicitHeight = 30
        end
      end
      object chkOnPPGErrorSendEmail: TwwCheckBox
        Left = 86
        Top = 59
        Width = 243
        Height = 17
        HelpContext = 440114
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'On Progress Build Error, Send an Email '
        DataField = 'OnPPGErrorSendEmail'
        TabOrder = 7
        OnClick = chkOnPPGErrorSendEmailClick
      end
      object cboPPErrorEmailTo: TwwDBLookupCombo
        Left = 315
        Top = 86
        Width = 194
        Height = 23
        HelpContext = 440115
        Anchors = [akLeft, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'25'#9'EmployeeName'#9'F')
        DataField = 'PPErrorEmailTo'
        LookupTable = cboEmployeeLookup
        LookupField = 'EmployeeName'
        DropDownWidth = 300
        ParentFont = False
        TabOrder = 8
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = True
        OnChange = cboPPErrorEmailToChange
      end
    end
    object pnlGeneral: TDNMPanel
      Left = 0
      Top = -2155
      Width = 1051
      Height = 1161
      HelpContext = 440056
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel8: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1037
        Height = 1147
        HelpContext = 440008
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitWidth = 511
      end
      object Bevel11: TBevel
        AlignWithMargins = True
        Left = 21
        Top = 943
        Width = 511
        Height = 95
        HelpContext = 440128
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Shape = bsFrame
      end
      object Label10: TLabel
        Left = 11
        Top = 12
        Width = 44
        Height = 15
        HelpContext = 440009
        Caption = 'General'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label18: TLabel
        Left = 19
        Top = 368
        Width = 290
        Height = 15
        HelpContext = 440083
        Caption = 'Number of Decimal Places for Cost in the BOM Tree'
        Transparent = True
      end
      object Label22: TLabel
        Left = 176
        Top = 973
        Width = 51
        Height = 15
        HelpContext = 440096
        Caption = 'Wastage'
        Transparent = True
      end
      object lblResetSaleDateWhenBuilthint: TLabel
        Left = 43
        Top = 427
        Width = 424
        Height = 42
        HelpContext = 440098
        Caption = 
          '(In Sales Orders with Serialised Products,                      ' +
          '                                                 If Progress Bui' +
          'lt Date is Prior to Sales Order Date,                           ' +
          '                    Reset the Sales Order Date to be Prior to th' +
          'e Build Date - To Track Serial Number Availability)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label23: TLabel
        Left = 41
        Top = 884
        Width = 91
        Height = 15
        HelpContext = 440116
        Caption = 'Default Process'
        Transparent = True
      end
      object Label26: TLabel
        Left = 97
        Top = 1004
        Width = 130
        Height = 15
        HelpContext = 440096
        Caption = 'Non Product Sub Items'
        Transparent = True
      end
      object Label27: TLabel
        Left = 28
        Top = 949
        Width = 156
        Height = 15
        HelpContext = 440096
        Caption = 'Account for Progress Build '
        Transparent = True
      end
      object chkManufacturePartSourceStockconfirm: TwwCheckBox
        Left = 18
        Top = 44
        Width = 490
        Height = 17
        HelpContext = 440028
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 
          'Open Product Source Option from Sale. (ie. Stock Or Manufacture.' +
          ')'
        DataField = 'ManufacturePartSourceStockconfirm'
        TabOrder = 0
        OnClick = chkManufacturePartSourceStockconfirmClick
      end
      object chkManufacturePartSourceStock: TwwCheckBox
        Left = 18
        Top = 79
        Width = 490
        Height = 17
        HelpContext = 440029
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Manufacture Part Source from Stock By Default'
        DataField = 'ManufacturePartSourceStock'
        TabOrder = 1
        OnClick = chkManufacturePartSourceStockClick
      end
      object chkOpenTreeFromSalesOrder: TwwCheckBox
        Left = 18
        Top = 115
        Width = 490
        Height = 17
        HelpContext = 440030
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Open Process Tree From Sales Order when Product Selected'
        DataField = 'OpenTreeFromSalesOrder'
        TabOrder = 2
        OnClick = chkOpenTreeFromSalesOrderClick
      end
      object chkCapacityplannerSelectionOptionBeforeLoad: TwwCheckBox
        Left = 18
        Top = 151
        Width = 490
        Height = 17
        HelpContext = 440031
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Capacity Planner : Show Selection Options '
        DataField = 'CapacityplannerSelectionOptionBeforeLoad'
        TabOrder = 7
        OnClick = chkCapacityplannerSelectionOptionBeforeLoadClick
      end
      object chkOnlyshowScheduledJobsForBarCodeMan: TwwCheckBox
        Left = 18
        Top = 295
        Width = 490
        Height = 17
        HelpContext = 440079
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Show '#39'Scheduled'#39' Jobs For Bar Code Manufacturing'
        DataField = 'OnlyshowScheduledJobsForBarCodeMan'
        TabOrder = 3
        OnClick = chkOnlyshowScheduledJobsForBarCodeManClick
      end
      object chkHideSelectedSubnodesinReport: TwwCheckBox
        Left = 18
        Top = 187
        Width = 490
        Height = 17
        HelpContext = 440032
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Hide Option Selections from '#39'Sales Order Manufacture Report'#39
        DataField = 'HideSelectedSubnodesinReport'
        TabOrder = 4
        OnClick = chkHideSelectedSubnodesinReportClick
      end
      object chkAutoclockOnemployeeOnjob: TwwCheckBox
        Left = 18
        Top = 223
        Width = 490
        Height = 17
        HelpContext = 440075
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Automatically   '#39'Clock On/Off'#39'   When job   Started / Stopped'
        DataField = 'AutoclockOnemployeeOnjob'
        TabOrder = 5
        OnClick = chkAutoclockOnemployeeOnjobClick
      end
      object chkCompleteBOMOrderOnSave: TwwCheckBox
        Left = 18
        Top = 259
        Width = 490
        Height = 17
        HelpContext = 440077
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Complete BOM Order On Save'
        DataField = 'CompleteBOMOrderOnSave'
        TabOrder = 6
        OnClick = chkCompleteBOMOrderOnSaveClick
      end
      object edtCostDecimalPlacesinTree: TEdit
        Left = 322
        Top = 364
        Width = 68
        Height = 23
        HelpContext = 440085
        TabOrder = 8
        Text = '0'
        OnChange = edtCostDecimalPlacesinTreeChange
      end
      object chkDefaultCoupenTimeinWOTimesheet: TwwCheckBox
        Left = 18
        Top = 331
        Width = 490
        Height = 17
        HelpContext = 440086
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Work Order Timesheet : Coupon Time  By Default'
        DataField = 'DefaultCoupenTimeinWOTimesheet'
        TabOrder = 9
        OnClick = chkDefaultCoupenTimeinWOTimesheetClick
      end
      object cboDefaultBOMWastageAccount: TwwDBLookupCombo
        Left = 235
        Top = 969
        Width = 191
        Height = 23
        HelpContext = 440097
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'20'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        LookupTable = qryDefaultBOMWastageAccount
        LookupField = 'AccountName'
        ParentFont = False
        TabOrder = 22
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnChange = cboDefaultBOMWastageAccountChange
      end
      object cboBoMNonProductsubnodePostingAccount: TwwDBLookupCombo
        Left = 235
        Top = 1000
        Width = 191
        Height = 23
        HelpContext = 440097
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'20'#9'Account Name'#9'T'
          'Type'#9'20'#9'Type'#9'T')
        LookupTable = QryBoMNonProductsubnodePostingAccount
        LookupField = 'AccountName'
        ParentFont = False
        TabOrder = 19
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnChange = cboBoMNonProductsubnodePostingAccountChange
      end
      object chkResetSaleDateWhenBuilt: TwwCheckBox
        Left = 18
        Top = 408
        Width = 490
        Height = 17
        HelpContext = 440117
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Reset Sales Order Date When Built'
        DataField = 'ResetSaleDateWhenBuilt'
        TabOrder = 10
        OnClick = chkResetSaleDateWhenBuiltClick
      end
      object chkUseSteelWeight: TwwCheckBox
        Left = 18
        Top = 488
        Width = 490
        Height = 17
        HelpContext = 440102
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Use "Steel Weight" (Custom field 7 on Products) in Reports'
        DataField = 'UseFld7AsSteelWeight'
        TabOrder = 14
        OnClick = chkUseSteelWeightClick
      end
      object chkRoundBatchQtyinProgressBatchCreator: TwwCheckBox
        Left = 18
        Top = 823
        Width = 490
        Height = 17
        HelpContext = 440118
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Round Batch Qty in Progress Batch Creator'
        DataField = 'RoundBatchQtyinProgressBatchCreator'
        TabOrder = 11
        OnClick = chkRoundBatchQtyinProgressBatchCreatorClick
      end
      object chkUpdateProductDescriptionFromTreeInfo: TwwCheckBox
        Left = 18
        Top = 529
        Width = 490
        Height = 17
        HelpContext = 440119
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Update Product Card Description From Tree Info'
        TabOrder = 12
        OnClick = chkUpdateProductDescriptionFromTreeInfoClick
      end
      object optCopyInfotoSalesDesc: TAdvOfficeRadioGroup
        Left = 18
        Top = 563
        Width = 345
        Height = 105
        HelpContext = 440120
        Version = '1.3.0.0'
        Caption = 'Sales Order Description from Tree '
        ParentBackground = False
        TabOrder = 13
        OnClick = optCopyInfotoSalesDescClick
        Items.Strings = (
          'Copy Root Node "Info" to the Sales Order Description'
          'Copy All Node "Info" to the Sales Order Description'
          'Do Not Change Sales Order Desciprion')
        Ellipsis = False
      end
      object chkAutoAllocateProcessForTreeRoot: TwwCheckBox
        Left = 18
        Top = 853
        Width = 490
        Height = 17
        HelpContext = 440121
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Auto Allocate Process For Tree Root For New Product'
        DataField = 'AutoAllocateProcessForTreeRoot'
        TabOrder = 15
        OnClick = chkAutoAllocateProcessForTreeRootClick
      end
      object cboDefaultProcessforTree: TwwDBLookupCombo
        Left = 138
        Top = 880
        Width = 191
        Height = 23
        HelpContext = 440122
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Description'#9'25'#9'Description'#9'F'
          'HourlyLabourRate'#9'10'#9'Rate'#9'F'
          'HourlyOverheadRate'#9'10'#9'Overhead Rate'#9'F')
        LookupTable = qryProcessSteps
        LookupField = 'Description'
        ParentFont = False
        TabOrder = 16
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnChange = cboDefaultProcessforTreeChange
      end
      object edtDefaultTreeProcessDuration: TMaskEditEx
        Left = 344
        Top = 880
        Width = 55
        Height = 23
        HelpContext = 440123
        EditMask = '!90:00:00;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 17
        Text = '  :  :  '
        OnChange = edtDefaultTreeProcessDurationChange
        Version = '1.2.0.0'
      end
      object chkConfirmQtysOnfinalise: TwwCheckBox
        Left = 18
        Top = 915
        Width = 490
        Height = 17
        HelpContext = 440124
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Confirm Qtys On Finalise?'
        DataField = 'ConfirmQtysOnfinalise'
        TabOrder = 18
        OnClick = chkConfirmQtysOnfinaliseClick
      end
      object optBomSalesPriceOptions: TAdvOfficeRadioGroup
        Left = 18
        Top = 688
        Width = 511
        Height = 116
        HelpContext = 440125
        Version = '1.3.0.0'
        Caption = 'BOM Sales : Price Calculation Options'
        ParentBackground = False
        TabOrder = 20
        OnClick = optBomSalesPriceOptionsClick
        Items.Strings = (
          'Ignore Price Calculation from BOM Price and Use Main Price'
          'Calculate Price from Sales BOM '
          
            'Customer'#39's Special Price Overrides Calculated Price (If Provided' +
            ') '
          'Standard Pricing')
        Ellipsis = False
      end
      object optBuildDetailsUpdateOption: TAdvOfficeRadioGroup
        Left = 21
        Top = 1038
        Width = 511
        Height = 102
        HelpContext = 440126
        Version = '1.3.0.0'
        Caption = 'BOM Tree Details on Sales'
        ParentBackground = False
        TabOrder = 21
        OnClick = optBuildDetailsUpdateOptionClick
        Items.Strings = (
          'Replace Product Description Memo'
          'Append to Product Description Memo'
          'None')
        Ellipsis = False
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = -994
      Width = 1051
      Height = 173
      HelpContext = 440127
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      DesignSize = (
        1051
        173)
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1037
        Height = 159
        HelpContext = 440128
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 10
        ExplicitWidth = 557
        ExplicitHeight = 210
      end
      object Label25: TLabel
        Left = 18
        Top = 12
        Width = 43
        Height = 15
        HelpContext = 440129
        Caption = 'Costing'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblUseCurrentCostforProgressBuildhint: TLabel
        Left = 29
        Top = 56
        Width = 1017
        Height = 104
        HelpContext = 440130
        Anchors = [akLeft, akTop, akRight, akBottom]
        AutoSize = False
        Caption = 'When Checked, '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 1019
      end
      object chkUseCurrentCostforProgressBuild: TwwCheckBox
        Left = 28
        Top = 33
        Width = 460
        Height = 17
        HelpContext = 440131
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Use Current Cost for Progress Build'
        DataField = 'UseCurrentCostforProgressBuild'
        TabOrder = 0
        OnClick = chkUseCurrentCostforProgressBuildClick
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = 845
      Width = 1051
      Height = 133
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object Bevel12: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1037
        Height = 119
        HelpContext = 440003
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 6
        ExplicitWidth = 1051
        ExplicitHeight = 152
      end
      object Label28: TLabel
        Left = 18
        Top = 12
        Width = 243
        Height = 15
        HelpContext = 440005
        Caption = 'Progress Build Balance Adjustment Details'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label29: TLabel
        Left = 50
        Top = 54
        Width = 86
        Height = 15
        HelpContext = 75025
        Caption = 'Account Name '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label30: TLabel
        Left = 81
        Top = 83
        Width = 55
        Height = 15
        HelpContext = 75029
        Caption = 'Employee'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object edtPPGBalanceAdjAccount: TwwDBEdit
        Left = 161
        Top = 50
        Width = 234
        Height = 23
        DataField = 'AccountName'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtPPGBalanceAdjEmployee: TwwDBEdit
        Left = 161
        Top = 79
        Width = 234
        Height = 23
        DataField = 'EmployeeName'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object btnPPGBalanceAdjAccount: TDNMSpeedButton
        Left = 401
        Top = 50
        Width = 31
        Height = 23
        Caption = '. . .'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = btnPPGBalanceAdjAccountClick
      end
      object btnPPGBalanceAdjEmployee: TDNMSpeedButton
        Left = 401
        Top = 79
        Width = 31
        Height = 23
        Caption = '. . .'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = btnPPGBalanceAdjEmployeeClick
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 696
    Top = 83
  end
  inherited tmrdelay: TTimer
    Left = 728
    Top = 83
  end
  inherited popSpelling: TPopupMenu
    Left = 760
    Top = 83
  end
  inherited tmrdelayMsg: TTimer
    Left = 664
    Top = 83
  end
  object qryDefaultBOMWastageAccount: TERPQuery
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 664
    Top = 49
    object qryDefaultBOMWastageAccountAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 20
      FieldName = 'AccountName'
      Size = 50
    end
    object qryDefaultBOMWastageAccountType: TWideStringField
      DisplayWidth = 20
      FieldName = 'Type'
      Size = 255
    end
  end
  object qryProcessSteps: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT ps.Id, ps.Description, ps.Active , PS.DefaultDuration ,'
      
        'R.HourlyOverheadRate, R.HourlyLabourRate ,R.BreakdownHoursDay ,R' +
        '.SetupHoursDay'
      
        'FROM tblprocessstep ps inner join tblProcResourceProcess rp on r' +
        'p.ProcessStepId = ps.Id'
      
        'inner join  tblProcResource r  on r.ProcResourceId = rp.ProcReso' +
        'urceId '
      'Where ((r.Active = "T" AND ps.Active = "T") OR (ps.Id = :Id))'
      'ORDER BY ps.Description')
    Left = 734
    Top = 49
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Id'
      end>
    object qryProcessStepsDescription: TWideStringField
      DisplayWidth = 25
      FieldName = 'Description'
      Origin = 'ps.Description'
      Size = 255
    end
    object qryProcessStepsHourlyLabourRate: TFloatField
      DisplayLabel = 'Rate'
      DisplayWidth = 10
      FieldName = 'HourlyLabourRate'
      Origin = 'r.HourlyLabourRate'
    end
    object qryProcessStepsHourlyOverheadRate: TFloatField
      DisplayLabel = 'Overhead Rate'
      DisplayWidth = 10
      FieldName = 'HourlyOverheadRate'
      Origin = 'r.HourlyOverheadRate'
    end
    object qryProcessStepsId: TIntegerField
      FieldName = 'Id'
      Origin = 'ps.ID'
      Visible = False
    end
    object qryProcessStepsActive: TWideStringField
      FieldName = 'Active'
      Origin = 'ps.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryProcessStepsDefaultDuration: TFloatField
      FieldName = 'DefaultDuration'
      Origin = 'ps.DefaultDuration'
      Visible = False
    end
    object qryProcessStepsBreakdownHoursDay: TFloatField
      FieldName = 'BreakdownHoursDay'
      Origin = 'r.BreakdownHoursDay'
      Visible = False
    end
    object qryProcessStepsSetupHoursDay: TFloatField
      FieldName = 'SetupHoursDay'
      Origin = 'r.SetupHoursDay'
      Visible = False
    end
  end
  object MyConnection1: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    LoginPrompt = False
    Left = 699
    Top = 49
  end
  object cboEmployeeLookup: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT E.EmployeeID, E.EmployeeName  AS EmployeeName '
      
        'FROM tblEmployees  E inner join tblpassword P on E.employeeId = ' +
        'P.employeeId'
      'WHERE (((E.Active)<>'#39'F'#39'))  '
      'ORDER BY EmployeeName;')
    AutoCalcFields = False
    Options.LongStrings = False
    Left = 770
    Top = 52
  end
  object QryBoMNonProductsubnodePostingAccount: TERPQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT tblChartofAccounts.*, AccDesc as Type'
      'FROM tblChartofAccounts'
      'LEFT JOIN tblacctypedesc on  AccType = AccountType'
      'WHERE IsHeader = '#39'F'#39' AND Active = '#39'T'#39
      'ORDER BY AccDesc, AccountName;')
    Left = 808
    Top = 49
    object QryBoMNonProductsubnodePostingAccountAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
    object QryBoMNonProductsubnodePostingAccountType: TWideStringField
      FieldName = 'Type'
      Size = 255
    end
  end
end
