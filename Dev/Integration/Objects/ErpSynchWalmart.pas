unit ErpSynchWalmart;

interface

uses JsonObject, ErpSynchObj , BusObjBase;

Type
TErpSynchWalmart = Class(TErpSynch)
  Private
    procedure AddorUpdate(Data: TJsonObject);
  Protected
  Public
    Procedure SynchOrders;(*Override;*)
End;

implementation

uses Sysutils, utCoreEDIConst,BusobjExternalXRef;

{ TErpSynchWalmart }

procedure TErpSynchWalmart.AddorUpdate(Data: TJsonObject);
begin

end;

procedure TErpSynchWalmart.SynchOrders;
var
  json: TJsonObject;
  ctr:Integer;
begin
  inherited;
    if SameTExt(CoreService.ServiceName, Servicename_Walmart) then begin
      fCurrentSynchItemType := SynchItemType_Orders;
      if CoreService.GetData(GetData_Req_Type_SynchOrders) then begin
        if CoreService.ResultData.A['items'].Count > 0 then begin
          Log('Walmart Orders Received');
          Log('=============================================');
          for ctr:= 0 to CoreService.ResultData.A['items'].Count -1 do begin
            json := CoreService.ResultData.A['items'][ctr].AsObject;
            AddorUpdate(json);
            Log(inttostr(ctr));
            log(json.asSTring);
            Log('=============================================');
          end;
        end;
      end;
    end;
end;

end.
