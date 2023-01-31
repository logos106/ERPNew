object XMLServer: TXMLServer
  OldCreateOrder = False
  OnDestroy = ServiceDestroy
  AllowPause = False
  DisplayName = 'XML API Server'
  ErrorSeverity = esIgnore
  BeforeInstall = ServiceBeforeInstall
  AfterInstall = ServiceAfterInstall
  BeforeUninstall = ServiceBeforeUninstall
  AfterUninstall = ServiceAfterUninstall
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  OnStop = ServiceStop
  Left = 264
  Top = 175
  Height = 150
  Width = 215
end
