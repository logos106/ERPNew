unit BusObjProcessForScheduling;

interface

Uses BusObjProcess , BusObjProcessPartNDS , BusObjNDSBase , BusObjProcessTimeNDS;

type



 TProcessPartForSchedulingNDS = class(TProcessPartNDS)
   Private
   Protected
   Public
    function BuiltQtyasOnDate (aProcitem : TProcTreeNode; fdRequiredQty:Double;  var aAsOnDate:TdateTime;  Bookit:Boolean):Double;
    function Logstring: String;
 end;


  TProcTreeNodeForScheduling = class( TProcTreeNode)
  Private
    function getCommatext: String;
    Function AddNewScheduledQty(const fiProcessPartID:Integer; Const FdDate :TDatetime; fdQty:Double):Boolean;Overload;
  Protected
    function MakeProcesStepList: TProcessStepList;Override;
  Public
    Function AddNewScheduledQty(const fiProctreeId:Integer;const fiProcessPartID:Integer; Const FdDate :TDatetime; fdQty:Double):Boolean;Overload;
    Property Commatext:String read getCommatext;
    Procedure LogTreeWithProcessnBuiltQty(treelevel :Integer=0);
    function FindNodeForID(aProctreeId :Integer): TProcTreeNodeForScheduling;
    function findProcessPart(aprocessPartID:Integer):TProcessPartNDS;
    function IsOkToBuild(SelectedProcess :TProcessPartNDS;  fdQty :Double;  var adt:TDateTime; Bookit:Boolean):Boolean;
  end;

implementation

uses SysUtils, tcConst, CommonLib,  dateutils, LogLib, ProductQtyLib,
  tcDataUtils;


function TProcTreeNodeForScheduling.findProcessPart(aprocessPartID:Integer):TProcessPartNDS;
var
  x:Integer;
begin
  result:=nil;
  for x:= 0 to ProcessStepList.Count -1 do begin
    if ProcessStepList[x].Id = aprocessPartID then begin
      result := ProcessStepList[x];
      exit;
    end;
  end;
end;

function TProcTreeNodeForScheduling.IsOkToBuild(SelectedProcess :TProcessPartNDS;  fdQty :Double;  var adt:TDateTime; Bookit:Boolean):Boolean;
var
  x:Integer;
  fdflag:Boolean;
  aQty:Double;
  fifirstProcessSeq:Integer;
begin

  result:= False;
  if ManufactureUOMQty =0 then begin
    Result := True;
    Exit;
  end;

  {check for a process step with a duration. Id there is no process step with a duration, its ready to build}
    fdFlag:=False;
    if Self.ProcessStepList.count >0 then
      for x:= 0 to Self.ProcessStepList.count-1 do
        if  (Self.ProcessStepList[x].duration=0) and
            (Self.ProcessStepList[x].setupduration=0) and
            (Self.ProcessStepList[x].breakdownduration=0) then else begin
              fdFlag := true;
              break;
            end;
    if fdFlag=false then begin
      Result := true;
      Exit;
    end;


  if SelectedProcess <> nil then begin
    fdflag := False;
    {all process steps of the same node but below}
    aQty :=0;

    {first Process Seq no}
    fifirstProcessSeq:=ProcessStepList[0].ProcessStepSeq;
    for x:=  ProcessStepList.Count -1 downto 0    do
      if fifirstProcessSeq> ProcessStepList[x].ProcessStepSeq then
        fifirstProcessSeq := ProcessStepList[x].ProcessStepSeq;

    for x:=  ProcessStepList.Count -1 downto 0    do begin
      if (ProcessStepList[x].ID = SelectedProcess.ID)  then begin
        fdflag := True;
        break;
      end else if fdflag  then begin
        //if ProcessStepList[x].ProcessStepSeq < SelectedProcess.ProcessStepSeq then begin
        if ProcessStepList[x].ProcessStepSeq = fifirstProcessSeq then begin
          aQty:= TProcessPartForSchedulingNDS(ProcessStepList.Item[x]).BuiltQtyasOnDate (self, fdQty ,  adt , Bookit);
          if (aQty =0 ) or ( fdQty > aQty) then Exit // not available to build
          else break; // check only for the immediate next
        end;
      end;
    end;

    if not fdflag then   exit // process step not found
    else if  ProcessStepList[x].ProcessStepSeq <> fifirstProcessSeq then begin // its not the first process step of the node, so is ok to do
      REsult := TRue;
      Exit;
    end else if fdQty <= aQty then begin
      REsult := TRue;
      Exit;
    end;

    if (Children.count =0)  then begin
      REsult := True;
      Exit;
    end;

    {when its the first process step.. check the subnodes}
    for x:= 0 to Children.Count -1 do begin
        result:= TProcTreeNodeForScheduling(Children[x]).IsOkToBuild(nil ,fdQty*TProcTreeNodeForScheduling(Children[x]).Quantity ,adt, Bookit);
        if not(result) then Exit;
    end;
    (*// the first process step, so item[0]
    aQty:= TProcessPartForSchedulingNDS(ProcessStepList.Item[0]).BuiltQtyasOnDate (fdQty ,  adt , Bookit);*)
  end else begin
    if ProcessStepList.Count =0 then result := True
    else begin

   (* fifirstProcessSeq:=ProcessStepList[0].ProcessStepSeq;
    for x:=  ProcessStepList.Count -1 downto 0    do
      if fifirstProcessSeq> ProcessStepList[x].ProcessStepSeq then
        fifirstProcessSeq := ProcessStepList[x].ProcessStepSeq;*)


      for x:=  ProcessStepList.Count -1 downto 0    do begin
        //if fifirstProcessSeq = ProcessStepList[x].ProcessStepSeq then begin
          aQty:= TProcessPartForSchedulingNDS(ProcessStepList.Item[x]).BuiltQtyasOnDate (self, fdQty ,  adt , Bookit);
          if (aQty =0 ) or ( fdQty > aQty) then Exit;// not available to build
        //end;
      end;
      REsult := TRue;
    end;
  end;
end;

procedure TProcTreeNodeForScheduling.LogTreeWithProcessnBuiltQty(treelevel :Integer=0);
var
  x1, x2:Integer;
begin
  logtext(ReplicateStr('   ' , treelevel)+ Caption);
  for x1 := 0 to ProcessStepList.Count -1 do begin
    logtext(ReplicateStr('   ' , treelevel+1)+ ProcessStepList.item[x1].ProcessStepDescription + ',' + SecondsToTime(trunc(ProcessStepList.item[x1].Duration))+',' + floattostr(TotalQty)+ ',' + SecondsToTime(trunc(ProcessStepList.item[x1].Duration*TotalQty)));
    for x2 := 0 to ProcessStepList.item[x1].Processpartqtylist.count-1 do begin
      logtext(ReplicateStr('   ' , treelevel+2)+ formatDateTime('dd-mm-yy hh:nn:ss' , ProcessStepList.item[x1].ProcessPartQtyList.item[x2].BuildDate) + ',' +
                                                  floattostr(ProcessStepList.item[x1].ProcessPartQtyList.item[x2].QtyScheduled)+ ',' +
                                                  floattostr(ProcessStepList.item[x1].ProcessPartQtyList.item[x2].QtyUsed) );

    end;
  end;
  if Children.Count>0 then
    for x1:= 0 to Children.Count -1 do
      TProcTreeNodeForScheduling(Children[x1]).LogTreeWithProcessnBuiltQty(treelevel +1);
end;

function TProcTreeNodeForScheduling.MakeProcesStepList: TProcessStepList;
begin
  REsult := inherited MakeProcesStepList;
end;

Function  TProcTreeNodeForScheduling.AddNewScheduledQty(const fiProcessPartID: Integer; const FdDate: TDatetime; fdQty: Double):Boolean;
var
  //x1,
  x2:Integer;
begin
      REsult := False;
      for x2:= 0 to ProcessStepList.Count -1 do begin
        if ProcessStepList[x2].ID = fiProcessPartID then begin
          with TProcessPartForSchedulingNDS(ProcessStepList[x2]).ProcessPartQtyList.AddProcessPartQty do begin
              ProcessPartID := fiProcessPartID;
              BuildDate     := fdDate;
              QtyScheduled  := fdQty;
              Active        := True;
          end;
          Result :=  True;
          break;
        end;
        REsult := TRue;
      end;
end;
Function  TProcTreeNodeForScheduling.AddNewScheduledQty(const fiProctreeId,fiProcessPartID: Integer; const FdDate: TDatetime; fdQty: Double):Boolean;
var
  x1 : integer;
  // x2:Integer;
begin
  REsult := False;
  if Self.id = fiProctreeId then begin
       result := AddNewScheduledQty(fiProcessPartID,FdDate,fdQty);
       Exit;
  end;
  for x1:= 0 to Children.Count -1 do
      if TProcTreeNodeForScheduling(Children[x1]).AddNewScheduledQty(fiProctreeId , fiProcessPartID,FdDate,fdQty) then begin
        Result := TRue;
        Break;
      end;

    (*if TProcTreeNode(Children[x1]).Id = fiProctreeId then begin
      for x2:= 0 to TProcTreeNode(Children[x1]).ProcessStepList.Count -1 do
        if TProcTreeNode(Children[x1]).ProcessStepList[x2].ID = fiProcessPartID then begin
          with TProcessPartForSchedulingNDS(TProcTreeNode(Children[x1]).ProcessStepList[x2]).ProcessPartQtyList.AddProcessPartQty do begin
              ProcessPartID := fiProcessPartID;
              BuildDate     := fdDate;
              QtyScheduled  := fdQty;
              Active        := True;
          end;
          Result :=  True;
          break;
        end;
        REsult := TRue;
      //break;
    end else begin
          REsult := TProcTreeNodeForScheduling(Children[x1]).AddNewScheduledQty(fiProctreeId,fiProcessPartID,FdDate,fdQty);
          if result then break;
    end;*)
end;

(*Function  TProcTreeNodeForScheduling.AddNewScheduledQty(const fiProctreeId,fiProcessPartID: Integer; const FdDate: TDatetime; fdQty: Double):Boolean;
var
  x1, x2:Integer;
begin
  REsult := False;
  for x1:= 0 to Children.Count -1 do
    if TProcTreeNode(Children[x1]).Id = fiProctreeId then begin
      for x2:= 0 to TProcTreeNode(Children[x1]).ProcessStepList.Count -1 do
        if TProcTreeNode(Children[x1]).ProcessStepList[x2].ID = fiProcessPartID then begin
          with TProcessPartForSchedulingNDS(TProcTreeNode(Children[x1]).ProcessStepList[x2]).ProcessPartQtyList.AddProcessPartQty do begin
              ProcessPartID := fiProcessPartID;
              BuildDate     := fdDate;
              QtyScheduled  := fdQty;
              Active        := True;
          end;
          Result :=  True;
          break;
        end;
        REsult := TRue;
      break;
    end else begin
          REsult := TProcTreeNodeForScheduling(Children[x1]).AddNewScheduledQty(fiProctreeId,fiProcessPartID,FdDate,fdQty);
          if result then break;
    end;
end;*)

function TProcTreeNodeForScheduling.FindNodeForID(aProctreeId :Integer): TProcTreeNodeForScheduling;
var
  x:Integer;
begin
  result:= nil;
  if ProctreeId = aProctreeId  then begin
    result :=self;
  end else begin
   for x:= 0 to Children.Count -1 do begin
      result:= TProcTreeNodeForScheduling(Children[x]).FindNodeForID(aProctreeId);
      if assigned(result) then break;
   end;
  end;

end;

function TProcTreeNodeForScheduling.getCommatext: String;
var
  s1, s2:String;
  x1, x2:Integer;
begin
  Result := '';
  s1:= Caption +',' + floattostr(Quantity)+',' +floattostr(totalQty);
  if ProcessStepList.Count >0 then begin
    for x1 := 0 to ProcessStepList.Count -1 do begin
      s2 := s1 + ',' + inttostr(ProcessStepList.Item[x1].Id)+',' +Floattostr(ProcessStepList.Item[x1].Duration)+',' +Floattostr(TotalQty*ProcessStepList.Item[x1].Duration);
      if TProcessPartForSchedulingNDS(ProcessStepList.Item[x1]).ProcessPartQtyList.Count >0 then begin
        for x2 := 0 to TProcessPartForSchedulingNDS(ProcessStepList.Item[x1]).ProcessPartQtyList.Count-1 do
          result := result + NL + s2 + ',' +  FormatdateTime('dd-mm-yy hh:nn:ss' , ProcessStepList.Item[x1].ProcessPartQtyList[x2].BuildDate) +',' +floattostr(ProcessStepList.Item[x1].ProcessPartQtyList[x2].QtyScheduled);
      end else begin
        result := result + NL + s2
      end;
    end;
  end else begin
    result := result + NL + s1;
  end;

  if Children.Count >0 then
    for x1 := 0 to children.Count-1 do
      result := result + NL + TProcTreeNodeForScheduling(Children[x1]).commaText;

end;
function TProcessPartForSchedulingNDS.Logstring: String;
var
  x:Integer;
begin
  result := '';
  for x := 0 to ProcessPartQtyList.count-1 do begin
    if result <> '' then result := Result +',';
    result := Result +ProcessPartQtyList.item[x].Logstring;
  end;
end;


function TProcessPartForSchedulingNDS.BuiltQtyasOnDate(aProcitem : TProcTreeNode; fdRequiredQty: Double;var aAsOnDate: TdateTime; Bookit: Boolean): Double;
var
  x:Integer;
  aQty :Double;
  fbFlag:Boolean;
  Function RoundQty(const Value :Double):Double;
  begin
    REsult := Round(Value , 5);
  end;
begin
  REsult := 0;

  {check for a process step with a duration. Id there is no process step with a duration, its ready to build}
  if  (duration=0) and
          (setupduration=0) and
          (breakdownduration=0) then begin
      Result := fdRequiredQty;
      Exit;
  end;

  if (aProcitem.onorderuomqty + aProcitem.fromstockuomqty )- aProcitem.manufacturingQty > 0 then begin
    if (aProcitem.onorderuomqty + aProcitem.fromstockuomqty )- aProcitem.manufacturingQty  >= fdRequiredQty then result := fdRequiredQty
    else result := (aProcitem.onorderuomqty + aProcitem.fromstockuomqty )- aProcitem.manufacturingQty ;
  end;


  if ProcessPartQtyList.count =0 then exit;

  for x := 0 to ProcessPartQtyList.count-1 do begin
    if (Dateof(ProcessPartQtyList.item[x].BuildDate) <= aAsOnDate) and  (ProcessPartQtyList.item[x].QtyScheduled - ProcessPartQtyList.item[x].QtyUsed >0) then begin
      if RoundQty(ProcessPartQtyList.item[x].QtyScheduled - ProcessPartQtyList.item[x].QtyUsed) > RoundQty(fdRequiredQty - result) then
           aQty := RoundQty(fdRequiredQty - result)
      else aQty := RoundQty(ProcessPartQtyList.item[x].QtyScheduled - ProcessPartQtyList.item[x].QtyUsed);

      if  (aqty <> 0) then begin
        Result := RoundQty(result +aqty);
        if ProcessPartQtyList.item[x].BuildDate > aAsOnDate then aAsOnDate := ProcessPartQtyList.item[x].BuildDate;
        if Bookit then begin
          //Logtext('Before:' +Logstring);
          ProcessPartQtyList.item[x].QtyUsed :=RoundQty(ProcessPartQtyList.item[x].QtyUsed + aQty);
          //Logtext('After:' +Logstring);
        end;
      end;

      if fdRequiredQty - result  <=0 then exit;
    end;
  end;
end;

initialization
  RegisterClassOnce(TProcessPartQtyNDS);
finalization

end.
