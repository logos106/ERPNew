inherited RollaBlindStage1GUI: TRollaBlindStage1GUI
  Caption = 'Cut-out Sheet - Step 1'
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    inherited DNMPanel2: TDNMPanel
      inherited ScrollBox: TScrollBox
        Visible = False
      end
    end
    inherited DNMPanel3: TDNMPanel
      object Label8: TLabel [12]
        Left = 16
        Top = 80
        Width = 76
        Height = 15
        Caption = 'Lead Number'
        Transparent = True
      end
      object Label9: TLabel [13]
        Left = 16
        Top = 128
        Width = 67
        Height = 15
        Caption = 'Profile Type'
        Transparent = True
      end
      object Label11: TLabel [14]
        Left = 16
        Top = 176
        Width = 92
        Height = 15
        Caption = 'Installation Type'
        Transparent = True
      end
      object Label12: TLabel [15]
        Left = 16
        Top = 224
        Width = 117
        Height = 15
        Caption = 'Sub Installation Type'
        Transparent = True
      end
      object Label13: TLabel [16]
        Left = 16
        Top = 272
        Width = 62
        Height = 15
        Caption = 'Guide Type'
        Transparent = True
      end
      object Label14: TLabel [17]
        Left = 40
        Top = 360
        Width = 50
        Height = 15
        Caption = 'Arch Bar'
        Transparent = True
      end
      object Label15: TLabel [18]
        Left = 40
        Top = 392
        Width = 134
        Height = 15
        Caption = 'Move Housing by 50mm'
        Transparent = True
      end
      object Label10: TLabel [19]
        Left = 40
        Top = 328
        Width = 61
        Height = 15
        Caption = 'Perforated'
        Transparent = True
      end
      object Label16: TLabel [20]
        Left = 160
        Top = 80
        Width = 90
        Height = 15
        Caption = 'Shutter Number'
        Transparent = True
      end
      object Label17: TLabel [21]
        Left = 160
        Top = 128
        Width = 86
        Height = 15
        Caption = 'Opening Height'
        Transparent = True
      end
      object Label18: TLabel [22]
        Left = 160
        Top = 176
        Width = 83
        Height = 15
        Caption = 'Opening Width'
        Transparent = True
      end
      object Label19: TLabel [23]
        Left = 160
        Top = 224
        Width = 117
        Height = 15
        Caption = 'Map Reference (Opt)'
        Transparent = True
      end
      object Label20: TLabel [24]
        Left = 160
        Top = 272
        Width = 94
        Height = 15
        Caption = 'Install Date (Opt)'
        Transparent = True
      end
      object cboLeadNumber: TwwDBLookupCombo
        Left = 16
        Top = 96
        Width = 129
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ClientID'#9'10'#9'ClientID'#9'T'
          'FirstName'#9'15'#9'FirstName'#9'T'
          'LastName'#9'15'#9'LastName'#9'T')
        DataField = 'LeadNumber'
        DataSource = dsMain
        LookupTable = qryLeadNumber
        LookupField = 'ClientID'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboLeadNumberCloseUp
      end
      object cboProfileType: TwwDBLookupCombo
        Left = 16
        Top = 144
        Width = 129
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'ProfileType'
        DataSource = dsMain
        LookupTable = qryProfileType
        LookupField = 'ProfileType'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboProfileTypeCloseUp
      end
      object cboInstallationType: TwwDBComboBox
        Left = 16
        Top = 192
        Width = 129
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'InstallType'
        DataSource = dsMain
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Eave'
          'Reveal'
          'Surface'
          'Casement'
          'Curtain Replacement'
          'Rollavault')
        ParentFont = False
        Sorted = False
        TabOrder = 2
        UnboundDataType = wwDefault
        OnCloseUp = cboInstallationTypeCloseUp
      end
      object cboSubInstallationType: TwwDBComboBox
        Left = 16
        Top = 240
        Width = 129
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'SubInstallType'
        DataSource = dsMain
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Eave'
          'Offset'
          'Surface')
        ParentFont = False
        Sorted = False
        TabOrder = 3
        UnboundDataType = wwDefault
        OnCloseUp = cboSubInstallationTypeCloseUp
      end
      object cboGuideType: TwwDBComboBox
        Left = 16
        Top = 288
        Width = 129
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'GuideType'
        DataSource = dsMain
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Reveal'
          'Commercial')
        ParentFont = False
        Sorted = False
        TabOrder = 4
        UnboundDataType = wwDefault
        OnCloseUp = cboGuideTypeCloseUp
      end
      object chkArchBar: TwwCheckBox
        Left = 16
        Top = 360
        Width = 17
        Height = 17
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
        DataField = 'ArchBar'
        DataSource = dsMain
        TabOrder = 6
        OnClick = chkArchBarClick
      end
      object chkMoveBy50: TwwCheckBox
        Left = 16
        Top = 392
        Width = 17
        Height = 17
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
        DataField = 'MoveBy50'
        DataSource = dsMain
        TabOrder = 7
        OnClick = chkMoveBy50Click
      end
      object chkPerforated: TwwCheckBox
        Left = 16
        Top = 328
        Width = 17
        Height = 17
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
        DataField = 'Perforated'
        DataSource = dsMain
        TabOrder = 5
        OnClick = chkPerforatedClick
      end
      object edtShutterNumber: TwwDBEdit
        Left = 160
        Top = 96
        Width = 121
        Height = 23
        DataField = 'ShutterNumber'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtShutterNumberExit
      end
      object edtOpeningHeight: TwwDBEdit
        Left = 160
        Top = 144
        Width = 121
        Height = 23
        DataField = 'OpeningHeight'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtOpeningHeightExit
      end
      object edtOpeningWidth: TwwDBEdit
        Left = 160
        Top = 192
        Width = 121
        Height = 23
        DataField = 'OpeningWidth'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtOpeningWidthExit
      end
      object edtMapReference: TwwDBEdit
        Left = 160
        Top = 240
        Width = 121
        Height = 23
        DataField = 'MapRef'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnExit = edtMapReferenceExit
      end
      object edtInstallDate: TMaskEdit
        Left = 160
        Top = 288
        Width = 116
        Height = 23
        EditMask = '!99/99/9999;1;'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 12
        Text = '  /  /    '
        OnExit = edtInstallDateExit
      end
    end
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      
        'SELECT *, IF(Perforated='#39'T'#39', '#39'Perforated'#39', '#39'Non-perforated'#39') AS ' +
        'PerforatedOrNon, '
      'IF(Standard='#39'T'#39', '#39'Standard'#39', '#39'Reverse'#39') AS StandardOrReverse '
      'FROM tblrollaaddsheet1;')
  end
  inherited qryHeading: TMyQuery
    SQL.Strings = (
      
        'SELECT  ClientID as LeadNumber, Title, FirstName, LastName as Su' +
        'rname '
      'FROM tblclients '
      'WHERE ClientID=:ClientID;')
  end
  object qryLeadNumber: TMyQuery
    SQL.Strings = (
      'SELECT ClientID, FirstName, LastName '
      'FROM tblclients'
      'ORDER BY LastName;')
    Left = 360
    Top = 544
    object qryLeadNumberClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
    end
    object qryLeadNumberFirstName: TStringField
      DisplayWidth = 15
      FieldName = 'FirstName'
      Origin = 'tblclients.FirstName'
      Size = 40
    end
    object qryLeadNumberLastName: TStringField
      DisplayWidth = 15
      FieldName = 'LastName'
      Origin = 'tblclients.LastName'
      Size = 40
    end
  end
  object qryProfileType: TMyQuery
    SQL.Strings = (
      'SELECT * '
      'FROM tblrollaprofiletypes'
      'ORDER BY Asc1;')
    Left = 400
    Top = 544
    object StringField1: TStringField
      DisplayWidth = 10
      FieldName = 'ProfileType'
      Size = 50
    end
  end
end
