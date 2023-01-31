inherited RollaBlindStage6GUI: TRollaBlindStage6GUI
  Caption = 'Cut-out Sheet - Step 6'
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    inherited btnBack: TDNMSpeedButton
      Enabled = True
    end
    inherited btnNext: TDNMSpeedButton
      Caption = '&Finish'
    end
    inherited DNMPanel2: TDNMPanel
      inherited ScrollBox: TScrollBox
        Visible = False
      end
    end
    inherited DNMPanel3: TDNMPanel
      object Label8: TLabel
        Left = 32
        Top = 80
        Width = 45
        Height = 15
        Caption = 'Number'
        Transparent = True
      end
      object Label9: TLabel
        Left = 96
        Top = 80
        Width = 19
        Height = 15
        Caption = 'Qty'
        Transparent = True
      end
      object Label10: TLabel
        Left = 168
        Top = 80
        Width = 67
        Height = 15
        Caption = 'Profile Type'
        Transparent = True
      end
      object Label11: TLabel
        Left = 296
        Top = 80
        Width = 37
        Height = 15
        Caption = 'Colour'
        Transparent = True
      end
      object lblNumber1: TLabel
        Left = 32
        Top = 104
        Width = 45
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '1'
        Transparent = True
      end
      object lblNumber2: TLabel
        Left = 32
        Top = 136
        Width = 45
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '2'
        Transparent = True
      end
      object lblNumber3: TLabel
        Left = 32
        Top = 168
        Width = 45
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '3'
        Transparent = True
      end
      object lblNumber4: TLabel
        Left = 32
        Top = 200
        Width = 45
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '4'
        Transparent = True
      end
      object lblNumber5: TLabel
        Left = 32
        Top = 232
        Width = 45
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '5'
        Transparent = True
      end
      object lblNumber6: TLabel
        Left = 32
        Top = 264
        Width = 45
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '6'
        Transparent = True
      end
      object lblNumber7: TLabel
        Left = 32
        Top = 296
        Width = 45
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '7'
        Transparent = True
      end
      object lblNumber8: TLabel
        Left = 32
        Top = 328
        Width = 45
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '8'
        Transparent = True
      end
      object lblNumber9: TLabel
        Left = 32
        Top = 360
        Width = 45
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '9'
        Transparent = True
      end
      object lblNumber10: TLabel
        Left = 32
        Top = 392
        Width = 45
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = '10'
        Transparent = True
      end
      object Label12: TLabel
        Left = 384
        Top = 80
        Width = 77
        Height = 15
        Caption = 'Lock Position'
        Transparent = True
      end
      object Label54: TLabel
        Left = 408
        Top = 134
        Width = 68
        Height = 15
        Caption = 'Finger Grips'
        Transparent = True
      end
      object edtQty1: TwwDBEdit
        Left = 80
        Top = 100
        Width = 49
        Height = 23
        DataField = 'Lvl1qty'
        DataSource = dsMain
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
        OnExit = edtQtyExit
        OnMouseDown = AllMouseDown
      end
      object edtQty2: TwwDBEdit
        Left = 80
        Top = 132
        Width = 49
        Height = 23
        DataField = 'Lvl2qty'
        DataSource = dsMain
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
        OnExit = edtQtyExit
        OnMouseDown = AllMouseDown
      end
      object edtQty3: TwwDBEdit
        Left = 80
        Top = 164
        Width = 49
        Height = 23
        DataField = 'Lvl3qty'
        DataSource = dsMain
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
        OnExit = edtQtyExit
        OnMouseDown = AllMouseDown
      end
      object edtQty4: TwwDBEdit
        Left = 80
        Top = 196
        Width = 49
        Height = 23
        DataField = 'Lvl4qty'
        DataSource = dsMain
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
        OnExit = edtQtyExit
        OnMouseDown = AllMouseDown
      end
      object edtQty5: TwwDBEdit
        Left = 80
        Top = 228
        Width = 49
        Height = 23
        DataField = 'Lvl5qty'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtQtyExit
        OnMouseDown = AllMouseDown
      end
      object edtQty6: TwwDBEdit
        Left = 80
        Top = 260
        Width = 49
        Height = 23
        DataField = 'Lvl6qty'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtQtyExit
        OnMouseDown = AllMouseDown
      end
      object edtQty7: TwwDBEdit
        Left = 80
        Top = 292
        Width = 49
        Height = 23
        DataField = 'Lvl7qty'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtQtyExit
        OnMouseDown = AllMouseDown
      end
      object edtQty8: TwwDBEdit
        Left = 80
        Top = 324
        Width = 49
        Height = 23
        DataField = 'Lvl8qty'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtQtyExit
        OnMouseDown = AllMouseDown
      end
      object edtQty9: TwwDBEdit
        Left = 80
        Top = 356
        Width = 49
        Height = 23
        DataField = 'Lvl9qty'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 24
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtQtyExit
        OnMouseDown = AllMouseDown
      end
      object edtQty10: TwwDBEdit
        Left = 80
        Top = 388
        Width = 49
        Height = 23
        DataField = 'Lvl10qty'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 27
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtQtyExit
        OnMouseDown = AllMouseDown
      end
      object cboProfileType1: TwwDBLookupCombo
        Left = 144
        Top = 100
        Width = 121
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Lvl1prof'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboProfileType2: TwwDBLookupCombo
        Left = 144
        Top = 132
        Width = 121
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Lvl2prof'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 4
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboProfileType3: TwwDBLookupCombo
        Left = 144
        Top = 164
        Width = 121
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Lvl3prof'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 7
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboProfileType4: TwwDBLookupCombo
        Left = 144
        Top = 196
        Width = 121
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Lvl4prof'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 10
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboProfileType5: TwwDBLookupCombo
        Left = 144
        Top = 228
        Width = 121
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Lvl5prof'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 13
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboProfileType6: TwwDBLookupCombo
        Left = 144
        Top = 260
        Width = 121
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Lvl6prof'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 16
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboProfileType7: TwwDBLookupCombo
        Left = 144
        Top = 292
        Width = 121
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Lvl7prof'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 19
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboProfileType8: TwwDBLookupCombo
        Left = 144
        Top = 324
        Width = 121
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Lvl8prof'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 22
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboProfileType9: TwwDBLookupCombo
        Left = 144
        Top = 356
        Width = 121
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Lvl9prof'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 25
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboProfileType10: TwwDBLookupCombo
        Left = 144
        Top = 388
        Width = 121
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'Lvl10prof'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 28
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboColour1: TwwDBLookupCombo
        Left = 280
        Top = 100
        Width = 73
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9'F'#9
          'ProfileType'#9'15'#9'ProfileType'#9'F')
        DataField = 'Lvl1colour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnBeforeDropDown = cboColourBeforeDropDown
        OnCloseUp = cboColourCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboColour2: TwwDBLookupCombo
        Left = 280
        Top = 132
        Width = 73
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9#9
          'ProfileType'#9'15'#9'ProfileType'#9#9)
        DataField = 'Lvl2colour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 5
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnBeforeDropDown = cboColourBeforeDropDown
        OnCloseUp = cboColourCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboColour3: TwwDBLookupCombo
        Left = 280
        Top = 164
        Width = 73
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9#9
          'ProfileType'#9'15'#9'ProfileType'#9#9)
        DataField = 'Lvl3colour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 8
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnBeforeDropDown = cboColourBeforeDropDown
        OnCloseUp = cboColourCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboColour4: TwwDBLookupCombo
        Left = 280
        Top = 196
        Width = 73
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9#9
          'ProfileType'#9'15'#9'ProfileType'#9#9)
        DataField = 'Lvl4colour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 11
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnBeforeDropDown = cboColourBeforeDropDown
        OnCloseUp = cboColourCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboColour5: TwwDBLookupCombo
        Left = 280
        Top = 228
        Width = 73
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9#9
          'ProfileType'#9'15'#9'ProfileType'#9#9)
        DataField = 'Lvl5colour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 14
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnBeforeDropDown = cboColourBeforeDropDown
        OnCloseUp = cboColourCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboColour6: TwwDBLookupCombo
        Left = 280
        Top = 260
        Width = 73
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9#9
          'ProfileType'#9'15'#9'ProfileType'#9#9)
        DataField = 'Lvl6colour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 17
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnBeforeDropDown = cboColourBeforeDropDown
        OnCloseUp = cboColourCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboColour7: TwwDBLookupCombo
        Left = 280
        Top = 292
        Width = 73
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9#9
          'ProfileType'#9'15'#9'ProfileType'#9#9)
        DataField = 'Lvl7colour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 20
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnBeforeDropDown = cboColourBeforeDropDown
        OnCloseUp = cboColourCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboColour8: TwwDBLookupCombo
        Left = 280
        Top = 324
        Width = 73
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9#9
          'ProfileType'#9'15'#9'ProfileType'#9#9)
        DataField = 'Lvl8colour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 23
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnBeforeDropDown = cboColourBeforeDropDown
        OnCloseUp = cboColourCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboColour9: TwwDBLookupCombo
        Left = 280
        Top = 356
        Width = 73
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9#9
          'ProfileType'#9'15'#9'ProfileType'#9#9)
        DataField = 'Lvl9colour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 26
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnBeforeDropDown = cboColourBeforeDropDown
        OnCloseUp = cboColourCloseUp
        OnMouseDown = AllMouseDown
      end
      object cboColour10: TwwDBLookupCombo
        Left = 280
        Top = 388
        Width = 73
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9#9
          'ProfileType'#9'15'#9'ProfileType'#9#9)
        DataField = 'Lvl10colour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 29
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnBeforeDropDown = cboColourBeforeDropDown
        OnMouseDown = AllMouseDown
      end
      object btnCalculate: TDNMSpeedButton
        Left = 384
        Top = 344
        Width = 87
        Height = 27
        Anchors = [akRight, akBottom]
        Caption = 'Ca&lculate'
        DisableTransparent = False
        Enabled = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 32
        OnClick = btnCalculateClick
      end
      object btnReset: TDNMSpeedButton
        Left = 384
        Top = 384
        Width = 87
        Height = 27
        Anchors = [akRight, akBottom]
        Caption = '&Reset'
        DisableTransparent = False
        Enabled = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 33
        TabStop = False
        OnClick = btnResetClick
      end
      object edtLockPosition: TwwDBEdit
        Left = 384
        Top = 100
        Width = 87
        Height = 23
        DataField = 'LockPosition'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 30
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object chkFingerGrips: TwwCheckBox
        Left = 384
        Top = 134
        Width = 17
        Height = 17
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
        DataField = 'FingGrips'
        DataSource = dsMain
        TabOrder = 31
      end
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * '
      'FROM tblrollaaddcolgrid1'
      '')
  end
  inherited qryHeading: TMyQuery
    SQL.Strings = (
      
        'SELECT  ClientID as LeadNumber, Title, FirstName, LastName as Su' +
        'rname '
      'FROM tblclients '
      'WHERE ClientID=:ClientID;')
  end
  object qryProfileType: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ProfileType'
      'FROM tblrollaprofiletypes'
      'ORDER BY Asc2;')
    Left = 376
    Top = 544
    object qryProfileTypeProfileType: TStringField
      DisplayWidth = 15
      FieldName = 'ProfileType'
      Visible = False
      Size = 50
    end
  end
  object qryColour: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT rpc.ColourCode, rpc.ProfileType, rpc.Standard'
      'FROM tblrollaaddsheet1 ras '
      
        'INNER JOIN tblrollaprofilecolours rpc ON ras.Standard = rpc.Stan' +
        'dard'
      'WHERE rpc.ProfileType = :ProfileType'
      'GROUP BY rpc.ColourCode'
      'ORDER BY rpc.ColourCode;')
    Left = 408
    Top = 544
    ParamData = <
      item
        DataType = ftString
        Name = 'ProfileType'
        Value = ''
      end>
    object qryColourColourCode: TStringField
      DisplayWidth = 3
      FieldName = 'ColourCode'
      Size = 50
    end
    object qryColourProfileType: TStringField
      DisplayWidth = 15
      FieldName = 'ProfileType'
      Size = 50
    end
    object qryColourStandard: TStringField
      DisplayWidth = 1
      FieldName = 'Standard'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryCalc: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblrollaaddsheet1 ras '
      'INNER JOIN tblrollaAddColGrid1 USING(SheetID)'
      'WHERE ras.SheetID=:SheetID;'
      '')
    Left = 440
    Top = 544
    ParamData = <
      item
        DataType = ftString
        Name = 'SheetID'
        Value = ''
      end>
  end
end
