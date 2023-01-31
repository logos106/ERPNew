inherited frWwDbGridGuiEdit: TfrWwDbGridGuiEdit
  Width = 556
  Height = 395
  HelpContext = 597000
  Constraints.MinHeight = 395
  Constraints.MinWidth = 556
  Color = 15527129
  ParentColor = False
  ExplicitWidth = 556
  ExplicitHeight = 395
  inherited lblMsg: TLabel
    Top = 375
    Width = 556
    HelpContext = 597035
    ExplicitTop = 375
    ExplicitWidth = 435
  end
  object pnlGrid: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 556
    Height = 375
    HelpContext = 597001
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object pnlCustColumn: TDNMPanel
      Left = 0
      Top = 210
      Width = 556
      Height = 165
      HelpContext = 597002
      Align = alBottom
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      Transparent = False
      object grpCustColumn: TGroupBox
        Left = 16
        Top = 8
        Width = 377
        Height = 145
        HelpContext = 597003
        Caption = ' Custom Column '
        TabOrder = 0
        object lblFormula: TLabel
          Left = 23
          Top = 52
          Width = 92
          Height = 15
          HelpContext = 597004
          Caption = 'Column Formula'
          Transparent = True
        end
        object lblFormat: TLabel
          Left = 18
          Top = 96
          Width = 84
          Height = 15
          HelpContext = 597005
          Caption = 'Display Format'
          Transparent = True
        end
        object Label2: TLabel
          Left = 121
          Top = 55
          Width = 142
          Height = 15
          HelpContext = 597006
          Caption = '( Right Click For Options )'
          Enabled = False
          Transparent = True
        end
        object btnAddCustColumn: TDNMSpeedButton
          Left = 16
          Top = 21
          Width = 75
          Height = 25
          HelpContext = 597007
          Action = actAdd
          Caption = 'New'
          Color = clWhite
          DisableTransparent = False
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ParentColor = False
          Style = bsModern
          TabOrder = 0
          AutoDisableParentOnclick = True
        end
        object btnDelete: TDNMSpeedButton
          Left = 104
          Top = 21
          Width = 75
          Height = 25
          HelpContext = 597008
          Action = actDelete
          Caption = 'Delete'
          Color = clWhite
          DisableTransparent = False
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ParentColor = False
          Style = bsModern
          TabOrder = 1
          AutoDisableParentOnclick = True
        end
        object edtFieldFormula: TEdit
          Left = 16
          Top = 71
          Width = 345
          Height = 23
          HelpContext = 597009
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          PopupMenu = pumFormula
          TabOrder = 3
          OnExit = edtFieldFormulaExit
        end
        object edtFormat: TEdit
          Left = 16
          Top = 112
          Width = 233
          Height = 23
          HelpContext = 597010
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnExit = edtFormatExit
        end
        object btnCheckFormula: TDNMSpeedButton
          Left = 262
          Top = 21
          Width = 99
          Height = 25
          HelpContext = 597011
          Action = actCheckFormula
          Caption = 'Check Formula'
          Color = clWhite
          DisableTransparent = False
          HotTrackColor = clBtnShadow
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          ParentColor = False
          Style = bsModern
          TabOrder = 2
          AutoDisableParentOnclick = True
        end
        object chkSumColumn: TwwCheckBox
          Left = 264
          Top = 114
          Width = 97
          Height = 17
          HelpContext = 597012
          DisableThemes = False
          AlwaysTransparent = True
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          DisplayValueChecked = 'True'
          DisplayValueUnchecked = 'False'
          NullAndBlankState = cbUnchecked
          Caption = 'Sum Column'
          TabOrder = 5
          Visible = False
          OnClick = chkSumColumnClick
        end
      end
      object pnlSearch: TDNMPanel
        Left = 393
        Top = 74
        Width = 157
        Height = 79
        HelpContext = 597036
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Label3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 151
          Height = 15
          HelpContext = 597037
          Align = alTop
          Alignment = taCenter
          Caption = 'Search for Field'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          ExplicitWidth = 89
        end
        object Shape1: TShape
          Left = 0
          Top = 0
          Width = 157
          Height = 79
          HelpContext = 597038
          Brush.Style = bsClear
          Pen.Color = clGray
        end
        object edtSearch: TEdit
          AlignWithMargins = True
          Left = 6
          Top = 24
          Width = 145
          Height = 23
          Hint = 'Type In What To Search in the List of Columns'
          HelpContext = 597039
          Margins.Left = 6
          Margins.Right = 6
          TabStop = False
          Align = alTop
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnKeyDown = edtSearchKeyDown
        end
        object btnearchnext: TDNMSpeedButton
          AlignWithMargins = True
          Left = 33
          Top = 53
          Width = 91
          Height = 23
          Hint = 'Search Next'
          HelpContext = 597040
          Margins.Left = 33
          Margins.Right = 33
          Align = alBottom
          Caption = 'Next'
          DisableTransparent = False
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'Tahoma'
          HotTrackFont.Style = []
          TabOrder = 1
          AutoDisableParentOnclick = True
          OnClick = btnearchnextClick
        end
      end
    end
    object pnlColumns: TDNMPanel
      Left = 0
      Top = 0
      Width = 556
      Height = 210
      HelpContext = 597013
      Align = alClient
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      Transparent = False
      object pnlColumnsTop: TDNMPanel
        Left = 0
        Top = 0
        Width = 556
        Height = 25
        HelpContext = 597014
        Align = alTop
        BevelOuter = bvNone
        Color = 15527129
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label1: TLabel
          Left = 18
          Top = 9
          Width = 273
          Height = 15
          HelpContext = 597015
          Caption = 'Columns -  Double click on name to change label'
          Color = 15527129
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
        end
      end
      object pnlColumnsLeft: TDNMPanel
        Left = 0
        Top = 25
        Width = 17
        Height = 185
        HelpContext = 597016
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
      end
      object lstGridColumns: TCheckListBox
        Left = 17
        Top = 25
        Width = 376
        Height = 185
        HelpContext = 597017
        OnClickCheck = lstGridColumnsClickCheck
        Align = alLeft
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 15
        ParentFont = False
        Style = lbOwnerDrawFixed
        TabOrder = 2
        OnClick = lstGridColumnslClick
        OnDblClick = lstGridColumnsDblClick
        OnDrawItem = lstGridColumnsDrawItem
      end
      object btnGridTitleFont: TDNMSpeedButton
        Left = 408
        Top = 24
        Width = 135
        Height = 29
        HelpContext = 597018
        Caption = 'Grid Title Font'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = btnGridTitleFontClick
      end
      object btnGridFont: TDNMSpeedButton
        Left = 408
        Top = 64
        Width = 135
        Height = 29
        HelpContext = 597019
        Caption = 'Grid Font'
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 4
        AutoDisableParentOnclick = True
        OnClick = btnGridFontClick
      end
      object btnAltRowColour: TDNMSpeedButton
        Left = 408
        Top = 104
        Width = 135
        Height = 29
        HelpContext = 597020
        Caption = 'Alternate Row Colour '
        Color = clWhite
        DisableTransparent = False
        HotTrackColor = clBtnShadow
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        ParentColor = False
        Style = bsModern
        TabOrder = 5
        AutoDisableParentOnclick = True
        OnClick = btnAltRowColourClick
      end
      object chkGridLines: TwwCheckBox
        Left = 409
        Top = 143
        Width = 120
        Height = 17
        HelpContext = 597021
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Transparent = True
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Caption = 'Enable Grid Lines'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        OnClick = chkGridLinesClick
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    OnTimer = nil
  end
  object alColumns: TActionList
    Left = 304
    Top = 16
    object actAdd: TAction
      Caption = 'New'
      HelpContext = 597023
      OnExecute = actAddExecute
    end
    object actDelete: TAction
      Caption = 'Delete'
      Enabled = False
      HelpContext = 597024
      OnExecute = actDeleteExecute
    end
    object actCheckFormula: TAction
      Caption = 'Check Formula'
      Enabled = False
      HelpContext = 597025
      OnExecute = actCheckFormulaExecute
    end
  end
  object pumFormula: TAdvPopupMenu
    HelpContext = 597026
    OnPopup = pumFormulaPopup
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 336
    Top = 16
    object mnuColumns: TMenuItem
      Caption = 'Columns'
      HelpContext = 597027
    end
    object N5: TMenuItem
      Caption = '-'
      HelpContext = 597028
    end
    object N1: TMenuItem
      Caption = 'add'
      HelpContext = 597029
      OnClick = FormulaItemClick
    end
    object N2: TMenuItem
      Caption = 'subtract'
      HelpContext = 597030
      OnClick = FormulaItemClick
    end
    object multiply1: TMenuItem
      Caption = 'multiply'
      HelpContext = 597031
      OnClick = FormulaItemClick
    end
    object divide1: TMenuItem
      Caption = 'divide'
      HelpContext = 597032
      OnClick = FormulaItemClick
    end
    object N3: TMenuItem
      Caption = '('
      HelpContext = 597033
      OnClick = FormulaItemClick
    end
    object N4: TMenuItem
      Caption = ')'
      HelpContext = 597034
      OnClick = FormulaItemClick
    end
  end
  object dlgFont: TFontDialog
    HelpContext = 597035
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Left = 248
    Top = 16
  end
  object dlgColor: TColorDialog
    HelpContext = 597036
    Left = 192
    Top = 20
  end
end
