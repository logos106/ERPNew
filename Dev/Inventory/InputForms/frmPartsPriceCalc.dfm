inherited fmPartsPriceCalc: TfmPartsPriceCalc
  Left = 343
  Top = 515
  HelpContext = 1301002
  BorderStyle = bsNone
  Caption = 'Product Price Calculations'
  ClientHeight = 314
  ClientWidth = 1082
  Position = poMainFormCenter
  ExplicitLeft = 343
  ExplicitTop = 515
  ExplicitWidth = 1098
  ExplicitHeight = 353
  DesignSize = (
    1082
    314)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 314
    Width = 1082
    HelpContext = 1301003
    ExplicitTop = 304
    ExplicitWidth = 953
  end
  inherited shapehint: TShape
    Left = 11
    Pen.Color = 10197915
    ExplicitLeft = 12
  end
  inherited shapehintextra1: TShape
    Left = 61
    Pen.Color = 10197915
    ExplicitLeft = 55
  end
  object pnlMain: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 1082
    Height = 314
    HelpContext = 1301004
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    BorderStyle = bsSingle
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    object DNMPanel1: TDNMPanel
      Left = 75
      Top = 51
      Width = 1002
      Height = 215
      HelpContext = 1301005
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object pnlStandard: TDNMPanel
        Left = 894
        Top = 0
        Width = 108
        Height = 215
        HelpContext = 1301006
        Align = alLeft
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        TabOrder = 6
        VerticalAlignment = taAlignTop
        object lblStandard: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 100
          Height = 18
          HelpContext = 1301007
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Standard'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Shape33: TShape
          Left = 1
          Top = 25
          Width = 106
          Height = 1
          HelpContext = 1301008
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 2
          ExplicitTop = 21
        end
        object Shape34: TShape
          Left = 1
          Top = 57
          Width = 106
          Height = 1
          HelpContext = 1301009
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 2
          ExplicitTop = 48
          ExplicitWidth = 105
        end
        object Shape35: TShape
          Left = 1
          Top = 139
          Width = 106
          Height = 1
          HelpContext = 1301010
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -7
          ExplicitTop = 135
        end
        object Shape36: TShape
          Left = 1
          Top = 171
          Width = 106
          Height = 1
          HelpContext = 1301011
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 150
          ExplicitWidth = 105
        end
        object edtStandardCost: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 100
          Height = 23
          HelpContext = 1301012
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'COST1'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = edtStandardCostEnter
        end
        object edtOverheadAmountPrice: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 144
          Width = 100
          Height = 23
          HelpContext = 1301013
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'OverheadAmountPrice'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnEnter = edtStandardCostEnter
        end
        object edtOverheadAmount: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 112
          Width = 100
          Height = 23
          HelpContext = 1301014
          Margins.Bottom = 4
          Align = alTop
          DataField = 'OverheadAmount'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = optStandardModeChange
        end
        object chkStandardCost: TCheckBox
          AlignWithMargins = True
          Left = 23
          Top = 175
          Width = 62
          Height = 17
          HelpContext = 1301015
          Margins.Left = 22
          Margins.Right = 22
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Use ?'
          TabOrder = 4
          OnClick = OnUseSelect
        end
        object optStandardMode: TwwRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 61
          Width = 100
          Height = 45
          HelpContext = 1301016
          DisableThemes = False
          Frame.NonFocusBorders = [efTopBorder, efBottomBorder]
          ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ButtonFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ShowBorder = False
          Transparent = True
          Align = alTop
          DataField = 'StandardMode'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'Percentage'
            'Value')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'T'
            'F')
          OnChange = optStandardModeChange
        end
      end
      object pnlManAvgCost: TDNMPanel
        Left = 676
        Top = 0
        Width = 109
        Height = 215
        HelpContext = 1301017
        Align = alLeft
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        TabOrder = 4
        VerticalAlignment = taAlignTop
        object lblManAvgCost: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 101
          Height = 18
          HelpContext = 1301018
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Man. Avg. Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Shape29: TShape
          Left = 1
          Top = 25
          Width = 107
          Height = 1
          HelpContext = 1301019
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 2
          ExplicitTop = 18
        end
        object Shape30: TShape
          Left = 1
          Top = 57
          Width = 107
          Height = 1
          HelpContext = 1301020
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 2
          ExplicitTop = 48
          ExplicitWidth = 105
        end
        object Shape31: TShape
          Left = 1
          Top = 171
          Width = 107
          Height = 1
          HelpContext = 1301021
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 125
          ExplicitWidth = 109
        end
        object Shape32: TShape
          Left = 1
          Top = 139
          Width = 107
          Height = 1
          HelpContext = 1301022
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 132
        end
        object edtManAvgCost: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 101
          Height = 23
          HelpContext = 1301023
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'ManAvgCost'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = edtManAvgCostEnter
        end
        object optManAvgCostMargin: TwwRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 61
          Width = 101
          Height = 45
          HelpContext = 1301024
          DisableThemes = False
          Frame.NonFocusBorders = [efTopBorder, efBottomBorder]
          ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ButtonFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ShowBorder = False
          Transparent = True
          Align = alTop
          DataField = 'ManAverageCostGrossMarginMode'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'Markup'
            'Gr. Margin')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'T'
            'F')
          OnChange = optManAvgCostMarginChange
        end
        object edtManAvgCostPrice: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 144
          Width = 101
          Height = 23
          HelpContext = 1301025
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'ManAvgCostPrice'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnEnter = edtManAvgCostEnter
        end
        object chkManAvgCost: TCheckBox
          AlignWithMargins = True
          Left = 23
          Top = 175
          Width = 63
          Height = 17
          HelpContext = 1301026
          Margins.Left = 22
          Margins.Right = 22
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Use ?'
          TabOrder = 4
          OnClick = OnUseSelect
        end
        object edtManAverageCostGrossMarginAmount: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 112
          Width = 101
          Height = 23
          HelpContext = 1301027
          Margins.Bottom = 4
          Align = alTop
          DataField = 'ManAverageCostGrossMarginAmount'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = optManAvgCostMarginChange
        end
      end
      object pnlManLatestCost: TDNMPanel
        Left = 785
        Top = 0
        Width = 109
        Height = 215
        HelpContext = 1301028
        Align = alLeft
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        TabOrder = 5
        VerticalAlignment = taAlignTop
        object lblManLatestCost: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 101
          Height = 18
          HelpContext = 1301029
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Man. Latest Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Shape25: TShape
          Left = 1
          Top = 57
          Width = 107
          Height = 1
          HelpContext = 1301030
          Align = alTop
          Pen.Color = 10197915
          ExplicitTop = 22
          ExplicitWidth = 105
        end
        object Shape26: TShape
          Left = 1
          Top = 25
          Width = 107
          Height = 1
          HelpContext = 1301031
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 18
        end
        object Shape27: TShape
          Left = 1
          Top = 139
          Width = 107
          Height = 1
          HelpContext = 1301032
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -4
          ExplicitTop = 136
        end
        object Shape28: TShape
          Left = 1
          Top = 171
          Width = 107
          Height = 1
          HelpContext = 1301033
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 150
          ExplicitWidth = 105
        end
        object edtManLatestCost: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 101
          Height = 23
          HelpContext = 1301034
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'ManLatestCost'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = edtManLatestCostEnter
        end
        object optManLatestCostMargin: TwwRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 61
          Width = 101
          Height = 45
          HelpContext = 1301035
          DisableThemes = False
          Frame.NonFocusBorders = [efTopBorder, efBottomBorder]
          ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ButtonFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ShowBorder = False
          Transparent = True
          Align = alTop
          DataField = 'ManLastCostGrossMarginMode'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'Markup'
            'Gr. Margin')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'T'
            'F')
          OnChange = optManLatestCostMarginChange
        end
        object edtManLatestCostPrice: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 144
          Width = 101
          Height = 23
          HelpContext = 1301036
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'ManLatestCostPrice'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnEnter = edtManLatestCostEnter
        end
        object chkManLatestCost: TCheckBox
          AlignWithMargins = True
          Left = 23
          Top = 175
          Width = 63
          Height = 17
          HelpContext = 1301037
          Margins.Left = 22
          Margins.Right = 22
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Use ?'
          TabOrder = 4
          OnClick = OnUseSelect
        end
        object edtManLastCostGrossMarginAmount: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 112
          Width = 101
          Height = 23
          HelpContext = 1301038
          Margins.Bottom = 4
          Align = alTop
          DataField = 'ManLastCostGrossMarginAmount'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = optManLatestCostMarginChange
        end
      end
      object pnlMancostWithLabour: TDNMPanel
        Left = 567
        Top = 0
        Width = 109
        Height = 215
        HelpContext = 1301039
        Align = alLeft
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 3
        VerticalAlignment = taAlignTop
        object lblMancostWithLabour: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 101
          Height = 18
          HelpContext = 1301040
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Man. Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Shape21: TShape
          Left = 1
          Top = 25
          Width = 107
          Height = 1
          HelpContext = 1301041
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 22
        end
        object Shape22: TShape
          Left = 1
          Top = 57
          Width = 107
          Height = 1
          HelpContext = 1301042
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -3
          ExplicitTop = 54
        end
        object Shape23: TShape
          Left = 1
          Top = 139
          Width = 107
          Height = 1
          HelpContext = 1301043
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 136
        end
        object Shape24: TShape
          Left = 1
          Top = 171
          Width = 107
          Height = 1
          HelpContext = 1301044
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 135
        end
        object edtMancostWithLabour: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 101
          Height = 23
          HelpContext = 1301045
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'MancostWithLabour'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = edtMancostWithLabourEnter
        end
        object optMancostWithLabourMargin: TwwRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 61
          Width = 101
          Height = 45
          HelpContext = 1301046
          DisableThemes = False
          Frame.NonFocusBorders = [efTopBorder, efBottomBorder]
          ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ButtonFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ShowBorder = False
          Transparent = True
          Align = alTop
          DataField = 'ManCostGrossMarginMode'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'Markup'
            'Gr. Margin')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'T'
            'F')
          OnChange = optMancostWithLabourMarginChange
        end
        object edtMancostWithLabourPrice: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 144
          Width = 101
          Height = 23
          HelpContext = 1301047
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'MancostWithLabourPrice'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnEnter = edtMancostWithLabourEnter
        end
        object chkMancostWithLabour: TCheckBox
          AlignWithMargins = True
          Left = 23
          Top = 175
          Width = 63
          Height = 17
          HelpContext = 1301048
          Margins.Left = 22
          Margins.Right = 22
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Use ?'
          TabOrder = 4
          OnClick = OnUseSelect
        end
        object edtManCostGrossMarginAmount: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 112
          Width = 101
          Height = 23
          HelpContext = 1301049
          Margins.Bottom = 4
          Align = alTop
          DataField = 'ManCostGrossMarginAmount'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = optMancostWithLabourMarginChange
        end
      end
      object pnlLandedCost: TDNMPanel
        Left = 327
        Top = 0
        Width = 120
        Height = 215
        HelpContext = 1301050
        Align = alLeft
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        TabOrder = 2
        VerticalAlignment = taAlignTop
        object lblLandedCost: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 112
          Height = 18
          HelpContext = 1301051
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Landed Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Shape17: TShape
          Left = 1
          Top = 25
          Width = 118
          Height = 1
          HelpContext = 1301052
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -4
          ExplicitTop = 18
        end
        object Shape18: TShape
          Left = 1
          Top = 57
          Width = 118
          Height = 1
          HelpContext = 1301053
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 2
          ExplicitTop = 48
          ExplicitWidth = 105
        end
        object Shape19: TShape
          Left = 1
          Top = 139
          Width = 118
          Height = 1
          HelpContext = 1301054
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -4
          ExplicitTop = 135
        end
        object Shape20: TShape
          Left = 1
          Top = 171
          Width = 118
          Height = 1
          HelpContext = 1301055
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -4
          ExplicitTop = 125
          ExplicitWidth = 120
        end
        object edtLandedCost: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 112
          Height = 23
          HelpContext = 1301056
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'LandedCost'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = edtLandedcostEnter
        end
        object OptLandedCostMargin: TwwRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 61
          Width = 112
          Height = 45
          HelpContext = 1301057
          DisableThemes = False
          Frame.NonFocusBorders = [efTopBorder, efBottomBorder]
          ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ButtonFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ShowBorder = False
          Transparent = True
          Align = alTop
          DataField = 'LandedCostGrossMarginMode'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'Markup'
            'Gr. Margin')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'T'
            'F')
          OnChange = OptLandedCostMarginChange
        end
        object edtLandedCostPrice: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 144
          Width = 112
          Height = 23
          HelpContext = 1301058
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'LandedCostPrice'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnEnter = edtLandedcostEnter
        end
        object chkLandedCost: TCheckBox
          AlignWithMargins = True
          Left = 23
          Top = 175
          Width = 74
          Height = 17
          HelpContext = 1301059
          Margins.Left = 22
          Margins.Right = 22
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Use ?'
          TabOrder = 4
          OnClick = OnUseSelect
        end
        object edtLandedCostGrossMarginAmount: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 112
          Width = 112
          Height = 23
          HelpContext = 1301060
          Margins.Bottom = 4
          Align = alTop
          DataField = 'LandedCostGrossMarginAmount'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = OptLandedCostMarginChange
        end
      end
      object pnlAvgCost: TDNMPanel
        Left = 218
        Top = 0
        Width = 109
        Height = 215
        HelpContext = 1301061
        Align = alLeft
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        TabOrder = 1
        VerticalAlignment = taAlignTop
        object lblAvgCost: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 101
          Height = 18
          HelpContext = 1301062
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Average Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          WordWrap = True
        end
        object Shape13: TShape
          Left = 1
          Top = 25
          Width = 107
          Height = 1
          HelpContext = 1301063
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 18
        end
        object Shape14: TShape
          Left = 1
          Top = 57
          Width = 107
          Height = 1
          HelpContext = 1301064
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 2
          ExplicitTop = 48
          ExplicitWidth = 105
        end
        object Shape15: TShape
          Left = 1
          Top = 171
          Width = 107
          Height = 1
          HelpContext = 1301065
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 2
          ExplicitTop = 142
        end
        object Shape16: TShape
          Left = 1
          Top = 139
          Width = 107
          Height = 1
          HelpContext = 1301066
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 136
        end
        object edtAvgCost: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 101
          Height = 23
          HelpContext = 1301067
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'AvgCost'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = edtAvgCostEnter
        end
        object optAvgCostMargin: TwwRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 61
          Width = 101
          Height = 45
          HelpContext = 1301068
          DisableThemes = False
          Frame.NonFocusBorders = [efTopBorder, efBottomBorder]
          ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ButtonFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ShowBorder = False
          Transparent = True
          Align = alTop
          DataField = 'AverageCostGrossMarginMode'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'Markup'
            'Gr. Margin')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'T'
            'F')
          OnChange = optAvgCostMarginChange
        end
        object edtAvgCostPrice: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 144
          Width = 101
          Height = 23
          HelpContext = 1301069
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'AvgCostPrice'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnEnter = edtAvgCostEnter
        end
        object chkAvgCost: TCheckBox
          AlignWithMargins = True
          Left = 23
          Top = 175
          Width = 63
          Height = 17
          HelpContext = 1301070
          Margins.Left = 22
          Margins.Right = 22
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Use ?'
          TabOrder = 4
          OnClick = OnUseSelect
        end
        object edtAverageCostGrossMarginAmount: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 112
          Width = 101
          Height = 23
          HelpContext = 1301071
          Margins.Bottom = 4
          Align = alTop
          DataField = 'AverageCostGrossMarginAmount'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = optAvgCostMarginChange
        end
      end
      object pnlLatestCost: TDNMPanel
        Left = 109
        Top = 0
        Width = 109
        Height = 215
        HelpContext = 1301083
        Align = alLeft
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        TabOrder = 0
        VerticalAlignment = taAlignTop
        object lblLatestCost: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 101
          Height = 18
          HelpContext = 1301084
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Latest Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Shape1: TShape
          Left = 1
          Top = 139
          Width = 107
          Height = 1
          HelpContext = 1301085
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 5
          ExplicitTop = 135
        end
        object Shape2: TShape
          Left = 1
          Top = 57
          Width = 107
          Height = 1
          HelpContext = 1301086
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 5
          ExplicitTop = 28
        end
        object Shape3: TShape
          Left = 1
          Top = 171
          Width = 107
          Height = 1
          HelpContext = 1301087
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -4
          ExplicitTop = 130
          ExplicitWidth = 109
        end
        object Shape4: TShape
          Left = 1
          Top = 25
          Width = 107
          Height = 1
          HelpContext = 1301088
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 21
        end
        object edtLatestCost: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 101
          Height = 23
          Hint = 'Based on last purchase cost.'
          HelpContext = 1301089
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'LatestCost'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
          OnEnter = edtLatestCostEnter
        end
        object OptLatestCostMargin: TwwRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 61
          Width = 101
          Height = 45
          HelpContext = 1301090
          DisableThemes = False
          Frame.NonFocusBorders = [efTopBorder, efBottomBorder]
          ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ButtonFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ShowBorder = False
          Transparent = True
          Align = alTop
          DataField = 'LastCostGrossMarginMode'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'Markup'
            'Gr. Margin')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'T'
            'F')
          OnChange = OptLatestCostMarginChange
        end
        object edtLatestCostPrice: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 144
          Width = 101
          Height = 23
          HelpContext = 1301091
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'LatestCostPrice'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 2
          OnExit = edtLatestCostEnter
        end
        object chkLatestCost: TCheckBox
          AlignWithMargins = True
          Left = 23
          Top = 175
          Width = 63
          Height = 17
          HelpContext = 1301092
          Margins.Left = 22
          Margins.Right = 22
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Use ?'
          TabOrder = 4
          OnClick = OnUseSelect
        end
        object edtLastCostGrossMarginAmount: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 112
          Width = 101
          Height = 23
          HelpContext = 1301093
          Margins.Bottom = 4
          Align = alTop
          Color = clWhite
          DataField = 'LastCostGrossMarginAmount'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = OptLatestCostMarginChange
        end
      end
      object pnlTotalLandedCost: TDNMPanel
        Left = 447
        Top = 0
        Width = 120
        Height = 215
        HelpContext = 1301112
        Align = alLeft
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        TabOrder = 7
        VerticalAlignment = taAlignTop
        object lblTotalLandedCost: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 112
          Height = 18
          HelpContext = 1301113
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Total Landed Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Shape37: TShape
          Left = 1
          Top = 25
          Width = 118
          Height = 1
          HelpContext = 1301114
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -4
          ExplicitTop = 18
        end
        object Shape38: TShape
          Left = 1
          Top = 57
          Width = 118
          Height = 1
          HelpContext = 1301115
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 2
          ExplicitTop = 48
          ExplicitWidth = 105
        end
        object Shape39: TShape
          Left = 1
          Top = 139
          Width = 118
          Height = 1
          HelpContext = 1301116
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -4
          ExplicitTop = 135
        end
        object Shape40: TShape
          Left = 1
          Top = 171
          Width = 118
          Height = 1
          HelpContext = 1301117
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -4
          ExplicitTop = 125
          ExplicitWidth = 120
        end
        object edtTotalLandedCost: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 112
          Height = 23
          HelpContext = 1301118
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'TotalLandedcost'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = edtTotalLandedcostEnter
        end
        object OpttotalLandedCostMargin: TwwRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 61
          Width = 112
          Height = 45
          HelpContext = 1301119
          DisableThemes = False
          Frame.NonFocusBorders = [efTopBorder, efBottomBorder]
          ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ButtonFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ShowBorder = False
          Transparent = True
          Align = alTop
          DataField = 'TotalLandedcostGrossMarginMode'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'Markup'
            'Gr. Margin')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'T'
            'F')
          OnChange = OpttotalLandedCostMarginChange
        end
        object edttotalLandedCostPrice: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 144
          Width = 112
          Height = 23
          HelpContext = 1301120
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'TotalLandedcostPrice'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnEnter = edtTotalLandedcostEnter
        end
        object chkTotalLandedCost: TCheckBox
          AlignWithMargins = True
          Left = 23
          Top = 175
          Width = 74
          Height = 17
          HelpContext = 1301121
          Margins.Left = 22
          Margins.Right = 22
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Use ?'
          TabOrder = 4
          OnClick = OnUseSelect
        end
        object edtTotalLandedCostGrossMarginAmount: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 112
          Width = 112
          Height = 23
          HelpContext = 1301122
          Margins.Bottom = 4
          Align = alTop
          DataField = 'TotalLandedcostGrossMarginAmount'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = OpttotalLandedCostMarginChange
        end
      end
      object pnlCostPriceInc: TDNMPanel
        Left = 0
        Top = 0
        Width = 109
        Height = 215
        HelpContext = 1301072
        Align = alLeft
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentColor = True
        ParentFont = False
        TabOrder = 8
        VerticalAlignment = taAlignTop
        object lblCostPriceInc: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 101
          Height = 18
          HelpContext = 1301073
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'Product Cost'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Shape9: TShape
          Left = 1
          Top = 108
          Width = 107
          Height = 1
          HelpContext = 1301074
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 3
          ExplicitTop = 27
        end
        object Shape10: TShape
          Left = 1
          Top = 25
          Width = 107
          Height = 1
          HelpContext = 1301075
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 3
          ExplicitTop = 21
        end
        object Shape11: TShape
          Left = 1
          Top = 171
          Width = 107
          Height = 1
          HelpContext = 1301076
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = -4
          ExplicitTop = 121
          ExplicitWidth = 109
        end
        object Shape12: TShape
          Left = 1
          Top = 139
          Width = 107
          Height = 1
          HelpContext = 1301077
          Align = alTop
          Pen.Color = 10197915
          ExplicitLeft = 0
          ExplicitTop = 136
        end
        object edtCostPriceInc: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 30
          Width = 101
          Height = 23
          HelpContext = 1301078
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'COST1'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          OnEnter = edtCostPriceIncEnter
        end
        object OptCostPriceIncMargin: TwwRadioGroup
          AlignWithMargins = True
          Left = 4
          Top = 60
          Width = 101
          Height = 45
          HelpContext = 1301079
          DisableThemes = False
          Frame.NonFocusBorders = [efTopBorder, efBottomBorder]
          ButtonFrame.FocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ButtonFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
          ShowBorder = False
          Transparent = True
          Align = alTop
          DataField = 'ProductCostGrossMarginMode'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          Items.Strings = (
            'Markup'
            'Gr. Margin')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'T'
            'F')
          OnChange = OptCostPriceIncMarginChange
        end
        object edtCOST1Price: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 144
          Width = 101
          Height = 23
          HelpContext = 1301080
          Margins.Top = 4
          Margins.Bottom = 4
          TabStop = False
          Align = alTop
          DataField = 'COST1Price'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          OnEnter = edtCostPriceIncEnter
        end
        object chkCostPriceInc: TCheckBox
          AlignWithMargins = True
          Left = 23
          Top = 175
          Width = 63
          Height = 17
          HelpContext = 1301081
          Margins.Left = 22
          Margins.Right = 22
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Use ?'
          TabOrder = 4
          OnClick = OnUseSelect
        end
        object edtProductCostGrossMarginAmount: TDBEdit
          AlignWithMargins = True
          Left = 4
          Top = 112
          Width = 101
          Height = 23
          HelpContext = 1301082
          Margins.Bottom = 4
          Align = alTop
          DataField = 'ProductCostGrossMarginAmount'
          DataSource = dsPartsPriceCalc
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = OptCostPriceIncMarginChange
        end
      end
    end
    object pnlLeft: TDNMPanel
      Left = 1
      Top = 51
      Width = 74
      Height = 215
      HelpContext = 1301094
      Align = alLeft
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      object lblCost: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 29
        Width = 68
        Height = 25
        HelpContext = 1301095
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = '$'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object lblMargin: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 61
        Width = 68
        Height = 47
        HelpContext = 1301096
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Markup / Margin'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object lblPrice: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 143
        Width = 68
        Height = 25
        HelpContext = 1301097
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Price'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object lblItems: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 68
        Height = 19
        HelpContext = 1301098
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
      end
      object lblMarginAmt: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 114
        Width = 68
        Height = 22
        HelpContext = 1301099
        Align = alTop
        Alignment = taRightJustify
        AutoSize = False
        Caption = ' % Cost/Sell'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
      end
      object Shape5: TShape
        Left = 0
        Top = 25
        Width = 74
        Height = 1
        HelpContext = 1301100
        Align = alTop
        Pen.Color = 10197915
        ExplicitTop = 22
      end
      object Shape6: TShape
        Left = 0
        Top = 139
        Width = 74
        Height = 1
        HelpContext = 1301101
        Align = alTop
        Pen.Color = 10197915
        ExplicitLeft = -2
        ExplicitTop = 136
      end
      object Shape8: TShape
        Left = 0
        Top = 171
        Width = 74
        Height = 1
        HelpContext = 1301102
        Align = alTop
        Pen.Color = 10197915
        ExplicitLeft = -2
        ExplicitTop = 136
      end
      object Shape7: TShape
        Left = 0
        Top = 57
        Width = 74
        Height = 1
        HelpContext = 1301103
        Align = alTop
        Pen.Color = 10197915
        ExplicitTop = 45
        ExplicitWidth = 79
      end
    end
    object DNMPanel3: TDNMPanel
      Left = 1
      Top = 1
      Width = 1076
      Height = 50
      HelpContext = 1301104
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        1076
        50)
      object pnlTitle: TDNMPanel
        Left = 249
        Top = 3
        Width = 577
        Height = 44
        HelpContext = 1301105
        Anchors = []
        BevelInner = bvRaised
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object TitleShader: TShader
          Left = 2
          Top = 2
          Width = 573
          Height = 40
          HelpContext = 1301106
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
            Width = 573
            Height = 40
            HelpContext = 1301107
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Product Price Calculating Options'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -29
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
            ExplicitTop = -1
            ExplicitWidth = 382
            ExplicitHeight = 31
          end
        end
      end
    end
    object DNMPanel4: TDNMPanel
      Left = 1
      Top = 266
      Width = 1076
      Height = 43
      HelpContext = 1301108
      Margins.Left = 2
      Margins.Top = 0
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        1076
        43)
      object lblMsg: TLabel
        Left = 0
        Top = 0
        Width = 1076
        Height = 13
        HelpContext = 1301109
        Align = alTop
        Alignment = taCenter
        Caption = 'lblMsg'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlBottom
        Visible = False
        WordWrap = True
        ExplicitWidth = 37
      end
      object btnCompleted: TDNMSpeedButton
        Left = 425
        Top = 13
        Width = 87
        Height = 27
        HelpContext = 1301110
        Anchors = [akBottom]
        Caption = '&Save'
        Default = True
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
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ModalResult = 1
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 0
        OnClick = btnCompletedClick
      end
      object btnClose: TDNMSpeedButton
        Left = 564
        Top = 14
        Width = 87
        Height = 27
        HelpContext = 1301111
        Anchors = [akBottom]
        Cancel = True
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
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        ModalResult = 2
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        OnClick = btnCloseClick
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 412
    Top = 250
  end
  inherited tmrdelay: TTimer
    Left = 448
    Top = 250
  end
  inherited popSpelling: TPopupMenu
    Left = 125
    Top = 250
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 233
    Top = 250
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 268
    Top = 250
  end
  inherited MyConnection: TERPConnection
    Server = 'localhost'
    Left = 90
    Top = 190
  end
  inherited DataState: TDataState
    Left = 304
    Top = 250
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 161
    Top = 250
  end
  inherited imgsort: TImageList
    Left = 340
    Top = 250
    Bitmap = {
      494C01010200B401000210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 18
    Top = 250
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 376
    Top = 250
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 197
    Top = 250
  end
  inherited qryMemTrans: TERPQuery
    Left = 53
    Top = 250
  end
  object qryPartsPriceCalc: TERPQuery
    Connection = frmParts.MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblPartsPriceCalc'
      'Where PARTSID = :PARTSID')
    Left = 89
    Top = 250
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PARTSID'
        Value = 135
      end>
    object qryPartsPriceCalcPartsID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PartsID'
      Origin = 'tblpartspricecalc.PartsID'
    end
    object qryPartsPriceCalcProductPriceCalctype: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductPriceCalctype'
      Origin = 'tblpartspricecalc.ProductPriceCalctype'
    end
    object qryPartsPriceCalcLatestCost: TFloatField
      FieldKind = fkLookup
      FieldName = 'LatestCost'
      LookupDataSet = frmParts.qryProduct
      LookupKeyFields = 'PARTSID'
      LookupResultField = 'LatestCost'
      KeyFields = 'PartsID'
      currency = True
      Lookup = True
    end
    object qryPartsPriceCalcLatestCostPrice: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'LatestCostPrice'
      currency = True
      Calculated = True
    end
    object qryPartsPriceCalcLastCostGrossMarginMode: TWideStringField
      DisplayWidth = 1
      FieldName = 'LastCostGrossMarginMode'
      Origin = 'tblpartspricecalc.LastCostGrossMarginMode'
      FixedChar = True
      Size = 1
    end
    object qryPartsPriceCalcLastCostGrossMarginAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'LastCostGrossMarginAmount'
      Origin = 'tblpartspricecalc.LastCostGrossMarginAmount'
      DisplayFormat = '##00.00%'
    end
    object qryPartsPriceCalcCOST1: TFloatField
      FieldKind = fkLookup
      FieldName = 'COST1'
      LookupDataSet = frmParts.qryProduct
      LookupKeyFields = 'PARTSID'
      LookupResultField = 'COST1'
      KeyFields = 'PartsID'
      currency = True
      Lookup = True
    end
    object qryPartsPriceCalcAvgCost: TFloatField
      FieldKind = fkLookup
      FieldName = 'AvgCost'
      LookupDataSet = frmParts.qryProduct
      LookupKeyFields = 'PARTSID'
      LookupResultField = 'AvgCost'
      KeyFields = 'PartsID'
      currency = True
      Lookup = True
    end
    object qryPartsPriceCalcLandedCost: TFloatField
      FieldKind = fkLookup
      FieldName = 'LandedCost'
      LookupDataSet = frmParts.qryProduct
      LookupKeyFields = 'PARTSID'
      LookupResultField = 'LandedCost'
      KeyFields = 'PartsID'
      currency = True
      Lookup = True
    end
    object qryPartsPriceCalcTotalLandedcost: TFloatField
      FieldKind = fkLookup
      FieldName = 'TotalLandedcost'
      LookupDataSet = frmParts.qryProduct
      LookupKeyFields = 'PARTSID'
      LookupResultField = 'TotalLandedcost'
      KeyFields = 'PartsID'
      currency = True
      Lookup = True
    end
    object qryPartsPriceCalcMancostWithLabour: TFloatField
      FieldKind = fkLookup
      FieldName = 'MancostWithLabour'
      LookupDataSet = frmParts.qryProduct
      LookupKeyFields = 'PARTSID'
      LookupResultField = 'MancostWithLabour'
      KeyFields = 'PartsID'
      currency = True
      Lookup = True
    end
    object qryPartsPriceCalcManLatestCost: TFloatField
      FieldKind = fkLookup
      FieldName = 'ManLatestCost'
      LookupDataSet = frmParts.qryProduct
      LookupKeyFields = 'PARTSID'
      LookupResultField = 'ManLatestCost'
      KeyFields = 'PartsID'
      currency = True
      Lookup = True
    end
    object qryPartsPriceCalcManAvgCost: TFloatField
      FieldKind = fkLookup
      FieldName = 'ManAvgCost'
      LookupDataSet = frmParts.qryProduct
      LookupKeyFields = 'PARTSID'
      LookupResultField = 'ManAvgCost'
      KeyFields = 'PartsID'
      currency = True
      Lookup = True
    end
    object qryPartsPriceCalcCOST1Price: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'COST1Price'
      currency = True
      Calculated = True
    end
    object qryPartsPriceCalcProductCostGrossMarginMode: TWideStringField
      DisplayWidth = 1
      FieldName = 'ProductCostGrossMarginMode'
      Origin = 'tblpartspricecalc.ProductCostGrossMarginMode'
      FixedChar = True
      Size = 1
    end
    object qryPartsPriceCalcProductCostGrossMarginAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'ProductCostGrossMarginAmount'
      Origin = 'tblpartspricecalc.ProductCostGrossMarginAmount'
      DisplayFormat = '##00.00%'
    end
    object qryPartsPriceCalcAvgCostPrice: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'AvgCostPrice'
      currency = True
      Calculated = True
    end
    object qryPartsPriceCalcAverageCostGrossMarginMode: TWideStringField
      DisplayWidth = 1
      FieldName = 'AverageCostGrossMarginMode'
      Origin = 'tblpartspricecalc.AverageCostGrossMarginMode'
      FixedChar = True
      Size = 1
    end
    object qryPartsPriceCalcAverageCostGrossMarginAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'AverageCostGrossMarginAmount'
      Origin = 'tblpartspricecalc.AverageCostGrossMarginAmount'
      DisplayFormat = '##00.00%'
    end
    object qryPartsPriceCalcLandedCostPrice: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'LandedCostPrice'
      currency = True
      Calculated = True
    end
    object qryPartsPriceCalcTotalLandedcostPrice: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalLandedcostPrice'
      currency = True
      Calculated = True
    end
    object qryPartsPriceCalcLandedCostGrossMarginMode: TWideStringField
      DisplayWidth = 1
      FieldName = 'LandedCostGrossMarginMode'
      Origin = 'tblpartspricecalc.LandedCostGrossMarginMode'
      FixedChar = True
      Size = 1
    end
    object qryPartsPriceCalcTotalLandedcostGrossMarginMode: TWideStringField
      DisplayWidth = 1
      FieldName = 'TotalLandedcostGrossMarginMode'
      Origin = 'tblpartspricecalc.TotalLandedcostGrossMarginMode'
      FixedChar = True
      Size = 1
    end
    object qryPartsPriceCalcLandedCostGrossMarginAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'LandedCostGrossMarginAmount'
      Origin = 'tblpartspricecalc.LandedCostGrossMarginAmount'
      DisplayFormat = '##00.00%'
    end
    object qryPartsPriceCalcTotalLandedcostGrossMarginAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalLandedcostGrossMarginAmount'
      Origin = 'tblpartspricecalc.TotalLandedcostGrossMarginAmount'
      DisplayFormat = '##00.00%'
    end
    object qryPartsPriceCalcMancostWithLabourPrice: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'MancostWithLabourPrice'
      currency = True
      Calculated = True
    end
    object qryPartsPriceCalcManCostGrossMarginMode: TWideStringField
      DisplayWidth = 1
      FieldName = 'ManCostGrossMarginMode'
      Origin = 'tblpartspricecalc.ManCostGrossMarginMode'
      FixedChar = True
      Size = 1
    end
    object qryPartsPriceCalcManCostGrossMarginAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'ManCostGrossMarginAmount'
      Origin = 'tblpartspricecalc.ManCostGrossMarginAmount'
      DisplayFormat = '##00.00%'
    end
    object qryPartsPriceCalcManAvgCostPrice: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ManAvgCostPrice'
      currency = True
      Calculated = True
    end
    object qryPartsPriceCalcManAverageCostGrossMarginMode: TWideStringField
      DisplayWidth = 1
      FieldName = 'ManAverageCostGrossMarginMode'
      Origin = 'tblpartspricecalc.ManAverageCostGrossMarginMode'
      FixedChar = True
      Size = 1
    end
    object qryPartsPriceCalcManAverageCostGrossMarginAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'ManAverageCostGrossMarginAmount'
      Origin = 'tblpartspricecalc.ManAverageCostGrossMarginAmount'
      DisplayFormat = '##00.00%'
    end
    object qryPartsPriceCalcManLatestCostPrice: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'ManLatestCostPrice'
      currency = True
      Calculated = True
    end
    object qryPartsPriceCalcManLastCostGrossMarginMode: TWideStringField
      DisplayWidth = 1
      FieldName = 'ManLastCostGrossMarginMode'
      Origin = 'tblpartspricecalc.ManLastCostGrossMarginMode'
      FixedChar = True
      Size = 1
    end
    object qryPartsPriceCalcManLastCostGrossMarginAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'ManLastCostGrossMarginAmount'
      Origin = 'tblpartspricecalc.ManLastCostGrossMarginAmount'
      DisplayFormat = '##00.00%'
    end
    object qryPartsPriceCalcOverheadAmountPrice: TFloatField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'OverheadAmountPrice'
      currency = True
      Calculated = True
    end
    object qryPartsPriceCalcOverheadAmount: TFloatField
      DisplayWidth = 10
      FieldName = 'OverheadAmount'
      Origin = 'tblpartspricecalc.OverheadAmount'
      DisplayFormat = '##00.00%'
    end
    object qryPartsPriceCalcStandardMode: TWideStringField
      DisplayWidth = 1
      FieldName = 'StandardMode'
      Origin = 'tblpartspricecalc.StandardMode'
      FixedChar = True
      Size = 1
    end
    object qryPartsPriceCalcID: TIntegerField
      FieldName = 'ID'
    end
    object qryPartsPriceCalcGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryPartsPriceCalcmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryPartsPriceCalcmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object dsPartsPriceCalc: TDataSource
    DataSet = qryPartsPriceCalc
    Left = 161
    Top = 190
  end
end
