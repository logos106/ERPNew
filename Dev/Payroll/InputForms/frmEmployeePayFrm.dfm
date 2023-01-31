inherited frmEmployeePay: TfrmEmployeePay
  Left = 501
  Top = 145
  HelpContext = 272000
  Caption = 'Employee Pay'
  ClientHeight = 554
  ClientWidth = 993
  OldCreateOrder = True
  OnMouseWheel = FormMouseWheel
  ExplicitLeft = 501
  ExplicitTop = 145
  ExplicitWidth = 1009
  ExplicitHeight = 593
  DesignSize = (
    993
    554)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 554
    Width = 993
    HelpContext = 272072
    ExplicitTop = 554
    ExplicitWidth = 993
  end
  object Label1: TLabel [1]
    Left = 199
    Top = 36
    Width = 41
    Height = 15
    HelpContext = 272002
    Caption = 'Search'
    Transparent = True
    Visible = False
  end
  object Bevel1: TBevel [2]
    Left = 177
    Top = 0
    Width = 9
    Height = 554
    HelpContext = 272003
    Anchors = [akLeft, akTop, akBottom]
    Shape = bsLeftLine
  end
  object Label2: TLabel [3]
    Left = 185
    Top = 10
    Width = 48
    Height = 15
    HelpContext = 272004
    Alignment = taCenter
    AutoSize = False
    Caption = 'Scroll'
    Transparent = True
    Visible = False
  end
  object imgPrefs: TImage [4]
    Left = 185
    Top = 28
    Width = 48
    Height = 105
    HelpContext = 272005
    Visible = False
  end
  inherited imgGridWatermark: TImage
    Left = 196
    Top = 511
    HelpContext = 272001
    ExplicitLeft = 196
    ExplicitTop = 511
  end
  object Shader1: TShader [9]
    Left = 185
    Top = 54
    Width = 800
    Height = 31
    HelpContext = 272014
    BevelOuter = bvNone
    TabOrder = 5
    FromColor = clBtnFace
    ToColor = clWhite
    FromColorMirror = clWhite
    ToColorMirror = clBtnFace
    Steps = 10
    Direction = False
    Version = '1.4.0.0'
    object pnlActiveForm: TLabel
      Left = 5
      Top = 3
      Width = 793
      Height = 25
      HelpContext = 272015
      Alignment = taCenter
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsItalic]
      ParentFont = False
      Transparent = True
      Layout = tlCenter
    end
    object AdvPicture1: TAdvPicture
      Left = 3
      Top = 6
      Width = 25
      Height = 23
      HelpContext = 272016
      Animate = True
      Picture.Stretch = False
      Picture.Frame = 0
      PicturePosition = bpTopLeft
      StretchMode = smShrink
      Version = '1.4.0.0'
    end
  end
  object pnlTitle: TDNMPanel [10]
    Left = 394
    Top = 6
    Width = 392
    Height = 45
    HelpContext = 272017
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 388
      Height = 41
      HelpContext = 272018
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      FromColor = clBtnFace
      ToColor = clWhite
      FromColorMirror = clWhite
      ToColorMirror = clBtnFace
      Steps = 10
      Direction = False
      Version = '1.4.0.0'
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 388
        Height = 41
        HelpContext = 272019
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Employee Pay'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
    end
  end
  object pnlsum: TDNMPanel [11]
    Left = 184
    Top = 412
    Width = 804
    Height = 102
    HelpContext = 272020
    Anchors = [akLeft, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    object pnlemployee: TDNMPanel
      Left = 416
      Top = 1
      Width = 213
      Height = 100
      HelpContext = 272039
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
      object lblNICsOther: TLabel
        Tag = 1
        Left = 4
        Top = 22
        Width = 68
        Height = 15
        HelpContext = 272040
        Caption = 'NICs Class1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label12: TLabel
        Left = 4
        Top = 55
        Width = 61
        Height = 15
        HelpContext = 272041
        Caption = 'NICs Other'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label16: TLabel
        Left = 63
        Top = 4
        Width = 84
        Height = 15
        HelpContext = 272042
        Caption = 'Employee NICs'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edNICs: TDBEdit
        Left = 83
        Top = 21
        Width = 118
        Height = 23
        HelpContext = 272043
        TabStop = False
        DataField = 'UKNICsClass1'
        DataSource = DSPays
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edNICsOther: TDBEdit
        Left = 83
        Top = 50
        Width = 118
        Height = 23
        HelpContext = 272044
        TabStop = False
        DataField = 'UKNICsOther'
        DataSource = DSPays
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
    object pnlemployer: TDNMPanel
      Left = 415
      Top = 104
      Width = 213
      Height = 86
      HelpContext = 272045
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Label13: TLabel
        Tag = 1
        Left = 5
        Top = 27
        Width = 68
        Height = 15
        HelpContext = 272046
        Caption = 'NICs Class1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label15: TLabel
        Left = 6
        Top = 55
        Width = 61
        Height = 15
        HelpContext = 272047
        Caption = 'NICs Other'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label17: TLabel
        Left = 63
        Top = 4
        Width = 82
        Height = 15
        HelpContext = 272048
        Caption = 'Employer NICs'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edEmployerNICsClass1: TDBEdit
        Left = 84
        Top = 21
        Width = 121
        Height = 23
        HelpContext = 272049
        TabStop = False
        DataField = 'UKEmployerNICsClass1'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edEmployerNICsOther: TDBEdit
        Left = 85
        Top = 50
        Width = 121
        Height = 23
        HelpContext = 272050
        TabStop = False
        DataField = 'UKEmployerNICsOther'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
    object pnlsum1: TDNMPanel
      Left = 1
      Top = 1
      Width = 208
      Height = 100
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        208
        100)
      object lblWages: TLabel
        Left = 34
        Top = 13
        Width = 40
        Height = 15
        HelpContext = 272021
        Alignment = taRightJustify
        Caption = 'Wages'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblCommission: TLabel
        Left = 4
        Top = 41
        Width = 71
        Height = 15
        HelpContext = 272022
        Alignment = taRightJustify
        Caption = 'Commission'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblDeductions: TLabel
        Left = 11
        Top = 70
        Width = 64
        Height = 15
        HelpContext = 272023
        Alignment = taRightJustify
        Caption = 'Deductions'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Wages: TDBEdit
        Left = 83
        Top = 9
        Width = 118
        Height = 23
        HelpContext = 272030
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Wages'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object CommissionPay: TDBEdit
        Left = 83
        Top = 37
        Width = 118
        Height = 23
        HelpContext = 272031
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Commission'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object DeductionsPay: TDBEdit
        Left = 83
        Top = 66
        Width = 118
        Height = 23
        HelpContext = 272032
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Deductions'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object pnlsum2: TDNMPanel
      Left = 209
      Top = 1
      Width = 207
      Height = 100
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      DesignSize = (
        207
        100)
      object lblAllowances: TLabel
        Left = 9
        Top = 13
        Width = 66
        Height = 15
        HelpContext = 272024
        Alignment = taRightJustify
        Caption = 'Allowances'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblSundries: TLabel
        Left = 24
        Top = 41
        Width = 51
        Height = 15
        HelpContext = 272025
        Alignment = taRightJustify
        Caption = 'Sundries'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblSuper: TLabel
        Left = 41
        Top = 70
        Width = 34
        Height = 15
        HelpContext = 272029
        Alignment = taRightJustify
        Caption = 'Super'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object AllowancesPay: TDBEdit
        Left = 82
        Top = 9
        Width = 118
        Height = 23
        HelpContext = 272033
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Allowances'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object SuperPay: TDBEdit
        Left = 82
        Top = 66
        Width = 118
        Height = 23
        HelpContext = 272035
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Superannuation'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
      object SundriesPay: TDBEdit
        Left = 82
        Top = 37
        Width = 118
        Height = 23
        HelpContext = 272034
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Sundries'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object pnlsum3: TDNMPanel
      Left = 629
      Top = 1
      Width = 174
      Height = 100
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      DesignSize = (
        174
        100)
      object lblGross: TLabel
        Left = 4
        Top = 13
        Width = 34
        Height = 15
        HelpContext = 272026
        Alignment = taRightJustify
        Caption = 'Gross'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblTax: TLabel
        Left = 18
        Top = 38
        Width = 20
        Height = 15
        HelpContext = 272027
        Alignment = taRightJustify
        Caption = 'Tax'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object lblNet: TLabel
        Left = 19
        Top = 70
        Width = 19
        Height = 15
        HelpContext = 272028
        Alignment = taRightJustify
        Caption = 'Net'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object NetPay: TDBEdit
        Left = 51
        Top = 66
        Width = 118
        Height = 23
        HelpContext = 272038
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Net'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object TaxPay: TDBEdit
        Left = 51
        Top = 37
        Width = 118
        Height = 23
        HelpContext = 272037
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Tax'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = TaxPayChange
        OnEnter = TaxPayEnter
      end
      object GrossPay: TDBEdit
        Left = 51
        Top = 9
        Width = 118
        Height = 23
        HelpContext = 272036
        TabStop = False
        Anchors = [akLeft, akTop, akRight]
        DataField = 'Gross'
        DataSource = DSPays
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
    end
  end
  object DNMPanel2: TDNMPanel [12]
    Left = 185
    Top = 91
    Width = 801
    Height = 55
    HelpContext = 272051
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    object Label38: TLabel
      Left = 130
      Top = 4
      Width = 50
      Height = 15
      HelpContext = 272052
      Caption = 'Pay Date'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label49: TLabel
      Left = 240
      Top = 5
      Width = 54
      Height = 15
      HelpContext = 272053
      Caption = 'Date Paid'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label50: TLabel
      Left = 353
      Top = 6
      Width = 68
      Height = 15
      HelpContext = 272054
      Alignment = taCenter
      Caption = 'Pay Periods'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblTaxCode: TLabel
      Left = 517
      Top = 6
      Width = 51
      Height = 15
      HelpContext = 272055
      Caption = 'Tax code'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel2: TBevel
      Left = 653
      Top = 21
      Width = 114
      Height = 24
      HelpContext = 272056
      Shape = bsFrame
    end
    object Label11: TLabel
      Left = 686
      Top = 25
      Width = 64
      Height = 15
      HelpContext = 272057
      Caption = 'Manual Tax'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label14: TLabel
      Left = 436
      Top = 6
      Width = 42
      Height = 15
      HelpContext = 272058
      Caption = 'Pay No.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label20: TLabel
      Left = 12
      Top = 4
      Width = 39
      Height = 15
      HelpContext = 272059
      Caption = 'Region'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object PayDate: TwwDBDateTimePicker
      Left = 128
      Top = 22
      Width = 101
      Height = 23
      HelpContext = 272060
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'PayDate'
      DataSource = DSPays
      Date = 39207.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 0
      OnCloseUp = PayDateCloseUp
    end
    object DatePaid: TwwDBDateTimePicker
      Left = 238
      Top = 22
      Width = 101
      Height = 23
      HelpContext = 272061
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'DatePaid'
      DataSource = DSPays
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
    end
    object PayPeriods: TDBEdit
      Left = 353
      Top = 22
      Width = 52
      Height = 23
      HelpContext = 272062
      DataField = 'PayPeriods'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edTaxcodeUsed: TDBEdit
      Left = 518
      Top = 22
      Width = 63
      Height = 23
      HelpContext = 272063
      DataField = 'UKTaxCodeUsed'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object chkManualTax: TwwCheckBox
      Left = 662
      Top = 25
      Width = 15
      Height = 17
      HelpContext = 272064
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
      DataField = 'ManualTax'
      DataSource = DSPays
      TabOrder = 3
      OnClick = chkManualTaxClick
    end
    object edPayID: TDBEdit
      Left = 435
      Top = 22
      Width = 63
      Height = 23
      HelpContext = 272065
      DataField = 'PayID'
      DataSource = DSPays
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object edRegion: TDBEdit
      Left = 11
      Top = 22
      Width = 99
      Height = 23
      HelpContext = 272066
      DataField = 'Region'
      DataSource = DSPays
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
  end
  object btnEmployerNICs: TDNMSpeedButton [13]
    Left = 679
    Top = 548
    Width = 98
    Height = 27
    HelpContext = 272069
    Anchors = [akBottom]
    Caption = 'Employer NICs'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 9
    AutoDisableParentOnclick = True
    OnClick = btnEmployerNICsClick
  end
  object btnPrintPayslip: TDNMSpeedButton [14]
    Left = 527
    Top = 521
    Width = 87
    Height = 27
    HelpContext = 272070
    Anchors = [akBottom]
    Caption = 'Print Pay Slip'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 10
    AutoDisableParentOnclick = True
    OnClick = btnPrintPayslipClick
  end
  object btnABA: TDNMSpeedButton [15]
    Left = 298
    Top = 521
    Width = 87
    Height = 27
    HelpContext = 272071
    Anchors = [akBottom]
    Caption = 'Add to E.F.T.'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 11
    AutoDisableParentOnclick = True
    OnClick = btnABAClick
  end
  object btnLoadTimesheet: TDNMSpeedButton [16]
    Left = 642
    Top = 521
    Width = 102
    Height = 27
    HelpContext = 272075
    Anchors = [akBottom]
    Caption = '&Load Timesheet'
    DisableTransparent = False
    HotTrackFont.Charset = ANSI_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = [fsBold]
    TabOrder = 12
    AutoDisableParentOnclick = True
    OnClick = btnLoadTimesheetClick
  end
  object btnUpdateBatch: TDNMSpeedButton [17]
    Left = 413
    Top = 521
    Width = 87
    Height = 27
    Hint = 'Load Correct Commission Values for all Employees'
    HelpContext = 272076
    Anchors = [akBottom]
    Caption = 'Comm Update'
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
    TabOrder = 13
    TabStop = False
    AutoDisableParentOnclick = True
    OnClick = btnUpdateBatchClick
  end
  object sbPrefs: TScrollBox [18]
    Left = 185
    Top = 153
    Width = 801
    Height = 256
    HelpContext = 272010
    HorzScrollBar.Visible = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelKind = bkSoft
    BorderStyle = bsNone
    TabOrder = 4
  end
  object sbButtons: TScrollBox [19]
    Left = 0
    Top = 0
    Width = 177
    Height = 553
    HelpContext = 272008
    HorzScrollBar.Visible = False
    Anchors = [akLeft, akTop, akBottom]
    BorderStyle = bsNone
    TabOrder = 3
    object pnlButtons: TDNMPanel
      Left = 0
      Top = 0
      Width = 177
      Height = 553
      HelpContext = 272009
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Transparent = False
    end
  end
  object btnOK: TDNMSpeedButton [20]
    Left = 184
    Top = 521
    Width = 87
    Height = 27
    HelpContext = 272011
    Anchors = [akBottom]
    Caption = 'Save'
    Default = True
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = btnOKClick
  end
  object pnlTotalsUS: TDNMPanel [21]
    Left = 184
    Top = 272
    Width = 804
    Height = 102
    HelpContext = 272077
    Anchors = [akLeft, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    Visible = False
    DesignSize = (
      804
      102)
    object Label21: TLabel
      Left = 35
      Top = 16
      Width = 40
      Height = 15
      HelpContext = 272078
      Alignment = taRightJustify
      Caption = 'Wages'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label22: TLabel
      Left = 4
      Top = 43
      Width = 71
      Height = 15
      HelpContext = 272079
      Alignment = taRightJustify
      Caption = 'Commission'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label23: TLabel
      Left = 218
      Top = 43
      Width = 64
      Height = 15
      HelpContext = 272080
      Alignment = taRightJustify
      Caption = 'Deductions'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label25: TLabel
      Left = 441
      Top = 16
      Width = 51
      Height = 15
      HelpContext = 272082
      Alignment = taRightJustify
      Caption = 'Sundries'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label26: TLabel
      Left = 635
      Top = 16
      Width = 34
      Height = 15
      HelpContext = 272083
      Anchors = [akTop, akRight]
      Caption = 'Gross'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label27: TLabel
      Left = 649
      Top = 43
      Width = 20
      Height = 15
      HelpContext = 272084
      Anchors = [akTop, akRight]
      Caption = 'Tax'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label28: TLabel
      Left = 649
      Top = 72
      Width = 19
      Height = 15
      HelpContext = 272085
      Anchors = [akTop, akRight]
      Caption = 'Net'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label24: TLabel
      Left = 216
      Top = 16
      Width = 66
      Height = 15
      HelpContext = 272098
      Alignment = taRightJustify
      Caption = 'Allowances'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label29: TLabel
      Left = 416
      Top = 43
      Width = 76
      Height = 15
      HelpContext = 272099
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Company Tax'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edtUSWages: TDBEdit
      Left = 86
      Top = 12
      Width = 118
      Height = 23
      HelpContext = 272090
      TabStop = False
      DataField = 'Wages'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtUSCommission: TDBEdit
      Left = 86
      Top = 40
      Width = 118
      Height = 23
      HelpContext = 272091
      TabStop = False
      DataField = 'Commission'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtUSDeductions: TDBEdit
      Left = 288
      Top = 40
      Width = 118
      Height = 23
      HelpContext = 272092
      TabStop = False
      DataField = 'Deductions'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtUSSundries: TDBEdit
      Left = 501
      Top = 12
      Width = 118
      Height = 23
      HelpContext = 272094
      TabStop = False
      DataField = 'Sundries'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object edtUSGross: TDBEdit
      Left = 678
      Top = 12
      Width = 118
      Height = 23
      HelpContext = 272095
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'Gross'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object edtUSTax: TDBEdit
      Left = 678
      Top = 40
      Width = 118
      Height = 23
      HelpContext = 272096
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'Tax'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnEnter = TaxPayEnter
    end
    object edUSNet: TDBEdit
      Left = 678
      Top = 69
      Width = 118
      Height = 23
      HelpContext = 272097
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'Net'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
    object DBEdit1: TDBEdit
      Left = 288
      Top = 12
      Width = 118
      Height = 23
      HelpContext = 272100
      TabStop = False
      DataField = 'Allowances'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
    end
    object edtCompanyTax: TDBEdit
      Left = 501
      Top = 40
      Width = 118
      Height = 23
      HelpContext = 272101
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'CompanyTax'
      DataSource = DSPays
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
      OnEnter = TaxPayEnter
    end
  end
  object btnCancel: TDNMSpeedButton [22]
    Left = 772
    Top = 521
    Width = 87
    Height = 27
    HelpContext = 272012
    Anchors = [akBottom]
    Cancel = True
    Caption = '&Cancel'
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
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -12
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    AutoDisableParentOnclick = True
    OnClick = btnCancelClick
  end
  object pnlPrepared: TDNMPanel [23]
    Left = 865
    Top = 517
    Width = 62
    Height = 34
    HelpContext = 272102
    Anchors = [akRight, akBottom]
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 15
    Visible = False
    DesignSize = (
      62
      34)
    object Label18: TLabel
      Left = 1
      Top = 1
      Width = 60
      Height = 17
      HelpContext = 272006
      Align = alTop
      Alignment = taCenter
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Prepared'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 54
    end
    object ChkPrepared: TwwCheckBox
      Left = 23
      Top = 16
      Width = 15
      Height = 17
      HelpContext = 272068
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
      Anchors = [akRight, akBottom]
      Caption = 'chkApplycredits'
      DataField = 'Prepared'
      DataSource = DSPays
      TabOrder = 0
    end
  end
  object pnlDeleted: TDNMPanel [24]
    Left = 934
    Top = 517
    Width = 54
    Height = 34
    HelpContext = 272103
    Anchors = [akRight, akBottom]
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 16
    DesignSize = (
      54
      34)
    object Label19: TLabel
      Left = 1
      Top = 1
      Width = 52
      Height = 17
      HelpContext = 272007
      Align = alTop
      Alignment = taCenter
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Deleted'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitLeft = 0
      ExplicitWidth = 54
    end
    object chkDeleted: TwwCheckBox
      Left = 20
      Top = 16
      Width = 15
      Height = 17
      HelpContext = 272067
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
      Anchors = [akRight, akBottom]
      Caption = 'chkApplycredits'
      DataField = 'Deleted'
      DataSource = DSPays
      TabOrder = 0
      OnClick = chkDeletedClick
    end
  end
  object cboSearch: TwwDBComboBox [25]
    Left = 247
    Top = 26
    Width = 133
    Height = 23
    HelpContext = 272013
    ShowButton = True
    Style = csDropDown
    MapList = False
    AllowClearKey = False
    AutoDropDown = True
    ShowMatchText = True
    DropDownCount = 8
    DropDownWidth = 400
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 0
    ParentFont = False
    Sorted = True
    TabOrder = 0
    UnboundDataType = wwDefault
    Visible = False
    OnCloseUp = cboSearchCloseUp
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 215
    Top = 165
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 215
    Top = 201
  end
  inherited MyConnection: TERPConnection
    Database = 'aime_live'
    Left = 18
    Top = 15
  end
  inherited DataState: TDataState
    Left = 255
    Top = 149
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 217
    Top = 236
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102007C002C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited qryMemTrans: TERPQuery
    Left = 29
    Top = 136
  end
  object ImageScroll: TImageScroll
    Enabled = False
    Left = 249
    Top = 236
  end
  object qryPays: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblpays')
    Left = 860
    Top = 8
    object qryPaysPayID: TIntegerField
      FieldName = 'PayID'
    end
    object qryPaysEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryPaysPayDate: TDateField
      FieldName = 'PayDate'
    end
    object qryPaysPayPeriods: TWordField
      FieldName = 'PayPeriods'
    end
    object qryPaysWages: TFloatField
      FieldName = 'Wages'
      currency = True
    end
    object qryPaysCommission: TFloatField
      FieldName = 'Commission'
      currency = True
    end
    object qryPaysDeductions: TFloatField
      FieldName = 'Deductions'
      currency = True
    end
    object qryPaysworkplacegiving: TFloatField
      FieldName = 'WorkplaceGiving'
      currency = True
    end
    object qryPaysAllowances: TFloatField
      FieldName = 'Allowances'
      currency = True
    end
    object qryPaysAllowancesBeforeTax: TFloatField
      FieldName = 'AllowancesBeforeTax'
    end
    object qryPaysSundries: TFloatField
      FieldName = 'Sundries'
      currency = True
    end
    object qryPaysSuperannuation: TFloatField
      FieldName = 'Superannuation'
      currency = True
    end
    object qryPaysGross: TFloatField
      FieldName = 'Gross'
      currency = True
    end
    object qryPaysGrossTaxable: TFloatField
      FieldName = 'GrossTaxable'
    end
    object qryPaysTax: TFloatField
      FieldName = 'Tax'
      currency = True
    end
    object qryPaysNet: TFloatField
      FieldName = 'Net'
      currency = True
    end
    object qryPaysPay: TWideStringField
      FieldName = 'Pay'
      FixedChar = True
      Size = 1
    end
    object qryPaysPaid: TWideStringField
      FieldName = 'Paid'
      FixedChar = True
      Size = 1
    end
    object qryPaysEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryPaysPrinted: TWideStringField
      FieldName = 'Printed'
      FixedChar = True
      Size = 1
    end
    object qryPaysEmpName: TWideStringField
      FieldName = 'EmpName'
      Size = 50
    end
    object qryPaysLeaveLoading: TFloatField
      FieldName = 'LeaveLoading'
    end
    object qryPaysClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryPaysClass: TWideStringField
      FieldName = 'Class'
      Size = 255
    end
    object qryPaysIsTimesheet: TWideStringField
      FieldName = 'IsTimesheet'
      FixedChar = True
      Size = 1
    end
    object qryPaysPayPeriod: TWideStringField
      FieldName = 'PayPeriod'
      Size = 255
    end
    object qryPaysAnnualLeaveRate: TFloatField
      FieldName = 'AnnualLeaveRate'
    end
    object qryPaysCDEPGross: TFloatField
      FieldName = 'CDEPGross'
    end
    object qryPaysLumpA: TFloatField
      FieldName = 'LumpA'
    end
    object qryPaysLumpB: TFloatField
      FieldName = 'LumpB'
    end
    object qryPaysLumpD: TFloatField
      FieldName = 'LumpD'
    end
    object qryPaysLumpE: TFloatField
      FieldName = 'LumpE'
    end
    object qryPaysETP: TFloatField
      FieldName = 'ETP'
    end
    object qryPaysManualTax: TWideStringField
      FieldName = 'ManualTax'
      FixedChar = True
      Size = 1
    end
    object qryPaysDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object qryPaysIsNewTypePay: TWideStringField
      FieldName = 'IsNewTypePay'
      FixedChar = True
      Size = 1
    end
    object qryPaysmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryPaysPaySuperOnLeaveLoading: TWideStringField
      FieldName = 'PaySuperOnLeaveLoading'
      FixedChar = True
      Size = 1
    end
    object qryPaysPayVersion: TIntegerField
      FieldName = 'PayVersion'
    end
    object qryPaysPayNotes: TWideMemoField
      FieldName = 'PayNotes'
      BlobType = ftWideMemo
    end
    object qryPaysUKTaxCodeUsed: TWideStringField
      FieldName = 'UKTaxCodeUsed'
      Size = 255
    end
    object qryPaysPrepared: TWideStringField
      FieldName = 'Prepared'
      FixedChar = True
      Size = 1
    end
    object qryPaysUKNICsClass1: TFloatField
      FieldName = 'UKNICsClass1'
      currency = True
    end
    object qryPaysIsContractedOut: TWideStringField
      FieldName = 'IsContractedOut'
      FixedChar = True
      Size = 1
    end
    object qryPaysUKNICsOther: TFloatField
      FieldName = 'UKNICsOther'
      currency = True
    end
    object qryPaysUKEmployerNICsClass1: TFloatField
      FieldName = 'UKEmployerNICsClass1'
      currency = True
    end
    object qryPaysUKEmployerNICsOther: TFloatField
      FieldName = 'UKEmployerNICsOther'
      currency = True
    end
    object qryPaysRegion: TWideStringField
      FieldName = 'Region'
      Size = 255
    end
    object qryPaysIsContractedOut2: TWideStringField
      FieldName = 'IsContractedOut2'
      FixedChar = True
      Size = 1
    end
    object qryPaysGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryPaysPayXMLData: TWideMemoField
      FieldName = 'PayXMLData'
      BlobType = ftWideMemo
    end
    object qryPaysIsTermination: TWideStringField
      FieldName = 'IsTermination'
      FixedChar = True
      Size = 1
    end
    object qryPaysmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryPaysCompanyTax: TFloatField
      FieldName = 'CompanyTax'
      currency = True
    end
    object qryPaysPayRunID: TIntegerField
      FieldName = 'PayRunID'
    end
    object qryPaysGrossExcludeAllowances: TFloatField
      FieldName = 'GrossExcludeAllowances'
    end
    object qryPaysTopUptoJobKeepersAllowance: TFloatField
      FieldName = 'TopUptoJobKeepersAllowance'
      currency = True
    end
    object qryPaysDatePaid: TDateTimeField
      FieldName = 'DatePaid'
    end
  end
  object DSPays: TDataSource
    DataSet = qryPays
    Left = 904
    Top = 8
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 952
    Top = 16
  end
  object Timer2: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer2Timer
    Left = 936
    Top = 8
  end
  object qryPayAllowances: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblpaysallowances'
      'Where PayID=:xPayID;')
    Left = 612
    Top = 154
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayID'
      end>
    object qryPayAllowancesPayAllowanceID: TAutoIncField
      FieldName = 'PayAllowanceID'
      ReadOnly = True
    end
    object qryPayAllowancesPayID: TIntegerField
      FieldName = 'PayID'
    end
    object qryPayAllowancesAllowanceID: TIntegerField
      FieldName = 'AllowanceID'
    end
    object qryPayAllowancesQty: TFloatField
      FieldName = 'Qty'
    end
    object qryPayAllowancesAmount: TFloatField
      FieldName = 'Amount'
    end
    object qryPayAllowancesCalcBy: TWideStringField
      FieldName = 'CalcBy'
      Size = 50
    end
    object qryPayAllowancesArea: TWideStringField
      FieldName = 'Area'
      Size = 50
    end
    object qryPayAllowancesSuperInc: TWideStringField
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryPayAllowancesTaxExempt: TWideStringField
      FieldName = 'TaxExempt'
      FixedChar = True
      Size = 1
    end
    object qryPayAllowancesClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryPayAllowancesClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryPayAllowancesAllowance: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Allowance'
      LookupDataSet = qryAllowances
      LookupKeyFields = 'AllowanceID'
      LookupResultField = 'Description'
      KeyFields = 'AllowanceID'
      Lookup = True
    end
    object qryPayAllowancesAllowanceJob: TWideStringField
      FieldKind = fkLookup
      FieldName = 'AllowanceJob'
      LookupDataSet = qryJobs
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Lookup = True
    end
    object qryPayAllowancesLineTotal: TFloatField
      FieldKind = fkCalculated
      FieldName = 'LineTotal'
      Calculated = True
    end
    object qryPayAllowancesClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object qryPayAllowancesBasedOn: TWideStringField
      FieldKind = fkLookup
      FieldName = 'BasedOn'
      LookupDataSet = qryBasedOn
      LookupKeyFields = 'BasedOnID'
      LookupResultField = 'BasedOn'
      KeyFields = 'BasedOnID'
      Size = 25
      Lookup = True
    end
    object qryPayAllowancesBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
    end
    object qryPayAllowancesMoneyAmount: TFloatField
      FieldName = 'MoneyAmount'
      currency = True
    end
    object qryPayAllowancesAllowanceType: TWideStringField
      FieldName = 'AllowanceType'
      FixedChar = True
      Size = 9
    end
    object qryPayAllowancesDisplayIn: TWideStringField
      FieldName = 'DisplayIn'
      FixedChar = True
      Size = 14
    end
  end
  object qryAllowances: TERPQuery
    SQL.Strings = (
      
        'Select AllowanceID, Description, SuperInc, TaxExempt, PayrollTax' +
        'Exempt, '
      
        'WorkcoverExempt, DisplayIn, Amount, Percentage, BasedOnID, Activ' +
        'e,'
      'Percentage AS Qty, CalcBy'
      'FROM tblAllowances'
      'WHERE Active='#39'T'#39
      ''
      '')
    Left = 839
    Top = 40
    object qryAllowancesDescription: TWideStringField
      DisplayWidth = 15
      FieldName = 'Description'
      Size = 150
    end
    object qryAllowancesAllowanceID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'AllowanceID'
      ReadOnly = True
      Visible = False
    end
    object qryAllowancesSuperInc: TWideStringField
      DisplayWidth = 1
      FieldName = 'SuperInc'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesTaxExempt: TWideStringField
      DisplayWidth = 1
      FieldName = 'TaxExempt'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAllowancesQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Visible = False
    end
    object qryAllowancesAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Visible = False
    end
    object qryAllowancesBasedOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BasedOnID'
      Visible = False
    end
    object qryAllowancesCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
  end
  object qryJobs: TERPQuery
    SQL.Strings = (
      'SELECT ClientID, Company, JobNumber, DefaultClass'
      'FROM tblclients'
      
        'WHERE Active = '#39'T'#39' AND Customer='#39'T'#39' AND (Company NOT LIKE '#39'Table' +
        '%'#39')'
      'ORDER BY Company')
    Left = 868
    Top = 42
  end
  object qryBasedOn: TERPQuery
    SQL.Strings = (
      'Select BasedOnID, BasedOn'
      'FROM tblAllowanceBasedOn')
    Left = 895
    Top = 41
    object qryBasedOnBasedOn: TWideStringField
      DisplayWidth = 25
      FieldName = 'BasedOn'
      Size = 25
    end
    object qryBasedOnBasedOnID: TAutoIncField
      FieldName = 'BasedOnID'
      ReadOnly = True
      Visible = False
    end
  end
  object qryPayPaySplits: TERPQuery
    SQL.Strings = (
      
        'Select tblpayssplits.*,"Bank" as Bank From tblpayssplits WHERE P' +
        'ayID = :xPayID')
    Left = 420
    Top = 162
    ParamData = <
      item
        DataType = ftString
        Name = 'xPayID'
        Value = ''
      end>
    object qryPayPaySplitsBank: TWideStringField
      DisplayWidth = 5
      FieldKind = fkLookup
      FieldName = 'Bank'
      LookupDataSet = qryBankCodes
      LookupKeyFields = 'CodeID'
      LookupResultField = 'BankCode'
      KeyFields = 'BankID'
      FixedChar = True
      Size = 4
      Lookup = True
    end
    object qryPayPaySplitsSplit: TWideStringField
      DisplayWidth = 6
      FieldName = 'Split'
      FixedChar = True
      Size = 6
    end
    object qryPayPaySplitsBranch: TWideStringField
      DisplayWidth = 25
      FieldName = 'Branch'
      Size = 64
    end
    object qryPayPaySplitsBSB: TWideStringField
      DisplayWidth = 16
      FieldName = 'BSB'
      Size = 16
    end
    object qryPayPaySplitsAccountName: TWideStringField
      DisplayWidth = 30
      FieldName = 'AccountName'
      Size = 64
    end
    object qryPayPaySplitsAccountNo: TWideStringField
      DisplayWidth = 16
      FieldName = 'AccountNo'
      Size = 16
    end
    object qryPayPaySplitsAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
    end
    object qryPayPaySplitsType: TWideStringField
      DisplayWidth = 10
      FieldName = 'Type'
      Size = 32
    end
    object qryPayPaySplitsPayID: TIntegerField
      DisplayWidth = 4
      FieldName = 'PayID'
      Visible = False
    end
    object qryPayPaySplitsPaySplitID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PaySplitID'
      Visible = False
    end
    object qryPayPaySplitsBankID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BankID'
      Visible = False
    end
  end
  object qryBankCodes: TERPQuery
    SQL.Strings = (
      'Select CodeID,BankCode,BankName'
      'FROM tblBankCodes'
      'Where  (RegionId = :XRegionID)')
    BeforeOpen = qryBankCodesBeforeOpen
    Left = 738
    Top = 59
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'XRegionID'
      end>
  end
  object qrypayssuper: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblpayssuperannuation'
      'Where PayID=:xPayID'
      'AND BelowThreshold <> '#39'T'#39';')
    Options.FlatBuffers = True
    Left = 322
    Top = 172
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayID'
      end>
    object qrypayssuperSuperType: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'SuperType'
      LookupDataSet = qrySuperType
      LookupKeyFields = 'SuperTypeID'
      LookupResultField = 'Description'
      KeyFields = 'SuperTypeID'
      Lookup = True
    end
    object qrypayssuperSuperFund: TWideStringField
      DisplayLabel = 'Fund'
      DisplayWidth = 21
      FieldKind = fkLookup
      FieldName = 'SuperFund'
      LookupDataSet = qrySuppliers
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Lookup = True
    end
    object qrypayssuperAccountNo: TWideStringField
      DisplayLabel = 'Member No'
      DisplayWidth = 20
      FieldName = 'AccountNo'
      FixedChar = True
      Size = 50
    end
    object qrypayssuperDateJoined: TDateField
      DisplayLabel = 'Date Joined'
      DisplayWidth = 10
      FieldName = 'DateJoined'
    end
    object qrypayssuperAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
    end
    object qrypayssuperCalcBy: TWideStringField
      DisplayLabel = '$/%'
      DisplayWidth = 4
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qrypayssuperArea: TWideStringField
      FieldName = 'Area'
      Size = 50
    end
    object qrypayssuperAmountPaid: TFloatField
      DisplayLabel = 'Amount To Pay'
      DisplayWidth = 11
      FieldName = 'AmountPaid'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object qrypayssuperClassName: TWideStringField
      DisplayWidth = 40
      FieldName = 'ClassName'
      Size = 255
    end
    object qrypayssuperPaySuperID: TAutoIncField
      FieldName = 'PaySuperID'
      ReadOnly = True
      Visible = False
    end
    object qrypayssuperPayID: TIntegerField
      FieldName = 'PayID'
      Visible = False
    end
    object qrypayssuperSuperID: TIntegerField
      FieldName = 'SuperID'
      Visible = False
    end
    object qrypayssuperSuperTypeID: TIntegerField
      FieldName = 'SuperTypeID'
      Visible = False
    end
    object qrypayssuperClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object qrypayssuperClassID: TIntegerField
      FieldName = 'ClassID'
      Visible = False
    end
    object qrypayssuperThisPaysProportion: TFloatField
      FieldName = 'ThisPaysProportion'
    end
    object qrypayssuperNonCatchUpAmount: TFloatField
      FieldName = 'NonCatchUpAmount'
    end
    object qrypayssuperBelowThreshold: TWideStringField
      FieldName = 'BelowThreshold'
      FixedChar = True
      Size = 1
    end
  end
  object qrySuperType: TERPQuery
    SQL.Strings = (
      'Select SuperTypeID, Description'
      'FROM tblSuperType')
    Options.FlatBuffers = True
    Left = 872
    Top = 128
  end
  object qrySuppliers: TERPQuery
    SQL.Strings = (
      'Select ClientID, Company'
      'FROM tblClients'
      'WHERE Supplier='#39'T'#39
      'Order By Company;')
    Options.FlatBuffers = True
    Left = 923
    Top = 129
  end
  object qryPayBenefits: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblpaysukbenefits')
    Options.FlatBuffers = True
    Left = 871
    Top = 166
    object qryPayBenefitsPayID: TIntegerField
      FieldName = 'PayID'
    end
    object qryPayBenefitsDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryPayBenefitsIsNICsPayable: TWideStringField
      FieldName = 'IsNICsPayable'
      FixedChar = True
      Size = 1
    end
    object qryPayBenefitsNICsClass: TWideStringField
      FieldName = 'NICsClass'
      Size = 32
    end
    object qryPayBenefitsAmount: TFloatField
      FieldName = 'Amount'
    end
    object qryPayBenefitsEmployeeNICAmount: TFloatField
      FieldName = 'EmployeeNICAmount'
    end
    object qryPayBenefitsEmployerNICAmount: TFloatField
      FieldName = 'EmployerNICAmount'
    end
    object qryPayBenefitsBenefitReceivedFrom: TWideStringField
      FieldName = 'BenefitReceivedFrom'
      Size = 255
    end
    object qryPayBenefitsBenefitOrExpense: TWideStringField
      FieldName = 'BenefitOrExpense'
      FixedChar = True
      Size = 15
    end
    object qryPayBenefitsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryPayBenefitsClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
  end
  object qryPayCommissions: TERPQuery
    SQL.Strings = (
      'Select *'
      'From tblpayscommission'
      'Where PayID=:xPayID;')
    AfterPost = qryPayCommissionsAfterPost
    Left = 526
    Top = 185
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayID'
      end>
    object qryPayCommissionsPayCommissionID: TIntegerField
      FieldName = 'PayCommissionID'
    end
    object qryPayCommissionsPayID: TIntegerField
      FieldName = 'PayID'
    end
    object qryPayCommissionsCommissionID: TIntegerField
      FieldName = 'CommissionID'
    end
    object qryPayCommissionsGross: TFloatField
      FieldName = 'Gross'
      currency = True
    end
    object qryPayCommissionsCommissionPercent: TFloatField
      FieldName = 'CommissionPercent'
    end
    object qryPayCommissionsNet: TFloatField
      FieldName = 'Net'
      currency = True
    end
    object qryPayCommissionsPeriodID: TIntegerField
      FieldName = 'PeriodID'
    end
    object qryPayCommissionsSuperInc: TWideStringField
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryPayCommissionsTaxExempt: TWideStringField
      FieldName = 'TaxExempt'
      FixedChar = True
      Size = 1
    end
    object qryPayCommissionsCommPeriod: TWideStringField
      FieldKind = fkLookup
      FieldName = 'CommPeriod'
      LookupDataSet = qryCommissionPeriod
      LookupKeyFields = 'PeriodID'
      LookupResultField = 'Period'
      KeyFields = 'PeriodID'
      Lookup = True
    end
    object qryPayCommissionsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryPayCommissionsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryPayCommissionsClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object qryPayCommissionscDetails: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'cDetails'
      Size = 1
      Calculated = True
    end
    object qryPayCommissionsCommissionDesc: TWideMemoField
      FieldName = 'CommissionDesc'
      BlobType = ftWideMemo
    end
    object qryPayCommissionsIsManual: TWideStringField
      FieldName = 'IsManual'
      FixedChar = True
      Size = 1
    end
  end
  object qryCommissionPeriod: TERPQuery
    SQL.Strings = (
      'Select PeriodID,Period'
      'FROM tblCommissionPeriod'
      'Where Active = '#39'T'#39)
    Left = 824
    Top = 208
  end
  object qryPaydeductions: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblpaysdeductions'
      'Where PayID=:xPayID;')
    Left = 338
    Top = 227
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayID'
      end>
    object qryPaydeductionsPayDeductionID: TAutoIncField
      FieldName = 'PayDeductionID'
      ReadOnly = True
    end
    object qryPaydeductionsPayID: TIntegerField
      FieldName = 'PayID'
    end
    object qryPaydeductionsDeductionID: TIntegerField
      FieldName = 'DeductionID'
    end
    object qryPaydeductionsNotes: TWideStringField
      FieldName = 'Notes'
      Size = 50
    end
    object qryPaydeductionsQty: TFloatField
      FieldName = 'Qty'
    end
    object qryPaydeductionsAmount: TFloatField
      FieldName = 'Amount'
      DisplayFormat = '0.00'
    end
    object qryPaydeductionsCalcBy: TWideStringField
      FieldName = 'CalcBy'
      FixedChar = True
      Size = 1
    end
    object qryPaydeductionsArea: TWideStringField
      FieldName = 'Area'
      Size = 50
    end
    object qryPaydeductionsUnionFees: TWideStringField
      Alignment = taCenter
      FieldName = 'UnionFees'
      FixedChar = True
      Size = 1
    end
    object qryPaydeductionsTaxExempt: TWideStringField
      Alignment = taCenter
      FieldName = 'TaxExempt'
      FixedChar = True
      Size = 1
    end
    object qryPaydeductionsIsWorkPlacegiving: TWideStringField
      Alignment = taCenter
      FieldName = 'IsWorkPlacegiving'
      FixedChar = True
      Size = 1
    end
    object qryPaydeductionsDeduction: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Deduction'
      LookupDataSet = qryDeductions
      LookupKeyFields = 'DeductionID'
      LookupResultField = 'Description'
      KeyFields = 'DeductionID'
      Lookup = True
    end
    object qryPaydeductionsClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryPaydeductionsClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object qryPaydeductionsBasedOnID: TIntegerField
      FieldName = 'BasedOnID'
    end
    object qryPaydeductionsBasedOn: TWideStringField
      FieldKind = fkLookup
      FieldName = 'BasedOn'
      LookupDataSet = qryBasedOn
      LookupKeyFields = 'BasedOnID'
      LookupResultField = 'BasedOn'
      KeyFields = 'BasedOnID'
      Size = 25
      Lookup = True
    end
    object qryPaydeductionsMoneyAmount: TFloatField
      FieldName = 'MoneyAmount'
      currency = True
    end
    object qryPaydeductionsBox12CodeID: TIntegerField
      FieldName = 'Box12CodeID'
    end
    object qryPaydeductionsTaxExemptFederal: TWideStringField
      FieldName = 'TaxExemptFederal'
      FixedChar = True
      Size = 1
    end
    object qryPaydeductionsTaxExemptState: TWideStringField
      FieldName = 'TaxExemptState'
      FixedChar = True
      Size = 1
    end
    object qryPaydeductionsTaxExemptSocial: TWideStringField
      FieldName = 'TaxExemptSocial'
      FixedChar = True
      Size = 1
    end
    object qryPaydeductionsTaxExemptMedicare: TWideStringField
      FieldName = 'TaxExemptMedicare'
      FixedChar = True
      Size = 1
    end
  end
  object qryDeductions: TERPQuery
    SQL.Strings = (
      
        'Select DeductionID, Description, BasedOnID, TaxExempt, IsWorkPla' +
        'cegiving, UnionFees, CalcBy, Amount'
      'FROM tblDeductions')
    Left = 743
    Top = 234
  end
  object qryPaysPayRates: TERPQuery
    SQL.Strings = (
      'select * from tblpayspayrates '
      'Where PayID = :xPayId')
    Left = 564
    Top = 164
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayId'
      end>
    object qryPaysPayRatesPayID: TIntegerField
      DisplayWidth = 5
      FieldName = 'PayID'
      Origin = 'tblpayspayrates.PayID'
      Visible = False
    end
    object qryPaysPayRatesPayRate: TWideStringField
      DisplayLabel = 'Pay Rate'
      DisplayWidth = 32
      FieldKind = fkLookup
      FieldName = 'PayRate'
      LookupDataSet = qryPayRates
      LookupKeyFields = 'RateID'
      LookupResultField = 'Description'
      KeyFields = 'PayRateID'
      Size = 32
      Lookup = True
    end
    object qryPaysPayRatesPayType: TWideStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'PayType'
      LookupDataSet = qryPayRateType
      LookupKeyFields = 'TypeID'
      LookupResultField = 'Description'
      KeyFields = 'TypeID'
      Size = 64
      Lookup = True
    end
    object qryPaysPayRatesQty: TFloatField
      DisplayWidth = 10
      FieldName = 'Qty'
      Origin = 'tblpayspayrates.Qty'
      OnSetText = FeldSetTextDontAllowNulls
      DisplayFormat = '#,##.0##;-#,##.0##'
    end
    object qryPaysPayRatesAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Origin = 'tblpayspayrates.Amount'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object qryPaysPayRatesSuperInc: TWideStringField
      DisplayWidth = 1
      FieldName = 'SuperInc'
      Origin = 'tblpayspayrates.SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryPaysPayRatesPayJob: TWideStringField
      DisplayLabel = 'Job'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'PayJob'
      LookupDataSet = qryJobs
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Lookup = True
    end
    object qryPaysPayRatesLineTotal: TFloatField
      DisplayLabel = 'Line Total'
      DisplayWidth = 10
      FieldName = 'LineTotal'
      Origin = 'tblpayspayrates.LineTotal'
      currency = True
    end
    object qryPaysPayRatesClassName: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 15
      FieldName = 'ClassName'
      Origin = 'tblpayspayrates.ClassName'
      Size = 255
    end
    object qryPaysPayRatesPayRateID: TIntegerField
      DisplayWidth = 5
      FieldName = 'PayRateID'
      Origin = 'tblpayspayrates.PayRateID'
      Visible = False
    end
    object qryPaysPayRatesTypeID: TIntegerField
      DisplayWidth = 5
      FieldName = 'TypeID'
      Origin = 'tblpayspayrates.TypeID'
      Visible = False
    end
    object qryPaysPayRatesGlobalRef: TWideStringField
      DisplayWidth = 5
      FieldName = 'GlobalRef'
      Origin = 'tblpayspayrates.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPaysPayRatesClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tblpayspayrates.ClientID'
      Visible = False
    end
    object qryPaysPayRatesClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Origin = 'tblpayspayrates.ClassID'
      Visible = False
    end
    object qryPaysPayRatesEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblpayspayrates.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPaysPayRatesTimeSheetId: TIntegerField
      DisplayWidth = 10
      FieldName = 'TimeSheetId'
      Origin = 'tblpayspayrates.TimeSheetId'
      Visible = False
    end
    object qryPaysPayRatesPaysPayRateID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 5
      FieldName = 'PaysPayRateID'
      Origin = 'tblpayspayrates.PaysPayRateID'
      Visible = False
    end
    object qryPaysPayRatesNICsInc: TWideStringField
      DisplayWidth = 1
      FieldName = 'NICsInc'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryPayRates: TERPQuery
    SQL.Strings = (
      'Select RateID, Description'
      'FROM tblPayRates'
      '#WHERE Active = '#39'T'#39)
    Left = 917
    Top = 209
  end
  object qryPayRateType: TERPQuery
    SQL.Strings = (
      'Select TypeID,Description'
      'FROM tblPayRateType')
    Left = 950
    Top = 208
  end
  object qryLeaveTypes: TERPQuery
    SQL.Strings = (
      
        'SELECT LeaveTypeID,LeaveType FROM tblleavetypes WHERE Active = '#39 +
        'T'#39)
    Left = 953
    Top = 250
  end
  object qryLeavePayTypes: TERPQuery
    SQL.Strings = (
      'Select TypeID,Description'
      'FROM tblPayRateType')
    Left = 915
    Top = 250
  end
  object qryPaysLeave: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblPaysLeave'
      'Where PayID=:xPayID;')
    Left = 618
    Top = 226
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayID'
      end>
    object qryPaysLeaveDateTaken: TDateField
      DisplayLabel = 'Date Taken'
      DisplayWidth = 10
      FieldName = 'DateTaken'
    end
    object qryPaysLeaveLeaveType: TWideStringField
      FieldName = 'LeaveType'
      Size = 255
    end
    object qryPaysLeaveQty: TFloatField
      DisplayLabel = 'Hours'
      DisplayWidth = 7
      FieldName = 'Qty'
    end
    object qryPaysLeaveLeavePayType: TWideStringField
      DisplayLabel = 'Pay Type'
      DisplayWidth = 16
      FieldName = 'LeavePayType'
      Visible = False
      FixedChar = True
      Size = 24
    end
    object qryPaysLeaveAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      Visible = False
      currency = True
    end
    object qryPaysLeavelookupJob: TWideStringField
      DisplayLabel = 'Job'
      DisplayWidth = 25
      FieldKind = fkLookup
      FieldName = 'lookupJob'
      LookupDataSet = qryJobs
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Visible = False
      Size = 25
      Lookup = True
    end
    object qryPaysLeaveGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPaysLeavePayLeaveID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'PayLeaveID'
      ReadOnly = True
      Visible = False
    end
    object qryPaysLeavePayID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayID'
      Visible = False
    end
    object qryPaysLeaveClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object qryPaysLeaveClassID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object qryPaysLeaveEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPaysLeaveClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
    object qryPaysLeaveSuperInc: TWideStringField
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryPaysLeaveIsCertified: TWideStringField
      FieldName = 'IsCertified'
      FixedChar = True
      Size = 1
    end
    object qryPaysLeaveTakenFrom: TDateTimeField
      FieldName = 'TakenFrom'
    end
    object qryPaysLeaveTakenTo: TDateTimeField
      FieldName = 'TakenTo'
    end
  end
  object qryPaySundries: TERPQuery
    SQL.Strings = (
      'Select *'
      'From tblpayssundries'
      'Where PayID=:xPayID;')
    Left = 560
    Top = 233
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPayID'
      end>
    object qryPaySundriesSundry: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 18
      FieldName = 'Sundry'
      Size = 64
    end
    object qryPaySundriesAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'Amount'
      currency = True
    end
    object qryPaySundriesGST: TFloatField
      DisplayWidth = 10
      FieldName = 'GST'
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object qryPaySundriesSuperInc: TWideStringField
      DisplayWidth = 5
      FieldName = 'SuperInc'
      FixedChar = True
      Size = 1
    end
    object qryPaySundriesTaxExempt: TWideStringField
      DisplayWidth = 5
      FieldName = 'TaxExempt'
      FixedChar = True
      Size = 1
    end
    object qryPaySundriesAdjustment: TWideStringField
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'Adjustment'
      LookupDataSet = qryEmployeeSundries
      LookupKeyFields = 'SundryID'
      LookupResultField = 'Sundry'
      KeyFields = 'SundryID'
      Lookup = True
    end
    object qryPaySundriesAdjJob: TWideStringField
      DisplayLabel = 'Job'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AdjJob'
      LookupDataSet = qryJobs
      LookupKeyFields = 'ClientID'
      LookupResultField = 'Company'
      KeyFields = 'ClientID'
      Lookup = True
    end
    object qryPaySundriesAdjDept: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'AdjDept'
      LookupDataSet = qryDepartment
      LookupKeyFields = 'ClassID'
      LookupResultField = 'ClassName'
      KeyFields = 'ClassID'
      Lookup = True
    end
    object qryPaySundriesClientID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
      Visible = False
    end
    object qryPaySundriesClassID: TIntegerField
      DisplayLabel = 'Department'
      DisplayWidth = 10
      FieldName = 'ClassID'
      Visible = False
    end
    object qryPaySundriesPaySundryID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PaySundryID'
      Visible = False
    end
    object qryPaySundriesPayID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PayID'
      Visible = False
    end
    object qryPaySundriesSundryID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SundryID'
      Visible = False
    end
    object qryPaySundriesClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 255
    end
  end
  object qryEmployeeSundries: TERPQuery
    SQL.Strings = (
      
        'Select SundryID,EmployeeID,Sundry,Amount,GST,SuperInc,TaxExempt,' +
        'ClientID,ClassID'
      'FROM tblEmployeeSundries'
      'WHERE EmployeeID=:EmpID')
    Left = 815
    Top = 163
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmpID'
      end>
  end
  object qrySundryDesc: TERPQuery
    SQL.Strings = (
      'SELECT SundryID,SundryDesc From tblSundryTypes;')
    Left = 920
    Top = 370
  end
  object qryDepartment: TERPQuery
    SQL.Strings = (
      'Select ClassID, ClassName, Active'
      'FROM tblClass WHERE Active = "T"'
      'ORDER BY ClassName')
    Left = 870
    Top = 376
  end
  object qryPayCommissionLines: TERPQuery
    SQL.Strings = (
      'Select *'
      'From tblpayscommissionLines')
    MasterFields = 'PayCommissionID'
    DetailFields = 'PaycommissionID'
    Left = 486
    Top = 217
    object qryPayCommissionLinesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryPayCommissionLinesPayCommissionLineID: TIntegerField
      FieldName = 'PayCommissionLineID'
    end
    object qryPayCommissionLinesPaycommissionID: TIntegerField
      FieldName = 'PaycommissionID'
    end
    object qryPayCommissionLinesSalesCommissionId: TIntegerField
      FieldName = 'SalesCommissionId'
    end
    object qryPayCommissionLinesCommissionamount: TFloatField
      FieldName = 'Commissionamount'
    end
    object qryPayCommissionLinesDescription: TWideStringField
      FieldName = 'Description'
      Size = 100
    end
    object qryPayCommissionLinesmsTimestamp: TDateTimeField
      FieldName = 'msTimestamp'
    end
  end
  object qryTermination: TERPQuery
    SQL.Strings = (
      'select * from tblemployeeterminations')
    AfterOpen = qryTerminationAfterOpen
    Left = 720
    Top = 200
  end
end
