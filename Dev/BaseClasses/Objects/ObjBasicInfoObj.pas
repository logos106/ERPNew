unit ObjBasicInfoObj;

interface

uses
  Classes, BusObjBase;

type

  TObjBasicInfoClass = class of TObjBasicInfo;
  TObjBasicInfo = class(TPersistent)
  private
    fMsUpdateSiteCode: string;
    fMsTimeStamp: TDateTime;
    fID: integer;
//    DatasetBusObjClass: TDatasetBusObjClass;
  public
    constructor Create(const aClassName: string; aID: integer);
  published
    property ID: integer read fID;
    property MsTimeStamp: TDateTime read fMsTimeStamp;
    property MsUpdateSiteCode: string read fMsUpdateSiteCode;
  end;

implementation

uses
  SysUtils, DbSharedObjectsObj, CommonDBLib, ERPDbComponents;

{ TObjBasicInfo }

constructor TObjBasicInfo.Create(const aClassName: string; aID: integer);
var
  PersistentClass: TPersistentClass;
  TableName: string;
  IDFieldName: string;
  qry: TERPQuery;
begin
  inherited Create;
  PersistentClass := FindClass(aClassName);
  if not Assigned(PersistentClass) then
    raise Exception.Create('Error - Object class "' + aClassName + '" not found.');

  if PersistentClass.InheritsFrom(TDatasetBusObj) then begin
    TableName := TDatasetBusObjClass(PersistentClass).GetBusObjectTablename;
    IDFieldName := TDatasetBusObjClass(PersistentClass).GetIDField;
    if TableName = '' then
      raise Exception.Create('Error - Could not get table name for object "' + aClassName + '".');
    if IDFieldName = '' then
      raise Exception.Create('Error - Could not get ID Field name for object "' + aClassName + '".');
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      qry.SQL.Add('Select MsTimeStamp, MsUpdateSiteCode from ' + TableName);
      qry.SQL.Add('where ' + IDFieldName + ' = ' + IntToStr(aID));
      qry.Open;
      fID := aID;
      fMsTimeStamp := qry.FieldByName('MsTimeStamp').AsDateTime;
      fMsUpdateSiteCode := qry.FieldByName('MsUpdateSiteCode').AsString;
    finally
      DbSharedObj.ReleaseObj(qry);
    end;
  end
  else
    raise Exception.Create('Error - Object class "' + aClassName + '" wrong type.');
end;

initialization
  RegisterClass(TObjBasicInfo);


end.
