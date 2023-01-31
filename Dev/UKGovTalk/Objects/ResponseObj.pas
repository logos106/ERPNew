unit ResponseObj;

interface
uses      
  BusObjBase,Classes;

type
  TResponseObj = class(TObject)
  private
    fXML                        :string;
    fReaction                   :string;
    fResponseClass              :string;
    fResponseQualifier          :string;
    fResponseFunction           :string;
    fResponseCorrelationID      :string;
    fResponsePollInterval       :string;
    fResponseEndPoint           :string;  
    fResponseErrorNumber        :string;
    fResponseErrorType          :string;
    fResponseErrorMsg           :string; 
    fResponseErrorLocation      :string;
    fResponseStatus             :string;
    fErrorList                  :TStringList;
    function HasRequiredData:boolean;   
  public
    constructor Create;
    Destructor  Destroy;  override;
    property XML :string read fXML write fXML;    
    property Reaction:string read fReaction;
    procedure ProcessResponse(BusObjGateway: TMSBusObj);
    property ResponseErrorMsg           :string read fResponseErrorMsg;
    property ResponseErrorType          :string read fResponseErrorType;
    property ResponseErrorNumber        :string read fResponseErrorNumber; 
    property ResponseErrorLocation      :string read fResponseErrorLocation;
    property ErrorList                  :TStringList read fErrorList write fErrorList;
  end;

implementation
uses
  LibXMLParser,SysUtils,AppEnvironment,BusObjUKGovGateway;

constructor TResponseObj.Create;
begin
  inherited;
  fErrorList := TStringList.Create; 
end;

Destructor TResponseObj.Destroy;
begin
  FreeAndNil(fErrorList);
  inherited;
end;

function TResponseObj.HasRequiredData:boolean;
begin
  Result := True;
  if fXML = '' then Result := False;
end;

procedure TResponseObj.ProcessResponse(BusObjGateway:TMSBusObj);
var
  Parser :TXmlParser;
  bBodyFound:boolean;
begin
  if not HasRequiredData then begin

    exit;
  end;
  fResponseQualifier := '';
  fResponseFunction  := '';
  fResponseStatus    := '';
  
  Parser := TXmlParser.Create;
  Parser.Normalize := True;
  Parser.LoadFromBuffer(pAnsiChar(AnsiString(fXML)));
  bBodyFound := False;
  Parser.StartScan;
  try
    while Parser.Scan do
        case Parser.CurPartType of          // Here the parser tells you what it has found
          ptEmptyTag : begin end;
          ptStartTag:  // Process Parser.CurName and Parser.CurAttr
              begin
                if Parser.CurName = 'ResponseEndPoint' then begin
                  fResponsePollInterval := string(Parser.CurAttr.Value(0));
                end;
                if Parser.CurName = 'Body' then begin
                  bBodyFound := True;
                end;
              end;
          ptContent,
          ptCData    : // Process Parser.CurContent field here
              begin
                if Parser.CurName = 'Qualifier' then fResponseQualifier := string(Parser.CurContent)
                else if Parser.CurName = 'Function' then fResponseFunction := string(Parser.CurContent)
                else if Parser.CurName = 'CorrelationID' then fResponseCorrelationID := string(Parser.CurContent)
                else if Parser.CurName = 'ResponseEndPoint' then fResponseEndPoint := string(Parser.CurContent)
                else if Parser.CurName = 'class' then fResponseClass := string(Parser.CurContent)
             //   else if Parser.CurName = 'GatewayTimestamp' then fResponseGatewayTimestamp := DateTimeToMysqlDateStr(Now)//Parser.CurContent
                else if Parser.CurName = 'Number' then fResponseErrorNumber := string(Parser.CurContent)
                else if Parser.CurName = 'Type' then fResponseErrorType := string(Parser.CurContent)
                else if Parser.CurName = 'Text' then fResponseErrorMsg := string(Parser.CurContent)
                else if Parser.CurName = 'Location' then fResponseErrorLocation := string(Parser.CurContent)
                else if Parser.CurName = 'Status' then fResponseStatus := string(Parser.CurContent);

                if bBodyFound then begin
                  if Parser.CurName = 'err:Text' then begin
                    ErrorList.Add(string(Parser.CurContent));
                  end;
                end;
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

  //Write results to backend and set Reaction
  if (fResponseQualifier = 'acknowledgement') and (fResponseFunction = 'submit') then begin
    Tukgovgateway(BusObjGateway).CurrentResponseType := 'SUBMISSION_ACKNOWLEDGE';
    fReaction := 'Poll';
  end else if (fResponseQualifier = 'error') and (fResponseFunction = 'submit') then begin
    Tukgovgateway(BusObjGateway).CurrentResponseType := 'SUBMISSION_ERROR';
    if fResponseErrorType = 'fatal' then fReaction := 'Stop'
    else if fResponseErrorType = 'business' then fReaction := 'HandleBodyError'
    else if fResponseErrorType = 'recoverable' then begin
      if Tukgovgateway(BusObjGateway).CurrentSentType = 'SUBMISSION_REQUEST' then fReaction := 'Submit'
      else if Tukgovgateway(BusObjGateway).CurrentSentType = 'SUBMISSION_POLL' then fReaction := 'Poll';
    end;  
  end else if (fResponseQualifier = 'response') and (fResponseFunction = 'submit') then begin
    Tukgovgateway(BusObjGateway).CurrentResponseType := 'SUBMISSION_RESPONSE';
    fReaction := 'AnalyseBody'//'Delete';
  end else if (fResponseQualifier = 'response') and (fResponseFunction = 'delete') then begin
    Tukgovgateway(BusObjGateway).CurrentResponseType := 'DELETE_RESPONSE';
    fReaction := 'Finalise';
  end else if (fResponseQualifier = 'acknowledgement') and (fResponseFunction = 'delete') then begin
    Tukgovgateway(BusObjGateway).CurrentResponseType := 'DELETE_ACKNOWLEDGE';
    fReaction := 'Delete';
  end else if (fResponseQualifier = 'response') and (fResponseFunction = 'list') then begin
   // BusObjGateway.CurrentResponseType := 'DATA_RESPONSE';
    if fResponseStatus = 'SUBMISSION_ERROR' then begin
      fReaction := 'DataSubmitError';
    end else if fResponseStatus = 'SUBMISSION_RESPONSE' then begin
      fReaction := 'DataReceived';
    end else if fResponseStatus = 'SUBMISSION_ACKNOWLEDGEMENT' then begin
      fReaction := 'RequestData';
    end;
  end;

  if Tukgovgateway(BusObjGateway).CorrelationID = '' then Tukgovgateway(BusObjGateway).CorrelationID := fResponseCorrelationID;
  if fResponsePollInterval <> '' then  Tukgovgateway(BusObjGateway).PollInterval := StrToInt(fResponsePollInterval);
  Tukgovgateway(BusObjGateway).NoOfAttempts := Tukgovgateway(BusObjGateway).NoOfAttempts + 1;

  if Tukgovgateway(BusObjGateway).NoOfAttempts > AppEnv.CompanyPrefs.VATMaxAttemptsPerSession then fReaction := 'manyAttempts';
  Tukgovgateway(BusObjGateway).LastMessageRecieved := (Now);
  Tukgovgateway(BusObjGateway).ResponseEndPoint :=  fResponseEndPoint;
  Tukgovgateway(BusObjGateway).ResponseClass := fResponseClass;

  Tukgovgateway(BusObjGateway).ErrorMessage := fResponseErrorMsg;
  Tukgovgateway(BusObjGateway).ErrorType    := fResponseErrorType;
  Tukgovgateway(BusObjGateway).ErrorNumber  := fResponseErrorNumber;

  Tukgovgateway(BusObjGateway).PostDb;
end;



end.
