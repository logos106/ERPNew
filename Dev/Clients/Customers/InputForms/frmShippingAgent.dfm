inherited fmShippingAgent: TfmShippingAgent
  Left = 726
  Top = 259
  HelpContext = 748000
  Caption = 'Shipping Agent'
  ClientHeight = 265
  ClientWidth = 436
  OldCreateOrder = True
  ExplicitLeft = 726
  ExplicitTop = 259
  ExplicitWidth = 452
  ExplicitHeight = 304
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 215
    Width = 436
    HelpContext = 748004
    ExplicitTop = 215
    ExplicitWidth = 436
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 215
    Width = 436
    Height = 50
    HelpContext = 748002
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      436
      50)
    object Label1: TLabel
      Left = 387
      Top = 14
      Width = 43
      Height = 17
      HelpContext = 748008
      Alignment = taCenter
      AutoSize = False
      Caption = 'Active'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object btnSave: TDNMSpeedButton
      Left = 51
      Top = 14
      Width = 87
      Height = 27
      Hint = 'Save this Address against this client and Close'
      HelpContext = 748009
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
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 285
      Top = 14
      Width = 87
      Height = 27
      Hint = 'Cancel and Close'
      HelpContext = 748010
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
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object chkActive: TwwCheckBox
      Left = 401
      Top = 28
      Width = 14
      Height = 15
      HelpContext = 748011
      DisableThemes = False
      AlwaysTransparent = True
      Frame.Enabled = True
      Frame.Transparent = True
      Frame.FocusBorders = []
      Frame.NonFocusBorders = []
      ValueChecked = 'T'
      ValueUnchecked = 'F'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbChecked
      Caption = 'chkActive'
      Checked = True
      DataField = 'Active'
      DataSource = dscMain
      State = cbChecked
      TabOrder = 3
    end
    object cmdNew: TDNMSpeedButton
      Left = 168
      Top = 14
      Width = 87
      Height = 27
      HelpContext = 748012
      Anchors = []
      Caption = '&New'
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
      ParentFont = False
      TabOrder = 1
      OnClick = cmdNewClick
    end
  end
  object DNMPanel1: TDNMPanel [6]
    Left = 0
    Top = 50
    Width = 436
    Height = 165
    HelpContext = 748001
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label2: TLabel
      Left = 90
      Top = 21
      Width = 29
      Height = 15
      HelpContext = 748013
      Alignment = taRightJustify
      Caption = 'Code'
      Transparent = True
    end
    object Label3: TLabel
      Left = 54
      Top = 54
      Width = 65
      Height = 15
      HelpContext = 748014
      Alignment = taRightJustify
      Caption = 'Description'
      Transparent = True
    end
    object lblSupplier: TLabel
      Left = 62
      Top = 90
      Width = 57
      Height = 15
      HelpContext = 748015
      Alignment = taRightJustify
      Caption = 'Insurance'
      Transparent = True
    end
    object Label4: TLabel
      Left = 79
      Top = 123
      Width = 40
      Height = 15
      HelpContext = 748016
      Alignment = taRightJustify
      Caption = 'Weight'
      Transparent = True
    end
    object Label5: TLabel
      Left = 295
      Top = 123
      Width = 24
      Height = 15
      HelpContext = 748017
      Alignment = taRightJustify
      Caption = 'Size'
      Transparent = True
    end
    object edtCode: TwwDBEdit
      Left = 122
      Top = 17
      Width = 52
      Height = 23
      HelpContext = 748018
      DataField = 'Code'
      DataSource = dscMain
      Font.Charset = DEFAULT_CHARSET
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
    object edtDescription: TwwDBEdit
      Left = 122
      Top = 50
      Width = 300
      Height = 23
      HelpContext = 748019
      DataField = 'Description'
      DataSource = dscMain
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
    end
    object DefaultWeightUOM: TwwDBLookupCombo
      Left = 122
      Top = 119
      Width = 100
      Height = 23
      HelpContext = 748020
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'unitname'#9'15'#9'unitname'#9'F')
      DataField = 'DefaultWeightUOM'
      DataSource = dscMain
      LookupTable = QryWeightUOM
      LookupField = 'unitname'
      ParentFont = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = DefaultWeightUOMCloseUp
    end
    object cboDefaultsizeUOM: TwwDBLookupCombo
      Left = 322
      Top = 119
      Width = 100
      Height = 23
      HelpContext = 748021
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'unitname'#9'15'#9'unitname'#9'F')
      DataField = 'DefaultsizeUOM'
      DataSource = dscMain
      LookupTable = QrySizeUOM
      LookupField = 'unitname'
      ParentFont = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      UseTFields = False
      PreciseEditRegion = False
      AllowClearKey = False
      OnCloseUp = cboDefaultsizeUOMCloseUp
    end
    object edtInsurance: TwwDBEdit
      Left = 122
      Top = 86
      Width = 300
      Height = 23
      HelpContext = 748022
      DataField = 'Insurance'
      DataSource = dscMain
      Font.Charset = DEFAULT_CHARSET
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
  end
  object DNMPanel3: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 436
    Height = 50
    HelpContext = 748003
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object pnlTitle: TDNMPanel
      Left = 76
      Top = 6
      Width = 278
      Height = 36
      HelpContext = 748005
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
        Width = 274
        Height = 32
        HelpContext = 748006
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
          Width = 274
          Height = 32
          HelpContext = 748007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Shipping Agent'
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
  inherited imgsort: TImageList
    Bitmap = {
      494C010102005400640010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 146
    Top = 8
  end
  object tblMain: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblShippingAgent')
    Left = 18
    Top = 82
    object tblMainGlobalref: TWideStringField
      FieldName = 'Globalref'
      Size = 255
    end
    object tblMainShippingAgentID: TLargeintField
      FieldName = 'ShippingAgentID'
    end
    object tblMainCode: TWideStringField
      FieldName = 'Code'
      Size = 10
    end
    object tblMainDescription: TWideStringField
      FieldName = 'Description'
      Size = 100
    end
    object tblMainSupplierId: TLargeintField
      FieldName = 'SupplierId'
    end
    object tblMainSupplierName: TWideStringField
      FieldName = 'SupplierName'
      Size = 100
    end
    object tblMainmstimeStamp: TDateTimeField
      FieldName = 'mstimeStamp'
    end
    object tblMainActive: TWideStringField
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object tblMainDefaultWeightUOMID: TLargeintField
      FieldName = 'DefaultWeightUOMID'
    end
    object tblMainDefaultSizeUOMID: TLargeintField
      FieldName = 'DefaultSizeUOMID'
    end
    object tblMainDefaultWeightUOM: TWideStringField
      FieldKind = fkLookup
      FieldName = 'DefaultWeightUOM'
      LookupDataSet = QryWeightUOM
      LookupKeyFields = 'unitId'
      LookupResultField = 'unitname'
      KeyFields = 'DefaultWeightUOMID'
      Size = 100
      Lookup = True
    end
    object tblMainDefaultsizeUOM: TWideStringField
      FieldKind = fkLookup
      FieldName = 'DefaultsizeUOM'
      LookupDataSet = QrySizeUOM
      LookupKeyFields = 'unitId'
      LookupResultField = 'unitname'
      KeyFields = 'DefaultSizeUOMID'
      Size = 100
      Lookup = True
    end
    object tblMainInsurance: TWideStringField
      FieldName = 'Insurance'
      Size = 255
    end
  end
  object dscMain: TDataSource
    DataSet = tblMain
    Left = 12
    Top = 122
  end
  object QryWeightUOM: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select unitId, unitname  from tblunitsofmeasure where ifnull(Par' +
        'tID,0) = 0')
    Left = 266
    Top = 194
    object QryWeightUOMunitId: TIntegerField
      FieldName = 'unitId'
    end
    object QryWeightUOMunitname: TWideStringField
      FieldName = 'unitname'
      Size = 15
    end
  end
  object QrySizeUOM: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'Select unitId, unitname  from tblunitsofmeasure where ifnull(Par' +
        'tID,0) = 0')
    Left = 290
    Top = 210
    object QrySizeUOMunitId: TIntegerField
      FieldName = 'unitId'
    end
    object QrySizeUOMunitname: TWideStringField
      FieldName = 'unitname'
      Size = 15
    end
  end
end