unit DbBackupUtils;

interface

type
  TDbBackupUtils = class
  public
    class function AddBackupNameSuffix(aName, aVersion: string): string;
    class function ExtractBackupTime(aBackupName: string): TDateTime;
    class function NumberOfParts(aBackupTxtName: string): integer;
  end;

implementation

(*  NOTE - backup name format is as follows
  tablet_sample_company_15.2.7.0_Backup_2015-12-20_00-08.zip
*)

uses
  SysUtils, StrUtils, Classes;

const
  BACKUP_NAME_TIME_FORMAT = 'yyyy-mm-dd_hh-nn';

{ TDbBackupUtils }

class function TDbBackupUtils.AddBackupNameSuffix(aName, aVersion: string): string;
begin
  result := aName + '_' + aVersion + '_Backup_' + FormatDateTime(BACKUP_NAME_TIME_FORMAT,now);
end;

class function TDbBackupUtils.ExtractBackupTime(aBackupName: string): TDateTime;
var
  s: string;
begin
  s := ChangeFileExt(aBackupName,'');
  s := RightStr(s,Length(BACKUP_NAME_TIME_FORMAT));
  result := EncodeDate(
    StrToInt(Copy(s,1,4)),
    StrToInt(Copy(s,6,2)),
    StrToInt(Copy(s,9,2))
  ) +
  EncodeTime(
    StrToInt(Copy(s,12,2)),
    StrToInt(Copy(s,15,2)),
    0,
    0
  )
end;

class function TDbBackupUtils.NumberOfParts(aBackupTxtName: string): integer;
var
  sl: TStringList;
  x: integer;
  s: string;
begin
  result := 0;
  sl := TStringList.Create;
  try
    sl.LoadFromFile(aBackupTxtName);
    for x := 0 to sl.Count -1 do begin
      s := sl[x];
      if Pos('this backup consists of',Lowercase(s)) > 0 then begin
        s := StringReplace(s,'this backup consists of','',[rfIgnoreCase]);
        s := StringReplace(s,'archive file(s).','',[rfIgnoreCase]);
        result := StrToInt(Trim(s));
        exit;
      end;
    end;
  finally
    sl.Free;
  end;
end;

end.
