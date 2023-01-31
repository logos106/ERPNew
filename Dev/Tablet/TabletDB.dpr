library TabletDB;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  datTabletDllDb in 'Objects\datTabletDllDb.pas' {DataModule1: TDataModule};

{$R *.res}

function OpenDatabase(const DbFileName: PChar): boolean; stdcall;
begin
  if not Assigned(Db) then
    Db := TDataModule1.Create(nil)
  else
    Db.CloseDatabase;
  result := Db.OpenDatabase(DbFileName);
end;

function CloseDatabase: boolean; stdcall;
begin
  result := true;
  if Assigned(Db) then begin
    Db.CloseDatabase;
    FreeAndNil(Db);
  end;
end;

function Save(
  const ObjectType: PChar;
  const ErpID: integer;
  const msTimeStamp: TDateTime;
  const msUpdateSiteCode: PChar;
  const Data: PChar;
  const ApiID: integer): integer; stdcall;
begin
  result := 0;
  if Assigned(Db) then begin
    result := Db.Save(ObjectType,ErpID,msTimeStamp,msUpdateSiteCode,Data,ApiID);
  end;
end;


exports
  OpenDatabase,
  CloseDatabase,
  Save;

begin
end.
