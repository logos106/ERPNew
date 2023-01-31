inherited RollaBlindStage2crGUI: TRollaBlindStage2crGUI
  Caption = 'Cut-out Sheet - Step 2'
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    inherited btnBack: TDNMSpeedButton
      Enabled = True
    end
    inherited DNMPanel2: TDNMPanel
      inherited ScrollBox: TScrollBox
        Visible = False
      end
    end
    inherited DNMPanel3: TDNMPanel
      object Label11: TLabel
        Left = 16
        Top = 72
        Width = 114
        Height = 15
        Caption = 'Guide Measurement'
        Transparent = True
      end
      object Label43: TLabel
        Left = 16
        Top = 168
        Width = 58
        Height = 15
        Caption = 'Lock Type'
        Transparent = True
      end
      object Label46: TLabel
        Left = 16
        Top = 216
        Width = 77
        Height = 15
        Caption = 'Type of Stops'
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
      object Label35: TLabel
        Left = 16
        Top = 120
        Width = 127
        Height = 15
        Caption = 'Hidden Profile Number'
        Transparent = True
      end
      object cboGuideMeasurement: TwwDBComboBox
        Left = 16
        Top = 88
        Width = 129
        Height = 23
        ShowButton = True
        Style = csDropDownList
        MapList = False
        AllowClearKey = False
        DataField = 'CurtainFigure'
        DataSource = dsMain
        DropDownCount = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemHeight = 0
        Items.Strings = (
          '60'
          '55'
          '40'
          '70')
        ParentFont = False
        Sorted = False
        TabOrder = 0
        UnboundDataType = wwDefault
        OnCloseUp = cboGuideMeasurementCloseUp
      end
      object cboLockType: TwwDBComboBox
        Left = 16
        Top = 184
        Width = 129
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
        TabOrder = 2
        UnboundDataType = wwDefault
        OnCloseUp = cboLockTypeCloseUp
      end
      object cboStopsType: TwwDBComboBox
        Left = 16
        Top = 232
        Width = 129
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
          'None'
          'Standard'
          'Aluminium')
        ParentFont = False
        Sorted = False
        TabOrder = 3
        UnboundDataType = wwDefault
        OnCloseUp = cboStopsTypeCloseUp
      end
      object cboStarterLink: TwwDBComboBox
        Left = 16
        Top = 280
        Width = 129
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
          'None'
          'Standard'
          'Spring')
        ParentFont = False
        Sorted = False
        TabOrder = 4
        UnboundDataType = wwDefault
        OnCloseUp = cboStarterLinkCloseUp
      end
      object edtHiddenProfileNumber: TwwDBEdit
        Left = 16
        Top = 136
        Width = 129
        Height = 23
        DataField = 'HiddenProfileNumber'
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
        OnExit = edtHiddenProfileNumberExit
      end
    end
  end
end
