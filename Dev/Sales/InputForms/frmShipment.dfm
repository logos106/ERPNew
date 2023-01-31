inherited fmShipment: TfmShipment
  Left = 357
  Top = 230
  Caption = 'Shipment'
  ClientHeight = 565
  ClientWidth = 996
  Font.Style = []
  OnResize = FormResize
  ExplicitLeft = 357
  ExplicitTop = 230
  ExplicitWidth = 1012
  ExplicitHeight = 604
  DesignSize = (
    996
    565)
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 565
    Width = 996
    ExplicitTop = 476
    ExplicitWidth = 587
  end
  inherited shapehint: TShape
    Left = 12
    ExplicitLeft = 1
  end
  inherited shapehintextra1: TShape
    Left = 58
    ExplicitLeft = 27
  end
  object Label4: TLabel [4]
    Left = 8
    Top = 415
    Width = 136
    Height = 15
    Caption = 'Sale Shipping Allocation'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel [5]
    Left = 8
    Top = 286
    Width = 114
    Height = 15
    Caption = 'Shipment Packages'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCanProcess: TLabel [7]
    Left = 217
    Top = 539
    Width = 82
    Height = 15
    Alignment = taRightJustify
    Caption = 'lblCanProcess'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object btnSave: TDNMSpeedButton [8]
    Left = 308
    Top = 532
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'OK'
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
    TabOrder = 1
    AutoDisableParentOnclick = True
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton [9]
    Left = 600
    Top = 532
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'Cancel'
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
  object grdSaleLine: TwwDBGrid [10]
    Left = 8
    Top = 432
    Width = 980
    Height = 92
    Selected.Strings = (
      'ProductName'#9'15'#9'Product'#9'T'
      'Description'#9'26'#9'Description'#9'T'
      'UOM'#9'6'#9'UOM'#9'T'
      'UOMSoldQty'#9'10'#9'Sold Qty'#9'T'
      'ShippedUOMQty'#9'10'#9'Shipped Qty'#9'T'
      'AllocatedUOMQty'#9'10'#9'Allocated'#9#9
      'UnallocatedUOMQty'#9'10'#9'Unallocated'#9'T'
      'Weight'#9'10'#9'Weight'#9'T'#9
      'Height'#9'10'#9'Height'#9'T'#9
      'Length'#9'10'#9'Length'#9'T'#9
      'Width'#9'10'#9'Width'#9'T'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    Anchors = [akLeft, akTop, akBottom]
    DataSource = dsSaleLine
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = grdSaleLineCalcCellColors
  end
  object grdPackages: TwwDBGrid [11]
    Left = 8
    Top = 302
    Width = 980
    Height = 109
    ControlType.Strings = (
      'PackageDangerousGoodsAccessible;CheckBox;T;F'
      'PackageType;CustomEdit;cboPackageType;F'
      'PackageCODType;CustomEdit;cboPackageCODType;F'
      'PackageSignatureType;CustomEdit;cboPackageSignatureType;F'
      'PackageOptNonStandardContainer;CheckBox;T;F'
      'PackageOptAdditionalHandling;CheckBox;T;F'
      'PackageOptAppointmentDelivery;CheckBox;T;F'
      'PackageOptDangeriousGoods;CheckBox;T;F'
      'PackageOptDryIce;CheckBox;T;F'
      'PackageOptPriorityAlert;CheckBox;T;F'
      'PackageOptCOD;CheckBox;T;F'
      'PackageOptSignatureOption;CheckBox;T;F'
      'PackageOptAlcohol;CheckBox;T;F')
    Selected.Strings = (
      'PackageType'#9'10'#9'Package Type'#9#9
      'PackageWeight'#9'10'#9'Weight'#9#9
      'PackageWeightFrac'#9'10'#9'PackageWeightFrac'#9#9
      'PackageHeight'#9'10'#9'Height'#9#9
      'PackageLength'#9'10'#9'Length'#9#9
      'PackageWidth'#9'10'#9'Width'#9#9
      'PackageCODType'#9'15'#9'COD Type'#9#9
      'PackageCODAmount'#9'10'#9'COD Amount'#9#9
      'PackageReference'#9'10'#9'Reference'#9#9
      'PackageTrackingNumber'#9'10'#9'Tracking Number'#9#9
      'PackageSignatureType'#9'10'#9'Signature Type'#9#9
      'PackageDangerousGoodsAccessible'#9'1'#9'Dangerous Goods Accessible'#9#9
      'PackageDescription'#9'10'#9'Package Description'#9#9
      'PackageOptNonStandardContainer'#9'5'#9'Non Std Cntr'#9#9
      'PackageOptAdditionalHandling'#9'5'#9'Addnl Handling'#9#9
      'PackageOptAppointmentDelivery'#9'5'#9'Appoint Delivery'#9#9
      'PackageOptDangeriousGoods'#9'5'#9'Dangerious Goods'#9#9
      'PackageOptDryIce'#9'5'#9'Dry Ice'#9#9
      'PackageOptPriorityAlert'#9'5'#9'Priority Alert'#9#9
      'PackageOptCOD'#9'5'#9'COD'#9#9
      'PackageOptSignatureOption'#9'5'#9'Signature Option'#9#9
      'PackageOptAlcohol'#9'5'#9'Alcohol'#9#9
      'PackageBaseCharge'#9'10'#9'Base Charge'#9#9
      'PackageInsuredValue'#9'10'#9'Insured Value'#9#9
      'PackageNetCharge'#9'10'#9'Net Charge'#9#9
      'PackageSpecialService'#9'10'#9'Special Service'#9#9
      'PackageTotalDiscount'#9'10'#9'Total Discount'#9#9
      'PackageTotalSurcharges'#9'10'#9'Total Surcharges'#9#9
      'CommodityDescription'#9'15'#9'Comm Description'#9'F'#9
      'CommodityHarmonizedCode'#9'10'#9'Comm Harmonized Code'#9'F'#9
      'CommodityManufacturer'#9'15'#9'Comm Manufacturer'#9'F'#9
      'CommodityNumberOfPieces'#9'10'#9'Comm Number Of Pieces'#9'F'#9
      'CommodityQuantityUnit'#9'10'#9'Comm Quantity Unit'#9'F'#9
      'CommodityQuantity'#9'10'#9'Comm Quantity'#9'F'#9
      'CommodityUnitPrice'#9'10'#9'Comm Unit Price'#9'F'#9
      'CommodityValue'#9'10'#9'Comm Value'#9'F'#9
      'CommodityWeight'#9'10'#9'Comm Weight'#9'F'#9)
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
    DataSource = dsPackages
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    PopupMenu = popPackages
    TabOrder = 4
    TitleAlignment = taLeftJustify
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    TitleLines = 2
    TitleButtons = False
    OnCalcCellColors = grdPackagesCalcCellColors
    object wwDBGrid1IButton: TwwIButton
      Left = 0
      Top = 0
      Width = 22
      Height = 22
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
      OnClick = wwDBGrid1IButtonClick
    end
  end
  object cboPackageType: TwwDBComboBox [12]
    Left = 134
    Top = 344
    Width = 121
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    ItemHeight = 0
    Sorted = False
    TabOrder = 5
    UnboundDataType = wwDefault
  end
  object pcDetails: TPageControl [13]
    Left = 8
    Top = 53
    Width = 980
    Height = 228
    ActivePage = tabDetails
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object tabDetails: TTabSheet
      Caption = 'Details'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 16
        Top = 15
        Width = 48
        Height = 15
        Caption = 'Provider'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 44
        Width = 43
        Height = 15
        Caption = 'Service'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label31: TLabel
        Left = 16
        Top = 102
        Width = 98
        Height = 15
        Caption = 'Label Image Type'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPayorType: TLabel
        Left = 353
        Top = 15
        Width = 62
        Height = 15
        Caption = 'Payor Type'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPayorAccountNumber: TLabel
        Left = 353
        Top = 44
        Width = 83
        Height = 15
        Caption = 'Payor Account'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblMasterTrackingNumber: TLabel
        Left = 635
        Top = 15
        Width = 97
        Height = 15
        Alignment = taRightJustify
        Caption = 'Tracking Number'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label34: TLabel
        Left = 639
        Top = 44
        Width = 93
        Height = 15
        Alignment = taRightJustify
        Caption = 'Total Net Charge'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalBaseCharge: TLabel
        Left = 629
        Top = 73
        Width = 103
        Height = 15
        Alignment = taRightJustify
        Caption = 'Total Base Charge'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalSurcharges: TLabel
        Left = 635
        Top = 102
        Width = 97
        Height = 15
        Alignment = taRightJustify
        Caption = 'Total Surcharges'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label37: TLabel
        Left = 567
        Top = 175
        Width = 54
        Height = 15
        Alignment = taRightJustify
        Caption = 'Ship Date'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalNetChargeNegotiated: TLabel
        Left = 575
        Top = 131
        Width = 157
        Height = 15
        Alignment = taRightJustify
        Caption = 'Negotiated Total Net Charge'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPayorZipCode: TLabel
        Left = 353
        Top = 73
        Width = 85
        Height = 15
        Caption = 'Payor Zip Code'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDeliveryDate: TLabel
        Left = 760
        Top = 175
        Width = 74
        Height = 15
        Alignment = taRightJustify
        Caption = 'Delivery Date'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblDropoffType: TLabel
        Left = 16
        Top = 73
        Width = 71
        Height = 15
        Caption = 'Dropoff Type'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPostageProvider: TLabel
        Left = 243
        Top = 102
        Width = 48
        Height = 15
        Caption = 'Provider'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cboService: TComboBox
        Left = 122
        Top = 41
        Width = 199
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = cboServiceChange
      end
      object cboProvider: TComboBox
        Left = 122
        Top = 12
        Width = 199
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cboProviderChange
      end
      object cboLabelImageType: TComboBox
        Left = 122
        Top = 99
        Width = 107
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnChange = cboLabelImageTypeChange
      end
      object cboPayorType: TComboBox
        Left = 474
        Top = 12
        Width = 119
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = cboPayorTypeChange
      end
      object edtPayorAccountNumber: TDBEdit
        Left = 474
        Top = 41
        Width = 119
        Height = 23
        DataField = 'PayorAccountNumber'
        DataSource = dsShipments
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnChange = edtPayorAccountNumberChange
      end
      object edtMasterTrackingNumber: TDBEdit
        Left = 746
        Top = 12
        Width = 211
        Height = 23
        DataField = 'MasterTrackingNumber'
        DataSource = dsShipments
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object edtTotalNetCharge: TDBEdit
        Left = 746
        Top = 41
        Width = 155
        Height = 23
        DataField = 'TotalNetCharge'
        DataSource = dsShipments
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
      end
      object edtTotalBaseCharge: TDBEdit
        Left = 746
        Top = 70
        Width = 155
        Height = 23
        DataField = 'TotalBaseCharge'
        DataSource = dsShipments
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 7
      end
      object edtTotalSurcharges: TDBEdit
        Left = 746
        Top = 99
        Width = 155
        Height = 23
        DataField = 'TotalSurcharges'
        DataSource = dsShipments
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 8
      end
      object edtTotalNetChargeNegotiated: TDBEdit
        Left = 746
        Top = 128
        Width = 155
        Height = 23
        DataField = 'TotalNetChargeNegotiated'
        DataSource = dsShipments
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 9
      end
      object gbMailInnovations: TGroupBox
        Left = 16
        Top = 124
        Width = 526
        Height = 71
        TabOrder = 10
        object lblCostCenter: TLabel
          Left = 331
          Top = 16
          Width = 67
          Height = 15
          Caption = 'Cost Center'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblMIPackageID: TLabel
          Left = 331
          Top = 45
          Width = 64
          Height = 15
          Caption = 'Package ID'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblEndorsement: TLabel
          Left = 6
          Top = 45
          Width = 76
          Height = 15
          Caption = 'Endorsement'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblMailInovations: TLabel
          Left = 6
          Top = 12
          Width = 84
          Height = 15
          Caption = 'Mail Inovations'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtMICostCenter: TDBEdit
          Left = 407
          Top = 13
          Width = 107
          Height = 23
          DataField = 'MICostCenter'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edtMIPackageID: TDBEdit
          Left = 407
          Top = 42
          Width = 107
          Height = 23
          DataField = 'MIPackageID'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object cboEndorsement: TwwDBComboBox
          Left = 93
          Top = 42
          Width = 219
          Height = 23
          ShowButton = True
          Style = csDropDown
          MapList = True
          AllowClearKey = False
          DataField = 'Endorsement'
          DataSource = dsShipments
          DropDownCount = 8
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemHeight = 0
          Items.Strings = (
            'No Service Selected'#9'0'
            'Return Service Selected'#9'1'
            'Forwarding Service Requested'#9'2'
            'Address Service Requested'#9'3'
            'Change Service Selected'#9'4')
          ParentFont = False
          Sorted = False
          TabOrder = 2
          UnboundDataType = wwDefault
        end
      end
      object edtPayorZipCode: TDBEdit
        Left = 474
        Top = 70
        Width = 119
        Height = 23
        DataField = 'PayorZipCode'
        DataSource = dsShipments
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
      end
      object cboDropoffType: TComboBox
        Left = 122
        Top = 70
        Width = 199
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        OnChange = cboDropoffTypeChange
        Items.Strings = (
          'Regular Pickup'
          'Request Courier'
          'Drop Box'
          'Business Service Center'
          'Station')
      end
      object edtShipDate: TwwDBDateTimePicker
        Left = 633
        Top = 172
        Width = 112
        Height = 23
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        DataField = 'ShipDate'
        DataSource = dsShipments
        Epoch = 1899
        ShowButton = True
        TabOrder = 13
        OnChange = edtShipDateChange
      end
      object edtDeliveryDate: TwwDBDateTimePicker
        Left = 840
        Top = 172
        Width = 112
        Height = 23
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'Tahoma'
        CalendarAttributes.Font.Style = []
        DataField = 'DeliveryData'
        DataSource = dsShipments
        Epoch = 1899
        ReadOnly = True
        ShowButton = True
        TabOrder = 14
      end
      object chkDocumentsOnly: TwwCheckBox
        Left = 470
        Top = 101
        Width = 123
        Height = 17
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Documents Only'
        DataField = 'DocumentsOnly'
        DataSource = dsShipments
        TabOrder = 15
      end
      object cboPostageProvider: TComboBox
        Left = 299
        Top = 99
        Width = 86
        Height = 23
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 16
        OnChange = cboPostageProviderChange
        Items.Strings = (
          'USPS'
          'Endicia'
          'Stamps')
      end
      object btnTayorTypeHelp: TDNMSpeedButton
        Left = 600
        Top = 12
        Width = 25
        Height = 23
        Caption = '?'
        DisableTransparent = False
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = []
        TabOrder = 17
        AutoDisableParentOnclick = True
        OnClick = btnTayorTypeHelpClick
      end
    end
    object tabFedExSpecialServices: TTabSheet
      Caption = 'Special Services'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblBookingNumber: TLabel
        Left = 704
        Top = 7
        Width = 104
        Height = 15
        AutoSize = False
        Caption = 'Booking Number'
      end
      object chkCOD: TCheckBox
        Left = 29
        Top = 41
        Width = 148
        Height = 17
        Caption = 'COD'
        TabOrder = 0
        OnClick = chkFedExSpecialServicesClick
      end
      object chkTopLoad: TCheckBox
        Left = 500
        Top = 142
        Width = 148
        Height = 17
        Caption = 'Top Load'
        TabOrder = 1
        OnClick = chkFedExSpecialServicesClick
      end
      object chkInternationalTrafficinArmsRegulations: TCheckBox
        Left = 500
        Top = 159
        Width = 263
        Height = 17
        Caption = 'International Traffic in Arms Regulations'
        TabOrder = 2
        OnClick = chkFedExSpecialServicesClick
      end
      object chkHomeDeliveryPremium: TCheckBox
        Left = 239
        Top = 108
        Width = 181
        Height = 17
        Caption = 'Home Delivery Premium'
        TabOrder = 3
        OnClick = chkFedExSpecialServicesClick
      end
      object chkInsideDelivery: TCheckBox
        Left = 239
        Top = 125
        Width = 148
        Height = 17
        Caption = 'Inside Delivery'
        TabOrder = 4
        OnClick = chkFedExSpecialServicesClick
      end
      object chkInsidePickup: TCheckBox
        Left = 239
        Top = 142
        Width = 148
        Height = 17
        Caption = 'Inside Pickup'
        TabOrder = 5
        OnClick = chkFedExSpecialServicesClick
      end
      object chkReturnShipment: TCheckBox
        Left = 500
        Top = 91
        Width = 148
        Height = 17
        Caption = 'Return Shipment'
        TabOrder = 6
        OnClick = chkFedExSpecialServicesClick
      end
      object chkSaturdayDelivery: TCheckBox
        Left = 500
        Top = 108
        Width = 148
        Height = 17
        Caption = 'Saturday Delivery'
        TabOrder = 7
        OnClick = chkFedExSpecialServicesClick
      end
      object chkSaturdayPickup: TCheckBox
        Left = 500
        Top = 125
        Width = 148
        Height = 17
        Caption = 'Saturday Pickup'
        TabOrder = 8
        OnClick = chkFedExSpecialServicesClick
      end
      object chkBrokerSelect: TCheckBox
        Left = 29
        Top = 7
        Width = 148
        Height = 17
        Caption = 'Broker Select'
        TabOrder = 9
        OnClick = chkFedExSpecialServicesClick
      end
      object chkCallBeforeDelivery: TCheckBox
        Left = 29
        Top = 24
        Width = 148
        Height = 17
        Caption = 'Call Before Delivery'
        TabOrder = 10
        OnClick = chkFedExSpecialServicesClick
      end
      object chkCustomDeliveryWindow: TCheckBox
        Left = 29
        Top = 58
        Width = 172
        Height = 17
        Caption = 'Custom Delivery Window'
        TabOrder = 11
        OnClick = chkFedExSpecialServicesClick
      end
      object chkDangeriousGoods: TCheckBox
        Left = 29
        Top = 75
        Width = 172
        Height = 17
        Caption = 'Dangerious Goods'
        TabOrder = 12
        OnClick = chkFedExSpecialServicesClick
      end
      object chkDoNotBreakDownPallets: TCheckBox
        Left = 29
        Top = 92
        Width = 172
        Height = 17
        Caption = 'Do Not Break Down Pallets'
        TabOrder = 13
        OnClick = chkFedExSpecialServicesClick
      end
      object chkDoNotStackPallets: TCheckBox
        Left = 29
        Top = 108
        Width = 172
        Height = 17
        Caption = 'Do Not Stack Pallets'
        TabOrder = 14
        OnClick = chkFedExSpecialServicesClick
      end
      object chkEastCoastSpecial: TCheckBox
        Left = 29
        Top = 142
        Width = 172
        Height = 17
        Caption = 'East Coast Special'
        TabOrder = 15
        OnClick = chkFedExSpecialServicesClick
      end
      object chkElectronicTradeDocuments: TCheckBox
        Left = 29
        Top = 159
        Width = 214
        Height = 17
        Caption = 'Electronic Trade Documents'
        TabOrder = 16
        OnClick = chkFedExSpecialServicesClick
      end
      object chkEmailNotification: TCheckBox
        Left = 29
        Top = 176
        Width = 172
        Height = 17
        Caption = 'Email Notification'
        TabOrder = 17
        OnClick = chkFedExSpecialServicesClick
      end
      object chkExtreamLength: TCheckBox
        Left = 239
        Top = 7
        Width = 172
        Height = 17
        Caption = 'Extream Length'
        TabOrder = 18
        OnClick = chkFedExSpecialServicesClick
      end
      object chkFood: TCheckBox
        Left = 239
        Top = 23
        Width = 172
        Height = 17
        Caption = 'Food'
        TabOrder = 19
        OnClick = chkFedExSpecialServicesClick
      end
      object chkFreightGuarantee: TCheckBox
        Left = 239
        Top = 40
        Width = 172
        Height = 17
        Caption = 'Freight Guarantee'
        TabOrder = 20
        OnClick = chkFedExSpecialServicesClick
      end
      object chkFutureDay: TCheckBox
        Left = 239
        Top = 57
        Width = 172
        Height = 17
        Caption = 'Future Day'
        TabOrder = 21
        OnClick = chkFedExSpecialServicesClick
      end
      object chkHoldAtLocation: TCheckBox
        Left = 239
        Top = 74
        Width = 172
        Height = 17
        Caption = 'Hold At Location'
        TabOrder = 22
        OnClick = chkFedExSpecialServicesClick
      end
      object chkInternationalControlledExportService: TCheckBox
        Left = 239
        Top = 91
        Width = 249
        Height = 17
        Caption = 'International Controlled Export Service'
        TabOrder = 23
        OnClick = chkFedExSpecialServicesClick
      end
      object chkLiftgateDelivery: TCheckBox
        Left = 239
        Top = 159
        Width = 181
        Height = 17
        Caption = 'Liftgate Delivery'
        TabOrder = 24
        OnClick = chkFedExSpecialServicesClick
      end
      object chkLiftgatePickup: TCheckBox
        Left = 239
        Top = 176
        Width = 181
        Height = 17
        Caption = 'Liftgate Pickup'
        TabOrder = 25
        OnClick = chkFedExSpecialServicesClick
      end
      object chkLimitedAccessDelivery: TCheckBox
        Left = 500
        Top = 7
        Width = 181
        Height = 17
        Caption = 'Limited Access Delivery'
        TabOrder = 26
        OnClick = chkFedExSpecialServicesClick
      end
      object chkLimitedAccessPickup: TCheckBox
        Left = 500
        Top = 23
        Width = 181
        Height = 17
        Caption = 'Limited Access Pickup'
        TabOrder = 27
        OnClick = chkFedExSpecialServicesClick
      end
      object chkPendingShipment: TCheckBox
        Left = 500
        Top = 40
        Width = 181
        Height = 17
        Caption = 'Pending Shipment'
        TabOrder = 28
        OnClick = chkFedExSpecialServicesClick
      end
      object chkPoison: TCheckBox
        Left = 500
        Top = 57
        Width = 181
        Height = 17
        Caption = 'Posion'
        TabOrder = 29
        OnClick = chkFedExSpecialServicesClick
      end
      object chkProtectionFromFreezing: TCheckBox
        Left = 500
        Top = 74
        Width = 181
        Height = 17
        Caption = 'Protection From Freezing'
        TabOrder = 30
        OnClick = chkFedExSpecialServicesClick
      end
      object chkDryIce: TCheckBox
        Left = 29
        Top = 125
        Width = 172
        Height = 17
        Caption = 'Dry Ice'
        TabOrder = 31
        OnClick = chkFedExSpecialServicesClick
      end
      object edtBookingNumber: TwwDBEdit
        Left = 820
        Top = 3
        Width = 133
        Height = 23
        DataField = 'BookingNumber'
        DataSource = dsShipments
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 32
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object tabShipFrom: TTabSheet
      Caption = 'Ship From'
      object grpShipFrom: TGroupBox
        Left = 30
        Top = 3
        Width = 507
        Height = 196
        Caption = 'Ship From'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label3: TLabel
          Left = 15
          Top = 24
          Width = 61
          Height = 15
          Caption = 'First Name'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 203
          Top = 24
          Width = 30
          Height = 15
          Caption = 'Initial'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 301
          Top = 24
          Width = 61
          Height = 15
          Caption = 'Last Name'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 15
          Top = 53
          Width = 53
          Height = 15
          Caption = 'Company'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 301
          Top = 53
          Width = 31
          Height = 15
          Caption = 'Email'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 15
          Top = 82
          Width = 36
          Height = 15
          Caption = 'Phone'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 301
          Top = 82
          Width = 20
          Height = 15
          Caption = 'Fax'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 15
          Top = 111
          Width = 58
          Height = 15
          Caption = 'Address 1'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 15
          Top = 140
          Width = 58
          Height = 15
          Caption = 'Address 2'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label14: TLabel
          Left = 15
          Top = 170
          Width = 21
          Height = 15
          Caption = 'City'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label15: TLabel
          Left = 301
          Top = 113
          Width = 30
          Height = 15
          Caption = 'State'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label16: TLabel
          Left = 301
          Top = 140
          Width = 49
          Height = 15
          Caption = 'Zip Code'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblSenderCountryCode: TLabel
          Left = 301
          Top = 170
          Width = 44
          Height = 15
          Caption = 'Country'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtSenderFirstName: TDBEdit
          Left = 88
          Top = 21
          Width = 91
          Height = 23
          DataField = 'SenderFirstName'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edtSenderInitial: TDBEdit
          Left = 246
          Top = 21
          Width = 40
          Height = 23
          DataField = 'SenderMiddleInitial'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object edtSenderLastName: TDBEdit
          Left = 368
          Top = 21
          Width = 129
          Height = 23
          DataField = 'SenderLastName'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object edtSenderCompany: TDBEdit
          Left = 88
          Top = 50
          Width = 198
          Height = 23
          DataField = 'SenderCompany'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object edtSenderEmail: TDBEdit
          Left = 368
          Top = 50
          Width = 129
          Height = 23
          DataField = 'SenderEmail'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object edtSenderPhone: TDBEdit
          Left = 88
          Top = 79
          Width = 91
          Height = 23
          DataField = 'SenderPhone'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object edtSenderFax: TDBEdit
          Left = 367
          Top = 79
          Width = 130
          Height = 23
          DataField = 'SenderFax'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object edtSenderAddress1: TDBEdit
          Left = 88
          Top = 108
          Width = 198
          Height = 23
          DataField = 'SenderAddress1'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object edtSenderAddress2: TDBEdit
          Left = 88
          Top = 137
          Width = 198
          Height = 23
          DataField = 'SenderAddress2'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object edtSenderCity: TDBEdit
          Left = 88
          Top = 167
          Width = 198
          Height = 23
          DataField = 'SenderCity'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object edtSenderState: TDBEdit
          Left = 368
          Top = 108
          Width = 90
          Height = 23
          DataField = 'SenderState'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object edtSenderZipCode: TDBEdit
          Left = 368
          Top = 137
          Width = 90
          Height = 23
          DataField = 'SenderZipCode'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object edtSenderCountryCode: TwwDBLookupCombo
          Left = 368
          Top = 166
          Width = 90
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Shortcountrycode'#9'10'#9'Code'#9'F'
            'Country'#9'30'#9'Country'#9'F')
          DataField = 'SenderCountryCode'
          DataSource = dsShipments
          LookupTable = qrySenderCountryCodeLookup
          LookupField = 'Shortcountrycode'
          ParentFont = False
          TabOrder = 12
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
        end
      end
    end
    object tabShipTo: TTabSheet
      Caption = 'Ship To'
      ImageIndex = 2
      object grpShipTo: TGroupBox
        Left = 30
        Top = 3
        Width = 611
        Height = 196
        Caption = 'Ship To'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label18: TLabel
          Left = 15
          Top = 24
          Width = 61
          Height = 15
          Caption = 'First Name'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label19: TLabel
          Left = 203
          Top = 24
          Width = 30
          Height = 15
          Caption = 'Initial'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label20: TLabel
          Left = 301
          Top = 24
          Width = 61
          Height = 15
          Caption = 'Last Name'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label21: TLabel
          Left = 15
          Top = 53
          Width = 53
          Height = 15
          Caption = 'Company'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label22: TLabel
          Left = 301
          Top = 53
          Width = 31
          Height = 15
          Caption = 'Email'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label23: TLabel
          Left = 15
          Top = 82
          Width = 36
          Height = 15
          Caption = 'Phone'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label24: TLabel
          Left = 301
          Top = 82
          Width = 20
          Height = 15
          Caption = 'Fax'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label25: TLabel
          Left = 15
          Top = 111
          Width = 58
          Height = 15
          Caption = 'Address 1'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label26: TLabel
          Left = 15
          Top = 140
          Width = 58
          Height = 15
          Caption = 'Address 2'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label27: TLabel
          Left = 15
          Top = 170
          Width = 21
          Height = 15
          Caption = 'City'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label28: TLabel
          Left = 301
          Top = 113
          Width = 30
          Height = 15
          Caption = 'State'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label29: TLabel
          Left = 301
          Top = 140
          Width = 49
          Height = 15
          Caption = 'Zip Code'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblReceipientCountry: TLabel
          Left = 301
          Top = 170
          Width = 44
          Height = 15
          Caption = 'Country'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtReceipientFirstName: TDBEdit
          Left = 88
          Top = 21
          Width = 91
          Height = 23
          DataField = 'RecipientFirstName'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = ReceipientAddressChange
        end
        object edtReceipientInitial: TDBEdit
          Left = 246
          Top = 21
          Width = 40
          Height = 23
          DataField = 'RecipientMiddleInitial'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = ReceipientAddressChange
        end
        object edtReceipientLastName: TDBEdit
          Left = 368
          Top = 21
          Width = 129
          Height = 23
          DataField = 'RecipientLastName'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = ReceipientAddressChange
        end
        object edtReceipientCompany: TDBEdit
          Left = 88
          Top = 50
          Width = 198
          Height = 23
          DataField = 'RecipientCompany'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = ReceipientAddressChange
        end
        object edtReceipientEmail: TDBEdit
          Left = 368
          Top = 50
          Width = 129
          Height = 23
          DataField = 'RecipientEmail'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnChange = ReceipientAddressChange
        end
        object edtReceipientPhone: TDBEdit
          Left = 88
          Top = 79
          Width = 91
          Height = 23
          DataField = 'RecipientPhone'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnChange = ReceipientAddressChange
        end
        object edtReceipientFax: TDBEdit
          Left = 367
          Top = 79
          Width = 130
          Height = 23
          DataField = 'RecipientFax'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = ReceipientAddressChange
        end
        object edtReceipientAddress1: TDBEdit
          Left = 88
          Top = 108
          Width = 198
          Height = 23
          DataField = 'RecipientAddress1'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnChange = ReceipientAddressChange
        end
        object edtReceipientAddress2: TDBEdit
          Left = 88
          Top = 137
          Width = 198
          Height = 23
          DataField = 'RecipientAddress2'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnChange = ReceipientAddressChange
        end
        object edtReceipientCity: TDBEdit
          Left = 88
          Top = 167
          Width = 198
          Height = 23
          DataField = 'RecipientCity'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          OnChange = ReceipientAddressChange
        end
        object edtReceipientState: TDBEdit
          Left = 368
          Top = 108
          Width = 90
          Height = 23
          DataField = 'RecipientState'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnChange = ReceipientAddressChange
        end
        object edtReceipientZipCode: TDBEdit
          Left = 368
          Top = 137
          Width = 90
          Height = 23
          DataField = 'RecipientZipCode'
          DataSource = dsShipments
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          OnChange = ReceipientAddressChange
        end
        object edtReceipientCountry: TwwDBLookupCombo
          Left = 368
          Top = 166
          Width = 90
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          DropDownAlignment = taLeftJustify
          Selected.Strings = (
            'Shortcountrycode'#9'10'#9'Code'#9'F'
            'Country'#9'30'#9'Country'#9'F')
          DataField = 'RecipientCountryCode'
          DataSource = dsShipments
          LookupTable = qryRecipientCountryCodeLookup
          LookupField = 'Shortcountrycode'
          ParentFont = False
          TabOrder = 12
          AutoDropDown = False
          ShowButton = True
          PreciseEditRegion = False
          AllowClearKey = False
          OnChange = ReceipientAddressChange
        end
        object chkRecipientAddressValid: TwwCheckBox
          Left = 504
          Top = 168
          Width = 97
          Height = 17
          DisableThemes = False
          AlwaysTransparent = False
          ValueChecked = 'T'
          ValueUnchecked = 'F'
          DisplayValueChecked = 'T'
          DisplayValueUnchecked = 'F'
          NullAndBlankState = cbUnchecked
          Alignment = taLeftJustify
          Caption = 'Address Valid'
          DataField = 'RecipientAddressValid'
          DataSource = dsShipments
          TabOrder = 13
          ReadOnly = True
        end
        object btnValidateRecipientAddress: TDNMSpeedButton
          Left = 512
          Top = 132
          Width = 87
          Height = 27
          Hint = 'Save this Address against this client and Close'
          Caption = 'Validate'
          Default = True
          DisableTransparent = False
          HotTrackFont.Charset = ANSI_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -12
          HotTrackFont.Name = 'Arial'
          HotTrackFont.Style = [fsBold]
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          AutoDisableParentOnclick = True
          OnClick = btnValidateRecipientAddressClick
        end
      end
    end
  end
  object btnProcess: TDNMSpeedButton [14]
    Left = 405
    Top = 532
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'Process'
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
    OnClick = btnProcessClick
  end
  object chkProcessed: TwwCheckBox [15]
    Left = 887
    Top = 539
    Width = 97
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Anchors = [akRight, akBottom]
    Caption = 'Processed'
    DataField = 'Processed'
    DataSource = dsShipments
    TabOrder = 8
    ReadOnly = True
  end
  object cboPackageCODType: TwwDBComboBox [16]
    Left = 284
    Top = 344
    Width = 121
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    ItemHeight = 0
    Sorted = False
    TabOrder = 9
    UnboundDataType = wwDefault
  end
  object cboPackageSignatureType: TwwDBComboBox [17]
    Left = 428
    Top = 344
    Width = 121
    Height = 23
    ShowButton = True
    Style = csDropDown
    MapList = True
    AllowClearKey = False
    DropDownCount = 8
    ItemHeight = 0
    Sorted = False
    TabOrder = 10
    UnboundDataType = wwDefault
  end
  object pnlTitle: TDNMPanel [18]
    Left = 266
    Top = 6
    Width = 463
    Height = 41
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
      Width = 459
      Height = 37
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
        Width = 459
        Height = 37
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Shipment'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 326
      end
    end
  end
  object wwCheckBox1: TwwCheckBox [19]
    Left = 758
    Top = 540
    Width = 97
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    DisplayValueChecked = 'T'
    DisplayValueUnchecked = 'F'
    NullAndBlankState = cbUnchecked
    Alignment = taLeftJustify
    Anchors = [akRight, akBottom]
    Caption = 'Canceled'
    DataField = 'Canceled'
    DataSource = dsShipments
    TabOrder = 11
    ReadOnly = True
  end
  object btnCancelShipment: TDNMSpeedButton [20]
    Left = 502
    Top = 532
    Width = 87
    Height = 27
    Anchors = [akBottom]
    Caption = 'Cancel Ship'
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
    TabOrder = 12
    AutoDisableParentOnclick = True
    OnClick = btnCancelShipmentClick
  end
  inherited tmrProcessMessage: TTimer
    Left = 844
    Top = 8
  end
  inherited tmrdelay: TTimer
    Left = 880
    Top = 8
  end
  inherited popSpelling: TPopupMenu
    Left = 104
    Top = 16
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 193
    Top = 8
  end
  inherited ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Top = 16
  end
  inherited MyConnection: TERPConnection
    Connected = True
    Left = 2
    Top = 15
  end
  inherited DataState: TDataState
    Left = 248
    Top = 24
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 155
    Top = 8
  end
  inherited imgsort: TImageList
    Top = 24
    Bitmap = {
      494C010102000C01F00110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 522
    Top = 8
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Top = 8
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 584
    Top = 16
  end
  inherited qryMemTrans: TERPQuery
    Left = 37
    Top = 65528
  end
  object qryShipment: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblShipment')
    Left = 376
    Top = 8
    object qryShipmentShipmentId: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ShipmentId'
      Origin = 'tblshipment.ShipmentId'
    end
    object qryShipmentGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Origin = 'tblshipment.GlobalRef'
      Size = 255
    end
    object qryShipmentShipAddressId: TIntegerField
      FieldName = 'ShipAddressId'
      Origin = 'tblshipment.ShipAddressId'
    end
    object qryShipmentShipmentListId: TIntegerField
      FieldName = 'ShipmentListId'
      Origin = 'tblshipment.ShipmentListId'
    end
    object qryShipmentMasterTrackingNumber: TWideStringField
      FieldName = 'MasterTrackingNumber'
      Origin = 'tblshipment.MasterTrackingNumber'
      Size = 255
    end
    object qryShipmentPayorAccountNumber: TWideStringField
      FieldName = 'PayorAccountNumber'
      Origin = 'tblshipment.PayorAccountNumber'
      Size = 255
    end
    object qryShipmentPayorCountryCode: TWideStringField
      FieldName = 'PayorCountryCode'
      Origin = 'tblshipment.PayorCountryCode'
      Size = 255
    end
    object qryShipmentPayorType: TIntegerField
      FieldName = 'PayorType'
      Origin = 'tblshipment.PayorType'
    end
    object qryShipmentPayorZipCode: TWideStringField
      FieldName = 'PayorZipCode'
      Origin = 'tblshipment.PayorZipCode'
      Size = 255
    end
    object qryShipmentProvider: TIntegerField
      FieldName = 'Provider'
      Origin = 'tblshipment.Provider'
    end
    object qryShipmentServiceType: TIntegerField
      FieldName = 'ServiceType'
      Origin = 'tblshipment.ServiceType'
    end
    object qryShipmentShipmentSpecialServices: TLargeintField
      FieldName = 'ShipmentSpecialServices'
      Origin = 'tblshipment.ShipmentSpecialServices'
    end
    object qryShipmentActive: TWideStringField
      FieldName = 'Active'
      Origin = 'tblshipment.MIPackageID'
      FixedChar = True
      Size = 1
    end
    object qryShipmentmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
      Origin = 'tblshipment.Endorsement'
    end
    object qryShipmentmsUpdateSiteCode: TWideStringField
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblshipment.Processed'
      Size = 3
    end
    object qryShipmentSenderFirstName: TWideStringField
      FieldName = 'SenderFirstName'
      Origin = 'tblshipment.SenderFirstName'
      Size = 255
    end
    object qryShipmentSenderMiddleInitial: TWideStringField
      FieldName = 'SenderMiddleInitial'
      Origin = 'tblshipment.SenderMiddleInitial'
      Size = 255
    end
    object qryShipmentSenderLastName: TWideStringField
      FieldName = 'SenderLastName'
      Origin = 'tblshipment.SenderLastName'
      Size = 255
    end
    object qryShipmentSenderCompany: TWideStringField
      FieldName = 'SenderCompany'
      Origin = 'tblshipment.SenderCompany'
      Size = 255
    end
    object qryShipmentSenderAddress1: TWideStringField
      FieldName = 'SenderAddress1'
      Origin = 'tblshipment.SenderAddress1'
      Size = 255
    end
    object qryShipmentSenderAddress2: TWideStringField
      FieldName = 'SenderAddress2'
      Origin = 'tblshipment.SenderAddress2'
      Size = 255
    end
    object qryShipmentSenderCity: TWideStringField
      FieldName = 'SenderCity'
      Origin = 'tblshipment.SenderCity'
      Size = 255
    end
    object qryShipmentSenderState: TWideStringField
      FieldName = 'SenderState'
      Origin = 'tblshipment.SenderState'
      Size = 255
    end
    object qryShipmentSenderZipCode: TWideStringField
      FieldName = 'SenderZipCode'
      Origin = 'tblshipment.SenderZipCode'
      Size = 255
    end
    object qryShipmentSenderCountryCode: TWideStringField
      FieldName = 'SenderCountryCode'
      Origin = 'tblshipment.SenderCountryCode'
      Size = 255
    end
    object qryShipmentSenderEmail: TWideStringField
      FieldName = 'SenderEmail'
      Origin = 'tblshipment.SenderEmail'
      Size = 255
    end
    object qryShipmentSenderPhone: TWideStringField
      FieldName = 'SenderPhone'
      Origin = 'tblshipment.SenderPhone'
      Size = 255
    end
    object qryShipmentSenderFax: TWideStringField
      FieldName = 'SenderFax'
      Origin = 'tblshipment.SenderFax'
      Size = 255
    end
    object qryShipmentRecipientFirstName: TWideStringField
      FieldName = 'RecipientFirstName'
      Origin = 'tblshipment.RecipientFirstName'
      Size = 255
    end
    object qryShipmentRecipientMiddleInitial: TWideStringField
      FieldName = 'RecipientMiddleInitial'
      Origin = 'tblshipment.RecipientMiddleInitial'
      Size = 255
    end
    object qryShipmentRecipientLastName: TWideStringField
      FieldName = 'RecipientLastName'
      Origin = 'tblshipment.RecipientLastName'
      Size = 255
    end
    object qryShipmentRecipientCompany: TWideStringField
      FieldName = 'RecipientCompany'
      Origin = 'tblshipment.RecipientCompany'
      Size = 255
    end
    object qryShipmentRecipientAddress1: TWideStringField
      FieldName = 'RecipientAddress1'
      Origin = 'tblshipment.RecipientAddress1'
      Size = 255
    end
    object qryShipmentRecipientAddress2: TWideStringField
      FieldName = 'RecipientAddress2'
      Origin = 'tblshipment.RecipientAddress2'
      Size = 255
    end
    object qryShipmentRecipientCity: TWideStringField
      FieldName = 'RecipientCity'
      Origin = 'tblshipment.RecipientCity'
      Size = 255
    end
    object qryShipmentRecipientState: TWideStringField
      FieldName = 'RecipientState'
      Origin = 'tblshipment.RecipientState'
      Size = 255
    end
    object qryShipmentRecipientZipCode: TWideStringField
      FieldName = 'RecipientZipCode'
      Origin = 'tblshipment.RecipientZipCode'
      Size = 255
    end
    object qryShipmentRecipientCountryCode: TWideStringField
      FieldName = 'RecipientCountryCode'
      Origin = 'tblshipment.RecipientCountryCode'
      Size = 255
    end
    object qryShipmentRecipientEmail: TWideStringField
      FieldName = 'RecipientEmail'
      Origin = 'tblshipment.RecipientEmail'
      Size = 255
    end
    object qryShipmentRecipientPhone: TWideStringField
      FieldName = 'RecipientPhone'
      Origin = 'tblshipment.RecipientPhone'
      Size = 255
    end
    object qryShipmentRecipientFax: TWideStringField
      FieldName = 'RecipientFax'
      Origin = 'tblshipment.RecipientFax'
      Size = 255
    end
    object qryShipmentRecipientAddressValid: TWideStringField
      FieldName = 'RecipientAddressValid'
      Origin = 'tblshipment.RecipientAddressValid'
      FixedChar = True
      Size = 1
    end
    object qryShipmentLabelImageType: TIntegerField
      FieldName = 'LabelImageType'
      Origin = 'tblshipment.LabelImageType'
    end
    object qryShipmentProcessed: TWideStringField
      FieldName = 'Processed'
      Origin = 'tblshipment.MICostCenter'
      FixedChar = True
      Size = 1
    end
    object qryShipmentTotalNetCharge: TFloatField
      FieldName = 'TotalNetCharge'
      Origin = 'tblshipment.TotalNetCharge'
      currency = True
    end
    object qryShipmentTotalBaseCharge: TFloatField
      FieldName = 'TotalBaseCharge'
      Origin = 'tblshipment.TotalBaseCharge'
      currency = True
    end
    object qryShipmentTotalSurcharges: TFloatField
      FieldName = 'TotalSurcharges'
      Origin = 'tblshipment.TotalSurcharges'
      currency = True
    end
    object qryShipmentShipDate: TDateTimeField
      FieldName = 'ShipDate'
      Origin = 'tblshipment.ShipDate'
    end
    object qryShipmentTotalNetChargeNegotiated: TFloatField
      FieldName = 'TotalNetChargeNegotiated'
      Origin = 'tblshipment.TotalNetChargeNegotiated'
      currency = True
    end
    object qryShipmentMICostCenter: TWideStringField
      FieldName = 'MICostCenter'
      Size = 30
    end
    object qryShipmentMIPackageID: TWideStringField
      FieldName = 'MIPackageID'
      Size = 30
    end
    object qryShipmentEndorsement: TIntegerField
      FieldName = 'Endorsement'
    end
    object qryShipmentPackageIDCode: TWideStringField
      FieldName = 'PackageIDCode'
      Size = 255
    end
    object qryShipmentDeliveryData: TDateTimeField
      FieldName = 'DeliveryData'
    end
    object qryShipmentPostageProvider: TIntegerField
      FieldName = 'PostageProvider'
    end
    object qryShipmentDropoffType: TIntegerField
      FieldName = 'DropoffType'
    end
    object qryShipmentProcessedComment: TWideMemoField
      FieldName = 'ProcessedComment'
      BlobType = ftWideMemo
    end
    object qryShipmentDocumentsOnly: TWideStringField
      FieldName = 'DocumentsOnly'
      FixedChar = True
      Size = 1
    end
    object qryShipmentBookingNumber: TWideStringField
      FieldName = 'BookingNumber'
      Size = 255
    end
    object qryShipmentCanceled: TWideStringField
      FieldName = 'Canceled'
      FixedChar = True
      Size = 1
    end
  end
  object dsShipments: TDataSource
    DataSet = qryShipment
    Left = 472
    Top = 32
  end
  object qrySaleLine: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select tblsaleslines.SaleLineId, '
      'tblsaleslines.ProductName, '
      'tblsaleslines.Product_Description as Description, '
      'tblsaleslines.UnitOfMeasureQtySold as UOMSoldQty, '
      'tblsaleslines.UnitOfMeasureShipped as ShippedUOMQty, '
      'tblsaleslines.UnitOfMeasureSaleLines as UOM,'
      'IfNull(SSL2.UOMQty,0) as AllocatedUOMQty,'
      
        'tblsaleslines.UnitOfMeasureShipped - sum(IfNull(SSL1.UOMQty,0)) ' +
        'as UnallocatedUOMQty,'
      'u.Weight, u.Height, u.Length, u.Width '
      'from tblsaleslines'
      
        'left join tblShipmentSaleLine SSL1 on SSL1.SaleLineId = tblsales' +
        'lines.SaleLineID'
      
        'left join tblShipmentSaleLine SSL2 on SSL2.SaleLineId = tblsales' +
        'lines.SaleLineID and SSL2.ShipmentId = :ShipmentId'
      
        'left join tblunitsofmeasure u on u.UnitId = tblsaleslines.UnitOf' +
        'MeasureId'
      'where SaleId = :SaleId'
      'group by tblsaleslines.SaleLineID'
      'order by tblsaleslines.SortId')
    Left = 328
    Top = 432
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ShipmentId'
      end
      item
        DataType = ftUnknown
        Name = 'SaleId'
      end>
    object qrySaleLineProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 15
      FieldName = 'ProductName'
      Origin = 'tblsaleslines.ProductName'
      Size = 60
    end
    object qrySaleLineDescription: TWideStringField
      DisplayWidth = 26
      FieldName = 'Description'
      Origin = 'tblsaleslines.Product_Description'
      Size = 255
    end
    object qrySaleLineUOM: TWideStringField
      DisplayWidth = 6
      FieldName = 'UOM'
      Origin = 'tblsaleslines.UnitofMeasureSaleLines'
      Size = 255
    end
    object qrySaleLineUOMSoldQty: TFloatField
      DisplayLabel = 'Sold Qty'
      DisplayWidth = 10
      FieldName = 'UOMSoldQty'
      Origin = 'tblsaleslines.UnitofMeasureQtySold'
    end
    object qrySaleLineShippedUOMQty: TFloatField
      DisplayLabel = 'Shipped Qty'
      DisplayWidth = 10
      FieldName = 'ShippedUOMQty'
      Origin = 'tblsaleslines.UnitofMeasureShipped'
    end
    object qrySaleLineAllocatedUOMQty: TFloatField
      DisplayLabel = 'Allocated'
      DisplayWidth = 10
      FieldName = 'AllocatedUOMQty'
      Origin = 'AllocatedUOMQty'
      OnSetText = qrySaleLineAllocatedUOMQtySetText
    end
    object qrySaleLineUnallocatedUOMQty: TFloatField
      DisplayLabel = 'Unallocated'
      DisplayWidth = 10
      FieldName = 'UnallocatedUOMQty'
      Origin = 'UnallocatedUOMQty'
    end
    object qrySaleLineWeight: TFloatField
      DisplayWidth = 10
      FieldName = 'Weight'
    end
    object qrySaleLineHeight: TFloatField
      DisplayWidth = 10
      FieldName = 'Height'
    end
    object qrySaleLineLength: TFloatField
      DisplayWidth = 10
      FieldName = 'Length'
    end
    object qrySaleLineWidth: TFloatField
      DisplayWidth = 10
      FieldName = 'Width'
    end
    object qrySaleLineSaleLineId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'SaleLineId'
      Origin = 'tblsaleslines.SaleLineID'
      Visible = False
    end
  end
  object dsSaleLine: TDataSource
    DataSet = qrySaleLine
    Left = 360
    Top = 448
  end
  object qryPackages: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblshipmentpackage')
    BeforePost = qryPackagesBeforePost
    OnCalcFields = qryPackagesCalcFields
    Left = 176
    Top = 376
    object qryPackagesPackageType: TIntegerField
      DisplayLabel = 'Package Type'
      DisplayWidth = 10
      FieldName = 'PackageType'
      Origin = 'tblshipmentpackage.PackageType'
    end
    object qryPackagesPackageWeight: TWideStringField
      DisplayLabel = 'Weight'
      DisplayWidth = 10
      FieldName = 'PackageWeight'
      Origin = 'tblshipmentpackage.PackageWeight'
      Size = 255
    end
    object qryPackagesPackageWeightFrac: TWideStringField
      DisplayWidth = 10
      FieldName = 'PackageWeightFrac'
      Origin = 'tblshipmentpackage.PackageWeightFrac'
      Size = 255
    end
    object qryPackagesPackageHeight: TIntegerField
      DisplayLabel = 'Height'
      DisplayWidth = 10
      FieldName = 'PackageHeight'
      Origin = 'tblshipmentpackage.PackageHeight'
    end
    object qryPackagesPackageLength: TIntegerField
      DisplayLabel = 'Length'
      DisplayWidth = 10
      FieldName = 'PackageLength'
      Origin = 'tblshipmentpackage.PackageLength'
    end
    object qryPackagesPackageWidth: TIntegerField
      DisplayLabel = 'Width'
      DisplayWidth = 10
      FieldName = 'PackageWidth'
      Origin = 'tblshipmentpackage.PackageWidth'
    end
    object qryPackagesPackageCODType: TIntegerField
      DisplayLabel = 'COD Type'
      DisplayWidth = 15
      FieldName = 'PackageCODType'
      Origin = 'tblshipmentpackage.PackageCODType'
    end
    object qryPackagesPackageCODAmount: TFloatField
      DisplayLabel = 'COD Amount'
      DisplayWidth = 10
      FieldName = 'PackageCODAmount'
      Origin = 'tblshipmentpackage.PackageCODAmount'
      currency = True
    end
    object qryPackagesPackageReference: TWideStringField
      DisplayLabel = 'Reference'
      DisplayWidth = 10
      FieldName = 'PackageReference'
      Origin = 'tblshipmentpackage.PackageReference'
      Size = 255
    end
    object qryPackagesPackageTrackingNumber: TWideStringField
      DisplayLabel = 'Tracking Number'
      DisplayWidth = 10
      FieldName = 'PackageTrackingNumber'
      Origin = 'tblshipmentpackage.PackageTrackingNumber'
      Size = 255
    end
    object qryPackagesPackageSignatureType: TIntegerField
      DisplayLabel = 'Signature Type'
      DisplayWidth = 10
      FieldName = 'PackageSignatureType'
      Origin = 'tblshipmentpackage.PackageSignatureType'
    end
    object qryPackagesPackageDangerousGoodsAccessible: TWideStringField
      DisplayLabel = 'Dangerous Goods Accessible'
      DisplayWidth = 1
      FieldName = 'PackageDangerousGoodsAccessible'
      Origin = 'tblshipmentpackage.PackageDangerousGoodsAccessible'
      FixedChar = True
      Size = 1
    end
    object qryPackagesPackageDescription: TWideStringField
      DisplayLabel = 'Package Description'
      DisplayWidth = 10
      FieldName = 'PackageDescription'
      Origin = 'tblshipmentpackage.PackageDescription'
      Size = 255
    end
    object qryPackagesPackageOptNonStandardContainer: TBooleanField
      DisplayLabel = 'Non Std Cntr'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'PackageOptNonStandardContainer'
      OnSetText = qryPackagesPackageOptSetText
      Calculated = True
    end
    object qryPackagesPackageOptAdditionalHandling: TBooleanField
      DisplayLabel = 'Addnl Handling'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'PackageOptAdditionalHandling'
      OnSetText = qryPackagesPackageOptSetText
      Calculated = True
    end
    object qryPackagesPackageOptAppointmentDelivery: TBooleanField
      DisplayLabel = 'Appoint Delivery'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'PackageOptAppointmentDelivery'
      Calculated = True
    end
    object qryPackagesPackageOptDangeriousGoods: TBooleanField
      DisplayLabel = 'Dangerious Goods'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'PackageOptDangeriousGoods'
      Calculated = True
    end
    object qryPackagesPackageOptDryIce: TBooleanField
      DisplayLabel = 'Dry Ice'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'PackageOptDryIce'
      Calculated = True
    end
    object qryPackagesPackageOptPriorityAlert: TBooleanField
      DisplayLabel = 'Priority Alert'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'PackageOptPriorityAlert'
      Calculated = True
    end
    object qryPackagesPackageOptCOD: TBooleanField
      DisplayLabel = 'COD'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'PackageOptCOD'
      Calculated = True
    end
    object qryPackagesPackageOptSignatureOption: TBooleanField
      DisplayLabel = 'Signature Option'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'PackageOptSignatureOption'
      Calculated = True
    end
    object qryPackagesPackageOptAlcohol: TBooleanField
      DisplayLabel = 'Alcohol'
      DisplayWidth = 5
      FieldKind = fkCalculated
      FieldName = 'PackageOptAlcohol'
      Calculated = True
    end
    object qryPackagesPackageBaseCharge: TFloatField
      DisplayLabel = 'Base Charge'
      DisplayWidth = 10
      FieldName = 'PackageBaseCharge'
      Origin = 'tblshipmentpackage.PackageBaseCharge'
    end
    object qryPackagesPackageInsuredValue: TFloatField
      DisplayLabel = 'Insured Value'
      DisplayWidth = 10
      FieldName = 'PackageInsuredValue'
      Origin = 'tblshipmentpackage.PackageInsuredValue'
      currency = True
    end
    object qryPackagesPackageNetCharge: TFloatField
      DisplayLabel = 'Net Charge'
      DisplayWidth = 10
      FieldName = 'PackageNetCharge'
      Origin = 'tblshipmentpackage.PackageNetCharge'
      currency = True
    end
    object qryPackagesPackageSpecialService: TIntegerField
      DisplayLabel = 'Special Service'
      DisplayWidth = 10
      FieldName = 'PackageSpecialService'
      Origin = 'tblshipmentpackage.PackageSpecialService'
    end
    object qryPackagesPackageTotalDiscount: TFloatField
      DisplayLabel = 'Total Discount'
      DisplayWidth = 10
      FieldName = 'PackageTotalDiscount'
      Origin = 'tblshipmentpackage.PackageTotalDiscount'
      currency = True
    end
    object qryPackagesPackageTotalSurcharges: TFloatField
      DisplayLabel = 'Total Surcharges'
      DisplayWidth = 10
      FieldName = 'PackageTotalSurcharges'
      Origin = 'tblshipmentpackage.PackageTotalSurcharges'
      currency = True
    end
    object qryPackagesCommodityDescription: TWideStringField
      DisplayLabel = 'Comm Description'
      DisplayWidth = 15
      FieldName = 'CommodityDescription'
      Origin = 'tblshipmentpackage.CommodityDescription'
      Size = 255
    end
    object qryPackagesCommodityHarmonizedCode: TWideStringField
      DisplayLabel = 'Comm Harmonized Code'
      DisplayWidth = 10
      FieldName = 'CommodityHarmonizedCode'
      Origin = 'tblshipmentpackage.CommodityHarmonizedCode'
      Size = 255
    end
    object qryPackagesCommodityManufacturer: TWideStringField
      DisplayLabel = 'Comm Manufacturer'
      DisplayWidth = 15
      FieldName = 'CommodityManufacturer'
      Origin = 'tblshipmentpackage.CommodityManufacturer'
      Size = 255
    end
    object qryPackagesCommodityNumberOfPieces: TIntegerField
      DisplayLabel = 'Comm Number Of Pieces'
      DisplayWidth = 10
      FieldName = 'CommodityNumberOfPieces'
      Origin = 'tblshipmentpackage.CommodityNumberOfPieces'
    end
    object qryPackagesCommodityQuantityUnit: TWideStringField
      DisplayLabel = 'Comm Quantity Unit'
      DisplayWidth = 10
      FieldName = 'CommodityQuantityUnit'
      Origin = 'tblshipmentpackage.CommodityQuantityUnit'
      Size = 255
    end
    object qryPackagesCommodityQuantity: TIntegerField
      DisplayLabel = 'Comm Quantity'
      DisplayWidth = 10
      FieldName = 'CommodityQuantity'
    end
    object qryPackagesCommodityUnitPrice: TFloatField
      DisplayLabel = 'Comm Unit Price'
      DisplayWidth = 10
      FieldName = 'CommodityUnitPrice'
      Origin = 'tblshipmentpackage.CommodityUnitPrice'
      currency = True
    end
    object qryPackagesCommodityValue: TFloatField
      DisplayLabel = 'Comm Value'
      DisplayWidth = 10
      FieldName = 'CommodityValue'
      Origin = 'tblshipmentpackage.CommodityValue'
      currency = True
    end
    object qryPackagesCommodityWeight: TWideStringField
      DisplayLabel = 'Comm Weight'
      DisplayWidth = 10
      FieldName = 'CommodityWeight'
      Origin = 'tblshipmentpackage.CommodityWeight'
      Size = 255
    end
    object qryPackagesPackageCODLabel: TWideMemoField
      DisplayWidth = 10
      FieldName = 'PackageCODLabel'
      Origin = 'tblshipmentpackage.PackageCODLabel'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryPackagesPackageReturnRecpt: TWideMemoField
      DisplayWidth = 10
      FieldName = 'PackageReturnRecpt'
      Origin = 'tblshipmentpackage.PackageReturnRecpt'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryPackagesShipmentPackageId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ShipmentPackageId'
      Origin = 'tblshipmentpackage.ShipmentPackageId'
      Visible = False
    end
    object qryPackagesGlobalRef: TWideStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Origin = 'tblshipmentpackage.GlobalRef'
      Visible = False
      Size = 255
    end
    object qryPackagesShipmentId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ShipmentId'
      Origin = 'tblshipmentpackage.ShipmentId'
      Visible = False
    end
    object qryPackagesmsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Origin = 'tblshipmentpackage.msTimeStamp'
      Visible = False
    end
    object qryPackagesmsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Origin = 'tblshipmentpackage.msUpdateSiteCode'
      Visible = False
      Size = 3
    end
    object qryPackagesPackageShippingLabel: TBlobField
      DisplayWidth = 10
      FieldName = 'PackageShippingLabel'
      Origin = 'tblshipmentpackage.PackageShippingLabel'
      Visible = False
    end
  end
  object dsPackages: TDataSource
    DataSet = qryPackages
    Left = 280
    Top = 384
  end
  object qrySenderCountryCodeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblCountries order by Country')
    Left = 240
    Top = 304
  end
  object qryRecipientCountryCodeLookup: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblCountries order by Country')
    Left = 800
    Top = 8
  end
  object popPackages: TPopupMenu
    Left = 656
    Top = 348
    object mnuViewShippingLabel: TMenuItem
      Caption = 'View Shipping Label'
      OnClick = mnuViewShippingLabelClick
    end
  end
end
