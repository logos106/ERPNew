unit DbSharedObjectsObj;

interface

uses
  ERPDbComponents, MyAccess, Contnrs, SyncObjs , MyScript;

type
  TDbSharedObj = class
  private
    fList: TObjectList;
    fLock: TCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    function GetQuery(aConn: TCustomMyConnection): TERPQuery;Overload;
    function GetMyScript(aConn: TCustomMyConnection): TMyScript;Overload;
    function GetQuery(aConn: TCustomMyConnection; strSQL:String): TERPQuery;Overload;
    function GetScript(aConn: TCustomMyConnection): TERPScript;
    function GetCommand(aConn: TCustomMyConnection): TERPCommand;
    procedure ReleaseObj(aDbObj: TObject);
    function GetClassQuery(aConn: TCustomMyConnection; ClassIDs:String; ActiveclassesOnly:Boolean = False): TERPQuery;
  end;

  TDbSharedObjItem = class(TObject)
  private
    fInUse: boolean;
    fDbObj: TObject;
  public
    constructor Create;
    destructor Destroy; override;
    property InUse: boolean read fInUse write fInUse;
    property DbObj: TObject read fDbObj write fDbObj;
  end;


  function DbSharedObj: TDbSharedObj;

implementation

uses
  classes, sysutils;

var
  fDbSharedObj: TDbSharedObj;

function DbSharedObj: TDbSharedObj;
begin
  if not Assigned(fDbSharedObj) then
    fDbSharedObj := TDbSharedObj.Create;
  result := fDbSharedObj;
end;


{ TDbSharedObjItem }

constructor TDbSharedObjItem.Create;
begin
  fInUse := false;
end;

destructor TDbSharedObjItem.Destroy;
begin
  try
    fDbObj.Free;
  except
  end;
  inherited;
end;

{ TDbSharedObj }

constructor TDbSharedObj.Create;
begin
  fLock := TCriticalSection.Create;
  fList := TObjectList.Create(true);
end;

destructor TDbSharedObj.Destroy;
begin
  try
    fList.Free;
  except
  end;
  fLock.Free;
  inherited;
end;

function TDbSharedObj.GetCommand(aConn: TCustomMyConnection): TERPCommand;
var
  x: integer;
  item: TDbSharedObjItem;
begin
  item := nil;
  fLock.Acquire;
  try
    for x := 0 to fList.Count -1 do begin
      if (not TDbSharedObjItem(fList[x]).InUse) and (TDbSharedObjItem(fList[x]).DbObj is TERPCommand) then begin
        item := TDbSharedObjItem(fList[x]);
        break;
      end;
    end;
    if not assigned(item) then begin
      item := TDbSharedObjItem.Create;
      item.DbObj := TERPCommand.Create(nil);
      fList.Add(item);
    end;
    item.InUse := true;
    result := TERPCommand(item.DbObj);
    result.SQL.Clear;
    result.Connection := aConn;
  finally
    fLock.Release;
  end;
end;

function TDbSharedObj.GetQuery(aConn: TCustomMyConnection;strSQL: String): TERPQuery;
begin
  result :=GetQuery(aConn);
  result.SQL.text := strSQL;
  result.open;
end;
function TDbSharedObj.GetClassQuery(aConn: TCustomMyConnection; ClassIDs:String; ActiveclassesOnly:Boolean = False): TERPQuery;
begin
  result :=GetQuery(aConn);
  result.SQL.text := 'Select ClassID, classname from tblclass ';
  if ActiveclassesOnly then result.SQL.add(' where Active ="T"') else result.SQL.add(' Where Active in ("T","F")');
  if (ClassIDs <> '') and (trim(ClassIDs) <> '0') then result.SQL.add(' and ClassID in (' +ClassIDs +')');
  result.open;
end;
function TDbSharedObj.GetQuery(aConn: TCustomMyConnection): TERPQuery;
var
  x: integer;
  item: TDbSharedObjItem;
begin
  item := nil;
  fLock.Acquire;
  try
    for x := 0 to fList.Count -1 do begin
      if (not TDbSharedObjItem(fList[x]).InUse) and (TDbSharedObjItem(fList[x]).DbObj is TERPQuery) then begin
        item := TDbSharedObjItem(fList[x]);
        break;
      end;
    end;
    if not assigned(item) then begin
      item := TDbSharedObjItem.Create;
      item.DbObj := TERPQuery.Create(nil);
      fList.Add(item);
    end;
    item.InUse := true;
    result := TERPQuery(item.DbObj);
    if result.Active then result.Close;
    result.SQL.Clear;
    result.Connection := aConn;
  finally
    fLock.Release;
  end;
end;

function TDbSharedObj.GetMyScript(aConn: TCustomMyConnection): TMyScript;
var
  x: integer;
  item: TDbSharedObjItem;
begin
  item := nil;
  fLock.Acquire;
  try
    for x := 0 to fList.Count -1 do begin
      if (not TDbSharedObjItem(fList[x]).InUse) and (TDbSharedObjItem(fList[x]).DbObj is TMyScript) then begin
        item := TDbSharedObjItem(fList[x]);
        break;
      end;
    end;
    if not assigned(item) then begin
      item := TDbSharedObjItem.Create;
      item.DbObj := TMyScript.Create(nil);
      fList.Add(item);
    end;
    item.InUse := true;
    result := TMyScript(item.DbObj);
    result.SQL.Clear;
    result.Connection := aConn;
  finally
    fLock.Release;
  end;
end;

function TDbSharedObj.GetScript(aConn: TCustomMyConnection): TERPScript;
var
  x: integer;
  item: TDbSharedObjItem;
begin
  item := nil;
  fLock.Acquire;
  try
    for x := 0 to fList.Count -1 do begin
      if (not TDbSharedObjItem(fList[x]).InUse) and (TDbSharedObjItem(fList[x]).DbObj is TERPScript) then begin
        item := TDbSharedObjItem(fList[x]);
        break;
      end;
    end;
    if not assigned(item) then begin
      item := TDbSharedObjItem.Create;
      item.DbObj := TERPScript.Create(nil);
      fList.Add(item);
    end;
    item.InUse := true;
    result := TERPScript(item.DbObj);
    result.SQL.Clear;
    result.Connection := aConn;
  finally
    fLock.Release;
  end;
end;

procedure TDbSharedObj.ReleaseObj(aDbObj: TObject);
var
  x: integer;
  item: TDbSharedObjItem;
begin
  fLock.Acquire;
  try
    item := nil;
    for x := 0 to fList.Count -1 do begin
      if TDbSharedObjItem(fList[x]).DbObj = aDbObj then begin
        item := TDbSharedObjItem(fList[x]);
        break;
      end;
    end;
    if Assigned(item) then begin
      item.InUse := false;
      if item.DbObj is TERPQuery then begin
        if TERPQuery(item.DbObj).Active then TERPQuery(item.DbObj).Close;
        TERPQuery(item.DbObj).SQL.Clear;
        TERPQuery(item.DbObj).filter := '';
        TERPQuery(item.DbObj).Filtered :=False;
        TERPQuery(item.DbObj).Connection := nil;
      end
      else if item.DbObj is TMyScript then begin
        TMyScript(item.DbObj).SQL.Clear;
        TMyScript(item.DbObj).Connection := nil;
        TMyScript(item.DbObj).OnError := nil;
        TMyScript(item.DbObj).BeforeExecute := nil;
      end
      else if item.DbObj is TERPScript then begin
        TERPScript(item.DbObj).SQL.Clear;
        TERPScript(item.DbObj).Connection := nil;
        TERPScript(item.DbObj).OnError := nil;
        TERPScript(item.DbObj).BeforeExecute := nil;
      end
      else if item.DbObj is TERPCommand then begin
        TERPCommand(item.DbObj).SQL.Clear;
        TERPCommand(item.DbObj).Connection := nil;
      end;
    end;
  finally
    fLock.Release;
  end;
end;

{var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

var
  scr :TERPScript;
begin
  inherited;
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    scr.Execute;
  finally
    DbSharedObj.ReleaseObj(scr);
  end;

var
  cmd :TERPCommand;
begin
  inherited;
  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;

}
Initialization

Finalization
  fDbSharedObj.Free;

end.
