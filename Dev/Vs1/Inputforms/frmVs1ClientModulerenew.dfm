inherited fmVs1ClientModulerenew: TfmVs1ClientModulerenew
  BorderStyle = bsDialog
  Caption = 'Renew Module'
  ClientHeight = 375
  ClientWidth = 408
  Position = poMainFormCenter
  ExplicitWidth = 424
  ExplicitHeight = 414
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 319
    Width = 408
    ExplicitTop = 353
    ExplicitWidth = 408
  end
  object DNMPanel1: TDNMPanel [4]
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 402
    Height = 61
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      402
      61)
    object pnlHeader: TPanel
      Left = 54
      Top = 7
      Width = 296
      Height = 46
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 294
        Height = 44
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
          Width = 294
          Height = 44
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Renew Module'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = -1
          ExplicitWidth = 467
          ExplicitHeight = 52
        end
      end
    end
  end
  object DNMPanel2: TDNMPanel [5]
    AlignWithMargins = True
    Left = 3
    Top = 70
    Width = 402
    Height = 246
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 0
    ExplicitTop = 65
    ExplicitWidth = 408
    ExplicitHeight = 242
    object lblClientPrintNameHeading: TLabel
      AlignWithMargins = True
      Left = 48
      Top = 16
      Width = 78
      Height = 15
      HelpContext = 254556
      Alignment = taRightJustify
      Caption = 'License Level'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label1: TLabel
      AlignWithMargins = True
      Left = 49
      Top = 56
      Width = 77
      Height = 15
      HelpContext = 254556
      Alignment = taRightJustify
      Caption = 'Module Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label2: TLabel
      AlignWithMargins = True
      Left = 49
      Top = 103
      Width = 48
      Height = 15
      HelpContext = 254556
      Alignment = taRightJustify
      Caption = 'License '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 107
      Top = 124
      Width = 29
      Height = 15
      HelpContext = 254556
      Alignment = taRightJustify
      Caption = 'From'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      AlignWithMargins = True
      Left = 259
      Top = 124
      Width = 13
      Height = 15
      HelpContext = 254556
      Alignment = taRightJustify
      Caption = 'To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label5: TLabel
      AlignWithMargins = True
      Left = 58
      Top = 148
      Width = 43
      Height = 15
      HelpContext = 254556
      Alignment = taRightJustify
      Caption = 'Current'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      AlignWithMargins = True
      Left = 59
      Top = 188
      Width = 42
      Height = 15
      HelpContext = 254556
      Alignment = taRightJustify
      Caption = 'Renew '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object edtLicenseLevel: TDBEdit
      Left = 134
      Top = 14
      Width = 245
      Height = 23
      HelpContext = 254558
      DataField = 'LicenseLevel'
      DataSource = dsvs1_clientmodules
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edtModuleName: TDBEdit
      Left = 134
      Top = 54
      Width = 245
      Height = 23
      HelpContext = 254558
      DataField = 'ModuleName'
      DataSource = dsvs1_clientmodules
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtcleanLicenseFrom: TwwDBDateTimePicker
      Left = 107
      Top = 145
      Width = 121
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ShowButton = True
      TabOrder = 2
    end
    object edtcleanLicenseUntil: TwwDBDateTimePicker
      Left = 259
      Top = 145
      Width = 121
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ShowButton = True
      TabOrder = 3
    end
    object edtLicenseFrom: TwwDBDateTimePicker
      Left = 107
      Top = 185
      Width = 121
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      DataField = 'LicenseFrom'
      DataSource = dsvs1_clientmodules
      Date = 44022.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 4
    end
    object edtLicenseUntil: TwwDBDateTimePicker
      Left = 259
      Top = 185
      Width = 121
      Height = 23
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'Tahoma'
      CalendarAttributes.Font.Style = []
      DataField = 'LicenseUntil'
      DataSource = dsvs1_clientmodules
      Date = 44022.000000000000000000
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 5
    end
    object chkDontContact: TDBCheckBox
      AlignWithMargins = True
      Left = 321
      Top = 216
      Width = 59
      Height = 23
      HelpContext = 254345
      Margins.Left = 11
      Margins.Top = 2
      Margins.Right = 11
      Margins.Bottom = 2
      Alignment = taLeftJustify
      Caption = 'Active '
      DataField = 'Active'
      DataSource = dsvs1_clientmodules
      TabOrder = 6
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      WordWrap = True
    end
  end
  object DNMPanel3: TDNMPanel [6]
    AlignWithMargins = True
    Left = 3
    Top = 322
    Width = 402
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    ExplicitTop = 300
    DesignSize = (
      402
      50)
    object cmdClose: TDNMSpeedButton
      Left = 97
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 251008
      Anchors = []
      Caption = 'Confirm'
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
      Left = 218
      Top = 10
      Width = 93
      Height = 29
      HelpContext = 251005
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
  end
  object dsvs1_clientmodules: TDataSource
    Left = 165
    Top = 121
  end
end
