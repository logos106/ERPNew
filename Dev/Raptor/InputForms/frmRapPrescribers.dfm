inherited fmRapPrescriber: TfmRapPrescriber
  Left = 322
  Top = 274
  Caption = 'Rap Prescriber'
  ClientHeight = 337
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  object HeaderPanel: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 392
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object pnlTitle: TDNMPanel
      Left = 82
      Top = 6
      Width = 238
      Height = 45
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
        Width = 234
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
          Width = 234
          Height = 41
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'RAP Prescriber'
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
  object Panel1: TDNMPanel [2]
    Left = 0
    Top = 62
    Width = 392
    Height = 224
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      392
      224)
    object Label3: TLabel
      Left = 12
      Top = 15
      Width = 33
      Height = 15
      Caption = 'Name'
      Transparent = True
    end
    object Label4: TLabel
      Left = 12
      Top = 71
      Width = 34
      Height = 15
      Caption = 'Types'
      Transparent = True
    end
    object Label1: TLabel
      Left = 12
      Top = 47
      Width = 96
      Height = 15
      Caption = 'Provider Number'
      Transparent = True
    end
    object edtItemName: TwwDBEdit
      Left = 120
      Top = 11
      Width = 265
      Height = 23
      DataField = 'PrescriberName'
      DataSource = dsMaster
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
    object wwDBGrid1: TwwDBGrid
      Left = 12
      Top = 90
      Width = 372
      Height = 127
      ControlType.Strings = (
        'Active;CheckBox;T;F'
        'RapProductCode;CustomEdit;cboRapProduct;F'
        'PrescriberTypeCode;CustomEdit;cboPrescribertype;F')
      Selected.Strings = (
        'PrescriberTypeCode'#9'10'#9'Prescriber Type Code'#9'F'
        'PrescriberTypeName'#9'100'#9'Prescriber Type Name'#9'F')
      IniAttributes.Delimiter = ';;'
      TitleColor = 14144187
      FixedCols = 0
      ShowHorzScrollBar = True
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = dsDetails
      TabOrder = 2
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      TitleButtons = False
      OnEnter = wwDBGrid1Enter
      FooterColor = 14144187
    end
    object cboPrescribertype: TwwDBLookupCombo
      Left = 120
      Top = 160
      Width = 121
      Height = 23
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'PrescriberCode'#9'10'#9'PrescriberCode'#9'F'
        'PrescriberName'#9'100'#9'PrescriberName'#9'F')
      LookupTable = qryPrescribertypes
      LookupField = 'PrescriberCode'
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      AllowClearKey = False
    end
    object edtProvidernum: TwwDBEdit
      Left = 120
      Top = 43
      Width = 73
      Height = 23
      DataField = 'ProviderNum'
      DataSource = dsMaster
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
  end
  object Panel2: TDNMPanel [3]
    Left = 0
    Top = 286
    Width = 392
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      392
      51)
    object Label32: TLabel
      Left = 337
      Top = 17
      Width = 39
      Height = 16
      AutoSize = False
      Caption = 'Active'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      WordWrap = True
    end
    object btnCompleted: TDNMSpeedButton
      Left = 52
      Top = 12
      Width = 87
      Height = 27
      Anchors = []
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
      TabOrder = 1
      OnClick = btnCompletedClick
    end
    object cmdNew: TDNMSpeedButton
      Left = 146
      Top = 12
      Width = 87
      Height = 27
      Anchors = []
      Caption = '&New'
      DisableTransparent = False
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
      ParentFont = False
      TabOrder = 2
      OnClick = cmdNewClick
    end
    object btnClose: TDNMSpeedButton
      Left = 243
      Top = 12
      Width = 87
      Height = 27
      Anchors = []
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
      TabOrder = 3
      OnClick = btnCloseClick
    end
    object chkActive: TwwCheckBox
      Left = 376
      Top = 17
      Width = 15
      Height = 17
      TabStop = False
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
      Caption = 'chkActive'
      DataField = 'Active'
      TabOrder = 0
    end
  end
  object dsMaster: TDataSource
    DataSet = tblMaster
    Left = 208
    Top = 8
  end
  object tblMaster: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'from tblRapPrescriber'
      '')
    Left = 253
    Top = 12
    object tblMasterPrescriberID: TAutoIncField
      FieldName = 'PrescriberID'
      ReadOnly = True
    end
    object tblMasterPrescriberName: TStringField
      FieldName = 'PrescriberName'
      Size = 100
    end
    object tblMasterProviderNum: TStringField
      FieldName = 'ProviderNum'
      Size = 10
    end
    object tblMasterGlobalRef: TStringField
      FieldName = 'GlobalRef'
      Size = 255
    end
  end
  object dsDetails: TDataSource
    DataSet = tblDetails
    Left = 296
    Top = 8
  end
  object tblDetails: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'from tblRapPrescriberTypes'
      ''
      '')
    Left = 341
    Top = 12
    object tblDetailsPrescriberTypeCode: TStringField
      DisplayLabel = 'Prescriber Type Code'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'PrescriberTypeCode'
      LookupDataSet = qryPrescribertypes
      LookupKeyFields = 'PrescriberID'
      LookupResultField = 'PrescriberCode'
      KeyFields = 'PrescriberTypeID'
      Size = 10
      Lookup = True
    end
    object tblDetailsPrescriberTypeName: TStringField
      DisplayLabel = 'Prescriber Type Name'
      DisplayWidth = 100
      FieldKind = fkLookup
      FieldName = 'PrescriberTypeName'
      LookupDataSet = qryPrescribertypes
      LookupKeyFields = 'PrescriberID'
      LookupResultField = 'PrescriberName'
      KeyFields = 'PrescriberTypeID'
      Size = 100
      Lookup = True
    end
    object tblDetailsID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object tblDetailsPrescriberID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PrescriberID'
      Visible = False
    end
    object tblDetailsPrescriberTypeID: TIntegerField
      DisplayWidth = 10
      FieldName = 'PrescriberTypeID'
      Visible = False
    end
    object tblDetailsGlobalRef: TStringField
      DisplayWidth = 255
      FieldName = 'GlobalRef'
      Visible = False
      Size = 255
    end
  end
  object qryPrescribertypes: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'Select *'
      'from tblRapPrescriberType'
      '')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 39
    Top = 49
    object tblMasterPrescriberCode: TStringField
      DisplayWidth = 10
      FieldName = 'PrescriberCode'
      Size = 10
    end
    object StringField1: TStringField
      DisplayWidth = 100
      FieldName = 'PrescriberName'
      Size = 100
    end
    object LargeintField1: TIntegerField
      FieldName = 'PrescriberID'
      Visible = False
    end
  end
end
