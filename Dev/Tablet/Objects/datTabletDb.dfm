object dmTabletDB: TdmTabletDB
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object Database: TDISQLite3Database
    AfterCreateDatabase = DatabaseAfterCreateDatabase
    Left = 64
    Top = 40
  end
  object Query: TDISQLite3UniDirQuery
    Database = Database
    Left = 128
    Top = 48
  end
end
