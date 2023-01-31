unit SMSUtils;

interface
{$I ERP.inc}

uses
  MyAccess, SMSMessageObj, Classes;

//procedure SendSMS(aPhoneNumber, aMessage: string; dbConnection: TMyConnection; SubstituteList: TStringList = nil);

function PhoneNoToEntity(aPhoneNumber: string;
  var ContactID, CustomerId, SupplierId, EmployeeId, MarketingContactId: integer;
  dbConnection: TMyConnection): boolean;

function NumberHasCountryCode(const aPhoneNumber: string; dbConnection: TCustomMyConnection): boolean;
function NumberCountryCode(const aPhoneNumber: string; dbConnection: TCustomMyConnection): string;
function NumberCurrencyCode(const aPhoneNumber: string; dbConnection: TCustomMyConnection): string;
function NumberHasPlusPrefix(const aPhoneNumber: string): boolean;
function NumberHasCorrectPrefix(const aPhoneNumber: string; dbConnection: TCustomMyConnection): boolean;

const
  DevMode_MobileNumber = '+61405419565';

implementation

uses
  ERPDBComponents, SysUtils, DB;

//procedure SendSMS(aPhoneNumber, aMessage: string; dbConnection: TMyConnection;
//  SubstituteList: TStringList = nil);
//var
//  qry: TERPQuery;
//  ContactId, CustomerID, SupplierId, EmployeeId, MarketingContactId: integer;
//  smsMsg: TSMSMessage;
//  stream: TStream;
//  x: integer;
//  s, num: string;
//begin
//  if (aPhoneNumber = '') or (aMessage = '') then exit;
//
//  num := StringReplace(aPhoneNumber,' ','',[rfReplaceAll]);
//  qry := TERPQuery.Create(nil);
//  smsMsg := TSMSMessage.Create;
//  try
//    qry.Connection := dbConnection;
//    qry.SQL.Text := 'select * from tblreference where RefID = 0';
//    qry.Open;
//    qry.Insert;
//
//    qry.FieldByName('Ref_type').AsString := 'SMS';
//    qry.FieldByName('Referencetxt').AsString := Copy(aMessage,1,50);
//    qry.FieldByName('Ref_Date').AsDateTime := now;
//    qry.FieldByName('Status').AsString := 'Waiting';
//    qry.FieldByName('MessageTo').AsString := num;
//    {$IFDEF DevMode}
//      qry.FieldByName('MessageTo').AsString := DevMode_MobileNumber;
//    {$ENDIF}
//
//    if Assigned (SubstituteList) then begin
//      s := aMessage;
//      for x := 0  to SubstituteList.Count -1 do begin
//        s := StringReplace(s, SubstituteList.Names[x], SubstituteList.ValueFromIndex[x], [rfReplaceAll,rfIgnoreCase]);
//      end;
//      smsMsg.Content := s;
//    end
//    else
//      smsMsg.Content := aMessage;
//    smsMsg.Format := 'SMS';
//    smsMsg.PhoneNumber := num;
//    smsMsg.Status := 'Waiting';
//
//    stream:= qry.CreateBlobStream(qry.FieldByName('ReferenceData'),bmReadWrite);
//    try
//      smsMsg.SaveToStream(stream);
//    finally
//      stream.Free;
//    end;
//
//    if PhoneNoToEntity(num, ContactId, CustomerID, SupplierId, EmployeeId, MarketingContactId, dbConnection) then begin
//      if ContactId > 0 then qry.FieldByName('ContactId').AsInteger := ContactId;
//      if CustomerId > 0 then qry.FieldByName('CusId').AsInteger := CustomerId;
//      if SupplierId > 0 then qry.FieldByName('SupId').AsInteger := SupplierId;
//      if EmployeeId > 0 then qry.FieldByName('EmployeeId').AsInteger := EmployeeId;
//      if MarketingContactId > 0 then qry.FieldByName('MarketingContactId').AsInteger := MarketingContactId;
//    end;
//
//    qry.Post;
//
//    qry.SQL.Clear;
//    qry.SQL.Add('update tblreference');
//    qry.SQL.Add('set msUpdateSiteCode = (select tblmsbackendid.SiteCode from tblmsbackendid limit 1)');
//    qry.SQL.Add(', GlobalRef = Concat(RefID,(select tblmsbackendid.SiteCode from tblmsbackendid limit 1))');
//    qry.SQL.Add('where IsNull(msUpdateSiteCode)');
//    qry.Execute;
//
//  finally
//    qry.Free;
//    smsMsg.Free;
//  end;
//end;

function ExtractLocalNumber(aPhoneNumber: string; dbConnection: TMyConnection): string;
var
  maxLength, subPos: integer;
  qry2: TERPQuery;
begin
  result := StringReplace(aPhoneNumber,'+','',[]);
  qry2 := TERPQuery.Create(nil);
  try
    qry2.Connection := dbConnection;
    qry2.SQL.Text := 'select max(Length(callingcode)) as MaxLength from tblcountries';
    qry2.Open;
    maxLength := qry2.FieldByName('MaxLength').AsInteger;
    qry2.Close;
    if maxLength > 0 then begin
      for subPos := maxLength downto 1 do begin
        qry2.SQL.Text := 'select * from tblcountries where CallingCode = ' + QuotedStr(Copy(result,1,subPos));
        qry2.Open;
        if not qry2.IsEmpty then begin
          result := Copy(result,subPos+1,Length(result));
          break;
        end;
        qry2.Close;
      end;
    end;
  finally
    qry2.Free;
  end;
  { strip off leading 0's  }
  while Copy(result,1,1) = '0' do
    result := Copy(result,2,Length(result));
end;

function NumberCountryCode(const aPhoneNumber: string; dbConnection: TCustomMyConnection): string;
var
  qry2: TERPQuery;
  aNumber: string;
begin
  result := '';
  aNumber := StringReplace(aPhoneNumber,'+','',[]);
  aNumber := StringReplace(aNumber,' ','',[rfReplaceAll]);
  qry2 := TERPQuery.Create(nil);
  try
    qry2.Connection := dbConnection;
    qry2.SQL.Add('select Distinct(CallingCode) as CallingCode from tblcountries where Left("' + aNumber + '",1) = CallingCode');
    qry2.SQL.Add('union all');
    qry2.SQL.Add('select Distinct(CallingCode) as CallingCode from tblcountries where Left("' + aNumber + '",2) = CallingCode');
    qry2.SQL.Add('union all');
    qry2.SQL.Add('select Distinct(CallingCode) as CallingCode from tblcountries where Left("' + aNumber + '",3) = CallingCode');
    qry2.SQL.Add('union all');
    qry2.SQL.Add('select Distinct(CallingCode) as CallingCode from tblcountries where Left("' + aNumber + '",4) = CallingCode');
    qry2.SQL.Add('union all');
    qry2.SQL.Add('select Distinct(CallingCode) as CallingCode from tblcountries where Left("' + aNumber + '",5) = CallingCode');
    qry2.SQL.Add('union all');
    qry2.SQL.Add('select Distinct(CallingCode) as CallingCode from tblcountries where Left("' + aNumber + '",6) = CallingCode');
    qry2.Open;
    result := qry2.FieldByName('CallingCode').AsString;
  finally
    qry2.Free;
  end;
end;

function NumberCurrencyCode(const aPhoneNumber: string; dbConnection: TCustomMyConnection): string;
var
  CallingCode: string;
  qry: TERPQuery;
begin
  result := '';
  CallingCode := NumberCountryCode(aPhoneNumber, dbConnection);
  if CallingCode <> '' then begin
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := dbConnection;
      qry.SQL.Add('select tblcurrencyconversion.Code from tblcountries, tblcurrencyconversion');
      qry.SQL.Add('where tblcountries.CallingCode = ' + QuotedStr(CallingCode));
      qry.SQL.Add('and tblcountries.Country = tblcurrencyconversion.Country');
      qry.Open;
      if not qry.IsEmpty then
        result := qry.FieldByName('Code').AsString;
    finally
      qry.Free;
    end;
  end;
end;

function PhoneNoToEntity(aPhoneNumber: string;
  var ContactID, CustomerId, SupplierId, EmployeeId, MarketingContactId: integer;
  dbConnection: TMyConnection): boolean;
var
  qry2: TERPQuery;
  ph: string;
begin
  result := false;
  ContactID := 0;
  CustomerId := 0;
  SupplierId := 0;
  EmployeeId := 0;
  MarketingContactId := 0;

  ph := ExtractLocalNumber(aPhoneNumber, dbConnection);
  qry2 := TERPQuery.Create(nil);
  try
    qry2.Connection := dbConnection;

    qry2.SQL.Add('select tblclients.ClientID, tblContacts.ContactID, Null as MarketingContactID, Null as EmployeeID, Customer, Supplier, OtherContact, "F" as MarketingContact, "F" as Employee');
    qry2.SQL.Add('from tblclients');
    qry2.SQL.Add('left join tblcontacts on tblcontacts.ClientID = tblclients.ClientID');
    qry2.SQL.Add('where (tblclients.Mobile > "" and Replace(tblclients.Mobile," ","") like "%' + ph + '")');
    qry2.SQL.Add('or (tblContacts.ContactMob > "" and Replace(tblContacts.ContactMob," ","") like "%' + ph + '")');

    qry2.SQL.Add('union all');
    qry2.SQL.Add('select Null as ClientID, Null as ContactID, Null as MarketingContactID, tblEmployees.EmployeeID, "F" as Customer, "F" as Supplier, "F" as OtherContact, "F" as MarketingContact, "T" as Employee');
    qry2.SQL.Add('from tblEmployees');
    qry2.SQL.Add('where tblEmployees.Mobile > ""');
    qry2.SQL.Add('and Replace(tblEmployees.Mobile," ","") like "%' + ph + '"');

    qry2.SQL.Add('union all');
    qry2.SQL.Add('select Null as ClientID, Null as ContactID, tblMarketingContacts.ID as MarketingContactID, Null as EmployeeID, "F" as Customer, "F" as Supplier, "F" as OtherContact, "T" as MarketingContact, "F" as Employee');
    qry2.SQL.Add('from tblMarketingContacts');
    qry2.SQL.Add('where (IsNull(tblMarketingContacts.ClientID) or (tblMarketingContacts.ClientID = 0)) and tblMarketingContacts.Mobile > ""');
    qry2.SQL.Add('and Replace(tblMarketingContacts.Mobile," ","") like "%' + ph + '"');

    qry2.Open;
    while not qry2.Eof do begin
      result := true;
      if qry2.FieldByName('ClientID').AsInteger > 0 then begin
        if qry2.FieldByName('Customer').AsBoolean then
          CustomerId := qry2.FieldByName('ClientID').AsInteger;
        if qry2.FieldByName('Supplier').AsBoolean then
          SupplierID := qry2.FieldByName('ClientID').AsInteger;
      end;
      if qry2.FieldByName('ContactID').AsInteger > 0 then
        ContactID := qry2.FieldByName('ContactID').AsInteger;
      if qry2.FieldByName('MarketingContactID').AsInteger > 0 then
        MarketingContactID := qry2.FieldByName('MarketingContactID').AsInteger;
      if qry2.FieldByName('EmployeeID').AsInteger > 0 then
        EmployeeID := qry2.FieldByName('EmployeeID').AsInteger;
      qry2.Next;
    end;

  finally
    qry2.Free;
  end;
end;


function NumberHasCountryCode(const aPhoneNumber: string; dbConnection: TCustomMyConnection): boolean;
var
  no: string;
begin
  result := true;
  no := StringReplace(Trim(aPhoneNumber),'+','',[]);
  if Copy(no,1,1) = '0' then begin
    result := false;
    exit;
  end;
  if NumberCountryCode(aPhoneNumber, dbConnection) = '' then
    result := false;
end;

function NumberHasPlusPrefix(const aPhoneNumber: string): boolean;
begin
  result := Pos('+',Trim(aPhoneNumber)) = 1;
end;

function NumberHasCorrectPrefix(const aPhoneNumber: string; dbConnection: TCustomMyConnection): boolean;
begin
  result := True;
  Exit;
  // dene wants this to be removed as is not required for cloud
  result := NumberHasPlusPrefix(aPhoneNumber) and NumberHasCountryCode(aPhoneNumber, dbConnection);
end;

end.
