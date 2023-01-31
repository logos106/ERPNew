object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object Connection: TFDConnection
    AfterConnect = ConnectionAfterConnect
    Left = 40
    Top = 32
  end
  object Query: TFDQuery
    Connection = Connection
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    Left = 56
    Top = 96
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 128
    Top = 32
  end
end
