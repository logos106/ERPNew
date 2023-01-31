object FmStsPreference: TFmStsPreference
  Left = 580
  Top = 269
  Caption = 'FmStsPreference'
  ClientHeight = 579
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    584
    579)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlStSConfig: TDNMPanel
    Left = 10
    Top = 2
    Width = 551
    Height = 569
    HelpContext = 1686003
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Bevel1: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 537
      Height = 555
      HelpContext = 1686004
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitHeight = 417
    end
    object lblTitle: TLabel
      Left = 14
      Top = 14
      Width = 72
      Height = 15
      HelpContext = 1686005
      Caption = 'Seed To sale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label8: TLabel
      Left = 91
      Top = 97
      Width = 100
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Plant Tag Product'
      Transparent = True
    end
    object Label1: TLabel
      Left = 70
      Top = 141
      Width = 121
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Package Tag Product'
      Transparent = True
    end
    object Label2: TLabel
      Left = 15
      Top = 184
      Width = 174
      Height = 15
      HelpContext = 26007
      Alignment = taRightJustify
      Caption = 'Seed to Sale Reporting Agency'
      Transparent = True
    end
    object Label3: TLabel
      Left = 106
      Top = 228
      Width = 83
      Height = 15
      HelpContext = 26007
      Alignment = taRightJustify
      Caption = 'Stock Account'
      Transparent = True
    end
    object Label4: TLabel
      Left = 114
      Top = 316
      Width = 75
      Height = 15
      HelpContext = 26007
      Alignment = taRightJustify
      Caption = 'Default Class'
      Transparent = True
    end
    object Label5: TLabel
      Left = 76
      Top = 359
      Width = 113
      Height = 15
      HelpContext = 26007
      Alignment = taRightJustify
      Caption = 'Default Weight UOM'
      Transparent = True
    end
    object Label6: TLabel
      Left = 98
      Top = 397
      Width = 91
      Height = 15
      HelpContext = 26007
      Alignment = taRightJustify
      Caption = 'Metrc Base URL'
      Transparent = True
    end
    object Label7: TLabel
      Left = 54
      Top = 435
      Width = 135
      Height = 15
      HelpContext = 26007
      Alignment = taRightJustify
      Caption = 'Facility License Number'
      Transparent = True
    end
    object Label9: TLabel
      Left = 103
      Top = 473
      Width = 86
      Height = 15
      HelpContext = 26007
      Alignment = taRightJustify
      Caption = 'Vendor API Key'
      Transparent = True
    end
    object Label10: TLabel
      Left = 113
      Top = 511
      Width = 76
      Height = 15
      HelpContext = 26007
      Alignment = taRightJustify
      Caption = 'User API Key '
      Transparent = True
    end
    object edtStSPackageTagProduct: TEdit
      Left = 200
      Top = 137
      Width = 298
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnChange = edtStSPackageTagProductChange
    end
    object chkUseSeedToSale: TwwCheckBox
      Left = 74
      Top = 54
      Width = 141
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Enable Seed to Sale'
      TabOrder = 1
      OnClick = chkUseSeedToSaleClick
    end
    object edtStSPlantTagProduct: TEdit
      Left = 200
      Top = 93
      Width = 298
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
      OnChange = edtStSPlantTagProductChange
    end
    object btnStSPackageTagProduct: TDNMSpeedButton
      Left = 504
      Top = 93
      Width = 33
      Height = 23
      Hint = 'Select Product from List'
      HelpContext = 251005
      Cancel = True
      Caption = '.  .  .'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 3
      AutoDisableParentOnclick = True
      OnClick = btnStSPackageTagProductClick
    end
    object btnStSPlantTagProduct: TDNMSpeedButton
      Left = 504
      Top = 137
      Width = 33
      Height = 23
      Hint = 'Select Product from List'
      HelpContext = 251005
      Cancel = True
      Caption = '.  .  .'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnStSPlantTagProductClick
    end
    object edtStSSupplier: TEdit
      Left = 200
      Top = 180
      Width = 298
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      OnChange = edtStSSupplierChange
    end
    object btnStSSupplier: TDNMSpeedButton
      Left = 504
      Top = 180
      Width = 33
      Height = 23
      Hint = 'Select Supplier from List'
      HelpContext = 251005
      Cancel = True
      Caption = '.  .  .'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 6
      AutoDisableParentOnclick = True
      OnClick = btnStSSupplierClick
    end
    object edtStSStockAccount: TEdit
      Left = 200
      Top = 224
      Width = 298
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
      OnChange = edtStSStockAccountChange
    end
    object btnStSStockAccount: TDNMSpeedButton
      Left = 504
      Top = 224
      Width = 33
      Height = 23
      Hint = 'Select Supplier from List'
      HelpContext = 251005
      Cancel = True
      Caption = '.  .  .'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 8
      AutoDisableParentOnclick = True
      OnClick = btnStSStockAccountClick
    end
    object btnInitDefaults: TDNMSpeedButton
      Left = 361
      Top = 51
      Width = 153
      Height = 23
      Caption = 'Intialise with Defaults'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'Tahoma'
      HotTrackFont.Style = []
      TabOrder = 9
      AutoDisableParentOnclick = True
      OnClick = btnInitDefaultsClick
    end
    object chkStSUsesBins: TwwCheckBox
      Left = 39
      Top = 269
      Width = 176
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Seed to Sale Uses Rooms'
      TabOrder = 11
      OnClick = chkStSUsesBinsClick
    end
    object chkStSSimpleMode: TwwCheckBox
      Left = 397
      Top = 269
      Width = 101
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Simple Mode'
      TabOrder = 10
      OnClick = chkStSSimpleModeClick
    end
    object edtStSDefaultClass: TEdit
      Left = 200
      Top = 312
      Width = 298
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 12
      OnChange = edtStSDefaultClassChange
    end
    object btnStSDefaultClass: TDNMSpeedButton
      Left = 504
      Top = 312
      Width = 33
      Height = 23
      Hint = 'Select Supplier from List'
      HelpContext = 251005
      Cancel = True
      Caption = '.  .  .'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      ParentFont = False
      TabOrder = 13
      AutoDisableParentOnclick = True
      OnClick = btnStSDefaultClassClick
    end
    object cboUOM: TComboBox
      Left = 200
      Top = 355
      Width = 298
      Height = 23
      HelpContext = 469024
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      OnChange = cboUOMChange
    end
    object edtstsbaseurl: TEdit
      Left = 200
      Top = 394
      Width = 298
      Height = 23
      TabOrder = 15
    end
    object edtstslicensenumber: TEdit
      Left = 200
      Top = 433
      Width = 298
      Height = 23
      TabOrder = 16
    end
    object edtstsvendorapikey: TEdit
      Left = 200
      Top = 472
      Width = 298
      Height = 23
      TabOrder = 17
    end
    object edtstsuserapikey: TEdit
      Left = 200
      Top = 512
      Width = 298
      Height = 23
      TabOrder = 18
    end
  end
end
