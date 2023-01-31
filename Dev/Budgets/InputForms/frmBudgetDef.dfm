inherited fmBudgetDef: TfmBudgetDef
  Left = 317
  Top = 171
  HelpContext = 145000
  Caption = 'Budget Definition'
  ClientHeight = 397
  ClientWidth = 533
  Color = 14153215
  OldCreateOrder = True
  Position = poScreenCenter
  ExplicitLeft = 317
  ExplicitTop = 171
  ExplicitWidth = 549
  ExplicitHeight = 436
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 352
    Width = 533
    ExplicitTop = 352
    ExplicitWidth = 533
    HelpContext = 145037
  end
  inherited imgGridWatermark: TImage
    HelpContext = 145001
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 352
    Width = 533
    Height = 45
    HelpContext = 145002
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    DesignSize = (
      533
      45)
    object Label3: TLabel
      Left = 492
      Top = 10
      Width = 35
      Height = 15
      HelpContext = 145003
      Anchors = [akRight, akBottom]
      Caption = 'Active'
      Transparent = True
    end
    object btnSave: TDNMSpeedButton
      Left = 102
      Top = 4
      Width = 91
      Height = 27
      HelpContext = 145004
      Anchors = [akBottom]
      Caption = '&Save'
      Default = True
      DisableTransparent = False
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 349
      Top = 4
      Width = 91
      Height = 27
      HelpContext = 145005
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnCancelClick
    end
    object btnNew: TDNMSpeedButton
      Left = 225
      Top = 4
      Width = 91
      Height = 27
      HelpContext = 145006
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 2
      OnClick = btnNewClick
    end
    object chkActive: TwwCheckBox
      Left = 472
      Top = 9
      Width = 17
      Height = 17
      HelpContext = 145007
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
      Caption = 'chkActive'
      DataField = 'Active'
      DataSource = dsBudgetDef
      TabOrder = 0
    end
  end
  object DNMPanel4: TDNMPanel [6]
    Left = 0
    Top = 52
    Width = 533
    Height = 300
    HelpContext = 145008
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
    object Bevel113: TBevel
      Left = 248
      Top = 83
      Width = 267
      Height = 94
      HelpContext = 145009
      Shape = bsFrame
    end
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 33
      Height = 15
      HelpContext = 145010
      Caption = 'Name'
      Transparent = True
    end
    object Label2: TLabel
      Left = 16
      Top = 38
      Width = 65
      Height = 15
      HelpContext = 145011
      Caption = 'Description'
      Transparent = True
    end
    object Label6: TLabel
      Left = 259
      Top = 124
      Width = 54
      Height = 15
      HelpContext = 145012
      Caption = 'Amount 1'
      Transparent = True
    end
    object Label7: TLabel
      Left = 259
      Top = 153
      Width = 54
      Height = 15
      HelpContext = 145013
      Caption = 'Amount 2'
      Transparent = True
    end
    object Label9: TLabel
      Left = 16
      Top = 68
      Width = 60
      Height = 15
      HelpContext = 145014
      Caption = 'Start Date '
      Transparent = True
    end
    object Label10: TLabel
      Left = 16
      Top = 159
      Width = 53
      Height = 15
      HelpContext = 145015
      Caption = 'End Date '
      Transparent = True
    end
    object Label5: TLabel
      Left = 307
      Top = 98
      Width = 38
      Height = 15
      HelpContext = 145016
      Caption = 'Visible'
      Transparent = True
    end
    object Label11: TLabel
      Left = 399
      Top = 98
      Width = 65
      Height = 15
      HelpContext = 145017
      Caption = 'Description'
      Transparent = True
    end
    object Label12: TLabel
      Left = 16
      Top = 98
      Width = 44
      Height = 15
      HelpContext = 145018
      Caption = 'Periods'
      Transparent = True
    end
    object Label13: TLabel
      Left = 16
      Top = 128
      Width = 42
      Height = 15
      HelpContext = 145019
      Caption = 'Interval'
      Transparent = True
    end
    object Label4: TLabel
      Left = 248
      Top = 67
      Width = 161
      Height = 15
      HelpContext = 145020
      Caption = 'Customisable Amount Fields'
      Transparent = True
    end
    object Label8: TLabel
      Left = 16
      Top = 192
      Width = 74
      Height = 15
      HelpContext = 145021
      Caption = 'Departments'
      Transparent = True
    end
    object edtName: TwwDBEdit
      Left = 104
      Top = 4
      Width = 289
      Height = 23
      HelpContext = 145022
      DataField = 'Name'
      DataSource = dsBudgetDef
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtDescription: TwwDBEdit
      Left = 104
      Top = 34
      Width = 414
      Height = 23
      HelpContext = 145023
      DataField = 'Description'
      DataSource = dsBudgetDef
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object edtAmount1Label: TwwDBEdit
      Left = 345
      Top = 119
      Width = 164
      Height = 23
      HelpContext = 145024
      DataField = 'Amount1Label'
      DataSource = dsBudgetDef
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
    end
    object edtAmount2Label: TwwDBEdit
      Left = 345
      Top = 149
      Width = 164
      Height = 23
      HelpContext = 145025
      DataField = 'Amount2Label'
      DataSource = dsBudgetDef
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
    end
    object chkShowAmount1: TwwCheckBox
      Left = 318
      Top = 123
      Width = 17
      Height = 17
      HelpContext = 145026
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
      Caption = 'chkActive'
      DataField = 'ShowAmount1'
      DataSource = dsBudgetDef
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = chkShowAmount1Click
    end
    object chkShowAmount2: TwwCheckBox
      Left = 318
      Top = 152
      Width = 17
      Height = 17
      HelpContext = 145027
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
      Caption = 'chkActive'
      DataField = 'ShowAmount2'
      DataSource = dsBudgetDef
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = chkShowAmount2Click
    end
    object cboIntervalPeriod: TwwDBComboBox
      Left = 104
      Top = 124
      Width = 113
      Height = 23
      HelpContext = 145028
      ShowButton = True
      Style = csDropDownList
      MapList = True
      AllowClearKey = False
      ShowMatchText = True
      DataField = 'IntervalPeriod'
      DataSource = dsBudgetDef
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Daily'#9'1'
        'Weekly'#9'2'
        'Fortnightly'#9'3'
        'Monthly'#9'4'
        'Quarterly'#9'5'
        'Half Yearly'#9'6'
        'Yearly'#9'7')
      ParentFont = False
      Sorted = False
      TabOrder = 5
      UnboundDataType = wwDefault
    end
    object dtStartDate: TwwDBDateTimePicker
      Left = 104
      Top = 64
      Width = 89
      Height = 23
      HelpContext = 145029
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      CalendarAttributes.PopupYearOptions.NumberColumns = 4
      DataField = 'StartDate'
      DataSource = dsBudgetDef
      Date = 38614.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
    end
    object dtEndDate: TwwDBDateTimePicker
      Left = 104
      Top = 155
      Width = 89
      Height = 23
      HelpContext = 145030
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'EndDate'
      DataSource = dsBudgetDef
      Date = 38979.000000000000000000
      Epoch = 1950
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 4
    end
    object spnIntervalDuration: TwwDBSpinEdit
      Left = 104
      Top = 94
      Width = 49
      Height = 23
      HelpContext = 145031
      EditAlignment = eaRightAlignEditing
      Increment = 1.000000000000000000
      DataField = 'IntervalDuration'
      DataSource = dsBudgetDef
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      UnboundDataType = wwDefault
    end
    object grdBudgetClasses: TwwDBGrid
      Left = 104
      Top = 189
      Width = 414
      Height = 105
      HelpContext = 145032
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'Classname'#9'48'#9'Department'#9'T'#9
        'Active'#9'1'#9'Active'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnRowChanged = grdBudgetClassesRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      DataSource = dsBudgetClass
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      ParentFont = False
      TabOrder = 10
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnEnter = grdBudgetClassesEnter
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 533
    Height = 52
    HelpContext = 145033
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    Transparent = False
    object pnlTitle: TDNMPanel
      Left = 129
      Top = 3
      Width = 277
      Height = 45
      HelpContext = 145034
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 275
        Height = 43
        HelpContext = 145035
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
          Width = 275
          Height = 43
          HelpContext = 145036
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Budget Definition'
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
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 48
    Top = 27
  end
  inherited MyConnection: TERPConnection
    Left = 80
    Top = 26
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 112
    Top = 27
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102004801800110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object BudgetClass_Dataset: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblBudgetClass')
    Left = 360
    Top = 80
    object BudgetClass_DatasetClassname: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 48
      FieldKind = fkLookup
      FieldName = 'Classname'
      LookupDataSet = ClassNameLookup
      LookupKeyFields = 'ClassID'
      LookupResultField = 'ClassName'
      KeyFields = 'ClassId'
      Size = 100
      Lookup = True
    end
    object BudgetClass_DatasetActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblBudgetClass.Active'
      FixedChar = True
      Size = 1
    end
    object BudgetClass_DatasetID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 15
      FieldName = 'ID'
      Origin = 'tblBudgetClass.ID'
      Visible = False
    end
    object BudgetClass_DatasetBudgetId: TIntegerField
      DisplayWidth = 15
      FieldName = 'BudgetId'
      Origin = 'tblBudgetClass.BudgetId'
      Visible = False
    end
    object BudgetClass_DatasetClassId: TIntegerField
      DisplayWidth = 15
      FieldName = 'ClassId'
      Origin = 'tblBudgetClass.ClassId'
      Visible = False
    end
    object BudgetClass_DatasetmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblBudgetClass.msTimeStamp'
      Visible = False
    end
  end
  object ClassNameLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select ClassId, ClassName from tblClass ')
    Left = 512
    Top = 304
    object ClassNameLookupClassID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClassID'
      Origin = 'tblClass.ClassId'
    end
    object ClassNameLookupClassName: TWideStringField
      FieldName = 'ClassName'
      Origin = 'tblClass.ClassName'
      Size = 60
    end
  end
  object dsBudgetDef: TDataSource
    DataSet = BudgetDef_Dataset
    Left = 296
    Top = 80
  end
  object BudgetDef_Dataset: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblBudgets')
    Left = 232
    Top = 80
    object BudgetDef_DatasetGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object BudgetDef_DatasetBudgetID: TIntegerField
      FieldName = 'BudgetID'
    end
    object BudgetDef_DatasetName: TWideStringField
      FieldName = 'Name'
      Size = 25
    end
    object BudgetDef_DatasetDescription: TWideStringField
      FieldName = 'Description'
      Size = 50
    end
    object BudgetDef_DatasetAmount1Label: TWideStringField
      FieldName = 'Amount1Label'
      Size = 50
    end
    object BudgetDef_DatasetAmount2Label: TWideStringField
      FieldName = 'Amount2Label'
      Size = 50
    end
    object BudgetDef_DatasetShowAmount1: TWideStringField
      FieldName = 'ShowAmount1'
      FixedChar = True
      Size = 1
    end
    object BudgetDef_DatasetShowAmount2: TWideStringField
      FieldName = 'ShowAmount2'
      FixedChar = True
      Size = 1
    end
    object BudgetDef_DatasetStartDate: TDateTimeField
      FieldName = 'StartDate'
    end
    object BudgetDef_DatasetEndDate: TDateTimeField
      FieldName = 'EndDate'
    end
    object BudgetDef_DatasetIntervalPeriod: TSmallintField
      FieldName = 'IntervalPeriod'
    end
    object BudgetDef_DatasetIntervalDuration: TSmallintField
      FieldName = 'IntervalDuration'
    end
    object BudgetDef_DatasetActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object BudgetDef_DatasetEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object BudgetDef_DatasetmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
  end
  object dsBudgetClass: TDataSource
    DataSet = BudgetClass_Dataset
    Left = 424
    Top = 80
  end
end
