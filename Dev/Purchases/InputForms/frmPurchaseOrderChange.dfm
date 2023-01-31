inherited fmPurchaseOrderChange: TfmPurchaseOrderChange
  Left = 169
  Top = 212
  HelpContext = 1659002
  Caption = 'Purchase Order Change'
  ClientWidth = 921
  ExplicitLeft = 169
  ExplicitTop = 212
  ExplicitWidth = 937
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 432
    Width = 921
    HelpContext = 1659003
    ExplicitTop = 432
    ExplicitWidth = 818
  end
  inherited shapehint: TShape
    ExplicitLeft = 5
  end
  inherited shapehintextra1: TShape
    Left = 50
    ExplicitLeft = 43
  end
  object pnlHeader: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 921
    Height = 193
    HelpContext = 1659004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      921
      193)
    object Label38: TLabel
      Left = 8
      Top = 44
      Width = 215
      Height = 18
      HelpContext = 1659005
      AutoSize = False
      Caption = 'Supplier Name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblClientDetails: TLabel
      Left = 8
      Top = 88
      Width = 226
      Height = 18
      HelpContext = 1659006
      AutoSize = False
      Caption = 'To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label35: TLabel
      Left = 573
      Top = 90
      Width = 41
      Height = 15
      HelpContext = 1659007
      Caption = 'Ship To'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object SaleDate_Label: TLabel
      Left = 612
      Top = 25
      Width = 79
      Height = 18
      HelpContext = 1659008
      AutoSize = False
      Caption = 'Order Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label160: TLabel
      Left = 742
      Top = 25
      Width = 76
      Height = 18
      HelpContext = 1659009
      AutoSize = False
      Caption = 'PO Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object pnlTitle: TDNMPanel
      Left = 227
      Top = 3
      Width = 380
      Height = 43
      HelpContext = 1659010
      Caption = 'Purchase Order'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 378
        Height = 41
        HelpContext = 1659011
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
          Width = 378
          Height = 41
          HelpContext = 1659012
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Purchase Order Change'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 305
        end
      end
    end
    object btnCompleted: TDNMSpeedButton
      Left = 824
      Top = 10
      Width = 89
      Height = 27
      HelpContext = 1659013
      Anchors = [akTop, akRight]
      Caption = 'Save'
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCompletedClick
    end
    object btnClose: TDNMSpeedButton
      Left = 824
      Top = 41
      Width = 89
      Height = 27
      HelpContext = 1659014
      Anchors = [akTop, akRight]
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnCloseClick
    end
    object txtClientDetails: TDBMemo
      Left = 8
      Top = 104
      Width = 250
      Height = 83
      HelpContext = 1659015
      DataField = 'OrderTo'
      DataSource = dsMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object txtShipTo: TDBMemo
      Left = 573
      Top = 104
      Width = 250
      Height = 83
      HelpContext = 1659016
      DataField = 'ShipTo'
      DataSource = dsMaster
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object edtSupplier: TDBEdit
      Left = 8
      Top = 59
      Width = 250
      Height = 23
      HelpContext = 1659017
      DataField = 'ClientPrintName'
      DataSource = dsMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object cboCreationDate: TwwDBDateTimePicker
      Left = 612
      Top = 43
      Width = 116
      Height = 23
      HelpContext = 1659018
      AutoFillDateAndTime = True
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'OrderDate'
      DataSource = dsMaster
      Epoch = 1950
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 6
    end
    object txtCustomID: TDBEdit
      Left = 742
      Top = 43
      Width = 75
      Height = 23
      Hint = 'Double Click For The Transaction Sequence List'
      HelpContext = 1659019
      DataField = 'PurchaseOrderNumber'
      DataSource = dsMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
    end
    object pnlApprover: TDNMPanel
      Left = 263
      Top = 59
      Width = 300
      Height = 128
      HelpContext = 1659020
      BevelInner = bvLowered
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      DesignSize = (
        300
        128)
      object Label2: TLabel
        Left = 15
        Top = 13
        Width = 52
        Height = 15
        HelpContext = 1659021
        Alignment = taRightJustify
        Caption = 'Approver'
      end
      object Label1: TLabel
        Left = 21
        Top = 102
        Width = 45
        Height = 15
        HelpContext = 1659022
        Alignment = taRightJustify
        Caption = 'Created'
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
        Left = 11
        Top = 57
        Width = 55
        Height = 15
        HelpContext = 1659023
        Alignment = taRightJustify
        Caption = 'Employee'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object cboApprover: TwwDBLookupCombo
        Left = 73
        Top = 9
        Width = 138
        Height = 23
        HelpContext = 1659024
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'30'#9'Employee Name'#9'F')
        DataField = 'ApproverEmployeeID'
        DataSource = dsTransChanges
        LookupTable = qryApproverLookup
        LookupField = 'EmployeeID'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object chkSendEmail: TwwCheckBox
        Left = 219
        Top = 12
        Width = 78
        Height = 17
        HelpContext = 1659025
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Anchors = [akTop, akRight]
        Caption = 'Notify'
        TabOrder = 1
      end
      object chkApproved: TwwCheckBox
        Left = 219
        Top = 101
        Width = 78
        Height = 17
        HelpContext = 1659026
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Anchors = [akTop, akRight]
        Caption = 'Approved'
        DataField = 'Approved'
        DataSource = dsTransChanges
        TabOrder = 2
      end
      object chkActive: TwwCheckBox
        Left = 219
        Top = 56
        Width = 78
        Height = 17
        HelpContext = 1659027
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Anchors = [akTop, akRight]
        Caption = 'Active'
        DataField = 'Active'
        DataSource = dsTransChanges
        TabOrder = 3
      end
      object edtEmployeeName: TDBEdit
        Left = 73
        Top = 53
        Width = 138
        Height = 23
        HelpContext = 1659028
        DataField = 'EmployeeName'
        DataSource = dsTransChanges
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object edtCreateDate: TDBEdit
        Left = 73
        Top = 98
        Width = 106
        Height = 23
        HelpContext = 1659029
        DataField = 'CreateDate'
        DataSource = dsTransChanges
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
    end
    object btnOpenPO: TDNMSpeedButton
      Left = 824
      Top = 72
      Width = 89
      Height = 27
      HelpContext = 1659030
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'PO'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 9
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = btnOpenPOClick
    end
    object btnNewPO: TDNMSpeedButton
      Left = 824
      Top = 104
      Width = 89
      Height = 50
      HelpContext = 1659031
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Linked PO # 12345'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 10
      TabStop = False
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnNewPOClick
    end
  end
  object pnlFooter: TDNMPanel [6]
    Left = 0
    Top = 432
    Width = 921
    Height = 100
    HelpContext = 1659032
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      921
      100)
    object Label142: TLabel
      Left = 720
      Top = 15
      Width = 82
      Height = 18
      HelpContext = 1659033
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Est Sub Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label54: TLabel
      Left = 720
      Top = 39
      Width = 82
      Height = 18
      HelpContext = 1659034
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Est Tax Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label56: TLabel
      Left = 720
      Top = 70
      Width = 68
      Height = 18
      HelpContext = 1659035
      Anchors = [akRight, akBottom]
      AutoSize = False
      Caption = 'Est Total '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 9
      Top = 57
      Width = 67
      Height = 38
      HelpContext = 1659036
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Warehouse Notes'
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
      Left = 9
      Top = 9
      Width = 67
      Height = 38
      HelpContext = 1659037
      Alignment = taRightJustify
      Anchors = [akLeft, akBottom]
      AutoSize = False
      Caption = 'Comments'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label7: TLabel
      Left = 280
      Top = 33
      Width = 54
      Height = 15
      HelpContext = 1659038
      Alignment = taRightJustify
      Caption = 'Con. Note'
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
      Left = 285
      Top = 57
      Width = 49
      Height = 30
      HelpContext = 1659039
      Alignment = taRightJustify
      Caption = 'Cust PO Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object txtSubTotal: TAdvEdit
      Left = 808
      Top = 6
      Width = 105
      Height = 24
      HelpContext = 1659040
      EditAlign = eaRight
      EditType = etMoney
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = '0'
      Visible = True
      Version = '2.8.6.9'
    end
    object txtTaxTotal: TAdvEdit
      Left = 808
      Top = 36
      Width = 105
      Height = 24
      HelpContext = 1659041
      EditAlign = eaRight
      EditType = etMoney
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = '0'
      Visible = True
      Version = '2.8.6.9'
    end
    object txtTotal: TAdvEdit
      Left = 794
      Top = 66
      Width = 119
      Height = 27
      HelpContext = 1659042
      EditAlign = eaRight
      EditType = etMoney
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      Enabled = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      Text = '0'
      Visible = True
      Version = '2.8.6.9'
    end
    object memComments: TMemo
      Left = 82
      Top = 4
      Width = 185
      Height = 43
      HelpContext = 1659043
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = memCommentsChange
    end
    object memSalesComments: TMemo
      Left = 82
      Top = 52
      Width = 185
      Height = 43
      HelpContext = 1659044
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = memSalesCommentsChange
    end
    object memConNote: TMemo
      Left = 343
      Top = 28
      Width = 185
      Height = 23
      HelpContext = 1659045
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnChange = memConNoteChange
    end
    object edtCustPoNumber: TEdit
      Left = 343
      Top = 57
      Width = 121
      Height = 23
      HelpContext = 1659046
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Text = 'edtCustPoNumber'
      OnChange = edtCustPoNumberChange
    end
  end
  object grdDetails: TAdvStringGrid [7]
    Left = 0
    Top = 193
    Width = 921
    Height = 239
    Cursor = crDefault
    HelpContext = 1659047
    Align = alClient
    DrawingStyle = gdsClassic
    FixedCols = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    OnCanEditCell = grdDetailsCanEditCell
    OnGetEditorType = grdDetailsGetEditorType
    OnEditingDone = grdDetailsEditingDone
    ActiveCellFont.Charset = ANSI_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -12
    ActiveCellFont.Name = 'Arial'
    ActiveCellFont.Style = [fsBold]
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -11
    FilterDropDown.Font.Name = 'Tahoma'
    FilterDropDown.Font.Style = []
    FilterDropDownClear = '(All)'
    FixedRowHeight = 22
    FixedFont.Charset = ANSI_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -12
    FixedFont.Name = 'Arial'
    FixedFont.Style = [fsBold]
    FloatFormat = '%.2f'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'Tahoma'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -11
    PrintSettings.FixedFont.Name = 'Tahoma'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'Tahoma'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'Tahoma'
    PrintSettings.FooterFont.Style = []
    PrintSettings.PageNumSep = '/'
    SearchFooter.FindNextCaption = 'Find &next'
    SearchFooter.FindPrevCaption = 'Find &previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -11
    SearchFooter.Font.Name = 'Tahoma'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurence'
    SearchFooter.HintFindPrev = 'Find previous occurence'
    SearchFooter.HintHighlight = 'Highlight occurences'
    SearchFooter.MatchCaseCaption = 'Match case'
    Version = '5.6.0.1'
  end
  inherited tmrProcessMessage: TTimer
    Left = 588
    Top = 65528
  end
  inherited tmrdelay: TTimer
    Left = 656
    Top = 0
  end
  inherited popSpelling: TPopupMenu
    Left = 344
    Top = 24
  end
  inherited tmrdelayMsg: TTimer
    Left = 160
    Top = 8
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 449
    Top = 24
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 485
    Top = 24
  end
  inherited MyConnection: TERPConnection
    Left = 274
    Top = 65527
  end
  inherited DataState: TDataState
    Left = 520
    Top = 24
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 379
    Top = 24
  end
  inherited imgsort: TImageList
    Left = 555
    Top = 24
    Bitmap = {
      494C010102004801500210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 274
    Top = 24
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 590
    Top = 24
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 414
    Top = 24
  end
  inherited qryMemTrans: TERPQuery
    Left = 309
    Top = 24
  end
  inherited tmrOnshow: TTimer
    Left = 728
    Top = 0
  end
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblpurchaseOrders where PurchaseOrderID = :POID')
    AfterOpen = tblMasterAfterOpen
    Left = 168
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'POID'
      end>
    object tblMasterPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
    end
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblMasterPurchaseOrderNumber: TWideStringField
      FieldName = 'PurchaseOrderNumber'
      Size = 30
    end
    object tblMasterSeqNo: TIntegerField
      FieldName = 'SeqNo'
    end
    object tblMasterOriginalNo: TWideStringField
      FieldName = 'OriginalNo'
      Size = 255
    end
    object tblMasterBaseNo: TWideStringField
      FieldName = 'BaseNo'
      Size = 255
    end
    object tblMasterAccount: TWideStringField
      FieldName = 'Account'
      Size = 255
    end
    object tblMasterAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object tblMasterBOID: TWideStringField
      FieldName = 'BOID'
      Size = 255
    end
    object tblMasterSupplierName: TWideStringField
      FieldName = 'SupplierName'
      Size = 255
    end
    object tblMasterClientPrintName: TWideStringField
      FieldName = 'ClientPrintName'
      Size = 255
    end
    object tblMasterClientID: TIntegerField
      FieldName = 'ClientID'
    end
    object tblMasterOrderTo: TWideStringField
      FieldName = 'OrderTo'
      Size = 255
    end
    object tblMasterShipTo: TWideStringField
      FieldName = 'ShipTo'
      Size = 255
    end
    object tblMasterShipToId: TIntegerField
      FieldName = 'ShipToId'
    end
    object tblMasterOrderDate: TDateTimeField
      FieldName = 'OrderDate'
    end
    object tblMasterTotalTax: TFloatField
      FieldName = 'TotalTax'
    end
    object tblMasterTotalAmount: TFloatField
      FieldName = 'TotalAmount'
    end
    object tblMasterTotalAmountInc: TFloatField
      FieldName = 'TotalAmountInc'
    end
    object tblMasterEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 255
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object tblMasterInvoiceNumber: TWideStringField
      FieldName = 'InvoiceNumber'
      Size = 30
    end
    object tblMasterRefNo: TWideStringField
      FieldName = 'RefNo'
      Size = 50
    end
    object tblMasterETADate: TDateField
      FieldName = 'ETADate'
    end
    object tblMasterDueDate: TDateField
      FieldName = 'DueDate'
    end
    object tblMasterComments: TWideStringField
      FieldName = 'Comments'
      Size = 255
    end
    object tblMasterSalesComments: TWideStringField
      FieldName = 'SalesComments'
      Size = 255
    end
    object tblMasterShipping: TWideStringField
      FieldName = 'Shipping'
      Size = 255
    end
    object tblMasterTerms: TWideStringField
      FieldName = 'Terms'
      Size = 255
    end
    object tblMasterPrintFlag: TWideStringField
      FieldName = 'PrintFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterPrintedBy: TWideStringField
      FieldName = 'PrintedBy'
      Size = 255
    end
    object tblMasterPaid: TWideStringField
      FieldName = 'Paid'
      FixedChar = True
      Size = 1
    end
    object tblMasterBalance: TFloatField
      FieldName = 'Balance'
    end
    object tblMasterPayment: TFloatField
      FieldName = 'Payment'
    end
    object tblMasterApplyFlag: TWideStringField
      FieldName = 'ApplyFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterAmountDue: TFloatField
      FieldName = 'AmountDue'
    end
    object tblMasterPayMethod: TIntegerField
      FieldName = 'PayMethod'
    end
    object tblMasterIsPO: TWideStringField
      FieldName = 'IsPO'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsRA: TWideStringField
      FieldName = 'IsRA'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsBill: TWideStringField
      FieldName = 'IsBill'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsCredit: TWideStringField
      FieldName = 'IsCredit'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsCheque: TWideStringField
      FieldName = 'IsCheque'
      FixedChar = True
      Size = 1
    end
    object tblMasterIsRefundCheque: TWideStringField
      FieldName = 'IsRefundCheque'
      FixedChar = True
      Size = 1
    end
    object tblMasterRefundGlobalref: TWideStringField
      FieldName = 'RefundGlobalref'
      Size = 255
    end
    object tblMasterIsPOCredit: TWideStringField
      FieldName = 'IsPOCredit'
      FixedChar = True
      Size = 1
    end
    object tblMasterDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object tblMasterCancelled: TWideStringField
      FieldName = 'Cancelled'
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterInvoiceDate: TDateField
      FieldName = 'InvoiceDate'
    end
    object tblMasterEnteredBy: TWideStringField
      FieldName = 'EnteredBy'
      Size = 255
    end
    object tblMasterEnteredAt: TWideStringField
      FieldName = 'EnteredAt'
      Size = 255
    end
    object tblMasterConNote: TWideStringField
      FieldName = 'ConNote'
      Size = 25
    end
    object tblMasterCustPONumber: TWideStringField
      FieldName = 'CustPONumber'
      Size = 30
    end
    object tblMasterLastUpdated: TDateTimeField
      FieldName = 'LastUpdated'
    end
    object tblMasterForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      FixedChar = True
      Size = 3
    end
    object tblMasterForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
    end
    object tblMasterForeignTotalAmount: TFloatField
      FieldName = 'ForeignTotalAmount'
    end
    object tblMasterForeignPaidAmount: TFloatField
      FieldName = 'ForeignPaidAmount'
    end
    object tblMasterForeignBalanceAmount: TFloatField
      FieldName = 'ForeignBalanceAmount'
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object tblMasterApproved: TWideStringField
      FieldName = 'Approved'
      FixedChar = True
      Size = 1
    end
    object tblMasterAPNotes: TWideMemoField
      FieldName = 'APNotes'
      BlobType = ftWideMemo
    end
    object tblMasterExpenseClaimEmployee: TIntegerField
      FieldName = 'ExpenseClaimEmployee'
    end
    object tblMastercontactID: TLargeintField
      FieldName = 'contactID'
    end
    object tblMasterContactName: TWideStringField
      FieldName = 'ContactName'
      Size = 100
    end
    object tblMasterSalesGlobalref: TWideStringField
      FieldName = 'SalesGlobalref'
      Size = 255
    end
    object tblMasterShipToCustomer: TWideStringField
      FieldName = 'ShipToCustomer'
      FixedChar = True
      Size = 1
    end
    object tblMasterRARef: TWideStringField
      FieldName = 'RARef'
      Size = 255
    end
    object tblMasterTotalDiscount: TFloatField
      FieldName = 'TotalDiscount'
    end
    object tblMasterSaleLineRef: TWideStringField
      FieldName = 'SaleLineRef'
      Size = 255
    end
    object tblMastermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object tblMasterArea: TWideStringField
      FieldName = 'Area'
      Size = 50
    end
    object tblMasterOrderStatus: TWideStringField
      FieldName = 'OrderStatus'
      Size = 50
    end
    object tblMasterEquipmentId: TIntegerField
      FieldName = 'EquipmentId'
    end
    object tblMasterEquipmentName: TWideStringField
      FieldName = 'EquipmentName'
      Size = 100
    end
    object tblMasterSOApprovedBy: TIntegerField
      FieldName = 'SOApprovedBy'
    end
    object tblMasterCreatedFromSO: TIntegerField
      FieldName = 'CreatedFromSO'
    end
    object tblMasterSignature: TBlobField
      FieldName = 'Signature'
    end
    object tblMasterSignatureTime: TDateTimeField
      FieldName = 'SignatureTime'
    end
    object tblMasterFuturePO: TWideStringField
      FieldName = 'FuturePO'
      FixedChar = True
      Size = 1
    end
    object tblMasterContractorPayment: TWideStringField
      FieldName = 'ContractorPayment'
      FixedChar = True
      Size = 1
    end
  end
  object tblDetail: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblpurchaseLines where PurchaseOrderID = :POID'
      'order by SeqNo')
    Left = 320
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'POID'
      end>
    object tblDetailPurchaseLineID: TIntegerField
      FieldName = 'PurchaseLineID'
    end
    object tblDetailSEQNo: TIntegerField
      FieldName = 'SEQNo'
    end
    object tblDetailGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object tblDetailPurchaseOrderID: TIntegerField
      FieldName = 'PurchaseOrderID'
    end
    object tblDetailBaseLineno: TIntegerField
      FieldName = 'BaseLineno'
    end
    object tblDetailProductID: TIntegerField
      FieldName = 'ProductID'
    end
    object tblDetailPARTTYPE: TWideStringField
      FieldName = 'PARTTYPE'
      Size = 13
    end
    object tblDetailINCOMEACCNT: TWideStringField
      FieldName = 'INCOMEACCNT'
      Size = 50
    end
    object tblDetailASSETACCNT: TWideStringField
      FieldName = 'ASSETACCNT'
      Size = 50
    end
    object tblDetailCOGSACCNT: TWideStringField
      FieldName = 'COGSACCNT'
      Size = 50
    end
    object tblDetailProductGroup: TWideStringField
      FieldName = 'ProductGroup'
      Size = 255
    end
    object tblDetailProductName: TWideStringField
      FieldName = 'ProductName'
      Size = 60
    end
    object tblDetailProductPrintName: TWideStringField
      FieldName = 'ProductPrintName'
      Size = 255
    end
    object tblDetailPartBarcode: TWideStringField
      FieldName = 'PartBarcode'
      Size = 255
    end
    object tblDetailProduct_Description: TWideStringField
      FieldName = 'Product_Description'
      Size = 255
    end
    object tblDetailAccountNumber: TWideStringField
      FieldName = 'AccountNumber'
      Size = 50
    end
    object tblDetailAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
    object tblDetailAccountGroup: TWideStringField
      FieldName = 'AccountGroup'
      Size = 255
    end
    object tblDetailLineTaxRate: TFloatField
      FieldName = 'LineTaxRate'
    end
    object tblDetailLineCost: TFloatField
      FieldName = 'LineCost'
      currency = True
    end
    object tblDetailAvgCost: TFloatField
      FieldName = 'AvgCost'
      currency = True
    end
    object tblDetailStandardCost: TFloatField
      FieldName = 'StandardCost'
      currency = True
    end
    object tblDetailLineCostInc: TFloatField
      FieldName = 'LineCostInc'
      currency = True
    end
    object tblDetailLineTaxCode: TWideStringField
      FieldName = 'LineTaxCode'
      Size = 15
    end
    object tblDetailLineTax: TFloatField
      FieldName = 'LineTax'
      currency = True
    end
    object tblDetailQtySold: TFloatField
      FieldName = 'QtySold'
    end
    object tblDetailUnitofMeasureQtySold: TFloatField
      FieldName = 'UnitofMeasureQtySold'
    end
    object tblDetailShipped: TFloatField
      FieldName = 'Shipped'
    end
    object tblDetailUnitofMeasureShipped: TFloatField
      FieldName = 'UnitofMeasureShipped'
    end
    object tblDetailBackOrder: TFloatField
      FieldName = 'BackOrder'
    end
    object tblDetailUnitofMeasureBackorder: TFloatField
      FieldName = 'UnitofMeasureBackorder'
    end
    object tblDetailUnitofMeasurePOLines: TWideStringField
      FieldName = 'UnitofMeasurePOLines'
      Size = 255
    end
    object tblDetailUnitOfMeasureID: TIntegerField
      FieldName = 'UnitOfMeasureID'
    end
    object tblDetailUnitofMeasureMultiplier: TFloatField
      FieldName = 'UnitofMeasureMultiplier'
    end
    object tblDetailInvoiced: TWideStringField
      FieldName = 'Invoiced'
      FixedChar = True
      Size = 1
    end
    object tblDetailClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object tblDetailClass: TWideStringField
      FieldName = 'Class'
      Size = 255
    end
    object tblDetailCustomerJob: TWideStringField
      FieldName = 'CustomerJob'
      Size = 255
    end
    object tblDetailCustomerPrintJob: TWideStringField
      FieldName = 'CustomerPrintJob'
      Size = 255
    end
    object tblDetailCustomerJobID: TIntegerField
      FieldName = 'CustomerJobID'
    end
    object tblDetailRAQty: TFloatField
      FieldName = 'RAQty'
    end
    object tblDetailRAstatus: TWideStringField
      FieldName = 'RAstatus'
      Size = 255
    end
    object tblDetailBatch: TWideStringField
      FieldName = 'Batch'
      Size = 9
    end
    object tblDetailUseTimecost: TWideStringField
      FieldName = 'UseTimecost'
      FixedChar = True
      Size = 1
    end
    object tblDetailSaleID_Timecost: TIntegerField
      FieldName = 'SaleID_Timecost'
    end
    object tblDetailTimecostMarkupPer: TFloatField
      FieldName = 'TimecostMarkupPer'
    end
    object tblDetailTimecostPrice: TFloatField
      FieldName = 'TimecostPrice'
    end
    object tblDetailTimecostMarkupDol: TFloatField
      FieldName = 'TimecostMarkupDol'
    end
    object tblDetailserialno: TWideMemoField
      FieldName = 'serialno'
      BlobType = ftWideMemo
    end
    object tblDetailTotalLineAmount: TFloatField
      FieldName = 'TotalLineAmount'
      currency = True
    end
    object tblDetailTotalLineAmountInc: TFloatField
      FieldName = 'TotalLineAmountInc'
      currency = True
    end
    object tblDetailCOGSTotalLineAmount: TFloatField
      FieldName = 'COGSTotalLineAmount'
      currency = True
    end
    object tblDetailCOGSTotalLineAmountInc: TFloatField
      FieldName = 'COGSTotalLineAmountInc'
      currency = True
    end
    object tblDetailEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblDetailDeleted: TWideStringField
      FieldName = 'Deleted'
      FixedChar = True
      Size = 1
    end
    object tblDetailRAInvoiceNo: TWideStringField
      FieldName = 'RAInvoiceNo'
      Size = 11
    end
    object tblDetailAttrib1Purchase: TFloatField
      FieldName = 'Attrib1Purchase'
    end
    object tblDetailAttrib2Purchase: TFloatField
      FieldName = 'Attrib2Purchase'
    end
    object tblDetailAttrib1PurchaseRate: TFloatField
      FieldName = 'Attrib1PurchaseRate'
    end
    object tblDetailAttrib1PurchaseEst: TFloatField
      FieldName = 'Attrib1PurchaseEst'
    end
    object tblDetailAttrib2PurchaseEst: TFloatField
      FieldName = 'Attrib2PurchaseEst'
    end
    object tblDetailLastLineID: TIntegerField
      FieldName = 'LastLineID'
    end
    object tblDetailRelatedPOIDUsed: TWideStringField
      FieldName = 'RelatedPOIDUsed'
      FixedChar = True
      Size = 1
    end
    object tblDetailRelatedPOID: TIntegerField
      FieldName = 'RelatedPOID'
    end
    object tblDetailLandedCostsPerItem: TFloatField
      FieldName = 'LandedCostsPerItem'
      currency = True
    end
    object tblDetailLandedCostsPercentage: TFloatField
      FieldName = 'LandedCostsPercentage'
    end
    object tblDetailLandedCostsTotal: TFloatField
      FieldName = 'LandedCostsTotal'
      currency = True
    end
    object tblDetailForeignExchangeRate: TFloatField
      FieldName = 'ForeignExchangeRate'
    end
    object tblDetailForeignExchangeCode: TWideStringField
      FieldName = 'ForeignExchangeCode'
      FixedChar = True
      Size = 3
    end
    object tblDetailForeignCurrencyLineCost: TFloatField
      FieldName = 'ForeignCurrencyLineCost'
    end
    object tblDetailForeignTotalLineAmount: TFloatField
      FieldName = 'ForeignTotalLineAmount'
    end
    object tblDetailDescAttrib1: TWideStringField
      FieldName = 'DescAttrib1'
      Size = 255
    end
    object tblDetailDescAttrib2: TWideStringField
      FieldName = 'DescAttrib2'
      Size = 255
    end
    object tblDetailDescAttrib3: TWideStringField
      FieldName = 'DescAttrib3'
      Size = 255
    end
    object tblDetailDescAttrib4: TWideStringField
      FieldName = 'DescAttrib4'
      Size = 255
    end
    object tblDetailDescAttrib5: TWideStringField
      FieldName = 'DescAttrib5'
      Size = 255
    end
    object tblDetailSearchFilter: TWideStringField
      FieldName = 'SearchFilter'
      Size = 255
    end
    object tblDetailSearchFilterCopy: TWideStringField
      FieldName = 'SearchFilterCopy'
      Size = 255
    end
    object tblDetailReceivedDate: TDateTimeField
      FieldName = 'ReceivedDate'
    end
    object tblDetailCostCentreId: TIntegerField
      FieldName = 'CostCentreId'
    end
    object tblDetailmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object tblDetailDocketNumber: TWideStringField
      FieldName = 'DocketNumber'
      Size = 255
    end
    object tblDetailPartSpecID: TIntegerField
      FieldName = 'PartSpecID'
    end
    object tblDetailSpecDescription: TWideStringField
      FieldName = 'SpecDescription'
      Size = 255
    end
    object tblDetailSpecValue: TFloatField
      FieldName = 'SpecValue'
    end
    object tblDetailNewForeignExchangeRate: TFloatField
      FieldName = 'NewForeignExchangeRate'
    end
    object tblDetailETADate: TDateField
      FieldName = 'ETADate'
    end
    object tblDetailCustomField1: TWideStringField
      FieldName = 'CustomField1'
      Size = 255
    end
    object tblDetailCustomField2: TWideStringField
      FieldName = 'CustomField2'
      Size = 255
    end
    object tblDetailCustomField3: TWideStringField
      FieldName = 'CustomField3'
      Size = 255
    end
    object tblDetailCustomField4: TWideStringField
      FieldName = 'CustomField4'
      Size = 255
    end
    object tblDetailCustomField5: TWideStringField
      FieldName = 'CustomField5'
      Size = 255
    end
    object tblDetailCustomField6: TWideStringField
      FieldName = 'CustomField6'
      Size = 255
    end
    object tblDetailCustomField7: TWideStringField
      FieldName = 'CustomField7'
      Size = 255
    end
    object tblDetailCustomField8: TWideStringField
      FieldName = 'CustomField8'
      Size = 255
    end
    object tblDetailCustomField9: TWideStringField
      FieldName = 'CustomField9'
      Size = 255
    end
    object tblDetailCustomField10: TWideStringField
      FieldName = 'CustomField10'
      Size = 255
    end
    object tblDetailLineNotes: TWideMemoField
      FieldName = 'LineNotes'
      BlobType = ftWideMemo
    end
    object tblDetailINCOMEACCNTID: TIntegerField
      FieldName = 'INCOMEACCNTID'
    end
    object tblDetailASSETACCNTID: TIntegerField
      FieldName = 'ASSETACCNTID'
    end
    object tblDetailCOGSACCNTID: TIntegerField
      FieldName = 'COGSACCNTID'
    end
    object tblDetailSortID: TIntegerField
      FieldName = 'SortID'
    end
    object tblDetailMemoLine: TWideMemoField
      FieldName = 'MemoLine'
      BlobType = ftWideMemo
    end
    object tblDetailSaleLineID: TIntegerField
      FieldName = 'SaleLineID'
    end
    object tblDetailRelatedShipContainerID: TIntegerField
      FieldName = 'RelatedShipContainerID'
    end
    object tblDetailRelatedShipContainerIDUsed: TWideStringField
      FieldName = 'RelatedShipContainerIDUsed'
      FixedChar = True
      Size = 1
    end
    object tblDetailRepairId: TIntegerField
      FieldName = 'RepairId'
    end
    object tblDetailCustomerEquipmentID: TIntegerField
      FieldName = 'CustomerEquipmentID'
    end
    object tblDetailEquipmentName: TWideStringField
      FieldName = 'EquipmentName'
      Size = 100
    end
    object tblDetailProcTreeId: TIntegerField
      FieldName = 'ProcTreeId'
    end
    object tblDetailSupplierProductCode: TWideStringField
      FieldName = 'SupplierProductCode'
      Size = 50
    end
    object tblDetailSupplierProductName: TWideStringField
      FieldName = 'SupplierProductName'
      Size = 50
    end
    object tblDetailRALineRef: TWideStringField
      FieldName = 'RALineRef'
      Size = 255
    end
    object tblDetailPrintedValue: TFloatField
      FieldName = 'PrintedValue'
    end
    object tblDetailDiscountPercent: TFloatField
      FieldName = 'DiscountPercent'
    end
    object tblDetailDiscountAmount: TFloatField
      FieldName = 'DiscountAmount'
      currency = True
    end
    object tblDetailOriginalCost: TFloatField
      FieldName = 'OriginalCost'
      currency = True
    end
    object tblDetailMatrixDesc: TWideMemoField
      FieldName = 'MatrixDesc'
      BlobType = ftWideMemo
    end
    object tblDetailMatrixRef: TWideMemoField
      FieldName = 'MatrixRef'
      BlobType = ftWideMemo
    end
    object tblDetailMatrixPrice: TFloatField
      FieldName = 'MatrixPrice'
    end
    object tblDetailSmartOrderID: TIntegerField
      FieldName = 'SmartOrderID'
    end
    object tblDetailSmartOrderLineID: TIntegerField
      FieldName = 'SmartOrderLineID'
    end
    object tblDetailmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object tblDetailformulaId: TIntegerField
      FieldName = 'formulaId'
    end
    object tblDetailFormulaName: TWideStringField
      FieldName = 'FormulaName'
      Size = 255
    end
    object tblDetailFormulaQtySoldValue1: TFloatField
      FieldName = 'FormulaQtySoldValue1'
    end
    object tblDetailFormulaQtySoldValue2: TFloatField
      FieldName = 'FormulaQtySoldValue2'
    end
    object tblDetailFormulaQtySoldValue3: TFloatField
      FieldName = 'FormulaQtySoldValue3'
    end
    object tblDetailFormulaQtySoldValue4: TFloatField
      FieldName = 'FormulaQtySoldValue4'
    end
    object tblDetailFormulaQtySoldValue5: TFloatField
      FieldName = 'FormulaQtySoldValue5'
    end
    object tblDetailFormulaQtySoldValue: TFloatField
      FieldName = 'FormulaQtySoldValue'
    end
    object tblDetailFormulaQtyShippedValue1: TFloatField
      FieldName = 'FormulaQtyShippedValue1'
    end
    object tblDetailFormulaQtyShippedValue2: TFloatField
      FieldName = 'FormulaQtyShippedValue2'
    end
    object tblDetailFormulaQtyShippedValue3: TFloatField
      FieldName = 'FormulaQtyShippedValue3'
    end
    object tblDetailFormulaQtyShippedValue4: TFloatField
      FieldName = 'FormulaQtyShippedValue4'
    end
    object tblDetailFormulaQtyShippedValue5: TFloatField
      FieldName = 'FormulaQtyShippedValue5'
    end
    object tblDetailFormulaQtyShippedValue: TFloatField
      FieldName = 'FormulaQtyShippedValue'
    end
    object tblDetailEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object tblDetailEmployeeName: TWideStringField
      FieldName = 'EmployeeName'
      Size = 100
    end
    object tblDetailAreaCode: TWideStringField
      FieldName = 'AreaCode'
      Size = 50
    end
    object tblDetailLinesOrder: TIntegerField
      FieldName = 'LinesOrder'
    end
    object tblDetailExpenseProductID: TIntegerField
      FieldName = 'ExpenseProductID'
    end
    object tblDetailExpenseProductName: TWideStringField
      FieldName = 'ExpenseProductName'
      Size = 100
    end
    object tblDetailGeneralNotes: TWideMemoField
      FieldName = 'GeneralNotes'
      BlobType = ftWideMemo
    end
    object tblDetailLineDescription: TWideStringField
      FieldName = 'LineDescription'
    end
    object tblDetailBoxesReceived: TIntegerField
      FieldName = 'BoxesReceived'
    end
    object tblDetailBoxesOrdered: TIntegerField
      FieldName = 'BoxesOrdered'
    end
  end
  object dsMaster: TDataSource
    DataSet = tblMaster
    Left = 160
    Top = 280
  end
  object qryTransChanges: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select * from tbltranschanges where TransType = :TransType and T' +
        'ransID = :TransID')
    Left = 360
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TransType'
      end
      item
        DataType = ftUnknown
        Name = 'TransID'
      end>
    object qryTransChangesID: TIntegerField
      FieldName = 'ID'
    end
    object qryTransChangesTransType: TWideStringField
      FieldName = 'TransType'
      Size = 255
    end
    object qryTransChangesTransID: TIntegerField
      FieldName = 'TransID'
    end
    object qryTransChangesEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
    end
    object qryTransChangesApproverEmployeeID: TIntegerField
      FieldName = 'ApproverEmployeeID'
    end
    object qryTransChangesCreateDate: TDateTimeField
      FieldName = 'CreateDate'
    end
    object qryTransChangesActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryTransChangesApproved: TWideStringField
      FieldName = 'Approved'
      FixedChar = True
      Size = 1
    end
    object qryTransChangesData: TWideMemoField
      FieldName = 'Data'
      BlobType = ftWideMemo
    end
    object qryTransChangesmstimestamp: TDateTimeField
      FieldName = 'mstimestamp'
    end
    object qryTransChangesmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Size = 3
    end
    object qryTransChangesEmployeeName: TStringField
      FieldKind = fkLookup
      FieldName = 'EmployeeName'
      LookupDataSet = qryEmployeeLookup
      LookupKeyFields = 'EmployeeID'
      LookupResultField = 'EmployeeName'
      KeyFields = 'EmployeeID'
      Size = 255
      Lookup = True
    end
  end
  object qryApproverLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '/*SQL dynamically chanegd */'
      'select distinct al.EmployeeID, al.EmployeeName, e.Email'
      'from tblapprovallevels al'
      'inner join tblemployees e on e.EmployeeID = al.EmployeeID'
      
        'where (:OrderTotal >= (al.ValueFrom - al.ValueLeeway)) and (:Ord' +
        'erTotal <= (al.ValueTo + al.ValueLeeway)) '
      'and al.ApprovalType = :ApprovalType')
    Left = 720
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'OrderTotal'
      end
      item
        DataType = ftUnknown
        Name = 'OrderTotal'
      end
      item
        DataType = ftUnknown
        Name = 'ApprovalType'
      end>
  end
  object dsTransChanges: TDataSource
    DataSet = qryTransChanges
    Left = 440
    Top = 248
  end
  object qryEmployeeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblemployees')
    Left = 584
    Top = 232
  end
  object popNewPO: TAdvPopupMenu
    AutoHotkeys = maManual
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 843
    Top = 152
    object mnuNewPO: TMenuItem
      Caption = 'New PO'
      HelpContext = 1659048
    end
  end
end
