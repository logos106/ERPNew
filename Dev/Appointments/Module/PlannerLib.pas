unit PlannerLib;

interface

uses DBPlanner,Planner , Classes;

type
  TPlannerMultiSelectActionEvent = Procedure (Item: TPlannerItem) of Object;
  TfuncObject = function :TObject  of Object;

Procedure IterateOnSelectedCells(planner: TDBPlanner; ActionEvent : TPlannerMultiSelectActionEvent;NewItemProperty: TfuncObject;showProgressbar:Boolean =True);
Procedure IterateOnSelectedItems(planner: TDBPlanner; ActionEvent : TPlannerMultiSelectActionEvent;showProgressbar:Boolean =True);
Procedure IterateOnAllItems(planner: TDBPlanner; ActionEvent : TPlannerMultiSelectActionEvent;showProgressbar:Boolean =True;doActionIfSelected:Boolean =False);
Procedure UnselectAll(planner: TDBPlanner; showProgressbar:Boolean =True);
function PlannerItemsSelected(planner: TDBPlanner):Integer;
function PlannerFirstdateSelected(planner: TDBPlanner):TDate;
function GetFirstItemSelected(planner: TDBPlanner):TPlannerItem;


implementation

uses ProgressDialog, Dateutils, tcConst;

function GetFirstItemSelected(planner: TDBPlanner):TPlannerItem;
var
  i: integer;
begin
  REsult := nil;
  if planner.Items.Count =0 then exit;
  for i := 0 to planner.Items.Count - 1 do begin
    if planner.Items.Items[i].Selected then begin
        Result := planner.Items.Items[i];
        Exit;
    end;
  end;

end;
function PlannerFirstdateSelected(planner: TDBPlanner):TDate;
var
  i: integer;
begin
  REsult := 0;
  if planner.Items.Count =0 then exit;
  for i := 0 to planner.Items.Count - 1 do begin
    if planner.Items.Items[i].Selected then begin
      if (result =0) or (Result > Dateof(planner.Items.Items[i].ItemStartTime)) then
        Result := Dateof(planner.Items.Items[i].ItemStartTime);
    end;
  end;
end;

function PlannerItemsSelected(planner: TDBPlanner):Integer;
var
  i: integer;
begin
  REsult := 0;
  for i := 0 to planner.Items.Count - 1 do begin
    if planner.Items.Items[i].Selected then begin
      REsult := result +1;
    end;
  end;

end;
Procedure UnselectAll(planner: TDBPlanner; showProgressbar:Boolean =True);
var
  i: integer;
begin
  //planner.Selections.Clear;
  planner.SelectCells(-1,-1,-1);
  if showProgressbar then DoShowProgressbar(planner.Items.Count , WAITMSG);
  try
      for i := 0 to planner.Items.Count - 1 do begin
        if (planner.Items.Items[i].Selected) then begin
          planner.Items.Items[i].Selected := False;
        end;
        doStepProgressbar;
      end;
  finally
    if showProgressbar then DoHideProgressbar;
  end;

end;
Procedure IterateOnAllItems(planner: TDBPlanner; ActionEvent : TPlannerMultiSelectActionEvent;showProgressbar:Boolean =True;doActionIfSelected:Boolean =False);
var
  i: integer;
begin
  if showProgressbar then DoShowProgressbar(planner.Items.Count , WAITMSG);
  try
      for i := 0 to planner.Items.Count - 1 do begin
        if (doActionIfSelected =False ) or (planner.Items.Items[i].Selected) then begin
          ActionEvent(planner.Items.Items[i]);
        end;
        doStepProgressbar;
      end;
  finally
    if showProgressbar then DoHideProgressbar;
  end;
end;
Procedure IterateOnSelectedItems(planner: TDBPlanner; ActionEvent : TPlannerMultiSelectActionEvent;showProgressbar:Boolean =True);
begin
  IterateOnAllItems(Planner , actionEvent, ShowProgressbar, True);
end;


Procedure IterateOnSelectedCells(planner: TDBPlanner; ActionEvent : TPlannerMultiSelectActionEvent;NewItemProperty: TfuncObject;showProgressbar:Boolean =True);
var
  iCurrentCell, iPos: integer;
  iDayCnt, iNumDays: integer;
  oItem: TPlannerItem;
  ItemProperties:TObject;
begin
      planner.Items.BeginUpdate;
      iCurrentCell := planner.SelItemBegin;
      iPos := planner.SelPosition;
      iNumDays := (planner.SelItemEnd - planner.SelItemBegin) + 1;
      iDayCnt := 0;
      if showProgressbar then DoShowProgressbar(iNumDays , WAITMSG);
      try
        while iDayCnt < iNumDays - 1 do begin
            planner.SelectCells(iCurrentCell + iDayCnt, iCurrentCell + iDayCnt, iPos);
            oItem := planner.CreateItemAtSelection;
            ItemProperties := NewItemProperty;
            oItem.ItemObject :=  ItemProperties;  // assign object to item
            ActionEvent(oItem);
            oItem.Update;
            Inc(iDayCnt);
            doStepProgressbar;
        end;
      finally
        if showProgressbar then DoHideProgressbar;
      end;
      planner.Items.EndUpdate;
end;


end.



