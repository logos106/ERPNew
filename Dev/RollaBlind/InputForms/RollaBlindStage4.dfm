inherited RollaBlindStage4GUI: TRollaBlindStage4GUI
  Caption = 'Cut-out Sheet - Step 4'
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
        object Label23: TLabel
          Left = 21
          Top = 403
          Width = 147
          Height = 15
          Caption = 'Hidden Profile Information'
        end
        object Bevel7: TBevel
          Left = 20
          Top = 420
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label24: TLabel
          Left = 22
          Top = 422
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
          Top = 441
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
          Top = 460
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
          Top = 422
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
          Top = 441
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
          Top = 460
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
          Top = 499
          Width = 137
          Height = 15
          Caption = 'Modified Measurements'
        end
        object Bevel9: TBevel
          Left = 20
          Top = 516
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label28: TLabel
          Left = 22
          Top = 518
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
          Top = 537
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
          Top = 556
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
          Top = 518
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
          Top = 537
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
          Top = 556
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
          Top = 595
          Width = 134
          Height = 15
          Caption = 'Mechanism Information'
        end
        object Bevel10: TBevel
          Left = 20
          Top = 612
          Width = 245
          Height = 39
          Shape = bsFrame
        end
        object Label32: TLabel
          Left = 22
          Top = 614
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Mechanism Type'
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
          Top = 614
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
        object Label33: TLabel
          Left = 22
          Top = 633
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Description'
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
        object txtMechDescription: TDBText
          Left = 144
          Top = 633
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'MechDescription'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label34: TLabel
          Left = 21
          Top = 672
          Width = 120
          Height = 15
          Caption = 'Starter Link / Colours'
        end
        object Bevel11: TBevel
          Left = 20
          Top = 689
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label35: TLabel
          Left = 22
          Top = 691
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Starter Link'
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
        object Label37: TLabel
          Left = 22
          Top = 710
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Side Plate Colour'
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
        object Label38: TLabel
          Left = 22
          Top = 729
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Al. Extrusion Colour'
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
        object txtStarterLink: TDBText
          Left = 144
          Top = 691
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'StarterLink'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtSidePlateColour: TDBText
          Left = 144
          Top = 710
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'SidePlateColour'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtAlumExtColour: TDBText
          Left = 144
          Top = 729
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'AlExtColour'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label39: TLabel
          Left = 21
          Top = 768
          Width = 96
          Height = 15
          Caption = 'Lock Information'
        end
        object Bevel12: TBevel
          Left = 20
          Top = 785
          Width = 245
          Height = 20
          Shape = bsFrame
        end
        object Label40: TLabel
          Left = 22
          Top = 787
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Lock Type'
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
        object txtLockType: TDBText
          Left = 144
          Top = 787
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'LockType'
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
      object Label41: TLabel [12]
        Left = 40
        Top = 72
        Width = 71
        Height = 15
        Caption = 'Sill Required'
        Transparent = True
      end
      object Label42: TLabel [13]
        Left = 16
        Top = 96
        Width = 39
        Height = 15
        Caption = 'Sill Cut'
        Transparent = True
      end
      object Label43: TLabel [14]
        Left = 16
        Top = 144
        Width = 66
        Height = 15
        Caption = 'Sill Material'
        Transparent = True
      end
      object Label44: TLabel [15]
        Left = 16
        Top = 192
        Width = 57
        Height = 15
        Caption = 'Sill Colour'
        Transparent = True
      end
      object Label45: TLabel [16]
        Left = 40
        Top = 296
        Width = 64
        Height = 15
        Caption = 'Guide Caps'
        Transparent = True
      end
      object Label46: TLabel [17]
        Left = 16
        Top = 240
        Width = 77
        Height = 15
        Caption = 'Type of Stops'
        Transparent = True
      end
      object chkSillRequired: TwwCheckBox
        Left = 16
        Top = 72
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
        DataField = 'SillRequired'
        DataSource = dsMain
        TabOrder = 0
        OnClick = chkSillRequiredClick
      end
      object edtSillLength: TwwDBEdit
        Left = 16
        Top = 112
        Width = 145
        Height = 23
        TabStop = False
        DataField = 'SillLength'
        DataSource = dsMain
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
        OnExit = edtSillLengthExit
      end
      object cboSillMaterial: TwwDBLookupCombo
        Left = 16
        Top = 160
        Width = 145
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Description'#9'20'#9'10'#9'F'#9
          'ItemNumber'#9'10'#9'ItemNumber'#9'F'#9)
        DataField = 'SillMaterial'
        DataSource = dsMain
        LookupTable = qrySillMaterial
        LookupField = 'Description'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboSillMaterialCloseUp
      end
      object cboSillColour: TwwDBLookupCombo
        Left = 16
        Top = 208
        Width = 145
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'ColourCode'#9'3'#9'ColourCode'#9'F'#9
          'Description'#9'15'#9'Description'#9'F'#9)
        DataField = 'SillColour'
        DataSource = dsMain
        LookupTable = qrySillColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboSillColourCloseUp
      end
      object chkGuideCaps: TwwCheckBox
        Left = 16
        Top = 296
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
        DataField = 'GuideCapsRequired'
        DataSource = dsMain
        TabOrder = 5
      end
      object cboStopsType: TwwDBComboBox
        Left = 16
        Top = 256
        Width = 145
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'StopsType'
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
          'Aluminium')
        ParentFont = False
        Sorted = False
        TabOrder = 4
        UnboundDataType = wwDefault
        OnCloseUp = cboStopsTypeCloseUp
      end
    end
  end
  object qrySillMaterial: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Description, ItemNumber, ItemID'
      'FROM tblrollaitems'
      'WHERE Category='#39'Sill'#39';')
    Left = 376
    Top = 544
    object qrySillMaterialDescription: TStringField
      DisplayLabel = '10'
      DisplayWidth = 20
      FieldName = 'Description'
      Size = 50
    end
    object qrySillMaterialItemNumber: TStringField
      DisplayWidth = 10
      FieldName = 'ItemNumber'
      Size = 50
    end
    object qrySillMaterialItemID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ItemID'
      Visible = False
    end
  end
  object qrySillColour: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ric.ColourCode, ric.Description, ri.ItemID'
      'FROM tblrollaitems ri'
      'INNER JOIN tblrollaitemcolours ric ON ri.ItemID = ric.ItemID'
      'WHERE ri.ItemID=:ItemID;')
    Left = 408
    Top = 544
    ParamData = <
      item
        DataType = ftString
        Name = 'ItemID'
        Value = ''
      end>
    object qrySillColourColourCode: TStringField
      DisplayWidth = 3
      FieldName = 'ColourCode'
      Size = 50
    end
    object qrySillColourDescription: TStringField
      DisplayWidth = 15
      FieldName = 'Description'
      Size = 50
    end
    object qrySillColourItemID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ItemID'
      Visible = False
    end
  end
end
