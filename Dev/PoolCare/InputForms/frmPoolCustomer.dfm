inherited fmPoolCustomer: TfmPoolCustomer
  Left = 304
  Top = 133
  Caption = 'Pool Profile'
  ClientHeight = 413
  ClientWidth = 655
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 59
    Width = 655
    Height = 308
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label38: TLabel
      Left = 18
      Top = 3
      Width = 95
      Height = 18
      AutoSize = False
      Caption = 'Customer Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label25: TLabel
      Left = 13
      Top = 38
      Width = 97
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Company Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label27: TLabel
      Left = 50
      Top = 69
      Width = 60
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Mr./Mrs/...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label74: TLabel
      Left = 22
      Top = 100
      Width = 88
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'First Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label78: TLabel
      Left = 37
      Top = 131
      Width = 73
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Last Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label31: TLabel
      Left = 379
      Top = 39
      Width = 92
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Phone Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label76: TLabel
      Left = 395
      Top = 69
      Width = 76
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Fax Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label33: TLabel
      Left = 358
      Top = 102
      Width = 113
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Alt. Phone Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label13: TLabel
      Left = 358
      Top = 130
      Width = 113
      Height = 18
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Mobile'
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
      Left = 13
      Top = 29
      Width = 619
      Height = 131
      Shape = bsFrame
    end
    object cboClient: TwwDBLookupCombo
      Left = 117
      Top = 1
      Width = 226
      Height = 23
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'70'#9'Company'#9'F')
      DataField = 'ClientID'
      DataSource = dsPoolProfile
      LookupTable = qryClient
      LookupField = 'ClientID'
      TabOrder = 0
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
      OnDblClick = cboClientDblClick
      OnDropDown = cboClientDropDown
      OnCloseUp = cboClientCloseUp
      OnEnter = cboClientEnter
    end
    object DNMPanel3: TDNMPanel
      Left = 13
      Top = 166
      Width = 621
      Height = 132
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        617
        128)
      object Label1: TLabel
        Left = 435
        Top = 9
        Width = 81
        Height = 18
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        Caption = 'Volume(,000)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label2: TLabel
        Left = 44
        Top = 9
        Width = 52
        Height = 18
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        Caption = 'Location'
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
        Left = 17
        Top = 40
        Width = 79
        Height = 18
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        Caption = 'Construction'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label4: TLabel
        Left = 24
        Top = 72
        Width = 72
        Height = 18
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        Caption = 'Sanitizer'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label6: TLabel
        Left = 458
        Top = 74
        Width = 58
        Height = 15
        Alignment = taRightJustify
        Anchors = [akLeft]
        Caption = 'MSA Used'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 561
        Top = 74
        Width = 22
        Height = 15
        Alignment = taRightJustify
        Anchors = [akLeft]
        Caption = 'Spa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label5: TLabel
        Left = 421
        Top = 40
        Width = 95
        Height = 18
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        Caption = 'Salt Required'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label8: TLabel
        Left = 11
        Top = 105
        Width = 85
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft]
        AutoSize = False
        Caption = 'Sanitizer Level'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label50: TLabel
        Left = 453
        Top = 104
        Width = 63
        Height = 15
        Alignment = taRightJustify
        Anchors = [akLeft]
        Caption = 'Pool Active'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtVolume: TwwDBEdit
        Left = 522
        Top = 7
        Width = 81
        Height = 23
        Anchors = [akLeft]
        DataField = 'Volume'
        DataSource = dsPoolProfile
        TabOrder = 4
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cboLocation: TwwDBComboBox
        Left = 102
        Top = 7
        Width = 228
        Height = 23
        Anchors = [akLeft]
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        DataField = 'Location'
        DataSource = dsPoolProfile
        DropDownCount = 8
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Indoor'
          'Outdoor'
          '')
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
      end
      object edtSaltRequired: TwwDBEdit
        Left = 522
        Top = 38
        Width = 81
        Height = 23
        Anchors = [akLeft]
        DataField = 'SaltRequired'
        DataSource = dsPoolProfile
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtSanitizerLevel: TwwDBEdit
        Left = 102
        Top = 101
        Width = 58
        Height = 23
        Anchors = [akLeft]
        DataField = 'Sanitizerlvl'
        DataSource = dsPoolProfile
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cboConstruction: TwwDBLookupCombo
        Left = 102
        Top = 38
        Width = 228
        Height = 23
        Anchors = [akLeft]
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'30'#9'Name'#9'F')
        DataField = 'Construction'
        DataSource = dsPoolProfile
        LookupTable = qryConstruction
        LookupField = 'TestCategoriesID'
        Style = csDropDownList
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object cboSanitizer: TwwDBLookupCombo
        Left = 102
        Top = 70
        Width = 228
        Height = 23
        Anchors = [akLeft]
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'30'#9'Name'#9'F')
        DataField = 'Sanitizer'
        DataSource = dsPoolProfile
        LookupTable = qrySnitizer
        LookupField = 'TestCategoriesID'
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
      end
      object chkMSAUsed: TwwCheckBox
        Left = 522
        Top = 72
        Width = 15
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
        Anchors = [akLeft]
        Caption = 'chkActive'
        DataField = 'UsesMSA'
        DataSource = dsPoolProfile
        TabOrder = 6
      end
      object chkSpa: TwwCheckBox
        Left = 587
        Top = 72
        Width = 16
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
        Anchors = [akLeft]
        Caption = 'chkActive'
        DataField = 'IsSpa'
        DataSource = dsPoolProfile
        TabOrder = 7
      end
      object chkActive: TwwCheckBox
        Left = 522
        Top = 102
        Width = 16
        Height = 17
        AlwaysTransparent = True
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Anchors = [akLeft]
        Caption = 'chkActive'
        DataField = 'Active'
        DataSource = dsPoolProfile
        TabOrder = 8
      end
    end
    object txtCompany: TDBEdit
      Left = 117
      Top = 36
      Width = 224
      Height = 23
      Color = 15724527
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object txtContactTitle: TDBEdit
      Left = 117
      Top = 67
      Width = 224
      Height = 23
      Color = 15724527
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object txtContactFirstName: TDBEdit
      Left = 117
      Top = 98
      Width = 224
      Height = 23
      Color = 15724527
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object txtContactLastName: TDBEdit
      Left = 117
      Top = 130
      Width = 224
      Height = 23
      Color = 15724527
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object txtPhoneNumber: TDBEdit
      Left = 476
      Top = 37
      Width = 140
      Height = 23
      Color = 15724527
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 6
    end
    object txtFaxNumber: TDBEdit
      Left = 476
      Top = 68
      Width = 140
      Height = 23
      Color = 15724527
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
    end
    object txtAltPhone: TDBEdit
      Left = 476
      Top = 100
      Width = 140
      Height = 23
      Color = 15724527
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
    object txtMobile: TDBEdit
      Left = 476
      Top = 129
      Width = 140
      Height = 23
      Color = 15724527
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 9
    end
  end
  object pnlTop: TDNMPanel [2]
    Left = 0
    Top = 0
    Width = 655
    Height = 59
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object pnlTitle: TDNMPanel
      Left = 207
      Top = 6
      Width = 238
      Height = 45
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
        Width = 234
        Height = 41
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.2.1.1'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 234
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Pool Profile'
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
  object pnlBottom: TDNMPanel [3]
    Left = 0
    Top = 367
    Width = 655
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      655
      46)
    object btnSave: TDNMSpeedButton
      Left = 62
      Top = 10
      Width = 87
      Height = 27
      Action = actMainSave
      Anchors = [akBottom]
      Caption = '&Save'
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
      TabOrder = 0
    end
    object btnNew: TDNMSpeedButton
      Left = 288
      Top = 10
      Width = 87
      Height = 27
      Action = actMainNew
      Anchors = [akBottom]
      Caption = '&New'
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
      TabOrder = 2
    end
    object btnCancel: TDNMSpeedButton
      Left = 514
      Top = 10
      Width = 87
      Height = 27
      Action = actMainCancel
      Anchors = [akBottom]
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
      TabOrder = 4
    end
    object BitBtn1: TDNMSpeedButton
      Left = 175
      Top = 10
      Width = 87
      Height = 27
      Action = acTests
      Anchors = [akBottom]
      Caption = '&Tests'
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
    end
    object BitBtn2: TDNMSpeedButton
      Left = 401
      Top = 10
      Width = 87
      Height = 27
      Anchors = [akBottom]
      Caption = 'Print'
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtn2Click
    end
  end
  object alMain: TActionList
    Left = 40
    Top = 35
    object actMainSave: TAction
      Caption = '&Save'
      OnExecute = actMainSaveExecute
    end
    object actMainNew: TAction
      Caption = '&New'
      OnExecute = actMainNewExecute
    end
    object actMainCancel: TAction
      Caption = '&Cancel'
      OnExecute = actMainCancelExecute
    end
    object actCustomer: TAction
      Caption = 'Customer'
      OnExecute = actCustomerExecute
    end
    object acTests: TAction
      Caption = '&Tests'
      OnExecute = acTestsExecute
    end
  end
  object qryPoolProfile: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select * from tblPoolProfile Where PoolProfileID= :PoolProfileID')
    FetchRows = 1
    BeforePost = qryPoolProfileBeforePost
    Options.LongStrings = False
    Left = 29
    Top = 158
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PoolProfileID'
        Value = 1
      end>
    object qryPoolProfilePoolProfileID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PoolProfileID'
      Origin = 'tblPoolProfile.PoolProfileID'
    end
    object qryPoolProfileClient: TStringField
      FieldName = 'Client'
      Origin = 'tblPoolProfile.Client'
      Size = 50
    end
    object qryPoolProfileVolume: TIntegerField
      FieldName = 'Volume'
      Origin = 'tblPoolProfile.Volume'
    end
    object qryPoolProfileLocation: TStringField
      FieldName = 'Location'
      Origin = 'tblPoolProfile.Location'
      Size = 10
    end
    object qryPoolProfileConstruction: TStringField
      FieldName = 'Construction'
      Origin = 'tblPoolProfile.Construction'
    end
    object qryPoolProfileSanitizer: TStringField
      FieldName = 'Sanitizer'
      Origin = 'tblPoolProfile.Sanitizer'
    end
    object qryPoolProfileUsesMSA: TStringField
      FieldName = 'UsesMSA'
      Origin = 'tblPoolProfile.UsesMSA'
      FixedChar = True
      Size = 1
    end
    object qryPoolProfileIsSpa: TStringField
      FieldName = 'IsSpa'
      Origin = 'tblPoolProfile.IsSpa'
      FixedChar = True
      Size = 1
    end
    object qryPoolProfileSaltRequired: TIntegerField
      FieldName = 'SaltRequired'
      Origin = 'tblPoolProfile.SaltRequired'
    end
    object qryPoolProfileDateEntered: TDateField
      FieldName = 'DateEntered'
      Origin = 'tblPoolProfile.DateEntered'
    end
    object qryPoolProfileGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Origin = 'tblPoolProfile.GlobalRef'
      Size = 255
    end
    object qryPoolProfileActive: TStringField
      FieldName = 'Active'
      Origin = 'tblPoolProfile.Active'
      FixedChar = True
      Size = 1
    end
    object qryPoolProfileSanitizerlvl: TIntegerField
      FieldName = 'Sanitizerlvl'
      Origin = 'tblPoolProfile.Sanitizerlvl'
    end
    object qryPoolProfileClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblPoolProfile.ClientID'
    end
  end
  object qryClient: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT C1.ClientID AS ClientID, C1.Company AS Company, C1.Title,' +
        ' C1.FirstName, C1.LastName, C1.Phone, C1.FaxNumber, C1.AltPhone,' +
        ' C1.Mobile'
      
        'FROM tblclients AS C1 LEFT JOIN tblpoolprofile ON C1.ClientID = ' +
        'tblpoolprofile.ClientID'
      'WHERE C1.Customer='#39'T'#39' AND Length(C1.Company)>0'
      'AND C1.Active = '#39'T'#39'  and tblpoolprofile.ClientID is null'
      'Order by C1.Company ')
    Options.LongStrings = False
    Left = 65
    Top = 164
    object qryClientCompany: TStringField
      DisplayWidth = 70
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object qryClientTitle: TStringField
      FieldName = 'Title'
      Origin = 'tblclients.Title'
      Size = 32
    end
    object qryClientFirstName: TStringField
      FieldName = 'FirstName'
      Origin = 'tblclients.FirstName'
      Size = 15
    end
    object qryClientLastName: TStringField
      FieldName = 'LastName'
      Origin = 'tblclients.LastName'
      Size = 30
    end
    object qryClientPhone: TStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
    end
    object qryClientFaxNumber: TStringField
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
    end
    object qryClientAltPhone: TStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
    end
    object qryClientMobile: TStringField
      FieldName = 'Mobile'
      Origin = 'tblclients.Mobile'
    end
    object qryClientClientID: TIntegerField
      FieldName = 'ClientID'
    end
  end
  object dsPoolProfile: TwwDataSource
    DataSet = qryPoolProfile
    Left = 27
    Top = 123
  end
  object dsClient: TwwDataSource
    DataSet = qryClient
    Left = 69
    Top = 126
  end
  object qryConstruction: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select TestCategoriesID, Name   from tblpooltestCategories'
      'Where construction = '#39'T'#39' '
      'Order by Name   ')
    Options.LongStrings = False
    Left = 368
    Top = 269
    object qryConstructionName: TStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Size = 30
    end
    object qryConstructionTestCategoriesID: TIntegerField
      FieldName = 'TestCategoriesID'
      Visible = False
    end
  end
  object qrySnitizer: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select TestCategoriesID, Name    from tblpooltestCategories'
      'Where Sanitizer = '#39'T'#39' '
      'Order by Name')
    Options.LongStrings = False
    Left = 365
    Top = 308
    object qrySnitizerName: TStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Size = 30
    end
    object qrySnitizerTestCategoriesID: TIntegerField
      FieldName = 'TestCategoriesID'
      Visible = False
    end
  end
end
