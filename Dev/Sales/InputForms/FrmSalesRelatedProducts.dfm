inherited FmSalesRelatedProducts: TFmSalesRelatedProducts
  Left = 315
  Top = 211
  Caption = 'Sales Related Products'
  ClientHeight = 381
  ClientWidth = 1003
  Position = poMainFormCenter
  ExplicitLeft = 315
  ExplicitTop = 211
  ExplicitWidth = 1019
  ExplicitHeight = 420
  DesignSize = (
    1003
    381)
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1664002
  inherited lblSkingroupMsg: TLabel
    Top = 331
    Width = 1003
    ExplicitTop = 482
    ExplicitWidth = 638
    HelpContext = 1664003
  end
  inherited shapehint: TShape
    Left = 9
    ExplicitLeft = 9
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 30
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 1003
    Height = 59
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      1003
      59)
    HelpContext = 1664004
    object pnlTitle: TDNMPanel
      Left = 291
      Top = 10
      Width = 422
      Height = 39
      HelpContext = 1664005
      Anchors = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 420
        Height = 37
        HelpContext = 1664006
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
          Width = 420
          Height = 37
          HelpContext = 1664007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sales Related Products'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 5
        end
      end
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 331
    Width = 1003
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      1003
      50)
    HelpContext = 1664008
    object cmdClose: TDNMSpeedButton
      Left = 283
      Top = 11
      Width = 93
      Height = 29
      HelpContext = 1664009
      Anchors = []
      Caption = '&Save'
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object cmdCancel: TDNMSpeedButton
      Left = 618
      Top = 6
      Width = 93
      Height = 29
      HelpContext = 1664010
      Anchors = []
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
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = cmdCancelClick
    end
    object chkshowList: TCheckBox
      AlignWithMargins = True
      Left = 891
      Top = 4
      Width = 100
      Height = 42
      Margins.Left = 866
      Margins.Right = 11
      Align = alRight
      Alignment = taLeftJustify
      Caption = 'Show as List'
      TabOrder = 2
      OnClick = chkshowListClick
      HelpContext = 1664011
    end
  end
  object TABCTL20: TPageControl [7]
    Left = 0
    Top = 59
    Width = 1003
    Height = 272
    HelpContext = 1664012
    ActivePage = TabMain
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabHeight = 25
    TabOrder = 2
    TabWidth = 66
    ExplicitLeft = 9
    ExplicitTop = 2
    ExplicitWidth = 872
    ExplicitHeight = 250
    object TabMain: TTabSheet
      HelpContext = 1664013
      Caption = 'Main'
      ImageIndex = 15
      ExplicitLeft = 8
      ExplicitTop = 34
      ExplicitWidth = 0
      ExplicitHeight = 215
      object pnlTab: TDNMPanel
        Left = 0
        Top = 0
        Width = 995
        Height = 237
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ExplicitTop = 2
        HelpContext = 1664014
        object Label6: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 8
          Width = 116
          Height = 15
          Margins.Top = 7
          Caption = 'CONFIGURING ITEM : '
          HelpContext = 1664015
        end
        object Label7: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 33
          Width = 129
          Height = 15
          Margins.Top = 7
          Margins.Right = 888
          Caption = 'GENERAL PROPERTIES'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          HelpContext = 1664016
        end
        object Label8: TLabel
          Left = 57
          Top = 68
          Width = 56
          Height = 15
          Alignment = taRightJustify
          Caption = 'Quantity : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664017
        end
        object Label9: TLabel
          Left = 46
          Top = 107
          Width = 67
          Height = 15
          Alignment = taRightJustify
          Caption = 'Form Type : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664018
        end
        object Label10: TLabel
          Left = 50
          Top = 146
          Width = 63
          Height = 15
          Alignment = taRightJustify
          Caption = 'Prod Line : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664019
        end
        object Label11: TLabel
          Left = 415
          Top = 8
          Width = 70
          Height = 15
          Alignment = taRightJustify
          Caption = 'Dimensions '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Transparent = True
          HelpContext = 1664020
        end
        object lblFormula1: TLabel
          Left = 415
          Top = 35
          Width = 63
          Height = 15
          Caption = 'Prod Line : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664021
        end
        object lblFormula2: TLabel
          Left = 501
          Top = 35
          Width = 63
          Height = 15
          Caption = 'Prod Line : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664022
        end
        object lblFormula3: TLabel
          Left = 588
          Top = 35
          Width = 63
          Height = 15
          Caption = 'Prod Line : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664023
        end
        object lblFormula5: TLabel
          Left = 761
          Top = 35
          Width = 63
          Height = 15
          Caption = 'Prod Line : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664024
        end
        object lblFormula4: TLabel
          Left = 674
          Top = 35
          Width = 63
          Height = 15
          Caption = 'Prod Line : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664025
        end
        object Label16: TLabel
          Left = 400
          Top = 94
          Width = 25
          Height = 15
          Alignment = taRightJustify
          Caption = 'Cut :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664026
        end
        object Label17: TLabel
          Left = 29
          Top = 186
          Width = 84
          Height = 15
          Alignment = taRightJustify
          Caption = 'Pattern Name :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664027
        end
        object Label18: TLabel
          Left = 400
          Top = 145
          Width = 71
          Height = 15
          Alignment = taRightJustify
          Caption = 'Description :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664028
        end
        object Label1: TLabel
          Left = 659
          Top = 94
          Width = 68
          Height = 15
          Caption = 'Formula Qty'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664029
        end
        object lblrelUnitofMeasureShipped: TLabel
          Left = 763
          Top = 94
          Width = 49
          Height = 15
          Caption = 'Total Qty'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664030
        end
        object Shape1: TShape
          AlignWithMargins = True
          Left = 339
          Top = 0
          Width = 1
          Height = 250
          Brush.Style = bsClear
          Pen.Color = clGray
          HelpContext = 1664031
        end
        object Shape2: TShape
          Left = 400
          Top = 30
          Width = 457
          Height = 53
          Brush.Style = bsClear
          Pen.Color = clGray
          HelpContext = 1664032
        end
        object Label5: TLabel
          Left = 556
          Top = 94
          Width = 63
          Height = 15
          Caption = 'Related qty'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          HelpContext = 1664033
        end
        object wwDBEdit7: TwwDBEdit
          Left = 129
          Top = 142
          Width = 121
          Height = 23
          DataField = 'RelatedProductProdLine'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664034
        end
        object edtFormula1: TwwDBEdit
          Left = 415
          Top = 51
          Width = 63
          Height = 23
          DataField = 'FormulaQtyShippedValue1'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664035
        end
        object edtFormula2: TwwDBEdit
          Left = 501
          Top = 51
          Width = 63
          Height = 23
          DataField = 'FormulaQtyShippedValue2'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664036
        end
        object edtFormula3: TwwDBEdit
          Left = 588
          Top = 51
          Width = 63
          Height = 23
          DataField = 'FormulaQtyShippedValue3'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664037
        end
        object edtFormula5: TwwDBEdit
          Left = 761
          Top = 51
          Width = 63
          Height = 23
          DataField = 'FormulaQtyShippedValue5'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664038
        end
        object edtFormula4: TwwDBEdit
          Left = 674
          Top = 51
          Width = 63
          Height = 23
          DataField = 'FormulaQtyShippedValue4'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664039
        end
        object wwDBEdit13: TwwDBEdit
          Left = 129
          Top = 182
          Width = 192
          Height = 23
          DataField = 'RelatedProductPatternName'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664040
        end
        object txtComments: TDBMemo
          Left = 400
          Top = 162
          Width = 327
          Height = 67
          Hint = '"Type In A Comment For The Warehouse"'
          DataField = 'RelatedProductFormulaDescription'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ScrollBars = ssVertical
          ShowHint = True
          TabOrder = 11
          HelpContext = 1664041
        end
        object navPartPic: TwwDBNavigator
          AlignWithMargins = True
          Left = 124
          Top = 207
          Width = 100
          Height = 25
          HelpContext = 1664042
          Margins.Left = 850
          Margins.Bottom = 99
          DataSource = dsSalesObj
          Layout = nlVertical
          ShowHint = True
          RepeatInterval.InitialDelay = 500
          RepeatInterval.Interval = 100
          ParentShowHint = False
          Transparent = True
          object navPartPicFirst: TwwNavButton
            Left = 0
            Top = 0
            Width = 25
            Height = 25
            Hint = 'Move to first record'
            HelpContext = 1664043
            ImageIndex = -1
            NumGlyphs = 2
            Spacing = 4
            Transparent = False
            Caption = 'navPartPicFirst'
            Enabled = False
            DisabledTextColors.ShadeColor = clGray
            DisabledTextColors.HighlightColor = clBtnHighlight
            Index = 0
            Style = nbsFirst
          end
          object navPartPicPrior: TwwNavButton
            Left = 25
            Top = 0
            Width = 25
            Height = 25
            Hint = 'Move to prior record'
            HelpContext = 1664044
            ImageIndex = -1
            NumGlyphs = 2
            Spacing = 4
            Transparent = False
            Caption = 'navPartPicPrior'
            Enabled = False
            DisabledTextColors.ShadeColor = clGray
            DisabledTextColors.HighlightColor = clBtnHighlight
            Index = 1
            Style = nbsPrior
          end
          object navPartPicNext: TwwNavButton
            Left = 50
            Top = 0
            Width = 25
            Height = 25
            Hint = 'Move to next record'
            HelpContext = 1664045
            ImageIndex = -1
            NumGlyphs = 2
            Spacing = 4
            Transparent = False
            Caption = 'navPartPicNext'
            Enabled = False
            DisabledTextColors.ShadeColor = clGray
            DisabledTextColors.HighlightColor = clBtnHighlight
            Index = 2
            Style = nbsNext
          end
          object navPartPicLast: TwwNavButton
            Left = 75
            Top = 0
            Width = 25
            Height = 25
            Hint = 'Move to last record'
            HelpContext = 1664046
            ImageIndex = -1
            NumGlyphs = 2
            Spacing = 4
            Transparent = False
            Caption = 'navPartPicLast'
            Enabled = False
            DisabledTextColors.ShadeColor = clGray
            DisabledTextColors.HighlightColor = clBtnHighlight
            Index = 3
            Style = nbsLast
          end
        end
        object cboProductformula: TwwDBLookupCombo
          Left = 400
          Top = 110
          Width = 150
          Height = 23
          HelpContext = 1664047
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'FormulaName'#9'25'#9'Name'#9'F')
          DataField = 'formulaID'
          DataSource = dsSalesObj
          LookupTable = qryProductformula
          LookupField = 'FormulaID'
          ParentFont = False
          TabOrder = 10
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = True
        end
        object btnChangeProduct: TDNMSpeedButton
          Left = 256
          Top = 104
          Width = 65
          Height = 23
          Caption = 'Change'
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          TabOrder = 2
          AutoDisableParentOnclick = True
          OnClick = btnChangeProductClick
          HelpContext = 1664048
        end
        object edtProductName: TwwDBEdit
          Left = 129
          Top = 103
          Width = 121
          Height = 23
          TabStop = False
          DataField = 'ProductName'
          DataSource = dsSalesObj
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
          HelpContext = 1664049
        end
        object edtUnitofMeasureShipped: TEdit
          Left = 129
          Top = 64
          Width = 121
          Height = 23
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = 'edtUnitofMeasureShipped'
          OnExit = edtUnitofMeasureShippedExit
          OnKeyDown = edtUnitofMeasureShippedKeyDown
          HelpContext = 1664050
        end
        object wwDBEdit2: TwwDBEdit
          Left = 659
          Top = 110
          Width = 94
          Height = 23
          TabStop = False
          DataField = 'FormulaQtyShippedValue'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 13
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664051
        end
        object grpDescription: TwwRadioGroup
          Left = 733
          Top = 145
          Width = 124
          Height = 84
          DisableThemes = False
          Caption = 'For Description'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Use Formula'
            'Use Dimension')
          ParentFont = False
          TabOrder = 14
          OnClick = grpDescriptionClick
          HelpContext = 1664052
        end
        object pnlTotals: TDNMPanel
          Left = 863
          Top = 1
          Width = 131
          Height = 235
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 15
          HelpContext = 1664053
          object Shape3: TShape
            AlignWithMargins = True
            Left = 4
            Top = 96
            Width = 123
            Height = 2
            Align = alTop
            Brush.Style = bsClear
            Pen.Color = clGray
            HelpContext = 1664054
          end
          object DBEdit1: TDBEdit
            Left = 1
            Top = 170
            Width = 129
            Height = 23
            Align = alTop
            DataField = 'TotalLineAmountInc'
            DataSource = dsSalesObj
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            HelpContext = 1664055
          end
          object DBEdit2: TDBEdit
            Left = 1
            Top = 124
            Width = 129
            Height = 23
            Align = alTop
            DataField = 'ProductName'
            DataSource = dsSalesObj
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            HelpContext = 1664056
          end
          object DBEdit3: TDBEdit
            Left = 1
            Top = 101
            Width = 129
            Height = 23
            Align = alTop
            DataField = 'SaleLineId'
            DataSource = dsSalesObj
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            HelpContext = 1664057
          end
          object DBEdit4: TDBEdit
            Left = 1
            Top = 70
            Width = 129
            Height = 23
            Align = alTop
            DataField = 'TotalLineAmountInc'
            DataSource = DSDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            HelpContext = 1664058
          end
          object DBEdit5: TDBEdit
            Left = 1
            Top = 24
            Width = 129
            Height = 23
            Align = alTop
            DataField = 'ProductName'
            DataSource = DSDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            HelpContext = 1664059
          end
          object DBEdit6: TDBEdit
            Left = 1
            Top = 1
            Width = 129
            Height = 23
            Align = alTop
            DataField = 'SaleLineID'
            DataSource = DSDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            HelpContext = 1664060
          end
          object DBEdit7: TDBEdit
            Left = 1
            Top = 47
            Width = 129
            Height = 23
            Align = alTop
            DataField = 'LinePriceInc'
            DataSource = DSDetails
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            HelpContext = 1664061
          end
          object DBEdit8: TDBEdit
            Left = 1
            Top = 147
            Width = 129
            Height = 23
            Align = alTop
            DataField = 'LinePriceInc'
            DataSource = dsSalesObj
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            HelpContext = 1664062
          end
        end
        object wwDBEdit1: TwwDBEdit
          Left = 556
          Top = 110
          Width = 94
          Height = 23
          TabStop = False
          DataField = 'RelatedProductQty'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 16
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664063
        end
        object edtmainProductname: TwwDBEdit
          Left = 136
          Top = 4
          Width = 197
          Height = 23
          DataField = 'Productname'
          DataSource = DSDetails
          ReadOnly = True
          TabOrder = 17
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664064
        end
        object edtrelUnitofMeasureShipped: TwwDBEdit
          Left = 763
          Top = 110
          Width = 94
          Height = 23
          TabStop = False
          DataField = 'UnitofMeasureShipped'
          DataSource = dsSalesObj
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 18
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 1664065
        end
        object DNMSpeedButton1: TDNMSpeedButton
          Left = 256
          Top = 208
          Width = 65
          Height = 23
          Hint = 'Add New Related Product'
          HelpContext = 1664066
          Caption = 'Add New'
          Default = True
          DisableTransparent = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = []
          ParentFont = False
          TabOrder = 19
          AutoDisableParentOnclick = True
          OnClick = DNMSpeedButton1Click
        end
      end
    end
    object tabFollowupnProducts: TTabSheet
      HelpContext = 1664067
      Caption = 'Products'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 864
      ExplicitHeight = 215
      object pnlGrid: TDNMPanel
        Left = 0
        Top = 0
        Width = 995
        Height = 237
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 873
        ExplicitTop = 1
        ExplicitWidth = 129
        ExplicitHeight = 250
        HelpContext = 1664068
        object Label4: TLabel
          AlignWithMargins = True
          Left = 626
          Top = 216
          Width = 95
          Height = 15
          Caption = 'For Description : '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          HelpContext = 1664069
        end
        object DNMPanel1: TDNMPanel
          Left = 1
          Top = 50
          Width = 993
          Height = 163
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          HelpContext = 1664070
          object grdTransactions: TwwDBGrid
            Left = 1
            Top = 1
            Width = 991
            Height = 161
            IniAttributes.Delimiter = ';;'
            TitleColor = clWhite
            FixedCols = 1
            ShowHorzScrollBar = True
            Align = alClient
            DataSource = dsSalesObj
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = []
            KeyOptions = []
            ParentFont = False
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'Arial'
            TitleFont.Style = [fsBold]
            TitleLines = 2
            TitleButtons = False
            OnCalcCellColors = grdTransactionsCalcCellColors
            OnCalcTitleAttributes = grdTransactionsCalcTitleAttributes
            OnDblClick = grdTransactionsDblClick
            FooterColor = clWhite
            HelpContext = 1664071
            object grdTransactionsIButton: TwwIButton
              Left = 0
              Top = 0
              Width = 22
              Height = 34
              AllowAllUp = True
              Glyph.Data = {
                26040000424D2604000000000000360000002800000012000000120000000100
                180000000000F0030000120B0000120B00000000000000000000FFFFFFFFFFFF
                636393525293FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFF555591616191FFFFFFFFFFFF0000FDFDFD6060820000D20000DA3F3F
                7DF4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F741417D0000CC00
                00CE5B5B80FBFBFB00009292A40000A40000C80000F60000BA30307BE7E7E7FF
                FFFFFFFFFFFFFFFFFFFFFFE7E7E734347C0000B20000FC0000D40000A28D8DA1
                000062628D0000BE0000D80000F80000F80000BA1F1F79DBDBDBFFFFFFFFFFFF
                D9D9D91C1C790000B00000FF1717FF0000F40000CA5C5C8900007979A90000CC
                0000D20000D60000F80000F40000B0131375DFDFDFDEDEDE1212750000B00000
                FA0F0FFF0000EA0000E40000E47373AB0000EAEAEC3F3FB30000CC0000D20000
                D80000F20000EE0000A812126B11116B0000A80000F60303FF0000E80000E200
                00DE3F3FBDEAEAEC0000FFFFFFFFFFFF4949B30000CC0000CE0000CC0000E400
                00DC00008A00008A0000DE0000EE0000E00000DE0000DC5252B6FFFFFFFFFFFF
                0000FFFFFFFFFFFFFFFFFF6464AF0000D00000E00000E20000F60000D60000D6
                0000F40000DC0000D40000D26A6AB4FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
                FFFFFFFFFFFF8888BB0101F60303FF0000F80000FC0000FC0000FC0505FF0303
                E89696BEFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFABAB
                AB0202910000E40000FC0000F80000F80000FC0000E2050592C7C7C7FFFFFFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF94949C00005800007C0000D607
                07FF0000FC0000FC0707FF0000CC00007600004EAEAEB2FFFFFFFFFFFFFFFFFF
                0000FFFFFFFFFFFF8E8E960000540000840000E00F0FFF0303FF1111FF0F0FFF
                0303FF0F0FFF0000D600007C00004CB1B1B3FFFFFFFFFFFF0000FFFFFF93939B
                00004E00007C0000EA1F1FFF1111FF1F1FFF0505EC0000F21F1FFF0F0FFF1F1F
                FF0000DC000078000044B3B3B7FFFFFF0000E0E0E100004400007E0000EC2D2D
                FF1919FF2F2FFF0101FCD8D8DDC5C5CF0B0BFF2D2DFF1919FF2929FF0000E000
                007A151547FBFBFB0000C7C7C80000820000F63535FF2525FF3D3DFF0202FFCA
                CAD3FFFFFFFFFFFFACACC11515FF3939FF2525FF3535FF0000EA00006EEAEAEA
                0000E0E0E20000EA5757FF2F2FFF4949FF0707FFCACAD3FFFFFFFFFFFFFFFFFF
                FFFFFFA6A6BF1B1BFF4343FF3333FF5151FF1414D9F7F7F70000FFFFFFB6B6CD
                1B1BFF6565FF1212FFC9C9D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFACAC
                C22929FF6565FF1616FAD3D3DCFFFFFF0000FFFFFFFFFFFFAFAFC43333E6CCCC
                D5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9898BE3737E4E0
                E0E3FFFFFFFFFFFF0000}
              HelpContext = 1664072
            end
          end
        end
        object DNMPanel4: TDNMPanel
          Left = 1
          Top = 1
          Width = 993
          Height = 49
          Align = alTop
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          HelpContext = 1664073
          object pnlsold: TDNMPanel
            Left = 464
            Top = 1
            Width = 123
            Height = 47
            Align = alLeft
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              123
              47)
            HelpContext = 1664074
            object lblQtySold: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 117
              Height = 15
              Align = alTop
              Caption = 'Sold'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              ExplicitWidth = 25
              HelpContext = 1664075
            end
            object edtQtySold: TwwDBEdit
              Left = 0
              Top = 21
              Width = 105
              Height = 23
              Anchors = [akRight, akBottom]
              DataField = 'UnitofMeasureQtySold'
              DataSource = DSDetails
              TabOrder = 0
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
              HelpContext = 1664076
            end
          end
          object DNMPanel7: TDNMPanel
            Left = 402
            Top = 1
            Width = 62
            Height = 47
            Align = alLeft
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            HelpContext = 1664077
            object Label2: TLabel
              AlignWithMargins = True
              Left = 12
              Top = 15
              Width = 47
              Height = 15
              Margins.Top = 15
              Align = alClient
              Alignment = taRightJustify
              Caption = 'Quantity'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              Layout = tlCenter
              HelpContext = 1664078
            end
          end
          object pnlShipped: TDNMPanel
            Left = 587
            Top = 1
            Width = 123
            Height = 47
            Align = alLeft
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            DesignSize = (
              123
              47)
            HelpContext = 1664079
            object lblQtyShipped: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 117
              Height = 15
              Align = alTop
              Caption = 'Shipped'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              ExplicitWidth = 46
              HelpContext = 1664080
            end
            object edtQtyShipped: TwwDBEdit
              Left = 0
              Top = 21
              Width = 105
              Height = 23
              Anchors = [akRight, akBottom]
              DataField = 'UnitofMeasureShipped'
              DataSource = DSDetails
              TabOrder = 0
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
              HelpContext = 1664081
            end
          end
          object pnluom: TDNMPanel
            Left = 833
            Top = 1
            Width = 123
            Height = 47
            Align = alLeft
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            DesignSize = (
              123
              47)
            HelpContext = 1664082
            object lblUOM: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 117
              Height = 15
              Align = alTop
              Caption = 'UOM'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              ExplicitWidth = 27
              HelpContext = 1664083
            end
            object edtuom: TwwDBEdit
              Left = 0
              Top = 21
              Width = 121
              Height = 23
              Anchors = [akRight, akBottom]
              DataField = 'UnitofMeasureSaleLines'
              DataSource = DSDetails
              ReadOnly = True
              TabOrder = 0
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
              HelpContext = 1664084
            end
          end
          object pnlBO: TDNMPanel
            Left = 710
            Top = 1
            Width = 123
            Height = 47
            Align = alLeft
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            DesignSize = (
              123
              47)
            HelpContext = 1664085
            object lblBO: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 117
              Height = 15
              Align = alTop
              Caption = 'Back Order'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = True
              ExplicitWidth = 65
              HelpContext = 1664086
            end
            object edtBO: TwwDBEdit
              Left = 0
              Top = 21
              Width = 105
              Height = 23
              Anchors = [akRight, akBottom]
              DataField = 'UnitofMeasureBackorder'
              DataSource = DSDetails
              ReadOnly = True
              TabOrder = 0
              UnboundDataType = wwDefault
              WantReturns = False
              WordWrap = False
              HelpContext = 1664087
            end
          end
          object DNMPanel5: TDNMPanel
            Left = 1
            Top = 1
            Width = 401
            Height = 47
            Align = alLeft
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
            HelpContext = 1664088
            object lblProductname: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 7
              Width = 116
              Height = 15
              Margins.Top = 7
              Align = alTop
              Caption = 'CONFIGURING ITEM : '
              HelpContext = 1664089
            end
            object DBText2: TDBText
              AlignWithMargins = True
              Left = 3
              Top = 28
              Width = 395
              Height = 16
              Align = alClient
              DataField = 'ProductName'
              DataSource = DSDetails
              ExplicitLeft = 6
              ExplicitTop = 25
              ExplicitWidth = 711
              ExplicitHeight = 17
              HelpContext = 1664090
            end
          end
        end
        object chkShippedQtyOnly: TCheckBox
          AlignWithMargins = True
          Left = 4
          Top = 216
          Width = 435
          Height = 17
          Margins.Right = 555
          Align = alBottom
          Caption = '   Hide Quantity Sold'
          TabOrder = 2
          OnClick = chkShippedQtyOnlyClick
          HelpContext = 1664091
        end
        object grpListDescription: TwwRadioGroup
          Left = 733
          Top = 216
          Width = 258
          Height = 17
          DisableThemes = False
          ShowGroupCaption = False
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Items.Strings = (
            'Use Formula'
            'USe Dimension')
          ParentFont = False
          TabOrder = 3
          OnClick = grpListDescriptionClick
          HelpContext = 1664092
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 334
    Top = 16
  end
  inherited tmrdelay: TTimer
    Left = 371
    Top = 16
  end
  inherited popSpelling: TPopupMenu
    Left = 484
    Top = 16
  end
  inherited tmrdelayMsg: TTimer
    Left = 409
    Top = 16
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 559
    Top = 16
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 597
    Top = 16
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 106
    Top = 16
  end
  inherited DataState: TDataState
    Left = 634
    Top = 16
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 446
    Top = 16
  end
  inherited imgsort: TImageList
    Left = 672
    Top = 16
    Bitmap = {
      494C010102004801380210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 183
    Top = 16
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 710
    Top = 16
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 522
    Top = 16
  end
  inherited qryMemTrans: TERPQuery
    Left = 221
    Top = 16
  end
  object DSDetails: TDataSource
    Left = 258
    Top = 16
  end
  object dsSalesObj: TDataSource
    Left = 296
    Top = 16
  end
  object qryProductformula: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT `FormulaID`, `FormulaName`  '
      'FROM `tblfeformula` main '
      
        'Where (Select count(*) from `tblfeformula`  sub where sub.`Formu' +
        'laName`   = main.`FormulaName`  ) = 1'
      'group by formulaname')
    Left = 141
    Top = 17
    object qryProductformulaFormulaName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 25
      FieldName = 'FormulaName'
      Size = 50
    end
    object qryProductformulaFormulaID: TIntegerField
      FieldName = 'FormulaID'
      Visible = False
    end
  end
end
