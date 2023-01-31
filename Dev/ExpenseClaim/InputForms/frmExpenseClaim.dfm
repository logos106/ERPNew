inherited fmExpenseClaim: TfmExpenseClaim
  Left = 374
  Top = 333
  HelpContext = 1195002
  Caption = 'Expense Claim Request'
  ClientHeight = 519
  ClientWidth = 996
  ExplicitLeft = 374
  ExplicitTop = 333
  ExplicitWidth = 1012
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 519
    Width = 996
    HelpContext = 1195003
    ExplicitTop = 406
    ExplicitWidth = 757
  end
  inherited shapehint: TShape
    Left = 13
    ExplicitLeft = 6
  end
  inherited shapehintextra1: TShape
    Left = 56
    ExplicitLeft = 39
  end
  object Label1: TLabel [4]
    Left = 24
    Top = 64
    Width = 55
    Height = 15
    HelpContext = 1195004
    Caption = 'Employee'
  end
  object Label2: TLabel [5]
    Left = 14
    Top = 95
    Width = 65
    Height = 15
    HelpContext = 1195005
    Caption = 'Description'
  end
  object Label3: TLabel [6]
    Left = 834
    Top = 64
    Width = 26
    Height = 15
    HelpContext = 1195006
    Anchors = [akTop, akRight]
    Caption = 'Date'
  end
  object Label4: TLabel [7]
    Left = 3
    Top = 397
    Width = 55
    Height = 15
    HelpContext = 1195007
    Anchors = [akLeft, akBottom]
    Caption = 'Comment'
  end
  object Label8: TLabel [8]
    Left = 823
    Top = 26
    Width = 37
    Height = 15
    HelpContext = 1195008
    Anchors = [akTop, akRight]
    Caption = 'Ref No'
  end
  object Label9: TLabel [9]
    Left = 289
    Top = 64
    Width = 63
    Height = 15
    HelpContext = 1195009
    Caption = 'Request To'
  end
  object lblProcessed: TLabel [10]
    Left = 24
    Top = 20
    Width = 100
    Height = 22
    HelpContext = 1195010
    Caption = 'Processed'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel [11]
    Left = 835
    Top = 464
    Width = 38
    Height = 17
    HelpContext = 1195011
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'Total '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label10: TLabel [12]
    Left = 823
    Top = 433
    Width = 50
    Height = 15
    HelpContext = 1195012
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'Tax Total'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label11: TLabel [13]
    Left = 821
    Top = 401
    Width = 52
    Height = 15
    HelpContext = 1195013
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    Caption = 'Sub Total'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Bevel1: TBevel [14]
    Left = 909
    Top = 490
    Width = 79
    Height = 24
    HelpContext = 1195014
    Anchors = [akRight, akBottom]
  end
  object Bevel3: TBevel [15]
    Left = 5
    Top = 491
    Width = 94
    Height = 24
    HelpContext = 1195015
    Anchors = [akLeft, akBottom]
    ExplicitTop = 453
  end
  object pnlTitle: TDNMPanel [17]
    Left = 259
    Top = 6
    Width = 479
    Height = 44
    HelpContext = 1195025
    Anchors = [akTop]
    Caption = 'Bill'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 19
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 477
      Height = 42
      HelpContext = 1195026
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
        Width = 477
        Height = 42
        HelpContext = 1195027
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Expense Claim Request'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 152
      end
    end
  end
  object btnSave: TDNMSpeedButton [18]
    Left = 160
    Top = 484
    Width = 87
    Height = 27
    HelpContext = 1195028
    Action = actSave
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
    TabOrder = 13
  end
  object btnNew: TDNMSpeedButton [19]
    Left = 258
    Top = 484
    Width = 87
    Height = 27
    HelpContext = 1195029
    Action = actNew
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
    TabOrder = 14
  end
  object btnCancel: TDNMSpeedButton [20]
    Left = 748
    Top = 484
    Width = 87
    Height = 27
    HelpContext = 1195030
    Action = actCancel
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
    TabOrder = 18
  end
  object chkActive: TwwCheckBox [21]
    Left = 920
    Top = 493
    Width = 63
    Height = 18
    HelpContext = 1195031
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
    Caption = 'Active'
    DataField = 'Active'
    DataSource = dsMaster
    TabOrder = 9
  end
  object cboMasterEmployee: TwwDBLookupCombo [22]
    Left = 96
    Top = 60
    Width = 145
    Height = 23
    HelpContext = 1195032
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    DataField = 'EmployeeName'
    DataSource = dsMaster
    LookupTable = qryMasterEmployeeLookup
    LookupField = 'EmployeeName'
    DropDownWidth = 100
    ParentFont = False
    TabOrder = 0
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object edtMasterDescription: TDBEdit [23]
    Left = 96
    Top = 94
    Width = 685
    Height = 23
    HelpContext = 1195033
    Anchors = [akLeft, akTop, akRight]
    DataField = 'Description'
    DataSource = dsMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object edtMasterDate: TwwDBDateTimePicker [24]
    Left = 867
    Top = 60
    Width = 121
    Height = 23
    HelpContext = 1195034
    Anchors = [akTop, akRight]
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'Tahoma'
    CalendarAttributes.Font.Style = []
    DataField = 'DateTime'
    DataSource = dsMaster
    Epoch = 1950
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ShowButton = True
    TabOrder = 4
  end
  object chkProcessed: TwwCheckBox [25]
    Left = 8
    Top = 495
    Width = 89
    Height = 17
    HelpContext = 1195035
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
    Anchors = [akLeft, akBottom]
    Caption = 'Processed'
    DataField = 'Processed'
    DataSource = dsMaster
    TabOrder = 8
    ReadOnly = True
  end
  object edtTotalInc: TDBEdit [26]
    Left = 879
    Top = 461
    Width = 109
    Height = 23
    HelpContext = 1195036
    Anchors = [akRight, akBottom]
    DataField = 'TotalAmountInc'
    DataSource = dsMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 12
  end
  object edtTotalTax: TDBEdit [27]
    Left = 879
    Top = 429
    Width = 109
    Height = 23
    HelpContext = 1195037
    Anchors = [akRight, akBottom]
    DataField = 'TotalTax'
    DataSource = dsMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 11
  end
  object edtTotalEx: TDBEdit [28]
    Left = 879
    Top = 397
    Width = 109
    Height = 23
    HelpContext = 1195038
    Anchors = [akRight, akBottom]
    DataField = 'TotalAmountEx'
    DataSource = dsMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 10
  end
  object edtRefNo: TDBEdit [29]
    Left = 867
    Top = 22
    Width = 121
    Height = 23
    HelpContext = 1195039
    Anchors = [akTop, akRight]
    DataField = 'RefNo'
    DataSource = dsMaster
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object cboMasterRequestToEmployeeLookup: TwwDBLookupCombo [30]
    Left = 361
    Top = 60
    Width = 145
    Height = 23
    HelpContext = 1195040
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    DropDownAlignment = taLeftJustify
    DataField = 'RequestToEmployeeName'
    DataSource = dsMaster
    LookupTable = qryMasterRequestToEmployeeLookup
    LookupField = 'EmployeeName'
    DropDownWidth = 100
    ParentFont = False
    TabOrder = 1
    AutoDropDown = True
    ShowButton = True
    PreciseEditRegion = False
    AllowClearKey = False
  end
  object btnProcess: TDNMSpeedButton [31]
    Left = 356
    Top = 484
    Width = 87
    Height = 27
    HelpContext = 1195041
    Action = actProcess
    Anchors = [akBottom]
    Caption = 'P&rocess'
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
    TabOrder = 15
  end
  object btnPrint: TDNMSpeedButton [32]
    Left = 552
    Top = 484
    Width = 87
    Height = 27
    HelpContext = 1195042
    Action = actPrint
    Anchors = [akBottom]
    Caption = '&Print'
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
    TabOrder = 16
  end
  object DNMSpeedButton1: TDNMSpeedButton [33]
    Left = 650
    Top = 484
    Width = 87
    Height = 27
    HelpContext = 1195043
    Action = actPreview
    Anchors = [akBottom]
    Caption = 'Pre&view'
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
    TabOrder = 17
  end
  object pnlChooseRpt: TDNMPanel [34]
    Left = 835
    Top = 94
    Width = 152
    Height = 21
    HelpContext = 1195044
    Anchors = [akTop, akRight]
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object lblChooseRpt: TLabel
      Left = 25
      Top = 3
      Width = 98
      Height = 15
      HelpContext = 1195045
      Caption = 'Choose Template'
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object chkChooseRpt: TCheckBox
      Left = 5
      Top = 2
      Width = 14
      Height = 17
      HelpContext = 1195046
      TabStop = False
      TabOrder = 0
    end
  end
  object txtComments: TDBMemo [35]
    Left = 70
    Top = 397
    Width = 739
    Height = 81
    Hint = '"Type In A Comment For The Warehouse"'
    HelpContext = 1195047
    Anchors = [akLeft, akRight, akBottom]
    DataField = 'Comments'
    DataSource = dsMaster
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssVertical
    ShowHint = True
    TabOrder = 7
  end
  object cmdEmail: TDNMSpeedButton [36]
    Left = 454
    Top = 484
    Width = 87
    Height = 27
    HelpContext = 1195048
    Anchors = [akTop, akRight]
    Caption = '&Email'
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
    TabOrder = 20
    OnClick = cmdEmailClick
  end
  object DNMPanel1: TDNMPanel [37]
    Left = 1
    Top = 123
    Width = 992
    Height = 269
    HelpContext = 1195016
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object lblMsg: TLabel
      Left = 1
      Top = 253
      Width = 990
      Height = 15
      HelpContext = 1195017
      Align = alBottom
      Alignment = taCenter
      Caption = 'lblMsg'
      Visible = False
      ExplicitWidth = 37
    end
    object grdMain: TwwDBGrid
      AlignWithMargins = True
      Left = 11
      Top = 4
      Width = 970
      Height = 246
      HelpContext = 1195018
      Margins.Left = 10
      Margins.Right = 10
      ControlType.Strings = (
        'Reimbursement;CheckBox;T;F'
        'Approved;CheckBox;T;F'
        'TaxCode;CustomEdit;cboTaxCode;F'
        'EmployeeName;CustomEdit;cboDetailEmployee;F'
        'AccountName;CustomEdit;cboAccountName;F'
        'SupplierName;CustomEdit;cboSupplierLookup;F'
        'Approval;CustomEdit;cboApproval;F'
        'Processed;CheckBox;T;F'
        'CustomerName;CustomEdit;cboCustomer;F')
      Selected.Strings = (
        'DateTime'#9'12'#9'Date'#9#9
        'SupplierName'#9'14'#9'Supplier'#9#9
        'AccountName'#9'14'#9'Account'#9#9
        'Description'#9'21'#9'Description'#9'F'#9
        'Attachments'#9'5'#9'Attach'#9#9
        'AmountInc'#9'10'#9'Amount Inc'#9#9
        'Approval'#9'8'#9'Approval'#9#9
        'Reimbursement'#9'1'#9'Reimburse'#9#9'Reimbursement'
        'EmployeeName'#9'12'#9'Employee'#9#9'Reimbursement'
        'Comments'#9'20'#9'Comments'#9#9
        'RefNo'#9'10'#9'Ref No'#9#9
        'PayTo'#9'20'#9'Pay To'#9#9
        'AccountId'#9'10'#9'AccountId'#9#9
        'Processed'#9'1'#9'Processed'#9#9
        'CustomerName'#9'15'#9'Customer Name'#9'F'#9
        'DueDate'#9'12'#9'Due Date'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      OnRowChanged = grdMainRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Align = alClient
      DataSource = dsDetail
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      MultiSelectOptions = [msoShiftSelect]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      PopupMenu = popCustomiseGrid
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 2
      TitleButtons = False
      OnDblClick = grdMainDblClick
      OnEnter = grdMainEnter
      OnMouseUp = grdMainMouseUp
      object grdMainIButton: TwwIButton
        Left = 0
        Top = 0
        Width = 22
        Height = 35
        HelpContext = 1195019
        AllowAllUp = True
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
        Margin = 0
        NumGlyphs = 2
        OnClick = grdMainIButtonClick
      end
    end
    object cboTaxCode: TERPDbLookupCombo
      Left = 69
      Top = 47
      Width = 111
      Height = 23
      HelpContext = 1195020
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'TaxCode'
      DataSource = dsDetail
      LookupTable = qryTaxCodeLookup
      LookupField = 'Name'
      ParentFont = False
      TabOrder = 1
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      ShowMatchText = True
      LookupFormClassName = 'TTaxCodeListGUI'
      EditFormClassName = 'TfrmTaxcode'
      LookupFormKeyStringFieldName = 'Name'
      LookupComboType = ctTaxcode
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      LookupIDField = 'TaxCodeID'
    end
    object cboDetailEmployee: TwwDBLookupCombo
      Left = 214
      Top = 47
      Width = 111
      Height = 23
      HelpContext = 1195021
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      DataField = 'EmployeeName'
      DataSource = dsDetail
      LookupTable = qryDetailEmployeeLookup
      LookupField = 'EmployeeName'
      DropDownWidth = 100
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboAccountName: TERPDbLookupCombo
      Left = 359
      Top = 47
      Width = 111
      Height = 23
      HelpContext = 1195022
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AccountName'#9'25'#9'Account Name'#9'F'
        'Type'#9'20'#9'Type'#9'T'
        'Description'#9'30'#9'Description'#9'F')
      DataField = 'AccountName'
      DataSource = dsDetail
      LookupTable = qryAccountLookup
      LookupField = 'AccountName'
      Options = [loTitles]
      DropDownWidth = 700
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      LookupFormClassName = 'TChartOfAccountsListLookupGUI'
      EditFormClassName = 'TfrmChartOfAccounts'
      LookupFormKeyStringFieldName = 'AccountName'
      LookupComboType = ctAccount
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = True
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      LookupIDField = 'AccountID'
    end
    object cboSupplierLookup: TERPDbLookupCombo
      Left = 504
      Top = 47
      Width = 111
      Height = 23
      HelpContext = 1195023
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      DataField = 'SupplierName'
      DataSource = dsDetail
      LookupTable = qrySupplierLookup
      LookupField = 'Company'
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      LookupFormClassName = 'TSupplierExpressListGUI'
      EditFormClassName = 'TfmSupplier'
      LookupFormKeyStringFieldName = 'SupplierName'
      LookupComboType = ctSupplier
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    object cboApproval: TwwDBComboBox
      Left = 649
      Top = 47
      Width = 111
      Height = 23
      HelpContext = 1195024
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      DataField = 'Approval'
      DataSource = dsDetail
      DropDownCount = 8
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Pending'
        'Approved'
        'Declined')
      ItemIndex = 1
      ParentFont = False
      Sorted = False
      TabOrder = 5
      UnboundDataType = wwDefault
      OnChange = cboApprovalChange
    end
    object cboCustomer: TERPDbLookupCombo
      Left = 792
      Top = 47
      Width = 111
      Height = 23
      HelpContext = 1195055
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F')
      DataField = 'CustomerName'
      DataSource = dsDetail
      LookupTable = qryCustomerLookup
      LookupField = 'Company'
      ParentFont = False
      TabOrder = 6
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      LookupFormClassName = 'TCustomerExpressListGUI'
      EditFormClassName = 'TfrmCustomer'
      LookupFormKeyStringFieldName = 'Company'
      LookupComboType = ctCustomer
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
  end
  inherited DataState: TDataState
    Left = 128
    Top = 0
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102000401280110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 602
    Top = 8
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 680
    Top = 16
  end
  inherited qryMemTrans: TERPQuery
    Left = 196
    Top = 296
  end
  object qryMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblExpenseClaim')
    Left = 24
    Top = 296
    object qryMasterExpenseClaimID: TIntegerField
      FieldName = 'ExpenseClaimID'
    end
    object qryMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryMasterDateTime: TDateTimeField
      FieldName = 'DateTime'
    end
    object qryMasterDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object qryMasterTotalTax: TFloatField
      FieldName = 'TotalTax'
      currency = True
    end
    object qryMasterTotalAmountEx: TFloatField
      FieldName = 'TotalAmountEx'
      currency = True
    end
    object qryMasterTotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
      currency = True
    end
    object qryMasterEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
    object qryMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryMasterRefNo: TWideStringField
      FieldName = 'RefNo'
      Size = 255
    end
    object qryMasterComments: TWideStringField
      FieldName = 'Comments'
      Size = 255
    end
    object qryMasterActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryMastermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryMasterRequestToEmployeeName: TWideStringField
      FieldName = 'RequestToEmployeeName'
      Size = 255
    end
    object qryMasterRequestToEmployeeID: TIntegerField
      FieldName = 'RequestToEmployeeID'
    end
    object qryMasterProcessed: TWideStringField
      FieldName = 'Processed'
      FixedChar = True
      Size = 1
    end
  end
  object qryDetail: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblExpenseClaimLine')
    BeforeInsert = qryDetailBeforeInsert
    OnCalcFields = qryDetailCalcFields
    Left = 58
    Top = 296
    object qryDetailDateTime: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 12
      FieldName = 'DateTime'
      Origin = 'tblexpenseclaimline.DateTime'
    end
    object qryDetailSupplierName: TWideStringField
      DisplayLabel = 'Supplier'
      DisplayWidth = 14
      FieldName = 'SupplierName'
      Origin = 'tblexpenseclaimline.SupplierName'
      Size = 255
    end
    object qryDetailAccountName: TWideStringField
      DisplayLabel = 'Account'
      DisplayWidth = 14
      FieldName = 'AccountName'
      Origin = 'tblexpenseclaimline.AccountName'
      Size = 255
    end
    object qryDetailDescription: TWideStringField
      DisplayWidth = 21
      FieldName = 'Description'
      Origin = 'tblexpenseclaimline.Description'
      Size = 255
    end
    object qryDetailAttachments: TStringField
      DisplayLabel = 'Attach'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'Attachments'
      Size = 5
      Calculated = True
    end
    object qryDetailAmountInc: TFloatField
      DisplayLabel = 'Amount Inc'
      DisplayWidth = 10
      FieldName = 'AmountInc'
      Origin = 'tblexpenseclaimline.AmountInc'
      currency = True
    end
    object qryDetailApproval: TWideStringField
      DisplayWidth = 8
      FieldName = 'Approval'
      Origin = 'tblexpenseclaimline.Approval'
      FixedChar = True
      Size = 8
    end
    object qryDetailReimbursement: TWideStringField
      DisplayLabel = 'Reimburse'
      DisplayWidth = 1
      FieldName = 'Reimbursement'
      Origin = 'tblexpenseclaimline.Reimbursement'
      FixedChar = True
      Size = 1
    end
    object qryDetailEmployeeName: TWideStringField
      DisplayLabel = 'Employee'
      DisplayWidth = 12
      FieldName = 'EmployeeName'
      Origin = 'tblexpenseclaimline.EmployeeName'
      Size = 255
    end
    object qryDetailComments: TWideStringField
      DisplayWidth = 20
      FieldName = 'Comments'
      Origin = 'tblexpenseclaimline.Comments'
      Size = 255
    end
    object qryDetailRefNo: TWideStringField
      DisplayLabel = 'Ref No'
      DisplayWidth = 10
      FieldName = 'RefNo'
      Origin = 'tblexpenseclaimline.RefNo'
      Size = 255
    end
    object qryDetailPayTo: TWideStringField
      DisplayLabel = 'Pay To'
      DisplayWidth = 20
      FieldName = 'PayTo'
      Origin = 'tblexpenseclaimline.PayTo'
      Size = 255
    end
    object qryDetailAccountId: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountId'
      Origin = 'tblexpenseclaimline.AccountId'
    end
    object qryDetailProcessed: TWideStringField
      DisplayWidth = 1
      FieldName = 'Processed'
      Origin = 'tblexpenseclaimline.Processed'
      FixedChar = True
      Size = 1
    end
    object qryDetailCustomerName: TWideStringField
      DisplayLabel = 'Customer Name'
      DisplayWidth = 15
      FieldName = 'CustomerName'
      Size = 255
    end
    object qryDetailDueDate: TDateField
      DisplayLabel = 'Due Date'
      DisplayWidth = 12
      FieldName = 'DueDate'
    end
    object qryDetailTaxCode: TWideStringField
      DisplayLabel = 'Tax Code'
      DisplayWidth = 12
      FieldName = 'TaxCode'
      Origin = 'tblexpenseclaimline.TaxCode'
      Visible = False
      Size = 255
    end
    object qryDetailTax: TFloatField
      DisplayWidth = 10
      FieldName = 'Tax'
      Origin = 'tblexpenseclaimline.Tax'
      Visible = False
      currency = True
    end
    object qryDetailAmountEx: TFloatField
      DisplayLabel = 'Amount Ex'
      DisplayWidth = 10
      FieldName = 'AmountEx'
      Origin = 'tblexpenseclaimline.AmountEx'
      Visible = False
      currency = True
    end
    object qryDetailExpenseClaimLineID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ExpenseClaimLineID'
      Origin = 'tblexpenseclaimline.ExpenseClaimLineID'
      Visible = False
    end
    object qryDetailExpenseClaimID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ExpenseClaimID'
      Origin = 'tblexpenseclaimline.ExpenseClaimID'
      Visible = False
    end
    object qryDetailGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblexpenseclaimline.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryDetailSupplierID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SupplierID'
      Origin = 'tblexpenseclaimline.SupplierID'
      Visible = False
    end
    object qryDetailEmployeeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'EmployeeID'
      Origin = 'tblexpenseclaimline.EmployeeID'
      Visible = False
    end
    object qryDetailActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblexpenseclaimline.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryDetailmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblexpenseclaimline.msTimeStamp'
      Visible = False
    end
    object qryDetailmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblexpenseclaimline.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryDetailTaxCodeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'TaxCodeId'
      Origin = 'tblexpenseclaimline.TaxCodeId'
      Visible = False
    end
    object qryDetailTaxRate: TFloatField
      DisplayWidth = 10
      FieldName = 'TaxRate'
      Origin = 'tblexpenseclaimline.TaxRate'
      Visible = False
    end
    object qryDetailChequeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ChequeId'
      Origin = 'tblexpenseclaimline.ChequeId'
      Visible = False
    end
    object qryDetailBillId: TIntegerField
      DisplayWidth = 10
      FieldName = 'BillId'
      Origin = 'tblexpenseclaimline.BillId'
      Visible = False
    end
    object qryDetailCustomerID: TIntegerField
      DisplayLabel = 'Customer ID'
      DisplayWidth = 10
      FieldName = 'CustomerID'
      Visible = False
    end
  end
  object dsMaster: TDataSource
    DataSet = qryMaster
    Left = 24
    Top = 272
  end
  object dsDetail: TDataSource
    DataSet = qryDetail
    Left = 64
    Top = 272
  end
  object qryMasterEmployeeLookup: TERPQuery
    SQL.Strings = (
      
        'select EmployeeID, EmployeeName from tblEmployees where Active =' +
        ' "T" order by EmployeeName')
    Left = 230
    Top = 296
  end
  object qryTaxCodeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT T.TaxCodeID, T.Name as Name, T.Description, T.Rate  , LOC' +
        '.LocationValue as Location  FROM tbltaxcodes T Left join tbltaxc' +
        'odelocations LOC on T.TaxCodeID = LOC.TaxCodeID Where T.RegionID' +
        '=:xRegionID AND T.Active <>"F" and  ((ifnull(LOC.ID,0)=0) or ( :' +
        'filterTaxcodeforClient ="F") or  (LOc.active ="T" and  (T.Taxcod' +
        'eLocationCategory ="C" and LOC.LocationValue = :Clientcountry ) ' +
        'or  (T.TaxcodeLocationCategory ="S" and LOC.LocationValue = :Cli' +
        'entState ) or  (T.TaxcodeLocationCategory ="L" and LOC.LocationV' +
        'alue = :clientLocation ) or  (T.TaxcodeLocationCategory ="P" and' +
        ' LOC.LocationValue = :ClientPostcode )  ))'
      '   AND ('
      '(    ((:SearchMode = 0) or (IsNull(:SearchMode))) '
      
        ' or ((:SearchMode = 1) and ( ( T.Name  LIKE Concat(:SearchValue,' +
        '"%"))  OR  ( T.Description  LIKE Concat(:SearchValue,"%"))   )) '
      
        ' or ((:SearchMode = 2) and ( ( T.Name  LIKE Concat("%",:SearchVa' +
        'lue,"%"))  OR  ( T.Description  LIKE Concat("%",:SearchValue,"%"' +
        '))   )) '
      ') AND ifnull(:SearchValue , "") <> "") ORDER BY Name')
    AutoCalcFields = False
    BeforeOpen = qryTaxCodeLookupBeforeOpen
    Active = True
    Left = 92
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end
      item
        DataType = ftUnknown
        Name = 'filterTaxcodeforClient'
      end
      item
        DataType = ftUnknown
        Name = 'Clientcountry'
      end
      item
        DataType = ftUnknown
        Name = 'ClientState'
      end
      item
        DataType = ftUnknown
        Name = 'clientLocation'
      end
      item
        DataType = ftUnknown
        Name = 'ClientPostcode'
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
        Name = 'SearchMode'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
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
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryTaxCodeLookupTaxCodeID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'TaxCodeID'
      Origin = 'T.TaxCodeID'
    end
    object qryTaxCodeLookupDescription: TWideStringField
      FieldName = 'Description'
      Origin = 'T.Description'
      Size = 255
    end
    object qryTaxCodeLookupRate: TFloatField
      FieldName = 'Rate'
      Origin = 'T.Rate'
    end
    object qryTaxCodeLookupLocation: TWideStringField
      FieldName = 'Location'
      Origin = 'LOC.LocationValue'
      Size = 255
    end
    object qryTaxCodeLookupcRate: TFloatField
      FieldKind = fkCalculated
      FieldName = 'cRate'
      DisplayFormat = '##0.00%'
      Calculated = True
    end
    object qryTaxCodeLookupName: TWideStringField
      FieldName = 'Name'
      Origin = 'T.Name'
      Size = 15
    end
  end
  object qryDetailEmployeeLookup: TERPQuery
    SQL.Strings = (
      
        'select EmployeeID, EmployeeName from tblEmployees where Active =' +
        ' "T" order by EmployeeName')
    Left = 264
    Top = 296
  end
  object qryAccountLookup: TERPQuery
    SQL.Strings = (
      'SELECT'
      
        'Concat(If( char_length(Level4)>0,Space(15), If( char_length(Leve' +
        'l3)>0,Space(10),If( char_length(Level2)>0,Space(5),Space(0)))),A' +
        'ccountName) as AccountTree,'
      
        'SUBSTRING(If((char_length(tblChartofAccounts.AccountGroup)>0),Co' +
        'ncat(REPLACE(tblChartofAccounts.AccountGroup,"^"," - ")," - ",tb' +
        'lChartofAccounts.AccountName),tblChartofAccounts.AccountName),1,' +
        '255) as FullAccountName,'
      'tblChartofAccounts.AccountName,'
      'tblChartofAccounts.AccountID,'
      'tblChartofAccounts.AccountNumber,'
      'tblChartofAccounts.AccountGroup,'
      'tblacctypedesc.AccDesc AS Type,'
      'tblChartofAccounts.Description,'
      'tblChartofAccounts.Taxcode,'
      'tblChartofAccounts.Active'
      'FROM tblChartofAccounts'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblChartofA' +
        'ccounts.AccountType'
      'WHERE tblChartofAccounts.Active = '#39'T'#39' and IsHeader = '#39'F'#39
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and ((AccountName LIKE Concat(:SearchValue' +
        ',"%")) or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%"))' +
        ' or (tblacctypedesc.AccDesc LIKE Concat(:SearchValue,"%"))) )'
      
        'or ((:SearchMode = 2) and ((AccountName LIKE Concat("%",:SearchV' +
        'alue,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchVal' +
        'ue,"%")) or (tblacctypedesc.AccDesc LIKE Concat("%",:SearchValue' +
        ',"%")))))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY AccountName')
    Options.LongStrings = False
    Left = 161
    Top = 296
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
        Name = 'SearchValue'
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
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end
      item
        DataType = ftUnknown
        Name = 'SearchValue'
      end>
    object qryAccountLookupAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 25
      FieldName = 'AccountName'
      Origin = 'tblChartofAccounts.AccountName'
      FixedChar = True
      Size = 50
    end
    object qryAccountLookupType: TWideStringField
      DisplayWidth = 20
      FieldName = 'Type'
      Origin = 'tblacctypedesc.Type'
      FixedChar = True
      Size = 255
    end
    object qryAccountLookupDescription: TWideStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Origin = 'tblChartofAccounts.Description'
      FixedChar = True
      Size = 150
    end
    object qryAccountLookupActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblChartofAccounts.Active'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object qryAccountLookupFullAccountName: TWideStringField
      DisplayLabel = 'Full Account Name'
      DisplayWidth = 30
      FieldName = 'FullAccountName'
      Origin = 'tblChartofAccounts.FullAccountName'
      ReadOnly = True
      Visible = False
      Size = 255
    end
    object qryAccountLookupAccountTree: TWideStringField
      DisplayLabel = 'Account Tree'
      DisplayWidth = 45
      FieldName = 'AccountTree'
      Origin = 'tblChartofAccounts.AccountTree'
      ReadOnly = True
      Visible = False
      Size = 65
    end
    object qryAccountLookupAccountNumber: TWideStringField
      DisplayWidth = 10
      FieldName = 'AccountNumber'
      Origin = 'tblChartofAccounts.AccountNumber'
      Visible = False
      FixedChar = True
      Size = 9
    end
    object qryAccountLookupAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tblChartofAccounts.AccountID'
      Visible = False
    end
    object qryAccountLookupAccountGroup: TWideStringField
      DisplayWidth = 40
      FieldName = 'AccountGroup'
      Origin = 'tblChartofAccounts.AccountGroup'
      Visible = False
      FixedChar = True
      Size = 255
    end
    object qryAccountLookupTaxcode: TWideStringField
      DisplayWidth = 15
      FieldName = 'Taxcode'
      Origin = 'tblChartofAccounts.Taxcode'
      Visible = False
      FixedChar = True
      Size = 15
    end
  end
  object qrySupplierLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select Company, ClientId FROM tblclients C1'
      'WHERE C1.Active = "T"'
      'AND C1.Supplier = "T"'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (C1.Company LIKE Concat(:SearchValue,"' +
        '%")))'
      
        'or ((:SearchMode = 2) and (C1.Company LIKE Concat("%",:SearchVal' +
        'ue,"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    Left = 299
    Top = 296
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
    object qrySupplierLookupCompany: TWideStringField
      DisplayWidth = 25
      FieldName = 'Company'
      Size = 80
    end
    object qrySupplierLookupClientId: TIntegerField
      FieldName = 'ClientId'
    end
  end
  object ActionList1: TActionList
    Left = 440
    Top = 296
    object actSave: TAction
      Caption = 'OK'
      HelpContext = 1195049
      OnExecute = actSaveExecute
    end
    object actNew: TAction
      Caption = 'New'
      HelpContext = 1195050
      OnExecute = actNewExecute
    end
    object actCancel: TAction
      Caption = 'Cancel'
      HelpContext = 1195051
      OnExecute = actCancelExecute
    end
    object actProcess: TAction
      Caption = 'Process'
      HelpContext = 1195052
      OnExecute = actProcessExecute
    end
    object actPrint: TAction
      Caption = 'Print'
      HelpContext = 1195053
      OnExecute = actPrintExecute
    end
    object actPreview: TDNMAction
      Caption = 'Preview'
      HelpContext = 1195054
      OnExecute = actPrintExecute
      buttoncolor = clWhite
    end
  end
  object qryMasterRequestToEmployeeLookup: TERPQuery
    SQL.Strings = (
      
        'select EmployeeID, EmployeeName from tblEmployees where Active =' +
        ' "T" order by EmployeeName')
    Left = 127
    Top = 296
  end
  object qryAttachmentLookup: TERPQuery
    SQL.Strings = (
      
        'select Count(AttachmentId) as Count from tblAttachments where Ta' +
        'bleNAme = "tblexpenseclaimline" and TableId = :TableId')
    Left = 333
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TableId'
      end>
  end
  object qryCustomerLookup: TERPQuery
    SQL.Strings = (
      'Select Company, ClientId FROM tblclients C1'
      'WHERE C1.Active = "T"'
      'AND C1.Customer = "T"'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (C1.Company LIKE Concat(:SearchValue,"' +
        '%")))'
      
        'or ((:SearchMode = 2) and (C1.Company LIKE Concat("%",:SearchVal' +
        'ue,"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    Left = 368
    Top = 296
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
  end
end
