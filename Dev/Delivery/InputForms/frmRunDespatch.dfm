inherited frmRunDespatchGUI: TfrmRunDespatchGUI
  Left = 153
  Top = 135
  Caption = 'Run Dispatch'
  ClientHeight = 560
  ClientWidth = 992
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 992
    Height = 560
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    DesignSize = (
      992
      560)
    object Bevel1: TBevel
      Left = 7
      Top = 175
      Width = 980
      Height = 263
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object lblReschedule: TLabel
      Left = 0
      Top = 538
      Width = 992
      Height = 22
      Align = alBottom
      Alignment = taCenter
      Caption = 'This Run has been rescheduled for dd / mm / yyyy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      PopupMenu = PopupMenu1
      Transparent = True
      Visible = False
    end
    object Label1: TLabel
      Left = 8
      Top = 135
      Width = 397
      Height = 22
      Alignment = taCenter
      Caption = 'This run has been successfully completed.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      PopupMenu = PopupMenu1
      Transparent = True
      Visible = False
    end
    object Label13: TLabel
      Left = 13
      Top = 98
      Width = 100
      Height = 15
      Caption = 'Customer Search'
      Enabled = False
      Transparent = True
    end
    object DNMPanel2: TDNMPanel
      Left = 171
      Top = 446
      Width = 663
      Height = 25
      Anchors = [akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 4
      DesignSize = (
        663
        25)
      object Label10: TLabel
        Left = 43
        Top = 5
        Width = 94
        Height = 15
        Anchors = [akLeft, akBottom]
        Caption = 'Preview Reports'
        Enabled = False
        Transparent = True
      end
      object Label9: TLabel
        Left = 347
        Top = 5
        Width = 139
        Height = 15
        Anchors = [akRight, akBottom]
        Caption = 'Show Contact as Default'
        Transparent = True
      end
      object Label11: TLabel
        Left = 533
        Top = 5
        Width = 105
        Height = 15
        Anchors = [akRight, akBottom]
        Caption = 'Single Line Entries'
        Transparent = True
      end
      object Label12: TLabel
        Left = 193
        Top = 5
        Width = 75
        Height = 15
        Anchors = [akLeft, akBottom]
        Caption = 'Print Reports'
        Enabled = False
        Transparent = True
      end
      object chkPreviewInvoices: TCheckBox
        Left = 27
        Top = 4
        Width = 12
        Height = 17
        Hint = 
          'Toggle this option if you would like to preview reports and prin' +
          't them manually or just print.'
        Anchors = [akLeft, akBottom]
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object chkShowCompany: TwwCheckBox
        Left = 329
        Top = 4
        Width = 15
        Height = 16
        Hint = 
          'Toggle this option if you want to search by contact or company w' +
          'hen selecting contacts.'
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
        DataField = 'ShowCompanyAsDefaultOnRun'
        DataSource = dsPersonalPreferences
        ParentShowHint = False
        ShowHint = True
        ShowText = False
        TabOrder = 1
        OnClick = chkShowCompanyClick
      end
      object chkSingleLines: TCheckBox
        Left = 517
        Top = 5
        Width = 12
        Height = 17
        Hint = 
          'Toggle this entry to either include special and compulsory produ' +
          'cts when adding new clients'
        Anchors = [akLeft, akBottom]
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object chkPrintInvoices: TCheckBox
        Left = 177
        Top = 4
        Width = 12
        Height = 17
        Hint = 
          'Toggle this option if you would like to preview reports and prin' +
          't them manually or just print.'
        Anchors = [akLeft, akBottom]
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
    end
    object cmdOK: TDNMSpeedButton
      Left = 194
      Top = 506
      Width = 101
      Height = 27
      Action = actSave
      Anchors = [akBottom]
      Caption = 'Save'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      Kind = bkOK
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 10
    end
    object cmdCancel: TDNMSpeedButton
      Left = 714
      Top = 506
      Width = 101
      Height = 27
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
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 15
      OnClick = cmdCancelClick
    end
    object grdRunlines: TwwDBGrid
      Left = 12
      Top = 180
      Width = 969
      Height = 250
      ControlType.Strings = (
        'Exclude;CheckBox;T;F'
        'ExcludeFrom;CustomEdit;dtExcludeFrom;F'
        'ExcludeTo;CustomEdit;dtExcludeTo;F'
        'PaymentMethodName;CustomEdit;cboPayMethod;F'
        'Track;CheckBox;T;F'
        'ProductName;CustomEdit;cboParts;F'
        'Company;CustomEdit;cboCustomer;F')
      Selected.Strings = (
        'Company'#9'22'#9'Company'#9'F'#9
        'ClientName'#9'21'#9'Contact'#9'T'#9
        'Address'#9'20'#9'Address'#9'F'#9
        'Sequence'#9'5'#9'Seq #'#9'F'#9
        'HistoryQty3'#9'10'#9'History 3'#9'T'#9
        'HistoryQty2'#9'10'#9'History 2'#9'T'#9
        'HistoryQty1'#9'10'#9'History 1'#9'T'#9
        'ProductName'#9'20'#9'Product'#9'T'#9
        'Track'#9'1'#9'Track'#9'F'#9
        'OrderQty'#9'8'#9'Order Qty'#9'T'#9
        'OrderValue'#9'10'#9'Price (Inc)'#9'T'#9
        'TakenQty'#9'8'#9'Actual Qty'#9#9
        'TakenValue'#9'10'#9'Actual (Inc)'#9'T'#9
        'PaymentMethodName'#9'15'#9'Pay Code'#9'F'#9
        'Reference'#9'10'#9'Reference'#9'F'#9
        'Payments'#9'10'#9'Payments'#9#9
        'Deposits'#9'10'#9'Deposits'#9#9
        'ReturnQty'#9'9'#9'Returns'#9#9
        'TaxCode'#9'7'#9'Tax'#9'T'#9
        'TaxAmount'#9'10'#9'Tax Amount'#9'T'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnRowChanged = grdRunlinesRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsDespatchLines
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      OnCalcCellColors = grdRunlinesCalcCellColors
      OnCalcTitleAttributes = grdRunlinesCalcTitleAttributes
      OnTitleButtonClick = grdRunlinesTitleButtonClick
      OnEnter = grdRunlinesEnter
      FooterColor = clWhite
      FooterCellColor = clWhite
      object btnDelete: TwwIButton
        Left = 0
        Top = 0
        Width = 24
        Height = 22
        AllowAllUp = True
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        OnClick = btnDeleteClick
      end
    end
    object btnStandingOrders: TDNMSpeedButton
      Left = 874
      Top = 320
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Standing Orders'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 17
      Visible = False
      OnClick = btnStandingOrdersClick
    end
    object btnInvoice: TDNMSpeedButton
      Left = 450
      Top = 475
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Invoice'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 7
      OnClick = btnInvoiceClick
    end
    object btnProductionList: TDNMSpeedButton
      Left = 874
      Top = 347
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Production List'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 16
      Visible = False
      OnClick = btnProductionListClick
    end
    object btnCancelRun: TDNMSpeedButton
      Left = 554
      Top = 475
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Cancel Run'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 8
      OnClick = btnCancelRunClick
    end
    object btnEdit: TDNMSpeedButton
      Left = 874
      Top = 401
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Edit Run'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 19
      Visible = False
    end
    object btnDeliveryDocket: TDNMSpeedButton
      Left = 874
      Top = 293
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Delivery Dockets'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 18
      Visible = False
      OnClick = btnDeliveryDocketClick
    end
    object cboPayMethod: TwwDBLookupCombo
      Left = 252
      Top = 222
      Width = 81
      Height = 23
      ControlType.Strings = (
        'Address;RichEdit;;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'30'#9'Payment Method'#9'F')
      DataField = 'PaymentMethodName'
      DataSource = dsDespatchLines
      LookupTable = qryPayment
      LookupField = 'Name'
      Options = [loTitles]
      Style = csDropDownList
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnChange = cboPayMethodChange
      OnCloseUp = cboPayMethodCloseUp
      OnEnter = cboPayMethodOnEnter
    end
    object btnRunSummary: TDNMSpeedButton
      Left = 346
      Top = 475
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Run Summary'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 6
      OnClick = btnRunSummaryClick
    end
    object DNMPanel3: TDNMPanel
      Left = 0
      Top = 47
      Width = 992
      Height = 52
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 21
      object Label3: TLabel
        Left = 13
        Top = 12
        Width = 92
        Height = 15
        Caption = 'Scheduled Runs'
        Transparent = True
      end
      object Label5: TLabel
        Left = 245
        Top = 12
        Width = 51
        Height = 15
        Caption = 'Run Date'
        Transparent = True
      end
      object Label8: TLabel
        Left = 387
        Top = 12
        Width = 67
        Height = 15
        Caption = 'Department'
        Transparent = True
      end
      object Label6: TLabel
        Left = 659
        Top = 30
        Width = 77
        Height = 19
        Caption = 'Operator: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label7: TLabel
        Left = 571
        Top = 12
        Width = 64
        Height = 15
        Caption = 'Dispatch ID'
        Transparent = True
      end
      object cboRunName: TwwDBLookupCombo
        Left = 13
        Top = 28
        Width = 227
        Height = 23
        Hint = 'Select from this dropdown list a scheduled despatch run.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'RunName'#9'25'#9'Run Name'#9'F'
          'Operator'#9'25'#9'Operator'#9'F'
          'ClassName'#9'20'#9'Department'#9'F'
          'RunDate'#9'10'#9'Scheduled Run Date'#9'F')
        LookupTable = qryRuns
        LookupField = 'RunName'
        Options = [loTitles]
        Style = csDropDownList
        AutoSelect = False
        DropDownCount = 15
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboRunNameCloseUp
      end
      object dtRunDate: TwwDBDateTimePicker
        Left = 244
        Top = 28
        Width = 139
        Height = 23
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        DataField = 'RunDate'
        DataSource = dsRuns
        Epoch = 1950
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ShowButton = True
        TabOrder = 1
      end
      object edtClass: TwwDBEdit
        Left = 387
        Top = 28
        Width = 177
        Height = 23
        DataField = 'ClassName'
        DataSource = dsRuns
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
      end
      object wwDBEdit1: TwwDBEdit
        Left = 569
        Top = 28
        Width = 78
        Height = 23
        DataField = 'DespatchID'
        DataSource = dsRuns
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
      end
    end
    object btnReschedule: TDNMSpeedButton
      Left = 874
      Top = 374
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Reschedule'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 20
      Visible = False
      OnClick = btnRescheduleClick
    end
    object btnDriverReports: TDNMSpeedButton
      Left = 242
      Top = 475
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Driver Reports'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 5
      OnClick = btnDriverReportsClick
    end
    object cboCustomer: TwwDBLookupCombo
      Left = 52
      Top = 222
      Width = 193
      Height = 23
      ControlType.Strings = (
        'Address;RichEdit;;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'30'#9'Company'#9'F'
        'Customer'#9'30'#9'Contact'#9'F'
        'Address'#9'35'#9'Address'#9'F')
      DataField = 'Company'
      DataSource = dsDespatchLines
      LookupTable = qryCustomer
      LookupField = 'Company'
      Options = [loTitles]
      Style = csDropDownList
      DropDownCount = 12
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = cboCustomerCloseUp
      OnNotInList = cboCustomerNotInList
    end
    object cboParts: TwwDBLookupCombo
      Left = 340
      Top = 222
      Width = 145
      Height = 23
      ControlType.Strings = (
        'Address;RichEdit;;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'30'#9'Product'#9'F')
      DataField = 'ProductName'
      DataSource = dsDespatchLines
      LookupTable = qryParts
      LookupField = 'PARTNAME'
      Options = [loTitles]
      Style = csDropDownList
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      AllowClearKey = False
      OnCloseUp = cboPartsCloseUp
    end
    object btnReorder: TDNMSpeedButton
      Left = 298
      Top = 506
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Re&order'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 11
      OnClick = btnReorderClick
    end
    object btnRenumber: TDNMSpeedButton
      Left = 402
      Top = 506
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Re&number'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 12
      OnClick = btnRenumberClick
    end
    object btnResequence: TDNMSpeedButton
      Left = 506
      Top = 506
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = '&Resequence'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 13
      OnClick = btnResequenceClick
    end
    object txtSearch: TEdit
      Left = 12
      Top = 112
      Width = 209
      Height = 23
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 22
      OnChange = txtSearchChange
    end
    object btnExport: TDNMSpeedButton
      Left = 658
      Top = 475
      Width = 102
      Height = 27
      Anchors = [akBottom]
      Caption = 'Export'
      DisableTransparent = False
      Enabled = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 9
      OnClick = btnExportClick
    end
    object btnSetPayments: TDNMSpeedButton
      Left = 610
      Top = 506
      Width = 101
      Height = 27
      Anchors = [akBottom]
      Caption = 'Set Payments'
      DisableTransparent = False
      Enabled = False
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 14
      OnClick = btnSetPaymentsClick
    end
    object pnlTitle: TDNMPanel
      Left = 321
      Top = 6
      Width = 344
      Height = 45
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 23
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 340
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
          Width = 340
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Run Dispatch Details'
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
  object qryRuns: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tbldespatchruns'
      'WHERE Active = '#39'T'#39' AND Done = "F"'
      'ORDER BY RunName;')
    Left = 160
    Top = 5
    object qryRunsRunName: TStringField
      DisplayLabel = 'Run Name'
      DisplayWidth = 25
      FieldName = 'RunName'
      Size = 255
    end
    object qryRunsOperator: TStringField
      DisplayWidth = 25
      FieldName = 'Operator'
      Size = 255
    end
    object qryRunsClassName: TStringField
      DisplayLabel = 'Department'
      DisplayWidth = 20
      FieldName = 'ClassName'
      Size = 255
    end
    object qryRunsRunDate: TDateField
      DisplayLabel = 'Scheduled Run Date'
      DisplayWidth = 10
      FieldName = 'RunDate'
    end
    object qryRunsDespatchID: TAutoIncField
      FieldName = 'DespatchID'
      ReadOnly = True
      Visible = False
    end
    object qryRunsRunID: TAutoIncField
      FieldName = 'RunID'
      ReadOnly = True
      Visible = False
    end
    object qryRunsActive: TStringField
      FieldName = 'Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryRunsOperatorID: TIntegerField
      FieldName = 'OperatorID'
      Visible = False
    end
    object qryRunsDone: TStringField
      FieldName = 'Done'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryRunsGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryRunsClassID: TIntegerField
      FieldName = 'ClassID'
      Visible = False
    end
    object qryRunsIsPublicHoliday: TStringField
      FieldName = 'IsPublicHoliday'
      FixedChar = True
      Size = 1
    end
    object qryRunsInvoicesGenerated: TStringField
      FieldName = 'InvoicesGenerated'
      FixedChar = True
      Size = 1
    end
    object qryRunsRescheduled: TStringField
      FieldName = 'Rescheduled'
      FixedChar = True
      Size = 1
    end
    object qryRunsRescheduleDate: TDateField
      FieldName = 'RescheduleDate'
    end
  end
  object dsRuns: TDataSource
    DataSet = qryRuns
    Left = 160
    Top = 35
  end
  object qryRunLines: TMyQuery
    SQL.Strings = (
      'SELECT *'
      'FROM tbldespatchrunlines'
      'WHERE DespatchID = :xDespatchID'
      'ORDER BY Sequence, ClientName')
    Left = 192
    Top = 5
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xDespatchID'
      end>
    object qryRunLinesClientName: TStringField
      DisplayLabel = 'Contact'
      DisplayWidth = 21
      FieldName = 'ClientName'
      Size = 255
    end
    object qryRunLinesCompany: TStringField
      DisplayWidth = 22
      FieldName = 'Company'
      Size = 255
    end
    object qryRunLinesProductName: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Size = 255
    end
    object qryRunLinesOrderQty: TFloatField
      DisplayLabel = 'Order Qty'
      DisplayWidth = 8
      FieldName = 'OrderQty'
    end
    object qryRunLinesOrderValue: TFloatField
      DisplayLabel = 'Price (Inc)'
      DisplayWidth = 10
      FieldName = 'OrderValue'
      currency = True
    end
    object qryRunLinesTakenQty: TFloatField
      DisplayLabel = 'Actual Qty'
      DisplayWidth = 8
      FieldName = 'TakenQty'
    end
    object qryRunLinesTakenValue: TFloatField
      DisplayLabel = 'Actual (Inc)'
      DisplayWidth = 10
      FieldName = 'TakenValue'
      currency = True
    end
    object qryRunLinesReturnQty: TFloatField
      DisplayLabel = 'Returns'
      DisplayWidth = 9
      FieldName = 'ReturnQty'
    end
    object qryRunLinesPaymentMethodName: TStringField
      DisplayLabel = 'Pay Code'
      DisplayWidth = 15
      FieldName = 'PaymentMethodName'
      Size = 255
    end
    object qryRunLinesPayments: TFloatField
      DisplayWidth = 10
      FieldName = 'Payments'
    end
    object qryRunLinesDeposits: TFloatField
      DisplayWidth = 10
      FieldName = 'Deposits'
    end
    object qryRunLinesTaxCode: TStringField
      DisplayLabel = 'Tax'
      DisplayWidth = 7
      FieldName = 'TaxCode'
      Size = 255
    end
    object qryRunLinesTaxAmount: TFloatField
      DisplayLabel = 'Tax Amount'
      DisplayWidth = 10
      FieldName = 'TaxAmount'
      currency = True
    end
    object qryRunLinesID: TAutoIncField
      FieldName = 'ID'
      Visible = False
    end
    object qryRunLinesDespatchID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DespatchID'
      Visible = False
    end
    object qryRunLinesGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object qryRunLinesPreferedSupp: TStringField
      DisplayWidth = 255
      FieldName = 'PreferedSupp'
      Visible = False
      Size = 255
    end
    object qryRunLinesSequence: TIntegerField
      DisplayLabel = 'Seq'
      DisplayWidth = 5
      FieldName = 'Sequence'
      Visible = False
    end
    object qryRunLinesAddress: TStringField
      DisplayWidth = 37
      FieldName = 'Address'
      Visible = False
      Size = 255
    end
    object qryRunLinesPhone: TStringField
      DisplayWidth = 13
      FieldName = 'Phone'
      Visible = False
      Size = 255
    end
    object qryRunLinesMobile: TStringField
      DisplayWidth = 13
      FieldName = 'Mobile'
      Visible = False
      Size = 255
    end
    object qryRunLinesRunID: TIntegerField
      FieldName = 'RunID'
      Visible = False
    end
    object qryRunLinesClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object qryRunLinesProductID: TIntegerField
      FieldName = 'ProductID'
      Visible = False
    end
    object qryRunLinesPaymentMethodID: TIntegerField
      FieldName = 'PaymentMethodID'
      Visible = False
    end
    object qryRunLinesUnitExPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitExPrice'
      Visible = False
    end
    object qryRunLinesSalesID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SalesID'
      Visible = False
    end
    object qryRunLinesHistoryQty1: TFloatField
      FieldName = 'HistoryQty1'
    end
    object qryRunLinesHistoryQty2: TFloatField
      FieldName = 'HistoryQty2'
    end
    object qryRunLinesHistoryQty3: TFloatField
      FieldName = 'HistoryQty3'
    end
    object qryRunLinesFreqInterval: TIntegerField
      FieldName = 'FreqInterval'
    end
    object qryRunLinesFreqType: TStringField
      FieldName = 'FreqType'
      Size = 255
    end
    object qryRunLinesStartDate: TDateField
      FieldName = 'StartDate'
    end
    object qryRunLinesLastDelivery: TDateField
      FieldName = 'LastDelivery'
    end
    object qryRunLinesTrack: TStringField
      FieldName = 'Track'
      FixedChar = True
      Size = 1
    end
    object qryRunLinesOriginalExPrice: TFloatField
      FieldName = 'OriginalExPrice'
    end
    object qryRunLinesDiscount: TFloatField
      FieldName = 'Discount'
    end
    object qryRunLinesReference: TStringField
      FieldName = 'Reference'
      Size = 255
    end
    object qryRunLinesIsContact: TStringField
      FieldName = 'IsContact'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryRunLinesContactID: TIntegerField
      FieldName = 'ContactID'
      Visible = False
    end
    object qryRunLinesDeliveryDocket: TStringField
      FieldName = 'DeliveryDocket'
      Visible = False
      Size = 255
    end
    object qryRunLinesPrepaymentID: TIntegerField
      FieldName = 'PrepaymentID'
    end
  end
  object dsRunLines: TDataSource
    DataSet = qryRunLines
    Left = 190
    Top = 35
  end
  object ActionManager1: TActionManager
    Left = 223
    Top = 5
    object actSave: TAction
      Caption = 'Save'
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
    end
  end
  object memDespatchLines: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Company'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'ClientName'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Address'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Sequence'
        DataType = ftInteger
      end
      item
        Name = 'HistoryQty3'
        DataType = ftFloat
      end
      item
        Name = 'HistoryQty2'
        DataType = ftFloat
      end
      item
        Name = 'HistoryQty1'
        DataType = ftFloat
      end
      item
        Name = 'ProductName'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Track'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'OrderQty'
        DataType = ftFloat
      end
      item
        Name = 'OrderValue'
        DataType = ftFloat
      end
      item
        Name = 'TakenQty'
        DataType = ftFloat
      end
      item
        Name = 'TakenValue'
        DataType = ftFloat
      end
      item
        Name = 'PaymentMethodName'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Reference'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Payments'
        DataType = ftFloat
      end
      item
        Name = 'Deposits'
        DataType = ftFloat
      end
      item
        Name = 'ReturnQty'
        DataType = ftFloat
      end
      item
        Name = 'TaxCode'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'TaxAmount'
        DataType = ftFloat
      end
      item
        Name = 'ContactID'
        DataType = ftInteger
      end
      item
        Name = 'IsContact'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ID'
        DataType = ftAutoInc
      end
      item
        Name = 'DespatchID'
        DataType = ftInteger
      end
      item
        Name = 'GlobalRef'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'PreferedSupp'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Phone'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'Mobile'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'RunID'
        DataType = ftInteger
      end
      item
        Name = 'ClientID'
        DataType = ftInteger
      end
      item
        Name = 'ProductID'
        DataType = ftInteger
      end
      item
        Name = 'PaymentMethodID'
        DataType = ftInteger
      end
      item
        Name = 'UnitExPrice'
        DataType = ftFloat
      end
      item
        Name = 'SalesID'
        DataType = ftInteger
      end
      item
        Name = 'StartDate'
        DataType = ftDate
      end
      item
        Name = 'FreqType'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'FreqInterval'
        DataType = ftInteger
      end
      item
        Name = 'LastDelivery'
        DataType = ftDate
      end
      item
        Name = 'Discount'
        DataType = ftFloat
      end
      item
        Name = 'DeliveryDocket'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'OriginalExPrice'
        DataType = ftFloat
      end
      item
        Name = 'PrepaymentID'
        DataType = ftInteger
      end>
    AutoAddIndexes = True
    IndexFieldNames = 'ID'
    IndexDefs = <>
    RecalcOnFetch = False
    SortOptions = []
    Standalone = True
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    AfterPost = memDespatchLinesAfterPost
    Left = 254
    Top = 5
    object memDespatchLinesCompany: TStringField
      DisplayWidth = 22
      FieldName = 'Company'
      Size = 255
    end
    object memDespatchLinesClientName: TStringField
      DisplayLabel = 'Contact'
      DisplayWidth = 21
      FieldName = 'ClientName'
      Size = 255
    end
    object memDespatchLinesAddress: TStringField
      DisplayWidth = 20
      FieldName = 'Address'
      Size = 255
    end
    object memDespatchLinesSequence: TIntegerField
      DisplayLabel = 'Seq #'
      DisplayWidth = 5
      FieldName = 'Sequence'
      OnChange = memDespatchLinesSequenceChange
    end
    object memDespatchLinesHistoryQty3: TFloatField
      DisplayLabel = 'History 3'
      DisplayWidth = 10
      FieldName = 'HistoryQty3'
    end
    object memDespatchLinesHistoryQty2: TFloatField
      DisplayLabel = 'History 2'
      DisplayWidth = 10
      FieldName = 'HistoryQty2'
    end
    object memDespatchLinesHistoryQty1: TFloatField
      DisplayLabel = 'History 1'
      DisplayWidth = 10
      FieldName = 'HistoryQty1'
    end
    object memDespatchLinesProductName: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Size = 255
    end
    object memDespatchLinesTrack: TStringField
      DisplayWidth = 1
      FieldName = 'Track'
      FixedChar = True
      Size = 1
    end
    object memDespatchLinesOrderQty: TFloatField
      DisplayLabel = 'Order Qty'
      DisplayWidth = 8
      FieldName = 'OrderQty'
      OnChange = memDespatchLinesOrderQtyChange
    end
    object memDespatchLinesOrderValue: TFloatField
      DisplayLabel = 'Price (Inc)'
      DisplayWidth = 10
      FieldName = 'OrderValue'
      currency = True
    end
    object memDespatchLinesTakenQty: TFloatField
      DisplayLabel = 'Actual Qty'
      DisplayWidth = 8
      FieldName = 'TakenQty'
      OnChange = memDespatchLinesTakenQtyChange
    end
    object memDespatchLinesTakenValue: TFloatField
      DisplayLabel = 'Actual (Inc)'
      DisplayWidth = 10
      FieldName = 'TakenValue'
      currency = True
    end
    object memDespatchLinesPaymentMethodName: TStringField
      DisplayLabel = 'Pay Code'
      DisplayWidth = 15
      FieldName = 'PaymentMethodName'
      Size = 255
    end
    object memDespatchLinesReference: TStringField
      DisplayWidth = 10
      FieldName = 'Reference'
      OnChange = memDespatchLinesReferenceChange
      Size = 255
    end
    object memDespatchLinesPayments: TFloatField
      DisplayWidth = 10
      FieldName = 'Payments'
      OnChange = memDespatchLinesPaymentsChange
      currency = True
    end
    object memDespatchLinesDeposits: TFloatField
      DisplayWidth = 10
      FieldName = 'Deposits'
      OnChange = memDespatchLinesDepositsChange
      currency = True
    end
    object memDespatchLinesReturnQty: TFloatField
      DisplayLabel = 'Returns'
      DisplayWidth = 9
      FieldName = 'ReturnQty'
      OnChange = memDespatchLinesReturnQtyChange
    end
    object memDespatchLinesTaxCode: TStringField
      DisplayLabel = 'Tax'
      DisplayWidth = 7
      FieldName = 'TaxCode'
      Size = 255
    end
    object memDespatchLinesTaxAmount: TFloatField
      DisplayLabel = 'Tax Amount'
      DisplayWidth = 10
      FieldName = 'TaxAmount'
      currency = True
    end
    object memDespatchLinesContactID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ContactID'
      Visible = False
    end
    object memDespatchLinesIsContact: TStringField
      DisplayWidth = 1
      FieldName = 'IsContact'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object memDespatchLinesID: TAutoIncField
      FieldName = 'ID'
      Visible = False
    end
    object memDespatchLinesDespatchID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DespatchID'
      Visible = False
    end
    object memDespatchLinesGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object memDespatchLinesPreferedSupp: TStringField
      DisplayWidth = 255
      FieldName = 'PreferedSupp'
      Visible = False
      Size = 255
    end
    object memDespatchLinesPhone: TStringField
      DisplayWidth = 13
      FieldName = 'Phone'
      Visible = False
      Size = 255
    end
    object memDespatchLinesMobile: TStringField
      DisplayWidth = 13
      FieldName = 'Mobile'
      Visible = False
      Size = 255
    end
    object memDespatchLinesRunID: TIntegerField
      FieldName = 'RunID'
      Visible = False
    end
    object memDespatchLinesClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
    object memDespatchLinesProductID: TIntegerField
      FieldName = 'ProductID'
      Visible = False
    end
    object memDespatchLinesPaymentMethodID: TIntegerField
      FieldName = 'PaymentMethodID'
      Visible = False
      OnChange = memDespatchLinesPaymentMethodIDChange
    end
    object memDespatchLinesUnitExPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitExPrice'
      Visible = False
    end
    object memDespatchLinesSalesID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SalesID'
      Visible = False
    end
    object memDespatchLinesStartDate: TDateField
      DisplayWidth = 10
      FieldName = 'StartDate'
      Visible = False
    end
    object memDespatchLinesFreqType: TStringField
      DisplayWidth = 255
      FieldName = 'FreqType'
      Visible = False
      Size = 255
    end
    object memDespatchLinesFreqInterval: TIntegerField
      DisplayWidth = 10
      FieldName = 'FreqInterval'
      Visible = False
    end
    object memDespatchLinesLastDelivery: TDateField
      DisplayWidth = 10
      FieldName = 'LastDelivery'
      Visible = False
    end
    object memDespatchLinesDiscount: TFloatField
      DisplayWidth = 10
      FieldName = 'Discount'
      Visible = False
    end
    object memDespatchLinesDeliveryDocket: TStringField
      DisplayWidth = 255
      FieldName = 'DeliveryDocket'
      Visible = False
      Size = 255
    end
    object memDespatchLinesOriginalExPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'OriginalExPrice'
      Visible = False
    end
    object memDespatchLinesPrepaymentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PrepaymentID'
      Visible = False
    end
  end
  object dsDespatchLines: TDataSource
    DataSet = memDespatchLines
    Left = 254
    Top = 35
  end
  object qryPayment: TMyQuery
    SQL.Strings = (
      'SELECT PayMethodID, Name '
      'FROM tblPaymentMethods'
      'ORDER BY Name')
    Options.LongStrings = False
    Left = 696
    Top = 8
  end
  object tmrTrigger: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrTriggerTimer
    Left = 666
    Top = 8
  end
  object memCopy: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.50'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 286
    Top = 5
    object IntegerField4: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientID'
    end
    object memCopyContactID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ContactID'
    end
    object StringField2: TStringField
      DisplayWidth = 20
      FieldName = 'Company'
      Size = 255
    end
    object StringField1: TStringField
      DisplayLabel = 'Contact'
      DisplayWidth = 20
      FieldName = 'ClientName'
      Size = 255
    end
    object StringField3: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Size = 255
    end
    object StringField8: TStringField
      DisplayWidth = 37
      FieldName = 'Address'
      Visible = False
      Size = 255
    end
    object IntegerField2: TIntegerField
      DisplayLabel = 'Seq'
      DisplayWidth = 5
      FieldName = 'Sequence'
      Visible = False
    end
    object memCopyHistoryQty3: TFloatField
      DisplayWidth = 10
      FieldName = 'HistoryQty3'
      Visible = False
    end
    object memCopyHistoryQty2: TFloatField
      DisplayWidth = 10
      FieldName = 'HistoryQty2'
      Visible = False
    end
    object memCopyHistoryQty1: TFloatField
      DisplayWidth = 10
      FieldName = 'HistoryQty1'
      Visible = False
    end
    object memCopyTrack: TStringField
      DisplayWidth = 1
      FieldName = 'Track'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object FloatField1: TFloatField
      DisplayLabel = 'Order Qty'
      DisplayWidth = 8
      FieldName = 'OrderQty'
      Visible = False
    end
    object FloatField2: TFloatField
      DisplayLabel = 'Price (Inc)'
      DisplayWidth = 10
      FieldName = 'OrderValue'
      Visible = False
      currency = True
    end
    object FloatField3: TFloatField
      DisplayLabel = 'Actual Qty'
      DisplayWidth = 8
      FieldName = 'TakenQty'
      Visible = False
    end
    object FloatField4: TFloatField
      DisplayLabel = 'Actual (Inc)'
      DisplayWidth = 10
      FieldName = 'TakenValue'
      Visible = False
      currency = True
    end
    object FloatField5: TFloatField
      DisplayLabel = 'Returns'
      DisplayWidth = 9
      FieldName = 'ReturnQty'
      Visible = False
    end
    object StringField4: TStringField
      DisplayLabel = 'Pay Code'
      DisplayWidth = 15
      FieldName = 'PaymentMethodName'
      Visible = False
      Size = 255
    end
    object memCopyReference: TStringField
      DisplayWidth = 255
      FieldName = 'Reference'
      Visible = False
      Size = 255
    end
    object FloatField6: TFloatField
      DisplayWidth = 10
      FieldName = 'Payments'
      Visible = False
    end
    object FloatField7: TFloatField
      DisplayWidth = 10
      FieldName = 'Deposits'
      Visible = False
    end
    object StringField5: TStringField
      DisplayLabel = 'Tax'
      DisplayWidth = 7
      FieldName = 'TaxCode'
      Visible = False
      Size = 255
    end
    object FloatField8: TFloatField
      DisplayLabel = 'Tax Amount'
      DisplayWidth = 10
      FieldName = 'TaxAmount'
      Visible = False
      currency = True
    end
    object AutoIncField1: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object IntegerField1: TIntegerField
      DisplayWidth = 10
      FieldName = 'DespatchID'
      Visible = False
    end
    object StringField6: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
    object StringField7: TStringField
      DisplayWidth = 255
      FieldName = 'PreferedSupp'
      Visible = False
      Size = 255
    end
    object StringField9: TStringField
      DisplayWidth = 13
      FieldName = 'Phone'
      Visible = False
      Size = 255
    end
    object StringField10: TStringField
      DisplayWidth = 13
      FieldName = 'Mobile'
      Visible = False
      Size = 255
    end
    object IntegerField3: TIntegerField
      FieldName = 'RunID'
      Visible = False
    end
    object IntegerField5: TIntegerField
      FieldName = 'ProductID'
      Visible = False
    end
    object IntegerField6: TIntegerField
      FieldName = 'PaymentMethodID'
      Visible = False
      OnChange = memDespatchLinesPaymentMethodIDChange
    end
    object FloatField9: TFloatField
      DisplayWidth = 10
      FieldName = 'UnitExPrice'
      Visible = False
    end
    object IntegerField7: TIntegerField
      DisplayWidth = 10
      FieldName = 'SalesID'
      Visible = False
    end
    object memCopyStartDate: TDateField
      DisplayWidth = 10
      FieldName = 'StartDate'
      Visible = False
    end
    object memCopyFreqInterval: TIntegerField
      DisplayWidth = 10
      FieldName = 'FreqInterval'
      Visible = False
    end
    object memCopyFreqType: TStringField
      DisplayWidth = 255
      FieldName = 'FreqType'
      Visible = False
      Size = 255
    end
    object memCopyLastDelivery: TDateField
      DisplayWidth = 10
      FieldName = 'LastDelivery'
      Visible = False
    end
    object memCopyOriginalExPrice: TFloatField
      DisplayWidth = 10
      FieldName = 'OriginalExPrice'
      Visible = False
    end
    object memCopyDiscount: TFloatField
      DisplayWidth = 10
      FieldName = 'Discount'
      Visible = False
    end
    object memCopyIsContact: TStringField
      DisplayWidth = 1
      FieldName = 'IsContact'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object memCopyDeliveryDocket: TStringField
      DisplayWidth = 255
      FieldName = 'DeliveryDocket'
      Visible = False
      Size = 255
    end
    object memCopyPrepaymentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PrepaymentID'
      Visible = False
    end
  end
  object qryHistory: TMyQuery
    SQL.Strings = (
      'SELECT '
      'DRL.ID, DRL.TakenQty'
      'FROM tbldespatchruns AS DR'
      
        'INNER JOIN tbldespatchrunlines AS DRL on DR.DespatchID = DRL.Des' +
        'patchID'
      'WHERE (DRL.ClientID = :xCID AND DRL.RunID = :xRID AND '
      '               DRL.ProductID = :xPID AND '
      '              (DR.RunDate >= :xDate1 AND DR.RunDate < :xDate))'
      ''
      'ORDER BY DRL.ID DESC'
      'LIMIT 3;')
    Options.LongStrings = False
    Left = 728
    Top = 8
    ParamData = <
      item
        DataType = ftString
        Name = 'xCID'
        Value = ''
      end
      item
        DataType = ftUnknown
        Name = 'xRID'
      end
      item
        DataType = ftUnknown
        Name = 'xPID'
      end
      item
        DataType = ftUnknown
        Name = 'xDate1'
      end
      item
        DataType = ftUnknown
        Name = 'xDate'
      end>
  end
  object PopupMenu1: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.1.1'
    Left = 755
    Top = 40
    object CustomiseFields1: TMenuItem
      Caption = 'Select Columns'
      Enabled = False
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object CancelRun1: TMenuItem
      Caption = 'Cancel Run'
      Enabled = False
      OnClick = btnCancelRunClick
    end
    object EditRun1: TMenuItem
      Caption = 'Edit Run'
      Enabled = False
    end
    object Export1: TMenuItem
      Caption = 'Export'
      Enabled = False
    end
    object Invoice1: TMenuItem
      Caption = 'Invoice'
      Enabled = False
      OnClick = btnInvoiceClick
    end
    object SetPayments1: TMenuItem
      Caption = 'Set Payments'
      Enabled = False
      OnClick = SetPayments1Click
    end
    object Save1: TMenuItem
      Caption = 'Save'
      Enabled = False
      OnClick = Save1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object DeliveryDockets1: TMenuItem
      Caption = 'Delivery Dockets'
      Enabled = False
      OnClick = btnDeliveryDocketClick
    end
    object DriverReports1: TMenuItem
      Caption = 'Driver Reports'
      Enabled = False
      OnClick = btnDriverReportsClick
    end
    object ProductionList1: TMenuItem
      Caption = 'Production List'
      Enabled = False
      OnClick = btnProductionListClick
    end
    object RunSummary1: TMenuItem
      Caption = 'Run Summary'
      Enabled = False
      OnClick = btnRunSummaryClick
    end
    object StandingOrders1: TMenuItem
      Caption = 'Standing Orders'
      Enabled = False
      OnClick = btnStandingOrdersClick
    end
  end
  object qryPersonalPreferences: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblpersonalpreferences '
      'WHERE (EmployeeID = :xID);')
    Options.LongStrings = False
    Left = 824
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xID'
      end>
  end
  object qryParts: TMyQuery
    SQL.Strings = (
      'SELECT'
      'PartsID, PARTNAME, Price1, TAXCODE, PREFEREDSUPP'
      'FROM tblparts'
      'WHERE Discontinued = '#39'F'#39' AND Active = '#39'T'#39' AND '
      '(PARTTYPE = '#39'INV'#39' OR PARTTYPE = "OTHER" OR PARTTYPE = "NONINV")'
      'ORDER BY Partname;')
    Options.LongStrings = False
    Left = 792
    Top = 8
    object qryPartsPARTNAME: TStringField
      DisplayLabel = 'Product'
      DisplayWidth = 30
      FieldName = 'PARTNAME'
      Origin = 'tblparts.PARTNAME'
      Size = 60
    end
    object qryPartsPartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'PartsID'
      Origin = 'tblparts.PartsID'
      Visible = False
    end
    object qryPartsPrice1: TFloatField
      DisplayLabel = 'Price (Ex)'
      DisplayWidth = 15
      FieldName = 'Price1'
      Origin = 'tblparts.Price1'
      Visible = False
      currency = True
    end
    object qryPartsTAXCODE: TStringField
      FieldName = 'TAXCODE'
      Origin = 'tblparts.TAXCODE'
      Visible = False
      Size = 11
    end
    object qryPartsPREFEREDSUPP: TStringField
      FieldName = 'PREFEREDSUPP'
      Size = 55
    end
  end
  object qryCustomer: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      '# Dummy SQL - See RefreshClientList procedure.'
      'SELECT'
      'ClientID, Company,'
      
        'CONCAT_WS('#39' '#39', IF(ISNULL(Title), '#39#39', Title), Firstname, LastName' +
        ') AS Customer,'
      
        'LEFT(CONCAT_WS('#39' '#39', Street, IF(ISNULL(Street2), '#39#39', Street2), IF' +
        '(ISNULL(Suburb), '#39#39', Suburb),'
      
        'IF(ISNULL(State), '#39#39', State), IF(ISNULL(Postcode), '#39#39', Postcode)' +
        ','
      
        'IF(ISNULL(Country), '#39#39', Country)), 200) AS Address, Phone, FaxNu' +
        'mber AS Fax, Mobile'
      'FROM tblclients'
      
        'WHERE (Active = "T" AND Customer = "T" AND IsJob = "F" AND Compa' +
        'ny NOT LIKE "Table%")'
      'ORDER BY Customer;'
      ''
      '')
    Options.LongStrings = False
    Left = 760
    Top = 8
  end
  object dsPersonalPreferences: TDataSource
    DataSet = qryPersonalPreferences
    Left = 824
    Top = 38
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    Options = [ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Title = 'Export CSV File As ...'
    Left = 791
    Top = 38
  end
end
