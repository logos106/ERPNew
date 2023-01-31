object BaseListingDat: TBaseListingDat
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 215
  Width = 341
  object connMain: TERPConnection
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    LoginPrompt = False
    Left = 41
    Top = 48
  end
  object qryMain: TERPQuery
    Connection = connMain
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    Left = 131
    Top = 48
  end
end
