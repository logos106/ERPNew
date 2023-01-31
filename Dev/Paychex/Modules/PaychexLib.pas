unit PaychexLib;

interface

function PayNameToDesc(const aPayName:Integer):String;
function classificationTypeToDesc(const aclassificationType:Integer):String;
function effectOnPayToDesc(const aeffectOnPay:Integer):String;

implementation

function PayNameToDesc(const aPayName:Integer):String;
begin
  if aPayName = 1 Then result := 'Hourly'
  Else if aPayName = 2 Then Result := 'Daily'
  Else if aPayName = 3 Then Result := 'IRA EE'
  Else if aPayName = 4 Then Result := 'Informal'
  Else REsult := 'Default';
end;
function classificationTypeToDesc(const aclassificationType:Integer):String;
begin
  if aclassificationType = 1 Then result := 'Regular'
  Else if aclassificationType = 2 Then Result := 'SUPPLEMENTAL'
  Else if aclassificationType = 3 Then Result := 'IRA (Individual Retirement Account)'
  Else if aclassificationType = 4 Then Result := 'Informational'
  Else REsult := 'Default';
end;
function effectOnPayToDesc(const aeffectOnPay:Integer):String;
begin
  if aeffectOnPay = 1 Then result := 'ADDITION'
  Else if aeffectOnPay = 2 Then Result := 'REDUCTION'
  Else if aeffectOnPay = 3 Then Result := 'INFORMATIONAL'
  Else REsult := 'Default';
end;
end.
