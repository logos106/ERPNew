unit XMLRequestConst;

interface

const

  { xml request header }
  XMLDocVersion         = '1.0';
  XMLDocEncoding        = 'UTF-8';

  { document root node }
  XMLNodeRoot = 'erpxml';

  { request block node }
  XMLNodeBlock = 'xmlBlock';
  { request block ticket attribute }
  XMLAttTicket = 'ticket';
  { request block timing attribute }
  XMLAttRequestTiming = 'requestTiming';
  { request block timing attribute values }
  XMLRequestTimingOn = 'on';
  XMLRequestTimingOff = 'off';
  { request block on error attribute }
  XMLAttOnError = 'onError';
  { request block on error attribute values }
  XMLOnErrorStop = 'stop';
  XMLOnErrorContinue = 'continue';

  { <request> node }
  XMLNodeRequest = 'request';
  { request data object attribute }
  XMLAttDataObject = 'dataObject';
  XMLAttLimitFieldList = 'limitFieldList';
  XMLAttExcludeInactive = 'excludeInactive';

  { request command attribute }
  XMLAttCommand = 'command';
  XMLCmdExecute = 'execute';
  XMLCmdTransaction = 'transaction';
  XMLCmdStartSession = 'startSession';
    { start session authorisation code node }
    XMLNodeAuthCode = 'authCode';
  XMLCmdEndSession = 'endSession';
  XMLCmdOpenCompany = 'openCompany';
    { open company value nodes }
    XMLNodeDataServer = 'dataServer';
    XMLNodeDataServerPort = 'dataServerPort';
    XMLNodeDatabase = 'database';
//    XMLNodeDataVersion = 'dataVersion';
    XMLNodeUser = 'user';
    XMLNodePass = 'pass';
  XMLCmdCloseCompany = 'closeCompany';
  XMLCmdSetFields = 'setFields';
  XMLCmdRead = 'read';
  XMLCmdAdd = 'add';
  XMLCmdModify = 'modify';

  XMLNodeLimit = 'limit';
  XMLNodeLimitCount = 'limitCount';
  XMLNodeLimitFrom = 'limitFrom';

  XMLNodeSelect = 'select';
  XMLNodeFilter = 'filter';
  XMLAttFilterName = 'filterName';
  XMLNodeSort = 'sort';
  XMLAttSortList = 'sortList';

  { <response> node }
  XMLNodeResponce = 'response';
  { result attribute }
  XMLAttResult = 'result';
  { result values }
  XMLResultOk = 'ok';
  XMLResultFail = 'fail';
  XMLResultNone = 'none';
  XMLResultNoData = 'noData';
  XMLResultWarning = 'warning';
  { reason attribute }
  XMLAttFailReason = 'reason';
  { reason attribute values }
  XMLFailReasonGeneral = 'general';
  XMLFailReasonException = 'exception';
  XMLFailReasonTransactionErrors = 'transactionErrors';
  XMLFailReasonNoCommand = 'noCommand';
  XMLFailReasonXMLInvalid = 'xmlInvalid';
  XMLFailReasonDeadSession = 'deadSession';
  XMLFailReasonBusySession = 'busySession';
  XMLFailReasonRequestInvalid = 'requestInvalid';
  XMLFailReasonNoSessionStart = 'noSessionStart';
  XMLFailReasonNoAuthCode = 'noAuthCode';
  XMLFailReasonInvalidAuthCode = 'invalidAuthCode';
  XMLFailReasonNoRequest = 'noRequest';
  XMLFailReasonDllLoadFail = 'dllLoadFail';
  XMLFailReasonLibNotFound = 'libNotFound';
  XMLFailReasonDbConnectFail = 'dbConnectFail';
  XMLFailReasonMaxSessionCountExceeded = 'maxSessionCountExceeded';
  XMLFailReasonSessionThreadAlreadyInUse = 'sessionThreadAlreadyInUse';
  XMLFailReasonCompanyNotOpen = 'companyNotOpen';
  XMLFailReasonNoDataObject = 'noDataObject';
  XMLFailReasonUnknownDataObject = 'unknownDataObject';
  XMLFailReasonNoOption = 'noOption';
  XMLFailReasonInvalidOption = 'invalidOption';
  XMLFailReasonUnknownCommand = 'unknownCommand';
  XMLFailReasonNoObjectStructure = 'noObjectStructure';
  XMLFailReasonObjectNotFound = 'objectNotFound';
  XMLFailReasonInvalidSort = 'invalidSort';
  { result description node }
  XMLNodeDesc = 'desc';
  XMLAttObjectCount = 'objectCount';
  XMLAttObjectNumber = 'objectNumber';

  { general }

  { start session result ticket node }
  XMLNodeTicket = 'ticket';

  { request/response common attributes }
  XMLAttClientRef = 'clientRef';
  XMLAttGlobalRef = 'globalRef';

  { general stuff }
  XMLAttRecId = 'recId';

  XMLNodeFieldList = 'fieldList';

  XMLAttOption = 'option';
  XMLOptionAdd = 'add';
  XMLOptionReplace = 'replace';

  XMLValTrue = 'true';
  XMLValFalse = 'false';


implementation

end.
