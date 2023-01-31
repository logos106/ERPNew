inherited RollaBlindStage2GUI: TRollaBlindStage2GUI
  Caption = 'Cut-out Sheet - Step 2'
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
      end
    end
    inherited DNMPanel3: TDNMPanel
      object Label27: TLabel [12]
        Left = 176
        Top = 72
        Width = 27
        Height = 15
        Caption = 'Drop'
        Transparent = True
      end
      object Label28: TLabel [13]
        Left = 176
        Top = 120
        Width = 26
        Height = 15
        Caption = 'DMG'
        Transparent = True
      end
      object Label29: TLabel [14]
        Left = 176
        Top = 168
        Width = 85
        Height = 15
        Caption = 'Shutter Weight'
        Transparent = True
      end
      object Label30: TLabel [15]
        Left = 16
        Top = 72
        Width = 96
        Height = 15
        Caption = 'Mechanism Type'
        Transparent = True
      end
      object Label31: TLabel [16]
        Left = 16
        Top = 120
        Width = 68
        Height = 15
        Caption = 'Cable Roller'
        Transparent = True
      end
      object Label32: TLabel [17]
        Left = 16
        Top = 168
        Width = 46
        Height = 15
        Caption = 'Position'
        Transparent = True
      end
      object edtDrop: TwwDBEdit
        Left = 176
        Top = 88
        Width = 129
        Height = 23
        TabStop = False
        DataField = 'Mod1Height'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtDMG: TwwDBEdit
        Left = 176
        Top = 136
        Width = 129
        Height = 23
        TabStop = False
        DataField = 'Mod1Width'
        DataSource = dsMain
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object edtShutterWeight: TwwDBEdit
        Left = 176
        Top = 184
        Width = 129
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
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object cboMechanismType: TwwDBLookupCombo
        Left = 16
        Top = 88
        Width = 145
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        DataField = 'MechType'
        DataSource = dsMain
        LookupTable = qryMechanismType
        LookupField = 'Description'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 0
        AutoDropDown = False
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboMechanismTypeCloseUp
      end
      object cboCableRoller: TwwDBComboBox
        Left = 16
        Top = 136
        Width = 145
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'CableRoller'
        DataSource = dsMain
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'Cable Roller Surface'
          'Cable Roller Reveal'
          'Cable Roller Open')
        ParentFont = False
        Sorted = False
        TabOrder = 1
        UnboundDataType = wwDefault
        OnCloseUp = cboCableRollerCloseUp
      end
      object cboWinchPosition: TwwDBComboBox
        Left = 16
        Top = 184
        Width = 145
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'WinchPosition'
        DataSource = dsMain
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          'LEFT-HAND SIDE'
          'RIGHT-HAND SIDE')
        ParentFont = False
        Sorted = False
        TabOrder = 2
        UnboundDataType = wwDefault
        OnCloseUp = cboWinchPositionCloseUp
      end
    end
  end
  object qryMechanismType: TMyQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT Description, HeavyDuty'
      'FROM tblrollamechanism'
      'WHERE HeavyDuty=:HeavyDuty'
      'ORDER BY AscSeq;'
      '')
    Left = 376
    Top = 544
    ParamData = <
      item
        DataType = ftString
        Name = 'HeavyDuty'
        Value = ''
      end>
    object qryMechanismTypeDescription: TStringField
      DisplayWidth = 10
      FieldName = 'Description'
      Size = 50
    end
    object qryMechanismTypeHeavyDuty: TStringField
      FieldName = 'HeavyDuty'
      FixedChar = True
      Size = 1
    end
  end
end
