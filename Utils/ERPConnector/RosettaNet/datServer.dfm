object dmServer: TdmServer
  OldCreateOrder = False
  Height = 243
  Width = 549
  object HTTPServer: TIdHTTPServer
    OnStatus = HTTPServerStatus
    Bindings = <>
    DefaultPort = 443
    IOHandler = IOHandler
    OnConnect = HTTPServerConnect
    OnDisconnect = HTTPServerDisconnect
    OnException = HTTPServerException
    OnListenException = HTTPServerListenException
    OnCommandError = HTTPServerCommandError
    OnCommandOther = HTTPServerCommandOther
    OnHeaderExpectations = HTTPServerHeaderExpectations
    OnCommandGet = HTTPServerCommandGet
    Left = 32
    Top = 16
  end
  object SessionPool: TElSessionPool
    Left = 128
    Top = 16
  end
  object ClientCertStorage: TElWinCertStorage
    Options = [csoStrictChainBuilding]
    ReadOnly = False
    Left = 216
    Top = 16
  end
  object CertStorage: TElMemoryCertStorage
    Options = [csoStrictChainBuilding]
    Left = 304
    Top = 24
  end
  object IOHandler: TElIndySSLServerIOHandler
    OnStatus = IOHandlerStatus
    CertStorage = CertStorage
    ClientAuthentication = False
    OnCertificateValidate = IOHandlerCertificateValidate
    OnCiphersNegotiated = IOHandlerCiphersNegotiated
    OnError = IOHandlerError
    OnSSLEstablished = IOHandlerSSLEstablished
    ServerCertStorage = CertStorage
    SessionPool = SessionPool
    Versions = [sbSSL2, sbSSL3, sbTLS1, sbTLS11, sbTLS12]
    ConnectTimeout = 0
    ReadTimeout = 0
    RenegotiationAttackPreventionMode = rapmCompatible
    Left = 392
    Top = 24
  end
end
