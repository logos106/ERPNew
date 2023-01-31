unit utAPIBaseObj;

interface

uses LogThreadBase, LogMessageTypes,JSONObject;

type
  TAPIBaseObj = class(TObject)
  private
  Protected
    fiTaskRecID :Integer;
    fOutJson: TJsonObject;
    fbCompleteProcess:Boolean;
    fbVS1_NewRegoCompleteProcess:Boolean;
    fiThreadProgresscount :Integer;
    fLogger: TLoggerBase;
    Procedure DoEvent(Const Eventtype, EventValue:String; WriteToOutjson:boolean = False;objname:String ='');
    function ThreadRunning: Boolean;
  Public
    Constructor Create;Virtual;
    Destructor Destroy;Override;
    Property TaskRecID :Integer read fiTaskRecID write fiTaskRecID;
  Published
  end;

implementation

uses SysUtils, utVS1Const, utCloudconst, CommonLib;

constructor TAPIBaseObj.Create;
begin
  fOutJson := JO;//fOutJson := nil;
  fbCompleteProcess:= False;
  fbVS1_NewRegoCompleteProcess:= False;
end;

destructor TAPIBaseObj.Destroy;
begin
  fOutJson.free;
  inherited;
end;

procedure TAPIBaseObj.DoEvent(Const Eventtype, EventValue:String; WriteToOutjson:boolean = False;objname:String ='');
begin
  if SameText(Eventtype, 'ThreadEvent') and
      SameText(EventValue, 'Oncomplete') then
        fbCompleteProcess := True
  else if SameText(Eventtype, 'ThreadEvent') and
      SameText(EventValue, 'OnVS1_NewRegocomplete') then
        fbVS1_NewRegoCompleteProcess := True
  else if fOutJson <> nil then begin
    if WriteToOutjson then begin
      if SameText(Eventtype, TAG_Obj)  then begin
        if objname ='' then objname := TAG_Obj;
        //fOutJson.O[objname].asString := EventValue;
        fOutJson.O[objname] := jo(EventValue);
        //fOutJson.O[objname].I['TaskRecID'] :=TaskRecID;
      end else if not sametext(Eventtype, TAG_ResponseNo)  then begin
        fOutJson.S[Eventtype] := EventValue;
          //fOutJson.I['TaskRecID'] :=TaskRecID;
      end else begin
             if SameText(EventValue,VS1_HTTP_Success_STRCode) then fOutJson.I[TAG_ResponseNo] := VS1_HTTP_Success_Code
        //else if sametext(EventValue,'201') then fOutJson.I[TAG_ResponseNo] := 201
        else if SameText(EventValue,'400') then fOutJson.I[TAG_ResponseNo] := 400
        else if SameText(EventValue,VS1_HTTP_Failed_STRCode) then fOutJson.I[TAG_ResponseNo] := VS1_HTTP_Failed_Code
        //else if sametext(EventValue,'402') then fOutJson.I[TAG_ResponseNo] := 402
        else if SameText(EventValue,'404') then fOutJson.I[TAG_ResponseNo] := VS1_HTTP_DupicateErr_Code
        else if IsInteger(EventValue)      then fOutJson.I[TAG_ResponseNo] := StrToInt(EventValue)
        else fOutJson.S[Eventtype] := EventValue;
        //fOutJson.I['TaskRecID'] :=TaskRecID;
      end;
    end;
  end;

  try fLogger.Log(IntToStr(TaskRecID) + ':' + EventValue, ltInfo); except end;

end;

Function TAPIBaseObj.ThreadRunning:Boolean;
begin
  Result := true;
  if not (fbCompleteProcess) and not (fbVS1_NewRegoCompleteProcess ) then begin
    sleep(1000);
    fiThreadProgresscount := fiThreadProgresscount +1;
  end else Result := False;
end;
end.
