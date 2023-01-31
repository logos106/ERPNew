inherited RollaBlindStage5GUI: TRollaBlindStage5GUI
  Caption = 'Cut-out Sheet - Step 5'
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    inherited btnBack: TDNMSpeedButton
      Enabled = True
    end
    inherited btnNext: TDNMSpeedButton
      Enabled = True
    end
    inherited DNMPanel2: TDNMPanel
      inherited ScrollBox: TScrollBox
        object Label8: TLabel
          Left = 21
          Top = 20
          Width = 105
          Height = 15
          Caption = 'Profile Information'
        end
        object Bevel4: TBevel
          Left = 20
          Top = 37
          Width = 245
          Height = 59
          Shape = bsFrame
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
        object Bevel8: TBevel
          Left = 20
          Top = 133
          Width = 245
          Height = 59
          Shape = bsFrame
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
        object Label23: TLabel
          Left = 21
          Top = 402
          Width = 147
          Height = 15
          Caption = 'Hidden Profile Information'
        end
        object Bevel7: TBevel
          Left = 20
          Top = 419
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label24: TLabel
          Left = 22
          Top = 421
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
          Top = 440
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
          Top = 459
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
          Top = 421
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
          Top = 440
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
          Top = 459
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
          Top = 498
          Width = 137
          Height = 15
          Caption = 'Modified Measurements'
        end
        object Bevel9: TBevel
          Left = 20
          Top = 515
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label28: TLabel
          Left = 22
          Top = 517
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
          Top = 536
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
          Top = 555
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
          Top = 517
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
          Top = 536
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
          Top = 555
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
          Top = 594
          Width = 134
          Height = 15
          Caption = 'Mechanism Information'
        end
        object Bevel10: TBevel
          Left = 20
          Top = 611
          Width = 245
          Height = 39
          Shape = bsFrame
        end
        object Label32: TLabel
          Left = 22
          Top = 613
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
        object Label33: TLabel
          Left = 22
          Top = 632
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
        object txtMechType: TDBText
          Left = 144
          Top = 613
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
        object txtMechDescription: TDBText
          Left = 144
          Top = 632
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
          Top = 671
          Width = 120
          Height = 15
          Caption = 'Starter Link / Colours'
        end
        object Bevel11: TBevel
          Left = 20
          Top = 688
          Width = 245
          Height = 59
          Shape = bsFrame
        end
        object Label35: TLabel
          Left = 22
          Top = 690
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
          Top = 709
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
          Top = 728
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
          Top = 690
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
          Top = 709
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
          Top = 728
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
          Top = 767
          Width = 96
          Height = 15
          Caption = 'Lock Information'
        end
        object Bevel12: TBevel
          Left = 20
          Top = 784
          Width = 245
          Height = 20
          Shape = bsFrame
        end
        object Label40: TLabel
          Left = 22
          Top = 786
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
          Top = 786
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
        object Label41: TLabel
          Left = 21
          Top = 825
          Width = 64
          Height = 15
          Caption = 'Guide Caps'
        end
        object Bevel13: TBevel
          Left = 20
          Top = 842
          Width = 245
          Height = 39
          Shape = bsFrame
        end
        object Label42: TLabel
          Left = 22
          Top = 844
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Gaps Required'
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
        object Label43: TLabel
          Left = 22
          Top = 863
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Colour'
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
        object txtGuideCapsRequired: TDBText
          Left = 144
          Top = 844
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'GuideCapsRequired'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtGuideCapColour: TDBText
          Left = 144
          Top = 863
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'GuideCapColour'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label44: TLabel
          Left = 21
          Top = 902
          Width = 85
          Height = 15
          Caption = 'Sill Information'
        end
        object Bevel14: TBevel
          Left = 20
          Top = 919
          Width = 245
          Height = 97
          Shape = bsFrame
        end
        object Label45: TLabel
          Left = 22
          Top = 921
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sill Required'
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
        object Label46: TLabel
          Left = 22
          Top = 940
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sill Length'
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
        object Label47: TLabel
          Left = 22
          Top = 959
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sill Material'
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
        object txtSillRequired: TDBText
          Left = 144
          Top = 921
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'SillRequired'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtSillLength: TDBText
          Left = 144
          Top = 940
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'SillLength'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object txtSillMaterial: TDBText
          Left = 144
          Top = 959
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'SillMaterial'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label48: TLabel
          Left = 22
          Top = 978
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sill Item Number'
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
        object txtSillItemNumber: TDBText
          Left = 144
          Top = 978
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'SillitemNumber'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label49: TLabel
          Left = 22
          Top = 997
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sill Colour'
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
        object txtSillColour: TDBText
          Left = 144
          Top = 997
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'SillColour'
          DataSource = dsMain
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
        end
        object Label50: TLabel
          Left = 21
          Top = 1036
          Width = 33
          Height = 15
          Caption = 'Stops'
        end
        object Bevel15: TBevel
          Left = 20
          Top = 1053
          Width = 245
          Height = 20
          Shape = bsFrame
        end
        object Label51: TLabel
          Left = 22
          Top = 1055
          Width = 119
          Height = 17
          Alignment = taCenter
          AutoSize = False
          Caption = 'Type of Stops'
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
        object txtStopsType: TDBText
          Left = 144
          Top = 1055
          Width = 119
          Height = 17
          Alignment = taCenter
          Color = clWhite
          DataField = 'StopsType'
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
      object Label52: TLabel [12]
        Left = 40
        Top = 72
        Width = 102
        Height = 15
        Caption = 'Packers Required'
        Transparent = True
      end
      object Label53: TLabel [13]
        Left = 40
        Top = 96
        Width = 125
        Height = 15
        Caption = 'More than one Packer'
        Transparent = True
      end
      object Label54: TLabel [14]
        Left = 40
        Top = 120
        Width = 84
        Height = 15
        Caption = 'Same Packers'
        Transparent = True
      end
      object Label55: TLabel [15]
        Left = 16
        Top = 144
        Width = 100
        Height = 15
        Caption = 'Packer Material 1'
        Transparent = True
      end
      object Label56: TLabel [16]
        Left = 16
        Top = 192
        Width = 100
        Height = 15
        Caption = 'Packer Material 2'
        Transparent = True
      end
      object Label57: TLabel [17]
        Left = 16
        Top = 240
        Width = 81
        Height = 15
        Caption = 'Packer Colour'
        Transparent = True
      end
      object Label58: TLabel [18]
        Left = 200
        Top = 70
        Width = 114
        Height = 15
        Caption = 'Hole Plugs Required'
        Transparent = True
      end
      object Label59: TLabel [19]
        Left = 176
        Top = 96
        Width = 101
        Height = 15
        Caption = 'Hole Plug Number'
        Transparent = True
      end
      object Label60: TLabel [20]
        Left = 360
        Top = 72
        Width = 101
        Height = 15
        Caption = 'Flashing Required'
        Transparent = True
      end
      object Label61: TLabel [21]
        Left = 336
        Top = 96
        Width = 77
        Height = 15
        Caption = 'Flashing Type'
        Transparent = True
      end
      object Label62: TLabel [22]
        Left = 336
        Top = 144
        Width = 116
        Height = 15
        Caption = 'Casement Profile Fill'
        Transparent = True
      end
      object Label63: TLabel [23]
        Left = 16
        Top = 288
        Width = 83
        Height = 15
        Caption = 'Packer Length'
        Transparent = True
      end
      object chkPackersRequired: TwwCheckBox
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
        DataField = 'PackRequired'
        DataSource = dsMain
        TabOrder = 0
        OnClick = chkPackersRequiredClick
      end
      object chkMoreThanOnePacker: TwwCheckBox
        Left = 16
        Top = 96
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
        DataField = 'PackMore'
        DataSource = dsMain
        TabOrder = 1
        OnClick = chkMoreThanOnePackerClick
      end
      object chkSamePackers: TwwCheckBox
        Left = 16
        Top = 120
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
        DataField = 'PackSame'
        DataSource = dsMain
        TabOrder = 2
        OnClick = chkSamePackersClick
      end
      object cboPackerMaterial1: TwwDBLookupCombo
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
          'Description'#9'20'#9'Description'#9'F'#9
          'ItemNumber'#9'10'#9'ItemNumber'#9'F'#9)
        DataField = 'PackMaterial1'
        DataSource = dsMain
        LookupTable = qryPackerMaterial
        LookupField = 'Description'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 3
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboPackerMaterial1CloseUp
      end
      object cboPackerMaterial2: TwwDBLookupCombo
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
          'Description'#9'20'#9'Description'#9'F'#9
          'ItemNumber'#9'10'#9'ItemNumber'#9'F'#9)
        DataField = 'PackMaterial2'
        DataSource = dsMain
        LookupTable = qryPackerMaterial
        LookupField = 'Description'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 4
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboPackerMaterial2CloseUp
      end
      object cboPackerColour: TwwDBLookupCombo
        Left = 16
        Top = 256
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
        DataField = 'PackColour'
        DataSource = dsMain
        LookupTable = qryPackerColour
        LookupField = 'ColourCode'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 5
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboPackerColourCloseUp
      end
      object chkHolePlugsRequired: TwwCheckBox
        Left = 176
        Top = 70
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
        DataField = 'HolePlugsRequired'
        DataSource = dsMain
        TabOrder = 7
        OnClick = chkHolePlugsRequiredClick
      end
      object edtHolePlugNumber: TwwDBEdit
        Left = 176
        Top = 112
        Width = 145
        Height = 23
        TabStop = False
        DataField = 'HolePlugNumber'
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
      end
      object chkFlashingRequired: TwwCheckBox
        Left = 336
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
        DataField = 'FlashRequired'
        DataSource = dsMain
        TabOrder = 9
        OnClick = chkFlashingRequiredClick
      end
      object cboFlashingType: TwwDBLookupCombo
        Left = 336
        Top = 112
        Width = 145
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'Description'#9'20'#9'Description'#9'F'#9
          'ItemNumber'#9'10'#9'ItemNumber'#9'F'#9)
        DataField = 'FlashMaterial'
        DataSource = dsMain
        LookupTable = qryFlashingMaterial
        LookupField = 'Description'
        Options = [loColLines]
        Style = csDropDownList
        ParentFont = False
        TabOrder = 10
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboFlashingTypeCloseUp
      end
      object cboCasementProfileFill: TwwDBComboBox
        Left = 336
        Top = 160
        Width = 145
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'CasementProfileFill'
        DataSource = dsMain
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Mesh'
          'Series1'
          'Series2'
          'Series2 Grooved'
          'Rollascreen')
        ParentFont = False
        Sorted = False
        TabOrder = 11
        UnboundDataType = wwDefault
        OnCloseUp = cboCasementProfileFillCloseUp
      end
      object edtPackerLength: TwwDBEdit
        Left = 16
        Top = 304
        Width = 145
        Height = 21
        TabStop = False
        BorderStyle = bsNone
        DataField = 'PackLength'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 6
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
  end
  object qryPackerMaterial: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Description, ItemNumber, ItemID'
      'FROM tblrollaitems'
      'WHERE Category='#39'Packers'#39';')
    Left = 376
    Top = 544
    object qryPackerMaterialDescription: TStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Size = 50
    end
    object qryPackerMaterialItemNumber: TStringField
      DisplayWidth = 10
      FieldName = 'ItemNumber'
      Size = 50
    end
    object qryPackerMaterialItemID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ItemID'
      Visible = False
    end
  end
  object qryPackerColour: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT ric.ColourCode, ric.Description, ri.ItemID'
      'FROM tblrollaitems ri'
      'INNER JOIN tblrollaitemcolours ric ON ri.ItemID = ric.ItemID'
      'WHERE ri.ItemID=:ItemID;'
      '')
    Left = 408
    Top = 544
    ParamData = <
      item
        DataType = ftString
        Name = 'ItemID'
        Value = ''
      end>
    object qryPackerColourColourCode: TStringField
      DisplayWidth = 3
      FieldName = 'ColourCode'
      Origin = 'ric.ColourCode'
      Size = 50
    end
    object qryPackerColourDescription: TStringField
      DisplayWidth = 15
      FieldName = 'Description'
      Origin = 'ric.Description'
      Size = 50
    end
    object qryPackerColourItemID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ItemID'
      Visible = False
    end
  end
  object qryFlashingMaterial: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Description, ItemNumber, ItemID'
      'FROM tblrollaitems'
      'WHERE Category='#39'Flashing'#39';')
    Left = 440
    Top = 544
    object qryFlashingMaterialDescription: TStringField
      DisplayWidth = 20
      FieldName = 'Description'
      Size = 50
    end
    object qryFlashingMaterialItemNumber: TStringField
      DisplayWidth = 10
      FieldName = 'ItemNumber'
      Size = 50
    end
    object qryFlashingMaterialItemID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ItemID'
      Visible = False
    end
  end
end
