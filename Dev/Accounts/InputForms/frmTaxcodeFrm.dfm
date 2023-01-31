inherited frmTaxcode: TfrmTaxcode
  Left = 503
  Top = 217
  HelpContext = 356000
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = 'Tax Code'
  ClientHeight = 445
  ClientWidth = 996
  Font.Charset = DEFAULT_CHARSET
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poScreenCenter
  ExplicitLeft = 503
  ExplicitTop = 217
  ExplicitWidth = 1012
  ExplicitHeight = 484
  DesignSize = (
    996
    445)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 395
    Width = 996
    HelpContext = 356017
    ExplicitTop = 425
    ExplicitWidth = 436
  end
  inherited shapehint: TShape
    Left = 45
    ExplicitLeft = 37
  end
  inherited imgGridWatermark: TImage
    Left = 124
    Top = 30
    HelpContext = 356001
    ExplicitLeft = 124
    ExplicitTop = 30
  end
  inherited shapehintextra1: TShape
    Left = 142
    ExplicitLeft = 120
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 50
    Width = 596
    Height = 345
    HelpContext = 356019
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Bevel2: TBevel
      Left = 6
      Top = 108
      Width = 584
      Height = 229
      HelpContext = 356021
      Shape = bsFrame
    end
    object Bevel1: TBevel
      Left = 6
      Top = 7
      Width = 584
      Height = 103
      HelpContext = 356002
      Shape = bsFrame
    end
    object Name_Label: TLabel
      Left = 63
      Top = 29
      Width = 38
      Height = 18
      HelpContext = 356003
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblDescription: TLabel
      Left = 31
      Top = 74
      Width = 70
      Height = 18
      HelpContext = 356004
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Description'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Rate_Label: TLabel
      Left = 70
      Top = 124
      Width = 31
      Height = 18
      HelpContext = 356005
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Rate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label1: TLabel
      Left = 13
      Top = 155
      Width = 80
      Height = 15
      HelpContext = 356020
      Caption = 'Sub Taxcodes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Name1: TDBEdit
      Left = 112
      Top = 27
      Width = 121
      Height = 23
      HelpContext = 356013
      DataField = 'Name'
      DataSource = dsTaxcodes
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object grdSubTaxcodes: TwwDBGrid
      Left = 13
      Top = 174
      Width = 570
      Height = 156
      HelpContext = 356022
      ControlType.Strings = (
        'PercentageOn;CustomEdit;cboPercentageOn;F'
        'SubTaxCode;CustomEdit;cboSubTaxCode;F'
        'UOM;CustomEdit;cboUOM;F')
      Selected.Strings = (
        'SubTaxCode'#9'8'#9'Code'#9#9
        'Percentage'#9'7'#9'Percent'#9#9
        'PercentageOn'#9'15'#9'Percentage On'#9#9
        'CapAmount'#9'10'#9'Cap Amt'#9'F'#9
        'AmountPerUnit'#9'10'#9'Per Unit'#9#9
        'UOM'#9'8'#9'Units'#9#9
        'ThresholdAmount'#9'10'#9'Threshold Amt'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dssTaxCodeLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      ParentFont = False
      TabOrder = 3
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnKeyPress = grdSubTaxcodesKeyPress
      FooterColor = clWhite
      object grdSubTaxcodesIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 22
        HelpContext = 356023
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
        OnClick = grdSubTaxcodesIButtonClick
      end
    end
    object cboSubTaxCode: TwwDBLookupCombo
      Left = 112
      Top = 283
      Width = 68
      Height = 23
      HelpContext = 356024
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Code'#9'10'#9'Code'#9'F'
        'Description'#9'20'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F')
      DataField = 'SubTaxCode'
      DataSource = dssTaxCodeLines
      LookupTable = qrySubTaxCode
      LookupField = 'Code'
      Options = [loTitles]
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboSubTaxCodeCloseUp
    end
    object cboPercentageOn: TwwDBLookupCombo
      Left = 205
      Top = 291
      Width = 58
      Height = 23
      HelpContext = 356025
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'SubTaxCode'#9'10'#9'Code'#9'F')
      DataField = 'PercentageOn'
      DataSource = dssTaxCodeLines
      LookupTable = QryPercentageOn
      LookupField = 'SubTaxCode'
      TabOrder = 5
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboPercentageOnDropDown
      OnCloseUp = cboPercentageOnCloseUp
    end
    object edtRate: TwwDBEdit
      Left = 111
      Top = 122
      Width = 121
      Height = 23
      HelpContext = 356026
      DataField = 'cRate'
      DataSource = dsTaxcodes
      ReadOnly = True
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnEnter = edtRateEnter
      OnExit = edtRateExit
    end
    object edtDescription: TDBEdit
      Left = 112
      Top = 72
      Width = 290
      Height = 23
      HelpContext = 356009
      DataField = 'Description'
      DataSource = dsTaxcodes
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object cboUOM: TwwDBLookupCombo
      Left = 403
      Top = 219
      Width = 94
      Height = 23
      HelpContext = 356042
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'UnitName'#9'15'#9'UnitName'#9'F')
      DataField = 'UOM'
      DataSource = dssTaxCodeLines
      LookupTable = qryUOMLookup
      LookupField = 'UnitName'
      TabOrder = 6
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
    end
  end
  object DNMPanel3: TDNMPanel [6]
    Left = 0
    Top = 395
    Width = 996
    Height = 50
    HelpContext = 356027
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      996
      50)
    object Label3: TLabel
      Left = 943
      Top = 8
      Width = 40
      Height = 12
      HelpContext = 356006
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Active'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitLeft = 761
    end
    object cmdCancel: TDNMSpeedButton
      Left = 613
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 356028
      Action = actCancel
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
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      AutoDisableParentOnclick = True
    end
    object cmdOk: TDNMSpeedButton
      Left = 296
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 356029
      Action = actSave
      Anchors = []
      Caption = '&Save'
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
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      AutoDisableParentOnclick = True
    end
    object cmdNew: TDNMSpeedButton
      Left = 454
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 356030
      Action = actNew
      Anchors = []
      Caption = '&New'
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      AutoDisableParentOnclick = True
    end
    object chkActive: TwwCheckBox
      Left = 957
      Top = 23
      Width = 14
      Height = 14
      HelpContext = 356008
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
      NullAndBlankState = cbChecked
      Anchors = [akRight, akBottom]
      Checked = True
      Color = 13039615
      DataField = 'Active'
      DataSource = dsTaxcodes
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      State = cbChecked
      TabOrder = 3
    end
  end
  object pnlCAtegoryDetails: TDNMPanel [7]
    Left = 596
    Top = 50
    Width = 400
    Height = 345
    HelpContext = 356031
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object lblTaxcodeLocationCategory: TLabel
      Left = 8
      Top = 32
      Width = 51
      Height = 15
      HelpContext = 356032
      Alignment = taRightJustify
      Caption = 'Category'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object bvlTaxcodeLocationCategory: TBevel
      Left = 68
      Top = 4
      Width = 328
      Height = 70
      HelpContext = 356033
    end
    object lblLocations: TLabel
      Left = 8
      Top = 86
      Width = 56
      Height = 15
      HelpContext = 356034
      Caption = 'Locations'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object grpTaxcodeLocationCategory: TwwRadioGroup
      Left = 76
      Top = 5
      Width = 316
      Height = 62
      HelpContext = 356035
      DisableThemes = False
      Columns = 3
      DataField = 'TaxcodeLocationCategory'
      DataSource = dsTaxcodes
      Items.Strings = (
        ' Country'
        ' State'
        ' City'
        ' Postcode'
        'Overseas')
      TabOrder = 0
      Values.Strings = (
        'C'
        'S'
        'L'
        'P'
        'O')
      OnClick = grpTaxcodeLocationCategoryClick
    end
    object grdTaxcodelocations: TwwDBGrid
      Left = 7
      Top = 113
      Width = 386
      Height = 224
      HelpContext = 356036
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      Selected.Strings = (
        'LocationValue'#9'42'#9'Name'
        'Active'#9'1'#9'Active')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      DataSource = dstaxcodelocations
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = []
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect]
      ParentFont = False
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      FooterColor = clWhite
      object btnTaxcodelocations: TwwIButton
        Left = 0
        Top = 0
        Width = 25
        Height = 22
        HelpContext = 356037
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
        OnClick = btnTaxcodelocationsClick
      end
    end
    object btnLocations: TDNMSpeedButton
      Left = 237
      Top = 81
      Width = 154
      Height = 27
      HelpContext = 356038
      Caption = 'Choose Locations'
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
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnLocationsClick
    end
  end
  object DNMPanel1: TDNMPanel [8]
    Left = 0
    Top = 0
    Width = 996
    Height = 50
    HelpContext = 356018
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      50)
    object pnlTitle: TDNMPanel
      Left = 403
      Top = 5
      Width = 191
      Height = 40
      HelpContext = 356014
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
        Width = 187
        Height = 36
        HelpContext = 356015
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
          Width = 187
          Height = 36
          HelpContext = 356016
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Tax Code'
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
  inherited dlgReportSelect: TSelectionDialog
    Left = 1
    Top = 2
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 65
    Top = 2
  end
  inherited MyConnection: TERPConnection
    Server = 'Localhost'
    Connected = True
    Left = 202
    Top = 7
  end
  inherited DataState: TDataState
    Left = 1
    Top = 26
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 129
    Top = 2
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102007C00AC0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 66
    Top = 394
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 304
    Top = 392
  end
  object dsTaxcodes: TDataSource
    DataSet = qryTaxcodes
    Left = 105
    Top = 430
  end
  object qryTaxcodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblTaxCodes'
      'WHERE TaxCodeID=:TCID;')
    AfterOpen = qryTaxcodesAfterOpen
    OnCalcFields = qryTaxcodesCalcFields
    Left = 105
    Top = 398
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TCID'
      end>
    object qryTaxcodesTaxCodeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TaxCodeID'
      Origin = 'tbltaxcodes.TaxCodeID'
    end
    object qryTaxcodesName: TWideStringField
      FieldName = 'Name'
      Origin = 'tbltaxcodes.Name'
      Size = 15
    end
    object qryTaxcodesDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'tbltaxcodes.Description'
      Size = 255
    end
    object qryTaxcodesRate: TFloatField
      FieldName = 'Rate'
      Origin = 'tbltaxcodes.Rate'
    end
    object qryTaxcodesRegionID: TWordField
      FieldName = 'RegionID'
      Origin = 'tbltaxcodes.RegionID'
    end
    object qryTaxcodesActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tbltaxcodes.Active'
      FixedChar = True
      Size = 1
    end
    object qryTaxcodesEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tbltaxcodes.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryTaxcodesGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tbltaxcodes.GlobalRef'
      Size = 255
    end
    object qryTaxcodesTaxFormula: TWideStringField
      FieldName = 'TaxFormula'
      Origin = 'tbltaxcodes.TaxFormula'
      Size = 255
    end
    object qryTaxcodescRate: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cRate'
      DisplayFormat = '##0.000%'
      Calculated = True
    end
    object qryTaxcodesmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryTaxcodesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryTaxcodesTaxcodeLocationCategory: TWideStringField
      FieldName = 'TaxcodeLocationCategory'
      FixedChar = True
      Size = 1
    end
  end
  object ActionList: TActionList
    Left = 24
    Top = 402
    object actSave: TAction
      Caption = '&Save'
      HelpContext = 356039
      OnExecute = actSaveExecute
    end
    object actNew: TAction
      Caption = '&New'
      HelpContext = 356040
      OnExecute = actNewExecute
    end
    object actCancel: TAction
      Caption = '&Cancel'
      HelpContext = 356041
      OnExecute = actCancelExecute
    end
  end
  object QryTaxCodeLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblTaxCodeLines'
      'WHERE TaxCodeID=:TCID'
      'Order by ID')
    Left = 145
    Top = 398
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TCID'
      end>
    object QryTaxCodeLinesSubTaxCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 8
      FieldName = 'SubTaxCode'
      Origin = 'tbltaxcodelines.SubTaxCode'
      Size = 10
    end
    object QryTaxCodeLinesPercentage: TFloatField
      DisplayLabel = 'Percent'
      DisplayWidth = 7
      FieldName = 'Percentage'
      Origin = 'tbltaxcodelines.Percentage'
    end
    object QryTaxCodeLinesPercentageOn: TWideStringField
      DisplayLabel = 'Percentage On'
      DisplayWidth = 15
      FieldName = 'PercentageOn'
      Origin = 'tbltaxcodelines.PercentageOn'
      Size = 255
    end
    object QryTaxCodeLinesCapAmount: TFloatField
      DisplayLabel = 'Cap Amt'
      DisplayWidth = 10
      FieldName = 'CapAmount'
      Origin = 'tbltaxcodelines.CapAmount'
      currency = True
    end
    object QryTaxCodeLinesAmountPerUnit: TFloatField
      DisplayLabel = 'Per Unit'
      DisplayWidth = 10
      FieldName = 'AmountPerUnit'
      Origin = 'tbltaxcodelines.AmountPerUnit'
      currency = True
    end
    object QryTaxCodeLinesUOM: TWideStringField
      DisplayLabel = 'Units'
      DisplayWidth = 8
      FieldName = 'UOM'
      Origin = 'tbltaxcodelines.UOM'
      Size = 255
    end
    object QryTaxCodeLinesThresholdAmount: TFloatField
      DisplayLabel = 'Threshold Amt'
      DisplayWidth = 10
      FieldName = 'ThresholdAmount'
      Origin = 'tbltaxcodelines.ThresholdAmount'
      currency = True
    end
    object QryTaxCodeLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tbltaxcodelines.ID'
      Visible = False
    end
    object QryTaxCodeLinesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tbltaxcodelines.GlobalRef'
      Visible = False
      Size = 255
    end
    object QryTaxCodeLinesTaxCodeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TaxCodeID'
      Origin = 'tbltaxcodelines.TaxCodeID'
      Visible = False
    end
    object QryTaxCodeLinesSubTaxID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SubTaxID'
      Origin = 'tbltaxcodelines.SubTaxID'
      Visible = False
    end
    object QryTaxCodeLinesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tbltaxcodelines.msTimeStamp'
      Visible = False
    end
    object QryTaxCodeLinesPercentageOnID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PercentageOnID'
      Origin = 'tbltaxcodelines.PercentageOnID'
      Visible = False
    end
    object QryTaxCodeLinesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tbltaxcodelines.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dssTaxCodeLines: TDataSource
    DataSet = QryTaxCodeLines
    Left = 145
    Top = 430
  end
  object QryPercentageOn: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ID, SubTaxcode '
      'FROM tblTaxCodeLines'
      'WHERE TaxCodeID =  :TaxCodeID and SubTaxID <> :SubTaxID'
      'union all '
      'Select 0 , '#39'Amount-Ex'#39)
    Left = 209
    Top = 398
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TaxCodeID'
      end
      item
        DataType = ftUnknown
        Name = 'SubTaxID'
      end>
    object QryPercentageOnID: TLargeintField
      FieldName = 'ID'
    end
    object QryPercentageOnSubTaxcode: TWideStringField
      FieldName = 'SubTaxcode'
      Size = 10
    end
  end
  object qrySubTaxCode: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tblsubtaxcode'
      'WHERE Active ='#39'T'#39' and '
      'REgionID= :xREgionID')
    BeforeOpen = qrySubTaxCodeBeforeOpen
    Left = 177
    Top = 398
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xREgionID'
      end>
    object qrySubTaxCodeCode: TWideStringField
      DisplayWidth = 10
      FieldName = 'Code'
      Origin = 'tblsubtaxcode.Code'
      Size = 255
    end
    object qrySubTaxCodeDescription: TWideStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Origin = 'tblsubtaxcode.Description'
      Size = 100
    end
    object qrySubTaxCodeActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblsubtaxcode.Active'
      FixedChar = True
      Size = 1
    end
    object qrySubTaxCodeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblsubtaxcode.ID'
      Visible = False
    end
  end
  object qrytaxcodelocations: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT *'
      'FROM tbltaxcodelocations'
      'WHERE TaxCodeID=:TCID'
      'Order by ID')
    Left = 257
    Top = 398
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TCID'
      end>
    object qrytaxcodelocationsLocationValue: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 42
      FieldName = 'LocationValue'
      Origin = 'tbltaxcodelocations.LocationValue'
      Size = 255
    end
    object qrytaxcodelocationsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tbltaxcodelocations.Active'
      FixedChar = True
      Size = 1
    end
    object qrytaxcodelocationsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tbltaxcodelocations.ID'
      Visible = False
    end
    object qrytaxcodelocationsGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tbltaxcodelocations.GlobalRef'
      Visible = False
      Size = 255
    end
    object qrytaxcodelocationsTaxCodeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TaxCodeID'
      Origin = 'tbltaxcodelocations.TaxCodeID'
      Visible = False
    end
    object qrytaxcodelocationsmstimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimeStamp'
      Origin = 'tbltaxcodelocations.mstimeStamp'
      Visible = False
    end
    object qrytaxcodelocationsmsUpdateSitecode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSitecode'
      Origin = 'tbltaxcodelocations.msUpdateSitecode'
      Visible = False
      Size = 3
    end
  end
  object dstaxcodelocations: TDataSource
    DataSet = qrytaxcodelocations
    Left = 257
    Top = 430
  end
  object qryUOMLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select distinct UnitName '
      'from tblunitsofmeasure'
      
        'left join tblparts on tblparts.PARTSID = tblunitsofmeasure.PartI' +
        'D '
      
        'where IfNull(tblunitsofmeasure.PartID,0) = 0 or (tblparts.Active' +
        ' = "T" and tblparts.Discontinued = "F")'
      'order by UnitName')
    Left = 400
    Top = 400
  end
end
