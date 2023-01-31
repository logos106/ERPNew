inherited SmartOrderGUI: TSmartOrderGUI
  Left = 459
  Top = 247
  HelpContext = 500000
  Caption = 'Smart Order'
  ClientHeight = 540
  ClientWidth = 1000
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  OnMouseDown = FormMouseDown
  ExplicitLeft = 459
  ExplicitTop = 247
  ExplicitWidth = 1016
  ExplicitHeight = 579
  DesignSize = (
    1000
    540)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 449
    Width = 1000
    HelpContext = 500037
    ExplicitTop = 460
    ExplicitWidth = 1000
  end
  inherited imgGridWatermark: TImage
    HelpContext = 500001
  end
  object pnlHeader: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 1000
    Height = 101
    HelpContext = 500027
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopOptions
    TabOrder = 0
    DesignSize = (
      1000
      101)
    object SaleDate_Label: TLabel
      Left = 2
      Top = 57
      Width = 108
      Height = 18
      HelpContext = 500028
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label54: TLabel
      Left = 2
      Top = 8
      Width = 147
      Height = 20
      HelpContext = 500030
      AutoSize = False
      Caption = 'Smart Order Description:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object lblArea: TLabel
      Left = 158
      Top = 59
      Width = 75
      Height = 15
      HelpContext = 500049
      Anchors = [akTop, akRight]
      Caption = 'Area Number'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lbMemTrans: TLabel
      Left = 673
      Top = 9
      Width = 124
      Height = 14
      HelpContext = 500061
      Anchors = [akTop, akRight]
      Caption = 'Right-Click For More ...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblSaleID: TDBText
      Left = 261
      Top = 57
      Width = 75
      Height = 17
      HelpContext = 500066
      Anchors = [akTop, akRight]
      DataField = 'Saletype'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label160: TLabel
      Left = 627
      Top = 35
      Width = 81
      Height = 15
      HelpContext = 500067
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'Smart Order #'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 381
      Top = 57
      Width = 120
      Height = 15
      HelpContext = 500068
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Default Supplier'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cboCreationDate: TwwDBDateTimePicker
      Left = 2
      Top = 73
      Width = 116
      Height = 23
      HelpContext = 500031
      Anchors = [akTop, akRight]
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      DataField = 'CreationDate'
      DataSource = DSMaster
      Epoch = 1950
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ShowButton = True
      TabOrder = 1
    end
    object txtSmartOrderDesc: TDBEdit
      Left = 2
      Top = 25
      Width = 334
      Height = 23
      HelpContext = 500032
      Anchors = [akLeft, akTop, akRight]
      AutoSelect = False
      AutoSize = False
      Color = clWhite
      DataField = 'SmartOrderDesc'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object pnlTitle: TDNMPanel
      Left = 381
      Top = 6
      Width = 239
      Height = 45
      HelpContext = 500034
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 235
        Height = 41
        HelpContext = 500035
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
          Width = 235
          Height = 41
          HelpContext = 500036
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Smart Order'
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
    object cboAreaCode: TwwDBLookupCombo
      Left = 158
      Top = 73
      Width = 75
      Height = 23
      HelpContext = 500050
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'AreaCode'#9'10'#9'Code'#9'F'
        'AreaName'#9'20'#9'Name'#9'F')
      DataField = 'Area'
      DataSource = DSMaster
      LookupTable = QryAreaCodes
      LookupField = 'AreaCode'
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object edtSaleID: TDBEdit
      Left = 261
      Top = 72
      Width = 75
      Height = 23
      HelpContext = 500069
      Anchors = [akTop, akRight]
      AutoSelect = False
      AutoSize = False
      Color = clWhite
      DataField = 'SaleID'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object txtCustomID: TDBEdit
      Left = 715
      Top = 29
      Width = 78
      Height = 23
      Hint = 'Double Click For The Transaction Sequence List'
      HelpContext = 500070
      TabStop = False
      Anchors = [akTop, akRight]
      DataField = 'SmartOrderID'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 6
    end
    object pnlApprover: TDNMPanel
      Left = 806
      Top = 29
      Width = 190
      Height = 67
      HelpContext = 500071
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object lblApprover: TLabel
        AlignWithMargins = True
        Left = 2
        Top = 23
        Width = 52
        Height = 15
        HelpContext = 500072
        Caption = 'Approver'
        Layout = tlCenter
      end
      object cboApprover: TwwDBLookupCombo
        Left = 2
        Top = 40
        Width = 177
        Height = 23
        HelpContext = 500073
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'EmployeeName'#9'30'#9'Employee Name'#9'F')
        DataField = 'ApproverID'
        DataSource = DSMaster
        LookupTable = qryApproverLookup
        LookupField = 'EmployeeID'
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboApproverCloseUp
      end
      object chkSendEmail: TwwCheckBox
        Left = 112
        Top = 1
        Width = 64
        Height = 15
        HelpContext = 500074
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Notify ?'
        TabOrder = 1
      end
      object chkApproved: TwwCheckBox
        AlignWithMargins = True
        Left = -1
        Top = 1
        Width = 88
        Height = 15
        HelpContext = 500077
        Margins.Right = 10
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Approved? '
        DataField = 'Approved'
        DataSource = DSMaster
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = chkApprovedClick
      end
    end
    object cboDefaultSupplier: TERPDbLookupCombo
      Left = 381
      Top = 73
      Width = 239
      Height = 23
      HelpContext = 500075
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PrintName'#9'25'#9'Display Name'#9'F'
        'Company'#9'25'#9'Supplier ID'#9'F')
      DataField = 'DefaultSupplierName'
      DataSource = DSMaster
      LookupTable = qryDefaultSupplier
      LookupField = 'Company'
      ParentFont = False
      TabOrder = 5
      AutoDropDown = False
      ShowButton = True
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
      DataIDField = 'DefaultSupplierID'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    object chkDefaultSupplierAll: TwwCheckBox
      Left = 541
      Top = 56
      Width = 79
      Height = 17
      HelpContext = 500076
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Anchors = [akTop, akRight]
      Caption = 'All Lines'
      DataField = 'UseDefaultSupplierForAllLines'
      DataSource = DSMaster
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object DNMPanel1: TDNMPanel
      Left = 635
      Top = 63
      Width = 110
      Height = 36
      HelpContext = 500078
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object chkDone: TDBCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 3
        Width = 91
        Height = 30
        HelpContext = 500079
        Margins.Right = 15
        Align = alRight
        Alignment = taLeftJustify
        Caption = ' Converted ? '
        DataField = 'Done'
        DataSource = DSMaster
        ReadOnly = True
        TabOrder = 0
        ValueChecked = 'T'
        ValueUnchecked = 'F'
      end
    end
  end
  object pnlFooter: TDNMPanel [6]
    Left = 0
    Top = 449
    Width = 1000
    Height = 91
    HelpContext = 500004
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      1000
      91)
    object cboComments_Label: TLabel
      Left = 8
      Top = -56
      Width = 67
      Height = 18
      HelpContext = 500006
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
      ExplicitTop = -67
    end
    object Label89: TLabel
      Left = 3
      Top = -1
      Width = 101
      Height = 28
      HelpContext = 500007
      Alignment = taCenter
      AutoSize = False
      Caption = 'Total of Different Parts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label65: TLabel
      Left = 806
      Top = 3
      Width = 86
      Height = 16
      HelpContext = 500060
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Total Cost (Ex)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Label68: TLabel
      Left = 801
      Top = 32
      Width = 91
      Height = 16
      HelpContext = 500009
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      AutoSize = False
      Caption = 'Total Cost (Inc)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object Bevel1: TDNMPanel
      Left = 110
      Top = 8
      Width = 617
      Height = 34
      HelpContext = 500005
      Anchors = [akTop]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object pnlAdvPrinting: TDNMPanel
        AlignWithMargins = True
        Left = 232
        Top = 4
        Width = 269
        Height = 26
        HelpContext = 500019
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        TabOrder = 3
        object LblShowPreview: TLabel
          Tag = 1
          AlignWithMargins = True
          Left = 134
          Top = 4
          Width = 129
          Height = 18
          HelpContext = 500020
          Align = alLeft
          Caption = 'Group Product on PO'#39's'
          Enabled = False
          Transparent = True
          Layout = tlCenter
          ExplicitHeight = 15
        end
        object Label1: TLabel
          AlignWithMargins = True
          Left = 24
          Top = 4
          Width = 76
          Height = 18
          HelpContext = 500021
          Align = alLeft
          Caption = 'Preview PO'#39's'
          Enabled = False
          Transparent = True
          Layout = tlCenter
          ExplicitHeight = 15
        end
        object chkGroupClass: TCheckBox
          AlignWithMargins = True
          Left = 114
          Top = 4
          Width = 14
          Height = 18
          HelpContext = 500022
          Margins.Left = 11
          Align = alLeft
          Enabled = False
          TabOrder = 1
        end
        object chkPreview: TCheckBox
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 14
          Height = 18
          HelpContext = 500023
          Align = alLeft
          Enabled = False
          TabOrder = 0
        end
      end
      object chkPrint: TCheckBox
        AlignWithMargins = True
        Left = 174
        Top = 4
        Width = 52
        Height = 26
        HelpContext = 500017
        Align = alLeft
        Caption = 'Print'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object chkShow: TCheckBox
        AlignWithMargins = True
        Left = 114
        Top = 4
        Width = 54
        Height = 26
        HelpContext = 500018
        Align = alLeft
        Caption = 'Show'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object CmdCreatePOs: TDNMSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 104
        Height = 26
        Hint = 
          'Click To Create All The Required Purchase Orders To Fullfil This' +
          ' Smart Order'
        HelpContext = 500016
        Align = alLeft
        Caption = 'Create PO'#39's'
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
        TabOrder = 0
        AutoDisableParentOnclick = True
        OnClick = CmdCreatePOsClick
      end
      object ChkchooseReport: TCheckBox
        AlignWithMargins = True
        Left = 507
        Top = 4
        Width = 107
        Height = 26
        HelpContext = 500054
        Align = alLeft
        Caption = 'Choose Report'
        TabOrder = 4
      end
    end
    object btnNew: TDNMSpeedButton
      Left = 150
      Top = 57
      Width = 93
      Height = 27
      HelpContext = 500012
      Anchors = [akTop]
      Caption = '&New'
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
      AutoDisableParentOnclick = True
      OnClick = btnNewClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 857
      Top = 57
      Width = 93
      Height = 27
      HelpContext = 500013
      Anchors = [akTop]
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
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 13
      AutoDisableParentOnclick = True
      OnClick = btnCancelClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 251
      Top = 57
      Width = 93
      Height = 27
      HelpContext = 500014
      Anchors = [akTop]
      Caption = 'Prin&t'
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
      AutoDisableParentOnclick = True
      OnClick = btnPrintClick
    end
    object btnSave: TDNMSpeedButton
      Left = 50
      Top = 57
      Width = 93
      Height = 27
      HelpContext = 500015
      Anchors = [akTop]
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 5
      AutoDisableParentOnclick = True
      OnClick = btnSaveClick
    end
    object edTotalPriceEx: TEdit
      Left = 899
      Top = 0
      Width = 97
      Height = 23
      HelpContext = 500024
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object edTotalPriceInc: TEdit
      Left = 899
      Top = 29
      Width = 97
      Height = 23
      HelpContext = 500025
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object edTotalPartNo: TEdit
      Left = 5
      Top = 29
      Width = 97
      Height = 23
      HelpContext = 500026
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnHideConverted: TDNMSpeedButton
      Left = 554
      Top = 57
      Width = 93
      Height = 27
      HelpContext = 500055
      Anchors = [akTop]
      Caption = 'Hide Converted'
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
      TabOrder = 10
      AutoDisableParentOnclick = True
      OnClick = btnHideConvertedClick
    end
    object DNMSpeedButton1: TDNMSpeedButton
      Left = 655
      Top = 57
      Width = 93
      Height = 27
      HelpContext = 500038
      Action = actSelectRecord
      Anchors = [akTop]
      Caption = 'Select Record'
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
      TabOrder = 11
      AutoDisableParentOnclick = True
    end
    object DNMSpeedButton2: TDNMSpeedButton
      Left = 756
      Top = 57
      Width = 93
      Height = 27
      HelpContext = 500039
      Action = actSummary
      Anchors = [akTop]
      Caption = 'Summary'
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
      TabOrder = 12
      AutoDisableParentOnclick = True
    end
    object btnRFQ: TDNMSpeedButton
      Left = 453
      Top = 57
      Width = 93
      Height = 27
      HelpContext = 500056
      Anchors = [akTop]
      Caption = 'RFQs'
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
      TabOrder = 9
      AutoDisableParentOnclick = True
      OnClick = btnRFQClick
    end
    object btnMakeRFG: TDNMSpeedButton
      Left = 352
      Top = 57
      Width = 93
      Height = 27
      HelpContext = 500057
      Anchors = [akTop]
      Caption = 'Email RFQ'
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
      TabOrder = 8
      AutoDisableParentOnclick = True
      OnClick = btnMakeRFGClick
    end
    object btnAttachments: TDNMSpeedButton
      Left = 730
      Top = 18
      Width = 65
      Height = 22
      HelpContext = 500080
      Anchors = [akTop]
      Caption = 'Attach'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000000
        000557777777777777750BBBBBBBBBBBBBB07F5555FFFFFFF5570BBBB0000000
        BBB07F5557777777FF570BBB077BBB770BB07F557755555775570BBBBBBBBBBB
        BBB07F5555FFFFFFF5570BBBB0000000BBB07F5557777777F5570BBBB0FFFFF0
        BBB07F5557FFFFF7F5570BBBB0000000BBB07F555777777755570BBBBBBBBBBB
        BBB07FFFFFFFFFFFFFF700000000000000007777777777777777500FFFFFFFFF
        F005577FF555FFFFF7755500FFF00000005555775FF7777777F5550F777FFFFF
        F055557F777FFF5557F5550000000FFF00555577777775FF77F5550777777000
        7055557FFFFFF777F7F555000000000000555577777777777755}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      AutoDisableParentOnclick = True
      OnClick = btnAttachmentsClick
    end
  end
  object pnlDetail: TDNMPanel [7]
    Left = 0
    Top = 101
    Width = 1000
    Height = 348
    HelpContext = 500002
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    object lblMsg: TLabel
      Left = 0
      Top = 333
      Width = 1000
      Height = 15
      HelpContext = 500040
      Align = alBottom
      Alignment = taCenter
      Caption = 'messages'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Transparent = True
      Visible = False
      ExplicitWidth = 60
    end
    object grdLines: TwwDBGrid
      Left = 0
      Top = 0
      Width = 1000
      Height = 333
      HelpContext = 500003
      ControlType.Strings = (
        'CusJobID;CustomEdit;cboCustomerJob;T'
        'ClassID;CustomEdit;cboClass;T'
        'SupplierID;CustomEdit;cboClient;T'
        'className;CustomEdit;cboClass;T'
        'UnitofMeasure;CustomEdit;cboUnitOfMeasure;F'
        'IsAvailable;CustomEdit;edtAvailable;F'
        'PARTSNAME;CustomEdit;cboProductR;F'
        'SearchFilter;CustomEdit;txtSearchFilter;T'
        'SupplierName;CustomEdit;cboClientR;F'
        'CusJobName;CustomEdit;cboCustomerJob;F'
        'ClassName;CustomEdit;cboClass;F'
        'Deleted;CheckBox;T;F'
        'EquipmentName;CustomEdit;cboEquipmentname;F'
        'converted;CheckBox;T;F'
        'MultiBuy;CheckBox;T;F'
        'SupplierPrintName;CustomEdit;cboPrintClientR;F')
      Selected.Strings = (
        'PARTSNAME'#9'17'#9'Product Name'#9'F'#9
        'PODesc'#9'22'#9'Description'#9#9
        'UnitofMeasure'#9'10'#9'Unit'#9#9
        'UnitofMeasureQty'#9'10'#9'To Purchase'#9#9
        'AvailableQty'#9'10'#9'Available Qty'#9#9
        'OnOrder'#9'10'#9'On Order'#9#9
        'SupplierPrintName'#9'20'#9'Supplier Print Name'#9'F'#9
        'CostInc'#9'9'#9'Cost (Inc)'#9#9
        'TotalCostInc'#9'10'#9'Total Cost(Inc)'#9'F'#9
        'ToBuildUOMQty'#9'10'#9'To Build'#9'F'#9
        'WastagePercentage'#9'10'#9'Wastage~Percentage'#9'F'#9
        'CusJobPrintName'#9'20'#9'Customer: / Job'#9'F'#9
        'ClassName'#9'12'#9'Department'#9#9
        'converted'#9'8'#9'Converted'#9#9
        'SupplierProductCode'#9'20'#9'Supplier Product Code'#9'F'#9
        'supplierProductname'#9'20'#9'Supplier Product Name'#9'F'#9
        'PrintedValue'#9'10'#9'Printed Value'#9#9
        'LineNotes'#9'20'#9'Line Notes'#9'F'#9
        'GeneralNotes'#9'20'#9'Product General Notes'#9'F'#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnHighlight
      OnMultiSelectRecord = grdLinesMultiSelectRecord
      OnRowChanged = grdLinesRowChanged
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgAllowInsert]
      MultiSelectOptions = [msoAutoUnselect, msoShiftSelect]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgMultiSelect, dgShowFooter, dgRowResize]
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
      OnCalcCellColors = grdLinesCalcCellColors
      OnCalcTitleAttributes = grdLinesCalcTitleAttributes
      OnTitleButtonClick = grdLinesTitleButtonClick
      OnDblClick = grdLinesDblClick
      OnEnter = grdLinesEnter
      OnKeyPress = grdLinesKeyPress
      OnCalcTitleImage = grdLinesCalcTitleImage
      TitleImageList = imgPopup
      PaintOptions.AlternatingRowRegions = [arrFixedColumns]
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
      object btnDeleteGridLine: TwwIButton
        Left = 0
        Top = 0
        Width = 20
        Height = 33
        Hint = 'Click to Delete Record'
        HelpContext = 500041
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
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = btnDeleteGridLineDblClick
        OnDblClick = btnDeleteGridLineDblClick
      end
    end
    object cboClass: TwwDBLookupCombo
      Left = 503
      Top = 108
      Width = 121
      Height = 26
      HelpContext = 500043
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'ClassName'#9'30'#9'Class Name'#9'T')
      DataField = 'ClassName'
      DataSource = DSDetails
      LookupTable = cboClassQry
      LookupField = 'ClassName'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      Style = csDropDownList
      DropDownWidth = 150
      ParentFont = False
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboClientR: TERPDbLookupCombo
      Left = 627
      Top = 109
      Width = 121
      Height = 26
      HelpContext = 500044
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Supplier;CustomEdit;cboClient;F')
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'Company'#9'55'#9'Supplier'#9'F')
      DataField = 'SupplierName'
      DataSource = DSDetails
      LookupTable = qryClient
      LookupField = 'Company'
      Options = [loTitles]
      ParentFont = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboClientRCloseUp
      LookupFormClassName = 'TSupplierExpressListGUI'
      EditFormClassName = 'TfmSupplier'
      LookupFormKeyStringFieldName = 'SupplierName'
      LookupComboType = ctSupplier
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'SupplierID'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    object cboUnitOfMeasure: TwwDBLookupCombo
      Left = 131
      Top = 108
      Width = 121
      Height = 26
      HelpContext = 500045
      AutoSize = False
      DropDownAlignment = taLeftJustify
      DataField = 'UnitofMeasure'
      DataSource = DSDetails
      LookupTable = qryUnitOfMeasure
      LookupField = 'UnitName'
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboProductR: TERPDbLookupCombo
      Left = 8
      Top = 108
      Width = 121
      Height = 26
      HelpContext = 500046
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Part Name'#9'F'
        'PURCHASEDESC'#9'50'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9#9)
      DataField = 'PARTSNAME'
      DataSource = DSDetails
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboProductRCloseUp
      LookupFormClassName = 'TProductListExpressGUI'
      EditFormClassName = 'TfrmParts'
      LookupFormKeyStringFieldName = 'ProductName'
      LookupComboType = ctProduct
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = True
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'PARTSID'
      LookupIDField = 'PartsID'
      LookupFieldAlt = 'ProductPrintName'
    end
    object txtSearchFilter: TwwDBEdit
      Left = 754
      Top = 108
      Width = 121
      Height = 23
      HelpContext = 500047
      DataField = 'SearchFilter'
      DataSource = DSDetails
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboEquipmentname: TwwDBLookupCombo
      Left = 255
      Top = 108
      Width = 121
      Height = 26
      HelpContext = 500048
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'EquipmentName'#9'20'#9'Name'#9'F'
        'RepairID'#9'10'#9'Repair#'#9'F'
        'Serialno'#9'1'#9'Serial#'#9'F'
        'Quantity'#9'1'#9'Quantity'#9'F'
        'Manufacture'#9'1'#9'Manufacture'#9'F'
        'model'#9'1'#9'Model'#9'F'
        'Registration'#9'1'#9'Registration'#9'F'
        'WarantyFinishDate'#9'1'#9'Warranty Finish'#9'F'
        'WarantyPeriod'#9'1'#9'Warranty Period'#9'F')
      LookupTable = qryrepairequip
      LookupField = 'CustomerEquipmentID'
      Options = [loTitles]
      TabOrder = 6
      Visible = False
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = True
      OnDblClick = cboEquipmentnameDblClick
      OnCloseUp = cboEquipmentnameCloseUp
      OnNotInList = cboEquipmentnameNotInList
    end
    object cboPrintProductR: TERPDbLookupCombo
      Left = 9
      Top = 77
      Width = 121
      Height = 26
      HelpContext = 500062
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Active;CheckBox;T;F')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Part Name'#9'F'
        'PURCHASEDESC'#9'50'#9'Description'#9'F'
        'Active'#9'1'#9'Active'#9#9)
      DataField = 'PARTSNAME'
      DataSource = DSDetails
      LookupTable = cboProductQry
      LookupField = 'Partname'
      Options = [loTitles]
      ParentFont = False
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboProductRCloseUp
      LookupFormClassName = 'TProductListExpressGUI'
      EditFormClassName = 'TfrmParts'
      LookupFormKeyStringFieldName = 'ProductName'
      LookupComboType = ctProduct
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = True
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'PARTSID'
      LookupIDField = 'PartsID'
      LookupFieldAlt = 'ProductPrintName'
    end
    object cboCustomerJob: TERPDbLookupCombo
      Left = 376
      Top = 76
      Width = 121
      Height = 26
      HelpContext = 500064
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'30'#9'Company'#9'F'
        'JobNumber'#9'10'#9'Job Number'#9'F')
      DataField = 'CusJobName'
      DataSource = DSDetails
      LookupTable = qryClientLookup
      LookupField = 'Company'
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
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
      DataIDField = 'CusJobID'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    object cboPrintCustomerJob: TERPDbLookupCombo
      Left = 376
      Top = 108
      Width = 121
      Height = 26
      HelpContext = 500065
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'45'#9'Company'#9'F'#9
        'JobNumber'#9'8'#9'JobNumber'#9'F'#9)
      DataField = 'CusJobName'
      DataSource = DSDetails
      LookupTable = qryClientLookup
      LookupField = 'Company'
      TabOrder = 9
      AutoDropDown = True
      ShowButton = True
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
      DataIDField = 'CusJobID'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
    object cboPrintClientR: TERPDbLookupCombo
      Left = 630
      Top = 76
      Width = 121
      Height = 26
      HelpContext = 500081
      BiDiMode = bdLeftToRight
      ParentBiDiMode = False
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'Supplier;CustomEdit;cboClient;F')
      DropDownAlignment = taRightJustify
      Selected.Strings = (
        'Company'#9'55'#9'Supplier'#9'F')
      DataField = 'SupplierPrintName'
      DataSource = DSDetails
      LookupTable = qryClient
      LookupField = 'Company'
      Options = [loTitles]
      ParentFont = False
      TabOrder = 10
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboClientRCloseUp
      LookupFormClassName = 'TSupplierExpressListGUI'
      EditFormClassName = 'TfmSupplier'
      LookupFormKeyStringFieldName = 'SupplierName'
      LookupComboType = ctSupplier
      AllowFullListSearchMode = False
      DisableNotInList = False
      AllowMultipleSelectFromList = False
      OpenListinF6WhenNotinList = False
      DeveloperHint = 'when in Grid -> Grid.Keoption -dgEnterToTab'
      DataIDField = 'SupplierID'
      LookupIDField = 'ClientID'
      LookupFieldAlt = 'PrintName'
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 468
    Top = 287
  end
  inherited tmrdelay: TTimer
    Left = 512
    Top = 287
  end
  inherited popSpelling: TPopupMenu
    Left = 114
    Top = 287
  end
  inherited tmrdelayMsg: TTimer
    Left = 557
    Top = 287
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 158
    Top = 287
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 203
    Top = 287
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 26
    Top = 287
  end
  inherited DataState: TDataState
    Left = 291
    Top = 287
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 601
    Top = 287
  end
  inherited imgsort: TImageList
    Left = 380
    Top = 287
    Bitmap = {
      494C01010200C8008C0210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 824
    Top = 326
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 424
    Top = 287
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 645
    Top = 288
  end
  inherited qryMemTrans: TERPQuery
    Left = 869
    Top = 326
  end
  object DSMaster: TDataSource
    DataSet = tblMaster
    Left = 24
    Top = 366
  end
  object DSDetails: TDataSource
    DataSet = tblDetails
    Left = 67
    Top = 366
  end
  object TaxCodeDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT TaxCodeID, Rate  FROM tbltaxcodes '
      'Where Name =:TAXCODE  AND  RegionID= :xRegionID')
    BeforeOpen = TaxCodeDetailsBeforeOpen
    Left = 557
    Top = 326
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TAXCODE'
      end
      item
        DataType = ftUnknown
        Name = 'xRegionID'
      end>
  end
  object imgPopup: TImageList
    Left = 247
    Top = 287
    Bitmap = {
      494C01010200B8007C0210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object tblMaster: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsmartorder'
      'Where SmartOrderID= :ID;')
    AutoCalcFields = False
    AfterOpen = tblMasterAfterOpen
    OnCalcFields = tblMasterCalcFields
    Left = 23
    Top = 326
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblMasterSmartOrderID: TAutoIncField
      AutoGenerateValue = arAutoInc
      FieldName = 'SmartOrderID'
      Origin = 'tblsmartorder.SmartOrderID'
      ReadOnly = True
    end
    object tblMasterEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Origin = 'tblsmartorder.EmployeeID'
    end
    object tblMasterCreationDate: TDateField
      FieldName = 'CreationDate'
      Origin = 'tblsmartorder.CreationDate'
    end
    object tblMasterSmartOrderDesc: TWideStringField
      FieldName = 'SmartOrderDesc'
      Origin = 'tblsmartorder.SmartOrderDesc'
      FixedChar = True
      Size = 255
    end
    object tblMasterArea: TWideStringField
      FieldName = 'Area'
      Origin = 'tblsmartorder.Area'
      FixedChar = True
      Size = 50
    end
    object tblMasterDone: TWideStringField
      FieldName = 'Done'
      Origin = 'tblsmartorder.Done'
      FixedChar = True
      Size = 1
    end
    object tblMasterEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      Origin = 'tblsmartorder.EditedFlag'
      FixedChar = True
      Size = 1
    end
    object tblMasterSaleOrderID: TIntegerField
      FieldName = 'SaleOrderID'
      Origin = 'tblsmartorder.SaleOrderID'
    end
    object tblMasterGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblsmartorder.GlobalRef'
      Size = 255
    end
    object tblMasterProjectLineID: TIntegerField
      FieldName = 'ProjectLineID'
      Origin = 'tblsmartorder.ProjectLineID'
    end
    object tblMasterSalesglobalRef: TWideStringField
      FieldName = 'SalesglobalRef'
      Origin = 'tblsmartorder.SalesGlobalref'
      Size = 255
    end
    object tblMasterShipTo: TWideStringField
      FieldName = 'ShipTo'
      Origin = 'tblsmartorder.ShipTo'
      Size = 255
    end
    object tblMastermsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblsmartorder.msTimeStamp'
    end
    object tblMastermsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblsmartorder.msUpdateSiteCode'
      Size = 3
    end
    object tblMasterApproved: TWideStringField
      FieldName = 'Approved'
      Origin = 'tblsmartorder.Approved'
      FixedChar = True
      Size = 1
    end
    object tblMasterApprovedBy: TIntegerField
      FieldName = 'ApprovedBy'
      Origin = 'tblsmartorder.ApprovedBy'
    end
    object tblMasterSaleID: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'SaleID'
      Calculated = True
    end
    object tblMasterSaletype: TStringField
      FieldKind = fkCalculated
      FieldName = 'Saletype'
      Calculated = True
    end
    object tblMasterApproverID: TIntegerField
      FieldName = 'ApproverID'
      Origin = 'tblsmartorder.ApproverID'
    end
    object tblMasterDefaultSupplierID: TIntegerField
      FieldName = 'DefaultSupplierID'
      Origin = 'tblsmartorder.DefaultSupplierID'
    end
    object tblMasterDefaultSupplierName: TWideStringField
      FieldName = 'DefaultSupplierName'
      Size = 255
    end
    object tblMasterUseDefaultSupplierForAllLines: TWideStringField
      FieldName = 'UseDefaultSupplierForAllLines'
      FixedChar = True
      Size = 1
    end
  end
  object tblDetails: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsmartorderlines'
      'Where SmartOrderID= :ID;')
    AutoCalcFields = False
    BeforeOpen = tblDetailsBeforeOpen
    AfterOpen = tblDetailsAfterOpen
    OnCalcFields = tblDetailsCalcFields
    Left = 67
    Top = 326
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
    object tblDetailsPARTSNAME: TWideStringField
      DisplayLabel = 'Product Name'
      DisplayWidth = 17
      FieldName = 'PARTSNAME'
      Origin = 'tblsmartorderlines.PARTSNAME'
      Size = 255
    end
    object tblDetailsPODesc: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 22
      FieldName = 'PODesc'
      Origin = 'tblsmartorderlines.PODesc'
      FixedChar = True
      Size = 255
    end
    object tblDetailsUnitofMeasure: TWideStringField
      DisplayLabel = 'Unit'
      DisplayWidth = 10
      FieldName = 'UnitofMeasure'
      Origin = 'tblsmartorderlines.UnitofMeasure'
      Size = 255
    end
    object tblDetailsUnitofMeasureQty: TFloatField
      DisplayLabel = 'To Purchase'
      DisplayWidth = 10
      FieldName = 'UnitofMeasureQty'
      Origin = 'tblsmartorderlines.UnitofMeasureQty'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsAvailableQty: TFloatField
      DisplayLabel = 'Available Qty'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'AvailableQty'
      Calculated = True
    end
    object tblDetailsOnOrder: TFloatField
      DisplayLabel = 'On Order'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'OnOrder'
      Calculated = True
    end
    object tblDetailsSupplierPrintName: TWideStringField
      DisplayLabel = 'Supplier Print Name'
      DisplayWidth = 20
      FieldName = 'SupplierPrintName'
      Size = 255
    end
    object tblDetailsCostInc: TFloatField
      DisplayLabel = 'Cost (Inc)'
      DisplayWidth = 9
      FieldName = 'CostInc'
      Origin = 'tblsmartorderlines.CostInc'
      OnChange = tblDetailsCostIncChange
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsTotalCostInc: TFloatField
      DisplayLabel = 'Total Cost(Inc)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalCostInc'
      currency = True
      Calculated = True
    end
    object tblDetailsToBuildUOMQty: TFloatField
      DisplayLabel = 'To Build'
      DisplayWidth = 10
      FieldName = 'ToBuildUOMQty'
      Origin = 'tblsmartorderlines.ToBuildUOMQty'
      OnSetText = FeldSetTextDontAllowNulls
    end
    object tblDetailsWastagePercentage: TFloatField
      DisplayLabel = 'Wastage~Percentage'
      DisplayWidth = 10
      FieldName = 'WastagePercentage'
    end
    object tblDetailsCusJobPrintName: TWideStringField
      DisplayLabel = 'Customer: / Job'
      DisplayWidth = 20
      FieldName = 'CusJobPrintName'
      Size = 255
    end
    object tblDetailsClassName: TWideStringField
      DisplayLabel = 'Department'
      DisplayWidth = 12
      FieldName = 'ClassName'
      Origin = 'tblsmartorderlines.ClassName'
      Size = 255
    end
    object tblDetailsconverted: TWideStringField
      DisplayLabel = 'Converted'
      DisplayWidth = 8
      FieldName = 'converted'
      Origin = 'tblsmartorderlines.converted'
      FixedChar = True
      Size = 1
    end
    object tblDetailsSupplierProductCode: TWideStringField
      DisplayLabel = 'Supplier Product Code'
      DisplayWidth = 20
      FieldName = 'SupplierProductCode'
      Origin = 'tblsmartorderlines.SupplierProductCode'
      Size = 50
    end
    object tblDetailssupplierProductname: TWideStringField
      DisplayLabel = 'Supplier Product Name'
      DisplayWidth = 20
      FieldName = 'supplierProductname'
      Origin = 'tblsmartorderlines.supplierProductname'
      Size = 50
    end
    object tblDetailsPrintedValue: TFloatField
      DisplayLabel = 'Printed Value'
      DisplayWidth = 10
      FieldName = 'PrintedValue'
      Origin = 'tblsmartorderlines.PrintedValue'
    end
    object tblDetailsLineNotes: TWideMemoField
      DisplayLabel = 'Line Notes'
      DisplayWidth = 20
      FieldName = 'LineNotes'
      BlobType = ftWideMemo
    end
    object tblDetailsGeneralNotes: TWideMemoField
      DisplayLabel = 'Product General Notes'
      DisplayWidth = 20
      FieldName = 'GeneralNotes'
      BlobType = ftWideMemo
    end
    object tblDetailsProductPrintName: TWideStringField
      DisplayLabel = 'Product Print Name'
      DisplayWidth = 17
      FieldName = 'ProductPrintName'
      Visible = False
      Size = 255
    end
    object tblDetailsSupplierName: TWideStringField
      DisplayLabel = 'Supplier Name'
      DisplayWidth = 20
      FieldName = 'SupplierName'
      Origin = 'tblsmartorderlines.SupplierName'
      Visible = False
      Size = 255
    end
    object tblDetailsTotalUOMqty: TFloatField
      DisplayLabel = 'Total'
      DisplayWidth = 10
      FieldName = 'TotalUOMqty'
      Origin = 'tblsmartorderlines.TotalUOMqty'
      Visible = False
    end
    object tblDetailsCusJobName: TWideStringField
      DisplayLabel = 'Customer: / Job'
      DisplayWidth = 19
      FieldName = 'CusJobName'
      Origin = 'tblsmartorderlines.CusJobName'
      Visible = False
      Size = 255
    end
    object tblDetailsSupplierContact: TWideStringField
      DisplayLabel = 'Supplier Contact'
      DisplayWidth = 20
      FieldName = 'SupplierContact'
      Origin = 'tblsmartorderlines.SupplierContact'
      Visible = False
      Size = 255
    end
    object tblDetailsDocketNumber: TWideStringField
      DisplayLabel = 'Docket Number'
      DisplayWidth = 20
      FieldName = 'DocketNumber'
      Origin = 'tblsmartorderlines.DocketNumber'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomField3: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField3'
      Origin = 'tblsmartorderlines.CustomField3'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomField1: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField1'
      Origin = 'tblsmartorderlines.CustomField1'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomField2: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField2'
      Origin = 'tblsmartorderlines.CustomField2'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomField4: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField4'
      Origin = 'tblsmartorderlines.CustomField4'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomField5: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField5'
      Origin = 'tblsmartorderlines.CustomField5'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomField6: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField6'
      Origin = 'tblsmartorderlines.CustomField6'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomField7: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField7'
      Origin = 'tblsmartorderlines.CustomField7'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomField8: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField8'
      Origin = 'tblsmartorderlines.CustomField8'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomField9: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField9'
      Origin = 'tblsmartorderlines.CustomField9'
      Visible = False
      Size = 255
    end
    object tblDetailsCustomField10: TWideStringCustField
      DisplayWidth = 20
      FieldName = 'CustomField10'
      Origin = 'tblsmartorderlines.CustomField10'
      Visible = False
      Size = 255
    end
    object tblDetailsEquipmentName: TWideStringField
      DisplayLabel = 'Equipment Name'
      DisplayWidth = 19
      FieldName = 'EquipmentName'
      Origin = 'tblsmartorderlines.EquipmentName'
      Visible = False
      Size = 100
    end
    object tblDetailsWeight4Qty: TFloatField
      DisplayLabel = 'Total Weight'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'Weight4Qty'
      ReadOnly = True
      Visible = False
      Calculated = True
    end
    object tblDetailsvolume4Qty: TFloatField
      DisplayLabel = 'Total Volume'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'volume4Qty'
      ReadOnly = True
      Visible = False
      Calculated = True
    end
    object tblDetailsUnitVolume: TFloatField
      DisplayLabel = 'Volume'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'UnitVolume'
      ReadOnly = True
      Visible = False
      Calculated = True
    end
    object tblDetailsHeight: TFloatField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Height'
      LookupDataSet = QryUOMLookUp
      LookupKeyFields = 'UnitID'
      LookupResultField = 'height'
      KeyFields = 'UnitOfMeasureID'
      ReadOnly = True
      Visible = False
      Lookup = True
    end
    object tblDetailswidth: TFloatField
      DisplayLabel = 'Width'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'width'
      LookupDataSet = QryUOMLookUp
      LookupKeyFields = 'UnitID'
      LookupResultField = 'width'
      KeyFields = 'UnitOfMeasureID'
      ReadOnly = True
      Visible = False
      Lookup = True
    end
    object tblDetailsLength: TFloatField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Length'
      LookupDataSet = QryUOMLookUp
      LookupKeyFields = 'UnitID'
      LookupResultField = 'Length'
      KeyFields = 'UnitOfMeasureID'
      ReadOnly = True
      Visible = False
      Lookup = True
    end
    object tblDetailsWeight: TFloatField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Weight'
      LookupDataSet = QryUOMLookUp
      LookupKeyFields = 'UnitID'
      LookupResultField = 'Weight'
      KeyFields = 'UnitOfMeasureID'
      ReadOnly = True
      Visible = False
      Lookup = True
    end
    object tblDetailsRepairId: TIntegerField
      DisplayLabel = 'Repair #'
      DisplayWidth = 10
      FieldName = 'RepairId'
      Origin = 'tblsmartorderlines.RepairId'
      Visible = False
    end
    object tblDetailsProcTreeId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProcTreeId'
      Origin = 'tblsmartorderlines.ProcTreeId'
      Visible = False
    end
    object tblDetailsPartBarCode: TWideStringField
      DisplayLabel = 'Barcode'
      DisplayWidth = 20
      FieldName = 'PartBarCode'
      Origin = 'tblsmartorderlines.PartBarCode'
      Visible = False
      Size = 255
    end
    object tblDetailsFormulaQtyValue1: TFloatField
      DisplayWidth = 14
      FieldName = 'FormulaQtyValue1'
      Origin = 'tblsmartorderlines.FormulaQtyValue1'
      Visible = False
    end
    object tblDetailsFormulaQtyValue2: TFloatField
      DisplayWidth = 14
      FieldName = 'FormulaQtyValue2'
      Origin = 'tblsmartorderlines.FormulaQtyValue2'
      Visible = False
    end
    object tblDetailsFormulaQtyValue3: TFloatField
      DisplayWidth = 14
      FieldName = 'FormulaQtyValue3'
      Origin = 'tblsmartorderlines.FormulaQtyValue3'
      Visible = False
    end
    object tblDetailsFormulaQtyValue4: TFloatField
      DisplayWidth = 14
      FieldName = 'FormulaQtyValue4'
      Origin = 'tblsmartorderlines.FormulaQtyValue4'
      Visible = False
    end
    object tblDetailsFormulaQtyValue5: TFloatField
      DisplayWidth = 14
      FieldName = 'FormulaQtyValue5'
      Origin = 'tblsmartorderlines.FormulaQtyValue5'
      Visible = False
    end
    object tblDetailsFormulaQtyValue: TFloatField
      DisplayWidth = 13
      FieldName = 'FormulaQtyValue'
      Origin = 'tblsmartorderlines.FormulaQtyValue'
      Visible = False
    end
    object tblDetailsTotalCostEx: TFloatField
      DisplayLabel = 'Total Cost(Ex)'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TotalCostEx'
      Visible = False
      currency = True
      Calculated = True
    end
    object tblDetailsMultiBuy: TWideStringField
      DisplayWidth = 1
      FieldName = 'MultiBuy'
      ReadOnly = True
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsVolume: TFloatField
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Volume'
      LookupDataSet = QryUOMLookUp
      LookupKeyFields = 'UnitID'
      LookupResultField = 'Volume'
      KeyFields = 'UnitOfMeasureID'
      ReadOnly = True
      Visible = False
      Lookup = True
    end
    object tblDetailsSaleLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SaleLineID'
      Origin = 'tblsmartorderlines.SaleLineID'
      Visible = False
    end
    object tblDetailsDeleted: TWideStringField
      DisplayWidth = 1
      FieldName = 'Deleted'
      Origin = 'tblsmartorderlines.Deleted'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsCostEx: TFloatField
      FieldName = 'CostEx'
      Origin = 'tblsmartorderlines.CostEx'
      Visible = False
      OnChange = tblDetailsCostExChange
      OnSetText = FeldSetTextDontAllowNulls
      currency = True
    end
    object tblDetailsQty: TFloatField
      DisplayWidth = 5
      FieldName = 'Qty'
      Origin = 'tblsmartorderlines.Qty'
      Visible = False
    end
    object tblDetailsPARTSID: TIntegerField
      DisplayLabel = 'Product ID'
      DisplayWidth = 20
      FieldName = 'PARTSID'
      Origin = 'tblsmartorderlines.PARTSID'
      Visible = False
      OnChange = tblDetailsPARTSIDChange
    end
    object tblDetailsSearchFilter: TWideStringField
      FieldName = 'SearchFilter'
      Origin = 'tblsmartorderlines.SearchFilter'
      Visible = False
      Size = 255
    end
    object tblDetailsClassID: TIntegerField
      DisplayWidth = 12
      FieldName = 'ClassID'
      Origin = 'tblsmartorderlines.ClassID'
      Visible = False
    end
    object tblDetailsSupplierID: TIntegerField
      DisplayLabel = 'Preferred Supplier ID'
      DisplayWidth = 18
      FieldName = 'SupplierID'
      Origin = 'tblsmartorderlines.SupplierID'
      Visible = False
    end
    object tblDetailsLinePrice: TFloatField
      DisplayWidth = 10
      FieldName = 'LinePrice'
      Origin = 'tblsmartorderlines.LinePrice'
      Visible = False
    end
    object tblDetailsSmartOrderLinesID: TAutoIncField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'SmartOrderLinesID'
      Origin = 'tblsmartorderlines.SmartOrderLinesID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsSmartOrderID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SmartOrderID'
      Origin = 'tblsmartorderlines.SmartOrderID'
      Visible = False
    end
    object tblDetailsEditedFlag: TWideStringField
      DisplayWidth = 1
      FieldName = 'EditedFlag'
      Origin = 'tblsmartorderlines.EditedFlag'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsGroupID: TIntegerField
      DisplayWidth = 10
      FieldName = 'GroupID'
      Origin = 'tblsmartorderlines.GroupID'
      Visible = False
    end
    object tblDetailsGroupLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'GroupLineID'
      Origin = 'tblsmartorderlines.GroupLineID'
      Visible = False
    end
    object tblDetailsGroupheader: TWideStringField
      DisplayWidth = 1
      FieldName = 'Groupheader'
      Origin = 'tblsmartorderlines.Groupheader'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tblDetailsLineTaxRate: TFloatField
      DisplayWidth = 10
      FieldName = 'LineTaxRate'
      Origin = 'tblsmartorderlines.LineTaxRate'
      Visible = False
    end
    object tblDetailsGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblsmartorderlines.GlobalRef'
      Visible = False
      Size = 255
    end
    object tblDetailsUnitofMeasureMultiplier: TFloatField
      FieldName = 'UnitofMeasureMultiplier'
      Origin = 'tblsmartorderlines.UnitofMeasureMultiplier'
      Visible = False
    end
    object tblDetailsCustPONumber: TWideStringField
      FieldName = 'CustPONumber'
      Origin = 'tblsmartorderlines.CustPONumber'
      Visible = False
      Size = 30
    end
    object tblDetailsSearchFilterCopy: TWideStringField
      FieldName = 'SearchFilterCopy'
      Origin = 'tblsmartorderlines.SearchFilterCopy'
      Visible = False
      Size = 255
    end
    object tblDetailsPurchaseOrderId: TIntegerField
      FieldName = 'PurchaseOrderId'
      Origin = 'tblsmartorderlines.PurchaseOrderId'
      Visible = False
    end
    object tblDetailsPurchaseLineId: TIntegerField
      FieldName = 'PurchaseLineId'
      Origin = 'tblsmartorderlines.PurchaseLineId'
      Visible = False
    end
    object tblDetailsUnitOfMeasureID: TIntegerField
      FieldName = 'UnitOfMeasureID'
      Origin = 'tblsmartorderlines.UnitOfMeasureID'
      Visible = False
    end
    object tblDetailsCusJobID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CusJobID'
      Origin = 'tblsmartorderlines.CusJobID'
      Visible = False
    end
    object tblDetailsCustomerEquipmentID: TIntegerField
      DisplayWidth = 10
      FieldName = 'CustomerEquipmentID'
      Origin = 'tblsmartorderlines.CustomerEquipmentID'
      Visible = False
    end
    object tblDetailsTotalQty: TFloatField
      DisplayWidth = 10
      FieldName = 'TotalQty'
      Origin = 'tblsmartorderlines.TotalQty'
      Visible = False
    end
    object tblDetailsTobuildQty: TFloatField
      DisplayWidth = 10
      FieldName = 'TobuildQty'
      Origin = 'tblsmartorderlines.TobuildQty'
      Visible = False
    end
  end
  object tblMergeSmartOrderLines: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblsmartorderlines'
      'Where SmartOrderID = :ID;')
    Filtered = True
    Left = 423
    Top = 326
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
  object tblShippingMethods: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblshippingmethods')
    Left = 468
    Top = 326
    object tblShippingMethodsShippingMethodID: TAutoIncField
      FieldName = 'ShippingMethodID'
      ReadOnly = True
    end
    object tblShippingMethodsShippingMethod: TWideStringField
      FieldName = 'ShippingMethod'
      FixedChar = True
    end
    object tblShippingMethodsActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object tblShippingMethodsEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
  end
  object tblterms: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'From tblterms')
    Left = 735
    Top = 326
    object tbltermsTermsID: TAutoIncField
      FieldName = 'TermsID'
      ReadOnly = True
    end
    object tbltermsTerms: TWideStringField
      FieldName = 'Terms'
      FixedChar = True
      Size = 50
    end
  end
  object qryUnitOfMeasure: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      '/*SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, heig' +
        'ht, width, length, volume, weight'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND (ifnull(U.PartID,0) = :xPartID or U.Pa' +
        'rtID = 0) '
      'Group By U.UnitName Desc'
      'Order By UnitID desc ,U.UnitName'
      '*/'
      'SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, heig' +
        'ht, width, length, volume, weight'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = :xPartID'
      'union all '
      'SELECT  '
      'U.UnitID,'
      
        'U.UnitName, U.Multiplier, U.UnitDescription,U.BaseUnitName, heig' +
        'ht, width, length, volume, weight'
      'FROM tblunitsofmeasure U'
      
        'WHERE U.ACTIVE = '#39'T'#39'  AND ifnull(U.PartID,0) = 0 and Unitname no' +
        't  in (Select unitname from  tblunitsofmeasure where  ifnull(Par' +
        'tID,0) = :xPartID  )'
      'Order By UnitID desc ,UnitName;')
    Left = 290
    Top = 326
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end
      item
        DataType = ftUnknown
        Name = 'xPartID'
      end>
    object qryUnitOfMeasureUnitName: TWideStringField
      DisplayWidth = 15
      FieldName = 'UnitName'
      Origin = 'tblunitsofmeasure.UnitName'
      Size = 15
    end
    object qryUnitOfMeasureUnitDescription: TWideStringField
      DisplayWidth = 12
      FieldName = 'UnitDescription'
      Origin = 'tblunitsofmeasure.UnitDescription'
      Size = 35
    end
    object qryUnitOfMeasureMultiplier: TFloatField
      DisplayWidth = 10
      FieldName = 'Multiplier'
      Origin = 'tblunitsofmeasure.Multiplier'
    end
    object qryUnitOfMeasureheight: TFloatField
      DisplayWidth = 10
      FieldName = 'height'
      Origin = 'tblunitsofmeasure.height'
    end
    object qryUnitOfMeasurewidth: TFloatField
      DisplayWidth = 10
      FieldName = 'width'
      Origin = 'tblunitsofmeasure.width'
    end
    object qryUnitOfMeasurelength: TFloatField
      DisplayWidth = 10
      FieldName = 'length'
      Origin = 'tblunitsofmeasure.length'
    end
    object qryUnitOfMeasurevolume: TFloatField
      DisplayWidth = 10
      FieldName = 'volume'
      Origin = 'tblunitsofmeasure.volume'
    end
    object qryUnitOfMeasureweight: TFloatField
      DisplayWidth = 10
      FieldName = 'weight'
      Origin = 'tblunitsofmeasure.weight'
    end
    object qryUnitOfMeasureUnitID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UnitID'
      Origin = 'tblunitsofmeasure.UnitID'
      Visible = False
    end
  end
  object cboClassQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT tblClass.ClassID, tblClass.ClassName '
      'FROM tblClass '
      
        'WHERE (((tblClass.ClassName) Is Not Null) And ((tblClass.Active)' +
        '<>'#39'F'#39')) '
      'ORDER BY tblClass.ClassName; ')
    Options.LongStrings = False
    Left = 690
    Top = 326
  end
  object cboProductQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT '
      'Left(SUBSTRING_INDEX(P.ProductGroup,'#39'^'#39',1),255) AS Manuf  , '
      
        'Left(substring(substring_index(P.ProductGroup,'#39'^'#39',2),char_length' +
        '(substring_index(P.ProductGroup,'#39'^'#39',1))+2),255) AS Type  ,'
      
        'Left(substring(substring_index(P.ProductGroup,'#39'^'#39',3),char_length' +
        '(substring_index(P.ProductGroup,'#39'^'#39',2))+2),255) AS Dept  ,'
      'P.PARTSID as PARTSID,'
      'P.PARTTYPE as PARTTYPE,'
      'P.PRODUCTGROUP as PRODUCTGROUP,'
      'P.PARTNAME as PARTNAME,'
      'convert(P.PARTSDESCRIPTION, char(255)) as PARTSDESCRIPTION,'
      'P.INCOMEACCNT as INCOMEACCNT,'
      'convert(P.PurchaseDesc, char(255)) as PurchaseDesc,'
      'P.ASSETACCNT as ASSETACCNT,'
      'P.COGSACCNT as COGSACCNT,'
      'P.BARCODE as BARCODE,'
      'P.PRODUCTCODE as PRODUCTCODE,'
      'P.PURCHTAXCODE as PURCHTAXCODE,'
      'P.PREFEREDSUPP as PREFEREDSUPP,'
      'P.Batch as Batch,'
      'P.SpecialDiscount as SpecialDiscount,'
      'P.SNTracking as SNTracking,'
      'P.BuyQTY1 as BuyQTY1,'
      'P.BuyQTY2 as BuyQTY2,'
      'P.BuyQTY3 as BuyQTY3,'
      'P.COST1 as COST1,'
      'P.COST2 as COST2,'
      'P.COST3 as COST3,'
      'P.SellQTY1 as SellQTY1,'
      'P.SellQTY2 as SellQTY2,'
      'P.SellQTY3 as SellQTY3,'
      'P.PRICE1 as PRICE1,'
      'P.PRICE2 as PRICE2,'
      'P.PRICE3 as PRICE3,'
      'P.WHOLESALEPRICE as WHOLESALEPRICE,'
      'P.Active as Active,'
      'P.EditedFlag as EditedFlag,'
      'P.MultipleBins as MultipleBins,'
      'P.AvgCost as AvgCost,'
      'P.Discontinued as Discontinued,'
      'P.Attrib1Purchase as Attrib1Purchase,'
      'P.Attrib2Purchase as Attrib2Purchase,'
      'P.Attrib1PurchaseRate as Attrib1PurchaseRate,'
      
        'if (ifnull(LatestCost ,0) = 0 , cost1, LatestCost ) as LatestCos' +
        'tPrice ,'
      'P.taxcode as TaxCode,'
      'p.LatestCost as LatestCost,'
      'p.AutoBatch as AutoBatch, '
      'p.Attrib1Sale as Attrib1Sale,'
      'p.Attrib2Sale as Attrib2Sale,'
      'p.Attrib1SaleRate as Attrib1SaleRate,'
      'P.LatestCostDate as LatestCostDate,'
      'SupplierProductCode,'
      'P.Multibuy,'
      'P.GeneralNotes,'
      'P.CUSTFLD1,'
      'P.CUSTFLD2,'
      'P.CUSTFLD3,'
      'P.CUSTFLD4,'
      'P.CUSTFLD5,'
      'P.CUSTFLD6,'
      'P.CUSTFLD7,'
      'P.CUSTFLD8,'
      'P.CUSTFLD9,'
      'P.CUSTFLD10,'
      'P.CUSTFLD11,'
      'P.CUSTFLD12,'
      'P.CUSTFLD13,'
      'P.CUSTFLD14,'
      'P.CUSTFLD15,'
      'P.CUSTDATE1,'
      'P.CUSTDATE2,'
      'P.CUSTDATE3'
      'FROM tblParts P'
      'where ExcludeFromSmartOrder = "F"')
    Options.LongStrings = False
    Left = 156
    Top = 326
    object cboProductQryManuf: TWideStringField
      FieldName = 'Manuf'
      Size = 255
    end
    object cboProductQryType: TWideStringField
      FieldName = 'Type'
      Size = 255
    end
    object cboProductQryDept: TWideStringField
      FieldName = 'Dept'
      Size = 255
    end
    object cboProductQryPARTSID: TIntegerField
      FieldName = 'PARTSID'
    end
    object cboProductQryPARTTYPE: TWideStringField
      FieldName = 'PARTTYPE'
      Size = 13
    end
    object cboProductQryPRODUCTGROUP: TWideStringField
      FieldName = 'PRODUCTGROUP'
      Size = 255
    end
    object cboProductQryPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Size = 60
    end
    object cboProductQryPARTSDESCRIPTION: TWideStringField
      FieldName = 'PARTSDESCRIPTION'
      Size = 255
    end
    object cboProductQryINCOMEACCNT: TWideStringField
      FieldName = 'INCOMEACCNT'
      Size = 50
    end
    object cboProductQryPurchaseDesc: TWideStringField
      FieldName = 'PurchaseDesc'
      Size = 255
    end
    object cboProductQryASSETACCNT: TWideStringField
      FieldName = 'ASSETACCNT'
      Size = 50
    end
    object cboProductQryCOGSACCNT: TWideStringField
      FieldName = 'COGSACCNT'
      Size = 50
    end
    object cboProductQryBARCODE: TWideStringField
      FieldName = 'BARCODE'
      Size = 35
    end
    object cboProductQryPRODUCTCODE: TWideStringField
      FieldName = 'PRODUCTCODE'
      Size = 255
    end
    object cboProductQryPURCHTAXCODE: TWideStringField
      FieldName = 'PURCHTAXCODE'
      Size = 15
    end
    object cboProductQryPREFEREDSUPP: TWideStringField
      FieldName = 'PREFEREDSUPP'
      Size = 55
    end
    object cboProductQryBatch: TWideStringField
      FieldName = 'Batch'
      FixedChar = True
      Size = 1
    end
    object cboProductQrySpecialDiscount: TWideStringField
      FieldName = 'SpecialDiscount'
      FixedChar = True
      Size = 1
    end
    object cboProductQrySNTracking: TWideStringField
      FieldName = 'SNTracking'
      FixedChar = True
      Size = 1
    end
    object cboProductQryBuyQTY1: TIntegerField
      FieldName = 'BuyQTY1'
    end
    object cboProductQryBuyQTY2: TIntegerField
      FieldName = 'BuyQTY2'
    end
    object cboProductQryBuyQTY3: TIntegerField
      FieldName = 'BuyQTY3'
    end
    object cboProductQryCOST1: TFloatField
      FieldName = 'COST1'
    end
    object cboProductQryCOST2: TFloatField
      FieldName = 'COST2'
    end
    object cboProductQryCOST3: TFloatField
      FieldName = 'COST3'
    end
    object cboProductQrySellQTY1: TIntegerField
      FieldName = 'SellQTY1'
    end
    object cboProductQrySellQTY2: TIntegerField
      FieldName = 'SellQTY2'
    end
    object cboProductQrySellQTY3: TIntegerField
      FieldName = 'SellQTY3'
    end
    object cboProductQryPRICE1: TFloatField
      FieldName = 'PRICE1'
    end
    object cboProductQryPRICE2: TFloatField
      FieldName = 'PRICE2'
    end
    object cboProductQryPRICE3: TFloatField
      FieldName = 'PRICE3'
    end
    object cboProductQryWHOLESALEPRICE: TFloatField
      FieldName = 'WHOLESALEPRICE'
    end
    object cboProductQryActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object cboProductQryEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object cboProductQryMultipleBins: TWideStringField
      FieldName = 'MultipleBins'
      FixedChar = True
      Size = 1
    end
    object cboProductQryAvgCost: TFloatField
      FieldName = 'AvgCost'
    end
    object cboProductQryDiscontinued: TWideStringField
      FieldName = 'Discontinued'
      FixedChar = True
      Size = 1
    end
    object cboProductQryAttrib1Purchase: TFloatField
      FieldName = 'Attrib1Purchase'
    end
    object cboProductQryAttrib2Purchase: TFloatField
      FieldName = 'Attrib2Purchase'
    end
    object cboProductQryAttrib1PurchaseRate: TFloatField
      FieldName = 'Attrib1PurchaseRate'
    end
    object cboProductQryLatestCostPrice: TFloatField
      FieldName = 'LatestCostPrice'
    end
    object cboProductQryTaxCode: TWideStringField
      FieldName = 'TaxCode'
      Size = 15
    end
    object cboProductQryLatestCost: TFloatField
      FieldName = 'LatestCost'
    end
    object cboProductQryAutoBatch: TWideStringField
      FieldName = 'AutoBatch'
      FixedChar = True
      Size = 1
    end
    object cboProductQryAttrib1Sale: TFloatField
      FieldName = 'Attrib1Sale'
    end
    object cboProductQryAttrib2Sale: TFloatField
      FieldName = 'Attrib2Sale'
    end
    object cboProductQryAttrib1SaleRate: TFloatField
      FieldName = 'Attrib1SaleRate'
    end
    object cboProductQryLatestCostDate: TDateField
      FieldName = 'LatestCostDate'
    end
    object cboProductQrySupplierProductCode: TWideStringField
      FieldName = 'SupplierProductCode'
      Size = 50
    end
    object cboProductQryCUSTFLD1: TWideStringField
      FieldName = 'CUSTFLD1'
      Size = 255
    end
    object cboProductQryCUSTFLD2: TWideStringField
      FieldName = 'CUSTFLD2'
      Size = 255
    end
    object cboProductQryCUSTFLD3: TWideStringField
      FieldName = 'CUSTFLD3'
      Size = 255
    end
    object cboProductQryCUSTFLD4: TWideStringField
      FieldName = 'CUSTFLD4'
      Size = 255
    end
    object cboProductQryCUSTFLD5: TWideStringField
      FieldName = 'CUSTFLD5'
      Size = 255
    end
    object cboProductQryCUSTFLD6: TWideStringField
      FieldName = 'CUSTFLD6'
      Size = 255
    end
    object cboProductQryCUSTFLD7: TWideStringField
      FieldName = 'CUSTFLD7'
      Size = 255
    end
    object cboProductQryCUSTFLD8: TWideStringField
      FieldName = 'CUSTFLD8'
      Size = 255
    end
    object cboProductQryCUSTFLD9: TWideStringField
      FieldName = 'CUSTFLD9'
      Size = 255
    end
    object cboProductQryCUSTFLD10: TWideStringField
      FieldName = 'CUSTFLD10'
      Size = 255
    end
    object cboProductQryCUSTFLD11: TWideStringField
      FieldName = 'CUSTFLD11'
      Size = 255
    end
    object cboProductQryCUSTFLD12: TWideStringField
      FieldName = 'CUSTFLD12'
      Size = 255
    end
    object cboProductQryCUSTFLD13: TWideStringField
      FieldName = 'CUSTFLD13'
      Size = 255
    end
    object cboProductQryCUSTFLD14: TWideStringField
      FieldName = 'CUSTFLD14'
      Size = 255
    end
    object cboProductQryCUSTFLD15: TWideStringField
      FieldName = 'CUSTFLD15'
      Size = 255
    end
    object cboProductQryCUSTDATE1: TDateTimeField
      FieldName = 'CUSTDATE1'
    end
    object cboProductQryCUSTDATE2: TDateTimeField
      FieldName = 'CUSTDATE2'
    end
    object cboProductQryCUSTDATE3: TDateTimeField
      FieldName = 'CUSTDATE3'
    end
    object cboProductQryGeneralNotes: TWideMemoField
      FieldName = 'GeneralNotes'
      BlobType = ftWideMemo
    end
    object cboProductQryMultibuy: TWideStringField
      DisplayLabel = 'Multi Buy'
      FieldName = 'Multibuy'
      FixedChar = True
      Size = 1
    end
  end
  object cboAccountQry: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT AccountID, AccountName, AccountType, Description, Account' +
        'Number, Taxcode, BankNumber, Extra, Active, EditedFlag, Class, A' +
        'llClasses, OpeningBalance, Debits, Credits, ClosingBalance, Acco' +
        'untGroup  '
      'FROM tblchartofaccounts'
      'WHERE AccountType = '#39'AP'#39' AND Active = '#39'T'#39' AND IsHeader = '#39'F'#39';')
    Options.LongStrings = False
    Left = 201
    Top = 326
  end
  object qryClient: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT ClientID, Company, Street, Street2, Suburb, State, PostCo' +
        'de,'
      
        'ShippingID, TermsID, ShipTime, ForeignExchangeSellCode, cc.BuyRa' +
        'te'
      'FROM tblclients c'
      
        'LEFT JOIN tblcurrencyconversion cc ON c.ForeignExchangeSellCode ' +
        '= cc.Code'
      'WHERE (c.Active = '#39'T'#39') AND (Supplier = '#39'T'#39')'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (c.Company LIKE Concat(:SearchValue,"%' +
        '")))'
      
        'or ((:SearchMode = 2) and (c.Company LIKE Concat("%",:SearchValu' +
        'e,"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY Company')
    Options.LongStrings = False
    Left = 379
    Top = 326
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
  object qryClientLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ClientID,Company,JobName, DefaultClass '
      'FROM tblclients'
      'WHERE NOT IsNull(tblclients.Company) AND'
      'tblclients.Active <>'#39'F'#39' And tblclients.Customer = '#39'T'#39
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (Company LIKE Concat(:SearchValue,"%")' +
        '))'
      
        'or ((:SearchMode = 2) and (Company LIKE Concat("%",:SearchValue,' +
        '"%"))))'
      'and IfNull(:SearchValue,"") <> ""'
      'ORDER BY tblclients.Company')
    Options.LongStrings = False
    Left = 245
    Top = 326
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
  object tblCompany: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select SetupID,CompanyName,Address,Address2,City,State,Postcode,' +
        'Country '
      'From tblcompanyinformation')
    Options.LongStrings = False
    Left = 112
    Top = 326
    object tblCompanySetupID: TIntegerField
      FieldName = 'SetupID'
    end
    object tblCompanyCompanyName: TWideStringField
      FieldName = 'CompanyName'
      Size = 200
    end
    object tblCompanyAddress: TWideStringField
      FieldName = 'Address'
      Size = 255
    end
    object tblCompanyAddress2: TWideStringField
      FieldName = 'Address2'
      Size = 255
    end
    object tblCompanyCity: TWideStringField
      FieldName = 'City'
      Size = 255
    end
    object tblCompanyState: TWideStringField
      FieldName = 'State'
      Size = 255
    end
    object tblCompanyPostcode: TWideStringField
      FieldName = 'Postcode'
      Size = 255
    end
    object tblCompanyCountry: TWideStringField
      FieldName = 'Country'
      Size = 255
    end
  end
  object qryrepairequip: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      '`RE`.`CustomerEquipmentID`,'
      '`E`.`EquipmentName`,'
      '`RE`.`RepairID`,'
      '`CE`.`Serialno`,'
      '`CE`.`Manufacture`,'
      '`CE`.`model`,'
      '`CE`.`Registration`,'
      '`CE`.`WarantyPeriod`,'
      '`CE`.`WarantyFinishDate`,'
      '`CE`.`Quantity`,'
      '`CE`.`ClientID`'
      ''
      'FROM'
      '`tblEquipmentxRef` AS `RE`'
      
        'Inner Join `tblcustomerequip` AS `CE` ON `RE`.`CustomerEquipment' +
        'ID` = `CE`.`id`'
      
        'Inner Join `tblequipment` AS `E` ON `CE`.`EquipmentID` = `E`.`Eq' +
        'uipmentID`'
      
        'Where (RE.RepairID= :ID or :RepairID=0) and (CE.ClientID=:Client' +
        'ID or :xClientID= 0)')
    Left = 601
    Top = 326
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'RepairID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ClientID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'xClientID'
        Value = 0
      end>
    object qryrepairequipEquipmentName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'EquipmentName'
      Size = 50
    end
    object qryrepairequipRepairID: TIntegerField
      DisplayLabel = 'Repair#'
      DisplayWidth = 10
      FieldName = 'RepairID'
    end
    object qryrepairequipSerialno: TWideStringField
      DisplayLabel = 'Serial#'
      DisplayWidth = 1
      FieldName = 'Serialno'
      Size = 100
    end
    object qryrepairequipQuantity: TFloatField
      DisplayWidth = 1
      FieldName = 'Quantity'
    end
    object qryrepairequipManufacture: TWideStringField
      DisplayWidth = 1
      FieldName = 'Manufacture'
      Size = 100
    end
    object qryrepairequipmodel: TWideStringField
      DisplayLabel = 'Model'
      DisplayWidth = 1
      FieldName = 'model'
      Size = 100
    end
    object qryrepairequipRegistration: TWideStringField
      DisplayWidth = 1
      FieldName = 'Registration'
      Size = 100
    end
    object qryrepairequipWarantyFinishDate: TDateTimeField
      DisplayLabel = 'Warranty Finish'
      DisplayWidth = 1
      FieldName = 'WarantyFinishDate'
    end
    object qryrepairequipWarantyPeriod: TFloatField
      DisplayLabel = 'Warranty Period'
      DisplayWidth = 1
      FieldName = 'WarantyPeriod'
    end
    object qryrepairequipCustomerEquipmentID: TIntegerField
      FieldName = 'CustomerEquipmentID'
      Visible = False
    end
    object qryrepairequipClientID: TIntegerField
      FieldName = 'ClientID'
      Visible = False
    end
  end
  object ActionList: TActionList
    Left = 67
    Top = 287
    object actSelectRecord: TDNMAction
      Category = 'DNMAction'
      Caption = 'Select Record'
      HelpContext = 500051
      OnExecute = actSelectRecordExecute
      OnUpdate = actSelectRecordUpdate
      buttoncolor = clWhite
    end
    object actSummary: TDNMAction
      Category = 'DNMAction'
      Caption = 'Summary'
      HelpContext = 500052
      OnExecute = actSummaryExecute
      OnUpdate = actSummaryUpdate
      buttoncolor = clWhite
    end
  end
  object QryUOMLookUp: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT  '
      'U.UnitID,'
      ' height, width, length, volume, weight'
      'FROM tblunitsofmeasure U')
    Left = 334
    Top = 326
    object FloatField2: TFloatField
      DisplayWidth = 10
      FieldName = 'height'
      Origin = 'U.height'
    end
    object FloatField3: TFloatField
      DisplayWidth = 10
      FieldName = 'width'
      Origin = 'U.width'
    end
    object FloatField4: TFloatField
      DisplayWidth = 10
      FieldName = 'length'
      Origin = 'U.length'
    end
    object FloatField5: TFloatField
      DisplayWidth = 10
      FieldName = 'volume'
      Origin = 'U.volume'
    end
    object FloatField6: TFloatField
      DisplayWidth = 10
      FieldName = 'weight'
      Origin = 'U.weight'
    end
    object IntegerField1: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'UnitID'
      Origin = 'U.UnitID'
      Visible = False
    end
  end
  object QtyProductAvailableQty: TERPQuery
    Connection = MyConnection
    Left = 512
    Top = 326
  end
  object QtyProductOnOrderQty: TERPQuery
    Connection = MyConnection
    Left = 512
    Top = 326
  end
  object PopOptions: TAdvPopupMenu
    MenuStyler = datGUIStylers.MainMenuStyler
    Version = '2.5.3.4'
    Left = 690
    Top = 288
    object mnuAuditTrial: TMenuItem
      Caption = 'Audit Trail'
      HelpContext = 500053
      OnClick = mnuAuditTrialClick
    end
    object mnuPOs: TMenuItem
      Caption = 'Purchase Orders'
      HelpContext = 500082
      OnClick = mnuPOsClick
    end
  end
  object QryAreaCodes: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select AreaCode, AreaName from tblAreaCodes where active ="T" or' +
        'der by Areacode')
    Left = 646
    Top = 326
    object QryAreaCodesAreaCode: TWideStringField
      DisplayLabel = 'Code'
      DisplayWidth = 10
      FieldName = 'AreaCode'
      Size = 50
    end
    object QryAreaCodesAreaName: TWideStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'AreaName'
      Size = 100
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'pdf'
    Filter = 'PDF (*.PDF)|*.PDF|All Files (*.*)|*.*'
    Left = 335
    Top = 287
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
    Left = 944
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
  object qryDefaultSupplier: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select Company, ClientId, PrintName FROM tblclients C1'
      'WHERE C1.Active = "T"'
      'AND C1.Supplier = "T"'
      'and (((:SearchMode = 0) or IsNull(:SearchMode))'
      
        'or ((:SearchMode = 1) and (Company LIKE Concat(:SearchValue,"%")' +
        '))'
      
        'or ((:SearchMode = 2) and (Company LIKE Concat("%",:SearchValue,' +
        '"%"))))'
      'and IfNull(:SearchValue,"") <> ""')
    Left = 706
    Top = 112
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
    object qryDefaultSupplierPrintName: TWideStringField
      DisplayLabel = 'Display Name'
      DisplayWidth = 25
      FieldName = 'PrintName'
      Size = 255
    end
    object qryClientLookupCompany: TWideStringField
      DisplayLabel = 'Supplier ID'
      DisplayWidth = 25
      FieldName = 'Company'
      Origin = 'C1.Company'
      Size = 80
    end
    object qryClientLookupClientId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientId'
      Origin = 'C1.ClientID'
      Visible = False
    end
  end
end
