inherited fmSetupHire: TfmSetupHire
  HelpContext = 1338002
  Caption = 'Hire Setup'
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    HelpContext = 1338003
    ExplicitTop = 522
    ExplicitWidth = 747
  end
  inherited shapehint: TShape
    Left = 15
    ExplicitLeft = 12
  end
  inherited shapehintextra1: TShape
    Left = 62
    ExplicitLeft = 56
  end
  inherited pnkheader: TDNMPanel
    HelpContext = 1338057
    ExplicitWidth = 851
    inherited pnlTitle: TDNMPanel
      Left = 298
      HelpContext = 1338060
      ExplicitLeft = 298
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          HelpContext = 1338058
          Caption = 'Hire Setup'
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
        VertScrollBar.Position = 164
        ExplicitTop = 227
        ExplicitWidth = 851
        ExplicitHeight = 450
        object pnlSetupDurations: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = -161
          Width = 918
          Height = 77
          HelpContext = 1338021
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
          object lblSetupDurations: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 726
            Height = 37
            HelpContext = 1338022
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
            HelpContext = 1338023
            Align = alTop
            Caption = '1)  Setup the Durations / Times'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 311
          end
          object btnDurations: TDNMPanel
            Left = 735
            Top = 2
            Width = 132
            Height = 31
            HelpContext = 1338024
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
            OnClick = btnDurationsClick
            object Shader1: TShader
              Tag = 1
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1338025
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnClick = btnDurationsClick
              FromColor = 12058551
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label1: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1338026
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Durations'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = btnDurationsClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
          object btnDurationworkflow: TDNMPanel
            Left = 735
            Top = 39
            Width = 132
            Height = 31
            HelpContext = 1338027
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
            OnClick = btnDurationworkflowClick
            object Shader2: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1338028
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnClick = btnDurationworkflowClick
              FromColor = 13303807
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label2: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1338029
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
                OnClick = btnDurationworkflowClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
        end
        object pnlMakeAssetProduct: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = -78
          Width = 918
          Height = 77
          HelpContext = 1338030
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
          object lblMakeAssetProduct: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 726
            Height = 37
            HelpContext = 1338031
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Caption = 'Create Products that will be Purchased and Converted to Hire.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            Layout = tlCenter
            WordWrap = True
            ExplicitTop = 35
            ExplicitWidth = 635
          end
          object label6: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 908
            Height = 24
            HelpContext = 1338032
            Align = alTop
            Caption = '2)  Make Product'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 170
          end
          object btnAssetProductList: TDNMPanel
            Left = 735
            Top = 2
            Width = 132
            Height = 31
            HelpContext = 1338033
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
            OnClick = btnAssetProductListClick
            object Shader3: TShader
              Tag = 1
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1338034
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnClick = btnAssetProductListClick
              FromColor = 8454016
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label5: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1338035
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Product List'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = btnAssetProductListClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
          object btnProductWorkflows: TDNMPanel
            Left = 735
            Top = 39
            Width = 132
            Height = 31
            HelpContext = 1338036
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
            OnClick = btnProductWorkflowsClick
            object Shader4: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1338037
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnClick = btnProductWorkflowsClick
              FromColor = 8454143
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label9: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1338038
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
                OnClick = btnProductWorkflowsClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
        end
        object pnlPurchaseOrder: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 5
          Width = 918
          Height = 77
          HelpContext = 1338048
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
          object lblPurchaseOrder: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 726
            Height = 37
            HelpContext = 1338049
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Caption = 
              'Create a Purchase Order to buy the Stock In. Inventory and Non-I' +
              'nventory Products can be used for Conversion to Hire.'
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
          object Label14: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 908
            Height = 24
            HelpContext = 1338050
            Align = alTop
            Caption = '3)  Purchase Stock'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 191
          end
          object btnPurchaseOrder: TDNMPanel
            Left = 735
            Top = 2
            Width = 132
            Height = 31
            HelpContext = 1338051
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
            OnClick = btnPurchaseOrderClick
            object Shader9: TShader
              Tag = 1
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1338052
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnClick = btnPurchaseOrderClick
              FromColor = 8454016
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label15: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1338053
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Purchase Order'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = btnPurchaseOrderClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
          object btnPurchaseOrderWF: TDNMPanel
            Left = 735
            Top = 39
            Width = 132
            Height = 31
            HelpContext = 1338054
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
            object Shader10: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1338055
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              FromColor = 8454143
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label16: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1338056
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
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
        end
        object pnlConvertProduct: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 88
          Width = 918
          Height = 77
          HelpContext = 1338039
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
          object lblConvertProduct: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 726
            Height = 37
            HelpContext = 1338040
            Margins.Left = 38
            Margins.Right = 150
            Align = alClient
            AutoSize = False
            Caption = 'Select Products and Convert them for Hire.'
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
          object Label10: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 908
            Height = 24
            HelpContext = 1338041
            Align = alTop
            Caption = '4)  Convert To Hire'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 187
          end
          object btnStockToAssettList: TDNMPanel
            Left = 735
            Top = 2
            Width = 132
            Height = 31
            HelpContext = 1338042
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
            OnClick = btnStockToAssettListClick
            object Shader5: TShader
              Tag = 1
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1338043
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnClick = btnStockToAssettListClick
              FromColor = 8454016
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label7: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1338044
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Conversion List'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = btnStockToAssettListClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
          object btnConvertProductHireWorkflow: TDNMPanel
            Left = 735
            Top = 39
            Width = 132
            Height = 31
            HelpContext = 1338045
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
            OnClick = btnConvertProductHireWorkflowClick
            object Shader6: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1338046
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnClick = btnConvertProductHireWorkflowClick
              FromColor = 8454143
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
                HelpContext = 1338047
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
                OnClick = btnConvertProductHireWorkflowClick
                ExplicitTop = -1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
        end
        object pnlHire: TDNMPanel
          AlignWithMargins = True
          Left = 3
          Top = 171
          Width = 918
          Height = 77
          HelpContext = 1338012
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
          ExplicitWidth = 926
          DesignSize = (
            914
            73)
          object lblHire: TLabel
            AlignWithMargins = True
            Left = 38
            Top = 33
            Width = 726
            Height = 37
            HelpContext = 1338013
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
            WordWrap = True
            ExplicitLeft = 39
            ExplicitTop = 37
            ExplicitWidth = 544
            ExplicitHeight = 36
          end
          object Label4: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 908
            Height = 24
            HelpContext = 1338014
            Align = alTop
            Caption = '5)  Make Hire Transaction'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            ExplicitWidth = 254
          end
          object btnHireList: TDNMPanel
            Left = 735
            Top = 2
            Width = 132
            Height = 31
            HelpContext = 1338015
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
            OnClick = btnHireListClick
            object Shader7: TShader
              Tag = 1
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1338016
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnClick = btnHireListClick
              FromColor = 8454016
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454016
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label8: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1338017
                Align = alClient
                Alignment = taCenter
                AutoSize = False
                Caption = 'Hire List'
                Font.Charset = ANSI_CHARSET
                Font.Color = clBlack
                Font.Height = -16
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = True
                Layout = tlCenter
                OnClick = btnHireListClick
                ExplicitLeft = -3
                ExplicitTop = 1
                ExplicitWidth = 130
                ExplicitHeight = 29
              end
            end
          end
          object btnHireWorkflow: TDNMPanel
            Left = 735
            Top = 39
            Width = 132
            Height = 31
            HelpContext = 1338018
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
            OnClick = btnHireWorkflowClick
            object Shader8: TShader
              Tag = 2
              Left = 0
              Top = 0
              Width = 128
              Height = 27
              HelpContext = 1338019
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnClick = btnHireWorkflowClick
              FromColor = 8454143
              ToColor = clWhite
              FromColorMirror = clWhite
              ToColorMirror = 8454143
              Steps = 10
              Direction = False
              Version = '1.4.0.0'
              object Label12: TLabel
                Left = 0
                Top = 0
                Width = 128
                Height = 27
                HelpContext = 1338020
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
                OnClick = btnHireWorkflowClick
                ExplicitLeft = 3
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
    HelpContext = 1338059
    ExplicitTop = 508
    ExplicitWidth = 851
    inherited btnCancel: TDNMSpeedButton
      Left = 366
      ExplicitLeft = 366
    end
  end
  inherited tmrProcessMessage: TTimer
    Top = 79
  end
  inherited tmrdelay: TTimer
    Top = 79
  end
  inherited popSpelling: TPopupMenu
    Top = 79
  end
  inherited tmrdelayMsg: TTimer
    Top = 79
  end
  inherited dlgReportSelect: TSelectionDialog
    Top = 79
  end
  inherited ApplicationEvents1: TApplicationEvents
    Top = 79
  end
  inherited MyConnection: TERPConnection
    Top = 79
  end
  inherited DataState: TDataState
    Top = 79
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Top = 79
  end
  inherited imgsort: TImageList
    Top = 79
    Bitmap = {
      494C010102009801BC0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Top = 79
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Top = 79
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 79
  end
  inherited qryMemTrans: TERPQuery
    Top = 79
  end
end
