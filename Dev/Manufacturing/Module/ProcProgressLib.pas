unit ProcProgressLib;

interface

type

  tDoneQtytype = (dqtOk = 1,  dqtWastage =2, dqtHold=3, dqtBuilding =4, dqtNone=5);


function DoneQtytypeToStr(Const Value :tDoneQtytype):String;
function StrToDoneQtytype(Const Value :String):tDoneQtytype;

implementation

function StrToDoneQtytype(Const Value :String):tDoneQtytype;
begin
       if Value = 'D' then result := dqtOk
  else if value = 'W' then result := dqtWastage
  else if value = 'H' then result := dqtHold
  else if value = 'B' then result := dqtBuilding
  else result := dqtNone;
end;
function DoneQtytypeToStr(Const Value :tDoneQtytype):String;
begin
       if Value = dqtOk       then result := 'D'
  else if value = dqtWastage  then result := 'W'
  else if value = dqtHold     then result := 'H'
  else if value = dqtBuilding then result := 'B'
  else result := '';
end;



end.
