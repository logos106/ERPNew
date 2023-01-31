unit DoorEditBaseObject;

interface

uses
  Classes, NodePropertiesLink, MyAccess,ERPdbComponents, SysUtils,
  Dialogs;

type
  TDoorEditBaseObj = class(TNodePropertiesLink)
  private
    Function getDoorPairing:Integer;
  Protected

  Public
    Property DoorPairing :Integer Read getDoorPairing;
  End;

implementation

uses EditDoorQuotationDetailsObj;

Function TDoorEditBaseObj.getDoorPairing:Integer;
var
    mainDoor :TEditDoorQuotationDetails;
begin
    REsult := 0;
    if (Assigned(Self.Owner)) and (Self.Owner is TEditDoorQuotationDetails) then
        mainDoor := TEditDoorQuotationDetails(Self.Owner)
    else Exit;
    Result := mainDoor.DoorPair;
end;
end.

