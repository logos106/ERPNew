unit FormEvents;

interface

type

  TFormEventType = (FEType_None, On_Enter, on_show, on_change, on_Exit, on_activate, on_KeyUP, on_KeyDown , on_MouseUP, On_click, on_Titleclick, On_CalcTitleImage  , On_BeforeOpenList, on_Create , on_Paint, on_Destroy, on_Close, on_BeforeOpen, on_AfterOpen , on_Dblclick);
  TFormEventTime = (FETime_None, On_After , On_Before);

  PEventRec = ^TFormEventRec;
  TFormEventRec = record
    EventType: TFormEventType;
    Name: string;
    Code, Data: Pointer;
  end;

function  FormEventTypetoStr(Const EventType :TFormEventType):String;
function  FormEventTimetoStr(Const Eventtime :TFormEventTime):String;


implementation

function  FormEventTypetoStr(Const EventType :TFormEventType):String;
begin
        if Eventtype = On_Enter           then Result := 'On Enter'
   else if Eventtype = on_show            then Result := 'On show'
   else if Eventtype = on_change          then Result := 'On change'
   else if Eventtype = on_Exit            then Result := 'On Exit'
   else if Eventtype = on_activate        then Result := 'On Activate'
   else if Eventtype = on_KeyUP           then Result := 'On Key up'
   else if Eventtype = on_KeyDown         then Result := 'On Key down'
   else if Eventtype = on_MouseUP         then Result := 'On Mouse UP'
   else if Eventtype = On_click           then Result := 'On click'
   else if Eventtype = on_Titleclick      then Result := 'On Titleclick'
   else if Eventtype = On_CalcTitleImage  then Result := 'On Calc title image'
   else if Eventtype = On_BeforeOpenList  then Result := 'On Before Open List'
   else if Eventtype = on_Create          then Result := 'On Create'
   else if Eventtype = on_Paint           then Result := 'On Paint'
   else if Eventtype = on_Destroy         then Result := 'On Destroy'
   else if Eventtype = on_Close           then Result := 'On Close'
   else if Eventtype = on_BeforeOpen      then Result := 'On BeforeOpen'
   else if Eventtype = on_AfterOpen       then Result := 'On AfterOpen'
   else Result := '';
end;
function  FormEventTimetoStr(Const Eventtime :TFormEventTime):String;
begin
       if Eventtime =  On_After then result := 'On After'
  else if Eventtime =  On_Before then result := 'On Before'
  else Result := '';
end;
end.
