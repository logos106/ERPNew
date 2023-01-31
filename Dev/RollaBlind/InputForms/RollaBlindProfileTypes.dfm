inherited RollaBlindProfileTypesGUI: TRollaBlindProfileTypesGUI
  Caption = 'Profile Types'
  ClientHeight = 205
  ClientWidth = 513
  PixelsPerInch = 96
  TextHeight = 15
  inherited DNMPanel1: TDNMPanel
    Width = 513
    Height = 205
    inherited Bevel1: TBevel
      Width = 481
      Height = 80
    end
    object Label1: TLabel [1]
      Left = 40
      Top = 88
      Width = 67
      Height = 15
      Caption = 'Profile Type'
      Transparent = True
    end
    object Label2: TLabel [2]
      Left = 200
      Top = 88
      Width = 65
      Height = 15
      Caption = 'Description'
      Transparent = True
    end
    inherited pnlTitle: TDNMPanel
      Left = 152
      Width = 209
      TabOrder = 5
    end
    inherited btnSave: TDNMSpeedButton
      Top = 164
      TabOrder = 2
    end
    inherited btnCancel: TDNMSpeedButton
      Left = 318
      Top = 164
      TabOrder = 4
    end
    inherited btnNew: TDNMSpeedButton
      Top = 164
      TabOrder = 3
    end
    object wwDBEdit1: TwwDBEdit
      Left = 40
      Top = 104
      Width = 137
      Height = 23
      DataField = 'ProfileType'
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
    object wwDBEdit2: TwwDBEdit
      Left = 200
      Top = 104
      Width = 273
      Height = 23
      DataField = 'Description'
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
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 104
    Top = 40
  end
  inherited qryMain: TMyQuery
    SQL.Strings = (
      'SELECT * FROM tblrollaprofiletypes')
  end
  inherited dsMain: TDataSource
    Left = 72
  end
end
