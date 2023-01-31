inherited fmATOPayEvent: TfmATOPayEvent
  Left = 1109
  Top = 27
  Caption = 'ATO Pay Event'
  ClientHeight = 766
  ClientWidth = 744
  ExplicitLeft = 1109
  ExplicitTop = 27
  ExplicitWidth = 760
  ExplicitHeight = 805
  DesignSize = (
    744
    766)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 716
    Width = 744
    ExplicitTop = 381
    ExplicitWidth = 622
  end
  inherited shapehint: TShape
    Left = 3
    ExplicitLeft = 0
  end
  inherited imgGridWatermark: TImage
    Left = 409
    Top = -5
    ExplicitLeft = 409
    ExplicitTop = -5
  end
  inherited shapehintextra1: TShape
    Left = 38
    ExplicitLeft = 29
  end
  object pnlBottom: TDNMPanel [5]
    Left = 0
    Top = 716
    Width = 744
    Height = 50
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
      744
      50)
    object btnSubmit: TDNMSpeedButton
      Left = 100
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 760001
      Anchors = [akBottom]
      Caption = 'Submit'
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
      AutoDisableParentOnclick = True
      OnClick = btnSubmitClick
    end
    object GetStatus: TDNMSpeedButton
      Left = 404
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 760001
      Anchors = [akBottom]
      Caption = 'Check Status'
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
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = GetStatusClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 557
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 760003
      Anchors = [akBottom]
      Caption = '&Close'
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
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnSTPDetailList: TDNMSpeedButton
      Left = 252
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 760001
      Anchors = [akBottom]
      Caption = 'Detail Report'
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
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnSTPDetailListClick
    end
    object btnSTPSubmissionData: TDNMSpeedButton
      Left = 7
      Top = 0
      Width = 90
      Height = 47
      HelpContext = 760001
      Anchors = [akBottom]
      Caption = 'STP Submission Data'
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
      TabOrder = 4
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnSTPSubmissionDataClick
    end
    object btnValidateXML: TDNMSpeedButton
      Left = 650
      Top = 6
      Width = 87
      Height = 27
      HelpContext = 760001
      Anchors = [akBottom]
      Caption = 'Validate '
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
      TabOrder = 5
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnValidateXMLClick
    end
  end
  object pnlTop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 744
    Height = 257
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      744
      257)
    object Label1: TLabel
      Left = 16
      Top = 79
      Width = 89
      Height = 15
      AutoSize = False
      Caption = 'Pay Run Date'
    end
    object Label2: TLabel
      Left = 14
      Top = 108
      Width = 89
      Height = 15
      AutoSize = False
      Caption = 'Created By'
    end
    object Label3: TLabel
      Left = 16
      Top = 138
      Width = 46
      Height = 15
      AutoSize = False
      Caption = 'Notes'
    end
    object Label4: TLabel
      Left = 16
      Top = 236
      Width = 46
      Height = 15
      AutoSize = False
      Caption = 'Pays'
    end
    object Label5: TLabel
      Left = 280
      Top = 108
      Width = 73
      Height = 15
      AutoSize = False
      Caption = 'Status'
    end
    object pnlTitle: TDNMPanel
      Left = 180
      Top = 12
      Width = 384
      Height = 45
      HelpContext = 8010
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
        Width = 380
        Height = 41
        HelpContext = 8011
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
          Width = 380
          Height = 41
          HelpContext = 8012
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'ATO Pay Event'
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
    object edtPayRunDate: TDBEdit
      Left = 121
      Top = 76
      Width = 121
      Height = 23
      DataField = 'RunDate'
      DataSource = dsPayRun
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtEmployeeName: TDBEdit
      Left = 119
      Top = 105
      Width = 121
      Height = 23
      DataField = 'EmployeeName'
      DataSource = dsPayRun
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object chkSubmitted: TwwCheckBox
      Left = 280
      Top = 79
      Width = 113
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Submitted'
      DataField = 'Submitted'
      DataSource = dsPayRun
      TabOrder = 3
      ReadOnly = True
    end
    object chkInvalidated: TwwCheckBox
      Left = 444
      Top = 79
      Width = 113
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Invalidated'
      DataField = 'Invalidated'
      DataSource = dsPayRun
      TabOrder = 4
      ReadOnly = True
    end
    object chkYearFinal: TwwCheckBox
      Left = 608
      Top = 79
      Width = 113
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Year Final'
      DataField = 'FinancialYearFinalRun'
      DataSource = dsPayRun
      TabOrder = 5
      OnClick = chkYearFinalClick
    end
    object memNotes: TDBMemo
      Left = 119
      Top = 134
      Width = 602
      Height = 115
      DataField = 'Notes'
      DataSource = dsPayRun
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 6
    end
    object btnShowResponse: TDNMSpeedButton
      Left = 608
      Top = 12
      Width = 113
      Height = 27
      HelpContext = 760001
      Anchors = [akTop, akRight]
      Caption = 'Show Response'
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
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = btnShowResponseClick
    end
    object edtStatus: TDBEdit
      Left = 375
      Top = 105
      Width = 121
      Height = 23
      DataField = 'MessageStatus'
      DataSource = dsPayRun
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
    object wwCheckBox1: TwwCheckBox
      Left = 608
      Top = 102
      Width = 113
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Complete'
      DataField = 'Complete'
      DataSource = dsPayRun
      TabOrder = 9
      ReadOnly = True
    end
  end
  object pnlPays: TDNMPanel [7]
    Left = 0
    Top = 257
    Width = 744
    Height = 459
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      744
      459)
    object Label6: TLabel
      Left = 16
      Top = 277
      Width = 145
      Height = 15
      AutoSize = False
      Caption = 'Terminated Employees'
    end
    object grdPays: TwwDBGrid
      Left = 14
      Top = 0
      Width = 717
      Height = 270
      ControlType.Strings = (
        'Pay;CheckBox;T;F'
        'Paid;CheckBox;T;F'
        'Deleted;CheckBox;T;F')
      Selected.Strings = (
        'EmployeeName'#9'15'#9'Employee Name'#9#9
        'Pay Date'#9'10'#9'Pay Date'#9#9
        'PayPeriod'#9'10'#9'Pay Period'#9#9
        'Date Paid'#9'10'#9'Date Paid'#9#9
        'Pay Periods'#9'10'#9'Pay Periods'#9#9
        'Deleted'#9'1'#9'Deleted'#9#9
        'Wages'#9'10'#9'Wages'#9#9
        'Commission'#9'10'#9'Commission'#9#9
        'Deductions'#9'10'#9'Deductions'#9#9
        'Workplacegiving'#9'10'#9'Workplace Giving'#9#9
        'Allowances'#9'10'#9'Allowances'#9#9
        'CDEP'#9'10'#9'CDEP'#9#9
        'Sundries'#9'10'#9'Sundries'#9#9
        'Superannuation'#9'10'#9'Superannuation'#9#9
        'Gross'#9'10'#9'Gross'#9#9
        'Tax'#9'10'#9'Tax'#9#9
        'NetCombined'#9'10'#9'Net Combined'#9#9
        'NetOnly'#9'10'#9'Net Only'#9#9
        'Paid'#9'1'#9'Paid'#9#9
        'ClassName'#9'15'#9'Class Name'#9#9
        'PayNo'#9'10'#9'Pay No'#9#9
        'G/L'#9'3'#9'G/L'#9#9
        'Splits'#9'6'#9'Splits'#9#9
        'FirstName'#9'15'#9'First Name'#9#9
        'LastName'#9'15'#9'Last Name'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsPays
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnDblClick = grdPaysDblClick
    end
    object wwDBGrid1: TwwDBGrid
      Left = 14
      Top = 300
      Width = 717
      Height = 150
      ControlType.Strings = (
        'Pay;CheckBox;T;F'
        'Paid;CheckBox;T;F'
        'Deleted;CheckBox;T;F')
      Selected.Strings = (
        'EmployeeName'#9'15'#9'Employee Name'#9#9
        'Pay Date'#9'10'#9'Pay Date'#9#9
        'PayPeriod'#9'10'#9'Pay Period'#9#9
        'Date Paid'#9'10'#9'Date Paid'#9#9
        'Pay Periods'#9'10'#9'Pay Periods'#9#9
        'Deleted'#9'1'#9'Deleted'#9#9
        'Wages'#9'10'#9'Wages'#9#9
        'Commission'#9'10'#9'Commission'#9#9
        'Deductions'#9'10'#9'Deductions'#9#9
        'Workplacegiving'#9'10'#9'Workplace Giving'#9#9
        'Allowances'#9'10'#9'Allowances'#9#9
        'CDEP'#9'10'#9'CDEP'#9#9
        'Sundries'#9'10'#9'Sundries'#9#9
        'Superannuation'#9'10'#9'Superannuation'#9#9
        'Gross'#9'10'#9'Gross'#9#9
        'Tax'#9'10'#9'Tax'#9#9
        'NetCombined'#9'10'#9'Net Combined'#9#9
        'NetOnly'#9'10'#9'Net Only'#9#9
        'Paid'#9'1'#9'Paid'#9#9
        'ClassName'#9'15'#9'Class Name'#9#9
        'PayNo'#9'10'#9'Pay No'#9#9
        'G/L'#9'3'#9'G/L'#9#9
        'Splits'#9'6'#9'Splits'#9#9
        'FirstName'#9'15'#9'First Name'#9#9
        'LastName'#9'15'#9'Last Name'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsTerminated
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
      ParentFont = False
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnDblClick = grdPaysDblClick
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 444
    Top = 65528
  end
  inherited tmrdelay: TTimer
    Left = 480
    Top = 65528
  end
  inherited popSpelling: TPopupMenu
    Left = 128
    Top = 65528
  end
  inherited tmrdelayMsg: TTimer
    Left = 104
    Top = 65520
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 233
    Top = 65528
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 269
    Top = 65528
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited DataState: TDataState
    Left = 304
    Top = 65528
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 163
    Top = 65528
  end
  inherited imgsort: TImageList
    Left = 339
    Top = 65528
    Bitmap = {
      494C010102004801B40310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 58
    Top = 65528
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 374
    Top = 65528
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 198
    Top = 65528
  end
  inherited qryMemTrans: TERPQuery
    Left = 93
    Top = 65528
  end
  object qryPayRun: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblpayrun')
    Left = 480
    Top = 224
    object qryPayRunGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryPayRunID: TIntegerField
      FieldName = 'ID'
    end
    object qryPayRunEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryPayRunEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
    object qryPayRunRunDate: TDateTimeField
      FieldName = 'RunDate'
    end
    object qryPayRunSubmitted: TWideStringField
      FieldName = 'Submitted'
      FixedChar = True
      Size = 1
    end
    object qryPayRunSubmittedDate: TDateField
      FieldName = 'SubmittedDate'
    end
    object qryPayRunPaysProcessed: TIntegerField
      FieldName = 'PaysProcessed'
    end
    object qryPayRunInvalidated: TWideStringField
      FieldName = 'Invalidated'
      FixedChar = True
      Size = 1
    end
    object qryPayRunFinancialYearFinalRun: TWideStringField
      FieldName = 'FinancialYearFinalRun'
      FixedChar = True
      Size = 1
    end
    object qryPayRunNotes: TWideMemoField
      FieldName = 'Notes'
      BlobType = ftWideMemo
    end
    object qryPayRunmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryPayRunmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryPayRunMessageUuid: TWideStringField
      FieldName = 'MessageUuid'
      Size = 255
    end
    object qryPayRunMessageType: TWideStringField
      FieldName = 'MessageType'
      Size = 255
    end
    object qryPayRunMessageStatus: TWideStringField
      FieldName = 'MessageStatus'
      Size = 255
    end
    object qryPayRunComplete: TWideStringField
      FieldName = 'Complete'
      FixedChar = True
      Size = 1
    end
    object qryPayRunATOMessage: TWideMemoField
      FieldName = 'ATOMessage'
      BlobType = ftWideMemo
    end
    object qryPayRunATOResponse: TWideMemoField
      FieldName = 'ATOResponse'
      BlobType = ftWideMemo
    end
    object qryPayRunOriginalRef: TWideStringField
      FieldName = 'OriginalRef'
      Size = 255
    end
  end
  object dsPayRun: TDataSource
    DataSet = qryPayRun
    Left = 480
    Top = 280
  end
  object qryPays: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select tblPays.GlobalRef,tblPays.PayID, tblPays.EmployeeID AS Em' +
        'ployeeID, tblPays.EmpName, tblPays.EmployeeID AS '#39'Employee ID'#39', ' +
        'tblPays.PayPeriod,'
      
        'Concat(FirstName,'#39' '#39',LastName) AS '#39'EmployeeName'#39',PayDate AS '#39'Pay' +
        ' Date'#39','
      'DatePaid AS '#39'Date Paid'#39', PayPeriods AS '#39'Pay Periods'#39','
      'tblPays.Wages As Wages,'
      'tblPays.Commission AS Commission,'
      'tblPays.Deductions AS Deductions,'
      'tblPays.Workplacegiving AS Workplacegiving,'
      'tblPays.Allowances AS Allowances,'
      'tblPays.CDEPGross AS CDEP,'
      'tblPays.Sundries AS Sundries,'
      'tblPays.Superannuation AS Superannuation,'
      'tblPays.Gross AS Gross,'
      'tblPays.Tax AS Tax,'
      'tblPays.Net AS NetCombined,'
      'ROUND(Sum(-pt.Amount), 2) AS NetOnly,'
      'Pay, Paid, tblClass.ClassName,'
      'tblPays.Deleted,'
      'tblPays.PayID as PayNo,'
      '"G/L" AS "G/L",'
      '"Splits" AS "Splits",'
      'FirstName,LastName,'
      
        'tblemployees.Active AS Active, tblPays.IsTermination AS Terminat' +
        'ion,'
      
        'CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,CUSTFLD7,C' +
        'USTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD' +
        '14,CUSTFLD15'
      'FROM tblPays'
      
        'LEFT JOIN tblEmployees ON tblPays.EmployeeID=tblEmployees.Employ' +
        'eeID'
      'LEFT JOIN tblClass ON tblPays.ClassID = tblClass.ClassID'
      
        'Left JOIN tblPaysTransactions pt on pt.PayID = tblPays.PayID and' +
        ' pt.AccountId = 0'
      
        'WHERE (tblPays.PayRunID = :PayRunID OR (tblPays.PayRunID = :Orig' +
        'inalPayRunID AND :OriginalPayRunID>0))'
      'GROUP By tblPays.PayID'
      'ORDER BY tblPays.PayID')
    Left = 552
    Top = 336
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PayRunID'
      end
      item
        DataType = ftUnknown
        Name = 'OriginalPayRunID'
      end
      item
        DataType = ftUnknown
        Name = 'OriginalPayRunID'
      end>
    object qryPaysEmployeeName: TWideStringField
      DisplayLabel = 'Employee Name'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'EmployeeName'
      Size = 81
    end
    object qryPaysPayDate: TDateField
      DisplayWidth = 10
      FieldName = 'Pay Date'
      Origin = 'tblpays.PayDate'
    end
    object qryPaysPayPeriod: TWideStringField
      DisplayLabel = 'Pay Period'
      DisplayWidth = 10
      FieldName = 'PayPeriod'
      Origin = 'tblpays.PayPeriod'
      Size = 255
    end
    object qryPaysDatePaid: TDateTimeField
      DisplayWidth = 10
      FieldName = 'Date Paid'
      Origin = 'tblpays.DatePaid'
    end
    object qryPaysPayPeriods: TWordField
      DisplayWidth = 10
      FieldName = 'Pay Periods'
      Origin = 'tblpays.PayPeriods'
    end
    object qryPaysDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblpays.Deleted'
      FixedChar = True
      Size = 1
    end
    object qryPaysWages: TFloatField
      DisplayWidth = 10
      FieldName = 'Wages'
      Origin = 'tblpays.Wages'
      currency = True
    end
    object qryPaysCommission: TFloatField
      DisplayWidth = 10
      FieldName = 'Commission'
      Origin = 'tblpays.Commission'
      currency = True
    end
    object qryPaysDeductions: TFloatField
      DisplayWidth = 10
      FieldName = 'Deductions'
      Origin = 'tblpays.Deductions'
      currency = True
    end
    object qryPaysWorkplacegiving: TFloatField
      DisplayLabel = 'Workplace Giving'
      DisplayWidth = 10
      FieldName = 'Workplacegiving'
      Origin = 'tblpays.Workplacegiving'
      currency = True
    end
    object qryPaysAllowances: TFloatField
      DisplayWidth = 10
      FieldName = 'Allowances'
      Origin = 'tblpays.Allowances'
      currency = True
    end
    object qryPaysCDEP: TFloatField
      DisplayWidth = 10
      FieldName = 'CDEP'
      Origin = 'tblpays.CDEPGross'
      currency = True
    end
    object qryPaysSundries: TFloatField
      DisplayWidth = 10
      FieldName = 'Sundries'
      Origin = 'tblpays.Sundries'
      currency = True
    end
    object qryPaysSuperannuation: TFloatField
      DisplayWidth = 10
      FieldName = 'Superannuation'
      Origin = 'tblpays.Superannuation'
      currency = True
    end
    object qryPaysGross: TFloatField
      DisplayWidth = 10
      FieldName = 'Gross'
      Origin = 'tblpays.Gross'
      currency = True
    end
    object qryPaysTax: TFloatField
      DisplayWidth = 10
      FieldName = 'Tax'
      Origin = 'tblpays.Tax'
      currency = True
    end
    object qryPaysNetCombined: TFloatField
      DisplayLabel = 'Net Combined'
      DisplayWidth = 10
      FieldName = 'NetCombined'
      Origin = 'tblpays.Net'
      currency = True
    end
    object qryPaysNetOnly: TFloatField
      DisplayLabel = 'Net Only'
      DisplayWidth = 10
      FieldName = 'NetOnly'
      Origin = 'NetOnly'
      currency = True
    end
    object qryPaysPaid: TWideStringField
      DisplayWidth = 1
      FieldName = 'Paid'
      Origin = 'tblpays.Paid'
      FixedChar = True
      Size = 1
    end
    object qryPaysClassName: TWideStringField
      DisplayLabel = 'Class Name'
      DisplayWidth = 15
      FieldName = 'ClassName'
      Origin = 'tblClass.ClassName'
      Size = 60
    end
    object qryPaysPayNo: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Pay No'
      DisplayWidth = 10
      FieldName = 'PayNo'
      Origin = 'tblpays.PayID'
    end
    object qryPaysGL: TWideStringField
      DisplayWidth = 3
      FieldName = 'G/L'
      Origin = 'G/L'
      Size = 3
    end
    object qryPaysSplits: TWideStringField
      DisplayWidth = 6
      FieldName = 'Splits'
      Origin = 'Splits'
      Size = 6
    end
    object qryPaysFirstName: TWideStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 15
      FieldName = 'FirstName'
      Origin = 'tblEmployees.FirstName'
      Size = 40
    end
    object qryPaysLastName: TWideStringField
      DisplayLabel = 'Last Name'
      DisplayWidth = 15
      FieldName = 'LastName'
      Origin = 'tblEmployees.LastName'
      Size = 40
    end
    object qryPaysPay: TWideStringField
      DisplayWidth = 1
      FieldName = 'Pay'
      Origin = 'tblpays.Pay'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryPaysCUSTFLD1: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD1'
      Origin = 'tblEmployees.CUSTFLD1'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD2: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD2'
      Origin = 'tblEmployees.CUSTFLD2'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD3: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD3'
      Origin = 'tblEmployees.CUSTFLD3'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD4: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD4'
      Origin = 'tblEmployees.CUSTFLD4'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD5: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD5'
      Origin = 'tblEmployees.CUSTFLD5'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD6: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD6'
      Origin = 'tblEmployees.CUSTFLD6'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD7: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD7'
      Origin = 'tblEmployees.CUSTFLD7'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD8: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD8'
      Origin = 'tblEmployees.CUSTFLD8'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD9: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD9'
      Origin = 'tblEmployees.CUSTFLD9'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD10: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD10'
      Origin = 'tblEmployees.CUSTFLD10'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD11: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD11'
      Origin = 'tblEmployees.CUSTFLD11'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD12: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD12'
      Origin = 'tblEmployees.CUSTFLD12'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD13: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD13'
      Origin = 'tblEmployees.CUSTFLD13'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD14: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD14'
      Origin = 'tblEmployees.CUSTFLD14'
      Visible = False
      Size = 50
    end
    object qryPaysCUSTFLD15: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD15'
      Origin = 'tblEmployees.CUSTFLD15'
      Visible = False
      Size = 50
    end
    object qryPaysGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblpays.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPaysPayID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PayID'
      Origin = 'tblpays.PayID'
      Visible = False
    end
    object qryPaysEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'Employee ID'
      Origin = 'tblpays.EmployeeID'
      Visible = False
    end
    object qryPaysActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryPaysTermination: TWideStringField
      FieldName = 'Termination'
      FixedChar = True
      Size = 1
    end
    object qryPaysEmployeeID2: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryPaysEmpName: TWideStringField
      FieldName = 'EmpName'
      Size = 50
    end
  end
  object dsPays: TDataSource
    DataSet = qryPays
    Left = 608
    Top = 360
  end
  object qryPaysYearFinal: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select tblPays.GlobalRef,tblPays.PayID, tblPays.EmployeeID AS Em' +
        'ployeeID, tblPays.EmpName, tblPays.EmployeeID AS '#39'Employee ID'#39', ' +
        'tblPays.PayPeriod,'
      
        'Concat(FirstName,'#39' '#39',LastName) AS '#39'EmployeeName'#39',PayDate AS '#39'Pay' +
        ' Date'#39','
      'DatePaid AS '#39'Date Paid'#39', PayPeriods AS '#39'Pay Periods'#39','
      'tblPays.Wages As Wages,'
      'tblPays.Commission AS Commission,'
      'tblPays.Deductions AS Deductions,'
      'tblPays.Workplacegiving AS Workplacegiving,'
      'tblPays.Allowances AS Allowances,'
      'tblPays.CDEPGross AS CDEP,'
      'tblPays.Sundries AS Sundries,'
      'tblPays.Superannuation AS Superannuation,'
      'tblPays.Gross AS Gross,'
      'tblPays.Tax AS Tax,'
      'tblPays.Net AS NetCombined,'
      'ROUND(Sum(-pt.Amount), 2) AS NetOnly,'
      'Pay, Paid, tblClass.ClassName,'
      'tblPays.Deleted,'
      'tblPays.PayID as PayNo,'
      '"G/L" AS "G/L",'
      '"Splits" AS "Splits",'
      'FirstName,LastName,'
      
        'tblemployees.Active AS Active, tblPays.IsTermination AS Terminat' +
        'ion,'
      
        'CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,CUSTFLD7,C' +
        'USTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD' +
        '14,CUSTFLD15'
      'FROM tblPays'
      
        'LEFT JOIN tblEmployees ON tblPays.EmployeeID=tblEmployees.Employ' +
        'eeID'
      'LEFT JOIN tblClass ON tblPays.ClassID = tblClass.ClassID'
      
        'Left JOIN tblPaysTransactions pt on pt.PayID = tblPays.PayID and' +
        ' pt.AccountId = 0'
      
        'WHERE (tblPays.PayRunID = :PayRunID OR (tblPays.PayRunID = :Orig' +
        'inalPayRunID AND :OriginalPayRunID>0))'
      'OR tblpays.DatePaid BETWEEN :Start AND :End'
      'GROUP By tblPays.PayID'
      'ORDER BY tblPays.PayID')
    Left = 464
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PayRunID'
      end
      item
        DataType = ftUnknown
        Name = 'OriginalPayRunID'
      end
      item
        DataType = ftUnknown
        Name = 'OriginalPayRunID'
      end
      item
        DataType = ftUnknown
        Name = 'Start'
      end
      item
        DataType = ftUnknown
        Name = 'END'
      end>
    object WideStringField1: TWideStringField
      DisplayLabel = 'Employee Name'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'EmployeeName'
      Size = 81
    end
    object DateField1: TDateField
      DisplayWidth = 10
      FieldName = 'Pay Date'
      Origin = 'tblpays.PayDate'
    end
    object WideStringField2: TWideStringField
      DisplayLabel = 'Pay Period'
      DisplayWidth = 10
      FieldName = 'PayPeriod'
      Origin = 'tblpays.PayPeriod'
      Size = 255
    end
    object DateTimeField1: TDateTimeField
      DisplayWidth = 10
      FieldName = 'Date Paid'
      Origin = 'tblpays.DatePaid'
    end
    object WordField1: TWordField
      DisplayWidth = 10
      FieldName = 'Pay Periods'
      Origin = 'tblpays.PayPeriods'
    end
    object WideStringField3: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblpays.Deleted'
      FixedChar = True
      Size = 1
    end
    object FloatField1: TFloatField
      DisplayWidth = 10
      FieldName = 'Wages'
      Origin = 'tblpays.Wages'
      currency = True
    end
    object FloatField2: TFloatField
      DisplayWidth = 10
      FieldName = 'Commission'
      Origin = 'tblpays.Commission'
      currency = True
    end
    object FloatField3: TFloatField
      DisplayWidth = 10
      FieldName = 'Deductions'
      Origin = 'tblpays.Deductions'
      currency = True
    end
    object FloatField4: TFloatField
      DisplayLabel = 'Workplace Giving'
      DisplayWidth = 10
      FieldName = 'Workplacegiving'
      Origin = 'tblpays.Workplacegiving'
      currency = True
    end
    object FloatField5: TFloatField
      DisplayWidth = 10
      FieldName = 'Allowances'
      Origin = 'tblpays.Allowances'
      currency = True
    end
    object FloatField6: TFloatField
      DisplayWidth = 10
      FieldName = 'CDEP'
      Origin = 'tblpays.CDEPGross'
      currency = True
    end
    object FloatField7: TFloatField
      DisplayWidth = 10
      FieldName = 'Sundries'
      Origin = 'tblpays.Sundries'
      currency = True
    end
    object FloatField8: TFloatField
      DisplayWidth = 10
      FieldName = 'Superannuation'
      Origin = 'tblpays.Superannuation'
      currency = True
    end
    object FloatField9: TFloatField
      DisplayWidth = 10
      FieldName = 'Gross'
      Origin = 'tblpays.Gross'
      currency = True
    end
    object FloatField10: TFloatField
      DisplayWidth = 10
      FieldName = 'Tax'
      Origin = 'tblpays.Tax'
      currency = True
    end
    object FloatField11: TFloatField
      DisplayLabel = 'Net Combined'
      DisplayWidth = 10
      FieldName = 'NetCombined'
      Origin = 'tblpays.Net'
      currency = True
    end
    object FloatField12: TFloatField
      DisplayLabel = 'Net Only'
      DisplayWidth = 10
      FieldName = 'NetOnly'
      Origin = 'NetOnly'
      currency = True
    end
    object WideStringField4: TWideStringField
      DisplayWidth = 1
      FieldName = 'Paid'
      Origin = 'tblpays.Paid'
      FixedChar = True
      Size = 1
    end
    object WideStringField5: TWideStringField
      DisplayLabel = 'Class Name'
      DisplayWidth = 15
      FieldName = 'ClassName'
      Origin = 'tblClass.ClassName'
      Size = 60
    end
    object IntegerField1: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Pay No'
      DisplayWidth = 10
      FieldName = 'PayNo'
      Origin = 'tblpays.PayID'
    end
    object WideStringField6: TWideStringField
      DisplayWidth = 3
      FieldName = 'G/L'
      Origin = 'G/L'
      Size = 3
    end
    object WideStringField7: TWideStringField
      DisplayWidth = 6
      FieldName = 'Splits'
      Origin = 'Splits'
      Size = 6
    end
    object WideStringField8: TWideStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 15
      FieldName = 'FirstName'
      Origin = 'tblEmployees.FirstName'
      Size = 40
    end
    object WideStringField9: TWideStringField
      DisplayLabel = 'Last Name'
      DisplayWidth = 15
      FieldName = 'LastName'
      Origin = 'tblEmployees.LastName'
      Size = 40
    end
    object WideStringField10: TWideStringField
      DisplayWidth = 1
      FieldName = 'Pay'
      Origin = 'tblpays.Pay'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object WideStringField11: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD1'
      Origin = 'tblEmployees.CUSTFLD1'
      Visible = False
      Size = 50
    end
    object WideStringField12: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD2'
      Origin = 'tblEmployees.CUSTFLD2'
      Visible = False
      Size = 50
    end
    object WideStringField13: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD3'
      Origin = 'tblEmployees.CUSTFLD3'
      Visible = False
      Size = 50
    end
    object WideStringField14: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD4'
      Origin = 'tblEmployees.CUSTFLD4'
      Visible = False
      Size = 50
    end
    object WideStringField15: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD5'
      Origin = 'tblEmployees.CUSTFLD5'
      Visible = False
      Size = 50
    end
    object WideStringField16: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD6'
      Origin = 'tblEmployees.CUSTFLD6'
      Visible = False
      Size = 50
    end
    object WideStringField17: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD7'
      Origin = 'tblEmployees.CUSTFLD7'
      Visible = False
      Size = 50
    end
    object WideStringField18: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD8'
      Origin = 'tblEmployees.CUSTFLD8'
      Visible = False
      Size = 50
    end
    object WideStringField19: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD9'
      Origin = 'tblEmployees.CUSTFLD9'
      Visible = False
      Size = 50
    end
    object WideStringField20: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD10'
      Origin = 'tblEmployees.CUSTFLD10'
      Visible = False
      Size = 50
    end
    object WideStringField21: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD11'
      Origin = 'tblEmployees.CUSTFLD11'
      Visible = False
      Size = 50
    end
    object WideStringField22: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD12'
      Origin = 'tblEmployees.CUSTFLD12'
      Visible = False
      Size = 50
    end
    object WideStringField23: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD13'
      Origin = 'tblEmployees.CUSTFLD13'
      Visible = False
      Size = 50
    end
    object WideStringField24: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD14'
      Origin = 'tblEmployees.CUSTFLD14'
      Visible = False
      Size = 50
    end
    object WideStringField25: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD15'
      Origin = 'tblEmployees.CUSTFLD15'
      Visible = False
      Size = 50
    end
    object WideStringField26: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblpays.GlobalRef'
      Visible = False
      Size = 255
    end
    object IntegerField2: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PayID'
      Origin = 'tblpays.PayID'
      Visible = False
    end
    object IntegerField3: TIntegerField
      DisplayWidth = 10
      FieldName = 'Employee ID'
      Origin = 'tblpays.EmployeeID'
      Visible = False
    end
    object WideStringField27: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object WideStringField28: TWideStringField
      FieldName = 'Termination'
      FixedChar = True
      Size = 1
    end
    object IntegerField4: TIntegerField
      FieldName = 'EmployeeID'
    end
    object WideStringField29: TWideStringField
      FieldName = 'EmpName'
      Size = 50
    end
  end
  object qryTerminated: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select tblPays.GlobalRef,tblPays.PayID, tblPays.EmployeeID AS Em' +
        'ployeeID, tblPays.EmpName, tblPays.EmployeeID AS '#39'Employee ID'#39', ' +
        'tblPays.PayPeriod,'
      
        'Concat(FirstName,'#39' '#39',LastName) AS '#39'EmployeeName'#39',PayDate AS '#39'Pay' +
        ' Date'#39','
      'MAX(DatePaid) AS '#39'Date Paid'#39', PayPeriods AS '#39'Pay Periods'#39','
      'tblPays.Wages As Wages,'
      'tblPays.Commission AS Commission,'
      'tblPays.Deductions AS Deductions,'
      'tblPays.Workplacegiving AS Workplacegiving,'
      'tblPays.Allowances AS Allowances,'
      'tblPays.CDEPGross AS CDEP,'
      'tblPays.Sundries AS Sundries,'
      'tblPays.Superannuation AS Superannuation,'
      'tblPays.Gross AS Gross,'
      'tblPays.Tax AS Tax,'
      'tblPays.Net AS NetCombined,'
      'ROUND(Sum(-pt.Amount), 2) AS NetOnly,'
      'Pay, Paid, tblClass.ClassName,'
      'tblPays.Deleted,'
      'tblPays.PayID as PayNo,'
      '"G/L" AS "G/L",'
      '"Splits" AS "Splits",'
      'FirstName,LastName,'
      
        'tblemployees.Active AS Active, tblPays.IsTermination AS Terminat' +
        'ion,'
      
        'CUSTFLD1,CUSTFLD2,CUSTFLD3,CUSTFLD4,CUSTFLD5,CUSTFLD6,CUSTFLD7,C' +
        'USTFLD8,CUSTFLD9,CUSTFLD10,CUSTFLD11,CUSTFLD12,CUSTFLD13,CUSTFLD' +
        '14,CUSTFLD15'
      'FROM tblPays'
      
        'LEFT JOIN tblEmployees ON tblPays.EmployeeID=tblEmployees.Employ' +
        'eeID'
      'LEFT JOIN tblClass ON tblPays.ClassID = tblClass.ClassID'
      
        'Left JOIN tblPaysTransactions pt on pt.PayID = tblPays.PayID and' +
        ' pt.AccountId = 0'
      'WHERE  tblpays.DatePaid BETWEEN :Start AND :End'
      'AND tblemployees.IsTerminated = '#39'T'#39' AND tblpays.Deleted = '#39'F'#39
      'GROUP By EmpName'
      '#AND tblpays.DatePaid < :End - 7'
      '#GROUP By tblPays.PayID'
      'ORDER BY tblPays.PayID')
    Left = 344
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Start'
      end
      item
        DataType = ftUnknown
        Name = 'END'
      end>
    object WideStringField30: TWideStringField
      DisplayLabel = 'Employee Name'
      DisplayWidth = 15
      FieldName = 'EmployeeName'
      Origin = 'EmployeeName'
      Size = 81
    end
    object DateField2: TDateField
      DisplayWidth = 10
      FieldName = 'Pay Date'
      Origin = 'tblpays.PayDate'
    end
    object WideStringField31: TWideStringField
      DisplayLabel = 'Pay Period'
      DisplayWidth = 10
      FieldName = 'PayPeriod'
      Origin = 'tblpays.PayPeriod'
      Size = 255
    end
    object DateTimeField2: TDateTimeField
      DisplayWidth = 10
      FieldName = 'Date Paid'
      Origin = 'tblpays.DatePaid'
    end
    object WordField2: TWordField
      DisplayWidth = 10
      FieldName = 'Pay Periods'
      Origin = 'tblpays.PayPeriods'
    end
    object WideStringField32: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblpays.Deleted'
      FixedChar = True
      Size = 1
    end
    object FloatField13: TFloatField
      DisplayWidth = 10
      FieldName = 'Wages'
      Origin = 'tblpays.Wages'
      currency = True
    end
    object FloatField14: TFloatField
      DisplayWidth = 10
      FieldName = 'Commission'
      Origin = 'tblpays.Commission'
      currency = True
    end
    object FloatField15: TFloatField
      DisplayWidth = 10
      FieldName = 'Deductions'
      Origin = 'tblpays.Deductions'
      currency = True
    end
    object FloatField16: TFloatField
      DisplayLabel = 'Workplace Giving'
      DisplayWidth = 10
      FieldName = 'Workplacegiving'
      Origin = 'tblpays.Workplacegiving'
      currency = True
    end
    object FloatField17: TFloatField
      DisplayWidth = 10
      FieldName = 'Allowances'
      Origin = 'tblpays.Allowances'
      currency = True
    end
    object FloatField18: TFloatField
      DisplayWidth = 10
      FieldName = 'CDEP'
      Origin = 'tblpays.CDEPGross'
      currency = True
    end
    object FloatField19: TFloatField
      DisplayWidth = 10
      FieldName = 'Sundries'
      Origin = 'tblpays.Sundries'
      currency = True
    end
    object FloatField20: TFloatField
      DisplayWidth = 10
      FieldName = 'Superannuation'
      Origin = 'tblpays.Superannuation'
      currency = True
    end
    object FloatField21: TFloatField
      DisplayWidth = 10
      FieldName = 'Gross'
      Origin = 'tblpays.Gross'
      currency = True
    end
    object FloatField22: TFloatField
      DisplayWidth = 10
      FieldName = 'Tax'
      Origin = 'tblpays.Tax'
      currency = True
    end
    object FloatField23: TFloatField
      DisplayLabel = 'Net Combined'
      DisplayWidth = 10
      FieldName = 'NetCombined'
      Origin = 'tblpays.Net'
      currency = True
    end
    object FloatField24: TFloatField
      DisplayLabel = 'Net Only'
      DisplayWidth = 10
      FieldName = 'NetOnly'
      Origin = 'NetOnly'
      currency = True
    end
    object WideStringField33: TWideStringField
      DisplayWidth = 1
      FieldName = 'Paid'
      Origin = 'tblpays.Paid'
      FixedChar = True
      Size = 1
    end
    object WideStringField34: TWideStringField
      DisplayLabel = 'Class Name'
      DisplayWidth = 15
      FieldName = 'ClassName'
      Origin = 'tblClass.ClassName'
      Size = 60
    end
    object IntegerField5: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayLabel = 'Pay No'
      DisplayWidth = 10
      FieldName = 'PayNo'
      Origin = 'tblpays.PayID'
    end
    object WideStringField35: TWideStringField
      DisplayWidth = 3
      FieldName = 'G/L'
      Origin = 'G/L'
      Size = 3
    end
    object WideStringField36: TWideStringField
      DisplayWidth = 6
      FieldName = 'Splits'
      Origin = 'Splits'
      Size = 6
    end
    object WideStringField37: TWideStringField
      DisplayLabel = 'First Name'
      DisplayWidth = 15
      FieldName = 'FirstName'
      Origin = 'tblEmployees.FirstName'
      Size = 40
    end
    object WideStringField38: TWideStringField
      DisplayLabel = 'Last Name'
      DisplayWidth = 15
      FieldName = 'LastName'
      Origin = 'tblEmployees.LastName'
      Size = 40
    end
    object WideStringField39: TWideStringField
      DisplayWidth = 1
      FieldName = 'Pay'
      Origin = 'tblpays.Pay'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object WideStringField40: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD1'
      Origin = 'tblEmployees.CUSTFLD1'
      Visible = False
      Size = 50
    end
    object WideStringField41: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD2'
      Origin = 'tblEmployees.CUSTFLD2'
      Visible = False
      Size = 50
    end
    object WideStringField42: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD3'
      Origin = 'tblEmployees.CUSTFLD3'
      Visible = False
      Size = 50
    end
    object WideStringField43: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD4'
      Origin = 'tblEmployees.CUSTFLD4'
      Visible = False
      Size = 50
    end
    object WideStringField44: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD5'
      Origin = 'tblEmployees.CUSTFLD5'
      Visible = False
      Size = 50
    end
    object WideStringField45: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD6'
      Origin = 'tblEmployees.CUSTFLD6'
      Visible = False
      Size = 50
    end
    object WideStringField46: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD7'
      Origin = 'tblEmployees.CUSTFLD7'
      Visible = False
      Size = 50
    end
    object WideStringField47: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD8'
      Origin = 'tblEmployees.CUSTFLD8'
      Visible = False
      Size = 50
    end
    object WideStringField48: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD9'
      Origin = 'tblEmployees.CUSTFLD9'
      Visible = False
      Size = 50
    end
    object WideStringField49: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD10'
      Origin = 'tblEmployees.CUSTFLD10'
      Visible = False
      Size = 50
    end
    object WideStringField50: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD11'
      Origin = 'tblEmployees.CUSTFLD11'
      Visible = False
      Size = 50
    end
    object WideStringField51: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD12'
      Origin = 'tblEmployees.CUSTFLD12'
      Visible = False
      Size = 50
    end
    object WideStringField52: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD13'
      Origin = 'tblEmployees.CUSTFLD13'
      Visible = False
      Size = 50
    end
    object WideStringField53: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD14'
      Origin = 'tblEmployees.CUSTFLD14'
      Visible = False
      Size = 50
    end
    object WideStringField54: TWideStringField
      DisplayWidth = 10
      FieldName = 'CUSTFLD15'
      Origin = 'tblEmployees.CUSTFLD15'
      Visible = False
      Size = 50
    end
    object WideStringField55: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblpays.GlobalRef'
      Visible = False
      Size = 255
    end
    object IntegerField6: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'PayID'
      Origin = 'tblpays.PayID'
      Visible = False
    end
    object IntegerField7: TIntegerField
      DisplayWidth = 10
      FieldName = 'Employee ID'
      Origin = 'tblpays.EmployeeID'
      Visible = False
    end
    object WideStringField56: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object WideStringField57: TWideStringField
      FieldName = 'Termination'
      FixedChar = True
      Size = 1
    end
    object IntegerField8: TIntegerField
      FieldName = 'EmployeeID'
    end
    object WideStringField58: TWideStringField
      FieldName = 'EmpName'
      Size = 50
    end
  end
  object dsTerminated: TDataSource
    DataSet = qryTerminated
    Left = 336
    Top = 288
  end
end
