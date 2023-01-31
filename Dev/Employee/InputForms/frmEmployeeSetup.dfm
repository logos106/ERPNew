inherited fmEmployeeSetup: TfmEmployeeSetup
  HelpContext = 1425002
  Caption = 'Setup Employee'
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    ExplicitTop = 365
    ExplicitWidth = 851
  end
  inherited shapehint: TShape
    Left = 16
    ExplicitLeft = 16
  end
  inherited shapehintextra1: TShape
    Left = 76
    ExplicitLeft = 76
  end
  inherited pnkheader: TDNMPanel
    ExplicitWidth = 851
    HelpContext = 1425042
    inherited pnlTitle: TDNMPanel
      Left = 263
      Width = 326
      HelpContext = 1425039
      ExplicitLeft = 263
      ExplicitWidth = 326
      inherited TitleShader: TShader
        Width = 324
        HelpContext = 1425040
        ExplicitWidth = 324
        inherited TitleLabel: TLabel
          Width = 324
          HelpContext = 1425041
          Caption = 'Setup Employee'
          ExplicitWidth = 324
        end
      end
    end
  end
  inherited MainPage: TPageControl [6]
    inherited TabSheet1: TTabSheet
      inherited mem_Note: TMemo [0]
      end
      inherited sbMain: TScrollBox [1]
        HelpContext = 1338010
        VertScrollBar.Position = 70
        ExplicitLeft = 3
        ExplicitTop = 308
        ExplicitWidth = 1920
        ExplicitHeight = 690
        object pnlPreferences: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = -67
          Width = 918
          Height = 77
          HelpContext = 1425003
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
          ExplicitWidth = 926
          DesignSize = (
            914
            73)
          object lblPreferencesNotes: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 726
            Height = 37
            HelpContext = 1425004
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
          object Label3: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 908
            Height = 24
            HelpContext = 1425005
            Align = alTop
            Caption = '1)  Payroll Access'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 179
          end
          object pnlPreferenceswf: TDNMPanel
            Left = 684
            Top = 39
            Width = 132
            Height = 31
            HelpContext = 1425006
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
            object Shader2: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1425007
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
              object lblPreferenceWorkflow: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1425008
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
                OnClick = lblPreferenceWorkflowClick
                ExplicitTop = -2
              end
            end
          end
          object pnlPreferencesaction: TDNMPanel
            Left = 684
            Top = 2
            Width = 132
            Height = 31
            HelpContext = 1425009
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Caption = 'Invoice'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 1
            object Shader5: TShader
              Tag = 1
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1425010
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
                Width = 128
                Height = 27
                HelpContext = 1425011
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
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
        end
        object pnlPayrollInfo: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 182
          Width = 918
          Height = 77
          HelpContext = 1425012
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
          ExplicitWidth = 926
          DesignSize = (
            914
            73)
          object lblpnlPayrollInfoNote: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 726
            Height = 37
            HelpContext = 1425013
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
          object Label17: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 908
            Height = 24
            HelpContext = 1425014
            Align = alTop
            Caption = '4)  Fill In Payroll Info'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 201
          end
          object pnlPayrollInfoAction: TDNMPanel
            Left = 684
            Top = 2
            Width = 132
            Height = 31
            HelpContext = 1425015
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Caption = 'Invoice'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            Visible = False
            object Shader9: TShader
              Tag = 1
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1425016
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
              object Label18: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1425017
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Employee'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = Label18Click
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
          object pnlpnlPayrollInfoWF: TDNMPanel
            Left = 684
            Top = 39
            Width = 132
            Height = 31
            HelpContext = 1425018
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
              Width = 128
              Height = 27
              HelpContext = 1425019
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
              object Label19: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1425020
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
                OnClick = Label19Click
                ExplicitTop = 4
              end
            end
          end
        end
        object pnlPayrollSetup: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 99
          Width = 918
          Height = 77
          HelpContext = 1425021
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
          ExplicitWidth = 926
          DesignSize = (
            914
            73)
          object lblPreferencesNote: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 726
            Height = 37
            HelpContext = 1425022
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
            ExplicitLeft = 14
            ExplicitTop = 25
            ExplicitWidth = 1722
          end
          object Label5: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 908
            Height = 24
            HelpContext = 1425023
            Align = alTop
            Caption = '3)  Payroll Setup'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 164
          end
          object btnPreferences: TDNMPanel
            Left = 684
            Top = 2
            Width = 132
            Height = 31
            HelpContext = 1425024
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Caption = 'Invoice'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            object Shader1: TShader
              Tag = 1
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1425025
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
              object lblPayrollSetup: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1425026
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Setup Payroll'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblPayrollSetupClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
          object btnPreferencesWF: TDNMPanel
            Left = 684
            Top = 39
            Width = 132
            Height = 31
            HelpContext = 1425027
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
              Width = 128
              Height = 27
              HelpContext = 1425028
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
              object Label11: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1425029
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
                OnClick = Label11Click
                ExplicitTop = -2
              end
            end
          end
        end
        object pnlEmployee: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 16
          Width = 918
          Height = 77
          HelpContext = 1425030
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
          ExplicitWidth = 926
          DesignSize = (
            914
            73)
          object lblEmployeeNote: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 726
            Height = 37
            HelpContext = 1425031
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
          object Label7: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 908
            Height = 24
            HelpContext = 1425032
            Align = alTop
            Caption = '2)  Create New Employee'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 249
          end
          object pnlEmployeeAction: TDNMPanel
            Left = 684
            Top = 2
            Width = 132
            Height = 31
            HelpContext = 1425033
            Anchors = [akTop]
            BevelKind = bkFlat
            BevelOuter = bvNone
            Caption = 'Invoice'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -33
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            Locked = True
            ParentFont = False
            TabOrder = 0
            object Shader3: TShader
              Tag = 1
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1425034
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
              object lblEmployee: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1425035
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Employee'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = lblEmployeeClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
          object pnlEmployeeWF: TDNMPanel
            Left = 684
            Top = 39
            Width = 132
            Height = 31
            HelpContext = 1425036
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
              Width = 128
              Height = 27
              HelpContext = 1425037
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
              object lblEmployeeWorkFlow: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1425038
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
                OnClick = lblEmployeeWorkFlowClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
        end
      end
    end
  end
  inherited pnlFooter: TDNMPanel [7]
    ExplicitTop = 389
    ExplicitWidth = 851
    HelpContext = 1425043
    inherited btnCancel: TDNMSpeedButton
      Left = 366
      ExplicitLeft = 366
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 874
  end
  inherited popSpelling: TPopupMenu
    Left = 96
    Top = 24
  end
  inherited tmrdelayMsg: TTimer
    Left = 836
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 647
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 685
  end
  inherited DataState: TDataState
    Left = 722
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 571
  end
  inherited imgsort: TImageList
    Left = 760
    Bitmap = {
      494C0101020048016C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryCustomField: TERPQuery
    Left = 495
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 798
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 609
  end
  inherited qryMemTrans: TERPQuery
    Left = 533
  end
end
