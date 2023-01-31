inherited RollaBlindStage3GUI: TRollaBlindStage3GUI
  Caption = 'Cut-out Sheet - Step 3'
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    inherited btnBack: TDNMSpeedButton
      Enabled = True
    end
    inherited DNMPanel2: TDNMPanel
      inherited ScrollBox: TScrollBox
        object Bevel4: TBevel
          Left = 20
          Top = 37
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label8: TLabel
          Left = 21
          Top = 20
          Width = 105
          Height = 15
          Caption = 'Profile Information'
        end
        object Label9: TLabel
          Left = 22
          Top = 39
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Profile Type'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label11: TLabel
          Left = 22
          Top = 58
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Perforated'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label13: TLabel
          Left = 22
          Top = 77
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Standard or Reverse'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object txtProfileType: TDBText
          Left = 144
          Top = 39
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'ProfileType'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtPerforated: TDBText
          Left = 144
          Top = 58
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'PerforatedOrNon'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtStandard: TDBText
          Left = 144
          Top = 77
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'StandardOrReverse'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label10: TLabel
          Left = 21
          Top = 116
          Width = 130
          Height = 15
          Caption = 'Installation Information'
        end
        object Bevel8: TBevel
          Left = 20
          Top = 133
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label12: TLabel
          Left = 22
          Top = 135
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Installation Type'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label14: TLabel
          Left = 22
          Top = 154
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sub Installation Type'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label36: TLabel
          Left = 22
          Top = 173
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Guide Type'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object txtInstallationType: TDBText
          Left = 144
          Top = 135
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'InstallType'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtSubInstallationType: TDBText
          Left = 144
          Top = 154
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'SubInstallType'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtGuideType: TDBText
          Left = 144
          Top = 173
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'GuideType'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label15: TLabel
          Left = 21
          Top = 212
          Width = 86
          Height = 15
          Caption = 'Measurements'
        end
        object Bevel5: TBevel
          Left = 20
          Top = 229
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label16: TLabel
          Left = 22
          Top = 231
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Shutter Number'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label17: TLabel
          Left = 22
          Top = 250
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Opening Height'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label18: TLabel
          Left = 22
          Top = 269
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Opening Width'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object txtShutterNumber: TDBText
          Left = 144
          Top = 231
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'ShutterNumber'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtOpeningHeight: TDBText
          Left = 144
          Top = 250
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'OpeningHeight'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtOpeningWidth: TDBText
          Left = 144
          Top = 269
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'OpeningWidth'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label19: TLabel
          Left = 21
          Top = 308
          Width = 100
          Height = 15
          Caption = 'Sales Information'
        end
        object Bevel6: TBevel
          Left = 20
          Top = 325
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label20: TLabel
          Left = 22
          Top = 327
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Contract Number'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label21: TLabel
          Left = 22
          Top = 346
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Map Reference'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label22: TLabel
          Left = 22
          Top = 365
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Installation Date'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object txtContractNumber: TDBText
          Left = 144
          Top = 327
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtMapReference: TDBText
          Left = 144
          Top = 346
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'MapRef'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtInstallationDate: TDBText
          Left = 144
          Top = 365
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'InstallDate'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label23: TLabel
          Left = 21
          Top = 404
          Width = 147
          Height = 15
          Caption = 'Hidden Profile Information'
        end
        object Bevel7: TBevel
          Left = 20
          Top = 421
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label24: TLabel
          Left = 22
          Top = 423
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Housing Type'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label25: TLabel
          Left = 22
          Top = 442
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Hidden Profiles'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label26: TLabel
          Left = 22
          Top = 461
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Hidden Profile Height'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object txtHousingType: TDBText
          Left = 144
          Top = 423
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'HiddenProfileType'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtHiddenProfiles: TDBText
          Left = 144
          Top = 442
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'HiddenProfileNumber'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtHiddenProfileHeight: TDBText
          Left = 144
          Top = 461
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'HiddenProfilesHeight'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label27: TLabel
          Left = 21
          Top = 500
          Width = 137
          Height = 15
          Caption = 'Modified Measurements'
        end
        object Bevel9: TBevel
          Left = 20
          Top = 517
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label28: TLabel
          Left = 22
          Top = 519
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Weight'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label29: TLabel
          Left = 22
          Top = 538
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Drop'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label30: TLabel
          Left = 22
          Top = 557
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'DMG'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object txtShutterWeight: TDBText
          Left = 144
          Top = 519
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'ShutterWeight'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtDrop: TDBText
          Left = 144
          Top = 538
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'Mod1Height'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtDMG: TDBText
          Left = 144
          Top = 557
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'Mod1Width'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label31: TLabel
          Left = 21
          Top = 596
          Width = 134
          Height = 15
          Caption = 'Mechanism Information'
        end
        object Bevel10: TBevel
          Left = 20
          Top = 613
          Width = 245
          Height = 20
          Shape = bsFrame
        end
        object Label32: TLabel
          Left = 22
          Top = 615
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Mechanism'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object txtMechType: TDBText
          Left = 144
          Top = 615
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'MechType'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
      end
    end
    inherited DNMPanel3: TDNMPanel
      object Label33: TLabel
        Left = 16
        Top = 72
        Width = 96
        Height = 15
        Caption = 'Mechanism Type'
        Transparent = True
      end
      object Label34: TLabel
        Left = 16
        Top = 120
        Width = 80
        Height = 15
        Caption = 'Selected Type'
        Transparent = True
      end
      object Label35: TLabel
        Left = 16
        Top = 168
        Width = 85
        Height = 15
        Caption = 'Shutter Weight'
        Transparent = True
      end
      object Label38: TLabel
        Left = 16
        Top = 216
        Width = 84
        Height = 15
        Caption = 'Winch Bracket'
        Transparent = True
      end
      object Label39: TLabel
        Left = 16
        Top = 264
        Width = 67
        Height = 15
        Caption = 'Starter Link'
        Transparent = True
      end
      object Label40: TLabel
        Left = 272
        Top = 72
        Width = 97
        Height = 15
        Caption = 'Side Plate Colour'
        Transparent = True
      end
      object Label41: TLabel
        Left = 272
        Top = 120
        Width = 157
        Height = 15
        Caption = 'Aluminium Extrusion Colour'
        Transparent = True
      end
      object Label42: TLabel
        Left = 272
        Top = 168
        Width = 84
        Height = 15
        Caption = 'Side Plate Size'
        Transparent = True
      end
      object Label43: TLabel
        Left = 272
        Top = 216
        Width = 58
        Height = 15
        Caption = 'Lock Type'
        Transparent = True
      end
      object cboSelectedType: TwwDBLookupCombo
        Left = 16
        Top = 136
        Width = 241
        Height = 23
        TabStop = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'MechDescription'
        DataSource = dsMain
        LookupTable = qrySelectedType
        LookupField = 'Description'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboSelectedTypeCloseUp
      end
      object edtMechanismType: TwwDBEdit
        Left = 16
        Top = 88
        Width = 241
        Height = 21
        TabStop = False
        BorderStyle = bsNone
        DataField = 'MechType'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtShutterWeight: TwwDBEdit
        Left = 16
        Top = 184
        Width = 241
        Height = 23
        TabStop = False
        DataField = 'ShutterWeight'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cboWinchBracket: TwwDBLookupCombo
        Left = 16
        Top = 232
        Width = 241
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Description'#9'30'#9'Description'#9'F'#9
          'ItemNumber'#9'10'#9'ItemNumber'#9'F'#9)
        DataField = 'WBMaterial'
        DataSource = dsMain
        LookupTable = qryWinchBracket
        LookupField = 'Description'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboWinchBracketCloseUp
      end
      object cboStarterLink: TwwDBComboBox
        Left = 16
        Top = 280
        Width = 241
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'StarterLink'
        DataSource = dsMain
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Standard'
          'Spring')
        ParentFont = False
        Sorted = False
        TabOrder = 4
        UnboundDataType = wwDefault
        OnCloseUp = cboStarterLinkCloseUp
      end
      object cboSidePlateColour: TwwDBLookupCombo
        Left = 272
        Top = 88
        Width = 217
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9'F'
          'Description'#9'15'#9'Description'#9'F')
        DataField = 'SidePlateColour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 5
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboSidePlateColourCloseUp
      end
      object cboAlumExtColour: TwwDBLookupCombo
        Left = 272
        Top = 136
        Width = 217
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9#9
          'Description'#9'15'#9'Description'#9#9)
        DataField = 'AlExtColour'
        DataSource = dsMain
        LookupTable = qryColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 6
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboAlumExtColourCloseUp
      end
      object cboSidePlateSize: TwwDBLookupCombo
        Left = 272
        Top = 184
        Width = 217
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'HiddenProfileType'
        DataSource = dsMain
        LookupTable = qrySidePlateSize
        LookupField = 'Category'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 7
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboSidePlateSizeCloseUp
      end
      object cboLockType: TwwDBComboBox
        Left = 272
        Top = 232
        Width = 217
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'LockType'
        DataSource = dsMain
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'None'
          'Standard'
          'Key'
          'Patio Bolt')
        ParentFont = False
        Sorted = False
        TabOrder = 8
        UnboundDataType = wwDefault
        OnCloseUp = cboLockTypeCloseUp
      end
    end
  end
  object qrySelectedType: TMyQuery
    SQL.Strings = (
      'SELECT Description, MechType'
      'FROM tblrollamechdata'
      'WHERE MechType=:MechType;')
    Left = 376
    Top = 544
    ParamData = <
      item
        DataType = ftString
        Name = 'MechType'
        Value = ''
      end>
    object qrySelectedTypeDescription: TStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Size = 50
    end
    object qrySelectedTypeMechType: TStringField
      FieldName = 'MechType'
      Size = 50
    end
  end
  object qryWinchBracket: TMyQuery
    SQL.Strings = (
      
        'SELECT Concat('#39'None'#39', Space(46)) AS Description, Space(50) AS It' +
        'emNumber, '#39'0'#39' AS Length'
      'FROM tblrollaitems'
      ''
      'UNION'
      ''
      'SELECT Description, ItemNumber, Length'
      'FROM tblrollaitems'
      'WHERE Category='#39'Winch Bracket'#39';')
    Left = 408
    Top = 544
    object qryWinchBracketDescription: TStringField
      DisplayWidth = 30
      FieldName = 'Description'
      Origin = 'tblrollaitems.Description'
      Size = 50
    end
    object qryWinchBracketItemNumber: TStringField
      DisplayWidth = 10
      FieldName = 'ItemNumber'
      FixedChar = True
      Size = 50
    end
    object qryWinchBracketLength: TStringField
      DisplayWidth = 15
      FieldName = 'Length'
      Visible = False
    end
  end
  object qryColour: TMyQuery
    SQL.Strings = (
      'SELECT ColourCode, Description'
      'FROM tblrollacolourcodes'
      'WHERE HeavyDuty=:HeavyDuty'
      'ORDER BY ColourCode;')
    Left = 440
    Top = 544
    ParamData = <
      item
        DataType = ftString
        Name = 'HeavyDuty'
        Value = ''
      end>
    object qryColourColourCode: TStringField
      DisplayWidth = 3
      FieldName = 'ColourCode'
      Size = 50
    end
    object qryColourDescription: TStringField
      DisplayWidth = 15
      FieldName = 'Description'
      Size = 50
    end
  end
  object qrySidePlateSize: TMyQuery
    SQL.Strings = (
      'SELECT Category'
      'FROM tblrollaprofdata'
      'GROUP BY Category'
      'ORDER BY Category;')
    Left = 472
    Top = 544
    object qrySidePlateSizeCategory: TStringField
      DisplayWidth = 20
      FieldName = 'Category'
      Size = 50
    end
  end
end
