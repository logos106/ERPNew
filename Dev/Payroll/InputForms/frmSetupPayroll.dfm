inherited fmSetupPayroll: TfmSetupPayroll
  HelpContext = 1312002
  Caption = 'Setup Payroll'
  ClientHeight = 625
  ExplicitWidth = 955
  ExplicitHeight = 654
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 568
    HelpContext = 1312003
    ExplicitTop = 439
    ExplicitWidth = 607
  end
  inherited shapehint: TShape
    ExplicitLeft = 1
  end
  inherited imgGridWatermark: TImage
    Left = 546
    Top = 35
    ExplicitLeft = 546
    ExplicitTop = 35
  end
  inherited shapehintextra1: TShape
    Left = 46
    ExplicitLeft = 28
  end
  inherited sbMain: TScrollBox [5]
    Height = 341
    HelpContext = 1312003
    ExplicitHeight = 334
    object pnlTaxScales: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 943
      Height = 77
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
        939
        73)
      HelpContext = 1312004
      object lblTaxScalesNotes: TLabel
        AlignWithMargins = True
        Left = 38
        Top = 33
        Width = 751
        Height = 37
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
        HelpContext = 1312005
      end
      object Label4: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 933
        Height = 24
        Align = alTop
        Caption = '1)  Setup / Check Tax Scales'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 286
        HelpContext = 1312006
      end
      object pnlTaxScalesWF: TDNMPanel
        Left = 698
        Top = 39
        Width = 132
        Height = 31
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
        Visible = False
        HelpContext = 1312007
        object Shader2: TShader
          Tag = 2
          Left = 0
          Top = 0
          Width = 128
          Height = 27
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          Visible = False
          FromColor = 13303807
          ToColor = clWhite
          FromColorMirror = clWhite
          ToColorMirror = 8454143
          Steps = 10
          Direction = False
          Version = '1.4.0.0'
          HelpContext = 1312008
          object lblWorkFlow: TLabel
            Left = 0
            Top = 0
            Width = 128
            Height = 27
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
            Visible = False
            OnClick = lblWorkFlowClick
            ExplicitTop = -1
            ExplicitWidth = 130
            ExplicitHeight = 29
            HelpContext = 1312009
          end
        end
      end
      object pnlTaxScalesAction: TDNMPanel
        Left = 698
        Top = 2
        Width = 132
        Height = 31
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
        HelpContext = 1312010
        object Shader5: TShader
          Tag = 1
          Left = 0
          Top = 0
          Width = 128
          Height = 27
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
          HelpContext = 1312011
          object lblGoThere: TLabel
            Left = 0
            Top = 0
            Width = 128
            Height = 27
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Tax Scales'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            OnClick = lblGoThereClick
            ExplicitTop = -1
            ExplicitWidth = 130
            ExplicitHeight = 29
            HelpContext = 1312012
          end
        end
      end
    end
    object pnlSetupEmployee: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 252
      Width = 943
      Height = 77
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
        939
        73)
      HelpContext = 1312013
      object lblSetupEmployeeNotes: TLabel
        AlignWithMargins = True
        Left = 38
        Top = 33
        Width = 751
        Height = 37
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
        HelpContext = 1312014
      end
      object Label6: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 933
        Height = 24
        Align = alTop
        Caption = '4)  Setup Employees for Payroll'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 315
        HelpContext = 1312015
      end
      object pnlSetupPayrollWF: TDNMPanel
        Left = 698
        Top = 39
        Width = 132
        Height = 31
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
        Visible = False
        HelpContext = 1312016
        object Shader1: TShader
          Tag = 2
          Left = 0
          Top = 0
          Width = 128
          Height = 27
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          Visible = False
          FromColor = 13303807
          ToColor = clWhite
          FromColorMirror = clWhite
          ToColorMirror = 8454143
          Steps = 10
          Direction = False
          Version = '1.4.0.0'
          HelpContext = 1312017
          object Label7: TLabel
            Left = 0
            Top = 0
            Width = 128
            Height = 27
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
            Visible = False
            ExplicitTop = -1
            ExplicitWidth = 130
            ExplicitHeight = 29
            HelpContext = 1312018
          end
        end
      end
      object pnlSetupEmployeeAction: TDNMPanel
        Left = 698
        Top = 2
        Width = 132
        Height = 31
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
        HelpContext = 1312019
        object Shader3: TShader
          Tag = 1
          Left = 0
          Top = 0
          Width = 128
          Height = 27
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
          HelpContext = 1312020
          object Label8: TLabel
            Left = 0
            Top = 0
            Width = 128
            Height = 27
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Employee Setup'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            OnClick = Label8Click
            ExplicitTop = 2
            HelpContext = 1312021
          end
        end
      end
    end
    object pnlPayroll: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 86
      Width = 943
      Height = 77
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
        939
        73)
      HelpContext = 1312022
      object lblPayrollNotes: TLabel
        AlignWithMargins = True
        Left = 38
        Top = 33
        Width = 751
        Height = 37
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
        HelpContext = 1312023
      end
      object Label14: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 933
        Height = 24
        Align = alTop
        Caption = '2)  Setup / Check Payroll Tax'#39's'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 304
        HelpContext = 1312024
      end
      object pnlPayrollWF: TDNMPanel
        Left = 698
        Top = 39
        Width = 132
        Height = 31
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
        Visible = False
        HelpContext = 1312025
        object Shader7: TShader
          Tag = 2
          Left = 0
          Top = 0
          Width = 128
          Height = 27
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          Visible = False
          FromColor = 13303807
          ToColor = clWhite
          FromColorMirror = clWhite
          ToColorMirror = 8454143
          Steps = 10
          Direction = False
          Version = '1.4.0.0'
          HelpContext = 1312026
          object Label15: TLabel
            Left = 0
            Top = 0
            Width = 128
            Height = 27
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
            Visible = False
            OnClick = Label15Click
            ExplicitTop = -1
            ExplicitWidth = 130
            ExplicitHeight = 29
            HelpContext = 1312027
          end
        end
      end
      object pnlPayrollAction: TDNMPanel
        Left = 698
        Top = 2
        Width = 132
        Height = 31
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
        HelpContext = 1312028
        object Shader8: TShader
          Tag = 1
          Left = 0
          Top = 0
          Width = 128
          Height = 27
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
          HelpContext = 1312029
          object Label16: TLabel
            Left = 0
            Top = 0
            Width = 128
            Height = 27
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Payroll Tax'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            OnClick = Label16Click
            ExplicitTop = 2
            HelpContext = 1312030
          end
        end
      end
    end
    object pnlPayrollAccounts: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 169
      Width = 943
      Height = 77
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
        939
        73)
      HelpContext = 1312031
      object lblPayrollAccountsNotes: TLabel
        AlignWithMargins = True
        Left = 38
        Top = 33
        Width = 751
        Height = 37
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
        HelpContext = 1312032
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 933
        Height = 24
        Align = alTop
        Caption = '3)  Assign GL Accounts to Payroll Accounts'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 439
        HelpContext = 1312033
      end
      object pnlPayrollAccountsWF: TDNMPanel
        Left = 698
        Top = 39
        Width = 132
        Height = 31
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
        Visible = False
        HelpContext = 1312034
        object Shader4: TShader
          Tag = 2
          Left = 0
          Top = 0
          Width = 128
          Height = 27
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          Visible = False
          FromColor = 13303807
          ToColor = clWhite
          FromColorMirror = clWhite
          ToColorMirror = 8454143
          Steps = 10
          Direction = False
          Version = '1.4.0.0'
          HelpContext = 1312035
          object Label3: TLabel
            Left = 0
            Top = 0
            Width = 128
            Height = 27
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
            Visible = False
            OnClick = Label7Click
            ExplicitTop = -1
            ExplicitWidth = 130
            ExplicitHeight = 29
            HelpContext = 1312036
          end
        end
      end
      object pnlPayrollAccountsAction: TDNMPanel
        Left = 698
        Top = 2
        Width = 132
        Height = 31
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
        HelpContext = 1312037
        object Shader6: TShader
          Tag = 1
          Left = 0
          Top = 0
          Width = 128
          Height = 27
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
          HelpContext = 1312038
          object Label5: TLabel
            Left = 0
            Top = 0
            Width = 128
            Height = 27
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Payroll Accounts'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -16
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            OnClick = Label5Click
            ExplicitTop = 2
            HelpContext = 1312039
          end
        end
      end
    end
  end
  inherited pnkheader: TDNMPanel [6]
    HelpContext = 1312043
    inherited pnlTitle: TDNMPanel
      Left = 256
      Width = 340
      ExplicitLeft = 256
      ExplicitWidth = 340
      HelpContext = 1312040
      inherited TitleShader: TShader
        Width = 338
        ExplicitWidth = 338
        HelpContext = 1312041
        inherited TitleLabel: TLabel
          Width = 338
          Caption = 'Setup Payroll'
          ExplicitWidth = 255
          HelpContext = 1312042
        end
      end
    end
  end
  inherited pnlFooter: TDNMPanel [7]
    Top = 568
    ExplicitTop = 561
    HelpContext = 1312044
    inherited btnCancel: TDNMSpeedButton
      Left = 366
      ExplicitLeft = 366
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 878
  end
  inherited tmrdelay: TTimer
    Left = 913
  end
  inherited popSpelling: TPopupMenu
    Left = 563
  end
  inherited tmrdelayMsg: TTimer
    Left = 843
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 668
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 703
  end
  inherited DataState: TDataState
    Left = 738
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 598
  end
  inherited imgsort: TImageList
    Left = 773
    Bitmap = {
      494C0101020014014C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 493
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 808
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 633
  end
  inherited qryMemTrans: TERPQuery
    Left = 528
  end
end
