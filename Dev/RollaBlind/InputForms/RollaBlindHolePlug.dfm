inherited RollaBlindHolePlugGUI: TRollaBlindHolePlugGUI
  Caption = 'Hole Plug Data'
  ClientHeight = 330
  ClientWidth = 358
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    Width = 358
    Height = 330
    inherited Bevel1: TBevel
      Width = 326
      Height = 202
    end
    object Label1: TLabel [1]
      Left = 88
      Top = 96
      Width = 50
      Height = 15
      Caption = 'Min Drop'
      Transparent = True
    end
    object Label2: TLabel [2]
      Left = 88
      Top = 152
      Width = 54
      Height = 15
      Caption = 'Max Drop'
      Transparent = True
    end
    object Label3: TLabel [3]
      Left = 88
      Top = 208
      Width = 94
      Height = 15
      Caption = 'Number of Plugs'
      Transparent = True
    end
    inherited pnlTitle: TDNMPanel
      Left = 52
      Width = 255
      TabOrder = 6
    end
    inherited btnSave: TDNMSpeedButton
      Left = 30
      Top = 289
      TabOrder = 3
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 240
      Top = 289
      TabOrder = 5
    end
    inherited btnNew: TDNMSpeedButton
      Left = 135
      Top = 289
      TabOrder = 4
    end
    object edtMinDrop: TwwDBEdit
      Left = 88
      Top = 112
      Width = 185
      Height = 23
      DataField = 'MinDrop'
      DataSource = dsMain
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
    object edtMaxDrop: TwwDBEdit
      Left = 88
      Top = 168
      Width = 185
      Height = 23
      DataField = 'MaxDrop'
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
    end
    object edtNumberOfPlugs: TwwDBEdit
      Left = 88
      Top = 224
      Width = 185
      Height = 23
      DataField = 'PlugNumber'
      DataSource = dsMain
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
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblrollaholeplugs')
    object qryMainMinDrop: TFloatField
      FieldName = 'MinDrop'
    end
    object qryMainMaxDrop: TFloatField
      FieldName = 'MaxDrop'
    end
    object qryMainPlugNumber: TFloatField
      FieldName = 'PlugNumber'
    end
  end
end
