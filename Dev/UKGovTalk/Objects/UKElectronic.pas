unit UKElectronic;
{       This handles communications to the UK Government portal ,GovTalk, using
        their Document submission protocol.
        The 4 messages generated are:
          SUBMISSION_REQUEST
          SUBMISSION_POLL
          DATA_REQUEST
          DELETE_REQUEST

        The 6 possible messages returned from the Gateway are:
          SUBMISSION_ACKNOWLEDGMENT
          SUBMISSION_ERROR
          SUBMISSION_RESPONSE
          DATA_RESPONSE
          DELETE_RESPONSE
          DELETE_ACKNOWLEDGE
}
{       Logic Flow (Data request(list) is not shown)

        Execute
          |
          according to Current Response Type
    __________|_________________________________________
    |      |              |            |                |
    |      Submit        Poll          DataRequest     DeleteRequest
    |      |              |            |                |
    |      |             TPollMessage  TDataRequest    TDeleteRequest
    |      |
    |     Create Submit message(TSubmitMessage)
    |      |
    |     Send using Client(TUKGovTalkClientObj)
    |      |
    |     Client returns XML which is a property for Response (TResponseObj)
    |      |
    |     Response.ProcessResponse
    |      |
    |     HandleResponse(Response.Reaction)  writes current response type to back end
    |      |
    |_____/\__________________________________
               |          |                  |
              Stop       TooManyAttempts
}

interface
uses
  UKGovTalkClient,ResponseObj,Classes, BusObjUKGovGateway,BusObjGovGatewayTest;

const
  URL_TEST =  'https://secure.dev.gateway.gov.uk/submission';
  URL_LIVE =  'https://secure.gateway.gov.uk/submission';

type
  TRec = class(TObject)
  private
  public
    sDocType            : string;
    sID                 : string;
    sState              : string;
    sCorrelationID      :string;
    iPollInterval       :integer;
    sResponseEndPoint   :string;
  end;

type
  TUKElectronic = class;
  TUKElectronicEvent  = procedure(const Sender: TUKElectronic; const EventType, Value: string) of object;

  TUKElectronic = class(TObject)
  private
    fbStop :Boolean;
    fInitialSessionReponseReceived :boolean;
    fDeclarationType            :string;
    fGenericKeyID               :integer;
    BusObjGateway               :Tukgovgateway;
    BusObjGatewayTest           :TukgovgatewayTest;
    Client                      :TUKGovTalkClientObj;
    Response                    :TResponseObj;
    fAuthenticationValue        :string;
    fTestValue                  :string;
    fSenderID                   :string;
    fKeyType                    :string;
    fKeys                       :string;
    fVendorID                   :string;
    fYear                       :integer;
    fMonth                      :string;
    fCurrencyCode               :string;

    fOnMessageChange: TUKElectronicEvent;
    fListStartDate,fListEndDate :string;
    fRecList: TList;
    fStatus:string;
    procedure Submit;
    procedure Poll;

    procedure DeleteRequest;   overload;
    procedure DeleteRequest(const sCorrelationID:string; const sDeclarationType:string); overload;
    procedure HandleResponse(const Reaction:string);
    procedure HandleBodyErrors;
    procedure LoadListReceived;
    procedure HandleListErrors;
    procedure HandleManyAttempts;
    procedure Finalise;
    procedure SaveSentXMLToFile(const sXML:string);
    procedure SaveResponseXMLToFile(const sXML:string);
    procedure TriggerEvents;
    function AnalyseBody:string;
    function GetGenericKeyID(const CorrelationID:string):string;

  public
    constructor Create;
    Destructor  Destroy;  override;
    property DeclarationType :string read fDeclarationType write fDeclarationType ;
    property GenericKeyID :integer read fGenericKeyID  write fGenericKeyID ;
    property AuthenticationValue :string read fAuthenticationValue write fAuthenticationValue;
    property TestValue:string read fTestValue write fTestValue;
    property SenderID:string read fSenderID write fSenderID;
    property KeyType :string read fKeyType write fKeyType;
    property Keys:string read fKeys write fKeys;
    property VendorID :string read fVendorID write fVendorID;
    property Year :integer read fYear write fYear;
    property Month :string read fMonth write fMonth;
    property CurrencyCode :string read fCurrencyCode write fCurrencyCode;   
    property Stop:boolean read fbStop write fbStop;
    property OnMessageChange: TUKElectronicEvent read fOnMessageChange write fOnMessageChange;
    property ListStartDate :string read fListStartDate write fListStartDate;
    property ListEndDate :string read fListEndDate write fListEndDate;
    property GatewayList:TList read fRecList;
    property Status:string read fStatus;
    procedure Execute;
    procedure SendDataRequest; {list}
    procedure ProcessGatewayList;
    procedure FinaliseList;
    procedure Initialise;
    procedure ReSubmit;
  end;

implementation

uses
  SysUtils,Dialogs,FastFuncs,DnMLib, LibXMLParser,MyAccess,ERPdbComponents,
  BaseGovtalkMessage,DataRequest,SubmitMessage,PollMessage,DeleteRequest,
  CommonDBLib,AppEnvironment,Forms;       
const
   VAT_DECLARATION_CLASS = 'HMCE-VATDEC-ORG-VAT100-STD';

constructor TUKElectronic.Create;
begin
  inherited;
  BusObjGateway  := Tukgovgateway.Create(nil);
  BusObjGatewayTest  := TukgovgatewayTest.Create(nil);
  Client         := TUKGovTalkClientObj.Create;
  Response       := TResponseObj.Create;
  fRecList        := TList.Create;
  VendorID := AppEnv.CompanyPrefs.VATVendorID;
  SenderID := AppEnv.CompanyPrefs.VATSenderID;
  KeyType  := AppEnv.CompanyPrefs.VATKeyType;
  Keys     := AppEnv.CompanyPrefs.VATKeys;
  CurrencyCode := AppEnv.CompanyPrefs.VATCurrencyCode;
  AuthenticationValue := AppEnv.CompanyPrefs.VATAuthentication;
end;

Destructor TUKElectronic.Destroy;
begin
  FreeAndNil(BusObjGateway);
  FreeAndNil(BusObjGatewayTest);
  FreeAndNil(Client);
  FreeAndNil(Response); 
  while fRecList.Count > 0 do begin
    TRec(fRecList[0]).Free;
    fRecList.Delete(0);
  end;
  inherited;
end;
procedure TUKElectronic.ReSubmit;
begin
  if AppEnv.CompanyPrefs.UKGatewayIsLive then BusObjGateway.CurrentResponseType := ''  
  else BusObjGatewayTest.CurrentResponseType := '';
  Submit;
end;

procedure TUKElectronic.Initialise;
begin
  if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
    BusObjGateway.LoadSelect('GenericKeyID = ' + IntToStr(GenericKeyID) + ' AND DeclarationType = ' + QuotedStr(DeclarationType));
    if BusObjGateway.Dataset.RecordCount > 0 then
      fStatus := BusObjGateway.CurrentResponseType
    else fStatus := 'Not submitted.';
    if BusObjGateway.CurrentResponseType = 'SUBMISSION_ERROR' then fOnMessageChange(self,'OfferTrySubmitAgain','This submission has previously returned an error. Do you wish to resubmit?');
  end else begin
    BusObjGatewayTest.LoadSelect('GenericKeyID = ' + IntToStr(GenericKeyID) + ' AND DeclarationType = ' + QuotedStr(DeclarationType));
    if BusObjGatewayTest.Dataset.RecordCount > 0 then
      fStatus := BusObjGatewayTest.CurrentResponseType
    else fStatus := 'Not submitted.';
    if BusObjGatewayTest.CurrentResponseType = 'SUBMISSION_ERROR' then fOnMessageChange(self,'OfferTrySubmitAgain','This submission has previously returned an error. Do you wish to resubmit?');
  end;
  fOnMessageChange(self,'UpdateStatus',fStatus); 
end;

procedure TUKElectronic.Execute;
var
  tmpID:integer;
  tmpReaction:string;
begin
  if (DeclarationType = '') or (GenericKeyID = 0) then begin
    fOnMessageChange(self,'MissingData','Missing KeyID');
    exit;
  end;

  if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
    BusObjGateway.LoadSelect('GenericKeyID = ' + IntToStr(GenericKeyID) + ' AND DeclarationType = ' + QuotedStr(DeclarationType));
    if BusObjGateway.Dataset.RecordCount = 0 then begin
      BusObjGateway.New;
      BusObjGateway.GenericKeyID := GenericKeyID;
      BusObjGateway.DeclarationType := DeclarationType;
      BusObjGateway.PostDb;
      tmpID := BusObjGateway.DeclarationID ;
      BusObjGateway.Load(tmpID);
      Submit;
    end else begin
      if BusObjGateway.IsFinalised then begin
        fOnMessageChange(self,'Finalised','This Declaration has already been successfully submitted.');
        Exit;
      end;

      if fInitialSessionReponseReceived = False then begin
        BusObjGateway.NoOfAttempts := 0;
        BusObjGateway.PostDb;
      end;

      if BusObjGateway.CurrentResponseType = 'SUBMISSION_ACKNOWLEDGE' then
        tmpReaction := 'Poll'
      else if (BusObjGateway.CurrentResponseType = 'SUBMISSION_ERROR') and (BusObjGateway.CorrelationID <> '') then begin
        if fInitialSessionReponseReceived = false then begin
          tmpReaction := 'Submit'
        end else begin
          if (BusObjGateway.ErrorType = 'fatal') then tmpReaction := 'Stop'
          else if BusObjGateway.ErrorType = 'business' then tmpReaction := 'HandleBodyError'
          else if BusObjGateway.ErrorType = 'recoverable' then begin
            if BusObjGateway.CurrentSentType = 'SUBMISSION_REQUEST' then tmpReaction := 'Submit'
            else if BusObjGateway.CurrentSentType = 'SUBMISSION_POLL' then tmpReaction := 'Poll';
          end;
        end;
      end else if (BusObjGateway.CurrentResponseType = 'SUBMISSION_ERROR') and (BusObjGateway.CorrelationID = '') then begin
        tmpReaction := 'Submit';
      end else if BusObjGateway.CurrentResponseType = 'SUBMISSION_RESPONSE' then
        tmpReaction := 'Delete'
      else if BusObjGateway.CurrentResponseType = 'DELETE_RESPONSE' then
        tmpReaction := 'Finalise'
      else if BusObjGateway.CurrentResponseType = 'DELETE_ACKNOWLEDGE' then
        tmpReaction := 'Delete'
      else if (BusObjGateway.CurrentResponseType = 'DATA_RESPONSE') and (BusObjGateway.CorrelationID <> '') then begin
        if fInitialSessionReponseReceived = False then
          tmpReaction := 'Poll'
        else tmpReaction := 'DataReceived';
      end else if (BusObjGateway.CurrentResponseType = 'DATA_RESPONSE') and (BusObjGateway.CorrelationID = '') then begin
        tmpReaction := 'Submit';
      end else if BusObjGateway.CurrentResponseType = '' then begin
        Submit;
      end;
    end;
  end else begin
    BusObjGatewayTest.LoadSelect('GenericKeyID = ' + IntToStr(GenericKeyID) + ' AND DeclarationType = ' + QuotedStr(DeclarationType));
    if BusObjGatewayTest.Dataset.RecordCount = 0 then begin
      BusObjGatewayTest.New;
      BusObjGatewayTest.GenericKeyID := GenericKeyID;
      BusObjGatewayTest.DeclarationType := DeclarationType;
      BusObjGatewayTest.PostDb;
      tmpID := BusObjGatewayTest.ID ;
      BusObjGatewayTest.Load(tmpID);
      Submit;
    end else begin
      if BusObjGatewayTest.IsFinalised then begin
        fOnMessageChange(self,'Finalised','This Declaration has already been successfully submitted.');
        Exit;
      end;

      if fInitialSessionReponseReceived = False then begin
        BusObjGatewayTest.NoOfAttempts := 0;
        BusObjGatewayTest.PostDb;
      end;

      if BusObjGatewayTest.CurrentResponseType = 'SUBMISSION_ACKNOWLEDGE' then
        tmpReaction := 'Poll'
      else if (BusObjGatewayTest.CurrentResponseType = 'SUBMISSION_ERROR') and (BusObjGatewayTest.CorrelationID <> '') then begin
        if fInitialSessionReponseReceived = false then begin
          tmpReaction := 'Submit'
        end else begin
          if (BusObjGatewayTest.ErrorType = 'fatal') then tmpReaction := 'Stop'
          else if BusObjGatewayTest.ErrorType = 'business' then tmpReaction := 'HandleBodyError'
          else if BusObjGatewayTest.ErrorType = 'recoverable' then begin
            if BusObjGatewayTest.CurrentSentType = 'SUBMISSION_REQUEST' then tmpReaction := 'Submit'
            else if BusObjGatewayTest.CurrentSentType = 'SUBMISSION_POLL' then tmpReaction := 'Poll';
          end;
        end;
      end else if (BusObjGatewayTest.CurrentResponseType = 'SUBMISSION_ERROR') and (BusObjGatewayTest.CorrelationID = '') then begin
        tmpReaction := 'Submit';
      end else if BusObjGatewayTest.CurrentResponseType = 'SUBMISSION_RESPONSE' then
        tmpReaction := 'Delete'
      else if BusObjGatewayTest.CurrentResponseType = 'DELETE_RESPONSE' then
        tmpReaction := 'Finalise'
      else if BusObjGatewayTest.CurrentResponseType = 'DELETE_ACKNOWLEDGE' then
        tmpReaction := 'Delete'
      else if (BusObjGatewayTest.CurrentResponseType = 'DATA_RESPONSE') and (BusObjGatewayTest.CorrelationID <> '') then begin
        if fInitialSessionReponseReceived = False then
          tmpReaction := 'Poll'
        else tmpReaction := 'DataReceived';
      end else if (BusObjGatewayTest.CurrentResponseType = 'DATA_RESPONSE') and (BusObjGatewayTest.CorrelationID = '') then begin
        tmpReaction := 'Submit';  
      end else if BusObjGateway.CurrentResponseType = '' then begin
        Submit;
      end;
    end;
  end;
  HandleResponse(tmpReaction);
end;


procedure TUKElectronic.SaveSentXMLToFile(const sXML:string);
var
  fs: TFileStream;         //for debugging
begin
  if not DirectoryExists(GetCurrentDir +'\GovTalkFilesSent') then
    if not CreateDir(GetCurrentDir +'\GovTalkFilesSent') then
    raise Exception.Create('Cannot create ' + GetCurrentDir + '\GovTalkFilesSent');
  if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
    If FileExists('\GovTalkFilesSent\' + IntToStr(BusObjGateway.DeclarationID) + '.xml') then
      DeleteFiles('\GovTalkFilesSent\', IntToStr(BusObjGateway.DeclarationID) + '.xml');

    fs := TFileStream.Create(GetCurrentDir + '\GovTalkFilesSent\' + IntToStr(BusObjGateway.DeclarationID)  + '.xml', fmCreate or fmOpenWrite);
  end else begin
    If FileExists('\GovTalkFilesSent\' + IntToStr(BusObjGatewayTest.ID) + '.xml') then
      DeleteFiles('\GovTalkFilesSent\', IntToStr(BusObjGatewayTest.ID) + '.xml');

    fs := TFileStream.Create(GetCurrentDir + '\GovTalkFilesSent\' + IntToStr(BusObjGatewayTest.ID)  + '.xml', fmCreate or fmOpenWrite);
  end;

  try
    fs.Write(PChar(sXML)^, Length(sXML));
  finally
    fs.Free;
  end;
end;

procedure TUKElectronic.SaveResponseXMLToFile(const sXML:string);
var
  fs: TFileStream;
begin
  if not DirectoryExists(GetCurrentDir +'\GovTalkResponseFiles') then
    if not CreateDir(GetCurrentDir +'\GovTalkResponseFiles') then
    raise Exception.Create('Cannot create ' + GetCurrentDir + '\GovTalkResponseFiles');
  if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
    If FileExists('\GovTalkResponseFiles\' + IntToStr(BusObjGateway.DeclarationID) + '.xml') then
      DeleteFiles('\GovTalkResponseFiles\', IntToStr(BusObjGateway.DeclarationID) + '.xml');

    fs := TFileStream.Create(GetCurrentDir + '\GovTalkResponseFiles\' + IntToStr(BusObjGateway.DeclarationID)  + '.xml', fmCreate or fmOpenWrite);
  end else begin
    If FileExists('\GovTalkResponseFiles\' + IntToStr(BusObjGatewayTest.ID) + '.xml') then
      DeleteFiles('\GovTalkResponseFiles\', IntToStr(BusObjGatewayTest.ID) + '.xml');

    fs := TFileStream.Create(GetCurrentDir + '\GovTalkResponseFiles\' + IntToStr(BusObjGatewayTest.ID)  + '.xml', fmCreate or fmOpenWrite);
  end;
  try
    fs.Write(PChar(sXML)^, Length(sXML));
  finally
    fs.Free;
  end;
end;

procedure TUKElectronic.TriggerEvents;
begin
  if Assigned(fOnMessageChange) then fOnMessageChange(self,'UpdateStatus','Reponse received');
  if Assigned(fOnMessageChange) then fOnMessageChange(self,'UpdateErrorMsg',Response.ResponseErrorMsg);
  if Assigned(fOnMessageChange) then fOnMessageChange(self,'UpdateErrorType',Response.ResponseErrorType);
  if Assigned(fOnMessageChange) then fOnMessageChange(self,'UpdateErrorNumber',Response.ResponseErrorNumber);
  if Assigned(fOnMessageChange) then fOnMessageChange(self,'UpdateErrorLocation',Response.ResponseErrorLocation);
end;

procedure TUKElectronic.Submit;
var
  SubmitMessage:TSubmitMessage;
  PollInterval :integer;
  LastMessageSent:TDateTime;
begin
  fOnMessageChange(self,'Submit','Submit');
  //wait for poll interval
  if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
    PollInterval := BusObjGateway.PollInterval ;
    LastMessageSent := BusObjGateway.LastMessageSent;
  end else begin
    PollInterval := BusObjGatewayTest.PollInterval;
    LastMessageSent := BusObjGatewayTest.LastMessageSent;
  end;

  while now < (LastMessageSent + (PollInterval/24/60/60)) do begin
    Sleep(200);
    Application.ProcessMessages;
    if fbStop then exit;
  end;
  SubmitMessage := TSubmitMessage.Create;
  SubmitMessage.DocType := DeclarationType;
  SubmitMessage.GenericKeyID := IntToStr(GenericKeyID);
  try
    if DeclarationType = 'VAT' then
      SubmitMessage.DocumentClass := VAT_DECLARATION_CLASS
    else if DeclarationType = 'PAYE' then
      SubmitMessage.DocumentClass := ''; {  add others as required }

    SubmitMessage.SenderID := SenderID;
    SubmitMessage.KeyType  := KeyType;
    SubmitMessage.Keys     := Keys;
    SubmitMessage.VendorID := VendorId;
    SubmitMessage.AuthenticationValue := AuthenticationValue;
    SubmitMessage.Year     := Year;
    SubmitMessage.Month    := Month;
    SubmitMessage.CurrencyCode := CurrencyCode;
    if AppEnv.CompanyPrefs.UKGatewayIsLive then  begin
      SubmitMessage.TestValue := '0';
      Client.IsLive := True;
    end else begin
      SubmitMessage.TestValue := '1';
      Client.IsLive := False;
    end;

    Client.XML := SubmitMessage.XML;
    SaveSentXMLToFile(Client.XML); //in case debugging needed

    if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
      BusObjGateway.LastMessageSent := Now;
      Client.URL := URL_LIVE;
      if Client.Send then begin
        BusObjGateway.CurrentSentType := 'SUBMISSION_REQUEST';
        Response.XML := Client.Response;
        Response.ProcessResponse(BusObjGateway);
        BusObjGateway.PostDb;
        SaveResponseXMLToFile(Response.XML); //in case debugging needed
        fInitialSessionReponseReceived := True;

        TriggerEvents;
        HandleResponse(Response.Reaction);
      end else begin
        fOnMessageChange(self,'TransmissionFailure','Transmission failure.');
      end;
    end else begin
      BusObjGatewayTest.LastMessageSent := Now;
      Client.URL := URL_TEST;
      if Client.Send then begin
        BusObjGatewayTest.CurrentSentType := 'SUBMISSION_REQUEST';
        Response.XML := Client.Response;
        Response.ProcessResponse(BusObjGatewayTest);
        BusObjGatewayTest.PostDb;
        SaveResponseXMLToFile(Response.XML); //in case debugging needed
        fInitialSessionReponseReceived := True;

        TriggerEvents;
        HandleResponse(Response.Reaction);
      end else begin
        fOnMessageChange(self,'TransmissionFailure','Transmission failure.');
      end;
    end;
  finally
    if Assigned(SubmitMessage) then FreeAndNil(SubmitMessage);
  end;
end;

procedure TUKElectronic.SendDataRequest;
var
  DataRequest :TDataRequest;
  PollInterval :integer;
  LastMessageSent:TDateTime;
begin
  if (fListStartDate = '') or (fListEndDate = '') then begin
    fOnMessageChange(self,'MissingListDates','Start and End Dates need to be selected.');
    exit;
  end;

  if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
    PollInterval := BusObjGateway.PollInterval;
    LastMessageSent := BusObjGateway.LastMessageSent;
  end else begin
    PollInterval := BusObjGatewayTest.PollInterval;
    LastMessageSent := BusObjGatewayTest.LastMessageSent;
  end;

  while now < (LastMessageSent + (PollInterval/24/60/60)) do begin
    Sleep(200); 
    Application.ProcessMessages;
    if fbStop then exit;
  end;

  if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
    Client.IsLive := True;
    if BusObjGateway.NoOfAttempts > 0 then begin
      BusObjGateway.NoOfAttempts := 0;
      BusObjGateway.PostDb;
    end;
  end else begin
    Client.IsLive := False;
    if BusObjGatewayTest.NoOfAttempts > 0 then begin
      BusObjGatewayTest.NoOfAttempts := 0;
      BusObjGatewayTest.PostDb;
    end;
  end;

  DataRequest := TDataRequest.Create;
  try
    if DeclarationType = 'VAT' then
      DataRequest.DocumentClass := VAT_DECLARATION_CLASS
    else if DeclarationType = 'PAYE' then
      DataRequest.DocumentClass := ''; {  add others as required }


    DataRequest.SenderID := SenderID;
    DataRequest.VendorID := VendorID;
    DataRequest.StartDate := ListStartDate;
    DataRequest.EndDate   := ListEndDate;
    DataRequest.KeyType   := KeyType;
    DataRequest.Keys      := Keys;
    DataRequest.AuthenticationValue := AuthenticationValue;
    Client.XML := DataRequest.XML;

    SaveSentXMLToFile(Client.XML); //in case debugging needed

    if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
      BusObjGateway.LastMessageSent := Now;
      Client.URL := URL_LIVE;
      BusObjGateway.PostDb;
      if Client.Send then begin
        Response.XML := Client.Response;
        Response.ProcessResponse(BusObjGateway);
        fInitialSessionReponseReceived := True;
        TriggerEvents;
        SaveResponseXMLToFile(Response.XML); //in case debugging needed
        HandleResponse(Response.Reaction);
      end else begin
        fOnMessageChange(self,'TransmissionFailure','Transmission failure.');
      end;
    end else begin
      BusObjGatewayTest.LastMessageSent := Now;
      BusObjGatewayTest.PostDb;
      Client.URL := URL_TEST;
      if Client.Send then begin
        Response.XML := Client.Response;
        Response.ProcessResponse(BusObjGatewayTest);
        fInitialSessionReponseReceived := True;
        TriggerEvents;
        SaveResponseXMLToFile(Response.XML); //in case debugging needed     
        HandleResponse(Response.Reaction);
      end else begin
        fOnMessageChange(self,'TransmissionFailure','Transmission failure.');
      end;
    end;
  finally
    if Assigned(DataRequest) then FreeAndNil(DataRequest);
  end;
end;

procedure TUKElectronic.Poll;
var
  PollMessage:TPollMessage;
  PollInterval :integer;
  LastMessageSent:TDateTime;
begin
  if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
    PollInterval := BusObjGateway.PollInterval;
    LastMessageSent := BusObjGateway.LastMessageSent;
  end else begin
    PollInterval := BusObjGatewayTest.PollInterval;
    LastMessageSent := BusObjGatewayTest.LastMessageSent; 
  end;
  while now <= (LastMessageSent + (PollInterval/24/60/60)) do begin
    Sleep(200); 
    Application.ProcessMessages;
    if fbStop then exit;
  end;     

  PollMessage := TPollMessage.Create;
  try
    if DeclarationType = 'VAT' then
      PollMessage.DocumentClass := VAT_DECLARATION_CLASS
    else if DeclarationType = 'PAYE' then
      PollMessage.DocumentClass := ''; { : add others as required }

    PollMessage.SenderID := SenderID;
    PollMessage.KeyType  := KeyType;
    PollMessage.Keys     := Keys;
    PollMessage.VendorID := VendorId;
    PollMessage.AuthenticationValue := AuthenticationValue;


    if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
      PollMessage.CorrelationID := BusObjGateway.CorrelationID;
      PollMessage.TestValue := '0';
      Client.IsLive := True;
      Client.XML := PollMessage.XML;

      SaveSentXMLToFile(Client.XML); //in case debugging needed
      BusObjGateway.LastMessageSent := Now;
      BusObjGateway.PostDb;
      Client.URL := BusObjGateway.ResponseEndPoint;
      if Client.Send then begin
        BusObjGateway.CurrentSentType := 'SUBMISSION_POLL';
        Response.XML := Client.Response;

        Response.ProcessResponse(BusObjGateway);
        TriggerEvents;

        SaveResponseXMLToFile(Response.XML); //in case debugging needed
        fInitialSessionReponseReceived := True;
        HandleResponse(Response.Reaction);
      end else begin
        fOnMessageChange(self,'TransmissionFailure','Transmission failure.');
      end;
    end else begin
      PollMessage.CorrelationID := BusObjGatewayTest.CorrelationID;
      PollMessage.TestValue     := '1';
      Client.IsLive := False;
      Client.XML := PollMessage.XML;

      SaveSentXMLToFile(Client.XML); //in case debugging needed
      BusObjGatewayTest.LastMessageSent := Now;
      BusObjGatewayTest.PostDb;
      Client.URL := BusObjGatewayTest.ResponseEndPoint;
      if Client.Send then begin
        BusObjGatewayTest.CurrentSentType := 'SUBMISSION_POLL';
        Response.XML := Client.Response;

        Response.ProcessResponse(BusObjGatewayTest);
        TriggerEvents;

        SaveResponseXMLToFile(Response.XML); //in case debugging needed
        fInitialSessionReponseReceived := True;
        HandleResponse(Response.Reaction);
      end else begin
        fOnMessageChange(self,'TransmissionFailure','Transmission failure.');
      end;
    end;
  finally
    if Assigned(PollMessage) then FreeAndNil(PollMessage);
  end;
end;


procedure TUKElectronic.DeleteRequest;
var
  DeleteMessage:TDeleteRequest;
  PollInterval :integer;
  LastMessageSent:TDateTime;
begin
  if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
    PollInterval := BusObjGateway.PollInterval;
    LastMessageSent := BusObjGateway.LastMessageSent;
  end else begin
    PollInterval := BusObjGatewayTest.PollInterval;
    LastMessageSent := BusObjGatewayTest.LastMessageSent;
  end;

  while now < (LastMessageSent + (PollInterval/24/60/60)) do begin
    Sleep(200); 
    Application.ProcessMessages;
    if fbStop then exit;
  end;

  if Assigned(fOnMessageChange) then fOnMessageChange(self,'Status','Finalising...');

  DeleteMessage := TDeleteRequest.Create;
  try
    if DeclarationType = 'VAT' then
      DeleteMessage.DocumentClass := VAT_DECLARATION_CLASS
    else if DeclarationType = 'PAYE' then
      DeleteMessage.DocumentClass := ''; {  add others as required }

    if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
      DeleteMessage.CorrelationID := BusObjGateway.CorrelationID;
      DeleteMessage.TestValue     := '0';
      Client.IsLive := True;
      Client.XML := DeleteMessage.XML;

      SaveSentXMLToFile(Client.XML); //in case debugging needed
      BusObjGateway.LastMessageSent := Now;
      BusObjGateway.PostDb;
//      Client.URL := BusObjGateway.ResponseEndPoint;
      Client.URL := URL_LIVE;
      if Client.Send then begin
        BusObjGateway.CurrentSentType := 'SUBMISSION_DELETE';
        Response.XML := Client.Response;

        Response.ProcessResponse(BusObjGateway);
        TriggerEvents;

        SaveResponseXMLToFile(Response.XML); //in case debugging needed
        fInitialSessionReponseReceived := True;
        HandleResponse(Response.Reaction);
      end else begin
        fOnMessageChange(self,'TransmissionFailure','Transmission failure.');
      end;
    end else begin
      DeleteMessage.CorrelationID := BusObjGatewayTest.CorrelationID;
      DeleteMessage.TestValue     := '1';
      Client.IsLive := False;
      Client.XML := DeleteMessage.XML;

      SaveSentXMLToFile(Client.XML); //in case debugging needed
      BusObjGatewayTest.LastMessageSent := Now;
      BusObjGatewayTest.PostDb;
     // Client.URL := BusObjGateway.ResponseEndPoint;
      Client.URL := URL_TEST;
      if Client.Send then begin
        BusObjGatewayTest.CurrentSentType := 'SUBMISSION_DELETE';
        Response.XML := Client.Response;

        Response.ProcessResponse(BusObjGatewayTest);
        TriggerEvents;

        SaveResponseXMLToFile(Response.XML); //in case debugging needed
        fInitialSessionReponseReceived := True;
        HandleResponse(Response.Reaction);
      end else begin
        fOnMessageChange(self,'TransmissionFailure','Transmission failure.');
      end;
    end;
  finally
    if Assigned(DeleteMessage) then FreeAndNil(DeleteMessage);
  end;
end;

procedure TUKElectronic.HandleResponse(const Reaction:string);
begin
  BusObjGateway.RefreshDB;
  if Reaction = 'Submit' then begin
    if Assigned(fOnMessageChange) then fOnMessageChange(self,'','Submit');
    Submit;
  end else if Reaction = 'Poll' then begin
    if Assigned(fOnMessageChange) then fOnMessageChange(self,'','Poll');
    Poll;
  end else if Reaction = 'Stop' then begin
    if Assigned(fOnMessageChange) then fOnMessageChange(self,'','Stop');
    if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
      Self.BusObjGateway.CurrentResponseType := 'SUBMISSION_ERROR';
      Self.BusObjGateway.PostDb;
    end else begin
      Self.BusObjGatewayTest.CurrentResponseType := 'SUBMISSION_ERROR';
      Self.BusObjGatewayTest.PostDb;
    end;
  end else if Reaction = 'AnalyseBody' then begin
    if AnalyseBody = 'OK' then begin
      if Assigned(fOnMessageChange) then fOnMessageChange(self,'','Delete');
      DeleteRequest;
    end else if AnalyseBody = 'Errors' then begin

    end;
  end else if Reaction = 'Finalise' then begin
    if Assigned(fOnMessageChange) then fOnMessageChange(self,'','Finalise');
    Finalise;
  end else if Reaction = 'HandleBodyError' then begin
    if Assigned(fOnMessageChange) then fOnMessageChange(self,'','HandleBodyErrors');
    if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
      Self.BusObjGateway.CurrentResponseType := 'SUBMISSION_ERROR';
      Self.BusObjGateway.PostDb;
    end else begin
      Self.BusObjGatewayTest.CurrentResponseType := 'SUBMISSION_ERROR';
      Self.BusObjGatewayTest.PostDb;
    end;
    HandleBodyErrors;
  end else if Reaction = 'DataReceived' then begin
    if Assigned(fOnMessageChange) then fOnMessageChange(self,'','DataReceived');
    LoadListReceived;
  end else if Reaction = 'RequestData' then begin
    if Assigned(fOnMessageChange) then fOnMessageChange(self,'','RequestData');
    SendDataRequest;
  end else if Reaction = 'DataSubmitError' then begin
    if Assigned(fOnMessageChange) then fOnMessageChange(self,'','DataSubmitError');
    HandleListErrors;
  end else if Reaction = 'manyAttempts' then begin
    if Assigned(fOnMessageChange) then fOnMessageChange(self,'','manyAttempts');
    HandleManyAttempts;
  end else if Reaction = 'Delete' then begin
    DeleteRequest;
  end;
end;


function TUKElectronic.AnalyseBody:string;
begin
  Result := 'OK';
//  stub
end;

procedure  TUKElectronic.HandleListErrors;
begin
   LoadListReceived;
end;

procedure  TUKElectronic.HandleBodyErrors;
var
  i:integer;
begin
  for i := 0 to (Response.ErrorList.Count - 1) do
  begin
    if Assigned(fOnMessageChange) then fOnMessageChange(self,'errorlist',Response.ErrorList.Strings[i]);
  end;    
end;

procedure  TUKElectronic.LoadListReceived;
var
  Parser                :TXmlParser;
  bStatusRecFound       :Boolean;
  Rec                   :TRec;
  sTempDocClass         :string;
  sTempCorrelationID    :string;
  tmpPollInterval       :integer;
  tmpResponseEndPoint   :string;
begin
  Parser := TXmlParser.Create;
  Parser.Normalize := True;
  Parser.LoadFromBuffer(pAnsiChar(AnsiString(Response.XML)));
  Parser.StartScan;
  try
    while fRecList.Count > 0 do begin
      TRec(fRecList[0]).Free;
      fRecList.Delete(0);
    end;
    Rec := nil;
    bStatusRecFound := False;
    tmpPollInterval := 10;
    while Parser.Scan do
        case Parser.CurPartType of
          ptEmptyTag : begin end;
          ptStartTag:
              begin
                if Parser.CurName = 'StatusRecord' then begin
                  bStatusRecFound := True;
                end;
                if Parser.CurName = 'ResponseEndPoint' then begin
                  tmpPollInterval := StrToInt(string(Parser.CurAttr.Value(0)));
                end;
              end;
          ptContent,
          ptCData    : // Process Parser.CurContent field here
              begin
                if Parser.CurName = 'Class' then sTempDocClass := string(Parser.CurContent);
                if Parser.CurName = 'ResponseEndPoint' then tmpResponseEndPoint := string(Parser.CurContent);

                if bStatusRecFound then begin
                  if Parser.CurName = 'CorrelationID' then begin
                    sTempCorrelationID := string(Parser.CurContent);
                    //add to list
                    Rec := TRec.Create;
                    if sTempDocClass = VAT_DECLARATION_CLASS then Rec.sDocType := 'VAT';
                    Rec.sCorrelationID := sTempCorrelationID;
                    Rec.sID := GetGenericKeyID(sTempCorrelationID);
                  end;
                  if Parser.CurName = 'Status' then begin
                    Rec.sState := string(Parser.CurContent);
                    Rec.sResponseEndPoint := tmpResponseEndPoint;
                    Rec.iPollInterval := tmpPollInterval;
                    fRecList.Add(Rec);
                  end;
                end
              end;
          ptEndTag   : // Process End-Tag here (Parser.CurName)
              begin

              end;
          ptPI       : // Process PI here (Parser.CurName is the target, Parser.CurContent)
              begin
              end;
      end;
  finally
    FreeAndNil(Parser);
  end;
end;

procedure  TUKElectronic.HandleManyAttempts;
begin
  //stub
end;

procedure  TUKElectronic.Finalise;
begin
   if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
     BusObjGateway.IsFinalised := True;
     BusObjGateway.PostDb;
   end else begin
     BusObjGatewayTest.IsFinalised := True;
     BusObjGatewayTest.PostDb;
   end;
end;

procedure TUKElectronic.ProcessGatewayList;
var
  i:integer;
  bSuccessFound:boolean;
begin
  bSuccessFound := False;
  if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
    for i := 0 to (Self.GatewayList.Count - 1) do begin
      if (TRec(Self.GatewayList[i]).sState = 'SUBMISSION_RESPONSE')
        and (TRec(Self.GatewayList[i]).sID <> '') then bSuccessFound := True;
      BusObjGateway.LoadSelect('CorrelationID = '  + QuotedStr(TRec(Self.GatewayList[i]).sCorrelationID));
      if BusObjGateway.Dataset.RecordCount > 0 then begin
        Self.BusObjGateway.CurrentResponseType := TRec(Self.GatewayList[i]).sState;
        Self.BusObjGateway.ResponseEndPoint := TRec(Self.GatewayList[i]).sResponseEndPoint;
        Self.BusObjGateway.PollInterval := TRec(Self.GatewayList[i]).iPollInterval; 
        Self.BusObjGateway.PostDb;
      end;
    end;
      //Reload the bus obj back to the Key Declaration
    BusObjGateway.LoadSelect('GenericKeyID = ' + IntToStr(GenericKeyID) + ' AND DeclarationType = ' + QuotedStr(DeclarationType));
  end else begin
    for i := 0 to (Self.GatewayList.Count - 1) do begin
      if (TRec(Self.GatewayList[i]).sState = 'SUBMISSION_RESPONSE')
        and (TRec(Self.GatewayList[i]).sID <> '') then bSuccessFound := True;

      BusObjGatewayTest.LoadSelect('CorrelationID = '  + QuotedStr(TRec(Self.GatewayList[i]).sCorrelationID));
      if BusObjGatewayTest.Dataset.RecordCount > 0 then begin
        Self.BusObjGatewayTest.CurrentResponseType := TRec(Self.GatewayList[i]).sState;
        Self.BusObjGatewayTest.ResponseEndPoint := TRec(Self.GatewayList[i]).sResponseEndPoint;
        Self.BusObjGatewayTest.PollInterval := TRec(Self.GatewayList[i]).iPollInterval;
        Self.BusObjGatewayTest.PostDb;
      end;
    end;
      //Reload the bus obj back to the Key Declaration
    BusObjGatewayTest.LoadSelect('GenericKeyID = ' + IntToStr(GenericKeyID) + ' AND DeclarationType = ' + QuotedStr(DeclarationType));
  end;
  if bSuccessFound then fOnMessageChange(self,'SuccessFound','Successful submissions found. Do you want to finalise?');
end;


procedure TUKElectronic.FinaliseList;
var
  i:integer;
begin
  for i := 0 to (Self.GatewayList.Count - 1) do
  begin
    if TRec(Self.GatewayList[i]).sState = 'SUBMISSION_RESPONSE' then begin
      DeleteRequest(TRec(Self.GatewayList[i]).sCorrelationID,TRec(Self.GatewayList[i]).sDocType);
    end;
          //delete any unassociated submissions ; rem this out later
  //  if TRec(Self.GatewayList[i]).sID = '' then DeleteRequest(TRec(Self.GatewayList[i]).sCorrelationID,TRec(Self.GatewayList[i]).sDocType);
  end;
end;

procedure TUKElectronic.DeleteRequest(const sCorrelationID:string; const sDeclarationType:string);
var
  DeleteMessage:TDeleteRequest;
begin
  if Assigned(fOnMessageChange) then fOnMessageChange(self,'Status','Finalising...');

  if AppEnv.CompanyPrefs.UKGatewayIsLive then BusObjGateway.LoadSelect('CorrelationID = ' + QuotedStr(sCorrelationID))
  else BusObjGatewayTest.LoadSelect('CorrelationID = ' + QuotedStr(sCorrelationID));

  DeleteMessage := TDeleteRequest.Create;
  try
    if sDeclarationType = 'VAT' then
      DeleteMessage.DocumentClass := VAT_DECLARATION_CLASS
    else if sDeclarationType = 'PAYE' then
      DeleteMessage.DocumentClass := ''; {  add others as required }

    DeleteMessage.CorrelationID := sCorrelationID;
    if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
      DeleteMessage.TestValue := '0';
      Client.IsLive := True;
    end else begin
      DeleteMessage.TestValue := '1';
      Client.IsLive := False;
    end;

    Client.XML := DeleteMessage.XML;

    SaveSentXMLToFile(Client.XML); //in case debugging needed

    if AppEnv.CompanyPrefs.UKGatewayIsLive then begin
      BusObjGateway.LastMessageSent := Now;
      BusObjGateway.PostDb;
      Client.URL := BusObjGateway.ResponseEndPoint;
      if Client.Send then begin
        BusObjGateway.CurrentSentType := 'SUBMISSION_DELETE';
        BusObjGateway.PostDb;
        Response.XML := Client.Response;

        Response.ProcessResponse(BusObjGateway);
        TriggerEvents;

        SaveResponseXMLToFile(Response.XML); //in case debugging needed
        fInitialSessionReponseReceived := True;
        HandleResponse(Response.Reaction);
      end else begin
        fOnMessageChange(self,'TransmissionFailure','Transmission failure.');
      end;
    end else begin
      BusObjGatewayTest.LastMessageSent := Now;
      BusObjGatewayTest.PostDb;
      Client.URL := BusObjGateway.ResponseEndPoint;
      if Client.Send then begin
        BusObjGatewayTest.CurrentSentType := 'SUBMISSION_DELETE';
        BusObjGatewayTest.PostDb;
        Response.XML := Client.Response;

        Response.ProcessResponse(BusObjGatewayTest);
        TriggerEvents;

        SaveResponseXMLToFile(Response.XML); //in case debugging needed
        fInitialSessionReponseReceived := True;
        HandleResponse(Response.Reaction);
      end else begin
        fOnMessageChange(self,'TransmissionFailure','Transmission failure.');
      end;
    end;
  finally
    if Assigned(DeleteMessage) then FreeAndNil(DeleteMessage);
  end;
end;


function TUKElectronic.GetGenericKeyID(const CorrelationID:string):string;
var
  qry:TERPQuery;
begin
  Result := '';
  qry := TERPQuery.Create(nil);    
  try
    qry.Options.FlatBuffers := True;
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    with qry do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT GenericKeyID,CorrelationID FROM ');
      if AppEnv.CompanyPrefs.UKGatewayIsLive then SQL.Add('tblukgovgateway')
        else SQL.Add('tblukgovgatewaytest');
      SQL.Add(' WHERE CorrelationID = ' + QuotedStr(CorrelationID) + ';');
      Open;
      if not IsEmpty then begin
        Result := FieldByName('GenericKeyID').AsString;
      end
    end;
  finally
    FreeAndNil(qry);
  end;
end;

end.
