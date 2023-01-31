inherited fmMarketingLead: TfmMarketingLead
  Left = 194
  Top = 373
  HelpContext = 174000
  Caption = 'Lead'
  ClientHeight = 564
  ClientWidth = 945
  DragMode = dmAutomatic
  OldCreateOrder = True
  OnResize = FormResize
  ExplicitLeft = 194
  ExplicitTop = 373
  ExplicitWidth = 961
  ExplicitHeight = 603
  DesignSize = (
    945
    564)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 526
    Width = 945
    HelpContext = 174044
    ExplicitTop = 499
    ExplicitWidth = 922
  end
  inherited imgGridWatermark: TImage
    HelpContext = 174001
  end
  object pnlBottom: TDNMPanel [5]
    Left = 0
    Top = 526
    Width = 945
    Height = 38
    HelpContext = 174036
    Align = alBottom
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
    DesignSize = (
      945
      38)
    object cmdOK: TDNMSpeedButton
      Left = 23
      Top = 5
      Width = 84
      Height = 27
      HelpContext = 174037
      Anchors = [akBottom]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      AutoDisableParentOnclick = True
      OnClick = cmdOKClick
    end
    object cmdClose: TDNMSpeedButton
      Left = 838
      Top = 5
      Width = 84
      Height = 27
      HelpContext = 174038
      Anchors = [akBottom]
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 6
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
    end
    object btnFollowUp: TDNMSpeedButton
      Left = 113
      Top = 5
      Width = 84
      Height = 27
      HelpContext = 174039
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Follow-Up'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnActionButtonClick
    end
    object btnAppointment: TDNMSpeedButton
      Left = 204
      Top = 5
      Width = 84
      Height = 27
      HelpContext = 174040
      Anchors = [akBottom]
      Caption = '&Appointment'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnActionButtonClick
    end
    object btnQuote: TDNMSpeedButton
      Left = 385
      Top = 5
      Width = 84
      Height = 27
      HelpContext = 174041
      Anchors = [akBottom]
      Caption = '&Quote'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnActionButtonClick
    end
    object btnInvoice: TDNMSpeedButton
      Left = 656
      Top = 5
      Width = 84
      Height = 27
      HelpContext = 174086
      Anchors = [akBottom]
      Caption = '&Invoice'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnActionButtonClick
    end
    object btnSalesOrder: TDNMSpeedButton
      Left = 566
      Top = 5
      Width = 84
      Height = 27
      HelpContext = 174043
      Anchors = [akBottom]
      Caption = '&Sales Order'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnActionButtonClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 747
      Top = 5
      Width = 84
      Height = 27
      HelpContext = 174087
      Anchors = [akBottom]
      Caption = '&Print'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = btnPrintClick
    end
    object btnEmailAction: TDNMSpeedButton
      Left = 294
      Top = 5
      Width = 84
      Height = 27
      HelpContext = 174088
      Anchors = [akBottom]
      Caption = '&Email'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 8
      AutoDisableParentOnclick = True
      OnClick = btnEmailActionClick
    end
    object btnTodo: TDNMSpeedButton
      Left = 475
      Top = 5
      Width = 84
      Height = 27
      HelpContext = 174089
      Anchors = [akBottom]
      Caption = 'To Do'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 9
      AutoDisableParentOnclick = True
      OnClick = btnActionButtonClick
    end
  end
  object pnlTop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 945
    Height = 47
    HelpContext = 174032
    Align = alTop
    BevelOuter = bvNone
    UseDockManager = False
    DragMode = dmAutomatic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      945
      47)
    object Label4: TLabel
      Left = 704
      Top = 29
      Width = 157
      Height = 15
      HelpContext = 174045
      Alignment = taCenter
      Caption = 'Double click any field to Edit'
      Enabled = False
      Transparent = True
    end
    object pnlTitle: TDNMPanel
      Left = 301
      Top = 3
      Width = 366
      Height = 39
      HelpContext = 174033
      Anchors = [akLeft, akTop, akRight]
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
        Width = 362
        Height = 35
        HelpContext = 174034
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
          Width = 362
          Height = 35
          HelpContext = 174035
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Lead'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 1
        end
      end
    end
  end
  object DNMPanel1: TDNMPanel [7]
    Left = 0
    Top = 47
    Width = 945
    Height = 479
    HelpContext = 174002
    Align = alClient
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
    object lblMsg: TLabel
      Left = 0
      Top = 166
      Width = 945
      Height = 15
      HelpContext = 174046
      Align = alTop
      Alignment = taCenter
      Caption = 'Double click any field to Edit'
      Enabled = False
      Transparent = True
      Visible = False
      ExplicitWidth = 157
    end
    object pnlheader: TDNMPanel
      Left = 0
      Top = 0
      Width = 945
      Height = 166
      HelpContext = 174047
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Bevel3: TBevel
        Left = 413
        Top = 2
        Width = 526
        Height = 161
        HelpContext = 174003
        Shape = bsFrame
      end
      object Bevel: TBevel
        Left = 839
        Top = 11
        Width = 93
        Height = 92
        HelpContext = 174004
        Shape = bsFrame
      end
      object Bevel2: TBevel
        Left = 10
        Top = 2
        Width = 397
        Height = 161
        HelpContext = 174005
        Shape = bsFrame
      end
      object Label7: TLabel
        Left = 18
        Top = 11
        Width = 58
        Height = 16
        HelpContext = 174006
        AutoSize = False
        Caption = 'Company'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label15: TLabel
        Left = 31
        Top = 34
        Width = 41
        Height = 18
        HelpContext = 174007
        AutoSize = False
        Caption = 'Details'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object LastTrainerID_Label: TLabel
        Left = 648
        Top = 38
        Width = 37
        Height = 15
        HelpContext = 174009
        Alignment = taRightJustify
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
      object Label9: TLabel
        Left = 665
        Top = 12
        Width = 20
        Height = 15
        HelpContext = 174010
        Alignment = taRightJustify
        Caption = 'Fax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Cus_Alt_PH_Label: TLabel
        Left = 428
        Top = 37
        Width = 60
        Height = 17
        HelpContext = 174011
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Alt Phone'
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
        Left = 428
        Top = 12
        Width = 60
        Height = 17
        HelpContext = 174012
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Co Phone'
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
        Left = 420
        Top = 139
        Width = 68
        Height = 16
        HelpContext = 174013
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Entered By'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label22: TLabel
        Left = 845
        Top = 16
        Width = 83
        Height = 48
        HelpContext = 174014
        Alignment = taCenter
        AutoSize = False
        Caption = 'No. of days since last Action'
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
        Left = 435
        Top = 113
        Width = 53
        Height = 18
        HelpContext = 174048
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Source'
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
        Left = 692
        Top = 113
        Width = 28
        Height = 16
        HelpContext = 174078
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Rep'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Visible = False
        WordWrap = True
      end
      object Label8: TLabel
        Left = 453
        Top = 88
        Width = 35
        Height = 15
        HelpContext = 174049
        Alignment = taRightJustify
        Caption = 'E-mail'
        Transparent = True
      end
      object Label10: TLabel
        Left = 33
        Top = 140
        Width = 26
        Height = 15
        HelpContext = 174050
        Caption = 'Web'
        Transparent = True
      end
      object Label11: TLabel
        Left = 697
        Top = 140
        Width = 42
        Height = 15
        HelpContext = 174051
        AutoSize = False
        Caption = 'Status'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label12: TLabel
        Left = 417
        Top = 62
        Width = 71
        Height = 15
        HelpContext = 174079
        Alignment = taRightJustify
        Caption = 'Skype Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label13: TLabel
        Left = 648
        Top = 63
        Width = 76
        Height = 15
        HelpContext = 174090
        Alignment = taRightJustify
        Caption = 'Lead Created'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object txtCompany: TDBEdit
        Left = 78
        Top = 8
        Width = 320
        Height = 23
        HelpContext = 174029
        DataField = 'Company'
        DataSource = dsLeads
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 12
        OnDblClick = txtCompanyDblClick
      end
      object txtPhone: TwwDBEdit
        Left = 490
        Top = 9
        Width = 146
        Height = 23
        HelpContext = 174020
        DataField = 'Phone'
        DataSource = dsmarketingcontact
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnDblClick = txtCompanyDblClick
      end
      object txtAltPhone: TwwDBEdit
        Left = 490
        Top = 34
        Width = 146
        Height = 23
        HelpContext = 174021
        DataField = 'AltPhone'
        DataSource = dsmarketingcontact
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnDblClick = txtCompanyDblClick
      end
      object txtFax: TDBEdit
        Left = 688
        Top = 9
        Width = 146
        Height = 23
        HelpContext = 174022
        DataField = 'FaxNumber'
        DataSource = dsmarketingcontact
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
        OnDblClick = txtCompanyDblClick
      end
      object txtMoblie: TwwDBEdit
        Left = 688
        Top = 34
        Width = 146
        Height = 23
        HelpContext = 174023
        DataField = 'Mobile'
        DataSource = dsmarketingcontact
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnDblClick = txtCompanyDblClick
      end
      object txtDays: TwwDBEdit
        Left = 855
        Top = 66
        Width = 62
        Height = 24
        HelpContext = 174024
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 11
        UnboundDataType = wwDefault
        UnboundAlignment = taCenter
        WantReturns = False
        WordWrap = False
      end
      object txtClientDetails: TMemo
        Left = 78
        Top = 37
        Width = 321
        Height = 96
        HelpContext = 174030
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnDblClick = txtCompanyDblClick
      end
      object cboEnteredBy: TwwDBLookupCombo
        Left = 490
        Top = 136
        Width = 199
        Height = 23
        HelpContext = 174031
        TabStop = False
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'40'#9'EmployeeName'#9'T')
        DataField = 'EnteredBy'
        DataSource = dsLeads
        LookupTable = qryEmployeeLookup
        LookupField = 'EmployeeID'
        Style = csDropDownList
        DropDownWidth = 430
        ParentFont = False
        TabOrder = 10
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboSource: TwwDBLookupCombo
        Left = 490
        Top = 110
        Width = 199
        Height = 23
        HelpContext = 174052
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'MediaType'#9'50'#9'MediaType'#9'F')
        DataField = 'Source'
        DataSource = dsmarketingcontact
        LookupTable = qryMediaType
        LookupField = 'MediaType'
        Style = csDropDownList
        DropDownWidth = 40
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = True
        OnDblClick = txtCompanyDblClick
        OnCloseUp = cboSourceCloseUp
      end
      object cboRep: TwwDBLookupCombo
        Left = 739
        Top = 110
        Width = 192
        Height = 23
        HelpContext = 174080
        TabStop = False
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'40'#9'EmployeeName'#9'T')
        DataField = 'RepName'
        DataSource = dsLeads
        LookupTable = qryRep
        LookupField = 'EmployeeID'
        Style = csDropDownList
        DropDownWidth = 430
        ParentFont = False
        TabOrder = 9
        Visible = False
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object edEmail: TDBEdit
        Left = 490
        Top = 85
        Width = 344
        Height = 23
        HelpContext = 174081
        DataField = 'Email'
        DataSource = dsmarketingcontact
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsUnderline]
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
        OnClick = edEmailClick
      end
      object edWeb: TDBEdit
        Left = 78
        Top = 138
        Width = 321
        Height = 23
        HelpContext = 174082
        DataField = 'URL'
        DataSource = dsmarketingcontact
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsUnderline]
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        OnClick = edWebClick
        OnDblClick = txtCompanyDblClick
      end
      object cboLeadStatus2: TwwDBLookupCombo
        Left = 739
        Top = 136
        Width = 192
        Height = 23
        HelpContext = 174053
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'name'#9'15'#9'name'#9'F')
        DataField = 'LeadStatus'
        DataSource = dsLeads
        LookupTable = qryLeadStatus
        LookupField = 'name'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 13
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnNotInList = cboLeadStatus2NotInList
      end
      object wwDBEdit1: TwwDBEdit
        Left = 490
        Top = 59
        Width = 146
        Height = 23
        HelpContext = 174083
        DataField = 'SkypeName'
        DataSource = dsmarketingcontact
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnDblClick = txtCompanyDblClick
      end
      object cbomarketingcontact: TERPDbLookupCombo
        Left = 78
        Top = 8
        Width = 320
        Height = 23
        HelpContext = 174054
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ControlType.Strings = (
          'OtherContact;CheckBox;T;F'
          'Customer;CheckBox;T;F'
          'Supplier;CheckBox;T;F')
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'company'#9'20'#9'Company'#9'F'
          'SUBURB'#9'15'#9'Suburb'#9'F'
          'STATE'#9'5'#9'State'#9'F'
          'POSTCODE'#9'5'#9'Post Code'#9'F'
          'OtherContact'#9'1'#9'Other Contact?'#9'F'
          'Customer'#9'1'#9'Customer?'#9'F'
          'Supplier'#9'1'#9'Supplier?'#9'F')
        DataField = 'Company'
        DataSource = dsLeads
        LookupTable = qryMarketingContacts
        LookupField = 'company'
        Options = [loTitles]
        ParentFont = False
        TabOrder = 14
        AutoDropDown = True
        ShowButton = True
        UseTFields = False
        PreciseEditRegion = False
        AllowClearKey = False
        OnDblClick = cbomarketingcontactDblClick
        OnDropDown = cbomarketingcontactDropDown
        OnCloseUp = cbomarketingcontactCloseUp
        OnEnter = cbomarketingcontactEnter
        OnExit = cbomarketingcontactExit
        OnNotInList = cbomarketingcontactNotInList
        LookupFormClassName = 'TMarketingcontactListForLeadGUI'
        EditFormClassName = 'TfmMarketingContact'
        LookupFormKeyStringFieldName = 'Company'
        LookupComboType = ctMarketingContact
        AllowFullListSearchMode = False
        OnAfterchange = cbomarketingcontactAfterchange
        OnAfterUpdateMe = cbomarketingcontactAfterUpdateMe
        DisableNotInList = False
        AllowMultipleSelectFromList = False
        OpenListinF6WhenNotinList = False
        DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
        LookupIDField = 'ID'
      end
      object wwDBEdit2: TwwDBEdit
        Left = 730
        Top = 59
        Width = 103
        Height = 23
        HelpContext = 174091
        DataField = 'CreatedOn'
        DataSource = dsLeads
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 15
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object TabCTL20: TPageControl
      AlignWithMargins = True
      Left = 11
      Top = 181
      Width = 923
      Height = 298
      HelpContext = 174055
      Margins.Left = 11
      Margins.Top = 0
      Margins.Right = 11
      Margins.Bottom = 0
      ActivePage = tabActionFollowup
      Align = alClient
      TabHeight = 22
      TabOrder = 1
      TabWidth = 222
      OnResize = TabCTL20Resize
      object tabActionFollowup: TTabSheet
        HelpContext = 174056
        Caption = 'Action / Followup'
        DesignSize = (
          915
          266)
        object lblFollowUpType: TLabel
          Left = 5
          Top = 2
          Width = 177
          Height = 18
          HelpContext = 174017
          Caption = 'Action / Follow up Details'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label5: TLabel
          Left = 5
          Top = 176
          Width = 80
          Height = 15
          HelpContext = 174018
          Anchors = [akLeft, akRight, akBottom]
          Caption = 'Contact Notes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          ExplicitTop = 188
        end
        object grdActions: TwwDBGrid
          Left = 3
          Top = 24
          Width = 904
          Height = 146
          HelpContext = 174057
          ControlInfoInDataset = False
          ControlType.Strings = (
            'ClassNameTo;CustomEdit;cboClassTo;F'
            'ProductName;CustomEdit;cboProduct;F'
            'UOM;CustomEdit;cboUOM;F'
            'CustomerName;CustomEdit;cboClient;F'
            'BinLocationFrom;CustomEdit;cboBinLocation;F'
            'BinLocationTo;CustomEdit;cboBinLocationTo;F'
            'BinNumberFrom;CustomEdit;cboBinNumber;F'
            'BinNumberTo;CustomEdit;cbobinnumberTo;F'
            'BatchNo;CustomEdit;cboBatchnumber;F'
            'BatchNoFrom;CustomEdit;cboBatchnumberFrom;F'
            'BatchNoTo;CustomEdit;cbobatchnumberto;F'
            'ActionTypeName;CustomEdit;cboActionType;F'
            'ResultTypeName;CustomEdit;cboresultType;F'
            'Priority;CustomEdit;cboPriority;F'
            'EmployeeName;CustomEdit;cboLineEmployee;F'
            'StatusID;CustomEdit;cboStatus;F'
            'Done;CheckBox;T;F'
            'ActionDate;CustomEdit;dtActionDate;F')
          Selected.Strings = (
            'ActionTypeName'#9'15'#9'Type'#9'F'#9'Action'
            'ActionDate'#9'10'#9'Date'#9'F'#9'Action'
            'Notes'#9'28'#9'Notes'#9'F'
            'Status'#9'20'#9'Appointment~Status'#9'F'
            'EmployeeName'#9'20'#9'Employee'#9'F'
            'Done'#9'1'#9'Done'#9'F'
            'ActionID'#9'10'#9'Sale #'#9'T'
            'salesPONumber'#9'10'#9'P.O. Number'#9'F')
          MemoAttributes = [mSizeable, mWordWrap, mGridShow]
          IniAttributes.Delimiter = ';;'
          TitleColor = 14155775
          OnRowChanged = grdActionsRowChanged
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dsLeadLines
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = [dgEnterToTab, dgAllowInsert]
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgRowResize]
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = True
          UseTFields = False
          LoadAllRTF = True
          OnCalcCellColors = grdActionsCalcCellColors
          OnColEnter = grdActionsColEnter
          OnDblClick = grdActionsDblClick
          OnEnter = grdActionsEnter
          FooterColor = 14155775
          PaintOptions.BackgroundOptions = [coBlendFixedRow]
          object SubformDetailsIButton: TwwIButton
            Left = 0
            Top = 0
            Width = 19
            Height = 34
            HelpContext = 174058
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
        object cboActionType: TwwDBLookupCombo
          Left = 25
          Top = 81
          Width = 121
          Height = 23
          HelpContext = 174059
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'ActionTypeName'
          DataSource = dsLeadLines
          LookupTable = qryActionType
          LookupField = 'Name'
          DropDownCount = 11
          TabOrder = 1
          Visible = False
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDblClick = cboActionTypeDblClick
          OnCloseUp = cboActionTypeCloseUp
          OnNotInList = cboActionTypeNotInList
        end
        object cboStatus: TwwDBLookupCombo
          Left = 150
          Top = 81
          Width = 121
          Height = 23
          HelpContext = 174060
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          DataField = 'Status'
          DataSource = dsLeadLines
          LookupTable = qryStatus
          LookupField = 'Id'
          DropDownCount = 11
          TabOrder = 2
          Visible = False
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDblClick = grdActionsDblClick
        end
        object cboPriority: TwwDBComboBox
          Left = 277
          Top = 81
          Width = 135
          Height = 23
          HelpContext = 174061
          ShowButton = True
          Style = csDropDownList
          MapList = True
          AllowClearKey = False
          AutoDropDown = True
          AutoFillDate = False
          DropDownCount = 11
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            '10 - High'#9'10'
            '9'#9'9'
            '8'#9'8'
            '7'#9'7'
            '6'#9'6'
            '5  - Standard'#9'5'
            '4'#9'4'
            '3'#9'3'
            '2'#9'2'
            '1'#9'1'
            '0  - Low'#9'0')
          ParentFont = False
          Sorted = False
          TabOrder = 3
          UnboundDataType = wwDefault
          Visible = False
          UnboundAlignment = taCenter
          OnDblClick = grdActionsDblClick
        end
        object dtActionDate: TwwDBDateTimePicker
          Left = 295
          Top = 81
          Width = 121
          Height = 23
          HelpContext = 174062
          CalendarAttributes.Font.Charset = DEFAULT_CHARSET
          CalendarAttributes.Font.Color = clWindowText
          CalendarAttributes.Font.Height = -11
          CalendarAttributes.Font.Name = 'MS Sans Serif'
          CalendarAttributes.Font.Style = []
          CalendarAttributes.PopupYearOptions.NumberColumns = 4
          Epoch = 1950
          ShowButton = True
          TabOrder = 4
          OnDblClick = grdActionsDblClick
        end
        object cboLineEmployee: TwwDBLookupCombo
          Left = 422
          Top = 81
          Width = 121
          Height = 23
          HelpContext = 174063
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'EmployeeName'#9'40'#9'EmployeeName'#9#9)
          DataField = 'EmployeeName'
          DataSource = dsLeadLines
          LookupTable = qryEmployeeLookup
          LookupField = 'EmployeeName'
          DropDownCount = 11
          DropDownWidth = 121
          TabOrder = 5
          Visible = False
          AutoDropDown = True
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDblClick = grdActionsDblClick
        end
        object cboresultType: TwwDBLookupCombo
          Left = 545
          Top = 81
          Width = 121
          Height = 23
          HelpContext = 174064
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Name'#9'30'#9'Name'#9'F')
          LookupTable = qryActiontypes
          LookupField = 'Name'
          DropDownCount = 11
          TabOrder = 6
          Visible = False
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnDblClick = grdActionsDblClick
        end
        object memContactNotes: TDBMemo
          Left = 5
          Top = 196
          Width = 904
          Height = 66
          HelpContext = 174027
          TabStop = False
          Anchors = [akLeft, akRight, akBottom]
          DataField = 'Notes'
          DataSource = dsmarketingcontact
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 7
          OnDblClick = txtCompanyDblClick
        end
      end
      object actCorrespondence: TTabSheet
        HelpContext = 174065
        Caption = 'Correspondence'
        ImageIndex = 1
        object pnlDocumentsInner: TDNMPanel
          Left = 0
          Top = 0
          Width = 915
          Height = 266
          HelpContext = 174066
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object Splitter1: TSplitter
            Left = 0
            Top = 142
            Width = 915
            Height = 3
            Cursor = crVSplit
            HelpContext = 174067
            Align = alTop
            ExplicitTop = 177
            ExplicitWidth = 225
          end
          object pnlDocumentsList: TDNMPanel
            Left = 0
            Top = 0
            Width = 915
            Height = 142
            HelpContext = 174068
            Align = alTop
            BevelOuter = bvNone
            Constraints.MinHeight = 130
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            DesignSize = (
              915
              142)
            object Label96: TLabel
              Left = 129
              Top = 9
              Width = 147
              Height = 15
              HelpContext = 174069
              Caption = 'Show inactive Documents'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label140: TLabel
              Left = 635
              Top = 17
              Width = 178
              Height = 13
              HelpContext = 174070
              Alignment = taRightJustify
              Anchors = [akTop, akRight]
              Caption = 'Double click to open correspondence'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              Transparent = True
              WordWrap = True
              ExplicitLeft = 641
            end
            object grdDocs: TwwDBGrid
              Left = 7
              Top = 32
              Width = 806
              Height = 107
              HelpContext = 174071
              ControlType.Strings = (
                'active;CheckBox;T;F'
                'Active;CheckBox;T;F')
              Selected.Strings = (
                'Date'#9'19'#9'Date'
                'Type'#9'8'#9'Type'
                'Reference'#9'19'#9'Reference'#9'F'
                'MarketingContactName'#9'15'#9'Marketing Contact'
                'MessageFrom'#9'20'#9'Message From'
                'MessageTo'#9'20'#9'Message To'
                'Active'#9'1'#9'Active')
              IniAttributes.Delimiter = ';;'
              TitleColor = clWhite
              OnRowChanged = grdDocsRowChanged
              FixedCols = 0
              ShowHorzScrollBar = True
              Anchors = [akLeft, akTop, akRight, akBottom]
              Color = clWhite
              DataSource = dsCorrespondence
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              KeyOptions = []
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              TitleAlignment = taLeftJustify
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clWindowText
              TitleFont.Height = -12
              TitleFont.Name = 'Arial'
              TitleFont.Style = [fsBold]
              TitleLines = 1
              TitleButtons = False
              OnDblClick = grdDocsDblClick
              FooterColor = clWhite
              FooterCellColor = clWhite
            end
            object btnGetEmails: TButton
              Left = 9
              Top = 4
              Width = 75
              Height = 25
              HelpContext = 174072
              Caption = 'Get Emails'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnClick = btnGetEmailsClick
            end
            object chkShowInactive: TCheckBox
              Left = 108
              Top = 9
              Width = 15
              Height = 17
              HelpContext = 174073
              Color = 14867920
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              TabOrder = 2
              OnClick = chkShowInactiveClick
            end
            object btnemail: TDNMSpeedButton
              Left = 821
              Top = 95
              Width = 87
              Height = 27
              HelpContext = 174042
              Anchors = [akTop, akRight]
              Caption = '&Email'
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
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
              TabOrder = 5
              AutoDisableParentOnclick = True
              OnClick = btnemailClick
            end
            object btnLetter: TDNMSpeedButton
              Left = 821
              Top = 32
              Width = 87
              Height = 27
              HelpContext = 174084
              Anchors = [akTop, akRight]
              Caption = 'Letter'
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
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
              TabOrder = 3
              AutoDisableParentOnclick = True
              OnClick = btnLetterClick
            end
            object btnFax: TDNMSpeedButton
              Left = 821
              Top = 64
              Width = 87
              Height = 27
              HelpContext = 174085
              Anchors = [akTop, akRight]
              Caption = 'Fax'
              DisableTransparent = False
              Font.Charset = DEFAULT_CHARSET
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
              TabOrder = 4
              AutoDisableParentOnclick = True
              OnClick = btnFaxClick
            end
          end
          object pnlDocumentsMessage: TDNMPanel
            Left = 0
            Top = 145
            Width = 915
            Height = 121
            HelpContext = 174074
            Align = alClient
            BevelOuter = bvNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            DesignSize = (
              915
              121)
            object HtmlViewer: THtmlViewer
              Left = 7
              Top = 2
              Width = 900
              Height = 58
              HelpContext = 174075
              TabOrder = 0
              Anchors = [akLeft, akTop, akRight, akBottom]
              BorderStyle = htFocused
              CharSet = DEFAULT_CHARSET
              DefBackground = clWhite
              DefFontName = 'Arial'
              DefFontSize = 9
              DefPreFontName = 'Courier New'
              HistoryMaxCount = 0
              NoSelect = False
              PrintMarginBottom = 2.000000000000000000
              PrintMarginLeft = 2.000000000000000000
              PrintMarginRight = 2.000000000000000000
              PrintMarginTop = 2.000000000000000000
              PrintScale = 1.000000000000000000
              QuirksMode = qmDetect
              OnHotSpotClick = HtmlViewerHotSpotClick
              OnImageRequest = HtmlViewerImageRequest
            end
            object lvAttachments: TListView
              Left = 7
              Top = 68
              Width = 902
              Height = 49
              HelpContext = 174076
              Anchors = [akLeft, akTop, akRight, akBottom]
              Columns = <>
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              ViewStyle = vsSmallIcon
              OnDblClick = lvAttachmentsDblClick
            end
          end
        end
      end
      object tabAttachments: TTabSheet
        HelpContext = 174077
        Caption = 'Attachments'
        ImageIndex = 2
      end
      object Custom_Fields: TTabSheet
        HelpContext = 174092
        Caption = 'Custom Fields'
        ImageIndex = 3
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object pnlCustFieldsTab: TDNMPanel
          Left = 0
          Top = 0
          Width = 915
          Height = 266
          HelpContext = 174093
          Align = alClient
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Transparent = False
          object pgCustomFields: TPageControl
            Left = 0
            Top = 0
            Width = 915
            Height = 266
            HelpContext = 174094
            ActivePage = tabCustomFields
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            TabWidth = 387
            object tabCustomFields: TTabSheet
              HelpContext = 174095
              Caption = 'Customisable List'
              object pnlcustomfieldList: TDNMPanel
                Left = 0
                Top = 0
                Width = 907
                Height = 236
                HelpContext = 174096
                Align = alClient
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
            end
          end
        end
      end
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C01010200FC00800110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryLeads: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblMarketingLeads WHERE LeadID = :LeadID')
    AfterOpen = qryLeadsAfterOpen
    Left = 178
    Top = 2
    ParamData = <
      item
        DataType = ftString
        Name = 'LeadID'
        Value = '1'
      end>
    object qryLeadsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblMarketingLeads.GlobalRef'
      Size = 255
    end
    object qryLeadsLeadID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'LeadID'
      Origin = 'tblMarketingLeads.LeadID'
    end
    object qryLeadsMarketingContactID: TIntegerField
      FieldName = 'MarketingContactID'
      Origin = 'tblMarketingLeads.MarketingContactID'
    end
    object qryLeadsCompany: TWideStringField
      FieldName = 'Company'
      Origin = 'tblMarketingLeads.Company'
      Size = 255
    end
    object qryLeadsClientID: TIntegerField
      FieldName = 'ClientID'
      Origin = 'tblMarketingLeads.ClientID'
    end
    object qryLeadsRepID: TIntegerField
      FieldName = 'RepID'
      Origin = 'tblMarketingLeads.RepID'
    end
    object qryLeadsEnteredByEmployeeID: TIntegerField
      FieldName = 'EnteredByEmployeeID'
      Origin = 'tblMarketingLeads.EnteredByEmployeeID'
    end
    object qryLeadsIsLead: TWideStringField
      FieldName = 'IsLead'
      Origin = 'tblMarketingLeads.IsLead'
      FixedChar = True
      Size = 1
    end
    object qryLeadsmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblMarketingLeads.msTimeStamp'
    end
    object qryLeadsnotes: TWideStringField
      FieldName = 'notes'
      Size = 255
    end
    object qryLeadsEnteredBy: TWideStringField
      FieldKind = fkLookup
      FieldName = 'EnteredBy'
      LookupDataSet = qryEmployeeLookup
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'EnteredByEmployeeID'
      Size = 100
      Lookup = True
    end
    object qryLeadsRepName: TWideStringField
      FieldKind = fkLookup
      FieldName = 'RepName'
      LookupDataSet = qryRep
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'RepID'
      Size = 100
      Lookup = True
    end
    object qryLeadsLeadStatus: TWideStringField
      FieldName = 'LeadStatus'
      Size = 255
    end
    object qryLeadsCreatedOn: TDateTimeField
      FieldName = 'CreatedOn'
    end
    object qryLeadsmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
  end
  object qryLeadLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblMarketingLeadLines')
    BeforeOpen = qryLeadLinesBeforeOpen
    BeforePost = qryLeadLinesBeforePost
    AfterScroll = qryLeadLinesAfterScroll
    Left = 211
    Top = 3
    object qryLeadLinesActionTypeName: TWideStringField
      DisplayLabel = 'Action Type'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ActionTypeName'
      LookupDataSet = qrySimpleTypes
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'ActionType'
      Size = 255
      Lookup = True
    end
    object qryLeadLinesCreationDate: TDateTimeField
      DisplayLabel = 'Action Date'
      DisplayWidth = 15
      FieldName = 'CreationDate'
      Origin = 'tblMarketingLeadLines.CreationDate'
    end
    object qryLeadLinesStatus: TWideStringField
      DisplayLabel = 'Appointment Status'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'Status'
      LookupDataSet = qrySimpleTypes
      LookupKeyFields = 'Id'
      LookupResultField = 'Name'
      KeyFields = 'StatusID'
      Size = 255
      Lookup = True
    end
    object qryLeadLinesResultTypeName: TWideStringField
      DisplayLabel = 'Followup Type'
      DisplayWidth = 15
      FieldName = 'ResultTypeName'
      Origin = 'tblMarketingLeadLines.ResultTypeName'
      Size = 255
    end
    object qryLeadLinesPriority: TIntegerField
      DisplayWidth = 15
      FieldName = 'Priority'
      Origin = 'tblMarketingLeadLines.Priority'
    end
    object qryLeadLinesDone: TWideStringField
      DisplayWidth = 1
      FieldName = 'Done'
      Origin = 'tblMarketingLeadLines.Done'
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesNotes: TWideMemoField
      DisplayWidth = 19
      FieldName = 'Notes'
      Origin = 'tblMarketingLeadLines.Notes'
      BlobType = ftWideMemo
    end
    object qryLeadLinesFollowUpDate: TDateTimeField
      DisplayLabel = 'FollowUp Date'
      DisplayWidth = 18
      FieldName = 'FollowUpDate'
      Origin = 'tblMarketingLeadLines.FollowUpDate'
      Visible = False
    end
    object qryLeadLinesGlobalRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'GlobalRef'
      Origin = 'tblMarketingLeadLines.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryLeadLinesLeadID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LeadID'
      Origin = 'tblMarketingLeadLines.LeadID'
      Visible = False
    end
    object qryLeadLinesLeadLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'LeadLineID'
      Origin = 'tblMarketingLeadLines.LeadLineID'
      Visible = False
    end
    object qryLeadLinesActionType: TIntegerField
      DisplayWidth = 10
      FieldName = 'ActionType'
      Origin = 'tblMarketingLeadLines.ActionType'
      Visible = False
      OnSetText = FeldSetTextDontAllowNulls
    end
    object qryLeadLinesActionID: TIntegerField
      DisplayLabel = 'Sale #'
      DisplayWidth = 10
      FieldName = 'ActionID'
      Origin = 'tblMarketingLeadLines.ActionID'
    end
    object qryLeadLinesFollowupID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FollowupID'
      Origin = 'tblMarketingLeadLines.FollowupID'
      Visible = False
    end
    object qryLeadLinesActionRef: TWideStringField
      DisplayWidth = 40
      FieldName = 'ActionRef'
      Origin = 'tblMarketingLeadLines.ActionRef'
      Visible = False
      Size = 255
    end
    object qryLeadLinesUpdateDate: TDateTimeField
      DisplayLabel = 'Due on'
      DisplayWidth = 18
      FieldName = 'UpdateDate'
      Origin = 'tblMarketingLeadLines.UpdateDate'
      Visible = False
    end
    object qryLeadLinesStatusID: TIntegerField
      DisplayWidth = 10
      FieldName = 'StatusID'
      Origin = 'tblMarketingLeadLines.StatusID'
      Visible = False
    end
    object qryLeadLinesEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblMarketingLeadLines.EmployeeID'
      Visible = False
    end
    object qryLeadLinesDuration: TWideStringField
      DisplayWidth = 40
      FieldName = 'Duration'
      Origin = 'tblMarketingLeadLines.Duration'
      Visible = False
      Size = 255
    end
    object qryLeadLinesTypeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'TypeId'
      Origin = 'tblMarketingLeadLines.TypeId'
      Visible = False
    end
    object qryLeadLinesTypeName: TWideStringField
      DisplayWidth = 40
      FieldName = 'TypeName'
      Origin = 'tblMarketingLeadLines.TypeName'
      Visible = False
      Size = 255
    end
    object qryLeadLinesHours: TFloatField
      DisplayWidth = 10
      FieldName = 'Hours'
      Origin = 'tblMarketingLeadLines.Hours'
      Visible = False
    end
    object qryLeadLinesResultTypeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ResultTypeId'
      Origin = 'tblMarketingLeadLines.ResultTypeId'
      Visible = False
    end
    object qryLeadLinesIsPhoneFollowUp: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsPhoneFollowUp'
      Origin = 'tblMarketingLeadLines.IsPhoneFollowUp'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesEntryCount: TIntegerField
      DisplayWidth = 10
      FieldName = 'EntryCount'
      Origin = 'tblMarketingLeadLines.EntryCount'
      Visible = False
    end
    object qryLeadLinesCreatedByID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CreatedByID'
      Origin = 'tblMarketingLeadLines.CreatedByID'
      Visible = False
    end
    object qryLeadLinesIsMarketing: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsMarketing'
      Origin = 'tblMarketingLeadLines.IsMarketing'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesIsLead: TWideStringField
      DisplayWidth = 1
      FieldName = 'IsLead'
      Origin = 'tblMarketingLeadLines.IsLead'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryLeadLinesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblMarketingLeadLines.msTimeStamp'
      Visible = False
    end
    object qryLeadLinesActionDate: TDateTimeField
      FieldName = 'ActionDate'
      Origin = 'tblMarketingLeadLines.ActionDate'
    end
    object qryLeadLinesEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
    end
    object qryLeadLinessalesPONumber: TWideStringField
      DisplayLabel = 'P.O. Number'
      FieldKind = fkLookup
      FieldName = 'salesPONumber'
      LookupDataSet = QrysalesCustomerPONum
      LookupKeyFields = 'saleID'
      LookupResultField = 'PONumber'
      KeyFields = 'ActionID'
      Size = 30
      Lookup = True
    end
  end
  object dsLeads: TDataSource
    DataSet = qryLeads
    Left = 178
    Top = 33
  end
  object dsLeadLines: TDataSource
    DataSet = qryLeadLines
    Left = 212
    Top = 33
  end
  object qryEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeID, EmployeeName, Active '
      'FROM tblemployees'
      
        'where (Active = "T") or (:EmployeeName <> "" and EmployeeName = ' +
        ':EmployeeName)'
      'ORDER BY EmployeeName')
    Left = 666
    Top = 42
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'EmployeeName'
      end
      item
        DataType = ftUnknown
        Name = 'EmployeeName'
      end>
    object qryEmployeeLookupEmployeeName: TWideStringField
      DisplayWidth = 40
      FieldName = 'EmployeeName'
      Origin = 'tblemployees.EmployeeName'
      Size = 255
    end
    object qryEmployeeLookupEmployeeID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblemployees.EmployeeID'
      Visible = False
    end
    object qryEmployeeLookupActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
  end
  object qryActionType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT * FROM tblSimpleTypes WHERE Active <> '#39'F'#39' AND TypeCode = ' +
        #39'LeadActionType'#39' '
      
        'AND NOT (name in ('#39'Appointment'#39', '#39'Invoice'#39', '#39'Quote'#39', '#39'SalesOrder' +
        #39', '#39'Lead'#39'))')
    Left = 93
    Top = 109
    object qryActionTypeName: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
    object qryActionTypeId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'Id'
      Origin = 'tblsimpletypes.Id'
      Visible = False
    end
    object qryActionTypeTypeCode: TWideStringField
      DisplayWidth = 30
      FieldName = 'TypeCode'
      Origin = 'tblsimpletypes.TypeCode'
      Visible = False
      Size = 30
    end
    object qryActionTypeActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblsimpletypes.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryStatus: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Id, TypeCode, Name, Active '
      'FROM tblsimpletypes'
      'ORDER BY Name')
    Filtered = True
    Left = 174
    Top = 106
    object StringField2: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
    object IntegerField1: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'Id'
      Origin = 'tblsimpletypes.Id'
      Visible = False
    end
    object StringField1: TWideStringField
      DisplayWidth = 30
      FieldName = 'TypeCode'
      Origin = 'tblsimpletypes.TypeCode'
      Visible = False
      Size = 30
    end
    object StringField3: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblsimpletypes.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryMarketingContact: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM tblmarketingcontacts'
      'WHERE ID = :ID')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 319
    Top = 2
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Value = ''
      end>
    object qryMarketingContactID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'tblmarketingcontacts.ID'
    end
    object qryMarketingContactFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblmarketingcontacts.FaxNumber'
      Size = 255
    end
    object qryMarketingContactPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblmarketingcontacts.Phone'
      Size = 255
    end
    object qryMarketingContactAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblmarketingcontacts.AltPhone'
      Size = 255
    end
    object qryMarketingContactMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblmarketingcontacts.Mobile'
      Size = 255
    end
    object qryMarketingContactSource: TWideStringField
      FieldName = 'Source'
      Origin = 'tblmarketingcontacts.Source'
      Size = 255
    end
    object qryMarketingContactNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object qryMarketingContactCOMPANY: TWideStringField
      FieldName = 'COMPANY'
      Size = 255
    end
    object qryMarketingContactStreet: TWideStringField
      FieldName = 'Street'
      Size = 255
    end
    object qryMarketingContactStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 255
    end
    object qryMarketingContactStreet3: TWideStringField
      FieldName = 'Street3'
      Size = 255
    end
    object qryMarketingContactSUBURB: TWideStringField
      FieldName = 'SUBURB'
      Size = 255
    end
    object qryMarketingContactSTATE: TWideStringField
      FieldName = 'STATE'
      Size = 255
    end
    object qryMarketingContactPOSTCODE: TWideStringField
      FieldName = 'POSTCODE'
      Size = 255
    end
    object qryMarketingContactCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryMarketingContactGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMarketingContactCompanyTypeName: TWideStringField
      FieldName = 'CompanyTypeName'
      Size = 255
    end
    object qryMarketingContactEmployeeSize: TWideStringField
      FieldName = 'EmployeeSize'
      Size = 255
    end
    object qryMarketingContactActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryMarketingContactJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object qryMarketingContactTitle: TWideStringField
      FieldName = 'Title'
      Size = 16
    end
    object qryMarketingContactFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 255
    end
    object qryMarketingContactMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Size = 255
    end
    object qryMarketingContactLastName: TWideStringField
      FieldName = 'LastName'
      Size = 255
    end
    object qryMarketingContactEmail: TWideStringField
      FieldName = 'Email'
      Size = 255
    end
    object qryMarketingContactDateEntered: TDateTimeField
      FieldName = 'DateEntered'
    end
    object qryMarketingContactEnteredEmpID: TIntegerField
      FieldName = 'EnteredEmpID'
    end
    object qryMarketingContactDateOfBirth: TDateField
      FieldName = 'DateOfBirth'
    end
    object qryMarketingContactDuration: TDateTimeField
      FieldName = 'Duration'
    end
    object qryMarketingContactmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryMarketingContactNumUnansweredCalls: TIntegerField
      FieldName = 'NumUnansweredCalls'
    end
    object qryMarketingContactDoNotQualify: TWideStringField
      FieldName = 'DoNotQualify'
      FixedChar = True
      Size = 1
    end
    object qryMarketingContactClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object qryMarketingContactURL: TWideStringField
      FieldName = 'URL'
      Size = 255
    end
    object qryMarketingContactSkypeName: TWideStringField
      FieldName = 'SkypeName'
      Size = 100
    end
    object qryMarketingContactBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Size = 255
    end
    object qryMarketingContactBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Size = 255
    end
    object qryMarketingContactBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Size = 255
    end
    object qryMarketingContactBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Size = 255
    end
    object qryMarketingContactBillState: TWideStringField
      FieldName = 'BillState'
      Size = 255
    end
    object qryMarketingContactBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Size = 255
    end
    object qryMarketingContactBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Size = 255
    end
  end
  object qrySimpleTypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Id, TypeCode, Name, Active'
      'FROM tblsimpletypes')
    Left = 133
    Top = 109
    object StringField4: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
    object IntegerField2: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'Id'
      Origin = 'tblsimpletypes.Id'
      Visible = False
    end
    object StringField5: TWideStringField
      DisplayWidth = 30
      FieldName = 'TypeCode'
      Origin = 'tblsimpletypes.TypeCode'
      Visible = False
      Size = 30
    end
    object StringField6: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblsimpletypes.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object dsEmployeeLookup: TDataSource
    DataSet = qryEmployeeLookup
    Left = 570
    Top = 9
  end
  object dsmarketingcontact: TDataSource
    DataSet = qryMarketingContact
    Left = 324
    Top = 33
  end
  object qryMarketingContacts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT DISTINCT'
      'MC.company , MC.Id , MC.firstName , MC.LastName  , '
      
        'MC.street, MC.street2, MC.Street3 , MC.SUBURB, Mc.STATE , Mc.POS' +
        'TCODE,'
      'C.Customer,'
      'C.Supplier,'
      'C.OtherContact'
      ''
      'FROM'
      '`tblmarketingcontacts` AS `MC`'
      'Left join tblclients C on MC.clientId = c.clientID'
      
        '/*Left join  `tblmarketingleads`  as `MLF`   on MLF.marketingCon' +
        'tactId = mc.Id '
      'and MLF.islead="T"*/'
      
        'where /*((ifnull(MLF.LeadID,0) = 0) or (MC.Id = :MarketingContac' +
        'tId))'
      'and */(((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (MC.Company LIKE Concat(:SearchValue,"' +
        '%")))'
      
        'or ((:SearchMode = 2) and (MC.Company LIKE Concat("%",:SearchVal' +
        'ue,"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'order by MC.Company')
    BeforeOpen = qryMarketingContactsBeforeOpen
    Left = 419
    Top = 51
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryMarketingContactscompany: TWideStringField
      DisplayLabel = 'Company'
      DisplayWidth = 20
      FieldName = 'company'
      Origin = 'tblmarketingcontacts.company'
      Size = 255
    end
    object qryMarketingContactsSUBURB: TWideStringField
      DisplayLabel = 'Suburb'
      DisplayWidth = 15
      FieldName = 'SUBURB'
      Size = 255
    end
    object qryMarketingContactsSTATE: TWideStringField
      DisplayLabel = 'State'
      DisplayWidth = 5
      FieldName = 'STATE'
      Size = 255
    end
    object qryMarketingContactsPOSTCODE: TWideStringField
      DisplayLabel = 'Post Code'
      DisplayWidth = 5
      FieldName = 'POSTCODE'
      Size = 255
    end
    object qryMarketingContactsOtherContact: TWideStringField
      DisplayLabel = 'Other Contact?'
      DisplayWidth = 1
      FieldName = 'OtherContact'
      FixedChar = True
      Size = 1
    end
    object qryMarketingContactsCustomer: TWideStringField
      DisplayLabel = 'Customer?'
      DisplayWidth = 1
      FieldName = 'Customer'
      FixedChar = True
      Size = 1
    end
    object qryMarketingContactsSupplier: TWideStringField
      DisplayLabel = 'Supplier?'
      DisplayWidth = 1
      FieldName = 'Supplier'
      FixedChar = True
      Size = 1
    end
    object qryMarketingContactsId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'Id'
      Origin = 'tblmarketingcontacts.Id'
      Visible = False
    end
    object qryMarketingContactsfirstName: TWideStringField
      FieldName = 'firstName'
      Origin = 'tblmarketingcontacts.firstName'
      Visible = False
      Size = 255
    end
    object qryMarketingContactsLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'tblmarketingcontacts.LastName'
      Visible = False
      Size = 255
    end
    object qryMarketingContactsstreet: TWideStringField
      FieldName = 'street'
      Visible = False
      Size = 255
    end
    object qryMarketingContactsstreet2: TWideStringField
      FieldName = 'street2'
      Visible = False
      Size = 255
    end
    object qryMarketingContactsStreet3: TWideStringField
      FieldName = 'Street3'
      Visible = False
      Size = 255
    end
  end
  object qryActiontypes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT * FROM tblSimpleTypes WHERE Active <> '#39'F'#39' AND TypeCode = ' +
        #39'LeadActionType'#39' '
      
        '#AND NOT (name in ('#39'Appointment'#39', '#39'Invoice'#39', '#39'Quote'#39', '#39'SalesOrde' +
        'r'#39', '#39'Lead'#39'))')
    Left = 213
    Top = 109
    object StringField7: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Origin = 'tblsimpletypes.Name'
      Size = 255
    end
    object IntegerField3: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'Id'
      Origin = 'tblsimpletypes.Id'
      Visible = False
    end
    object StringField8: TWideStringField
      DisplayWidth = 30
      FieldName = 'TypeCode'
      Origin = 'tblsimpletypes.TypeCode'
      Visible = False
      Size = 30
    end
    object StringField9: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblsimpletypes.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object qryMediaType: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  '
      'tblSource.MedTypeID, tblSource.MediaType, tblSource.Active, '
      'tblSource.CreationDate '
      'FROM tblSource '
      
        'WHERE (((tblSource.MediaType)>" ") And ((tblSource.Active)<>'#39'F'#39')' +
        ') '
      'ORDER BY tblSource.MediaType; ')
    Options.LongStrings = False
    Left = 782
    Top = 144
  end
  object qryRep: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT EmployeeID, EmployeeName '
      'FROM tblemployees'
      'ORDER BY EmployeeName')
    Left = 714
    Top = 66
    object StringField10: TWideStringField
      DisplayWidth = 40
      FieldName = 'EmployeeName'
      Origin = 'tblemployees.EmployeeName'
      Size = 255
    end
    object IntegerField4: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblemployees.EmployeeID'
      Visible = False
    end
  end
  object qryClient: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '*'
      'FROM tblclients'
      'WHERE ClientID = :ID;')
    FilterOptions = [foCaseInsensitive]
    Options.LongStrings = False
    Left = 355
    Top = 3
    ParamData = <
      item
        DataType = ftString
        Name = 'ID'
        Value = ''
      end>
    object qryClientClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
    end
    object qryClientFaxNumber: TWideStringField
      FieldName = 'FaxNumber'
      Origin = 'tblclients.FaxNumber'
    end
    object qryClientPhone: TWideStringField
      FieldName = 'Phone'
      Origin = 'tblclients.Phone'
    end
    object qryClientAltPhone: TWideStringField
      FieldName = 'AltPhone'
      Origin = 'tblclients.AltPhone'
    end
    object qryClientMobile: TWideStringField
      FieldName = 'Mobile'
      Origin = 'tblclients.Mobile'
    end
    object qryClientMedTypeID: TIntegerField
      FieldName = 'MedTypeID'
      Origin = 'tblclients.MedTypeID'
    end
    object qryClientSource: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Source'
      LookupDataSet = qryMediaType
      LookupKeyFields = 'MedTypeID'
      LookupResultField = 'MediaType'
      KeyFields = 'MedTypeID'
      Size = 255
      Lookup = True
    end
    object qryClientNotes: TWideMemoField
      FieldName = 'Notes'
      Origin = 'tblclients.Notes'
      BlobType = ftWideMemo
    end
    object qryClientCompany: TWideStringField
      FieldName = 'Company'
      Size = 80
    end
    object qryClientStreet: TWideStringField
      FieldName = 'Street'
      Size = 255
    end
    object qryClientStreet2: TWideStringField
      FieldName = 'Street2'
      Size = 255
    end
    object qryClientSuburb: TWideStringField
      FieldName = 'Suburb'
      Size = 255
    end
    object qryClientState: TWideStringField
      FieldName = 'State'
      Size = 255
    end
    object qryClientCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
    object qryClientPostcode: TWideStringField
      FieldName = 'Postcode'
      Size = 255
    end
    object qryClientBillStreet: TWideStringField
      FieldName = 'BillStreet'
      Size = 255
    end
    object qryClientBillStreet2: TWideStringField
      FieldName = 'BillStreet2'
      Size = 255
    end
    object qryClientBillSuburb: TWideStringField
      FieldName = 'BillSuburb'
      Size = 255
    end
    object qryClientBillState: TWideStringField
      FieldName = 'BillState'
      Size = 255
    end
    object qryClientBillCountry: TWideStringField
      FieldName = 'BillCountry'
      Size = 255
    end
    object qryClientBillPostcode: TWideStringField
      FieldName = 'BillPostcode'
      Size = 255
    end
    object qryClientPOBox: TWideStringField
      FieldName = 'POBox'
      Size = 255
    end
    object qryClientPOSuburb: TWideStringField
      FieldName = 'POSuburb'
      Size = 255
    end
    object qryClientPOState: TWideStringField
      FieldName = 'POState'
      Size = 255
    end
    object qryClientPOCountry: TWideStringField
      FieldName = 'POCountry'
      Size = 255
    end
    object qryClientPOPostcode: TWideStringField
      FieldName = 'POPostcode'
      Size = 255
    end
    object qryClientGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryClientClientTypeID: TIntegerField
      FieldName = 'ClientTypeID'
    end
    object qryClientABN: TWideStringField
      FieldName = 'ABN'
      Size = 15
    end
    object qryClientTitle: TWideStringField
      FieldName = 'Title'
      Size = 32
    end
    object qryClientFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 40
    end
    object qryClientMiddleName: TWideStringField
      FieldName = 'MiddleName'
      Size = 40
    end
    object qryClientLastName: TWideStringField
      FieldName = 'LastName'
      Size = 40
    end
    object qryClientPosition: TWideStringField
      FieldName = 'Position'
      Size = 30
    end
    object qryClientEmail: TWideStringField
      FieldName = 'Email'
      Size = 80
    end
    object qryClientAltContact: TWideStringField
      FieldName = 'AltContact'
      Size = 50
    end
    object qryClientPhoneSupportTill: TDateField
      FieldName = 'PhoneSupportTill'
    end
    object qryClientContact1: TWideStringField
      FieldName = 'Contact1'
      Size = 50
    end
    object qryClientContact2: TWideStringField
      FieldName = 'Contact2'
      Size = 50
    end
    object qryClientContact1Phone: TWideStringField
      FieldName = 'Contact1Phone'
    end
    object qryClientContact2Phone: TWideStringField
      FieldName = 'Contact2Phone'
    end
    object qryClientCreationDate: TDateField
      FieldName = 'CreationDate'
    end
    object qryClientUpdateDate: TDateField
      FieldName = 'UpdateDate'
    end
    object qryClientDateInactive: TDateField
      FieldName = 'DateInactive'
    end
    object qryClientClientNo: TWideStringField
      FieldName = 'ClientNo'
      Size = 50
    end
    object qryClientTYPE: TWideStringField
      FieldName = 'TYPE'
      Size = 50
    end
    object qryClientTAXID: TIntegerField
      FieldName = 'TAXID'
    end
    object qryClientCreditLimit: TFloatField
      FieldName = 'CreditLimit'
    end
    object qryClientARBalance: TFloatField
      FieldName = 'ARBalance'
    end
    object qryClientAPBalance: TFloatField
      FieldName = 'APBalance'
    end
    object qryClientBalance: TFloatField
      FieldName = 'Balance'
    end
    object qryClientSOBalance: TFloatField
      FieldName = 'SOBalance'
    end
    object qryClientTERMS: TWideStringField
      FieldName = 'TERMS'
      Size = 30
    end
    object qryClientTermsID: TIntegerField
      FieldName = 'TermsID'
    end
    object qryClientShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      Size = 30
    end
    object qryClientShippingID: TIntegerField
      FieldName = 'ShippingID'
    end
    object qryClientDiscount: TFloatField
      FieldName = 'Discount'
    end
    object qryClientSpecialDiscount: TFloatField
      FieldName = 'SpecialDiscount'
    end
    object qryClientJobName: TWideStringField
      FieldName = 'JobName'
      Size = 39
    end
    object qryClientJobRegistration: TWideStringField
      FieldName = 'JobRegistration'
      Size = 50
    end
    object qryClientWarrantyFinishDate: TDateTimeField
      FieldName = 'WarrantyFinishDate'
    end
    object qryClientHoursTakenForJob: TFloatField
      FieldName = 'HoursTakenForJob'
    end
    object qryClientIsJob: TWideStringField
      FieldName = 'IsJob'
      FixedChar = True
      Size = 1
    end
    object qryClientCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Size = 255
    end
    object qryClientCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Size = 255
    end
    object qryClientCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Size = 255
    end
    object qryClientCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Size = 255
    end
    object qryClientCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object qryClientCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Size = 255
    end
    object qryClientCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Size = 255
    end
    object qryClientCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Size = 255
    end
    object qryClientCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Size = 255
    end
    object qryClientCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Size = 255
    end
    object qryClientCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Size = 255
    end
    object qryClientCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Size = 255
    end
    object qryClientCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Size = 255
    end
    object qryClientCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Size = 255
    end
    object qryClientCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Size = 255
    end
    object qryClientPayMethodID: TIntegerField
      FieldName = 'PayMethodID'
    end
    object qryClientFeedback: TWideStringField
      FieldName = 'Feedback'
      FixedChar = True
      Size = 1
    end
    object qryClientCustomer: TWideStringField
      FieldName = 'Customer'
      FixedChar = True
      Size = 1
    end
    object qryClientSupplier: TWideStringField
      FieldName = 'Supplier'
      FixedChar = True
      Size = 1
    end
    object qryClientOtherContact: TWideStringField
      FieldName = 'OtherContact'
      FixedChar = True
      Size = 1
    end
    object qryClientOtherContactType: TIntegerField
      FieldName = 'OtherContactType'
    end
    object qryClientRepID: TIntegerField
      FieldName = 'RepID'
    end
    object qryClientRepName: TWideStringField
      FieldName = 'RepName'
      Size = 255
    end
    object qryClientAction: TDateTimeField
      FieldName = 'Action'
    end
    object qryClientGlobal: TWideStringField
      FieldName = 'Global'
      FixedChar = True
      Size = 1
    end
    object qryClientDone: TWideStringField
      FieldName = 'Done'
      FixedChar = True
      Size = 1
    end
    object qryClientDateEntered: TDateField
      FieldName = 'DateEntered'
    end
    object qryClientActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryClientEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryClientCorrespondenceMethod: TWideStringField
      FieldName = 'CorrespondenceMethod'
      Size = 30
    end
    object qryClientDontContact: TWideStringField
      FieldName = 'DontContact'
      FixedChar = True
      Size = 1
    end
    object qryClientCompletionDate: TDateField
      FieldName = 'CompletionDate'
    end
    object qryClientParentClientID: TIntegerField
      FieldName = 'ParentClientID'
    end
    object qryClientShipTime: TWordField
      FieldName = 'ShipTime'
    end
    object qryClientGracePeriod: TWordField
      FieldName = 'GracePeriod'
    end
    object qryClientLastContactDate: TDateField
      FieldName = 'LastContactDate'
    end
    object qryClientLoyaltyValue: TFloatField
      FieldName = 'LoyaltyValue'
    end
    object qryClientLastSaleDate: TDateField
      FieldName = 'LastSaleDate'
    end
    object qryClientAccountNo: TWideStringField
      FieldName = 'AccountNo'
      Size = 50
    end
    object qryClientBankAccountName: TWideStringField
      FieldName = 'BankAccountName'
      Size = 255
    end
    object qryClientBankCode: TWideStringField
      FieldName = 'BankCode'
      FixedChar = True
      Size = 3
    end
    object qryClientBankAccountBSB: TWideStringField
      FieldName = 'BankAccountBSB'
      Size = 7
    end
    object qryClientBankAccountNo: TWideStringField
      FieldName = 'BankAccountNo'
      Size = 10
    end
    object qryClientURL: TWideStringField
      FieldName = 'URL'
      Size = 255
    end
    object qryClientCombinedInvoiceBOID: TWideStringField
      FieldName = 'CombinedInvoiceBOID'
      Size = 255
    end
    object qryClientCombinedSaleOrderBOID: TWideStringField
      FieldName = 'CombinedSaleOrderBOID'
      Size = 255
    end
    object qryClientStopCredit: TWideStringField
      FieldName = 'StopCredit'
      FixedChar = True
      Size = 1
    end
    object qryClientRequired: TWideStringField
      FieldName = 'Required'
      FixedChar = True
      Size = 1
    end
    object qryClientSecurityLevel: TIntegerField
      FieldName = 'SecurityLevel'
    end
    object qryClientForcePOOnBooking: TWideStringField
      FieldName = 'ForcePOOnBooking'
      FixedChar = True
      Size = 1
    end
    object qryClientForcePOOnInvoice: TWideStringField
      FieldName = 'ForcePOOnInvoice'
      FixedChar = True
      Size = 1
    end
    object qryClientForcePOOnCustomer: TWideStringField
      FieldName = 'ForcePOOnCustomer'
      FixedChar = True
      Size = 1
    end
    object qryClientPickingPriority: TIntegerField
      FieldName = 'PickingPriority'
    end
    object qryClientJobNumber: TIntegerField
      FieldName = 'JobNumber'
    end
    object qryClientDefaultInvoiceTemplateID: TIntegerField
      FieldName = 'DefaultInvoiceTemplateID'
    end
    object qryClientDefaultDeliveryTemplateID: TIntegerField
      FieldName = 'DefaultDeliveryTemplateID'
    end
    object qryClientLoyaltyDateSaleDays: TDateField
      FieldName = 'LoyaltyDateSaleDays'
    end
    object qryClientLoyaltyDateAmount: TDateField
      FieldName = 'LoyaltyDateAmount'
    end
    object qryClientLoyaltyDateAppointDays: TDateField
      FieldName = 'LoyaltyDateAppointDays'
    end
    object qryClientGroupDiscountOverridesAll: TWideStringField
      FieldName = 'GroupDiscountOverridesAll'
      FixedChar = True
      Size = 1
    end
    object qryClientForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
    object qryClientCardNumber: TWideStringField
      FieldName = 'CardNumber'
      Size = 255
    end
    object qryClientDefaultClass: TWideStringField
      FieldName = 'DefaultClass'
      Size = 255
    end
    object qryClientArea: TWideStringField
      FieldName = 'Area'
    end
    object qryClientDischargeDate: TDateField
      FieldName = 'DischargeDate'
    end
    object qryClientJobTitle: TWideStringField
      FieldName = 'JobTitle'
      Size = 255
    end
    object qryClientUseInvBase: TWideStringField
      FieldName = 'UseInvBase'
      FixedChar = True
      Size = 1
    end
    object qryClientInvBaseNumber: TIntegerField
      FieldName = 'InvBaseNumber'
    end
    object qryClientApprovalFromDate: TDateTimeField
      FieldName = 'ApprovalFromDate'
    end
    object qryClientApprovalToDate: TDateTimeField
      FieldName = 'ApprovalToDate'
    end
    object qryClientTasks: TWideMemoField
      FieldName = 'Tasks'
      BlobType = ftWideMemo
    end
    object qryClientReminderDateTime: TDateTimeField
      FieldName = 'ReminderDateTime'
    end
    object qryClientSpecialInstructions: TWideMemoField
      FieldName = 'SpecialInstructions'
      BlobType = ftWideMemo
    end
    object qryClientCUSTDATE1: TDateField
      FieldName = 'CUSTDATE1'
    end
    object qryClientCUSTDATE2: TDateField
      FieldName = 'CUSTDATE2'
    end
    object qryClientCUSTDATE3: TDateField
      FieldName = 'CUSTDATE3'
    end
    object qryClientSerialNumber: TWideStringField
      FieldName = 'SerialNumber'
      Size = 255
    end
    object qryClientModelNumber: TWideStringField
      FieldName = 'ModelNumber'
      Size = 255
    end
    object qryClientManufacture: TWideStringField
      FieldName = 'Manufacture'
      Size = 255
    end
    object qryClientParentRelatedClientID: TIntegerField
      FieldName = 'ParentRelatedClientID'
    end
    object qryClientDeliveryNotes: TWideMemoField
      FieldName = 'DeliveryNotes'
      BlobType = ftWideMemo
    end
    object qryClientDefaultContactMethod: TWideStringField
      FieldName = 'DefaultContactMethod'
      Size = 255
    end
    object qryClientCreditCardNumber: TWideStringField
      FieldName = 'CreditCardNumber'
      Size = 255
    end
    object qryClientCreditCardExpiryDate: TWideStringField
      FieldName = 'CreditCardExpiryDate'
      Size = 255
    end
    object qryClientCreditCardCardHolderName: TWideStringField
      FieldName = 'CreditCardCardHolderName'
      Size = 40
    end
    object qryClientCreditCardNotes: TWideStringField
      FieldName = 'CreditCardNotes'
      Size = 255
    end
    object qryClientCompanyTypeId: TIntegerField
      FieldName = 'CompanyTypeId'
    end
    object qryClientCreditCardType: TWideStringField
      FieldName = 'CreditCardType'
      Size = 255
    end
    object qryClientLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
    end
    object qryClientmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryClientWarrantyPeriod: TFloatField
      FieldName = 'WarrantyPeriod'
    end
    object qryClientCustomerJobNumber: TWideStringField
      FieldName = 'CustomerJobNumber'
    end
    object qryClienthours: TFloatField
      FieldName = 'hours'
    end
    object qryClientEmailXML: TWideStringField
      FieldName = 'EmailXML'
      Size = 80
    end
    object qryClientInvoiceComment: TWideMemoField
      FieldName = 'InvoiceComment'
      BlobType = ftWideMemo
    end
    object qryClientInvoiceCommentPopup: TWideStringField
      FieldName = 'InvoiceCommentPopup'
      FixedChar = True
      Size = 1
    end
    object qryClientSendXMLInvoices: TWideStringField
      FieldName = 'SendXMLInvoices'
      FixedChar = True
      Size = 1
    end
    object qryClientDefaultPurchaseOrderTemplateID: TIntegerField
      FieldName = 'DefaultPurchaseOrderTemplateID'
    end
    object qryClientStreet3: TWideStringField
      FieldName = 'Street3'
      Size = 255
    end
    object qryClientBillStreet3: TWideStringField
      FieldName = 'BillStreet3'
      Size = 255
    end
    object qryClientIncludeOnIntrastat: TWideStringField
      FieldName = 'IncludeOnIntrastat'
      FixedChar = True
      Size = 1
    end
    object qryClientSkypeName: TWideStringField
      FieldName = 'SkypeName'
      Size = 100
    end
  end
  object qryLeadStatus: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT id,Typecode,name FROM tblsimpletypes '
      'WHERE Typecode = '#39'LeadStatusType'#39' and Active = "T"'
      'ORDER BY Name')
    Left = 768
    Top = 56
    object qryLeadStatusname: TWideStringField
      DisplayWidth = 15
      FieldName = 'name'
      Size = 255
    end
    object qryLeadStatusid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object qryLeadStatusTypecode: TWideStringField
      FieldName = 'Typecode'
      Visible = False
      Size = 30
    end
  end
  object qryCorrespondence: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select tblReference.RefID,'
      'tblReference.Ref_Date as Date,'
      'tblReference.Ref_type as Type,'
      'tblReference.Referencetxt as Reference,'
      'tblReference.MarketingContactID as MarketingContactID,'
      'tblMarketingContacts.Company as MarketingContactName,'
      'tblReference.Active as Active,'
      'tblReference.MessageFrom as MessageFrom,'
      'tblReference.MessageTo as MessageTo,'
      'tblReference.MessageId as MessageId,'
      'tblReference.ReferenceData as MessageData'
      'from tblReference'
      
        'left join tblMarketingContacts on tblMarketingContacts.ID = tblR' +
        'eference.MarketingContactID '
      'where tblReference.MarketingContactID = :MarketingContactID'
      
        'and ((:ShowInactive = "T") or ((:ShowInactive = "F")  and (tblRe' +
        'ference.Active = "T")))'
      'order by tblReference.Ref_Date')
    Left = 304
    Top = 112
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'MarketingContactID'
      end
      item
        DataType = ftUnknown
        Name = 'ShowInactive'
      end
      item
        DataType = ftUnknown
        Name = 'ShowInactive'
      end>
    object qryCorrespondenceDate: TDateTimeField
      DisplayWidth = 19
      FieldName = 'Date'
      Origin = 'tblreference.Ref_Date'
    end
    object qryCorrespondenceType: TWideStringField
      DisplayWidth = 8
      FieldName = 'Type'
      Origin = 'tblreference.Ref_type'
      Size = 50
    end
    object qryCorrespondenceReference: TWideStringField
      DisplayWidth = 19
      FieldName = 'Reference'
      Origin = 'tblreference.Referencetxt'
      Size = 50
    end
    object qryCorrespondenceMarketingContactName: TWideStringField
      DisplayLabel = 'Marketing Contact'
      DisplayWidth = 15
      FieldName = 'MarketingContactName'
      Origin = 'tblMarketingContacts.COMPANY'
      Size = 255
    end
    object qryCorrespondenceMessageFrom: TWideStringField
      DisplayLabel = 'Message From'
      DisplayWidth = 20
      FieldName = 'MessageFrom'
      Origin = 'tblreference.MessageFrom'
      Size = 255
    end
    object qryCorrespondenceMessageTo: TWideStringField
      DisplayLabel = 'Message To'
      DisplayWidth = 20
      FieldName = 'MessageTo'
      Origin = 'tblreference.MessageTo'
      Size = 255
    end
    object qryCorrespondenceActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblreference.Active'
      FixedChar = True
      Size = 1
    end
    object qryCorrespondenceRefID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'RefID'
      Origin = 'tblreference.RefID'
      Visible = False
    end
    object qryCorrespondenceMarketingContactID: TIntegerField
      FieldName = 'MarketingContactID'
      Origin = 'tblreference.MarketingContactID'
      Visible = False
    end
    object qryCorrespondenceMessageId: TWideStringField
      FieldName = 'MessageId'
      Origin = 'tblreference.MessageId'
      Visible = False
      Size = 255
    end
    object qryCorrespondenceMessageData: TBlobField
      FieldName = 'MessageData'
      Origin = 'tblreference.ReferenceData'
      Visible = False
    end
  end
  object dsCorrespondence: TDataSource
    DataSet = qryCorrespondence
    Left = 304
    Top = 160
  end
  object qryDocPath: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select DPID, DocumentPath '
      'FROM tblDocPath;')
    Options.LongStrings = False
    Left = 352
    Top = 105
  end
  object QrysalesCustomerPONum: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT saleID, PONumber FROM tblsales limit 0')
    Left = 248
    Top = 8
    object QrysalesCustomerPONumsaleID: TIntegerField
      FieldName = 'saleID'
    end
    object QrysalesCustomerPONumPONumber: TWideStringField
      FieldName = 'PONumber'
      Size = 30
    end
  end
  object tmrNewLeadActionRecordCreated: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tmrNewLeadActionRecordCreatedTimer
    Left = 760
    Top = 16
  end
end
