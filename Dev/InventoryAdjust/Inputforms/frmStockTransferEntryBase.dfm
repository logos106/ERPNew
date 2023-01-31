inherited fmStockTransferEntryBase: TfmStockTransferEntryBase
  Left = 74
  Top = 62
  HelpContext = 622000
  ActiveControl = cboUOM
  Caption = 'Stock Transfer Base'
  ClientHeight = 565
  ClientWidth = 994
  OldCreateOrder = True
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 1000
  ExplicitHeight = 594
  DesignSize = (
    994
    565)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 409
    Width = 994
    HelpContext = 622016
    ExplicitTop = 515
    ExplicitWidth = 998
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 12
  end
  inherited imgGridWatermark: TImage
    Picture.Data = {00}
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 56
  end
  object lblMessage: TLabel [5]
    Left = 0
    Top = 409
    Width = 994
    Height = 15
    HelpContext = 622050
    Align = alBottom
    Alignment = taCenter
    Caption = 'lblMessage'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    Visible = False
    ExplicitWidth = 65
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 994
    Height = 103
    HelpContext = 622051
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      994
      103)
    object lblprocessed: TLabel
      Left = 751
      Top = 19
      Width = 82
      Height = 19
      HelpContext = 622014
      Caption = 'Processed'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
    end
    object Label160: TLabel
      Left = 886
      Top = 6
      Width = 79
      Height = 18
      HelpContext = 622009
      AutoSize = False
      Caption = 'Transfer No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label3: TLabel
      Left = 871
      Top = 54
      Width = 33
      Height = 18
      HelpContext = 622010
      Caption = 'Date'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblEnforceUOM: TLabel
      Left = 744
      Top = 59
      Width = 89
      Height = 32
      Hint = 
        'When Ticked this is only showing the Quantity of the selected Un' +
        'it of Measure. Its not displaying the Quantity any other Unit of' +
        ' Measure  for this product'
      HelpContext = 622012
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Show only as Unit of Measure'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel2: TBevel
      Left = 737
      Top = 53
      Width = 122
      Height = 44
      HelpContext = 622006
      Shape = bsFrame
    end
    object Label6: TLabel
      Left = 632
      Top = 60
      Width = 77
      Height = 30
      Hint = 
        'When Ticked this is only showing the Quantity of the selected Un' +
        'it of Measure. Its not displaying the Quantity any other Unit of' +
        ' Measure  for this product'
      HelpContext = 622017
      Alignment = taRightJustify
      Caption = 'Hide Formula Columns'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel1: TBevel
      Left = 631
      Top = 53
      Width = 107
      Height = 44
      HelpContext = 622018
      Shape = bsFrame
    end
    object lblVia: TLabel
      Left = 517
      Top = 58
      Width = 18
      Height = 15
      HelpContext = 622020
      Caption = 'Via'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label48: TLabel
      Left = 340
      Top = 56
      Width = 76
      Height = 18
      HelpContext = 622021
      AutoSize = False
      Caption = 'Employee'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label1: TLabel
      Left = 159
      Top = 58
      Width = 63
      Height = 15
      HelpContext = 622011
      Caption = 'To Account'
      Transparent = True
    end
    object lblTransferFrom: TLabel
      Left = 10
      Top = 58
      Width = 80
      Height = 15
      HelpContext = 622007
      Caption = 'Transfer From'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object pnlTitle: TDNMPanel
      Left = 285
      Top = 6
      Width = 452
      Height = 45
      HelpContext = 622037
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
        Width = 448
        Height = 41
        HelpContext = 622038
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
          Width = 448
          Height = 41
          HelpContext = 622039
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Stock Transfer Base'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 405
        end
      end
    end
    object txtCustomID: TDBEdit
      Left = 884
      Top = 23
      Width = 78
      Height = 23
      HelpContext = 622022
      DataField = 'TransferEntryID'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      OnEnter = txtCustomIDEnter
    end
    object wwDBDateTimePicker1: TwwDBDateTimePicker
      Left = 871
      Top = 74
      Width = 116
      Height = 23
      HelpContext = 622023
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'DateTransferred'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 2
    end
    object chkEnforceUOM: TwwCheckBox
      Left = 839
      Top = 67
      Width = 13
      Height = 16
      HelpContext = 622033
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
      DataField = 'EnforceUOM'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnEnter = chkEnforceUOMEnter
      OnExit = chkEnforceUOMExit
    end
    object chkHideFormulacolumns: TwwCheckBox
      Left = 715
      Top = 67
      Width = 13
      Height = 16
      Hint = 
        'To Add or remove fomula columns :  Preference -> Inventory -> Pr' +
        'oducts: fields to calculate Quantity'
      HelpContext = 622045
      DisableThemes = False
      AlwaysTransparent = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 4
      OnClick = chkHideFormulacolumnsClick
    end
    object cboVia: TwwDBLookupCombo
      Left = 517
      Top = 74
      Width = 111
      Height = 23
      HelpContext = 622049
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ShippingMethod'#9'25'#9'ShippingMethod'#9'F')
      DataField = 'Shipping'
      DataSource = DSMaster
      LookupTable = cboViaQry
      LookupField = 'ShippingMethod'
      ParentFont = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboEmployee: TwwDBLookupCombo
      Left = 340
      Top = 74
      Width = 173
      Height = 23
      HelpContext = 622034
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EmployeeName'#9'25'#9'EmployeeName'#9'F')
      DataField = 'EmployeeName'
      DataSource = DSMaster
      LookupTable = cboEmployeeLookup
      LookupField = 'EmployeeName'
      ParentFont = False
      TabOrder = 6
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboAccount: TwwDBLookupCombo
      Left = 155
      Top = 74
      Width = 173
      Height = 23
      HelpContext = 622032
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'25'#9'Account Name'#9'F'
        'AccountType'#9'20'#9'Account Type'#9'F')
      DataField = 'AccountID'
      DataSource = DSMaster
      LookupTable = cboAccountQry
      LookupField = 'AccountID'
      ParentFont = False
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboClassFrom: TwwDBLookupCombo
      Left = 10
      Top = 74
      Width = 138
      Height = 23
      HelpContext = 622036
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'25'#9'Class'#9'T')
      DataField = 'TransferFromClassName'
      DataSource = DSMaster
      LookupTable = cboClassFromQry
      LookupField = 'Classname'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      Style = csDropDownList
      ParentFont = False
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDropDown = cboClassFromDropDown
      OnCloseUp = cboClassFromCloseUp
      OnEnter = cboClassFromEnter
    end
  end
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 424
    Width = 994
    Height = 141
    HelpContext = 622052
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      994
      141)
    object Label5: TLabel
      Left = 13
      Top = 8
      Width = 82
      Height = 18
      HelpContext = 622015
      Caption = 'Description'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lbMemo: TLabel
      Left = 41
      Top = 47
      Width = 54
      Height = 18
      HelpContext = 622008
      Caption = 'Reason'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 940
      Top = 98
      Width = 43
      Height = 15
      Hint = 
        'When Ticked this is only showing the Quantity of the selected Un' +
        'it of Measure. Its not displaying the Quantity any other Unit of' +
        ' Measure  for this product'
      HelpContext = 622013
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Deleted'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object wwDBEdit1: TwwDBEdit
      Left = 101
      Top = 6
      Width = 733
      Height = 23
      HelpContext = 622040
      DataField = 'Description'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
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
    object DBMemo1: TDBMemo
      Left = 104
      Top = 35
      Width = 883
      Height = 43
      HelpContext = 622041
      DataField = 'Notes'
      DataSource = DSMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object btnCompleted: TDNMSpeedButton
      Left = 61
      Top = 103
      Width = 87
      Height = 26
      HelpContext = 622028
      Caption = '&Process'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnCompletedClick
    end
    object btnhold: TDNMSpeedButton
      Left = 191
      Top = 103
      Width = 87
      Height = 26
      HelpContext = 622031
      Caption = '&Hold'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnholdClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 322
      Top = 103
      Width = 87
      Height = 26
      HelpContext = 622029
      Caption = 'Prin&t'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnPrintClick
    end
    object btncopy: TDNMSpeedButton
      Left = 453
      Top = 103
      Width = 87
      Height = 26
      HelpContext = 622044
      Caption = '&Copy'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btncopyClick
    end
    object cmdPrintPick: TDNMSpeedButton
      Left = 583
      Top = 103
      Width = 87
      Height = 26
      HelpContext = 622042
      Caption = 'Pic&king Slip'
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
      TabOrder = 6
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdPrintPickClick
    end
    object cmdDeliveryDocket: TDNMSpeedButton
      Left = 714
      Top = 103
      Width = 87
      Height = 26
      HelpContext = 622043
      Caption = '&Delivery Doc'
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
      TabOrder = 7
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdDeliveryDocketClick
    end
    object btnClose: TDNMSpeedButton
      Left = 845
      Top = 103
      Width = 87
      Height = 26
      HelpContext = 622030
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 8
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object wwCheckBox1: TwwCheckBox
      Left = 959
      Top = 113
      Width = 13
      Height = 16
      HelpContext = 622035
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
      DataField = 'Deleted'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnEnter = wwCheckBox1Enter
      OnExit = Setaccesslevel
    end
    object pnlChooseRpt: TDNMPanel
      Left = 840
      Top = 6
      Width = 144
      Height = 23
      HelpContext = 622046
      BevelOuter = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      object chkChooseRpt: TCheckBox
        Left = 11
        Top = 3
        Width = 121
        Height = 17
        HelpContext = 622048
        TabStop = False
        Caption = 'Choose Template'
        TabOrder = 0
      end
    end
  end
  object pnlDetail: TDNMPanel [8]
    Left = 0
    Top = 103
    Width = 994
    Height = 306
    HelpContext = 622024
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    Transparent = False
    object lblNote: TLabel
      Left = 0
      Top = 289
      Width = 994
      Height = 17
      HelpContext = 622026
      Align = alBottom
      Alignment = taCenter
      AutoSize = False
      Caption = 
        '(Use '#39'~'#39' for Barcode Selection)                    (Hold down '#39#39 +
        'CTRL'#39#39' and F3 to open the quantity Location report for the  clas' +
        's.)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      WordWrap = True
      ExplicitTop = 274
      ExplicitWidth = 979
    end
    object SubformDetails: TwwDBGrid
      Left = 0
      Top = 0
      Width = 994
      Height = 289
      HelpContext = 622027
      ControlInfoInDataset = False
      ControlType.Strings = (
        'ClassNameTo;CustomEdit;cboClassTo;F'
        'ProductName;CustomEdit;cboProduct;F'
        'UOM;CustomEdit;cboUOM;F'
        'CustomerName;CustomEdit;cboClient;F'
        'BinLocationFrom;CustomEdit;cboBinLocation;F'
        'BinLocationTo;CustomEdit;cboBinLocationTo;F'
        'BatchNo;CustomEdit;cboBatchnumber;F'
        'BatchNoFrom;CustomEdit;cboBatchnumberFrom;F'
        'BatchNoTo;CustomEdit;cbobatchnumberto;F'
        'PartBarcode;CustomEdit;cboBarcode;F')
      Selected.Strings = (
        'PartBarcode'#9'10'#9'Product Barcode'#9'F'#9
        'ProductName'#9'15'#9'Product Name'#9'F'#9
        'ProductDesc'#9'25'#9'Description'#9'F'#9
        'UOM'#9'5'#9'UOM'#9'F'#9
        'UOMAvailableQty'#9'7'#9'Available'#9'T'#9'Quantity'
        'FormulaQtyValue'#9'10'#9'FormulaQtyValue'#9'F'#9'Quantity'
        'FormulaQtyValue1'#9'10'#9'FormulaQtyValue1'#9'F'#9'Quantity'
        'FormulaQtyValue2'#9'10'#9'FormulaQtyValue2'#9'F'#9'Quantity'
        'FormulaQtyValue3'#9'10'#9'FormulaQtyValue3'#9'F'#9'Quantity'
        'FormulaQtyValue4'#9'10'#9'FormulaQtyValue4'#9'F'#9'Quantity'
        'FormulaQtyValue5'#9'10'#9'FormulaQtyValue5'#9'F'#9'Quantity'
        'UOMTransferQty'#9'7'#9'Transfer'#9'F'#9'Quantity'
        'ClassNameTo'#9'10'#9'Transfer To'#9'F'#9
        'AssetValue'#9'10'#9'Cost'#9'T'#9
        'UOMcost'#9'10'#9'Unit Cost'#9'F'#9
        'TotalCost'#9'10'#9'Total Cost'#9'F'#9
        'CustomerName'#9'20'#9'Customer Job'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoSearchOwnerForm, ecoDisableDateTimePicker, ecoDisableEditorIfReadOnly]
      Align = alClient
      DataSource = DSDetails
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter, dgRowResize]
      ParentFont = False
      PopupMenu = popCustomiseGrid
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = True
      OnCalcCellColors = SubformDetailsCalcCellColors
      OnCalcTitleAttributes = SubformDetailsCalcTitleAttributes
      OnDblClick = SubformDetailsDblClick
      OnEnter = SubformDetailsEnter
      OnKeyDown = SubformDetailsDown
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object SubformDetailsIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 19
        Height = 34
        HelpContext = 622001
        AllowAllUp = True
        Glyph.Data = {
          C6030000424DC603000000000000360000002800000010000000130000000100
          18000000000090030000120B0000120B00000000000000000000CCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC0C0C0CBCBCBCBCBCBCBCBCBCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCBCBCBCBCBCBCCCCCCD7D7D7C0C0C0
          666699969696969696999999CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCB9999
          99868686999999CBCBCBDDDDDDB2B2B2333399666666777777868686C0C0C0CC
          CCCCCCCCCCCCCCCCCCCCCCCBCBCB777777666666868686CBCBCBDDDDDDB2B2B2
          333399333366666666808080969696CBCBCBCCCCCCCCCCCCD7D7D7C0C0C03333
          99777777999999CBCBCBD7D7D7CBCBCB808080333366000080333366868686C0
          C0C0CCCCCCCCCCCCC0C0C0808080333399B2B2B2D7D7D7CCCCCCCBCBCBE6E6E6
          C0C0C0333399000080333366808080999999C0C0C06666993333993333667777
          77C0C0C0D7D7D7CCCCCCC9CACBCCCCCCCCCCCC33339900008033339966666686
          8686B2B2B2333399000080333366969696CBCBCBD7D7D7CCCCCCCBCBCCCCCCCC
          B2B2B2808080333366000080333366777777777777333366000080333399C0C0
          C0CCCCCCCCCCCCCCCCCCCACACCCCCCCCCCCCCCC0C0C033339900008000008000
          0080000080000080333399C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC9C9CBCCCCCC
          CCCCD1CCCCCC9696966666660000800000800000805F5F5F969696CCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCC7C7C9C0C0C0C0C0C096969666666600008000
          0080333366777777999999C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCC3C3CCB8B8B8
          868686808080666699333399333399000080333366666666808080969696C0C0
          C0CCCCCCCCCCCCCCCCCCA4A0A0868686333399666699B2B2B2CCCCCCC0C0C080
          8080333366333366333366777777969696C0C0C0CCCCCCCCCCCCC0C0C0C0C0C0
          B2B2B2C0C0C0CCCCCCD7D7D7D7D7D7C0C0C07777773333660000803333668080
          80868686999999CBCBCBD7D7D7D7D7D7DDDDDDDDDDDDCCCCCCCCCCCCCCCCCCCC
          CCCC999999666699333399333366777777868686999999CBCBCBCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCBCBCBCCCCCCB2B2B23333993366
          99B2B2B2CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCCCCCCCCCCCCCCCCCC0C0C0C0C0C0CCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
          CCCCCCC5C5C5CCCCCCCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD7D7D7D7D7
          D7CCCCCCCCCCCCCCCCCC}
        OnClick = SubformDetailsIButtonClick
      end
    end
    object cboProduct: TERPDbLookupCombo
      Left = 319
      Top = 33
      Width = 124
      Height = 23
      HelpContext = 622002
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Product Name'#9'F'
        'Manuf'#9'15'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'15'#9'Dept'#9'F'
        'PartsDescription'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F'
        'PreferedSupp'#9'20'#9'Preferred Supplier'#9'F'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      DataField = 'ProductName'
      DataSource = DSDetails
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = cboProductDblClick
      LookupFormClassName = 'TProductListExpressGUI'
      EditFormClassName = 'TfrmParts'
      LookupFormKeyStringFieldName = 'ProductName'
      LookupComboType = ctProduct
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = True
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'ProductID'
      LookupIDField = 'PartsID'
      LookupFieldAlt = 'ProductPrintName'
    end
    object cboClassTo: TwwDBLookupCombo
      Left = 319
      Top = 62
      Width = 124
      Height = 26
      HelpContext = 622003
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'25'#9'ClassName'#9'F')
      DataField = 'ClassNameTo'
      DataSource = DSDetails
      LookupTable = cboClassToQry
      LookupField = 'ClassName'
      Options = [loTitles]
      Style = csDropDownList
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboClient: TwwDBLookupCombo
      Left = 319
      Top = 91
      Width = 124
      Height = 23
      HelpContext = 622004
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'StopCreditImage;ImageIndex;Shrink To Fit')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'70'#9'Company'#9'F'
        'StopCreditImage'#9'1'#9'Stop Credit'#9'T')
      DataField = 'customername'
      DataSource = DSDetails
      LookupTable = cboClientLookup
      LookupField = 'Company'
      Options = [loTitles, loSearchOnBackspace]
      Style = csDropDownList
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboUOM: TwwDBLookupCombo
      Left = 319
      Top = 120
      Width = 121
      Height = 23
      HelpContext = 622005
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'UnitName'#9'15'#9'Unit Name'#9'F')
      DataField = 'ClassNameTo'
      DataSource = DSDetails
      LookupTable = qryUOM
      LookupField = 'UnitName'
      Options = [loTitles]
      Style = csDropDownList
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboPrintProduct: TERPDbLookupCombo
      Left = 327
      Top = 41
      Width = 124
      Height = 23
      HelpContext = 622053
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Product Name'#9'F'
        'Manuf'#9'15'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'15'#9'Dept'#9'F'
        'PartsDescription'#9'35'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9'F'
        'PreferedSupp'#9'20'#9'Preferred Supplier'#9'F'
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F')
      DataField = 'ProductName'
      DataSource = DSDetails
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      ParentFont = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnDblClick = cboProductDblClick
      LookupFormClassName = 'TProductListExpressGUI'
      EditFormClassName = 'TfrmParts'
      LookupFormKeyStringFieldName = 'ProductName'
      LookupComboType = ctProduct
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = True
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'ProductID'
      LookupIDField = 'PartsID'
      LookupFieldAlt = 'ProductPrintName'
    end
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    inherited CustomiseGrid: TMenuItem
      Visible = False
    end
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102001C01900110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object cboProductQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT PARTSID,PARTTYPE, p.PRODUCTGROUP,PARTNAME,'
      'PARTSDESCRIPTION,'
      'ReorderPoint, PreferredLevel, ReorderAmount,'
      'SNTracking, p.Active,'
      'if((LOCATE('#39'^'#39',p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')+1)) >0,'
      'MID(p.PRODUCTGROUP,LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1)+1,char_length(p.PRODUCTGROUP)-'
      
        'LOCATE('#39'^'#39',p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')+1)),  Null) ' +
        ' AS '#39'Manuf'#39' ,'
      'MID(p.PRODUCTGROUP, InStr(p.PRODUCTGROUP,'#39'^'#39')+1 ,'
      'If(LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1) - InStr(p.PRODUCTGROUP,'#39'^'#39') >0,'
      'LOCATE('#39'^'#39',p.PRODUCTGROUP,'
      'InStr(p.PRODUCTGROUP,'#39'^'#39')+1)-1 - InStr(p.PRODUCTGROUP,'#39'^'#39'),'
      'IF(InStr(p.PRODUCTGROUP,'#39'^'#39')<>0,'
      
        'char_length(p.PRODUCTGROUP) - InStr(p.PRODUCTGROUP,'#39'^'#39'),0))) AS ' +
        #39'Type'#39' ,'
      'If(InStr(p.PRODUCTGROUP,'#39'^'#39') -1 >0,'
      'Left(p.PRODUCTGROUP,InStr(p.PRODUCTGROUP,'#39'^'#39')-1),'
      'p.PRODUCTGROUP) AS '#39'Dept'#39','
      'p.AvgCost,p.Cost1,'
      'p.ASSETACCNT'
      'FROM tblparts as p'
      'INNER Join tblProductclasses PC ON p.PARTSID = PC.ProductID'
      'WHERE P.Active = '#39'T'#39' AND (PARTTYPE='#39'INV'#39')'
      'And PC.ClassID = :ClassID'
      'ORDER BY PC.ClassID,PARTNAME;')
    Options.LongStrings = False
    Options.FlatBuffers = True
    Left = 454
    Top = 135
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ClassID'
        Value = 0
      end>
  end
  object cboClassToQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      
        'FROM tblClass  WHERE tblClass.ClassName Is Not Null And tblClass' +
        '.Active='#39'T'#39
      'ORDER BY tblClass.ClassName;')
    Options.LongStrings = False
    Options.FlatBuffers = True
    Left = 454
    Top = 164
  end
  object cboClientLookup: TERPQuery
    SQL.Strings = (
      'SELECT'
      'C1.ClientID as ClientID,'
      'C1.Company as Company,'
      'IF(C1.IsJob = '#39'T'#39',C2.StopCredit,C1.StopCredit) AS StopCredit'
      'FROM tblclients as C1'
      'LEFT JOIN tblClients as C2 on C1.ParentClientID = C2.ClientID'
      'WHERE C1.Customer='#39'T'#39' AND char_length(C1.Company)>0'
      'AND (C1.Active = '#39'T'#39' OR C1.ClientID=:xClientID)')
    Options.LongStrings = False
    Options.FlatBuffers = True
    Left = 454
    Top = 194
    ParamData = <
      item
        DataType = ftInteger
        Name = 'xClientID'
        Value = 0
      end>
    object cboClientLookupCompany: TWideStringField
      DisplayWidth = 70
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object cboClientLookupStopCreditImage: TIntegerField
      DisplayLabel = 'Stop Credit'
      DisplayWidth = 1
      FieldKind = fkCalculated
      FieldName = 'StopCreditImage'
      Calculated = True
    end
    object cboClientLookupClientID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
      ReadOnly = True
      Visible = False
    end
    object cboClientLookupStopCredit: TWideStringField
      FieldName = 'StopCredit'
      Origin = '.StopCredit'
      Visible = False
      Size = 1
    end
  end
  object qryUOM: TERPQuery
    SQL.Strings = (
      '/*SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND (ifnull(U.PartID,0) = :xPartID or U.Pa' +
        'rtID = 0) '
      'Group By U.UnitName Desc'
      'Order By UnitID desc ,U.UnitName'
      '*/'
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :xPartID'
      'union all '
      'SELECT  '
      'U.UnitID,'
      'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :xPartID )'
      'Order By UnitID desc ,UnitName;')
    Options.LongStrings = False
    Options.FlatBuffers = True
    Left = 454
    Top = 224
    ParamData = <
      item
        DataType = ftInteger
        Name = 'xPartID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'xPartID'
        Value = 0
      end>
    object qryUOMUnitName: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 15
      FieldName = 'UnitName'
      Size = 15
    end
    object qryUOMMultiplier: TFloatField
      FieldName = 'Multiplier'
      Visible = False
    end
    object qryUOMUnitID: TIntegerField
      FieldName = 'UnitID'
      Visible = False
    end
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblstocktransferEntry')
    Left = 27
    Top = 332
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblstocktransferEntry.GlobalRef'
      Size = 255
    end
    object tblMasterTransferEntryID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TransferEntryID'
      Origin = 'tblstocktransferEntry.TransferEntryID'
    end
    object tblMasterTransferFromClassID: TIntegerField
      FieldName = 'TransferFromClassID'
      Origin = 'tblstocktransferEntry.TransferFromClassID'
    end
    object tblMasterTransferFromClassName: TWideStringField
      FieldName = 'TransferFromClassName'
      Origin = 'tblstocktransferEntry.TransferFromClassName'
      Size = 255
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblstocktransferEntry.EmployeeID'
    end
    object tblMasterEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Origin = 'tblstocktransferEntry.EmployeeName'
      Size = 255
    end
    object tblMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblstocktransferEntry.Deleted'
      FixedChar = True
      Size = 1
    end
    object tblMasterCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblstocktransferEntry.CreationDate'
    end
    object tblMasterNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblstocktransferEntry.Notes'
      BlobType = ftWideMemo
    end
    object tblMasterProcessed: TWideStringField
      FieldName = 'Processed'
      Origin = 'tblstocktransferEntry.Processed'
      FixedChar = True
      Size = 1
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblstocktransferEntry.msTimeStamp'
    end
    object tblMasterDateTransferred: TDateTimeField
      FieldName = 'DateTransferred'
      Origin = 'tblstocktransferEntry.DateTransferred'
    end
    object tblMasterAccountID: TIntegerField
      FieldName = 'AccountID'
      Origin = 'tblstocktransferEntry.AccountID'
    end
    object tblMasterAccountname: TWideStringField
      FieldName = 'Accountname'
      Origin = 'tblstocktransferEntry.Accountname'
      Size = 100
    end
    object tblMasterEnforceUOM: TWideStringField
      FieldName = 'EnforceUOM'
      Origin = 'tblstocktransferEntry.EnforceUOM'
      Size = 1
    end
    object tblMasterDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object tblMasterShipping: TWideStringField
      FieldName = 'Shipping'
      Size = 255
    end
    object tblMasterStockMovementGlobalref: TWideStringField
      FieldName = 'StockMovementGlobalref'
      Size = 255
    end
    object tblMastermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object tblMasterSalesRef: TWideStringField
      FieldName = 'SalesRef'
      Size = 255
    end
    object tblMasterTransferType: TWideStringField
      FieldName = 'TransferType'
      FixedChar = True
      Size = 5
    end
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblstocktransferEntrylines')
    OnCalcFields = tblDetailsCalcFields
    Left = 67
    Top = 335
    object tblDetailsPartBarcode: TWideStringField
      DisplayLabel = 'Product Barcode'
      DisplayWidth = 10
      FieldName = 'PartBarcode'
      Size = 255
    end
    object tblDetailsProductName: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 15
      FieldName = 'ProductName'
      Origin = 'tblstocktransferEntrylines.ProductName'
      Size = 255
    end
    object tblDetailsProductDesc: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 25
      FieldName = 'ProductDesc'
      Origin = 'tblstocktransferEntrylines.ProductDesc'
      Size = 255
    end
    object tblDetailsUOM: TWideStringField
      DisplayWidth = 5
      FieldName = 'UOM'
      Origin = 'tblstocktransferEntrylines.UOM'
      Size = 100
    end
    object tblDetailsUOMAvailableQty: TFloatField
      DisplayLabel = 'Available'
      DisplayWidth = 7
      FieldName = 'UOMAvailableQty'
      Origin = 'tblstocktransferEntrylines.UOMAvailableQty'
    end
    object tblDetailsFormulaQtyValue: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue'
    end
    object tblDetailsFormulaQtyValue1: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue1'
    end
    object tblDetailsFormulaQtyValue2: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue2'
    end
    object tblDetailsFormulaQtyValue3: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue3'
    end
    object tblDetailsFormulaQtyValue4: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue4'
    end
    object tblDetailsFormulaQtyValue5: TFloatField
      DisplayWidth = 10
      FieldName = 'FormulaQtyValue5'
    end
    object tblDetailsUOMTransferQty: TFloatField
      DisplayLabel = 'Transfer'
      DisplayWidth = 7
      FieldName = 'UOMTransferQty'
      Origin = 'tblstocktransferEntrylines.UOMTransferQty'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsClassNameTo: TWideStringField
      DisplayLabel = 'Transfer To'
      DisplayWidth = 10
      FieldName = 'ClassNameTo'
      Origin = 'tblstocktransferEntrylines.ClassNameTo'
      Size = 255
    end
    object tblDetailsAssetValue: TFloatField
      DisplayLabel = 'Cost'
      DisplayWidth = 10
      FieldName = 'AssetValue'
      Origin = 'tblstocktransferEntrylines.AssetValue'
      currency = True
    end
    object tblDetailsUOMcost: TFloatField
      DisplayLabel = 'Unit Cost'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UOMcost'
      currency = True
      Calculated = True
    end
    object tblDetailsTotalCost: TFloatField
      DisplayLabel = 'Total Cost'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalCost'
      currency = True
      Calculated = True
    end
    object tblDetailsCustomerName: TWideStringField
      DisplayLabel = 'Customer Job'
      DisplayWidth = 20
      FieldName = 'CustomerName'
      Origin = 'tblstocktransferEntrylines.CustomerName'
      Size = 255
    end
    object tblDetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblstocktransferEntrylines.GlobalRef'
      Visible = False
      Size = 255
    end
    object tblDetailsTransferEntryLinesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TransferEntryLinesID'
      Origin = 'tblstocktransferEntrylines.TransferEntryLinesID'
      Visible = False
    end
    object tblDetailsclientID: TIntegerField
      FieldName = 'clientID'
      Origin = 'tblstocktransferEntrylines.clientID'
      Visible = False
    end
    object tblDetailsAccountID: TIntegerField
      FieldName = 'AccountID'
      Origin = 'tblstocktransferEntrylines.AccountID'
      Visible = False
    end
    object tblDetailsTransferEntryID: TIntegerField
      FieldName = 'TransferEntryID'
      Origin = 'tblstocktransferEntrylines.TransferEntryID'
      Visible = False
    end
    object tblDetailsClassIDTo: TIntegerField
      FieldName = 'ClassIDTo'
      Origin = 'tblstocktransferEntrylines.ClassIDTo'
      Visible = False
    end
    object tblDetailsEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblstocktransferEntrylines.EmployeeID'
      Visible = False
    end
    object tblDetailsProductID: TIntegerField
      FieldName = 'ProductID'
      Origin = 'tblstocktransferEntrylines.ProductID'
      Visible = False
    end
    object tblDetailsUOMID: TIntegerField
      FieldName = 'UOMID'
      Origin = 'tblstocktransferEntrylines.UOMID'
      Visible = False
    end
    object tblDetailsUOMMultiplier: TFloatField
      FieldName = 'UOMMultiplier'
      Origin = 'tblstocktransferEntrylines.UOMMultiplier'
      Visible = False
    end
    object tblDetailsAvailableQty: TFloatField
      FieldName = 'AvailableQty'
      Origin = 'tblstocktransferEntrylines.AvailableQty'
      Visible = False
    end
    object tblDetailsTransferQty: TFloatField
      FieldName = 'TransferQty'
      Origin = 'tblstocktransferEntrylines.TransferQty'
      Visible = False
    end
    object tblDetailsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblstocktransferEntrylines.msTimeStamp'
      Visible = False
    end
    object tblDetailsDeleted: TWideStringField
      FieldName = 'Deleted'
      Origin = 'tblstocktransferEntrylines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsParttype: TWideStringField
      FieldName = 'Parttype'
      Visible = False
      Size = 13
    end
    object tblDetailsMatrixDesc: TWideMemoField
      FieldName = 'MatrixDesc'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsMatrixRef: TWideMemoField
      FieldName = 'MatrixRef'
      Visible = False
      BlobType = ftWideMemo
    end
    object tblDetailsMatrixPrice: TFloatField
      FieldName = 'MatrixPrice'
      Visible = False
    end
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 30
    Top = 368
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 71
    Top = 371
  end
  object cboClassFromQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      
        'FROM tblClass  WHERE tblClass.ClassName Is Not Null And tblClass' +
        '.Active='#39'T'#39
      'ORDER BY tblClass.ClassName; ')
    Options.LongStrings = False
    Options.FlatBuffers = True
    Left = 158
    Top = 95
  end
  object cboAccountQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT AccountID, AccountName, AccDesc,AccountType, Description,' +
        ' AccountNumber, Taxcode, BankNumber, Extra, Active, Class, AllCl' +
        'asses, OpeningBalance, Debits, Credits, ClosingBalance, AccountG' +
        'roup  '
      'FROM tblchartofaccounts'
      'Left Join tblacctypedesc on  AccType = AccountType'
      'WHERE Active = '#39'T'#39' AND AccType<>'#39'NONPOSTING'#39' AND Isheader = '#39'F'#39
      'Order By AccountType, AccountName;')
    Options.LongStrings = False
    Left = 334
    Top = 98
  end
  object cboEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT tblEmployees.EmployeeID, Concat(firstname,'#39' '#39',Lastname) A' +
        'S EmployeeName '
      'FROM tblEmployees '
      'WHERE (((tblEmployees.Active)<>'#39'F'#39')) '
      'ORDER BY Concat(firstname,'#39' '#39',Lastname);')
    Options.LongStrings = False
    Left = 653
    Top = 102
  end
  object cboViaQry: TERPQuery
    SQL.Strings = (
      'SELECT ShippingMethodID, ShippingMethod'
      'FROM tblShippingMethods '
      'WHERE tblShippingMethods.Active='#39'T'#39' '
      'ORDER BY tblShippingMethods.ShippingMethod; '
      '')
    Left = 104
    Top = 337
    object cboViaQryShippingMethod: TWideStringField
      DisplayWidth = 25
      FieldName = 'ShippingMethod'
      FixedChar = True
      Size = 15
    end
    object cboViaQryShippingMethodID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ShippingMethodID'
      ReadOnly = True
      Visible = False
    end
  end
end
