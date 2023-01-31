{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 03/10/05  1.00.00 BJ  Initial version.
}
unit BudgetLib;

interface

function GetTemporaryTableNameSuffix: string;
function PeriodName(const PeriodValue: integer): string;
function IsAmtField(const sFieldName: string): boolean;
function PeriodValue(const PeriodName: string): integer;

implementation

uses
   OnGuard, ogutil, {LBUtils,} sysutils, FastFuncs, Controls,AppEnvironment,
  CommonLib;

function RemoveInvalidAlphaNumericCharacters(const sValue: string): string;
var
  iIndex: integer;
  sNewValue: string;
begin
  sNewValue := sValue;
  for iIndex := 1 to char_length(sValue) do begin
    if not CharInSet(sValue[iIndex],['a'..'z', 'A'..'Z', '0'..'9', '_']) then begin
      sNewValue := StringReplace(sNewValue, sValue[iIndex], '_', [rfReplaceAll,rfIgnoreCase]);
    end;
  end;
  Result := sNewValue;
end;

function GetMachineIdentification(const User, System, Network, Drives: boolean): string;
var
  InfoSet: TEsMachineInfoSet;
  MachineID: longint;
begin
  InfoSet := [];
  if User then InfoSet := InfoSet + [midUser];
  if System then InfoSet := InfoSet + [midSystem];
  if Network then InfoSet := InfoSet + [midNetwork];
  if Drives then InfoSet := InfoSet + [midDrives];

  MachineID := CreateMachineID(InfoSet);
  Result := BufferToHex(MachineID, SizeOf(MachineID));
end;

function IsAmtField(const sFieldName: string): boolean;
Var
  FieldName: String;
begin
  Result := false;
  FieldName := Trim(sFieldName);
  if uppercase(Copy(FieldName, char_length(fieldName) - 4, 4)) = '_AMT' then
    if uppercase(Copy(FieldName, 1, 12)) <> 'ALLCLASS_AMT' then
      Result := true;
end;

function GetTemporaryTableNameSuffix: string;
begin
  Result := '_' + RemoveInvalidAlphaNumericCharacters(Trim(AppEnv.Employee.LogonName)) + '_' + GetMachineIdentification(true,
    true, true, true);
end;

function PeriodName(const PeriodValue: integer): string;
begin
  case PeriodValue of
    1: Result := 'Daily';
    2: Result := 'Weekly';
    3: Result := 'Fortnightly';
    4: Result := 'Monthly';
    5: Result := 'Quarterly';
    6: Result := 'Half Yearly';
    else Result := 'Yearly';
  end;
end;

function PeriodValue(const PeriodName: string): integer;
begin
  Result := 0;
  if PeriodName = 'Daily' then Result := 1
  else if PeriodName = 'Weekly' then Result := 2
  else if PeriodName = 'Fortnightly' then Result := 3
  else if PeriodName = 'Monthly' then Result := 4
  else if PeriodName = 'Quarterly' then Result := 5
  else if PeriodName = 'Half Yearly' then Result := 6
  else if PeriodName = 'Yearly' then Result := 7;
end;

end.

