unit AccessLevelUtils;

interface

const
  AccessGroupCount = 27;
  ERPAccessGroups: array[1..AccessGroupCount] of
    record
      Id: integer;
      Name: string;
    end =
   (
     (Id: 1;  Name: 'Accounts'),
     (Id: 2;  Name: 'Appointments'),
     (Id: 3;  Name: 'Banking'),
     (Id: 4;  Name: 'CRM / Marketing'),
     (Id: 5;  Name: 'Delivery'),
     (Id: 24; Name: 'EBay'),
     (Id: 27; Name: 'EDI'),
     (Id: 6;  Name: 'Employee'),
     (Id: 7;  Name: 'FixedAssets'),
     (Id: 8;  Name: 'General'),
     (Id: 23; Name: 'Google'),
     (Id: 25; Name: 'Hire'),
     (Id: 9;  Name: 'Inventory'),
     (Id: 10; Name: 'MainBackground'),
     (Id: 11; Name: 'Manufacturing'),
     (Id: 12; Name: 'Miscellaneous'),
     (Id: 13; Name: 'Payments'),
     (Id: 14; Name: 'Payroll'),
     (Id: 15; Name: 'POS'),
     (Id: 16; Name: 'Purchases'),
     (Id: 17; Name: 'Repairs'),
     (Id: 18; Name: 'Returns'),
     (Id: 19; Name: 'Sales'),
     (Id: 20; Name: 'SalesOrder'),
     (Id: 21; Name: 'Training'),
     (Id: 26; Name: 'TrueERP Mobile'),
     (Id: 22; Name: 'Utilities')
   );

   ERPAccessLevels: array[1..5] of
     record
       Level: integer;
       Name: string;
     end =
     (
       (Level: 1; Name: 'Full Access'),
       (Level: 2; Name: 'Full Access, No Delete'),
       (Level: 3; Name: 'Create + Read'),
       (Level: 5; Name: 'Read Only'),
       (Level: 6; Name: 'No Access')
     );

   function AccessGroupIdToName(const aId: integer): string;
   function AccessLevelToName(const aLevel: integer): string;

implementation

function AccessGroupIdToName(const aId: integer): string;
var
  x: integer;
begin
  result := '';
  for x := Low(ERPAccessGroups) to High(ERPAccessGroups) do begin
    if ERPAccessGroups[x].Id = aId then begin
      result := ERPAccessGroups[x].Name;
      break;
    end;
  end;
end;

function AccessLevelToName(const aLevel: integer): string;
var
  x: integer;
begin
  result := '';
  for x := Low(ERPAccessLevels) to High(ERPAccessLevels) do begin
    if ERPAccessLevels[x].Level = aLevel then begin
      result := ERPAccessLevels[x].Name;
      break;
    end;
  end;
end;

end.
