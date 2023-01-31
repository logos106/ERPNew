object ERPApiTestService: TERPApiTestService
  OldCreateOrder = False
  DisplayName = 'ERPApiTestService'
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end
