{******************************************************************* }
  { RegistrationLib - Library routines for use by ERP Registration   }
  {                                                                   }
  { 24 nov 2004 change:  preset MachineID                              }
  {                      before calling any function here              }
  {******************************************************************* }
unit RegistrationLib;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs,
  StdCtrls, StrUtils, Registry, OnGuard, OgUtil, MyAccess,ERPdbComponents, IniFiles, SproMeps, Printers;

const
  D_Year   = 2005;
  D_Month  = 2;
  D_Day    = 1;
  PrintReg = true;

type
  TQueryStr           = array[1..4] of byte;
  TQueryPair          = array[1..2] of TQueryStr;
  TQueryEndUserTable  = array[1..60] of TQueryPair;
  TQueryResellerTable = array[1..60] of TQueryPair;
  TQueryKeyGenTable   = array[1..60] of TQueryPair;

const
  QueryKeyGenTable: TQueryKeyGenTable = ((($AA, $E8, $58, $BD), ($0F, $D5, $4B, $67)),
    (($DF, $37, $EB, $C9), ($99, $E3, $07, $92)),
    (($B2, $1D, $57, $64), ($3A, $D7, $DF, $B6)),
    (($80, $18, $79, $0C), ($6B, $E8, $37, $9C)),
    (($9C, $BD, $DC, $2F), ($EA, $55, $79, $CD)),
    (($95, $F1, $21, $F6), ($BE, $B5, $BF, $4E)),
    (($B8, $5C, $A4, $62), ($F8, $F8, $D7, $31)),
    (($D6, $1B, $5C, $9B), ($BF, $FF, $F7, $3F)),
    (($48, $B5, $03, $85), ($ED, $99, $2E, $05)),
    (($2F, $51, $77, $93), ($B2, $EF, $57, $AD)),
    (($F9, $92, $1C, $AD), ($FD, $F9, $A6, $9E)),
    (($DC, $58, $B6, $5A), ($FB, $C5, $DF, $91)),
    (($A8, $BC, $7A, $85), ($DD, $65, $F2, $09)),
    (($05, $50, $FD, $7F), ($F8, $9A, $6C, $80)),
    (($CC, $1A, $7D, $9F), ($5E, $9C, $5E, $DC)),
    (($C9, $48, $C5, $95), ($57, $24, $F4, $23)),
    (($C0, $1F, $51, $FB), ($BF, $A1, $FA, $03)),
    (($AD, $35, $B3, $2D), ($36, $B5, $76, $C4)),
    (($50, $E0, $35, $5B), ($FE, $DD, $6F, $90)),
    (($E9, $EE, $C0, $DC), ($F9, $C8, $15, $D8)),
    (($19, $6E, $EE, $A6), ($E7, $DB, $6B, $4D)),
    (($C6, $BC, $4A, $01), ($1B, $B8, $06, $14)),
    (($A4, $93, $B3, $3D), ($FC, $A5, $F4, $69)),
    (($D2, $A7, $DE, $C4), ($7D, $79, $3D, $17)),
    (($60, $D6, $8E, $B4), ($9D, $AD, $4A, $5C)),
    (($01, $49, $97, $2D), ($C3, $CD, $AF, $E0)),
    (($1B, $AE, $90, $07), ($BE, $9F, $F6, $79)),
    (($7F, $EC, $D4, $7F), ($BC, $E1, $CB, $68)),
    (($87, $CA, $9F, $37), ($B3, $AC, $62, $39)),
    (($5A, $9E, $7A, $DB), ($DD, $F5, $2E, $8E)),
    (($4A, $38, $A8, $9C), ($2F, $CE, $DE, $5F)),
    (($25, $D1, $A9, $7C), ($13, $44, $3F, $AD)),
    (($1E, $56, $08, $D2), ($13, $7D, $4B, $91)),
    (($05, $2A, $31, $AB), ($5E, $DF, $EF, $26)),
    (($BE, $71, $45, $F4), ($7E, $B7, $72, $D1)),
    (($95, $17, $0F, $9A), ($F9, $E8, $7B, $39)),
    (($D2, $14, $3B, $EF), ($7D, $BF, $47, $A0)),
    (($8D, $EF, $C2, $50), ($FD, $92, $72, $78)),
    (($C4, $81, $A9, $05), ($27, $95, $EC, $89)),
    (($AB, $FC, $EB, $68), ($FF, $DB, $92, $E6)),
    (($CA, $AC, $27, $81), ($BF, $61, $E1, $A5)),
    (($81, $07, $D2, $89), ($B9, $ED, $FB, $34)),
    (($8E, $B7, $80, $88), ($B7, $D5, $26, $D0)),
    (($BD, $E4, $07, $04), ($5B, $B3, $CE, $0E)),
    (($4C, $68, $2B, $CA), ($4D, $47, $55, $17)),
    (($AA, $84, $7A, $3B), ($B7, $F6, $8B, $AE)),
    (($7E, $D1, $74, $E7), ($EC, $3F, $34, $48)),
    (($EB, $79, $EF, $5D), ($61, $A5, $35, $68)),
    (($12, $A6, $BA, $40), ($6A, $BF, $DF, $07)),
    (($D9, $3B, $81, $9E), ($DA, $FD, $5F, $B8)),
    (($FB, $76, $E2, $77), ($F8, $80, $8D, $44)),
    (($E0, $1C, $31, $03), ($65, $AD, $1C, $77)),
    (($08, $7A, $D5, $1C), ($B5, $B3, $17, $C2)),
    (($F0, $67, $5A, $EC), ($FE, $FC, $6C, $0D)),
    (($AA, $03, $70, $30), ($9E, $FD, $5E, $38)),
    (($8A, $9A, $40, $3E), ($9F, $F1, $3F, $76)),
    (($23, $CB, $46, $71), ($FE, $C0, $AF, $ED)),
    (($E9, $C5, $D8, $58), ($1B, $B7, $0A, $AD)),
    (($A1, $99, $A6, $4D), ($A3, $B9, $AD, $7C)),
    (($DD, $CE, $8C, $54), ($E3, $FC, $95, $40)));

  QueryResellerTable: TQueryResellerTable = ((($6F, $2A, $3E, $E4), ($60, $69, $99, $5A)),
    (($3E, $82, $31, $63), ($00, $6A, $D4, $7B)),
    (($FA, $DC, $B4, $66), ($5B, $03, $C9, $CE)),
    (($8E, $8E, $97, $10), ($88, $13, $00, $7E)),
    (($DE, $F7, $8F, $CD), ($52, $A2, $2A, $DA)),
    (($F2, $11, $7E, $8B), ($01, $CA, $42, $DC)),
    (($57, $46, $F4, $28), ($0B, $78, $CA, $BD)),
    (($C2, $85, $F6, $26), ($08, $BA, $80, $C8)),
    (($F7, $94, $FF, $A6), ($03, $EC, $A5, $5E)),
    (($E9, $A8, $45, $94), ($1C, $5C, $A2, $8B)),
    (($62, $EC, $DE, $45), ($45, $BF, $60, $AB)),
    (($89, $C4, $B1, $FB), ($43, $A4, $02, $F2)),
    (($1C, $30, $3E, $25), ($96, $76, $01, $F0)),
    (($6E, $08, $8C, $FB), ($0B, $F5, $00, $5E)),
    (($EA, $DA, $7F, $24), ($C3, $6D, $28, $C8)),
    (($A8, $32, $07, $1F), ($00, $51, $40, $24)),
    (($3E, $18, $97, $E3), ($19, $92, $32, $84)),
    (($D9, $DB, $D9, $C2), ($A1, $0D, $02, $B9)),
    (($8C, $0D, $A0, $93), ($C7, $CA, $9B, $1D)),
    (($E7, $CF, $1E, $10), ($1B, $2A, $90, $64)),
    (($9B, $12, $72, $F6), ($19, $C2, $22, $6A)),
    (($B1, $18, $CD, $DD), ($02, $BC, $82, $4F)),
    (($54, $6F, $4C, $1C), ($09, $7A, $28, $A4)),
    (($A9, $77, $5B, $B7), ($0A, $A8, $00, $D1)),
    (($B7, $EF, $4E, $0B), ($9B, $EC, $D0, $D4)),
    (($76, $BB, $0A, $B3), ($92, $C2, $89, $F4)),
    (($29, $E5, $02, $A9), ($91, $95, $18, $DF)),
    (($EE, $E3, $66, $AD), ($89, $44, $A9, $F2)),
    (($94, $18, $96, $EB), ($5F, $7C, $0A, $29)),
    (($AC, $9D, $DD, $D8), ($22, $03, $92, $B3)),
    (($D0, $D9, $F5, $EB), ($81, $FC, $E2, $99)),
    (($5A, $84, $55, $E8), ($22, $86, $E0, $B2)),
    (($4D, $2E, $0D, $DC), ($00, $D4, $E8, $FC)),
    (($57, $9C, $5E, $58), ($97, $EF, $81, $E8)),
    (($D7, $83, $B9, $56), ($51, $82, $12, $5D)),
    (($EE, $4A, $78, $1C), ($04, $71, $E2, $EA)),
    (($D9, $12, $CB, $64), ($15, $00, $92, $9F)),
    (($7E, $F4, $F5, $B9), ($E1, $E4, $70, $12)),
    (($44, $89, $B8, $24), ($8A, $F4, $92, $C4)),
    (($28, $B0, $0D, $08), ($11, $A6, $80, $27)),
    (($F0, $B5, $C6, $E5), ($03, $94, $82, $0E)),
    (($44, $E7, $E9, $8F), ($09, $20, $42, $F8)),
    (($49, $05, $46, $95), ($03, $A0, $49, $65)),
    (($24, $F3, $40, $9D), ($05, $70, $D0, $26)),
    (($6B, $3F, $3D, $45), ($15, $95, $C0, $85)),
    (($D9, $04, $FC, $1E), ($35, $75, $00, $0D)),
    (($47, $0E, $29, $F8), ($88, $92, $21, $BB)),
    (($D7, $3E, $2E, $61), ($01, $84, $E1, $26)),
    (($73, $30, $4D, $68), ($DB, $22, $75, $86)),
    (($76, $1C, $EB, $A7), ($04, $08, $60, $E4)),
    (($18, $8A, $28, $DC), ($A7, $F8, $D2, $92)),
    (($C3, $F8, $CE, $58), ($08, $B3, $60, $BD)),
    (($44, $D4, $57, $A5), ($3D, $8D, $03, $B8)),
    (($E7, $8F, $82, $56), ($07, $99, $70, $F9)),
    (($83, $EE, $0D, $FD), ($0B, $E0, $30, $B8)),
    (($F3, $AF, $CE, $EE), ($41, $92, $48, $73)),
    (($CA, $6F, $FF, $45), ($01, $10, $4A, $1C)),
    (($43, $CB, $DA, $2A), ($01, $2C, $42, $DF)),
    (($77, $C6, $66, $53), ($64, $8E, $F1, $98)),
    (($D3, $6A, $90, $CB), ($19, $B0, $85, $3A)));

  QueryEndUserTable: TQueryEndUserTable = ((($FC, $84, $B7, $69), ($2A, $63, $39, $8B)),
    (($61, $7F, $80, $21), ($1C, $14, $13, $C2)),
    (($47, $E8, $39, $5C), ($38, $E4, $D6, $4A)),
    (($A4, $E8, $34, $B6), ($79, $29, $3E, $3B)),
    (($F4, $1B, $71, $BD), ($63, $7E, $1C, $02)),
    (($DE, $9E, $65, $A6), ($5E, $B5, $FA, $0E)),
    (($14, $6A, $FB, $3F), ($0B, $A0, $5A, $F1)),
    (($7B, $E0, $D9, $25), ($12, $A8, $BC, $CA)),
    (($8C, $A4, $E4, $37), ($77, $E0, $1D, $D0)),
    (($FA, $AF, $06, $4A), ($F9, $58, $B7, $1E)),
    (($D3, $97, $53, $3C), ($10, $03, $6F, $E0)),
    (($9B, $DB, $ED, $70), ($D8, $B6, $91, $34)),
    (($2C, $DC, $17, $B7), ($34, $7B, $15, $0A)),
    (($51, $C2, $9E, $B0), ($5C, $D9, $DD, $AE)),
    (($F8, $5C, $6D, $B1), ($F7, $30, $7F, $3F)),
    (($ED, $CC, $68, $19), ($64, $B0, $3C, $1B)),
    (($E8, $81, $97, $E2), ($78, $F8, $18, $CB)),
    (($CA, $66, $87, $76), ($00, $0C, $B6, $B5)),
    (($24, $59, $ED, $C4), ($64, $E0, $B5, $20)),
    (($F9, $DF, $8D, $92), ($7C, $EA, $B7, $0A)),
    (($0E, $56, $66, $2F), ($B8, $01, $2E, $17)),
    (($DA, $F5, $C6, $9E), ($40, $C3, $2E, $77)),
    (($25, $92, $B1, $D0), ($84, $21, $F4, $00)),
    (($F5, $2C, $01, $C5), ($53, $82, $3C, $3D)),
    (($9B, $E2, $26, $C5), ($5C, $44, $B8, $08)),
    (($94, $4D, $23, $50), ($7C, $58, $72, $87)),
    (($AE, $13, $D9, $55), ($14, $3D, $3F, $86)),
    (($6B, $B9, $88, $A4), ($5A, $C8, $C9, $6C)),
    (($AA, $B9, $93, $A4), ($EE, $BF, $5C, $E5)),
    (($84, $D5, $83, $49), ($6C, $F0, $3D, $A2)),
    (($38, $27, $90, $26), ($3C, $70, $F5, $D2)),
    (($A3, $5C, $D3, $F7), ($52, $83, $3B, $1B)),
    (($9F, $5D, $2E, $0C), ($56, $0A, $B8, $01)),
    (($33, $6A, $F3, $39), ($0A, $2C, $94, $3A)),
    (($75, $8A, $1D, $62), ($14, $F8, $9F, $A3)),
    (($46, $71, $9B, $86), ($14, $CC, $2F, $0C)),
    (($3C, $A7, $EC, $FC), ($3E, $3A, $FE, $17)),
    (($E0, $E7, $EC, $FD), ($88, $AD, $1F, $2E)),
    (($1A, $C6, $EE, $63), ($5E, $D6, $1B, $21)),
    (($E9, $95, $0A, $B0), ($04, $A0, $57, $B0)),
    (($69, $F1, $4A, $1C), ($4C, $FC, $BC, $BB)),
    (($02, $71, $32, $72), ($20, $F4, $05, $3E)),
    (($19, $20, $83, $A1), ($5A, $E0, $9E, $27)),
    (($66, $ED, $46, $20), ($92, $50, $76, $A9)),
    (($D3, $24, $62, $C8), ($24, $C3, $6E, $BF)),
    (($26, $87, $62, $89), ($12, $22, $97, $9A)),
    (($E1, $A1, $78, $5C), ($5D, $B0, $F5, $2F)),
    (($66, $57, $C2, $78), ($31, $70, $7A, $38)),
    (($5F, $C0, $CD, $C9), ($6C, $53, $FD, $87)),
    (($5D, $37, $58, $9E), ($C8, $08, $5B, $CA)),
    (($20, $28, $14, $F6), ($4D, $B8, $BE, $52)),
    (($52, $6A, $0B, $1A), ($0A, $FB, $CD, $E8)),
    (($02, $3D, $28, $43), ($24, $30, $1F, $73)),
    (($47, $6F, $CF, $D5), ($4C, $58, $37, $06)),
    (($43, $A9, $DA, $CE), ($FA, $0A, $2E, $2C)),
    (($4B, $FC, $E0, $FA), ($75, $A5, $3D, $93)),
    (($47, $BD, $B7, $6A), ($6A, $46, $18, $F7)),
    (($5C, $93, $37, $22), ($F5, $FA, $3C, $66)),
    (($C9, $CE, $41, $12), ($74, $B0, $7B, $D1)),
    (($0F, $FA, $48, $55), ($61, $B0, $7D, $93)));

type
  TRegStage = (Install, Day2, Day60, Day90, Year);

type
  TRegStageInfo = array[Low(TRegStage)..High(TRegStage)] of string;
  TRegStageDays = array[Low(TRegStage)..High(TRegStage)] of integer;

const
  RegStageName: TRegStageInfo = ('Install', 'Day2', 'Day60', 'Day90', 'Year');
  RegStageDays: TRegStageDays = (20, 58, 305, 3, 1);
  { TODO : Change Install Day Back to 2 }
type
  TRegType = (RegNormal, RegReseller, RegMultisite, RegMysqlAccess);

type
  TRegTypeInfo = array[Low(TRegType)..High(TRegType)] of string;
  TRegTypeKeys = array[Low(TRegType)..High(TRegType)] of TKey;

const
  RegTypeName: TRegTypeInfo = ('End User', 'Reseller', 'Multisite', 'MysqlAccess');

  EncryptionKey: TRegTypeKeys = (($F7, $8A, $14, $AF, $93, $C0, $EE, $C1, $D4, $CC, $F7, $AC, $D1, $FC, $AC, $01),
    ($C3, $1F, $A7, $DC, $93, $32, $AB, $C0, $55, $C2, $1A, $B6, $C6, $C4, $CE, $B4),
    ($D2, $2A, $E4, $EB, $93, $F4, $C3, $B8, $FF, $A3, $11, $EE, $D3, $FA, $DF, $EE),
    ($AB, $2F, $DF, $DE, $1E, $65, $1B, $C1, $2E, $AC, $F9, $F0, $B5, $EF, $0C, $D7));

var
  MachineIdentification: string;    // preset this before doing anything else !!!!

function GetCompanyName: string;
function GenerateSerialNumber(const RegStage: TRegStage; const RegType: TRegType): string;
function GenerateRegistration(const ExpirationDate: TDateTime; const SerialNumber: string; const RegType: TRegType): string;
function VerifyRegistration(const SerialNumber: string; const RegistrationCode: string; const RegType: TRegType): string;
function DaysLeft(const SerialNumber: string; const RegistrationCode: string; const RegType: TRegType): integer;

procedure EnCryptRegistrationInformation;
procedure DeCryptRegistrationInformation;
function LineCount(const FileName: string): integer;

procedure GetRegistrationInformation(const RegType: TRegType; var CompanyName, RegistrationCode, SerialNumber, RegStage, MachineID: string);

  //USB Keys
function IsReseller: boolean;
function GetRegistrationDayLeft(const RegType: TRegType): integer;
function CheckMultisiteRegistration(var Message: string): boolean;
function GetPCName: string;
function StatusDesc(const status: word): string;
function KeyInitializeNoMessage: boolean;
function KeyInitialize: boolean;
function KeyGenVaildate: boolean;
function KeyUserVaildate: boolean;
function KeyResellerVaildate: boolean;
procedure CreateInstalledDateRegistry;
function CheckInstalledFor14DayRegistry: boolean;
function RegistrationFileExists: boolean;
function RegistrationOk: boolean;


implementation

{$I ERP.inc}

uses FastFuncs,DnMlib, Math, DateUtils, CommonDbLib, Forms, CommonLib;

const
  RegistrationFile = 'Registration.bin';

var
  APIPacket: RB_SPRO_APIPACKET;  

procedure CreateInstalledDateRegistry;
begin
  with TRegistry.Create do try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('\SOFTWARE\Microsoft\MSSetup', true);
      if not ValueExists('{L3ER4D7-I2RR4-4W3D2-W9W6UBZ3O1FY9}') then begin
        WriteString('{L3ER4D7-I2RR4-4W3D2-W9W6UBZ3O1FY9}', Encrypt(FormatDateTime('dd/mm/yyyy', Now), 'InstalledDate'));
      end;
  finally
    Free;
  end;
end;

function CheckInstalledFor14DayRegistry: boolean;
var
  TempShortDateFormat: string;
  TempStr: string;
  InstallDate: TDateTime;
begin
  Result := true;
  with TRegistry.Create do try
      RootKey := HKEY_LOCAL_MACHINE;
      OpenKey('\SOFTWARE\Microsoft\MSSetup', true);
      if ValueExists('{L3ER4D7-I2RR4-4W3D2-W9W6UBZ3O1FY9}') then begin
        TempStr := ReadString('{L3ER4D7-I2RR4-4W3D2-W9W6UBZ3O1FY9}');
        TempStr := DeCrypt(TempStr, 'InstalledDate');
        TempShortDateFormat := ShortDateFormat;
        ShortDateFormat := 'dd/mm/yyyy';
        InstallDate := StrToDate(TempStr);
        ShortDateFormat := TempShortDateFormat;
        if DaysBetween(Now(), InstallDate) >= 14 then begin
          Result := true;
        end else begin
          Result := false;
        end;
        if IsReseller then begin
          Result := true;
        end;
      end;
    finally
      Free;
    end;
end;


function IsReseller: boolean;
var
  CompanyName, RegistrationCode, SerialNumber, RegStage, MachineID: string;
  VerifyRegistrationResult: string;
  RegType: TRegType;
begin
  if FileExists(ExtractFilePath(Application.ExeName) + RegistrationFile) then begin
    //End User
    RegType := RegNormal;
    GetRegistrationInformation(RegType, CompanyName, RegistrationCode, SerialNumber, RegStage, MachineID);
    //    If ( (MachineID = GetMachineIdentification(False,True,True,True)) OR Empty(MachineID))  Then Begin
    if ((MachineID = MachineIdentification) or Empty(MachineID)) then begin
      VerifyRegistrationResult := VerifyRegistration(SerialNumber, RegistrationCode, RegType);
      if VerifyRegistrationResult = 'Expired' then begin
        Result := false;
      end else if VerifyRegistrationResult = 'Not Valid' then begin
        Result := false;
      end else begin
        Result := true
      end;
    end else begin
      Result := false;
    end;
    if not Result then begin
      //Reseller
      RegType := RegReseller;
      GetRegistrationInformation(RegType, CompanyName, RegistrationCode, SerialNumber, RegStage, MachineID);
      //      If (MachineID = GetMachineIdentification(False,True,True,True)) Then Begin
      if (MachineID = MachineIdentification) then begin
        VerifyRegistrationResult := VerifyRegistration(SerialNumber, RegistrationCode, RegType);
        if VerifyRegistrationResult = 'Expired' then begin
          Result := false;
        end else if VerifyRegistrationResult = 'Not Valid' then begin
          Result := false;
        end else begin
          Result := true
        end;
      end else begin
        Result := false;
      end;
    end else begin
      Result := false;
    end;
  end else begin
    Result := false;
  end;
end;

function LineCount(const FileName: string): integer;
var
  Count: integer;
  F: TextFile;
begin
  Count := 0;
  if not FileExists(FileName) then begin
    Result := 0;
    Exit;
  end;
  AssignFile(F, FileName);
  try
    {$I-}
    Reset(F);
    {$I+}
    IOResult;
    while not Eof(F) do begin
      Readln(F);
      Inc(Count);
    end;
    CloseFile(F);
    Result := Count;
  except
    CommonLib.MessageDlgXP_Vista('File is Already in Use!', mtError, [mbOK], 0);
    Result := 0;
  end;
end;

procedure EnCryptRegistrationInformation;
var
  R: TextFile;
  NewFile: TStringList;
  LINESTRING: string;
  I, Count: integer;
  FileLinesCount: integer;
begin
  if not FileExists(ExtractFilePath(Application.ExeName) + RegistrationFile) then begin
    Exit;
  end;
  NewFile := TStringList.Create;
  FileLinesCount := LineCount(ExtractFilePath(Application.ExeName) + RegistrationFile);
  AssignFile(R, ExtractFilePath(Application.ExeName) + RegistrationFile);
  try
    {$I-}
    Reset(R);
    {$I+}
    IOResult;
    Count := FileLinesCount;
    for I := 1 to Count do begin
      Readln(R, LINESTRING);
      LINESTRING := FastFuncs.Trim(LINESTRING);
      if not empty(LINESTRING) then begin
        NewFile.Add(EnCrypt(LINESTRING, 'yz'));
      end;
    end;
  finally
    CloseFile(R);
    Erase(R);
    NewFile.SaveToFile(ExtractFilePath(Application.ExeName) + RegistrationFile);
    FreeAndNil(NewFile);
    Sleep(50);
  end;
end;

procedure DeCryptRegistrationInformation;
var
  R: TextFile;
  NewFile: TStringList;
  LINESTRING: string;
  I, Count: integer;
  FileLinesCount: integer;
begin
  if not FileExists(ExtractFilePath(Application.ExeName) + RegistrationFile) then begin
    Exit;
  end;
  NewFile := TStringList.Create;
  FileLinesCount := LineCount(ExtractFilePath(Application.ExeName) + RegistrationFile);
  AssignFile(R, ExtractFilePath(Application.ExeName) + RegistrationFile);
  try
    {$I-}
    Reset(R);
    {$I+}
    IOResult;
    Count := FileLinesCount;
    for I := 1 to Count do begin
      Readln(R, LINESTRING);
      LINESTRING := FastFuncs.Trim(LINESTRING);
      if not empty(LINESTRING) then begin
        NewFile.Add(DeCrypt(LINESTRING, 'yz'));
      end;
    end;
  finally
    CloseFile(R);
    Erase(R);
    NewFile.SaveToFile(ExtractFilePath(Application.ExeName) + RegistrationFile);
    FreeAndNil(NewFile);
    Sleep(50);
  end;
end;

function KeyGenVaildate: boolean;
var
  Error: word;
  Response32: longint;
  QueryStr, ResponseStr: TQueryStr;
  TableIndex, Index: integer;
  Compare: boolean;
  NumSubLic: Pointer;
begin
  //Key Generator Security Key
  Randomize;
  Result := true;
{$IFDEF DevMode}
  Exit;
{$ENDIF}  
  TableIndex := Random(10) + 1;

  QueryStr := QueryKeyGenTable[TableIndex, 1];
  Error := SproQuery(@APIPacket, 18, @QueryStr, @ResponseStr, Response32, 4);
  if Error <> SP_SUCCESS then begin
    CommonLib.MessageDlgXP_Vista(StatusDesc(Error), mtInformation, [mbOK], 0);
    Exit;
  end;

  NumSubLic := nil;
  Error := SproReleaseLicense(@APIPacket, 0, NumSubLic);
  if Error <> SP_SUCCESS then begin
    CommonLib.MessageDlgXP_Vista(StatusDesc(Error), mtInformation, [mbOK], 0);
  end;

  Compare := true;
  for Index := 1 to 4 do Compare := Compare and (ResponseStr[Index] = QueryKeyGenTable[TableIndex, 2, Index]);

  if not Compare then begin
    CommonLib.MessageDlgXP_Vista('Incorrect USB Key Found - Insert ERP USB Key', mtInformation, [mbOK], 0);
    Result := false;
  end;
end;

function KeyResellerVaildate: boolean;
var
  Error: word;
  Response32: longint;
  QueryStr, ResponseStr: TQueryStr;
  TableIndex, Index: integer;
  Compare: boolean;
  NumSubLic: Pointer;
begin
  //Reseller Security Key
  Randomize;
  Result := true;
{$IFDEF DevMode}
  Exit;
{$ENDIF}  
  TableIndex := Random(60) + 1;

  QueryStr := QueryResellerTable[TableIndex, 1];
  Error := SproQuery(@APIPacket, 50, @QueryStr, @ResponseStr, Response32, 4);
  if Error <> SP_SUCCESS then begin
    CommonLib.MessageDlgXP_Vista(StatusDesc(Error), mtInformation, [mbOK], 0);
    Exit;
  end;

  NumSubLic := nil;
  Error := SproReleaseLicense(@APIPacket, 0, NumSubLic);
  if Error <> SP_SUCCESS then begin
    CommonLib.MessageDlgXP_Vista(StatusDesc(Error), mtInformation, [mbOK], 0);
  end;

  Compare := true;
  for Index := 1 to 4 do Compare := Compare and (ResponseStr[Index] = QueryResellerTable[TableIndex, 2, Index]);

  if not Compare then begin
    CommonLib.MessageDlgXP_Vista('Incorrect USB Key Found - Insert ERP USB Key', mtInformation, [mbOK], 0);
    Result := false;
  end;         
end;

function KeyUserVaildate: boolean;
var
  Error: word;
  Response32: longint;
  QueryStr, ResponseStr: TQueryStr;
  TableIndex, Index: integer;
  Compare: boolean;
  NumSubLic: Pointer;
begin
  //End User Security Key
  Randomize;
  Result := true;
{$IFDEF DevMode}
  Exit;
{$ENDIF}
  TableIndex := Random(60) + 1;

  QueryStr := QueryEndUserTable[TableIndex, 1];
  Error := SproQuery(@APIPacket, 36, @QueryStr, @ResponseStr, Response32, 4);
  if Error <> SP_SUCCESS then begin
    CommonLib.MessageDlgXP_Vista(StatusDesc(Error), mtInformation, [mbOK], 0);
    Exit;
  end;

  NumSubLic := nil;
  Error := SproReleaseLicense(@APIPacket, 0, NumSubLic);
  if Error <> SP_SUCCESS then begin
    CommonLib.MessageDlgXP_Vista(StatusDesc(Error), mtInformation, [mbOK], 0);
  end;

  Compare := true;
  for Index := 1 to 4 do Compare := Compare and (ResponseStr[Index] = QueryEndUserTable[TableIndex, 2, Index]);

  if not Compare then begin
    CommonLib.MessageDlgXP_Vista('Incorrect USB Key Found - Insert ERP USB Key', mtInformation, [mbOK], 0);
    Result := false;
  end;
end;
         
function KeyInitializeNoMessage: boolean;   
var
  Error: word;
  PC_Name: PChar;
begin

{$IFDEF DevMode}
  Result := True;
  Exit;  
{$ELSE}
  Result := false;
{$ENDIF}
  //Set the packet Size
  Error := SproFormatPacket(@APIPacket, RB_SPRO_APIPACKET_SIZE);
  if Error <> SP_SUCCESS then begin
    Exit;
  end;

  //Initialize the packet
  Error := SproInitialize(@APIPacket);
  if Error <> SP_SUCCESS then begin
    Exit;
  end;

  // Contact Server
  PC_Name := PChar(GetPCName);
  Error := SproSetContactServer(@APIPacket, PC_Name);
  if Error <> SP_SUCCESS then begin
    Exit;
  end;

  //Check for the presence Of Key
  Error := SproFindFirstUnit(@APIPacket, $1801);
  if Error <> SP_SUCCESS then begin
    Exit;
  end;
  Result := true;
end;


function KeyInitialize: boolean;
var
  Error: word;
  PC_Name: PChar;
begin
{$IFDEF DevMode}
  Result := True;
  Exit;  
{$ELSE}
  Result := false;
{$ENDIF}
  //Set the packet Size
  Error := SproFormatPacket(@APIPacket, RB_SPRO_APIPACKET_SIZE);
  if Error <> SP_SUCCESS then begin
    CommonLib.MessageDlgXP_Vista(StatusDesc(Error), mtInformation, [mbOK], 0);
    Exit;
  end;

  //Initialize the packet
  Error := SproInitialize(@APIPacket);
  if Error <> SP_SUCCESS then begin
    CommonLib.MessageDlgXP_Vista(StatusDesc(Error), mtInformation, [mbOK], 0);
    Exit;
  end;

  // Contact Server
  PC_Name := PChar(GetPCName);
  Error := SproSetContactServer(@APIPacket, PC_Name);
  if Error <> SP_SUCCESS then begin
    CommonLib.MessageDlgXP_Vista(StatusDesc(Error), mtInformation, [mbOK], 0);
    Exit;
  end;

  //Check for the presence Of Key
  Error := SproFindFirstUnit(@APIPacket, $1801);
  if Error <> SP_SUCCESS then begin
    CommonLib.MessageDlgXP_Vista(StatusDesc(Error), mtInformation, [mbOK], 0);
    Exit;
  end;
  Result := true;
end;


function StatusDesc(const status: word): string;
begin
  case (status and $FF) of
    SP_UNIT_NOT_FOUND: Result := 'No USB Key Found  -  Please Insert ERP USB Key';
    else Result := FastFuncs.IntToStr(status and $FF) + ' - ERP Key Error';
  end;
end;

function GetPCName: string;
var
  Buffer: array[0..MAX_COMPUTERNAME_LENGTH] of char;
  nSize: cardinal;
begin
  nSize := SizeOf(Buffer);
  GetComputerName(Buffer, nSize);
  Result := Buffer;
end;

function GetCompanyName: string;
var
  qryTemp: TERPQuery;
begin
  qryTemp := TERPQuery.Create(nil);
  qryTemp.Options.FlatBuffers := True;
  qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qryTemp.Sql.Add('SELECT CompanyName FROM tblcompanyinformation WHERE SetupID =1;');
    qryTemp.Active := true;
    if not qryTemp.IsEmpty then begin
      Result := qryTemp.FieldByName('CompanyName').AsString;
    end else begin
      Result := '';
    end;
  finally
    FreeAndNil(qryTemp);
  end;
end;

function GenerateSerialNumber(const RegStage: TRegStage; const RegType: TRegType): string;
begin
  Randomize;
  if RegStage = Install then begin
    Result := FastFuncs.IntToStr(RandomRange(100000000, 200000000));
  end else if RegStage = Day2 then begin
    Result := FastFuncs.IntToStr(RandomRange(200000000, 400000000));
  end else if RegStage = Day60 then begin
    Result := FastFuncs.IntToStr(RandomRange(400000000, 600000000));
  end else if RegStage = Day90 then begin
    Result := FastFuncs.IntToStr(RandomRange(600000000, 800000000));
  end else if RegStage = Year then begin
    Result := FastFuncs.IntToStr(RandomRange(800000000, 1000000000));
  end;
  if (RegType = RegReseller) then begin
    Result := FastFuncs.IntToStr(RandomRange(600000000, 800000000));
  end;
end;

function GenerateRegistration(const ExpirationDate: TDateTime; const SerialNumber: string; const RegType: TRegType): string;
var
  Key: TKey;
  Code: TCode;
  Modifier: longint;
begin
  Key := EncryptionKey[RegType];
  Modifier := StringHashELF(SerialNumber);
  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));
  InitRegCode(Key, '', ExpirationDate, Code);
  Result := BufferToHex(Code, SizeOf(Code));
end;

function VerifyRegistration(const SerialNumber, RegistrationCode: string; const RegType: TRegType): string;
var
  Key: TKey;
  Code: TCode;
  Modifier: longint;
begin
  Key := EncryptionKey[RegType];
  Modifier := StringHashELF(SerialNumber);
  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));
  HexToBuffer(RegistrationCode, Code, SizeOf(Code));
  if IsRegCodeValid(Key, Code) then begin
    if IsRegCodeExpired(Key, Code) then begin
      Result := 'Expired';
    end else begin
      Result := 'Valid';
    end;
  end else Result := 'Not Valid';
end;

function DaysLeft(const SerialNumber: string; const RegistrationCode: string; const RegType: TRegType): integer;
var
  Key: TKey;
  Code: TCode;
  Modifier: longint;
  ExpiredDate: TDateTime;
begin
  Key := EncryptionKey[RegType];
  Modifier := StringHashELF(SerialNumber);
  ApplyModifierToKeyPrim(Modifier, Key, SizeOf(Key));
  HexToBuffer(RegistrationCode, Code, SizeOf(Code));
  ExpiredDate := GetExpirationDate(Key, Code);
  Result := Trunc(ExpiredDate - Date);
end;


  //procedure SaveRegistrationInformation (const CompanyName : String; const RegType : TRegType; const RegistrationCode : String;
  //                                       const SerialNumber : String; const RegStage : String; const MachineID : String);
  //var
  //  RegIni: TMemIniFile;
  //begin
  //  DeCryptRegistrationInformation;
  //  RegIni:= TMemIniFile.Create(ExtractFilePath(Application.ExeName) + RegistrationFile);
  //  Try
  //    RegIni.WriteString(RegTypeName[RegType],'CompanyName', CompanyName);
  //    RegIni.WriteString(RegTypeName[RegType],'RegistrationCode', RegistrationCode);
  //    RegIni.WriteString(RegTypeName[RegType],'SerialNumber',  SerialNumber);
  //    If (RegType=RegMultisite) then Begin
  //      RegIni.WriteString(RegTypeName[RegType],'RegStage', 'Year');
  //    end else Begin
  //      RegIni.WriteString(RegTypeName[RegType],'RegStage', RegStage);
  //    end;
  //    RegIni.WriteString(RegTypeName[RegType],'MachineID', MachineID);
  //    RegIni.UpdateFile;
  //  finally
  //    RegIni.Free;
  //  end;
  //  EnCryptRegistrationInformation;
  //  PrintRegistrationInformation(RegStage);
  //end;


procedure GetRegistrationInformation(const RegType: TRegType; var CompanyName, RegistrationCode, SerialNumber, RegStage, MachineID: string);
var
  RegIni: TMemIniFile;
begin
  DeCryptRegistrationInformation;
  RegIni := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + RegistrationFile);
  try
    CompanyName      := RegIni.ReadString(RegTypeName[RegType], 'CompanyName', '');
    RegistrationCode := RegIni.ReadString(RegTypeName[RegType], 'RegistrationCode', '');
    SerialNumber     := RegIni.ReadString(RegTypeName[RegType], 'SerialNumber', '');
    RegStage         := RegIni.ReadString(RegTypeName[RegType], 'RegStage', '');
    MachineID        := RegIni.ReadString(RegTypeName[RegType], 'MachineID', '');
  finally
    FreeAndNil(RegIni);
  end;
  EnCryptRegistrationInformation;
end;

function CheckRegistrationInformationOk(const RegType: TRegType; var Message: string; var RegStage: string): boolean;
var
  CompanyName, RegistrationCode, SerialNumber, MachineID: string;
  VerifyRegistrationResult: string;
begin
  Result := true;
  //Is Reg file There
  if FileExists(ExtractFilePath(Application.ExeName) + RegistrationFile) then begin
    //Is Reg Correct
    GetRegistrationInformation(RegType, CompanyName, RegistrationCode, SerialNumber, RegStage, MachineID);
    //    If ( (MachineID = GetMachineIdentification(False,True,True,True)) OR Empty(MachineID))  Then Begin
    if ((MachineID = MachineIdentification) or Empty(MachineID)) then begin
      VerifyRegistrationResult := VerifyRegistration(SerialNumber, RegistrationCode, RegType);
      if VerifyRegistrationResult = 'Expired' then begin
        //Reg Expired
        Message := 'Registration Has Expired';
        Result := false;
      end else if VerifyRegistrationResult = 'Not Valid' then begin
        //Reg Not Valid
        Message := 'Registration Not Valid';
        Result := false;
      end else begin
        //Reg Valid {It's All Good}
      end;
    end else begin
      //Not Same Machines reg Info
      Message := 'ERP Has Detected Registration From a Different PC';
      Result := false;
    end;
  end else begin
    //No Reg file
    Message := 'Please Register ERP !';
    Result  := false;
  end;
end;

function GetRegistrationDayLeft(const RegType: TRegType): integer;
var
  CompanyName, RegistrationCode, SerialNumber, RegStage, MachineID: string;
begin
  Result := 0;
  //Is Reg file There
  if FileExists(ExtractFilePath(Application.ExeName) + RegistrationFile) then begin
    //Is Reg Correct
    GetRegistrationInformation(RegType, CompanyName, RegistrationCode, SerialNumber, RegStage, MachineID);
    //    If (MachineID = GetMachineIdentification(False,True,True,True)) Then Begin
    if (MachineID = MachineIdentification) then begin
      Result := DaysLeft(SerialNumber, RegistrationCode, RegType);
    end;
  end;
end;

function CheckMultisiteRegistration(var Message: string): boolean;
var
  VerifyRegistrationResult, CompanyName, RegistrationCode, SerialNumber, RegStage, MachineID: string;
  RegType: TRegType;
begin
  Result := true;
  //Is Reg file There
  if FileExists(ExtractFilePath(Application.ExeName) + RegistrationFile) then begin
    //Is Reg Correct
    RegType := RegMultisite;
    GetRegistrationInformation(RegType, CompanyName, RegistrationCode, SerialNumber, RegStage, MachineID);
    //    If ( (MachineID = GetMachineIdentification(False,True,True,True)) OR Empty(MachineID)) Then Begin
    if ((MachineID = MachineIdentification) or Empty(MachineID)) then begin
      VerifyRegistrationResult := VerifyRegistration(SerialNumber, RegistrationCode, RegType);
      if VerifyRegistrationResult = 'Expired' then begin
        //Reg Expired
        Message := 'Multisite Registration Has Expired';
        Result := false;
      end else if VerifyRegistrationResult = 'Not Valid' then begin
        //Reg Not Valid
        Message := 'Multisite Registration Not Valid';
        Result := false;
      end else begin
        //Reg Valid {It's All Good}
      end;
    end else begin
      //Not Same Machines reg Info
      Message := 'ERP Has Detected Registration From a Different PC';
      Result := false;
    end;
  end else begin
    //No Reg file
    Message := 'Please Register ERP Multisite !';
    Result  := false;
  end;
end;

function RegistrationFileExists: boolean;
begin
  Result := FileExists(ExtractFilePath(Application.ExeName) + RegistrationFile);
end;

function RegistrationOk: boolean;
var
  ResturnedRegStage, DisplayMessage: string;
begin
  Result := false;
  if CheckRegistrationInformationOk(RegNormal, DisplayMessage, ResturnedRegStage) then begin
    Result := true;
    Exit;
  end;
  if CheckRegistrationInformationOk(RegReseller, DisplayMessage, ResturnedRegStage) then begin
    Result := true;
    Exit;
  end;
end;

end.


