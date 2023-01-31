unit MenuEvents;

interface
uses
  Classes;

type
  TMenuEventType = (OnMenuPopuptype, OnMenuClickType, OnActionExecutetype);

  TMenuEventRec = record
    MenuEventType: TMenuEventType;
    Name: string;
    Code, Data: Pointer;
  end;

  PMenuEventRec = ^TMenuEventRec;

  procedure FreeMenuEventList(aList : TList);

implementation

procedure FreeMenuEventList(aList : TList);
var
  idx : integer;
begin
  for idx := 0 to aList.Count - 1 do
  begin
    //Finalize(PMenuEventRec(aList[idx]).Name);
    PMenuEventRec(aList[idx]).Name := '';
    Dispose(aList[idx]);
  end;
  aList.Clear;
end;

end.
