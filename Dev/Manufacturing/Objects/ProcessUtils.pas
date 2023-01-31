unit ProcessUtils;

interface
const
    PS_NOTSCHEDULED     = 'psNotScheduled';       PS_STR_NOTSCHEDULED     = 'Not Sched';            PS_INT_NOTSCHEDULED     = 1;
    PS_SCHEDULED        = 'psScheduled';          PS_STR_SCHEDULED        = 'Scheduled';            PS_INT_SCHEDULED        = 2;
    PS_STARTED          = 'psStarted';            PS_STR_STARTED          = 'Started';              PS_INT_STARTED          = 3;
    PS_COMPLETE         = 'psComplete';           PS_STR_COMPLETE         = 'Complete';             PS_INT_COMPLETE         = 6;
    PS_COMPLETENINVOICE = 'psCompletenInvoice';   PS_STR_COMPLETENINVOICE = 'Completed n Invoiced'; PS_INT_COMPLETENINVOICE = 7;
    PS_STOPPED          = 'psStopped';            PS_STR_STOPPED          = 'Stoped';               PS_INT_STOPPED          = 4;
    PS_QUALITYASSURANCE = 'psQualityAssurance';   PS_STR_QualityAssurance = 'Q A';                  PS_INT_QUALITYASSURANCE = 5;
    PS_UNKNOWN          = 'psUnknown';            PS_STR_UNKNOWN          = 'Un-known';             PS_INT_UNKNOWN          = 0;












type
  TProcessPartStatus = (psNotScheduled, psScheduled, psStarted, psComplete, psStoped,psUnknown,psQualityAssurance);
  TProcessPartStatusNo = (psnUnknown=0, psnNotScheduled=1, psnScheduled=2, psnStarted=3,psnStoped=4, psnQualityAssurance=5, psnComplete=6 );

  TProcessPartStatusList = set of TProcessPartStatus;

  function ProcTimeToStr(time: double; blankwhen0:boolean =False): string;
  function StrToProcTime(str: string): double;
  function ProcessPartStatusToStr(const ProcessPartStatus: TProcessPartStatus): string;
  function ProcessPartStatusIntToStr(const ProcessPartStatus: Integer): string;
  function ProcessPartStatusToUserStr(const ProcessPartStatus: TProcessPartStatus): string;
  function StrToProcessPartStatus(const Value: string): TProcessPartStatus;
  function ProcessPartStatusListToStatus(aStatusList: TProcessPartStatusList): TProcessPartStatus;


implementation

uses
  sysutils, classes, DNMLib, AppEnvironment, dateutils ;

function ProcessPartStatusIntToStr(const ProcessPartStatus: Integer): string;
begin
  case ProcessPartStatus of
    PS_INT_NotScheduled  : result:= PS_STR_NOTSCHEDULED;
    PS_INT_Scheduled     : result:= PS_STR_SCHEDULED;
    PS_INT_Started       : result:= PS_STR_STARTED;
    PS_INT_Complete      : result:= PS_STR_COMPLETE;
    PS_INT_STOPPED        : result:= PS_STR_Stopped;
    PS_INT_Unknown       : result:= PS_STR_Unknown;
    PS_INT_QualityAssurance  : result := PS_STR_QUALITYASSURANCE;
    else  result := '';
  end;
end;

function ProcessPartStatusToStr(const ProcessPartStatus: TProcessPartStatus): string;
begin
  case ProcessPartStatus of
    psNotScheduled  : result:= PS_NOTSCHEDULED;
    psScheduled     : result:= PS_SCHEDULED;
    psStarted       : result:= PS_STARTED;
    psComplete      : result:= PS_COMPLETE;
    psStoped        : result:= ps_Stopped;
    psUnknown       : result:= ps_Unknown;
    psQualityAssurance  : result := PS_QUALITYASSURANCE;
    else  raise Exception.Create('ProcessPartStatusToStr - Invalid ProcessPartStatus');
  end;
end;

function ProcessPartStatusToUserStr(const ProcessPartStatus: TProcessPartStatus): string;
begin
  case ProcessPartStatus of
    psNotScheduled: result:= PS_STR_NOTSCHEDULED;
    psQualityAssurance: result := PS_STR_QualityAssurance;
    psScheduled: result:= PS_STR_SCHEDULED;
    psStarted: result:= PS_STR_STARTED;
    psComplete: result:= PS_STR_COMPLETE;
    psStoped: result:= PS_STR_STOPPED;
    psUnknown: result:= PS_STR_UNKNOWN;
    else  raise Exception.Create('ProcessPartStatusToUserStr - Invalid ProcessPartStatus');
  end;
end;

function StrToProcessPartStatus(const Value: string): TProcessPartStatus;
begin
       if Value = PS_NOTSCHEDULED then result:= psNotScheduled
  else if Value = PS_QUALITYASSURANCE then result := psQualityAssurance
  else if Value = PS_SCHEDULED    then result:= psScheduled
  else if Value = PS_STARTED      then result:= psStarted
  else if Value = PS_COMPLETE     then result:= psComplete
  else if Value = PS_STOPPED      then result:= psstoped
  else if Value = PS_UNKNOWN      then result:= psUnknown
  else  raise Exception.Create('StrToProcessPartStatus - Invalid Value: "' + VAlue + '"');
end;

function ProcessPartStatusListToStatus(aStatusList: TProcessPartStatusList): TProcessPartStatus;
begin
  if [psComplete] = aStatusList then result:= psComplete
  else if [psNotScheduled] = aStatusList then result:= psNotScheduled
  else if [psQualityAssurance] = aStatusList then result := psQualityAssurance
  else if (psScheduled in aStatusList) and (not (psStarted in aStatusList)) then result:= psScheduled
  else if (psStarted in aStatusList) then result:= psStarted
  else result:= psNotScheduled;
end;

function ProcTimeToStr(time: double; blankwhen0:boolean =False): string;
var
  h,m, s:Integer;
  hrStr, minStr, secstr: string;
begin
  REsult := '';
  if (blankwhen0) and (time=0) then exit;

  h:= (*trunc(Abs(time))*) trunc(abs(time)/60/60);
  m:=(*trunc(Abs((time-h)*60))*)trunc(Abs((time-(h*60*60))/60));
  s:=(*round((((time-h)*60)-m)*60)*) round((time-(h*60*60))-(m*60));
  hrStr := IntToStr(h); while Length(hrStr)  < 2 do hrStr:= '0' + hrStr;
  minStr:= IntToStr(m); while Length(minStr) < 2 do minStr:= '0' + minStr;
  SecStr:= IntToStr(s); while Length(SecStr) < 2 do SecStr:= '0' + SecStr;
  result:= hrStr + ':' + minStr+ ':' + SecStr;
  if time < 0 then result:= '-' + result;
end;
(*var
  mins, h, m: integer;
  hrStr, minStr: string;
begin
  mins:= Round(Abs(time) * 60);
  h:= Trunc(mins/60);
  hrStr:= IntToStr(h);
  while Length(hrStr) < 2 do
    hrStr:= '0' + hrStr;
  m:= mins - (h * 60);
  minStr:= IntToStr(m);
  while Length(minStr) < 2 do
    minStr:= '0' + minStr;
  result:= hrStr + ':' + minStr;
  if time < 0 then
    result:= '-' + result;
end;*)

function StrToProcTime(str: string): double;
var
(*  sepPos: integer;*)
  s: string;
  IsNeg: boolean;
  lsts:TStringlist;
  ctr:Integer;
begin
  if Pos('-',str) > 0 then begin
    IsNeg:= true;
    s:= Copy(str,2,Length(str));
  end
  else begin
    IsNeg:= false;
    s:= str;
  end;

(*  sepPos:= Pos(':',s);
  if sepPos > 0 then begin
    result:= (StrToFloatDef(Copy(s,1,sepPos-1),0)) +
      (StrToFloatDef(Copy(s,sepPos+1,2),0) / 60);
  end
  else begin
    result:= StrToFloatDef(s,0) / 60;
  end;*)
  lsts :=  TStringlist.Create;
  try
    SplitString(s , ':' , lsts);
    Result := 0;
    for ctr := 0 to lsts.count-1 do begin
      (*if (ctr =0) and (lsts[ctr] <> '') then Result :=strtoint(lsts[ctr])
      else if (ctr =1) and (lsts[ctr] <> '')  then result := result +strtoint(lsts[ctr])/60
      else if (ctr =2) and (lsts[ctr] <> '')  then result := result +strtoint(lsts[ctr])/(60*60);*)
      if isInteger(lsts[ctr]) then
             if (ctr =0) and (lsts[ctr] <> '') then Result :=strtoint(lsts[ctr])*60*60
        else if (ctr =1) and (lsts[ctr] <> '')  then result := result +strtoint(lsts[ctr])*60
        else if (ctr =2) and (lsts[ctr] <> '')  then result := result +strtoint(lsts[ctr]);
    end;
  finally
    FreeAndNil(lsts);
  end;
  if IsNeg then
    result:= result * -1;
end;


end.
