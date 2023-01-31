inherited fmStockTransferEntry: TfmStockTransferEntry
  Left = 75
  Top = 228
  HelpContext = 1107002
  Caption = 'Stock Transfer'
  ExplicitLeft = 75
  ExplicitTop = 228
  ExplicitWidth = 1010
  ExplicitHeight = 604
  PixelsPerInch = 96
  TextHeight = 15
  inherited shapehint: TShape [0]
  end
  inherited shapehintextra1: TShape [1]
  end
  inherited shapehintextra2: TShape [2]
  end
  inherited imgGridWatermark: TImage [3]
  end
  inherited lblSkingroupMsg: TLabel [4]
  end
  inherited pnlDetail: TDNMPanel [6]
    HelpContext = 1107025
    inherited SubformDetails: TwwDBGrid
      Selected.Strings = (
        'PartBarcode'#9'10'#9'Product Barcode'#9'F'#9
        'ProductName'#9'15'#9'Product Name'#9'F'#9
        'ProductDesc'#9'25'#9'Description'#9'F'#9
        'UOM'#9'5'#9'UOM'#9'F'#9
        'UOMAvailableQty'#9'7'#9'Available'#9'T'#9'Quantity'
        'FormulaQtyValue'#9'10'#9'FormulaQtyValue'#9'F'#9'Quantity'
        'FormulaQtyValue1'#9'10'#9'FormulaQtyValue1'#9'F'#9'Quantity'
        'FormulaQtyValue2'#9'10'#9'FormulaQtyValue2'#9'F'#9'Quantity'
        'FormulaQtyValue3'#9'10'#9'FormulaQtyValue3'#9'F'#9'Quantity'
        'FormulaQtyValue4'#9'10'#9'FormulaQtyValue4'#9'F'#9'Quantity'
        'FormulaQtyValue5'#9'10'#9'FormulaQtyValue5'#9'F'#9'Quantity'
        'UOMTransferQty'#9'7'#9'Transfer'#9'F'#9'Quantity'
        'ClassNameTo'#9'10'#9'Transfer To'#9'F'#9
        'AssetValue'#9'10'#9'Cost'#9'T'#9
        'UOMcost'#9'10'#9'Unit Cost'#9'F'#9
        'BatchNoFrom'#9'1'#9'No'#9'F'#9'Batch From'
        'expiryDateFrom'#9'1'#9'Expiry Date'#9'F'#9'Batch From'
        'BinLocationFrom'#9'1'#9'Location'#9'F'#9'Bin From'
        'BinNumberFrom'#9'1'#9'Number'#9'F'#9'Bin From'
        'BatchNoTo'#9'1'#9'No'#9'F'#9'Batch To'
        'expiryDateTo'#9'1'#9'Expiry Date'#9'F'#9'Batch To'
        'BinLocationTo'#9'1'#9'Location'#9'F'#9'Bin To'
        'BinNumberTo'#9'1'#9'Number'#9'F'#9'Bin To'
        'SerialNumber'#9'100'#9'SerialNumber'#9'F'#9
        'UOMAllocatedQty'#9'10'#9'Available'#9'T'#9'Bin/Batch Quantity'
        'TransferUOMAllocatedQty'#9'10'#9'Transfer'#9'F'#9'Bin/Batch Quantity'
        'TotalCost'#9'10'#9'Total Cost'#9'F'#9
        'CustomerName'#9'20'#9'Customer Job'#9'F'#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
      ExplicitTop = 1
    end
    inherited cboProduct: TERPDbLookupCombo
      DataIDField = 'ProductId'
    end
    inherited cboUOM: TwwDBLookupCombo
      Width = 124
      HelpContext = 1107021
      ExplicitWidth = 124
    end
    inherited cboPrintProduct: TERPDbLookupCombo
      TabOrder = 9
      DataIDField = 'ProductId'
    end
    object cboBatchnumberFrom: TwwDBLookupCombo
      Left = 319
      Top = 150
      Width = 124
      Height = 26
      HelpContext = 1107006
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'batchnumber'#9'50'#9'Batch No'#9'F'
        'ExpiryDate'#9'12'#9'Expiry Date'#9'F')
      DataField = 'BatchNoFrom'
      LookupTable = QryBatchNoFrom
      LookupField = 'batchnumber'
      Options = [loTitles]
      Style = csDropDownList
      AutoSelect = False
      TabOrder = 5
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboBatchnumberFromCloseUp
    end
    object cbobatchnumberto: TwwDBLookupCombo
      Left = 319
      Top = 179
      Width = 124
      Height = 26
      HelpContext = 1107007
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'batchnumber'#9'50'#9'Batch No'#9'F'
        'ExpiryDate'#9'12'#9'Expiry Date'#9'F')
      DataField = 'BatchNoTo'
      LookupTable = QryBatchnoTo
      LookupField = 'batchnumber'
      Options = [loTitles]
      Style = csDropDownList
      AutoSelect = False
      TabOrder = 6
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cbobatchnumbertoCloseUp
    end
    object cboBinLocation: TwwDBLookupCombo
      Left = 319
      Top = 208
      Width = 124
      Height = 26
      HelpContext = 1107008
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'BinLocation'#9'10'#9'Bin Location'#9'F'
        'BinNumber'#9'10'#9'Number'#9'F')
      DataField = 'BinLocationFrom'
      LookupTable = qryBinLocationFrom
      LookupField = 'BinLocation'
      Options = [loTitles]
      AutoSelect = False
      TabOrder = 7
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboBinLocationCloseUp
      OnNotInList = cboBinLocationNotInList
    end
    object cboBinLocationTo: TwwDBLookupCombo
      Left = 319
      Top = 238
      Width = 124
      Height = 23
      HelpContext = 1107009
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ControlType.Strings = (
        'ProductBin;ImageIndex;Shrink To Fit'
        'ProductBinIndex;ImageIndex;Shrink To Fit')
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'BinLocation'#9'10'#9'Bin Location'#9'F'
        'Binnumber'#9'10'#9'Number'#9'F')
      DataField = 'BinLocationTo'
      LookupTable = QrybinLocationTo
      LookupField = 'BinLocation'
      Options = [loTitles]
      Style = csDropDownList
      ParentFont = False
      TabOrder = 8
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboBinLocationToCloseUp
      OnNotInList = cboBinLocationToNotInList
    end
  end
  inherited DNMPanel1: TDNMPanel [7]
    HelpContext = 1107026
    inherited Bevel1: TBevel [0]
      Left = 640
      ExplicitLeft = 640
    end
    inherited lblTransferFrom: TLabel [1]
    end
    inherited Bevel2: TBevel [2]
      Left = 747
      Width = 120
      HelpContext = 1107004
      ExplicitLeft = 747
      ExplicitWidth = 120
    end
    inherited Label160: TLabel [3]
      Left = 752
      Top = 7
      Anchors = [akTop, akRight]
      ExplicitLeft = 752
      ExplicitTop = 7
    end
    inherited Label3: TLabel [4]
      Left = 868
      Top = 7
      Anchors = [akTop, akRight]
      ExplicitLeft = 868
      ExplicitTop = 7
    end
    inherited Label1: TLabel [5]
    end
    inherited lblEnforceUOM: TLabel [6]
      Left = 752
      ExplicitLeft = 752
    end
    inherited Label48: TLabel [7]
    end
    inherited lblprocessed: TLabel [8]
      Left = 146
      Top = 23
      ExplicitLeft = 146
      ExplicitTop = 23
    end
    inherited Label6: TLabel [9]
      Left = 641
      ExplicitLeft = 641
    end
    inherited lblVia: TLabel [10]
    end
    object Bevel3: TBevel [11]
      Left = 868
      Top = 53
      Width = 119
      Height = 44
      HelpContext = 1107022
      Shape = bsFrame
    end
    object Label7: TLabel [12]
      Left = 879
      Top = 60
      Width = 76
      Height = 30
      Hint = 
        'When Ticked this is only showing the Quantity of the selected Un' +
        'it of Measure. Its not displaying the Quantity any other Unit of' +
        ' Measure  for this product'
      HelpContext = 1107005
      Alignment = taRightJustify
      Caption = 'Hide Product Barcode'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    inherited pnlTitle: TDNMPanel
      Left = 402
      Width = 238
      HelpContext = 1107013
      ExplicitLeft = 402
      ExplicitWidth = 238
      inherited TitleShader: TShader
        Width = 234
        HelpContext = 1107014
        ExplicitWidth = 234
        inherited TitleLabel: TLabel
          Width = 234
          HelpContext = 1107015
          Caption = 'Stock Transfer '
          ExplicitWidth = 450
        end
      end
    end
    inherited txtCustomID: TDBEdit
      Left = 752
      Top = 24
      Anchors = [akTop, akRight]
      ExplicitLeft = 752
      ExplicitTop = 24
    end
    inherited wwDBDateTimePicker1: TwwDBDateTimePicker
      Left = 868
      Top = 24
      Anchors = [akTop, akRight]
      ExplicitLeft = 868
      ExplicitTop = 24
    end
    inherited chkEnforceUOM: TwwCheckBox
      Left = 847
      Width = 16
      HelpContext = 1107023
      ExplicitLeft = 847
      ExplicitWidth = 16
    end
    inherited chkHideFormulacolumns: TwwCheckBox
      Left = 725
      Width = 16
      HelpContext = 1107024
      ExplicitLeft = 725
      ExplicitWidth = 16
    end
    inherited cboClassFrom: TwwDBLookupCombo
      Left = 8
      Top = 75
      ExplicitLeft = 8
      ExplicitTop = 75
    end
    object chkhideBarcode: TwwCheckBox
      Left = 967
      Top = 67
      Width = 16
      Height = 16
      HelpContext = 1107020
      DisableThemes = False
      AlwaysTransparent = True
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'T'
      DisplayValueUnchecked = 'F'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 9
      OnClick = chkhideBarcodeClick
    end
  end
  object btnAutoFill: TDNMSpeedButton [8]
    Left = 395
    Top = 527
    Width = 87
    Height = 26
    HelpContext = 1107018
    Anchors = [akBottom]
    Caption = '&Auto Transfer'
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
    TabOrder = 3
    AutoDisableParentOnclick = True
    OnClick = btnAutoFillClick
  end
  inherited DNMPanel2: TDNMPanel [9]
    HelpContext = 1107027
    inherited lbMemo: TLabel [0]
    end
    inherited Label4: TLabel [1]
    end
    inherited Label5: TLabel [2]
    end
    inherited wwDBEdit1: TwwDBEdit
      Width = 736
      HelpContext = 1107016
      ExplicitWidth = 736
    end
    inherited DBMemo1: TDBMemo
      Left = 101
      ExplicitLeft = 101
    end
    inherited btnhold: TDNMSpeedButton
      HelpContext = 1107012
    end
    inherited btnPrint: TDNMSpeedButton
      HelpContext = 1107010
    end
    inherited btncopy: TDNMSpeedButton
      HelpContext = 1107021
    end
    inherited cmdPrintPick: TDNMSpeedButton
      HelpContext = 1107017
    end
    inherited cmdDeliveryDocket: TDNMSpeedButton
      HelpContext = 1107019
    end
    inherited btnClose: TDNMSpeedButton
      HelpContext = 1107011
    end
    inherited pnlChooseRpt: TDNMPanel
      HelpContext = 1107028
      Anchors = [akRight, akBottom]
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 834
    Top = 208
  end
  inherited tmrdelay: TTimer
    Left = 872
    Top = 208
  end
  inherited popSpelling: TPopupMenu
    Left = 533
    Top = 208
  end
  inherited tmrdelayMsg: TTimer
    Left = 496
    Top = 208
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 646
    Top = 208
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 684
    Top = 208
  end
  inherited MyConnection: TERPConnection
    Left = 34
    Top = 167
  end
  inherited DataState: TDataState
    Left = 721
    Top = 208
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 571
    Top = 208
  end
  inherited imgsort: TImageList
    Left = 759
    Top = 208
    Bitmap = {
      494C010102000001600110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 34
    Top = 214
  end
  inherited ProgressDialogOBJ: TProgressDialog
    Left = 796
    Top = 208
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 608
    Top = 208
  end
  inherited qryMemTrans: TERPQuery
    Left = 69
    Top = 214
  end
  inherited tblMaster: TERPQuery
    AfterInsert = tblMasterAfterInsert
    Left = 141
    Top = 214
  end
  inherited tblDetails: TERPQuery
    AfterOpen = tblDetailsAfterOpen
    Left = 177
    Top = 214
    object tblDetailsBatchNoFrom: TWideStringField [15]
      DisplayLabel = 'No'
      DisplayWidth = 1
      FieldName = 'BatchNoFrom'
      Origin = 'tblstocktransferEntrylines.BatchNoFrom'
      Size = 50
    end
    object tblDetailsexpiryDateFrom: TDateTimeField [16]
      DisplayLabel = 'Expiry Date'
      DisplayWidth = 1
      FieldName = 'expiryDateFrom'
      Origin = 'tblstocktransferEntrylines.expiryDateFrom'
    end
    object tblDetailsBinLocationFrom: TWideStringField [17]
      DisplayLabel = 'Location'
      DisplayWidth = 1
      FieldName = 'BinLocationFrom'
      Origin = 'tblstocktransferEntrylines.BinLocationFrom'
      Size = 30
    end
    object tblDetailsBinNumberFrom: TWideStringField [18]
      DisplayLabel = 'Number'
      DisplayWidth = 1
      FieldName = 'BinNumberFrom'
      Origin = 'tblstocktransferEntrylines.BinNumberFrom'
      Size = 30
    end
    object tblDetailsBatchNoTo: TWideStringField [19]
      DisplayLabel = 'No'
      DisplayWidth = 1
      FieldName = 'BatchNoTo'
      Origin = 'tblstocktransferEntrylines.BatchNoTo'
      Size = 50
    end
    object tblDetailsexpiryDateTo: TDateTimeField [20]
      DisplayLabel = 'Expiry Date'
      DisplayWidth = 1
      FieldName = 'expiryDateTo'
      Origin = 'tblstocktransferEntrylines.expiryDateTo'
    end
    object tblDetailsBinLocationTo: TWideStringField [21]
      DisplayLabel = 'Location'
      DisplayWidth = 1
      FieldName = 'BinLocationTo'
      Origin = 'tblstocktransferEntrylines.BinLocationTo'
      Size = 30
    end
    object tblDetailsBinNumberTo: TWideStringField [22]
      DisplayLabel = 'Number'
      DisplayWidth = 1
      FieldName = 'BinNumberTo'
      Origin = 'tblstocktransferEntrylines.BinNumberTo'
      Size = 30
    end
    object tblDetailsSerialNumber: TWideStringField [23]
      DisplayWidth = 100
      FieldName = 'SerialNumber'
      Size = 100
    end
    object tblDetailsUOMAllocatedQty: TFloatField [24]
      DisplayLabel = 'Available'
      DisplayWidth = 10
      FieldName = 'UOMAllocatedQty'
    end
    object tblDetailsTransferUOMAllocatedQty: TFloatField [25]
      DisplayLabel = 'Transfer'
      DisplayWidth = 10
      FieldName = 'TransferUOMAllocatedQty'
    end
    inherited tblDetailsGlobalRef: TWideStringField [26]
    end
    inherited tblDetailsTransferEntryLinesID: TIntegerField [27]
    end
    object tblDetailsAllocatedQty: TFloatField [28]
      DisplayWidth = 10
      FieldName = 'AllocatedQty'
      Visible = False
    end
    object tblDetailsTransferAllocatedQty: TFloatField [29]
      DisplayWidth = 10
      FieldName = 'TransferAllocatedQty'
      Visible = False
    end
    inherited tblDetailsclientID: TIntegerField [30]
    end
    inherited tblDetailsAccountID: TIntegerField [31]
    end
    inherited tblDetailsTransferEntryID: TIntegerField [32]
    end
    inherited tblDetailsClassIDTo: TIntegerField [33]
    end
    inherited tblDetailsEmployeeID: TIntegerField [34]
    end
    inherited tblDetailsProductID: TIntegerField [35]
    end
    inherited tblDetailsUOMID: TIntegerField [36]
    end
    inherited tblDetailsUOMMultiplier: TFloatField [37]
    end
    inherited tblDetailsTotalCost: TFloatField [38]
    end
    inherited tblDetailsAvailableQty: TFloatField [39]
    end
    inherited tblDetailsCustomerName: TWideStringField [40]
    end
    object tblDetailsProductPrintName: TWideStringField
      DisplayWidth = 20
      FieldName = 'ProductPrintName'
      Visible = False
      Size = 255
    end
    object tblDetailsSerialnos: TWideMemoField
      DisplayLabel = 'Serial Nos'
      FieldName = 'Serialnos'
      Visible = False
      BlobType = ftWideMemo
    end
  end
  inherited DSMaster: TDataSource
    Left = 142
    Top = 248
  end
  inherited DSDetails: TDataSource
    Left = 175
    Top = 249
  end
  inherited cboClassFromQry: TERPQuery
    Left = 105
    Top = 214
  end
  inherited cboAccountQry: TERPQuery
    Left = 249
    Top = 214
  end
  inherited cboEmployeeLookup: TERPQuery
    Left = 285
    Top = 214
  end
  inherited cboViaQry: TERPQuery
    Left = 213
    Top = 214
  end
  object QryBatchnoTo: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        '/*select distinct  tblPQADetails.value as Batchnumber, tblPQADet' +
        'ails.expiryDate '
      
        'from tblPQADetails inner join tblPQA on  tblPQA.PQAID = tblPQADe' +
        'tails.PQAID '
      'where tblPQADetails.PQAtype = '#39'Batch'#39'  */'
      'select Distinct tblPQADetails.value as Batchnumber, '
      
        'DATE_FORMAT(ifnull(tblPQADetails.expiryDate , 0),'#39'%d-%m-%Y'#39') as ' +
        'ExpiryDate'
      
        'from tblPQADetails inner join tblPQA on  tblPQA.PQAID = tblPQADe' +
        'tails.PQAID '
      'where tblPQADetails.PQAtype = '#39'Batch'#39' '
      
        'and tblPQA.ProductID = :PartsID and tblPQA.DepartmentID = :Class' +
        'ID')
    Options.LongStrings = False
    Options.FlatBuffers = True
    Left = 454
    Top = 277
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PartsID'
        Value = 0
      end
      item
        DataType = ftUnknown
        Name = 'ClassID'
      end>
    object QryBatchNoTobatchnumber: TWideStringField
      DisplayLabel = 'Batch No'
      DisplayWidth = 50
      FieldName = 'batchnumber'
      Origin = 'tblPQADetails.Value'
      Size = 100
    end
    object QryBatchnoToExpiryDate: TWideStringField
      DisplayLabel = 'Expiry Date'
      DisplayWidth = 12
      FieldName = 'ExpiryDate'
      Origin = '.ExpiryDate'
      Size = 10
    end
  end
  object QryBatchNoFrom: TERPQuery
    SQL.Strings = (
      
        '/*select Distinct tblPQADetails.value as Batchnumber, ifnull(tbl' +
        'PQADetails.expiryDate , 0) as ExpiryDate'
      
        'from tblPQADetails inner join tblPQA on  tblPQA.PQAID = tblPQADe' +
        'tails.PQAID '
      'where tblPQADetails.PQAtype = '#39'Batch'#39'  */'
      'select Distinct tblPQADetails.value as Batchnumber, '
      
        'DATE_FORMAT(ifnull(tblPQADetails.expiryDate , 0),'#39'%d-%m-%Y'#39') as ' +
        'ExpiryDate'
      
        'from tblPQADetails inner join tblPQA on  tblPQA.PQAID = tblPQADe' +
        'tails.PQAID '
      'where tblPQADetails.PQAtype = '#39'Batch'#39' '
      
        'and tblPQA.ProductID = :PartsID and tblPQA.DepartmentID = :Class' +
        'ID')
    Options.LongStrings = False
    Options.FlatBuffers = True
    Left = 454
    Top = 247
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PartsID'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ClassID'
        Value = 0
      end>
    object QryBatchNoFrombatchnumber: TWideStringField
      DisplayLabel = 'Batch No'
      DisplayWidth = 50
      FieldName = 'batchnumber'
      Origin = 'batchnumber'
      Size = 30
    end
    object QryBatchNoFromExpiryDate: TWideStringField
      DisplayLabel = 'Expiry Date'
      DisplayWidth = 12
      FieldName = 'ExpiryDate'
      Size = 30
    end
  end
  object qryBinLocationFrom: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select distinct tblProductbin.Binlocation, tblProductbin.Binnumb' +
        'er'
      
        'from tblPQADetails inner join tblPQA on  tblPQA.PQAID = tblPQADe' +
        'tails.PQAID '
      
        'inner join tblProductbin on tblProductbin.binId = tblPQADetails.' +
        'Value'
      'where tblPQADetails.PQAtype = '#39'Bin'#39'  '
      'and tblProductbin.Active = '#39'T'#39
      
        'and tblPQA.ProductID =:PartsId and tblProductbin.classID = :Clas' +
        'sID')
    Options.LongStrings = False
    Options.FlatBuffers = True
    Left = 454
    Top = 307
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PartsId'
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ClassID'
        Value = 0
      end>
    object qryBinLocationFromBinLocation: TWideStringField
      DisplayLabel = 'Bin Location'
      DisplayWidth = 10
      FieldName = 'BinLocation'
      Origin = 'tblProductbin.BinLocation'
      Size = 30
    end
    object qryBinLocationFromBinnumber: TWideStringField
      DisplayLabel = 'Number'
      DisplayWidth = 10
      FieldName = 'Binnumber'
      Origin = 'tblProductbin.BinNumber'
      Size = 30
    end
  end
  object QrybinLocationTo: TERPQuery
    SQL.Strings = (
      
        'select distinct tblProductbin.Binlocation, tblProductbin.Binnumb' +
        'er'
      
        'from tblProductbin where  tblProductbin.classID = :classid order' +
        ' by binlocation , Binnumber')
    Options.LongStrings = False
    Options.FlatBuffers = True
    Left = 454
    Top = 337
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ClassID'
        Value = 0
      end>
    object QrybinLocationToBinLocation: TWideStringField
      DisplayLabel = 'Bin Location'
      DisplayWidth = 10
      FieldName = 'BinLocation'
      Size = 25
    end
    object QrybinLocationToBinnumber: TWideStringField
      DisplayLabel = 'Number'
      DisplayWidth = 10
      FieldName = 'Binnumber'
      Size = 30
    end
  end
end
