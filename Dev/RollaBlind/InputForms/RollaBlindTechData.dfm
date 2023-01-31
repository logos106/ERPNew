inherited RollaBlindTechDataGUI: TRollaBlindTechDataGUI
  ActiveControl = cboCategory
  Caption = 'Technical Data'
  ClientHeight = 258
  ClientWidth = 418
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    Width = 418
    Height = 258
    inherited Bevel1: TBevel
      Width = 386
      Height = 130
    end
    object Label1: TLabel [1]
      Left = 32
      Top = 88
      Width = 51
      Height = 15
      Caption = 'Category'
      Transparent = True
    end
    object Label2: TLabel [2]
      Left = 32
      Top = 144
      Width = 79
      Height = 15
      Caption = 'Measurement'
      Transparent = True
    end
    object Label3: TLabel [3]
      Left = 216
      Top = 88
      Width = 62
      Height = 15
      Caption = 'Guide Type'
      Transparent = True
    end
    object Label4: TLabel [4]
      Left = 216
      Top = 144
      Width = 27
      Height = 15
      Caption = 'Type'
      Transparent = True
    end
    inherited pnlTitle: TDNMPanel
      Left = 42
      Width = 330
    end
    inherited btnSave: TDNMSpeedButton
      Left = 60
      Top = 217
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 270
      Top = 217
    end
    inherited btnNew: TDNMSpeedButton
      Left = 165
      Top = 217
    end
    object cboCategory: TwwDBComboBox
      Left = 32
      Top = 104
      Width = 169
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      DataField = 'Category'
      DataSource = dsMain
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'DMG Measurement'
        'Drop Measurement'
        'Sill')
      ParentFont = False
      Sorted = False
      TabOrder = 4
      UnboundDataType = wwDefault
    end
    object wwDBEdit1: TwwDBEdit
      Left = 32
      Top = 160
      Width = 169
      Height = 23
      DataField = 'Measurement'
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
    object cboGuideType: TwwDBComboBox
      Left = 216
      Top = 104
      Width = 169
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
        'Commercial'
        'Heavy Duty'
        'Reveal'
        'Surface')
      ItemIndex = 2
      ParentFont = False
      Sorted = False
      TabOrder = 6
      UnboundDataType = wwDefault
    end
    object wwDBComboBox1: TwwDBComboBox
      Left = 216
      Top = 160
      Width = 169
      Height = 23
      ShowButton = True
      Style = csDropDownList
      MapList = False
      AllowClearKey = False
      DataField = 'Type'
      DataSource = dsMain
      DropDownCount = 8
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 0
      Items.Strings = (
        'Eave Surface'
        'Eave Reveal'
        'Eave Offset'
        'Surface Surface'
        'Surface Partial Eave'
        'Surface Partial Reveal'
        'Reveal Reveal'
        'Reveal Partial Eave'
        'Surface Heavy Duty'
        'Reveal Heavy Duty'
        'Casement Surface'
        'Casement Eave'
        'Rollavault Reveal')
      ItemIndex = 2
      ParentFont = False
      Sorted = False
      TabOrder = 7
      UnboundDataType = wwDefault
    end
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 288
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblrollainstallationmeasurements')
  end
  inherited dsMain: TDataSource
    Left = 288
  end
end
