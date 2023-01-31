unit GlobalRefToIDToggleObj;

interface
  
uses DB, MyAccess,  SysUtils;
//Multisite ID/GlobalRef Utils


function GlobalRefToID(const GlobalRef: string; const FieldName: string): integer;
  {Works Out What Function the Use By FieldName}


  // GET ID's
function GetSaleID(const GlobalRef: string): integer;
function GetSaleLineID(const GlobalRef: string): integer;
function GetPurchaseOrderID(const GlobalRef: string): integer;
function GetPurchaseLineID(const GlobalRef: string): integer;
function GetPayMethodID(const GlobalRef: string): integer;
function GetOtherTypeID(const GlobalRef: string): integer;
function GetClientID(const GlobalRef: string): integer;
function GetClassID(const GlobalRef: string): integer;
function GetAccountID(const GlobalRef: string): integer;
function GetAccountIDFromAccountName(const AccountName: string): integer;
function GetPartID(const GlobalRef: string): integer;
function GetEmployeeID(const GlobalRef: string): integer;
function GetClientTypeID(const GlobalRef: string): integer;
function GetSourceID(const GlobalRef: string): integer;
function GetTermsID(const GlobalRef: string): integer;
function GetTaxcodeID(const GlobalRef: string): integer;
function GetAbilityID(const GlobalRef: string): integer;
function GetServiceID(const GlobalRef: string): integer;
function GetAppointID(const GlobalRef: string): integer;
function GetTrainRateID(const GlobalRef: string): integer;
function GetEquipmentID(const GlobalRef: string): integer;
//function GetRepairID(const GlobalRef: string): integer;
function GetSmartOrderID(const GlobalRef: string): integer;
function GetDepositPaymentID(const GlobalRef: string): integer;
function GetWithdrawalPaymentID(const GlobalRef: string): integer;
function GetShippingMethodID(const GlobalRef: string): integer;
function GetTransferID(const GlobalRef: string): integer;
function GetGJID(const GlobalRef: string): integer; {General Jounral}
function GetSTOCKAdjID(const GlobalRef: string): integer;
function GetVehicleID(const GlobalRef: string): integer;
function GetManifestRouteID(const GlobalRef: string): integer;
function GetManifestID(const GlobalRef: string): integer;

  // GET GlobalRef's
function GetSaleGlobalRef(const ID: integer): string;
function GetSaleLineGlobalRef(const ID: integer): string;
function GetPurchaseOrderGlobalRef(const ID: integer): string;
function GetPurchaseLineGlobalRef(const ID: integer): string;
function GetPayMethodGlobalRef(const ID: integer): string;
function GetOtherTypeGlobalRef(const ID: integer): string;
function GetClientGlobalRef(const ID: integer): string;
function GetClassGlobalRef(const ID: integer): string;
function GetAccountGlobalRef(const ID: integer): string;
function GetPartGlobalRef(const ID: integer): string;
function GetEmployeeGlobalRef(const ID: integer): string;
function GetClientTypeGlobalRef(const ID: integer): string;
function GetSourceGlobalRef(const ID: integer): string;
function GetTermsGlobalRef(const ID: integer): string;
function GetTaxcodeGlobalRef(const ID: integer): string;
function GetAbilityGlobalRef(const ID: integer): string;
function GetServiceGlobalRef(const ID: integer): string;
function GetAppointGlobalRef(const ID: integer): string;
function GetTrainRateGlobalRef(const ID: integer): string;
function GetEquipmentGlobalRef(const ID: integer): string;
//function GetRepairGlobalRef(const ID: integer): string;
function GetSmartOrderGlobalRef(const ID: integer): string;
function GetDepositPaymentGlobalRef(const ID: integer): string;
function GetWithdrawalPaymentGlobalRef(const ID: integer): string;
function GetShippingMethodGlobalRef(const ID: integer): string;
function GetTransferGlobalRef(const ID: integer): string;
function GetGJGlobalRef(const ID: integer): string; {General Jounral}
function GetSTOCKAdjGlobalRef(const ID: integer): string;
function GetVehicleGlobalRef(const ID: integer): string;
function GetManifestRouteGlobalRef(const ID: integer): string;
function GetManifestGlobalRef(const ID: integer): string;


implementation

uses FastFuncs,CommonDbLib;

function GlobalRefToID(const GlobalRef: string; const FieldName: string): integer;
begin
  if (FieldName = 'ClientGlobalRef') or (FieldName = 'ClientGlobalRef2') then begin
    Result := GetClientID(GlobalRef);
  end else if (FieldName = 'ClassGlobalRef') then begin
    Result := GetClassID(GlobalRef);
  end else if (FieldName = 'AccountGlobalRef') or (FieldName = 'AccountGlobalRef2') then begin
    Result := GetAccountID(GlobalRef);
  end else if (FieldName = 'PartGlobalRef') or (FieldName = 'PartGlobalRef2') then begin
    Result := GetPartID(GlobalRef);
  end else if (FieldName = 'EmployeeGlobalRef') or (FieldName = 'EmployeeGlobalRef2') or (FieldName = 'EmployeeGlobalRef3') then
  begin
    Result := GetEmployeeID(GlobalRef);
  end else if FieldName = 'ClientTypeGlobalRef' then begin
    Result := GetClientTypeID(GlobalRef);
  end else if FieldName = 'SourceGlobalRef' then begin
    Result := GetSourceID(GlobalRef);
  end else if FieldName = 'TermsGlobalRef' then begin
    Result := GetTermsID(GlobalRef);
  end else if FieldName = 'PayMethodGlobalRef' then begin
    Result := GetPayMethodID(GlobalRef);
  end else if FieldName = 'OtherTypeGlobalRef' then begin
    Result := GetOtherTypeID(GlobalRef);
  end else if (FieldName = 'SaleGlobalRef') or (FieldName = 'SaleGlobalRef2') then begin
    Result := GetSaleID(GlobalRef);
  end else if FieldName = 'SaleLineGlobalRef' then begin
    Result := GetSaleLineID(GlobalRef);
  end else if FieldName = 'PurchaseOrderGlobalRef' then begin
    Result := GetPurchaseOrderID(GlobalRef);
  end else if FieldName = 'PurchaseLineGlobalRef' then begin
    Result := GetPurchaseLineID(GlobalRef);
  end else if FieldName = 'TaxcodeGlobalRef' then begin
    Result := GetTaxcodeID(GlobalRef);
  end else if FieldName = 'AbilityGlobalRef' then begin
    Result := GetAbilityID(GlobalRef);
  end else if FieldName = 'ServiceGlobalRef' then begin
    Result := GetServiceID(GlobalRef);
  end else if FieldName = 'AppointGlobalRef' then begin
    Result := GetAppointID(GlobalRef);
  end else if FieldName = 'TrainRateGlobalRef' then begin
    Result := GetTrainRateID(GlobalRef);
  end else if FieldName = 'EquipmentGlobalRef' then begin
    Result := GetEquipmentID(GlobalRef);
//  end else if FieldName = 'RepairGlobalRef' then begin
//    Result := GetRepairID(GlobalRef);
  end else if FieldName = 'SmartOrderGlobalRef' then begin
    Result := GetSmartOrderID(GlobalRef);
  end else if FieldName = 'DepositPaymentGlobalRef' then begin
    Result := GetDepositPaymentID(GlobalRef);
  end else if FieldName = 'WithdrawalPaymentGlobalRef' then begin
    Result := GetWithdrawalPaymentID(GlobalRef);
  end else if FieldName = 'ShippingMethodGlobalRef' then begin
    Result := GetShippingMethodID(GlobalRef);
  end else if FieldName = 'TransferGlobalRef' then begin
    Result := GetTransferID(GlobalRef);
  end else if FieldName = 'GJGlobalRef' then begin
    Result := GetGJID(GlobalRef);
  end else if FieldName = 'STOCKAdjGlobalRef' then begin
    Result := GetSTOCKAdjID(GlobalRef);
  end else if FieldName = 'VehicleGlobalRef' then begin
    Result := GetVehicleID(GlobalRef);
  end else if FieldName = 'ManifestRouteGlobalRef' then begin
    Result := GetManifestRouteID(GlobalRef);
  end else if FieldName = 'ManifestGlobalRef' then begin
    Result := GetManifestID(GlobalRef);
  end else begin
    Result := 0;
  end;
end;


function GetAppointID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT AppointID FROM tblappointments WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('AppointID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetTrainRateID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT TrainRateID FROM tbltrainerrates WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('AppointID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetDepositPaymentID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT PaymentID FROM tbldeposits WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PaymentID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetWithdrawalPaymentID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT PaymentID FROM tblwithdrawal WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PaymentID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetShippingMethodID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT ShippingMethodID FROM tblshippingmethods WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('ShippingMethodID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetTransferID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT TransferID FROM tblstocktransfer WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('TransferID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetSTOCKAdjID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT StockAdjustmentNo FROM tblstockadjust WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('StockAdjustmentNo').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetGJID(const GlobalRef: string): integer; {General Jounral}
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GJID FROM tblgeneraljournal WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GJID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetSmartOrderID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT SmartOrderID FROM tblsmartorder WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('SmartOrderID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

//function GetRepairID(const GlobalRef: string): integer;
//var
//  qryTemp: TMyQuery;
//begin
//  qryTemp := TMyQuery.Create(nil);
//  qryTemp.Options.FlatBuffers := True;
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  try
//    qryTemp.Sql.Add('SELECT RepairID FROM tblrepairs WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
//    qryTemp.Active := true;
//    if not qryTemp.IsEmpty then begin
//      Result := qryTemp.FieldByName('RepairID').AsInteger;
//    end else begin
//      Result := 0;
//    end;
//  finally
//    FreeAndNil(qryTemp);
//  end;
//end;

function GetEquipmentID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT EquipmentID FROM tblequipment WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('EquipmentID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetTaxcodeID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT TaxCodeID  FROM tbltaxcodes WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('TaxCodeID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetAbilityID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT AbilityID  FROM tblability WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('AbilityID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetServiceID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT ServiceID  FROM tblservices WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('ServiceID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetAbilityGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef  FROM tblability WHERE AbilityID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetDepositPaymentGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tbldeposits WHERE PaymentID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;


function GetWithdrawalPaymentGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblwithdrawal WHERE PaymentID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetTransferGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblstocktransfer WHERE TransferID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetManifestRouteGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblmanifestroutes WHERE ManifestRouteID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetManifestGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblmanifest WHERE ManifestID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetVehicleGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblmanifestvehicles WHERE VehicleID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetSTOCKAdjGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblstockadjust WHERE StockAdjustmentNo =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetGJGlobalRef(const ID: integer): string; {General Jounral}
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblgeneraljournal WHERE GJID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetShippingMethodGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblshippingmethods WHERE ShippingMethodID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetSmartOrderGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblsmartorder WHERE SmartOrderID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;


//function GetRepairGlobalRef(const ID: integer): string;
//var
//  qryTemp: TMyQuery;
//begin
//  qryTemp := TMyQuery.Create(nil);
//  qryTemp.Options.FlatBuffers := True;
//  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
//  try
//    qryTemp.Sql.Add('SELECT GlobalRef FROM tblrepairs WHERE RepairID =' + FastFuncs.IntToStr(ID) + ';');
//    qryTemp.Active := true;
//    if not qryTemp.IsEmpty then begin
//      Result := qryTemp.FieldByName('GlobalRef').AsString;
//    end else begin
//      Result := '';
//    end;
//  finally
//    FreeAndNil(qryTemp);
//  end;
//end;

function GetEquipmentGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblequipment WHERE EquipmentID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetAppointGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblappointments WHERE AppointID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetTrainRateGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef  FROM tbltrainerrates WHERE TrainRateID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetServiceGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef  FROM tblservices WHERE ServiceID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetTaxcodeGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tbltaxcodes WHERE TaxCodeID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetSaleID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT SaleID FROM tblsales');
    qryTemp.Sql.Add('WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;

    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('SaleID').AsInteger;
    end else begin
      Result := 0;
    end;

  finally
    // Release our used objects.
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

function GetSaleLineID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT SaleLineID  FROM tblsaleslines WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('SaleLineID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

function GetPurchaseOrderID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT PurchaseOrderID FROM tblpurchaseorders WHERE GlobalRef =' + QuotedStr(GlobalRef) + ' AND Paid="F";');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PurchaseOrderID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;

function GetPurchaseLineID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT PurchaseLineID  FROM tblpurchaselines WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PurchaseLineID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    if Assigned(qryTemp) then FreeAndNil(qryTemp);
  end;
end;


function GetSaleGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef  FROM tblsales WHERE SaleID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetSaleLineGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblsaleslines WHERE SaleLineID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetPurchaseOrderGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef  FROM tblpurchaseorders WHERE PurchaseOrderID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetPurchaseLineGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef  FROM tblpurchaselines WHERE PurchaseLineID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetPayMethodGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblpaymentmethods WHERE PayMethodID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetOtherTypeGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef  FROM tblothertype WHERE OtherTypeID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetPayMethodID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT PayMethodID FROM tblpaymentmethods WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PayMethodID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetOtherTypeID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT OtherTypeID  FROM tblothertype WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('OtherTypeID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetAccountIDFromAccountName(const AccountName: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT AccountID FROM tblchartofaccounts WHERE AccountName =' + QuotedStr(AccountName) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('AccountID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetAccountID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT AccountID FROM tblchartofaccounts WHERE GlobalRef =' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('AccountID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetAccountGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblchartofaccounts WHERE AccountID =' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetClassID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT ClassID FROM tblclass WHERE GlobalRef = ' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('ClassID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetClassGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblclass WHERE ClassID = ' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetClientID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT ClientID  FROM tblclients WHERE GlobalRef = ' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('ClientID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetEmployeeID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT EmployeeID FROM tblemployees WHERE GlobalRef = ' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('EmployeeID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetClientTypeID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT ClientTypeID FROM tblclienttype WHERE GlobalRef = ' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('ClientTypeID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetSourceID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT MedTypeID FROM tblsource WHERE GlobalRef = ' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('MedTypeID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetTermsID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT TermsID FROM tblterms WHERE GlobalRef = ' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('TermsID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetManifestID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT ManifestID FROM tblmanifest WHERE GlobalRef = ' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('ManifestID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetManifestRouteID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT ManifestRouteID FROM tblmanifestroutes WHERE GlobalRef = ' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('ManifestRouteID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetVehicleID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT VehicleID FROM tblmanifestvehicles WHERE GlobalRef = ' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('VehicleID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetPartID(const GlobalRef: string): integer;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT PARTSID FROM tblparts WHERE GlobalRef = ' + QuotedStr(GlobalRef) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('PARTSID').AsInteger;
    end else begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetClientGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblclients WHERE ClientID = ' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetEmployeeGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblemployees WHERE EmployeeID = ' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetClientTypeGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;  
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblclienttype WHERE ClientTypeID = ' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetSourceGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblsource WHERE MedTypeID = ' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetTermsGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;  
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblterms WHERE TermsID = ' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GetPartGlobalRef(const ID: integer): string;
var
  qryTemp: TMyQuery;
begin
  qryTemp := TMyQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Clear;
    qryTemp.Sql.Add('SELECT GlobalRef FROM tblparts WHERE PARTSID = ' + FastFuncs.IntToStr(ID) + ';');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('GlobalRef').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;
////////////

end.

