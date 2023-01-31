inherited fmBOMSetup: TfmBOMSetup
  HelpContext = 1371002
  Caption = 'Setup BOM'
  ClientHeight = 761
  ClientWidth = 1084
  OnResize = FormResize
  ExplicitWidth = 1100
  ExplicitHeight = 800
  DesignSize = (
    1084
    761)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 704
    Width = 1084
    HelpContext = 1371030
    ExplicitTop = 481
    ExplicitWidth = 1084
  end
  inherited shapehint: TShape
    Left = 11
    ExplicitLeft = 11
  end
  inherited shapehintextra1: TShape
    Left = 63
    ExplicitLeft = 63
  end
  inherited pnkheader: TDNMPanel
    Width = 1084
    HelpContext = 1371031
    ExplicitTop = 3
    ExplicitWidth = 1084
    DesignSize = (
      1084
      58)
    inherited pnlTitle: TDNMPanel
      Left = 415
      ExplicitLeft = 415
      HelpContext = 1371130
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          HelpContext = 1371032
          Caption = 'Setup  BOM'
        end
      end
    end
  end
  inherited pnlFooter: TDNMPanel
    Top = 704
    Width = 1084
    HelpContext = 1371033
    ExplicitTop = 703
    ExplicitWidth = 1084
    DesignSize = (
      1084
      57)
    inherited btnCancel: TDNMSpeedButton
      Left = 482
      ExplicitLeft = 482
    end
  end
  inherited MainPage: TPageControl
    Width = 1084
    Height = 646
    HelpContext = 1371034
    OnResize = MainPageResize
    ExplicitTop = 57
    ExplicitWidth = 1084
    ExplicitHeight = 646
    inherited TabSheet1: TTabSheet
      HelpContext = 1371035
      Caption = 'Setup BOM'
      ExplicitWidth = 1076
      ExplicitHeight = 616
      inherited sbMain: TScrollBox
        Width = 1076
        Height = 447
        HelpContext = 1371036
        VertScrollBar.Position = 237
        ExplicitWidth = 1076
        ExplicitHeight = 447
        object pnlResources: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = -151
          Width = 1053
          Height = 77
          HelpContext = 1371012
          Align = alTop
          BevelKind = bkFlat
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            1049
            73)
          object lblResources: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 861
            Height = 37
            HelpContext = 1371013
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitLeft = 39
            ExplicitTop = 37
            ExplicitWidth = 544
            ExplicitHeight = 36
          end
          object Label5: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1043
            Height = 24
            HelpContext = 1371014
            Align = alTop
            Caption = '2)  Setup Resources'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 205
          end
          object pnlResourcesaction: TDNMPanel
            Left = 873
            Top = 2
            Width = 160
            Height = 31
            HelpContext = 1371015
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            object Shader3: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371016
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 12058551
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              ExplicitTop = 2
              object lblResourceList: TLabel
                Left = 0
                Top = 0
                Width = 72
                Height = 27
                HelpContext = 1371011
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblResourceListClick
                ExplicitTop = -2
                ExplicitWidth = 156
              end
              object btnResourceList: TDNMSpeedButton
                Left = 72
                Top = 0
                Width = 84
                Height = 27
                ParentCustomHint = False
                Action = dtmManufacturingAddin.actResourceList
                Align = alRight
                Caption = 'Resource List'
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
                Layout = blNone
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                Transparent = True
                HelpContext = 1371116
              end
            end
          end
          object pnlResourceWF: TDNMPanel
            Left = 873
            Top = 39
            Width = 160
            Height = 31
            HelpContext = 1371018
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 1
            object Shader4: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371019
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 13303807
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object lblResourceWF: TLabel
                Left = 0
                Top = 0
                Width = 156
                Height = 27
                HelpContext = 1371020
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblResourceWFClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
        end
        object pnlRoster: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = -68
          Width = 1053
          Height = 100
          HelpContext = 1371021
          Align = alTop
          BevelKind = bkFlat
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          DesignSize = (
            1049
            96)
          object lblRoster: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 861
            Height = 60
            HelpContext = 1371022
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitLeft = 39
            ExplicitTop = 37
            ExplicitWidth = 544
            ExplicitHeight = 36
          end
          object Label8: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1043
            Height = 24
            HelpContext = 1371023
            Align = alTop
            Caption = '3)  Employee Allocation'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 235
          end
          object pnlRosterAction: TDNMPanel
            Left = 873
            Top = 2
            Width = 160
            Height = 31
            HelpContext = 1371024
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            object Shader5: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371025
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 12058551
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object lblEmpResProcRoster: TLabel
                Left = 0
                Top = 0
                Width = 80
                Height = 27
                HelpContext = 1371117
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblEmpResProcRosterClick
                ExplicitTop = -2
                ExplicitWidth = 156
              end
              object btnEmpResProcRoster: TDNMSpeedButton
                Left = 80
                Top = 0
                Width = 76
                Height = 27
                ParentCustomHint = False
                Action = dtmManufacturingAddin.actEmpResProcRoster
                Align = alRight
                Caption = 'Employee Allocation'
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
                Layout = blNone
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                Transparent = True
                HelpContext = 1371118
              end
            end
          end
          object pnlRosterWF: TDNMPanel
            Left = 873
            Top = 39
            Width = 160
            Height = 31
            HelpContext = 1371027
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 1
            object Shader6: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371028
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 13303807
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label10: TLabel
                Left = 0
                Top = 0
                Width = 156
                Height = 27
                HelpContext = 1371029
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = Label10Click
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
        end
        object pnlManufactureProduct: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 38
          Width = 1053
          Height = 77
          HelpContext = 1371039
          Align = alTop
          BevelKind = bkFlat
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          DesignSize = (
            1049
            73)
          object lblManufactureProduct: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 861
            Height = 37
            HelpContext = 1371040
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitLeft = 39
            ExplicitTop = 37
            ExplicitWidth = 544
            ExplicitHeight = 36
          end
          object Label11: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1043
            Height = 24
            HelpContext = 1371041
            Align = alTop
            Caption = '4)  Setup BOM Product'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 230
          end
          object pnlManufactureProductAction: TDNMPanel
            Left = 873
            Top = 2
            Width = 160
            Height = 31
            HelpContext = 1371042
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            object Shader7: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371043
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 12058551
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              ExplicitTop = 2
              object lblManufactureProductList: TLabel
                Left = 0
                Top = 0
                Width = 72
                Height = 27
                HelpContext = 1371119
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblManufactureProductListClick
                ExplicitTop = -2
                ExplicitWidth = 156
              end
              object btnManufactureProductList: TDNMSpeedButton
                Left = 72
                Top = 0
                Width = 84
                Height = 27
                ParentCustomHint = False
                Action = dtmManufacturingAddin.actBOMProductList
                Align = alRight
                Caption = 'BOM Product List'
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
                Layout = blNone
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                Transparent = True
                HelpContext = 1371120
              end
            end
          end
          object pnlManufactureProductWF: TDNMPanel
            Left = 873
            Top = 39
            Width = 160
            Height = 31
            HelpContext = 1371045
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 1
            object Shader8: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371046
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 13303807
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label13: TLabel
                Left = 0
                Top = 0
                Width = 156
                Height = 27
                HelpContext = 1371047
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                ExplicitTop = -1
              end
            end
          end
        end
        object pnlEmpnResRoster: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 370
          Width = 1053
          Height = 77
          HelpContext = 1371048
          Align = alTop
          BevelKind = bkFlat
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          DesignSize = (
            1049
            73)
          object lblEmpnResRoster: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 861
            Height = 37
            HelpContext = 1371049
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitTop = 37
            ExplicitWidth = 751
          end
          object Label15: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1043
            Height = 24
            HelpContext = 1371050
            Align = alTop
            Caption = '8) Production Scheduling'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 255
          end
          object pnlEmpnResRosterAction: TDNMPanel
            Left = 873
            Top = 2
            Width = 160
            Height = 31
            HelpContext = 1371051
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            object Shader9: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371052
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 12058551
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object lblEmpResProcRosternSchedule: TLabel
                Left = 0
                Top = 0
                Width = 80
                Height = 27
                HelpContext = 1371121
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblEmpResProcRosternScheduleClick
                ExplicitLeft = -6
                ExplicitTop = 2
              end
              object btnEmpResProcRosternSchedule: TDNMSpeedButton
                Left = 80
                Top = 0
                Width = 76
                Height = 27
                ParentCustomHint = False
                Action = dtmManufacturingAddin.actEmpResProcRosternSchedule
                Align = alRight
                Caption = 'Production Scheduling'
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
                Layout = blNone
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                Transparent = True
                HelpContext = 1371122
              end
            end
          end
          object pnlEmpnResRosterWF: TDNMPanel
            Left = 873
            Top = 39
            Width = 160
            Height = 31
            HelpContext = 1371054
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 1
            object Shader10: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371055
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 13303807
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label17: TLabel
                Left = 0
                Top = 0
                Width = 156
                Height = 27
                HelpContext = 1371056
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = Label17Click
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
        end
        object pnlSetupDurations: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = -234
          Width = 1053
          Height = 77
          HelpContext = 1371003
          Align = alTop
          BevelKind = bkFlat
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          DesignSize = (
            1049
            73)
          object lblProcessSteps: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 861
            Height = 37
            HelpContext = 1371004
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitLeft = 35
            ExplicitTop = 32
            ExplicitWidth = 694
          end
          object Label3: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1043
            Height = 24
            HelpContext = 1371005
            Align = alTop
            Caption = '1)  Setup the Process Steps'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 281
          end
          object btnDurations: TDNMPanel
            Left = 873
            Top = 2
            Width = 160
            Height = 31
            HelpContext = 1371006
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            object Shader1: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371007
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 12058551
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object lblprocessstepList: TLabel
                Left = 0
                Top = 0
                Width = 81
                Height = 27
                HelpContext = 1371123
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblprocessstepListClick
              end
              object btnprocessstepList: TDNMSpeedButton
                Left = 81
                Top = 0
                Width = 75
                Height = 27
                ParentCustomHint = False
                Action = dtmManufacturingAddin.actprocessstepList
                Align = alRight
                Caption = 'Process Step List'
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
                Layout = blNone
                ParentFont = False
                ParentShowHint = False
                ShowFocus = False
                ShowHint = False
                TabOrder = 0
                Transparent = True
                ExplicitLeft = 0
                ExplicitWidth = 156
                HelpContext = 1371124
              end
            end
          end
          object btnDurationworkflow: TDNMPanel
            Left = 873
            Top = 39
            Width = 160
            Height = 31
            HelpContext = 1371009
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 1
            object Shader2: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371010
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 13303807
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object lblDurationworkflow: TLabel
                Left = 0
                Top = 0
                Width = 156
                Height = 27
                HelpContext = 1371125
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblDurationworkflowClick
                ExplicitTop = -2
              end
            end
          end
        end
        object pnlSalesOrderExpress: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 204
          Width = 1053
          Height = 77
          HelpContext = 1371058
          Align = alTop
          BevelKind = bkFlat
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          DesignSize = (
            1049
            73)
          object lblSalesOrderExpress: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 861
            Height = 37
            HelpContext = 1371059
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitTop = 37
            ExplicitWidth = 751
          end
          object Label19: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1043
            Height = 24
            HelpContext = 1371060
            Align = alTop
            Caption = '6)  Make Sales Order / Work Order'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 343
          end
          object pnlSalesOrderExpressAction: TDNMPanel
            Left = 873
            Top = 2
            Width = 160
            Height = 31
            HelpContext = 1371061
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            object Shader11: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371062
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 12058551
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object lblSalesOrderExpressList: TLabel
                Left = 0
                Top = 0
                Width = 72
                Height = 27
                HelpContext = 1371126
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblSalesOrderExpressListClick
                ExplicitTop = -2
                ExplicitWidth = 156
              end
              object btnSalesOrderExpressList: TDNMSpeedButton
                Left = 72
                Top = 0
                Width = 84
                Height = 27
                ParentCustomHint = False
                Action = dtmMainGUI.actSOList
                Align = alRight
                Caption = 'Sales Order List'
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
                Layout = blNone
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                Transparent = True
                HelpContext = 1371127
              end
            end
          end
          object pnlSalesOrderExpressWF: TDNMPanel
            Left = 873
            Top = 39
            Width = 160
            Height = 31
            HelpContext = 1371064
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 1
            object Shader12: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371065
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 13303807
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label21: TLabel
                Left = 0
                Top = 0
                Width = 156
                Height = 27
                HelpContext = 1371066
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = Label21Click
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
        end
        object pnlCapacityPlan: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 287
          Width = 1053
          Height = 77
          HelpContext = 1371067
          Align = alTop
          BevelKind = bkFlat
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          DesignSize = (
            1049
            73)
          object lblCapacityPlan: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 861
            Height = 37
            HelpContext = 1371068
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitTop = 37
            ExplicitWidth = 751
          end
          object Label23: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1043
            Height = 24
            HelpContext = 1371069
            Align = alTop
            Caption = '7) Capacity Planning'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 206
          end
          object pnlCapacityPlanAction: TDNMPanel
            Left = 873
            Top = 2
            Width = 160
            Height = 31
            HelpContext = 1371070
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            object Shader13: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371071
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 12058551
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              ExplicitTop = 2
              object lblCapacityPlanning: TLabel
                Left = 0
                Top = 0
                Width = 72
                Height = 27
                HelpContext = 1371128
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblCapacityPlanningClick
                ExplicitTop = -2
                ExplicitWidth = 156
              end
              object btnCapacityPlanning: TDNMSpeedButton
                Left = 72
                Top = 0
                Width = 84
                Height = 27
                ParentCustomHint = False
                Action = dtmManufacturingAddin.actCapacityPlanning
                Align = alRight
                Caption = 'Capacity Planning'
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
                Layout = blNone
                ParentFont = False
                ParentShowHint = False
                ShowHint = False
                TabOrder = 0
                Transparent = True
                HelpContext = 1371129
              end
            end
          end
          object pnlCapacityPlanWF: TDNMPanel
            Left = 873
            Top = 39
            Width = 160
            Height = 31
            HelpContext = 1371073
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 1
            object Shader14: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371074
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 13303807
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label25: TLabel
                Left = 0
                Top = 0
                Width = 156
                Height = 27
                HelpContext = 1371075
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = Label25Click
                ExplicitTop = -2
              end
            end
          end
        end
        object pnlPreference: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 121
          Width = 1053
          Height = 77
          HelpContext = 1371076
          Align = alTop
          BevelKind = bkFlat
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          DesignSize = (
            1049
            73)
          object lblPreference: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 861
            Height = 37
            HelpContext = 1371077
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitTop = 37
            ExplicitWidth = 751
          end
          object Label4: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 1043
            Height = 24
            HelpContext = 1371078
            Align = alTop
            Caption = '5)  Preferences'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 153
          end
          object pnlPreferenceAction: TDNMPanel
            Left = 873
            Top = 2
            Width = 160
            Height = 31
            HelpContext = 1371079
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            object Shader15: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371080
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 12058551
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object lblPreferences: TLabel
                Left = 0
                Top = 0
                Width = 156
                Height = 27
                HelpContext = 1371081
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Preferences'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblPreferencesClick
                ExplicitTop = 2
              end
            end
          end
          object pnlPreferenceWF: TDNMPanel
            Left = 873
            Top = 39
            Width = 160
            Height = 31
            HelpContext = 1371082
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 1
            object Shader16: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 156
              Height = 27
              HelpContext = 1371083
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 13303807
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label9: TLabel
                Left = 0
                Top = 0
                Width = 156
                Height = 27
                HelpContext = 1371084
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Workflow'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = Label9Click
                ExplicitTop = -2
              end
            end
          end
        end
      end
      inherited mem_Note: TMemo
        Width = 1076
        HelpContext = 1371085
        ExplicitWidth = 1076
      end
    end
    object TabSheet2: TTabSheet
      HelpContext = 1371086
      Caption = 'Manufacturing Levels'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object HTMLabel1: THTMLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1070
        Height = 111
        HelpContext = 1371087
        Align = alTop
        HTMLText.Strings = (
          
            '<FONT  size="10"  face="Arial"  >The below assumes that you have' +
            ' already setup a related part or a BOM (Bill of Materials), also' +
            ' known as "Kits". <br>All stages allow the automatic creation of' +
            ' Smart Orders, Purchase Orders and Workshop Travellers or Job Ca' +
            'rds. They all check product levels and product requirements movi' +
            'ng forward.</FONT><br><br><FONT  size="12" face="Calibri" color=' +
            '"#008000" >We would suggest that you start at level 2 or 3 first' +
            ', before attempting the advanced options. Best idea is to open o' +
            'ne of the sample companies and try each of these steps, so you g' +
            'et a good understanding of each levels capabilities.</FONT>')
        Version = '1.8.1.0'
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 941
      end
      object PageLevels: TPageControl
        Left = 107
        Top = 153
        Width = 969
        Height = 463
        HelpContext = 1371088
        ActivePage = TabLevel1
        Align = alClient
        Style = tsButtons
        TabOrder = 0
        OnChanging = PageLevelsChanging
        OnResize = PageLevelsResize
        ExplicitLeft = 131
        ExplicitWidth = 945
        object TabLevel1: TTabSheet
          HelpContext = 1371089
          Caption = 'Level 1'
          object sbLvl1: TScrollBox
            Left = 0
            Top = 0
            Width = 961
            Height = 430
            HelpContext = 1371090
            HorzScrollBar.Visible = False
            Align = alClient
            TabOrder = 0
            DesignSize = (
              957
              426)
            object htmlLvl1: THTMLabel
              Left = 3
              Top = 3
              Width = 943
              Height = 259
              HelpContext = 1371091
              Anchors = [akLeft, akTop, akRight]
              BorderWidth = 1
              Version = '1.8.1.0'
              ExplicitWidth = 1062
            end
          end
        end
        object TabLevel2: TTabSheet
          HelpContext = 1371092
          Caption = 'Level 2'
          ImageIndex = 1
          object sbLvl2: TScrollBox
            Left = 0
            Top = 0
            Width = 961
            Height = 430
            HelpContext = 1371093
            HorzScrollBar.Visible = False
            Align = alClient
            TabOrder = 0
            DesignSize = (
              957
              426)
            object htmlLvl2: THTMLabel
              Left = 3
              Top = 3
              Width = 899
              Height = 259
              HelpContext = 1371094
              Anchors = [akLeft, akTop, akRight]
              BorderWidth = 1
              Version = '1.8.1.0'
              ExplicitWidth = 1062
            end
          end
        end
        object TabLevel3: TTabSheet
          HelpContext = 1371095
          Caption = 'Level 3'
          ImageIndex = 2
          object sbLvl3: TScrollBox
            Left = 0
            Top = 0
            Width = 961
            Height = 430
            HelpContext = 1371096
            HorzScrollBar.Visible = False
            Align = alClient
            TabOrder = 0
            DesignSize = (
              957
              426)
            object htmlLvl3: THTMLabel
              Left = 3
              Top = 3
              Width = 899
              Height = 259
              HelpContext = 1371097
              Anchors = [akLeft, akTop, akRight]
              BorderWidth = 1
              Version = '1.8.1.0'
              ExplicitWidth = 1062
            end
          end
        end
        object Tablevel4: TTabSheet
          HelpContext = 1371098
          Caption = 'Level 4'
          ImageIndex = 3
          object sbLvl4: TScrollBox
            Left = 0
            Top = 0
            Width = 961
            Height = 430
            HelpContext = 1371099
            HorzScrollBar.Visible = False
            Align = alClient
            TabOrder = 0
            DesignSize = (
              957
              426)
            object htmlLvl4: THTMLabel
              Left = 3
              Top = 3
              Width = 899
              Height = 259
              HelpContext = 1371100
              Anchors = [akLeft, akTop, akRight]
              BorderWidth = 1
              Version = '1.8.1.0'
              ExplicitWidth = 1062
            end
          end
        end
        object TabLevel5: TTabSheet
          HelpContext = 1371101
          Caption = 'Level 5'
          ImageIndex = 4
          object sbLvl5: TScrollBox
            Left = 0
            Top = 0
            Width = 961
            Height = 430
            HelpContext = 1371102
            HorzScrollBar.Visible = False
            Align = alClient
            TabOrder = 0
            DesignSize = (
              957
              426)
            object htmlLvl5: THTMLabel
              Left = 3
              Top = 3
              Width = 899
              Height = 259
              HelpContext = 1371103
              Anchors = [akLeft, akTop, akRight]
              BorderWidth = 1
              Version = '1.8.1.0'
              ExplicitWidth = 1062
            end
          end
        end
        object TabLevel6: TTabSheet
          HelpContext = 1371104
          Caption = 'Level 6'
          ImageIndex = 5
          object sbLvl6: TScrollBox
            Left = 0
            Top = 0
            Width = 961
            Height = 430
            HelpContext = 1371105
            HorzScrollBar.Visible = False
            Align = alClient
            TabOrder = 0
            DesignSize = (
              957
              426)
            object htmlLvl6: THTMLabel
              Left = 3
              Top = 3
              Width = 899
              Height = 259
              HelpContext = 1371106
              Anchors = [akLeft, akTop, akRight]
              BorderWidth = 1
              Version = '1.8.1.0'
              ExplicitWidth = 1062
            end
          end
        end
      end
      object DNMPanel1: TDNMPanel
        AlignWithMargins = True
        Left = 3
        Top = 156
        Width = 101
        Height = 457
        HelpContext = 1371107
        Align = alLeft
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object btnLevel1: TDNMSpeedButton
          Tag = 1
          AlignWithMargins = True
          Left = 3
          Top = 5
          Width = 95
          Height = 29
          HelpContext = 1371108
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Level1'
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
          TabOrder = 0
          OnClick = LevelOptionclick
        end
        object btnLevel2: TDNMSpeedButton
          Tag = 2
          AlignWithMargins = True
          Left = 3
          Top = 44
          Width = 95
          Height = 29
          HelpContext = 1371109
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Level2'
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
          TabOrder = 1
          OnClick = LevelOptionclick
        end
        object btnLevel3: TDNMSpeedButton
          Tag = 3
          AlignWithMargins = True
          Left = 3
          Top = 83
          Width = 95
          Height = 29
          HelpContext = 1371110
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Level3'
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
          TabOrder = 2
          OnClick = LevelOptionclick
        end
        object btnLevel4: TDNMSpeedButton
          Tag = 4
          AlignWithMargins = True
          Left = 3
          Top = 122
          Width = 95
          Height = 29
          HelpContext = 1371111
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Level4'
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
          TabOrder = 3
          OnClick = LevelOptionclick
        end
        object btnLevel5: TDNMSpeedButton
          Tag = 5
          AlignWithMargins = True
          Left = 3
          Top = 161
          Width = 95
          Height = 29
          HelpContext = 1371112
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Level5'
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
          TabOrder = 4
          OnClick = LevelOptionclick
        end
        object btnLevel6: TDNMSpeedButton
          Tag = 6
          AlignWithMargins = True
          Left = 3
          Top = 200
          Width = 95
          Height = 29
          HelpContext = 1371113
          Margins.Top = 5
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Level6'
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
          TabOrder = 5
          OnClick = LevelOptionclick
        end
      end
      object shActiveForm: TShader
        AlignWithMargins = True
        Left = 108
        Top = 120
        Width = 965
        Height = 30
        HelpContext = 1371114
        Margins.Left = 108
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object pnlActiveForm: TLabel
          Left = 0
          Top = 0
          Width = 965
          Height = 30
          HelpContext = 1371115
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Level1'
          Font.Charset = ANSI_CHARSET
          Font.Color = clMaroon
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = -3
          ExplicitWidth = 1076
        end
      end
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004801080210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
end
