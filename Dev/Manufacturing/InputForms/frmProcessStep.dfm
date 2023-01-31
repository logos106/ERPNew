inherited fmProcessStep: TfmProcessStep
  HelpContext = 907001
  Caption = 'Process Step'
  ClientHeight = 466
  ClientWidth = 463
  ExplicitWidth = 479
  ExplicitHeight = 505
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 412
    Width = 463
    HelpContext = 907002
    ExplicitTop = 358
    ExplicitWidth = 463
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 412
    Width = 463
    Height = 54
    HelpContext = 907008
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      463
      54)
    object btnCancel: TDNMSpeedButton
      Left = 335
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 907010
      Anchors = [akTop]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnOK: TDNMSpeedButton
      Left = 42
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 907011
      Anchors = [akTop]
      Caption = 'Save'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Kind = bkOK
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnOKClick
    end
    object btnEmployee: TDNMSpeedButton
      Left = 139
      Top = 14
      Width = 87
      Height = 27
      Hint = 'Choose Employees'
      HelpContext = 907023
      Anchors = [akBottom]
      Caption = 'Employees'
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
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnEmployeeClick
    end
    object btnResource: TDNMSpeedButton
      Left = 237
      Top = 14
      Width = 87
      Height = 27
      Hint = 'Save and Open the Resouce form'
      HelpContext = 907024
      Anchors = [akBottom]
      Caption = 'Resource'
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
      TabOrder = 3
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnOKClick
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 463
    Height = 65
    HelpContext = 907013
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      463
      65)
    object pnlTitle: TDNMPanel
      Left = 81
      Top = 9
      Width = 299
      Height = 45
      HelpContext = 907014
      Anchors = [akTop]
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
        Width = 295
        Height = 41
        HelpContext = 907015
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
          Width = 295
          Height = 41
          HelpContext = 907016
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Process Steps'
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
  object DNMPanel2: TDNMPanel [7]
    Left = 0
    Top = 65
    Width = 463
    Height = 347
    HelpContext = 907003
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      463
      347)
    object Label1: TLabel
      Left = 44
      Top = 19
      Width = 33
      Height = 15
      HelpContext = 907004
      Anchors = [akTop]
      Caption = 'Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label3: TLabel
      Left = 12
      Top = 51
      Width = 65
      Height = 15
      HelpContext = 907017
      Anchors = [akTop]
      Caption = 'Description'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object Label4: TLabel
      Left = 12
      Top = 287
      Width = 88
      Height = 15
      HelpContext = 907019
      Anchors = [akTop]
      Caption = 'Qty Per Coupon'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 149
      Top = 287
      Width = 95
      Height = 15
      HelpContext = 907020
      Anchors = [akTop]
      Caption = 'Rate Per Coupon'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 286
      Top = 287
      Width = 91
      Height = 15
      HelpContext = 907025
      Anchors = [akTop]
      Caption = 'Default Duration'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 1
      Top = 331
      Width = 461
      Height = 15
      HelpContext = 907026
      Align = alBottom
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'ddd:hh:mm:ss                              '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 2
      ExplicitTop = 326
    end
    object edtprocessStep: TwwDBEdit
      Left = 85
      Top = 16
      Width = 360
      Height = 23
      HelpContext = 907005
      DataField = 'Description'
      DataSource = dsProcessStep
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
    object grdEmployees: TwwDBGrid
      Left = 12
      Top = 92
      Width = 434
      Height = 189
      HelpContext = 907006
      ControlType.Strings = (
        'Active;CheckBox;T;F'
        'EmployeeName;CustomEdit;cboemployee;F'
        'IsDefault;CheckBox;T;F')
      Selected.Strings = (
        'EmployeeName'#9'42'#9'Employee'#9'F'
        'Active'#9'1'#9'Active?'
        'IsDefault'#9'1'#9'Default?')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      DataSource = dsemployeeprocesssteps
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
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
    end
    object cboemployee: TwwDBLookupCombo
      Left = 104
      Top = 136
      Width = 121
      Height = 23
      HelpContext = 907007
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'employeeName'#9'50'#9'employeeName'#9'F')
      DataField = 'EmployeeName'
      DataSource = dsemployeeprocesssteps
      LookupTable = QryEmployees
      LookupField = 'employeeName'
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object edtExtraInfo: TwwDBEdit
      Left = 85
      Top = 48
      Width = 360
      Height = 23
      HelpContext = 907018
      DataField = 'ExtraInfo'
      DataSource = dsProcessStep
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
    object edtQtyPercoupon: TwwDBEdit
      Left = 12
      Top = 305
      Width = 94
      Height = 23
      HelpContext = 907021
      DataField = 'QtyPerCoupon'
      DataSource = dsProcessStep
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
    end
    object edtRatePercolumn: TwwDBEdit
      Left = 149
      Top = 305
      Width = 94
      Height = 23
      HelpContext = 907022
      DataField = 'RAtePercoupon'
      DataSource = dsProcessStep
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
    object edtDefaultDuration: TwwDBEdit
      Left = 287
      Top = 305
      Width = 94
      Height = 23
      Hint = 'Days : Hours : Minutes : Seconds     '
      HelpContext = 907027
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      Picture.PictureMask = '###:##:##:##'
      ShowHint = True
      TabOrder = 5
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnExit = edtDefaultDurationExit
    end
    object chkActive: TwwCheckBox
      Left = 387
      Top = 302
      Width = 58
      Height = 27
      HelpContext = 907012
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Active'
      DataField = 'Active'
      DataSource = dsProcessStep
      TabOrder = 6
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C0101020048005C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object QryProcessStep: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblProcessStep')
    AfterOpen = QryProcessStepAfterOpen
    Left = 328
    Top = 201
    object QryProcessStepGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object QryProcessStepID: TIntegerField
      FieldName = 'ID'
    end
    object QryProcessStepDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object QryProcessStepProcessTime: TDateTimeField
      FieldName = 'ProcessTime'
    end
    object QryProcessStepActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QryProcessStepmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object QryProcessStepExtraInfo: TWideStringField
      FieldName = 'ExtraInfo'
      Size = 255
    end
    object QryProcessStepmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object QryProcessStepQtyPerCoupon: TFloatField
      FieldName = 'QtyPerCoupon'
    end
    object QryProcessStepRAtePercoupon: TFloatField
      FieldName = 'RAtePercoupon'
    end
    object QryProcessStepDefaultDuration: TFloatField
      FieldName = 'DefaultDuration'
    end
  end
  object dsProcessStep: TDataSource
    DataSet = QryProcessStep
    Left = 331
    Top = 232
  end
  object qryemployeeprocesssteps: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from  tblemployeeprocesssteps')
    Left = 360
    Top = 201
    object qryemployeeprocessstepsEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 42
      FieldName = 'EmployeeName'
      Origin = 'tblemployeeprocesssteps.EmployeeName'
      Size = 255
    end
    object qryemployeeprocessstepsActive: TWideStringField
      DisplayLabel = 'Active?'
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblemployeeprocesssteps.Active'
      FixedChar = True
      Size = 1
    end
    object qryemployeeprocessstepsIsDefault: TWideStringField
      DisplayLabel = 'Default?'
      DisplayWidth = 1
      FieldName = 'IsDefault'
      Origin = 'tblemployeeprocesssteps.IsDefault'
      FixedChar = True
      Size = 1
    end
    object qryemployeeprocessstepsEmpProcessStepsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'EmpProcessStepsID'
      Origin = 'tblemployeeprocesssteps.EmpProcessStepsID'
      Visible = False
    end
    object qryemployeeprocessstepsGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblemployeeprocesssteps.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryemployeeprocessstepsEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblemployeeprocesssteps.EmployeeID'
      Visible = False
    end
    object qryemployeeprocessstepsProcessStepID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcessStepID'
      Origin = 'tblemployeeprocesssteps.ProcessStepID'
      Visible = False
    end
    object qryemployeeprocessstepsProcessStep: TWideStringField
      DisplayWidth = 255
      FieldName = 'ProcessStep'
      Origin = 'tblemployeeprocesssteps.ProcessStep'
      Visible = False
      Size = 255
    end
    object qryemployeeprocessstepsmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblemployeeprocesssteps.msTimeStamp'
      Visible = False
    end
    object qryemployeeprocessstepsmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblemployeeprocesssteps.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsemployeeprocesssteps: TDataSource
    DataSet = qryemployeeprocesssteps
    Left = 363
    Top = 232
  end
  object QryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select EmployeeId, employeeName from  tblemployees')
    Left = 392
    Top = 201
    object QryEmployeesemployeeName: TWideStringField
      DisplayWidth = 50
      FieldName = 'employeeName'
      Size = 255
    end
    object QryEmployeesEmployeeId: TIntegerField
      FieldName = 'EmployeeId'
      Visible = False
    end
  end
end
