inherited fmDoorDet: TfmDoorDet
  Left = 1333
  Top = 138
  Caption = 'Door Detials'
  ClientHeight = 513
  ClientWidth = 559
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 153000
  inherited DNMPanel1: TDNMPanel
    Width = 559
    Height = 59
    TabOrder = 1
    HelpContext = 153002
    inherited pnlTitle: TDNMPanel
      Left = 89
      Top = 7
      HelpContext = 153003
      inherited TitleShader: TShader
        HelpContext = 153004
        inherited TitleLabel: TLabel
          Caption = 'Door Details'
          HelpContext = 153005
        end
      end
    end
  end
  inherited DNMPanel2: TDNMPanel
    Top = 59
    Width = 559
    Height = 408
    TabOrder = 2
    HelpContext = 153006
    object DNMPanel4: TDNMPanel
      Left = 2
      Top = 2
      Width = 555
      Height = 68
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      HelpContext = 153007
      object Label3: TLabel
        Left = 17
        Top = 15
        Width = 54
        Height = 15
        Caption = 'Door type'
        Transparent = True
        HelpContext = 153008
      end
      object Label7: TLabel
        Left = 270
        Top = 15
        Width = 33
        Height = 15
        Caption = 'Finish'
        Transparent = True
        HelpContext = 153009
      end
      object Label1: TLabel
        Left = 270
        Top = 43
        Width = 66
        Height = 15
        Caption = 'Frame Type'
        Transparent = True
        HelpContext = 153010
      end
      object Label4: TLabel
        Left = 17
        Top = 43
        Width = 65
        Height = 15
        Caption = 'Description'
        Transparent = True
        HelpContext = 153011
      end
      object cboUnit: TwwDBComboBox
        Left = 383
        Top = 11
        Width = 151
        Height = 23
        ShowButton = True
        Style = csDropDown
        MapList = False
        AllowClearKey = False
        DataField = 'finish'
        DropDownCount = 8
        ItemHeight = 0
        Items.Strings = (
          'Wood'
          'Particleboard'
          'Ply For Paint'
          'Plywood'
          'Chipboard'
          'MDF'
          'M.D.F.')
        Sorted = False
        TabOrder = 1
        UnboundDataType = wwDefault
        HelpContext = 153012
      end
      object wwDBEdit3: TwwDBEdit
        Left = 119
        Top = 39
        Width = 120
        Height = 23
        DataField = 'Description'
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153013
      end
      object edtHeightMats: TwwDBEdit
        Left = 119
        Top = 11
        Width = 120
        Height = 23
        DataField = 'DoorType'
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153014
      end
      object wwDBEdit1: TwwDBEdit
        Left = 383
        Top = 39
        Width = 151
        Height = 23
        DataField = 'FrameType'
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153015
      end
    end
    object DNMPanel5: TDNMPanel
      Left = 2
      Top = 70
      Width = 555
      Height = 192
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      HelpContext = 153016
      object DNMPanel7: TDNMPanel
        Left = 1
        Top = 1
        Width = 254
        Height = 190
        Align = alLeft
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        HelpContext = 153017
        object Label6: TLabel
          Left = 17
          Top = 10
          Width = 69
          Height = 15
          Caption = 'Add Go Cost'
          Transparent = True
          HelpContext = 153018
        end
        object Label10: TLabel
          Left = 17
          Top = 36
          Width = 66
          Height = 15
          Caption = 'BCS Cost M'
          Transparent = True
          HelpContext = 153019
        end
        object Label8: TLabel
          Left = 17
          Top = 62
          Width = 71
          Height = 15
          Caption = 'BCS Cost Rb'
          Transparent = True
          HelpContext = 153020
        end
        object Label12: TLabel
          Left = 17
          Top = 88
          Width = 68
          Height = 15
          Caption = 'BCS Cost St'
          Transparent = True
          HelpContext = 153021
        end
        object Label11: TLabel
          Left = 17
          Top = 114
          Width = 69
          Height = 15
          Caption = 'BCS cost Sy'
          Transparent = True
          HelpContext = 153022
        end
        object Label13: TLabel
          Left = 17
          Top = 140
          Width = 50
          Height = 15
          Caption = 'Lab Cost'
          Transparent = True
          HelpContext = 153023
        end
        object Label14: TLabel
          Left = 17
          Top = 166
          Width = 77
          Height = 15
          Caption = 'Lam Lab cost'
          Transparent = True
          HelpContext = 153024
        end
        object wwDBEdit8: TwwDBEdit
          Left = 119
          Top = 162
          Width = 120
          Height = 23
          DataField = 'LamLabCost'
          TabOrder = 6
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 153025
        end
        object wwDBEdit6: TwwDBEdit
          Left = 119
          Top = 136
          Width = 120
          Height = 23
          DataField = 'Labcost'
          TabOrder = 5
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 153026
        end
        object wwDBEdit11: TwwDBEdit
          Left = 119
          Top = 110
          Width = 120
          Height = 23
          DataField = 'BCSCostSy'
          TabOrder = 4
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 153027
        end
        object wwDBEdit9: TwwDBEdit
          Left = 119
          Top = 84
          Width = 120
          Height = 23
          DataField = 'BCSCostSt'
          TabOrder = 3
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 153028
        end
        object wwDBEdit10: TwwDBEdit
          Left = 119
          Top = 58
          Width = 120
          Height = 23
          DataField = 'BCSCostRB'
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 153029
        end
        object wwDBEdit7: TwwDBEdit
          Left = 119
          Top = 32
          Width = 120
          Height = 23
          DataField = 'BCSCostM'
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 153030
        end
        object wwDBEdit5: TwwDBEdit
          Left = 119
          Top = 6
          Width = 120
          Height = 23
          DataField = 'AddGocost'
          TabOrder = 0
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 153031
        end
      end
      object DNMPanel8: TDNMPanel
        Left = 255
        Top = 1
        Width = 299
        Height = 190
        Align = alClient
        BevelOuter = bvNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        HelpContext = 153032
        object Label19: TLabel
          Left = 16
          Top = 85
          Width = 59
          Height = 15
          Caption = 'Thickness'
          Transparent = True
          HelpContext = 153033
        end
        object Label5: TLabel
          Left = 16
          Top = 59
          Width = 69
          Height = 15
          Caption = 'Lipping Stile'
          Transparent = True
          HelpContext = 153034
        end
        object Label2: TLabel
          Left = 16
          Top = 32
          Width = 88
          Height = 15
          Caption = 'Computer Code'
          Transparent = True
          HelpContext = 153035
        end
        object Label16: TLabel
          Left = 16
          Top = 8
          Width = 61
          Height = 15
          Caption = 'Int/Ex Type'
          Transparent = True
          HelpContext = 153036
        end
        object wwDBEdit16: TwwDBEdit
          Left = 129
          Top = 81
          Width = 152
          Height = 23
          DataField = 'Thickness'
          TabOrder = 2
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 153037
        end
        object wwDBEdit4: TwwDBEdit
          Left = 129
          Top = 55
          Width = 152
          Height = 23
          DataField = 'LippingStile'
          TabOrder = 1
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 153038
        end
        object wwDBEdit2: TwwDBEdit
          Left = 129
          Top = 28
          Width = 152
          Height = 23
          DataField = 'ComputerCode'
          TabOrder = 0
          UnboundDataType = wwDefault
          WantReturns = False
          WordWrap = False
          HelpContext = 153039
        end
        object DNMPanel9: TDNMPanel
          Left = 1
          Top = 111
          Width = 280
          Height = 75
          BevelInner = bvLowered
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          HelpContext = 153040
          object Label15: TLabel
            Left = 143
            Top = 5
            Width = 36
            Height = 15
            Caption = 'Height'
            Transparent = True
            HelpContext = 153041
          end
          object Label30: TLabel
            Left = 17
            Top = 25
            Width = 56
            Height = 15
            Caption = 'Maximum'
            Transparent = True
            HelpContext = 153042
          end
          object Label17: TLabel
            Left = 17
            Top = 51
            Width = 52
            Height = 15
            Caption = 'Minimum'
            Transparent = True
            HelpContext = 153043
          end
          object Label31: TLabel
            Left = 223
            Top = 5
            Width = 33
            Height = 15
            Caption = 'Width'
            Transparent = True
            HelpContext = 153044
          end
          object wwDBEdit14: TwwDBEdit
            Left = 125
            Top = 47
            Width = 72
            Height = 23
            DataField = 'MinHeight'
            TabOrder = 1
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            HelpContext = 153045
          end
          object wwDBEdit13: TwwDBEdit
            Left = 125
            Top = 21
            Width = 72
            Height = 23
            DataField = 'MaxHeight'
            TabOrder = 0
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            HelpContext = 153046
          end
          object wwDBEdit15: TwwDBEdit
            Left = 203
            Top = 21
            Width = 72
            Height = 23
            DataField = 'MaxWidth'
            TabOrder = 2
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            HelpContext = 153047
          end
          object wwDBEdit12: TwwDBEdit
            Left = 203
            Top = 47
            Width = 72
            Height = 23
            DataField = 'Minwidth'
            TabOrder = 3
            UnboundDataType = wwDefault
            WantReturns = False
            WordWrap = False
            HelpContext = 153048
          end
        end
        object wwRadioGroup1: TwwRadioGroup
          Left = 131
          Top = -9
          Width = 147
          Height = 32
          Transparent = True
          Columns = 2
          DataField = 'InternalExternal'
          Items.Strings = (
            'Internal'
            'External')
          TabOrder = 4
          Values.Strings = (
            'Internal'
            'External')
          HelpContext = 153049
        end
      end
    end
    object DNMPanel6: TDNMPanel
      Left = 2
      Top = 262
      Width = 555
      Height = 144
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      HelpContext = 153050
      object Label20: TLabel
        Left = 17
        Top = 10
        Width = 55
        Height = 15
        Caption = 'MonoLux '
        Transparent = True
        HelpContext = 153051
      end
      object Label21: TLabel
        Left = 17
        Top = 37
        Width = 51
        Height = 15
        Caption = 'NoComp '
        Transparent = True
        HelpContext = 153052
      end
      object Label22: TLabel
        Left = 17
        Top = 65
        Width = 53
        Height = 15
        Caption = 'PlyDepth '
        Transparent = True
        HelpContext = 153053
      end
      object Label23: TLabel
        Left = 17
        Top = 93
        Width = 50
        Height = 15
        Caption = 'Rebated '
        Transparent = True
        HelpContext = 153054
      end
      object Label24: TLabel
        Left = 17
        Top = 121
        Width = 77
        Height = 15
        Caption = 'Report Notes '
        Transparent = True
        HelpContext = 153055
      end
      object Label25: TLabel
        Left = 270
        Top = 10
        Width = 64
        Height = 15
        Caption = 'Short Type '
        Transparent = True
        HelpContext = 153056
      end
      object Label26: TLabel
        Left = 270
        Top = 37
        Width = 55
        Height = 15
        Caption = 'Standard '
        Transparent = True
        HelpContext = 153057
      end
      object Label27: TLabel
        Left = 270
        Top = 65
        Width = 54
        Height = 15
        Caption = 'Sundries '
        Transparent = True
        HelpContext = 153058
      end
      object Label28: TLabel
        Left = 270
        Top = 93
        Width = 60
        Height = 15
        Caption = 'System90 '
        Transparent = True
        HelpContext = 153059
      end
      object Label29: TLabel
        Left = 270
        Top = 121
        Width = 98
        Height = 15
        Caption = 'TwinFastScrews '
        Transparent = True
        HelpContext = 153060
      end
      object wwDBEdit17: TwwDBEdit
        Left = 119
        Top = 6
        Width = 120
        Height = 23
        DataField = 'MonoLux'
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153061
      end
      object wwDBEdit18: TwwDBEdit
        Left = 119
        Top = 33
        Width = 120
        Height = 23
        DataField = 'NoComp'
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153062
      end
      object wwDBEdit19: TwwDBEdit
        Left = 119
        Top = 61
        Width = 120
        Height = 23
        DataField = 'PlyDepth'
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153063
      end
      object wwDBEdit20: TwwDBEdit
        Left = 119
        Top = 89
        Width = 120
        Height = 23
        DataField = 'Rebated'
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153064
      end
      object wwDBEdit21: TwwDBEdit
        Left = 119
        Top = 117
        Width = 120
        Height = 23
        DataField = 'ReportNotes'
        TabOrder = 4
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153065
      end
      object wwDBEdit22: TwwDBEdit
        Left = 385
        Top = 6
        Width = 152
        Height = 23
        DataField = 'ShortType'
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153066
      end
      object wwDBEdit23: TwwDBEdit
        Left = 385
        Top = 33
        Width = 152
        Height = 23
        DataField = 'standard'
        TabOrder = 6
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153067
      end
      object wwDBEdit24: TwwDBEdit
        Left = 385
        Top = 61
        Width = 152
        Height = 23
        DataField = 'Sundries'
        TabOrder = 7
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153068
      end
      object wwDBEdit25: TwwDBEdit
        Left = 385
        Top = 89
        Width = 152
        Height = 23
        DataField = 'System90'
        TabOrder = 8
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153069
      end
      object wwDBEdit26: TwwDBEdit
        Left = 385
        Top = 117
        Width = 152
        Height = 23
        DataField = 'TWinFastScrews'
        TabOrder = 9
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        HelpContext = 153070
      end
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 467
    Width = 559
    TabOrder = 0
    HelpContext = 153071
    inherited Label9: TLabel
      Left = 513
      Anchors = [akBottom]
      HelpContext = 153072
    end
    inherited cmdSave: TDNMSpeedButton
      Left = 102
      TabOrder = 1
      HelpContext = 153073
    end
    inherited cmdCancel: TDNMSpeedButton
      Left = 367
      TabOrder = 3
      HelpContext = 153074
    end
    inherited cmdnew: TDNMSpeedButton
      Left = 234
      HelpContext = 153075
    end
    inherited wwCheckBox1: TwwCheckBox
      Left = 492
      Top = 15
      Anchors = [akBottom]
      TabOrder = 0
      HelpContext = 153076
    end
  end
  inherited imgGridWatermark: TImage
    HelpContext = 153001
  end
end
