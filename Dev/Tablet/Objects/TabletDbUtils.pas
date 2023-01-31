unit TabletDbUtils;

interface

const
  TabletDb_Dll = 'TabletDb.dll';


function OpenDatabase(const DbFileName: PChar): boolean; stdcall; external TabletDb_Dll;

function CloseDatabase: boolean; stdcall; external TabletDb_Dll;

function Save(
  const ObjectType: PChar;
  const ErpID: integer;
  const msTimeStamp: TDateTime;
  const msUpdateSiteCode: PChar;
  const Data: PChar;
  const ApiID: integer): integer; stdcall; external TabletDb_Dll;

implementation


end.
