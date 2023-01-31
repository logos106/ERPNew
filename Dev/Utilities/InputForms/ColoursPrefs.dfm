inherited ColourPrefsGUI: TColourPrefsGUI
  Left = 2338
  Top = 7
  HelpContext = 71000
  Caption = 'Colour Preferences'
  ClientHeight = 1048
  ClientWidth = 1084
  ExplicitLeft = 2338
  ExplicitTop = 7
  ExplicitWidth = 1100
  ExplicitHeight = 1087
  PixelsPerInch = 96
  TextHeight = 13
  object lblWidth: TLabel [0]
    Left = 16
    Top = 8
    Width = 863
    Height = 22
    HelpContext = 71001
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
    Top = 1048
    Width = 1084
    HelpContext = 71092
    ExplicitTop = 807
    ExplicitWidth = 707
  end
  inherited sbpanels: TAdvScrollBox
    Width = 1084
    Height = 1048
    HelpContext = 71147
    ExplicitWidth = 1084
    ExplicitHeight = 921
    object pnlColours: TDNMPanel
      Left = 0
      Top = 131
      Width = 1082
      Height = 789
      HelpContext = 71002
      Align = alTop
      AutoSize = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 1065
      object pnlGeneral: TDNMPanel
        Left = 1
        Top = 271
        Width = 1080
        Height = 29
        HelpContext = 71005
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        ExplicitWidth = 1063
        object lblGeneral: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71006
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'General'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object GeneralColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71007
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object GeneralGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71008
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object GeneralReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71009
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel1: TDNMPanel
        Left = 1
        Top = 39
        Width = 1080
        Height = 29
        HelpContext = 71010
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        ExplicitWidth = 1063
        object Label3: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71011
          Margins.Left = 44
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Accounts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object AccountsColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71012
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object AccountsGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71013
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object AccountsReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71014
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel3: TDNMPanel
        Left = 1
        Top = 68
        Width = 1080
        Height = 29
        HelpContext = 71015
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 2
        ExplicitWidth = 1063
        object Label4: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71016
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Appointments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object AppointmentsColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71017
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object AppointmentsGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71018
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object AppointmentsReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71019
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel4: TDNMPanel
        Left = 1
        Top = 126
        Width = 1080
        Height = 29
        HelpContext = 71020
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 3
        ExplicitWidth = 1063
        object Label5: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71021
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'CRM'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object CRMColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71022
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object CRMGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71023
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object CRMReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71024
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel5: TDNMPanel
        Left = 1
        Top = 213
        Width = 1080
        Height = 29
        HelpContext = 71025
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 4
        ExplicitWidth = 1063
        object Label6: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71026
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Employee'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object EmployeeColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71027
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object EmployeeGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71028
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object EmployeeReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71029
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel6: TDNMPanel
        Left = 1
        Top = 242
        Width = 1080
        Height = 29
        HelpContext = 71030
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 5
        ExplicitWidth = 1063
        object Label7: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71031
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Fixed Assets'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object FixedAssetsColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71032
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object FixedAssetsGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71033
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object FixedAssetsReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71034
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel7: TDNMPanel
        Left = 1
        Top = 532
        Width = 1080
        Height = 29
        HelpContext = 71035
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 6
        ExplicitWidth = 1063
        object Label8: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71036
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Purchases'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object PurchasesColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71037
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object PurchasesGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71038
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object PurchasesReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71039
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel2: TDNMPanel
        Left = 1
        Top = 358
        Width = 1080
        Height = 29
        HelpContext = 71040
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 7
        ExplicitWidth = 1063
        object Label9: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71041
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Inventory'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object InventoryColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71042
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object InventoryGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71043
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object InventoryReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71044
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel8: TDNMPanel
        Left = 1
        Top = 387
        Width = 1080
        Height = 29
        HelpContext = 71050
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 9
        ExplicitWidth = 1063
        object Label11: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71051
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Manufacturing'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object ManufacturingColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71052
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object ManufacturingGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71053
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object ManufacturingReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71054
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel10: TDNMPanel
        Left = 1
        Top = 416
        Width = 1080
        Height = 29
        HelpContext = 71055
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 10
        ExplicitWidth = 1063
        object Label12: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71056
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Miscellaneous'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object MiscellaneousColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71057
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object MiscellaneousGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71058
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object MiscellaneousReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71059
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel11: TDNMPanel
        Left = 1
        Top = 474
        Width = 1080
        Height = 29
        HelpContext = 71060
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 11
        ExplicitWidth = 1063
        object Label13: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71061
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Payroll'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object PayrollColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71062
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object PayrollGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71063
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object PayrollReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71064
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel12: TDNMPanel
        Left = 1
        Top = 590
        Width = 1080
        Height = 29
        HelpContext = 71065
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 12
        ExplicitWidth = 1063
        object Label14: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71066
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Returns'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object ReturnsColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71067
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object ReturnsGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71068
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object ReturnsReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71069
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel13: TDNMPanel
        Left = 1
        Top = 619
        Width = 1080
        Height = 29
        HelpContext = 71070
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 13
        ExplicitLeft = 2
        ExplicitTop = 596
        object Label15: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71071
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Sales'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object SalesColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71072
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object SalesGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71073
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object SalesReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71074
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel14: TDNMPanel
        Left = 1
        Top = 648
        Width = 1080
        Height = 29
        HelpContext = 71075
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 14
        ExplicitTop = 619
        ExplicitWidth = 1063
        object Label18: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71076
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Sales Order'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object SalesOrderColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71077
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object SalesOrderGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71078
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object SalesOrderReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71079
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel17: TDNMPanel
        Left = 1
        Top = 735
        Width = 1080
        Height = 29
        HelpContext = 71080
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 15
        ExplicitTop = 648
        ExplicitWidth = 1063
        object Label19: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71081
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Utilities'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object UtilitiesColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71082
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object UtilitiesGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71083
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object UtilitiesReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71084
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object pnlTraining: TDNMPanel
        Left = 1
        Top = 706
        Width = 1080
        Height = 29
        HelpContext = 71095
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 16
        ExplicitLeft = 2
        ExplicitTop = 695
        object Label16: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71096
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Training'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object TrainingColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71097
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object TrainingGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71098
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object TrainingReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71099
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel15: TDNMPanel
        Left = 1
        Top = 97
        Width = 1080
        Height = 29
        HelpContext = 71100
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 17
        ExplicitWidth = 1063
        object lable33: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71101
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Banking'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object bankingColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71102
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object bankingGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71103
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object DNMSpeedButton1: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71104
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel16: TDNMPanel
        Left = 1
        Top = 155
        Width = 1080
        Height = 29
        HelpContext = 71105
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 18
        ExplicitWidth = 1063
        object Label17: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71106
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Delivery'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object DeliveryColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71107
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object DeliveryGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71108
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object DNMSpeedButton2: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71109
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel18: TDNMPanel
        Left = 1
        Top = 445
        Width = 1080
        Height = 29
        HelpContext = 71110
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 19
        ExplicitWidth = 1063
        object Label20: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71111
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Payments'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object PaymentsColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71112
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object PaymentsGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71113
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object DNMSpeedButton3: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71114
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel20: TDNMPanel
        Left = 1
        Top = 503
        Width = 1080
        Height = 29
        HelpContext = 71115
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 20
        ExplicitWidth = 1063
        object Label21: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71116
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'POS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object POSColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71117
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object POSGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71118
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object DNMSpeedButton4: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71119
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel21: TDNMPanel
        Left = 1
        Top = 561
        Width = 1080
        Height = 29
        HelpContext = 71120
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 21
        ExplicitWidth = 1063
        object Label22: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71121
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Repairs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object RepairsColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71122
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object RepairsGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71123
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object DNMSpeedButton5: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71124
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object btnExport: TDNMSpeedButton
        Left = 428
        Top = 57
        Width = 80
        Height = 47
        HelpContext = 71125
        Cancel = True
        Caption = 'Export for Default'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 22
        TabStop = False
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnExportClick
      end
      object DNMPanel22: TDNMPanel
        Left = 1
        Top = 300
        Width = 1080
        Height = 29
        HelpContext = 71126
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 23
        ExplicitWidth = 1063
        object Label23: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71127
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Google'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object GoogleColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71128
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object GoogleGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71129
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object GoogleReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71130
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel23: TDNMPanel
        Left = 1
        Top = 184
        Width = 1080
        Height = 29
        HelpContext = 71131
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 24
        ExplicitWidth = 1063
        object Label24: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71132
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Ebay'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object ebayColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71133
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object EBayGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71134
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object ebayReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71135
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel24: TDNMPanel
        Left = 1
        Top = 1
        Width = 1080
        Height = 38
        HelpContext = 71136
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 25
        ExplicitWidth = 1063
        object Label1: TLabel
          Left = 200
          Top = 12
          Width = 37
          Height = 15
          HelpContext = 71003
          Caption = 'Colour'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
        end
        object Label2: TLabel
          Left = 275
          Top = 12
          Width = 102
          Height = 15
          HelpContext = 71004
          Caption = 'Gradient  Intensity'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
        end
        object btnDefault: TDNMSpeedButton
          Left = 50
          Top = 6
          Width = 87
          Height = 27
          HelpContext = 71086
          Cancel = True
          Caption = 'Defaults'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 0
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btnDefaultClick
        end
        object btnResetAll: TDNMSpeedButton
          Left = 428
          Top = 6
          Width = 87
          Height = 27
          HelpContext = 71085
          Cancel = True
          Caption = '&Reset All'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
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
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          NumGlyphs = 2
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 1
          TabStop = False
          AutoDisableParentOnclick = True
          OnClick = btnResetAllClick
        end
      end
      object DNMPanel9: TDNMPanel
        Left = 1
        Top = 759
        Width = 1080
        Height = 29
        HelpContext = 71045
        Align = alBottom
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 8
        ExplicitLeft = 15
        ExplicitTop = 384
        object Label10: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71046
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Main Background'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          Visible = False
        end
        object MainBackgroundColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71047
          Margins.Left = 10
          Align = alLeft
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
          TabOrder = 0
          Visible = False
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
          Enabled = False
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object MainBackgroundGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71048
          Margins.Left = 10
          Align = alLeft
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
          Enabled = False
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
          Visible = False
          OnChange = AccountsGradIntensityChange
        end
        object MainBackgroundReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71049
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          Visible = False
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
        object chkShowImageOnMainBackGround: TDBCheckBox
          AlignWithMargins = True
          Left = 417
          Top = 0
          Width = 69
          Height = 29
          HelpContext = 71094
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Use image'
          DataField = 'ShowImageOnMainBackGround'
          DataSource = dsPersonalPreferences
          Enabled = False
          TabOrder = 3
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          Visible = False
          WordWrap = True
          OnClick = chkShowImageOnMainBackGroundClick
        end
      end
      object DNMPanel26: TDNMPanel
        Left = 1
        Top = 329
        Width = 1080
        Height = 29
        HelpContext = 71137
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 26
        ExplicitWidth = 1063
        object Label25: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71138
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Hire'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object HireColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71139
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object HireGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71140
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object HireReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71141
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
      object DNMPanel27: TDNMPanel
        Left = 1
        Top = 677
        Width = 1080
        Height = 29
        HelpContext = 71070
        Align = alTop
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 27
        ExplicitLeft = 9
        ExplicitTop = 674
        object Label30: TLabel
          Left = 0
          Top = 0
          Width = 150
          Height = 29
          HelpContext = 71071
          Align = alLeft
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Seed To Sale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object SeedToSaleColorSelector: TAdvOfficeColorSelector
          AlignWithMargins = True
          Left = 160
          Top = 3
          Width = 26
          Height = 23
          HelpContext = 71072
          Margins.Left = 10
          Align = alLeft
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
          OnSelectColor = AccountsColorSelectorSelectColor
        end
        object SeedToSaleGradIntensity: TAdvTrackBar
          AlignWithMargins = True
          Left = 199
          Top = 3
          Width = 160
          Height = 23
          HelpContext = 71073
          Margins.Left = 10
          Align = alLeft
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
          OnChange = AccountsGradIntensityChange
        end
        object SeedToSaleReset: TDNMSpeedButton
          AlignWithMargins = True
          Left = 372
          Top = 3
          Width = 42
          Height = 23
          HelpContext = 71074
          Margins.Left = 10
          Align = alLeft
          Caption = 'Reset'
          Color = clWhite
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentColor = False
          ParentFont = False
          SlowDecease = True
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = AccountsResetClick
        end
      end
    end
    object DNMPanel25: TDNMPanel
      Left = 0
      Top = 0
      Width = 1082
      Height = 131
      HelpContext = 71142
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 1065
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1068
        Height = 117
        HelpContext = 71143
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 8
        ExplicitTop = 6
        ExplicitWidth = 1051
        ExplicitHeight = 141
      end
      object Label26: TLabel
        Left = 24
        Top = 14
        Width = 42
        Height = 15
        HelpContext = 71144
        Caption = 'Images'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label27: TLabel
        Left = 100
        Top = 84
        Width = 85
        Height = 15
        HelpContext = 71145
        Caption = 'Image Scheme'
        Transparent = True
      end
      object cboImageSchemes: TwwDBLookupCombo
        Left = 200
        Top = 80
        Width = 225
        Height = 23
        HelpContext = 71146
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'name'#9'20'#9'Name'#9'F')
        DataField = 'ImageScheme'
        DataSource = dsPersonalPreferences
        LookupTable = qryImageSchemesLookup
        LookupField = 'Name'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboImageSchemesCloseUp
      end
      object btnPersonelColorPrefs: TDNMSpeedButton
        Left = 200
        Top = 30
        Width = 225
        Height = 27
        HelpContext = 71148
        Cancel = True
        Caption = 'List Colour Preferences'
        Color = clWhite
        DisableTransparent = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        ParentFont = False
        SlowDecease = True
        Style = bsModern
        TabOrder = 1
        TabStop = False
        AutoDisableParentOnclick = True
        OnClick = btnPersonelColorPrefsClick
      end
    end
    object DNMPanel19: TDNMPanel
      Left = 0
      Top = 920
      Width = 1082
      Height = 81
      HelpContext = 71087
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Visible = False
      Category = 'Raptor'
      DesignSize = (
        1082
        81)
      object Bevel2: TBevel
        Left = 8
        Top = 8
        Width = 706
        Height = 65
        HelpContext = 71088
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 529
      end
      object Label28: TLabel
        Left = 14
        Top = 14
        Width = 38
        Height = 15
        HelpContext = 71089
        Caption = 'Raptor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label29: TLabel
        Left = 24
        Top = 42
        Width = 169
        Height = 15
        HelpContext = 71090
        Caption = 'Submissions begin at number'
        Transparent = True
      end
      object edtRaptorSalesStartsAt: TEdit
        Left = 208
        Top = 34
        Width = 57
        Height = 23
        HelpContext = 71091
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 745
    Top = 67
  end
  inherited tmrdelay: TTimer
    Left = 800
    Top = 72
  end
  inherited tmrdelayMsg: TTimer
    Left = 864
    Top = 72
  end
  object MyConnection: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 600
    Top = 48
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'ColourAccounts'
      'ColourAppointments'
      'Colourbanking'
      'ColourCRM'
      'ColourDelivery'
      'ColourEbay'
      'ColourEmployee'
      'ColourFixedAssets'
      'ColourGeneral'
      'ColourGoogle'
      'ColourHire'
      'ColourInventory'
      'ColourMainBackground'
      'ColourManufacturing'
      'ColourMiscellaneous'
      'ColourPayments'
      'ColourPayroll'
      'ColourPOS'
      'ColourPurchases'
      'ColourRepairs'
      'ColourReturns'
      'ColourSales'
      'ColourSalesOrder'
      'ColourSeedToSale'
      'ColourTraining'
      'ColourUtilities'
      'GradIntensityAccounts'
      'GradIntensityAppointments'
      'GradIntensitybanking'
      'GradIntensityCRM'
      'GradIntensityDelivery'
      'GradIntensityEbay'
      'GradIntensityEmployee'
      'GradIntensityFixedAssets'
      'GradIntensityGeneral'
      'GradIntensityGoogle'
      'GradIntensityHire'
      'GradIntensityInventory'
      'GradIntensityMainBackground'
      'GradIntensityManufacturing'
      'GradIntensityMiscellaneous'
      'GradIntensityPayments'
      'GradIntensityPayroll'
      'GradIntensityPOS'
      'GradIntensityPurchases'
      'GradIntensityRepairs'
      'GradIntensityReturns'
      'GradIntensitySales'
      'GradIntensitySalesOrder'
      'GradIntensitySeedToSale'
      'GradIntensityTraining'
      'GradIntensityUtilities')
    Left = 632
    Top = 48
  end
  object qryPersonalPreferences: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblpersonalpreferences'
      'WHERE EmployeeID = :EmployeeID;')
    Left = 648
    Top = 104
    ParamData = <
      item
        DataType = ftString
        Name = 'EmployeeID'
        Value = ''
      end>
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 614
    Top = 104
  end
  object qryImageSchemesLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select name from tblimageschemes where active ="T" and ifnull(La' +
        'rgeIconsDLLName,'#39#39')<> '#39#39' and ifnull(SmallIconsDLLName,'#39#39')<> '#39#39' a' +
        'nd ifnull(name ,'#39#39')<> '#39#39' order by name')
    Left = 572
    Top = 105
  end
end
