inherited fmWebAPITest: TfmWebAPITest
  Left = 288
  Top = 267
  HelpContext = 837001
  Caption = 'Web API Test'
  ClientWidth = 1027
  OnMouseDown = FormMouseDown
  ExplicitTop = 8
  ExplicitWidth = 1033
  ExplicitHeight = 561
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 348
    Width = 1027
    HelpContext = 837003
    Margins.Bottom = 0
    ExplicitTop = 514
    ExplicitWidth = 956
  end
  inherited shapehint: TShape
    Left = 10
    ExplicitLeft = 10
  end
  object Splitter1: TSplitter [3]
    Left = 449
    Top = 58
    Height = 290
    HelpContext = 837002
    ExplicitLeft = 624
    ExplicitTop = 224
    ExplicitHeight = 100
  end
  inherited shapehintextra1: TShape
    Left = 58
    ExplicitLeft = 58
  end
  object pnlTop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 1027
    Height = 58
    HelpContext = 837018
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
      1027
      58)
    object lblProcess: TLabel
      Left = 921
      Top = 0
      Width = 106
      Height = 58
      Align = alRight
      Caption = 'lblProcess'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 24
    end
    object pnlHeader: TPanel
      Left = 215
      Top = 5
      Width = 596
      Height = 49
      HelpContext = 837019
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
        Width = 594
        Height = 47
        HelpContext = 837020
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
          Width = 594
          Height = 47
          HelpContext = 837021
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Web API Test'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -86
          ExplicitTop = 216
        end
      end
    end
  end
  object pnlBottom: TDNMPanel [7]
    Left = 0
    Top = 348
    Width = 1027
    Height = 50
    HelpContext = 837022
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    DesignSize = (
      1027
      50)
    object Label1: TLabel
      Left = 21
      Top = 3
      Width = 63
      Height = 15
      HelpContext = 837023
      Caption = 'User Name'
    end
    object Label2: TLabel
      Left = 130
      Top = 3
      Width = 58
      Height = 15
      HelpContext = 837024
      Caption = 'Password'
    end
    object Label3: TLabel
      Left = 242
      Top = 3
      Width = 54
      Height = 15
      HelpContext = 837025
      Caption = 'Database'
    end
    object edtUser: TEdit
      Left = 21
      Top = 19
      Width = 97
      Height = 23
      HelpContext = 837026
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnExit = edtUserExit
    end
    object edtPass: TEdit
      Left = 130
      Top = 19
      Width = 97
      Height = 23
      HelpContext = 837027
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnExit = edtPassExit
    end
    object edtDatabase: TEdit
      Left = 242
      Top = 19
      Width = 183
      Height = 23
      HelpContext = 837028
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnExit = edtDatabaseExit
    end
    object btnClose: TDNMSpeedButton
      Left = 924
      Top = 17
      Width = 87
      Height = 27
      Hint = '"Close The List"'
      HelpContext = 837029
      Anchors = [akTop, akRight]
      Caption = '&Close'
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object btnExamples: TDNMSpeedButton
      Left = 452
      Top = 15
      Width = 87
      Height = 27
      HelpContext = 837030
      Caption = 'Examples'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnExamplesClick
    end
    object btnHelp: TDNMSpeedButton
      Left = 585
      Top = 15
      Width = 87
      Height = 27
      HelpContext = 837031
      Caption = 'Help Wiki'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnHelpClick
    end
    object btnRESTClient: TDNMSpeedButton
      Left = 719
      Top = 15
      Width = 87
      Height = 27
      HelpContext = 837047
      Caption = 'Test App'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 6
      AutoDisableParentOnclick = True
      OnClick = btnRESTClientClick
    end
  end
  object pnlRequest: TDNMPanel [8]
    Left = 0
    Top = 58
    Width = 449
    Height = 290
    HelpContext = 837004
    Align = alLeft
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object memRequest: TMemo
      Left = 0
      Top = 73
      Width = 449
      Height = 217
      Hint = 'Right click for a list of sample requests.'
      HelpContext = 837005
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      PopupMenu = MenuExamples
      ScrollBars = ssBoth
      ShowHint = True
      TabOrder = 1
      OnExit = memRequestExit
    end
    object pnlRequestTop: TDNMPanel
      Left = 0
      Top = 0
      Width = 449
      Height = 73
      HelpContext = 837006
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        449
        73)
      object Label4: TLabel
        Left = 12
        Top = 28
        Width = 73
        Height = 15
        HelpContext = 837007
        Caption = 'Request URL'
      end
      object lblPort: TLabel
        Left = 410
        Top = 28
        Width = 27
        Height = 15
        HelpContext = 837008
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'Port:'
      end
      object cboURL: TComboBox
        Left = 16
        Top = 44
        Width = 427
        Height = 23
        HelpContext = 837009
        Anchors = [akLeft, akTop, akRight]
        DropDownCount = 20
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = 'https://localhost/erpapi/'
        OnExit = cboURLExit
      end
      object btnPost: TDNMSpeedButton
        Left = 184
        Top = 6
        Width = 87
        Height = 27
        HelpContext = 837010
        Anchors = [akTop]
        Caption = 'Post'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = btnPostClick
      end
    end
  end
  object pnlResult: TDNMPanel [9]
    Left = 452
    Top = 58
    Width = 425
    Height = 290
    HelpContext = 837011
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object pnlResponceTop: TDNMPanel
      Left = 0
      Top = 0
      Width = 425
      Height = 105
      HelpContext = 837012
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        425
        105)
      object chkFormatJson: TwwCheckBox
        Left = 314
        Top = 9
        Width = 97
        Height = 17
        HelpContext = 837015
        DisableThemes = False
        AlwaysTransparent = True
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Anchors = [akTop, akRight]
        Caption = 'Format Json'
        TabOrder = 1
        OnClick = chkFormatJsonClick
      end
      object btnGet: TDNMSpeedButton
        Left = 168
        Top = 6
        Width = 87
        Height = 27
        HelpContext = 837016
        Anchors = [akTop]
        Caption = 'Get'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = btnGetClick
      end
      object memResult: TMemo
        Left = 6
        Top = 40
        Width = 412
        Height = 59
        HelpContext = 837049
        Anchors = [akLeft, akTop, akRight]
        Lines.Strings = (
          'Result Code:')
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
      end
    end
    object memResponce: TMemo
      Left = 0
      Top = 105
      Width = 425
      Height = 185
      HelpContext = 837017
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 1
      OnDblClick = memResponceDblClick
    end
  end
  object pnlDevmode: TDNMPanel [10]
    Left = 0
    Top = 432
    Width = 1027
    Height = 100
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object DNMPanel1: TDNMPanel
      Left = 1
      Top = 49
      Width = 1025
      Height = 50
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object DNMSpeedButton14: TDNMSpeedButton
        AlignWithMargins = True
        Left = 81
        Top = 4
        Width = 97
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Repeat Appt With Date Range'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 0
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton14Click
      end
      object btnvs1credentisal: TDNMSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 4
        Width = 76
        Height = 42
        Margins.Left = 2
        Margins.Right = 1
        Align = alLeft
        Caption = 'VS1 Admin Credentials'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnvs1credentisalClick
      end
      object btncoreEDi: TDNMSpeedButton
        AlignWithMargins = True
        Left = 260
        Top = 4
        Width = 76
        Height = 42
        Margins.Left = 2
        Margins.Right = 1
        Align = alLeft
        Caption = 'CoreEDI URL'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 2
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btncoreEDiClick
      end
      object btnbackuprestore: TDNMSpeedButton
        AlignWithMargins = True
        Left = 181
        Top = 4
        Width = 76
        Height = 42
        Margins.Left = 2
        Margins.Right = 1
        Align = alLeft
        Caption = 'Backup / Restore'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 3
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnbackuprestoreClick
      end
    end
    object DNMPanel2: TDNMPanel
      Left = 1
      Top = -1
      Width = 1025
      Height = 50
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object DNMSpeedButton2: TDNMSpeedButton
        AlignWithMargins = True
        Left = 2
        Top = 4
        Width = 48
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Vs1 Rego '
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 0
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton2Click
      end
      object btnErpAdminCred: TDNMSpeedButton
        AlignWithMargins = True
        Left = 52
        Top = 4
        Width = 76
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'ERP Admin Credentials'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 1
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnErpAdminCredClick
      end
      object btnDropdatabase: TDNMSpeedButton
        AlignWithMargins = True
        Left = 209
        Top = 4
        Width = 52
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Drop DB'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 2
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnDropdatabaseClick
      end
      object DNMSpeedButton5: TDNMSpeedButton
        AlignWithMargins = True
        Left = 317
        Top = 4
        Width = 48
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'New User'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 3
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton5Click
      end
      object btnCreateNewDatabase: TDNMSpeedButton
        AlignWithMargins = True
        Left = 263
        Top = 4
        Width = 52
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Create DB'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 4
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnCreateNewDatabaseClick
      end
      object DNMSpeedButton4: TDNMSpeedButton
        AlignWithMargins = True
        Left = 367
        Top = 4
        Width = 55
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'VS1 Login'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 5
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton4Click
      end
      object DNMSpeedButton3: TDNMSpeedButton
        AlignWithMargins = True
        Left = 424
        Top = 4
        Width = 55
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Choose DB'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 6
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton3Click
      end
      object DNMSpeedButton6: TDNMSpeedButton
        AlignWithMargins = True
        Left = 481
        Top = 4
        Width = 74
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'License Check'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 7
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton6Click
      end
      object DNMSpeedButton7: TDNMSpeedButton
        AlignWithMargins = True
        Left = 557
        Top = 4
        Width = 51
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Access Levels'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 8
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton7Click
      end
      object btnVS1renew: TDNMSpeedButton
        AlignWithMargins = True
        Left = 610
        Top = 4
        Width = 48
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Renew'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 9
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnVS1renewClick
      end
      object tbnAddModules: TDNMSpeedButton
        AlignWithMargins = True
        Left = 660
        Top = 4
        Width = 48
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Add Modules'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 10
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = tbnAddModulesClick
      end
      object btnDBConnect: TDNMSpeedButton
        AlignWithMargins = True
        Left = 710
        Top = 4
        Width = 63
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Connect DB Test'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 11
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnDBConnectClick
      end
      object btnChangeDatabase: TDNMSpeedButton
        AlignWithMargins = True
        Left = 775
        Top = 4
        Width = 63
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Change Database'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 12
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnChangeDatabaseClick
      end
      object btnupdatecomppre: TDNMSpeedButton
        AlignWithMargins = True
        Left = 840
        Top = 4
        Width = 63
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Update Comp Pref'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 13
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnupdatecomppreClick
      end
      object btnRepeatAppt: TDNMSpeedButton
        AlignWithMargins = True
        Left = 905
        Top = 4
        Width = 63
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Repeat Appt'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 14
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnRepeatApptClick
      end
      object btnDashboard: TDNMSpeedButton
        AlignWithMargins = True
        Left = 970
        Top = 4
        Width = 63
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'VS1 Dashboard'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 15
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = btnDashboardClick
      end
      object DNMSpeedButton1: TDNMSpeedButton
        AlignWithMargins = True
        Left = 130
        Top = 4
        Width = 77
        Height = 42
        Margins.Left = 1
        Margins.Right = 1
        Align = alLeft
        Caption = 'Change Password'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 16
        WordWrap = True
        AutoDisableParentOnclick = True
        OnClick = DNMSpeedButton1Click
      end
    end
  end
  object pnlObjects: TDNMPanel [11]
    Left = 877
    Top = 58
    Width = 150
    Height = 290
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object Lstobjects: TListBox
      Left = 1
      Top = 1
      Width = 148
      Height = 288
      Align = alClient
      ItemHeight = 15
      Items.Strings = (
        'VS1 Clients'
        'VS1 Databases'
        'VS1 Users')
      TabOrder = 0
      OnDblClick = LstobjectsDblClick
    end
  end
  object pnlGTOptions: TDNMPanel [12]
    Left = 0
    Top = 398
    Width = 1027
    Height = 34
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object DNMSpeedButton8: TDNMSpeedButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 149
      Height = 26
      Align = alLeft
      Caption = 'Init Existing DB For StS'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton8Click
    end
    object DNMSpeedButton9: TDNMSpeedButton
      AlignWithMargins = True
      Left = 159
      Top = 4
      Width = 112
      Height = 26
      Align = alLeft
      Caption = 'Add Seed To Sale'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton9Click
    end
    object DNMSpeedButton10: TDNMSpeedButton
      AlignWithMargins = True
      Left = 277
      Top = 4
      Width = 100
      Height = 26
      Align = alLeft
      Caption = 'New Strain'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton10Click
    end
    object DNMSpeedButton11: TDNMSpeedButton
      AlignWithMargins = True
      Left = 383
      Top = 4
      Width = 100
      Height = 26
      Align = alLeft
      Caption = 'STS Class'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton11Click
    end
    object DNMSpeedButton12: TDNMSpeedButton
      AlignWithMargins = True
      Left = 489
      Top = 4
      Width = 100
      Height = 26
      Align = alLeft
      Caption = 'StsTag'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton12Click
    end
    object DNMSpeedButton13: TDNMSpeedButton
      AlignWithMargins = True
      Left = 595
      Top = 4
      Width = 134
      Height = 26
      Align = alLeft
      Caption = 'StS Change Phase'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = DNMSpeedButton13Click
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 524
    Top = 0
  end
  inherited tmrdelay: TTimer
    Left = 448
    Top = 65528
  end
  inherited popSpelling: TPopupMenu
    Left = 88
    Top = 0
  end
  inherited tmrdelayMsg: TTimer
    Left = 560
    Top = 0
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 193
    Top = 0
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 213
    Top = 65520
  end
  inherited DataState: TDataState
    Left = 248
    Top = 0
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 123
    Top = 16
  end
  inherited imgsort: TImageList
    Left = 307
    Top = 65528
    Bitmap = {
      494C010102003400EC0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 266
    Top = 0
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 334
    Top = 8
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Top = 8
  end
  inherited qryMemTrans: TERPQuery
    Left = 53
    Top = 8
  end
  inherited tmrOnshow: TTimer
    Left = 488
    Top = 0
  end
  object MenuExamples: TPopupMenu
    Left = 104
    Top = 192
    object mnuCreateNewCustomer: TMenuItem
      Caption = 'Create New Customer'
      HelpContext = 837032
      OnClick = mnuCreateNewCustomerClick
    end
    object mnuCreateCustomerPrepayment1: TMenuItem
      Caption = 'Create New Customer Prepayment'
      HelpContext = 837050
      OnClick = mnuCreateCustomerPrepayment1Click
    end
    object mnuCreatNewLead: TMenuItem
      Caption = 'Create New Lead'
      HelpContext = 837033
      OnClick = mnuCreatNewLeadClick
    end
    object mnuCreateNewProduct: TMenuItem
      Caption = 'Create New Product'
      HelpContext = 837034
      OnClick = mnuCreateNewProductClick
    end
    object mnuCreateNewQuote: TMenuItem
      Caption = 'Create New Quote'
      HelpContext = 837035
      OnClick = mnuCreateNewQuoteClick
    end
    object mnuCreateNewSalesOrder: TMenuItem
      Caption = 'Create New Sales Order'
      HelpContext = 837036
      OnClick = mnuCreateNewSalesOrderClick
    end
    object mnuCreateNewInvoice: TMenuItem
      Caption = 'Create New Invoice'
      HelpContext = 837037
      OnClick = mnuCreateNewInvoiceClick
    end
    object mnuCreateNewPurchaseOrder: TMenuItem
      Caption = 'Create New Purchase Order'
      HelpContext = 837048
      OnClick = mnuCreateNewPurchaseOrderClick
    end
    object mnuCreateNewPOwithBatchNos: TMenuItem
      Caption = 'Create New PO with Batch No'#39's'
      HelpContext = 837051
      OnClick = mnuCreateNewPOwithBatchNosClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mnuGetProductList: TMenuItem
      Caption = 'Get Product List'
      HelpContext = 837038
      OnClick = mnuGetProductListClick
    end
    object mnuGetCustomerList: TMenuItem
      Caption = 'Get Customer List'
      HelpContext = 837039
      OnClick = mnuGetCustomerListClick
    end
    object mnuGetQuoteList: TMenuItem
      Caption = 'Get Quote List'
      HelpContext = 837040
      OnClick = mnuGetQuoteListClick
    end
    object mnuGetSalesOrderList: TMenuItem
      Caption = 'Get Sales Order List'
      HelpContext = 837041
      OnClick = mnuGetSalesOrderListClick
    end
    object mnuGetInternalSalesOrderList: TMenuItem
      Caption = 'Get Internal Sales Order List'
      HelpContext = 837052
      OnClick = mnuGetInternalSalesOrderListClick
    end
    object mnuGetSupportLogList: TMenuItem
      Caption = 'Get Support Log List'
      HelpContext = 837042
      OnClick = mnuGetSupportLogListClick
    end
    object mnuGetInvoiceList: TMenuItem
      Caption = 'Get Invoice List'
      HelpContext = 837043
      OnClick = mnuGetInvoiceListClick
    end
    object mnuGetProductPictureList: TMenuItem
      Caption = 'Get Product Picture List'
      HelpContext = 837044
      OnClick = mnuGetProductPictureListClick
    end
    object mnuGetTaskList: TMenuItem
      Caption = 'Get Task List'
      HelpContext = 837045
      OnClick = mnuGetTaskListClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnuPrintInvoice: TMenuItem
      Caption = 'Print Invoice (Post Request)'
      HelpContext = 837053
      OnClick = mnuPrintInvoiceClick
    end
    object InputAPItype1: TMenuItem
      Caption = 'Input API type'
      OnClick = InputAPItype1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object BalanceSheet1: TMenuItem
      Caption = 'Balance Sheet'
      OnClick = BalanceSheet1Click
    end
    object ransactionJournal1: TMenuItem
      Caption = 'Transaction Journal'
      OnClick = ransactionJournal1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object mnuExampleWithOptions: TMenuItem
      Caption = 'Example With Options'
      OnClick = mnuExampleWithOptionsClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mnuMore: TMenuItem
      Caption = '.. More'
      HelpContext = 837046
      OnClick = mnuMoreClick
    end
  end
  object tmrProcess: TTimer
    Enabled = False
    Left = 832
    Top = 24
  end
end
