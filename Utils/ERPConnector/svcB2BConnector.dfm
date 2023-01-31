object ERPB2BConnector: TERPB2BConnector
  OldCreateOrder = False
  DisplayName = 'ERPB2BConnector'
  AfterInstall = ServiceAfterInstall
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
end
