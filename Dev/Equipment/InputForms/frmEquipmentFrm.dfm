inherited frmEquipment: TfrmEquipment
  Left = 749
  Top = 162
  HelpContext = 652000
  Caption = 'Equipment'
  ClientHeight = 461
  ClientWidth = 452
  OldCreateOrder = True
  ExplicitLeft = 749
  ExplicitTop = 162
  ExplicitWidth = 468
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 461
    Width = 452
    HelpContext = 652006
    ExplicitTop = 461
    ExplicitWidth = 452
  end
  object DNMPanel1: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 452
    Height = 461
    HelpContext = 652007
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
    DesignSize = (
      452
      461)
    object Label1: TLabel
      Left = 24
      Top = 76
      Width = 33
      Height = 15
      HelpContext = 652001
      Caption = 'Name'
      Transparent = True
    end
    object lblProduct: TLabel
      Left = 241
      Top = 76
      Width = 45
      Height = 15
      HelpContext = 652022
      Caption = 'Product'
      Transparent = True
    end
    object Label2: TLabel
      Left = 24
      Top = 127
      Width = 65
      Height = 15
      HelpContext = 652002
      Caption = 'Description'
      Transparent = True
    end
    object Label4: TLabel
      Left = 24
      Top = 178
      Width = 72
      Height = 15
      HelpContext = 652023
      Caption = 'Manufacture'
      Transparent = True
    end
    object Label6: TLabel
      Left = 24
      Top = 228
      Width = 166
      Height = 15
      HelpContext = 652024
      Caption = 'Spare Parts of the Equipment'
      Transparent = True
    end
    object Label5: TLabel
      Left = 249
      Top = 178
      Width = 52
      Height = 15
      HelpContext = 652025
      Caption = 'Model No'
      Transparent = True
    end
    object Label3: TLabel
      Left = 381
      Top = 415
      Width = 35
      Height = 15
      HelpContext = 652003
      Anchors = [akBottom]
      Caption = 'Active'
      Transparent = True
    end
    object grdSpareParts: TwwDBGrid
      Left = 24
      Top = 248
      Width = 407
      Height = 161
      Hint = 
        'This is a List of Products That Can Be Used On or By  The Equipm' +
        'ent'
      HelpContext = 652008
      ControlType.Strings = (
        'Active;CheckBox;T;F'
        'ProductName;CustomEdit;cboProductR;F')
      Selected.Strings = (
        'ProductName'#9'20'#9'Product'#9#9
        'PARTSDESCRIPTION'#9'26'#9'Description'#9'T'
        'Active'#9'1'#9'Active'#9#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow]
      IniAttributes.Delimiter = ';;'
      TitleColor = clWhite
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsEquipmentParts
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      KeyOptions = [dgEnterToTab, dgAllowInsert]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgRowResize]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = True
      OnExit = grdSparePartsExit
      FooterColor = clWhite
      FooterCellColor = clWhite
      PaintOptions.BackgroundOptions = [coBlendFixedRow]
    end
    object edName: TwwDBEdit
      Left = 24
      Top = 91
      Width = 205
      Height = 23
      HelpContext = 652004
      DataField = 'EquipmentName'
      DataSource = DSEquipment
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboProduct: TwwDBLookupCombo
      Left = 241
      Top = 91
      Width = 190
      Height = 23
      Hint = 'Used For Buying and Selling Equipment'
      HelpContext = 652009
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Name'#9'F'
        'Manuf'#9'10'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'10'#9'Dept'#9'F'
        'PARTSDESCRIPTION'#9'50'#9'PARTSDESCRIPTION'#9'F')
      DataField = 'Productname'
      DataSource = DSEquipment
      LookupTable = QryLinkedProduct
      LookupField = 'PARTNAME'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      DropDownWidth = 780
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboProductCloseUp
    end
    object edDescription: TwwDBEdit
      Left = 24
      Top = 142
      Width = 407
      Height = 23
      HelpContext = 652005
      DataField = 'EquipmentDescription'
      DataSource = DSEquipment
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object cboManufacture: TwwDBLookupCombo
      Left = 24
      Top = 195
      Width = 205
      Height = 23
      HelpContext = 652010
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'30'#9'Name'#9'F')
      DataField = 'Manufacture'
      DataSource = DSEquipment
      LookupTable = qryManufacture
      LookupField = 'Name'
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboManufactureCloseUp
      OnNotInList = cboManufactureNotInList
    end
    object pnlTitle: TDNMPanel
      Left = 137
      Top = 9
      Width = 208
      Height = 42
      HelpContext = 652011
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Invoice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 10
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 206
        Height = 40
        HelpContext = 652012
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
          Width = 206
          Height = 40
          HelpContext = 652013
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Equipment'
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
    object btnSave: TDNMSpeedButton
      Left = 47
      Top = 418
      Width = 87
      Height = 27
      HelpContext = 652014
      Anchors = [akBottom]
      Caption = '&Save'
      Default = True
      DisableTransparent = False
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
      TabOrder = 7
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 280
      Top = 417
      Width = 86
      Height = 28
      HelpContext = 652015
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
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
      TabOrder = 9
      OnClick = btnCancelClick
    end
    object btnNew: TDNMSpeedButton
      Left = 163
      Top = 418
      Width = 87
      Height = 27
      HelpContext = 652016
      Anchors = [akBottom]
      Caption = '&New'
      DisableTransparent = False
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      TabOrder = 8
      OnClick = btnNewClick
    end
    object chkActive: TwwCheckBox
      Left = 391
      Top = 428
      Width = 17
      Height = 17
      HelpContext = 652017
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
      NullAndBlankState = cbChecked
      Anchors = [akBottom]
      Caption = 'chkActive'
      Checked = True
      DataField = 'Active'
      DataSource = DSEquipment
      State = cbChecked
      TabOrder = 6
    end
    object cboProductR: TwwDBLookupCombo
      Left = 295
      Top = 386
      Width = 113
      Height = 23
      HelpContext = 652018
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PARTNAME'#9'15'#9'Name'#9'F'
        'Manuf'#9'10'#9'Manuf'#9'F'
        'Type'#9'15'#9'Type'#9'F'
        'Dept'#9'10'#9'Dept'#9'F'
        'PARTSDESCRIPTION'#9'50'#9'PARTSDESCRIPTION'#9'F')
      DataField = 'ProductName'
      DataSource = dsEquipmentParts
      LookupTable = qryParts
      LookupField = 'PARTNAME'
      Options = [loColLines, loTitles, loFixedDropDownHeight, loSearchOnBackspace]
      DropDownWidth = 780
      ParentFont = False
      TabOrder = 11
      AutoDropDown = True
      ShowButton = True
      OrderByDisplay = False
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboProductRCloseUp
    end
    object cboModel: TwwDBLookupCombo
      Left = 249
      Top = 195
      Width = 182
      Height = 23
      HelpContext = 652019
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Name'#9'30'#9'Name'#9'F')
      DataField = 'Model'
      DataSource = DSEquipment
      LookupTable = qryModel
      LookupField = 'Name'
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnNotInList = cboModelNotInList
    end
    object Panel1: TPanel
      Left = 18
      Top = 129
      Width = 417
      Height = 141
      HelpContext = 652020
      Color = clNavy
      ParentBackground = False
      TabOrder = 12
      Visible = False
      object Label7: TLabel
        Left = 1
        Top = 1
        Width = 415
        Height = 139
        HelpContext = 652021
        Align = alClient
        Alignment = taCenter
        Caption = 'This form is Deleted .  Please use '#39'frmEquip'#39' instead'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -37
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitWidth = 395
        ExplicitHeight = 132
      end
    end
  end
  inherited MyConnection: TERPConnection
    Connected = True
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102002000300010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object DSEquipment: TDataSource
    DataSet = qryEquipment
    Left = 56
    Top = 345
  end
  object qryEquipment: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblequipment'
      'WHERE EquipmentID=:KeyID')
    Left = 56
    Top = 377
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object qryEquipmentGlobalRef: TWideStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
    object qryEquipmentEquipmentID: TIntegerField
      FieldName = 'EquipmentID'
    end
    object qryEquipmentEquipmentName: TWideStringField
      FieldName = 'EquipmentName'
      Size = 50
    end
    object qryEquipmentEquipmentDescription: TWideStringField
      FieldName = 'EquipmentDescription'
      Size = 100
    end
    object qryEquipmentEditedFlag: TWideStringField
      FieldName = 'EditedFlag'
      FixedChar = True
      Size = 1
    end
    object qryEquipmentActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryEquipmentmsTimeStamp: TDateTimeField
      FieldName = 'msTimeStamp'
    end
    object qryEquipmentProductId: TLargeintField
      FieldName = 'ProductId'
    end
    object qryEquipmentManufacture: TWideStringField
      FieldName = 'Manufacture'
      Size = 100
    end
    object qryEquipmentModel: TWideStringField
      FieldName = 'Model'
      Size = 100
    end
    object qryEquipmentManufactureID: TIntegerField
      FieldName = 'ManufactureID'
    end
    object qryEquipmentProductname: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Productname'
      LookupDataSet = QryLinkedProduct
      LookupKeyFields = 'PARTSID'
      LookupResultField = 'PARTNAME'
      KeyFields = 'ProductId'
      Lookup = True
    end
  end
  object qryManufacture: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select ID, Name from tblManufacture where Active = '#39'T'#39
      'order by name')
    Options.LongStrings = False
    Left = 253
    Top = 377
    object qryManufactureName: TWideStringField
      DisplayWidth = 30
      FieldName = 'Name'
      Size = 30
    end
    object qryManufactureID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
  end
  object QryEquipmentParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblequipmentParts'
      'WHERE EquipmentID=:KeyID')
    Left = 95
    Top = 377
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'KeyID'
      end>
    object QryEquipmentPartsProductName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 20
      FieldName = 'ProductName'
      Origin = 'tblequipmentParts.ProductName'
      Size = 100
    end
    object QryEquipmentPartsPARTSDESCRIPTION: TWideStringField
      DisplayLabel = 'Description'
      DisplayWidth = 26
      FieldName = 'PARTSDESCRIPTION'
      Origin = 'tblequipmentParts.PARTSDESCRIPTION'
      Size = 255
    end
    object QryEquipmentPartsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tblequipmentParts.Active'
      FixedChar = True
      Size = 1
    end
    object QryEquipmentPartsGlobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'Globalref'
      Origin = 'tblequipmentParts.Globalref'
      Visible = False
      Size = 255
    end
    object QryEquipmentPartsID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tblequipmentParts.ID'
      Visible = False
    end
    object QryEquipmentPartsEquipmentId: TIntegerField
      DisplayWidth = 10
      FieldName = 'EquipmentId'
      Origin = 'tblequipmentParts.EquipmentId'
      Visible = False
    end
    object QryEquipmentPartsEquipmentname: TWideStringField
      DisplayWidth = 100
      FieldName = 'Equipmentname'
      Origin = 'tblequipmentParts.Equipmentname'
      Visible = False
      Size = 100
    end
    object QryEquipmentPartsProductId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ProductId'
      Origin = 'tblequipmentParts.ProductId'
      Visible = False
    end
    object QryEquipmentPartsmstimestamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'mstimestamp'
      Origin = 'tblequipmentParts.mstimestamp'
      Visible = False
    end
  end
  object dsEquipmentParts: TDataSource
    DataSet = QryEquipmentParts
    Left = 95
    Top = 345
  end
  object qryParts: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'PARTSID,PARTNAME, PARTSDESCRIPTION'
      'FROM tblparts p'
      'ORDER By PartName')
    Left = 134
    Top = 377
    object qryPartsPARTSID: TIntegerField
      FieldName = 'PARTSID'
    end
    object qryPartsPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Size = 60
    end
    object qryPartsPARTSDESCRIPTION: TWideStringField
      FieldName = 'PARTSDESCRIPTION'
      Size = 255
    end
  end
  object QryLinkedProduct: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT'
      'PARTSID,PARTNAME'
      'FROM tblparts p'
      'ORDER By PartName')
    Left = 213
    Top = 377
    object QryLinkedProductPARTSID: TIntegerField
      FieldName = 'PARTSID'
    end
    object QryLinkedProductPARTNAME: TWideStringField
      FieldName = 'PARTNAME'
      Size = 60
    end
  end
  object qryModel: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'select * from tblModel where Active = "T"'
      'order by Name')
    Left = 174
    Top = 377
  end
end
