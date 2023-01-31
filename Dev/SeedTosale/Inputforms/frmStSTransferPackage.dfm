inherited fmStSTransferPackage: TfmStSTransferPackage
  Caption = 'Seed To Sale - Transfer Package'
  ClientHeight = 727
  ClientWidth = 970
  ExplicitWidth = 976
  ExplicitHeight = 756
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 684
    Width = 970
    ExplicitTop = 684
    ExplicitWidth = 964
  end
  inherited shapehint: TShape
    Left = 20
    ExplicitLeft = 20
  end
  inherited shapehintextra1: TShape
    Left = 88
    ExplicitLeft = 87
  end
  inherited pnlFooter: TDNMPanel
    Top = 684
    Width = 970
    ExplicitTop = 684
    ExplicitWidth = 997
    inherited btnCompleted: TDNMSpeedButton
      Left = 393
      Caption = '&Register'
      Enabled = False
      ModalResult = 1
      AutoDisableParentOnclick = False
      OnClick = btnCompletedClick
      ExplicitLeft = 393
    end
    inherited btnClose: TDNMSpeedButton
      Left = 497
      ModalResult = 2
      OnClick = btnCloseClick
      ExplicitLeft = 497
    end
  end
  inherited pnlHeader: TDNMPanel
    Width = 970
    ExplicitWidth = 997
    inherited pnlTitle: TDNMPanel
      Left = 198
      Width = 573
      ExplicitLeft = 198
      ExplicitWidth = 600
      inherited TitleShader: TShader
        Width = 571
        ExplicitWidth = 731
        inherited TitleLabel: TLabel
          Width = 571
          Caption = 'New Transfer'
          ExplicitWidth = 700
        end
      end
    end
    object chkDone: TDBCheckBox
      Left = 24
      Top = 21
      Width = 97
      Height = 17
      Caption = 'Finished'
      DataField = 'Completed'
      DataSource = dsTransfer
      ReadOnly = True
      TabOrder = 1
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
  end
  inherited pnlDetails: TDNMPanel
    Width = 970
    Height = 627
    ExplicitWidth = 997
    ExplicitHeight = 627
    object pnlDest: TDNMPanel
      Left = 1
      Top = 1
      Width = 968
      Height = 152
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 995
      object lbDestination: TLabel
        Left = 8
        Top = 22
        Width = 160
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Destination Department'
        FocusControl = lookupDestination
      end
      object lbRoute: TLabel
        Left = 8
        Top = 56
        Width = 160
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Planned Route'
        FocusControl = dbmmoRoute
        WordWrap = True
      end
      object lbTransferType: TLabel
        Left = 528
        Top = 22
        Width = 110
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Transfer Type'
        FocusControl = cbbTransferType
      end
      object lbEstDeparture: TLabel
        Left = 528
        Top = 77
        Width = 110
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Est. Departure'
        FocusControl = dbdtmEstDeparture
      end
      object lbEstArrival: TLabel
        Left = 528
        Top = 116
        Width = 110
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Est. Arrival'
        FocusControl = dbdtmEstArrival
      end
      object lookupDestination: TwwDBLookupCombo
        Left = 176
        Top = 19
        Width = 326
        Height = 23
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ClassName'#9'20'#9'ClassName'#9'F')
        DataField = 'DestDeptID'
        DataSource = dsTransfer
        LookupTable = qryDepartment
        LookupField = 'ClassID'
        Style = csDropDownList
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object dbmmoRoute: TDBMemo
        Left = 176
        Top = 53
        Width = 326
        Height = 83
        DataField = 'Route'
        DataSource = dsTransfer
        TabOrder = 1
      end
      object cbbTransferType: TwwDBComboBox
        Left = 642
        Top = 19
        Width = 245
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'TransferType'
        DataSource = dsTransfer
        DropDownCount = 8
        ItemHeight = 0
        Items.Strings = (
          'Transfer'
          'Affiliate transfer')
        Sorted = False
        TabOrder = 2
        UnboundDataType = wwDefault
      end
      object dbdtmEstDeparture: TwwDBDateTimePicker
        Left = 642
        Top = 74
        Width = 245
        Height = 23
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        DataField = 'EstDeparture'
        DataSource = dsTransfer
        Epoch = 1950
        ShowButton = True
        TabOrder = 3
      end
      object dbdtmEstArrival: TwwDBDateTimePicker
        Left = 642
        Top = 113
        Width = 245
        Height = 23
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        DataField = 'EstArrival'
        DataSource = dsTransfer
        Epoch = 1950
        ShowButton = True
        TabOrder = 4
      end
    end
    object pnlSource: TDNMPanel
      Left = 1
      Top = 153
      Width = 968
      Height = 216
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 995
      object lbSource: TLabel
        Left = 8
        Top = 22
        Width = 160
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Source Department'
        FocusControl = lookupSource
      end
      object lbDriver: TLabel
        Left = 8
        Top = 55
        Width = 160
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Driver'
        FocusControl = lookupDriver
      end
      object lbVehicle: TLabel
        Left = 467
        Top = 55
        Width = 123
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Vehicle'
        FocusControl = lookupVehicle
      end
      object lbEmployeeID: TLabel
        Left = 8
        Top = 95
        Width = 160
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'EmployeeID'
        FocusControl = edtEmployeeID
      end
      object lbDriverLic: TLabel
        Left = 8
        Top = 127
        Width = 160
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Driver License No.'
        FocusControl = edtDriverLic
      end
      object lbDriverPhone: TLabel
        Left = 8
        Top = 159
        Width = 160
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Driver Phone No.'
        FocusControl = edtDriverPhone
      end
      object lbVehicleMake: TLabel
        Left = 467
        Top = 95
        Width = 123
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Vehicle Make'
        FocusControl = edtVehicleMake
      end
      object lbVehicleModel: TLabel
        Left = 467
        Top = 127
        Width = 123
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Vehicle Model'
        FocusControl = edtVehicleModel
      end
      object lbVehiclePlate: TLabel
        Left = 467
        Top = 159
        Width = 123
        Height = 15
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'License Plate'
        FocusControl = edtVehiclePlate
      end
      object lookupSource: TwwDBLookupCombo
        Left = 176
        Top = 19
        Width = 326
        Height = 23
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ClassName'#9'20'#9'ClassName'#9'F')
        DataField = 'SourceDeptID'
        DataSource = dsTransfer
        LookupTable = qryDepartment
        LookupField = 'ClassID'
        Style = csDropDownList
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = lookupSourceCloseUp
      end
      object lookupDriver: TwwDBLookupCombo
        Left = 176
        Top = 52
        Width = 326
        Height = 23
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Name'#9'20'#9'Name'#9'F')
        DataField = 'DriverID'
        DataSource = dsTransfer
        LookupTable = qryDriver
        LookupField = 'EmployeeID'
        Style = csDropDownList
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnChange = lookupDriverChange
      end
      object lookupVehicle: TwwDBLookupCombo
        Left = 594
        Top = 52
        Width = 335
        Height = 23
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ConcatData'#9'20'#9'ConcatData'#9'F')
        DataField = 'VehicleID'
        DataSource = dsTransfer
        LookupTable = qryVehicle
        LookupField = 'VehicleID'
        Style = csDropDownList
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnChange = lookupVehicleChange
      end
      object edtEmployeeID: TEdit
        Left = 176
        Top = 92
        Width = 254
        Height = 23
        ReadOnly = True
        TabOrder = 3
      end
      object edtDriverLic: TEdit
        Left = 176
        Top = 124
        Width = 254
        Height = 23
        ReadOnly = True
        TabOrder = 4
      end
      object edtDriverPhone: TEdit
        Left = 176
        Top = 156
        Width = 254
        Height = 23
        ReadOnly = True
        TabOrder = 5
      end
      object edtVehicleMake: TEdit
        Left = 594
        Top = 92
        Width = 254
        Height = 23
        ReadOnly = True
        TabOrder = 6
      end
      object edtVehicleModel: TEdit
        Left = 594
        Top = 124
        Width = 254
        Height = 23
        ReadOnly = True
        TabOrder = 7
      end
      object edtVehiclePlate: TEdit
        Left = 594
        Top = 156
        Width = 254
        Height = 23
        ReadOnly = True
        TabOrder = 8
      end
      object btnAddDriver: TDNMSpeedButton
        Left = 502
        Top = 52
        Width = 24
        Height = 23
        Hint = 'Add driver'
        Caption = '...'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 9
        AutoDisableParentOnclick = True
        OnClick = btnAddDriverClick
      end
      object btnAddVehicle: TDNMSpeedButton
        Left = 929
        Top = 52
        Width = 24
        Height = 23
        Hint = 'Add vehicle'
        Caption = '...'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        TabOrder = 10
        AutoDisableParentOnclick = True
        OnClick = btnAddVehicleClick
      end
    end
    object pnlPackageTitle: TDNMPanel
      Left = 1
      Top = 369
      Width = 968
      Height = 40
      Align = alTop
      Caption = 'Check the boxes to select packages to transfer'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ExplicitWidth = 995
    end
    object wdbgrdPackages: TwwDBGrid
      Left = 1
      Top = 409
      Width = 968
      Height = 217
      ControlType.Strings = (
        'Check;CheckBox;True;False'
        'Checked;CheckBox;True;False')
      Selected.Strings = (
        'Checked'#9'5'#9'Check'#9'F'#9
        'PackageID'#9'10'#9'PackageID'#9'T'#9
        'StsTag'#9'30'#9'StsTag'#9'T'#9
        'PackageName'#9'50'#9'PackageName'#9'T'#9
        'PackageDate'#9'18'#9'PackageDate'#9'T'#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableEditorIfReadOnly]
      Align = alClient
      DataSource = dsPackages
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      ExplicitWidth = 995
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 548
    Top = 616
  end
  inherited tmrdelay: TTimer
    Left = 584
    Top = 616
  end
  inherited popSpelling: TPopupMenu
    Left = 232
    Top = 616
  end
  inherited tmrdelayMsg: TTimer
    Left = 672
    Top = 616
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 337
    Top = 616
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 373
    Top = 616
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 162
    Top = 583
  end
  inherited DataState: TDataState
    Left = 408
    Top = 616
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 267
    Top = 616
  end
  inherited imgsort: TImageList
    Left = 443
    Top = 616
    Bitmap = {
      494C0101020048010C0310001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 162
    Top = 616
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 478
    Top = 616
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 302
    Top = 616
  end
  inherited qryMemTrans: TERPQuery
    Left = 197
    Top = 616
  end
  inherited tmrOnshow: TTimer
    Left = 624
    Top = 616
  end
  object dsPackages: TDataSource
    DataSet = qryPackages
    Left = 240
    Top = 537
  end
  object qryTransfer: TERPQuery
    Connection = MyConnection
    Left = 320
    Top = 480
  end
  object qryPackages: TERPQuery
    Connection = MyConnection
    Left = 240
    Top = 480
    object qryPackagesCheck: TBooleanField
      DisplayLabel = 'Check'
      DisplayWidth = 5
      FieldName = 'Checked'
    end
    object qryPackagesPackageID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PackageID'
    end
    object qryPackagesStsTag: TWideStringField
      DisplayWidth = 30
      FieldName = 'StsTag'
    end
    object qryPackagesPackageName: TWideStringField
      DisplayWidth = 50
      FieldName = 'PackageName'
      Size = 0
    end
    object qryPackagesPackageDate: TDateTimeField
      DisplayWidth = 18
      FieldName = 'PackageDate'
    end
    object qryPackagesTagID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TagID'
      Visible = False
    end
    object qryPackagesStSProductId: TIntegerField
      DisplayWidth = 10
      FieldName = 'StSProductId'
      Visible = False
    end
    object qryPackagesID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
    object qryPackagesDeptID: TIntegerField
      DisplayWidth = 10
      FieldName = 'DeptID'
      Visible = False
    end
    object qryPackagesTransferID: TIntegerField
      DisplayWidth = 10
      FieldName = 'TransferID'
      Visible = False
    end
    object qryPackagesLineID: TIntegerField
      DisplayWidth = 10
      FieldName = 'LineID'
      Visible = False
    end
  end
  object dsTransfer: TDataSource
    DataSet = qryTransfer
    Left = 320
    Top = 536
  end
  object qryDriver: TERPQuery
    Connection = MyConnection
    Left = 403
    Top = 480
    object qryDriverName: TWideStringField
      DisplayWidth = 20
      FieldName = 'Name'
    end
    object qryDriverEmployeeID: TIntegerField
      FieldName = 'EmployeeID'
      Visible = False
    end
    object qryDriverDriverLic: TWideStringField
      FieldName = 'DriverLic'
      Visible = False
    end
    object qryDriverDriverPhone: TWideStringField
      FieldName = 'DriverPhone'
      Visible = False
    end
  end
  object dsDriver: TDataSource
    DataSet = qryDriver
    Left = 403
    Top = 536
  end
  object qryVehicle: TERPQuery
    Connection = MyConnection
    Left = 480
    Top = 480
    object qryVehicleConcatData: TWideStringField
      DisplayWidth = 20
      FieldName = 'ConcatData'
    end
    object qryVehicleVehicleID: TIntegerField
      FieldName = 'VehicleID'
      Visible = False
    end
    object qryVehicleVehicleMake: TWideStringField
      FieldName = 'VehicleMake'
      Visible = False
    end
    object qryVehicleVehicleModel: TWideStringField
      FieldName = 'VehicleModel'
      Visible = False
    end
    object qryVehicleVehiclePlate: TWideStringField
      FieldName = 'VehiclePlate'
      Visible = False
    end
  end
  object dsVehicle: TDataSource
    DataSet = qryVehicle
    Left = 479
    Top = 536
  end
  object qryDepartment: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT C.ClassID, C.ClassName '
      
        'FROM tblClass C INNER JOIN tblStsClass Sts ON C.ClassID = Sts.Cl' +
        'assID  '
      'WHERE C.Active = True'
      'ORDER BY C.ClassName;')
    Left = 568
    Top = 480
    object qryDepartmentClassName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ClassName'
    end
    object qryDepartmentClassID: TIntegerField
      FieldName = 'ClassID'
      Visible = False
    end
  end
  object scrptMain: TERPScript
    Connection = MyConnection
    IgnorenContinueOnError = False
    Left = 672
    Top = 480
  end
end
