unit AccessLevelObj;

{ML 07/2002 - This object implements a true singleton pattern. The developer will get an
access violation if he/she tries to explicitly create the object, therefore, you should
use the class function instance. This will give you all the functionality required.

USAGE : Simply put the unit name in your uses clause and reference the relevant method through
the Instance method, e.g. AppEnv.AccessLevels.GetFormDescription('Blah blah')}

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 18/04/05  1.00.01 IJB  Changed GetEmployeeAccessLevel to return 6 (no access)
  //                        if not found.
  // 19/12/05  1.00.02 AL   Chenged from TAccessLevelObj = class(TObject)
  //                                  to TAccessLevelObj = class(TPersistent)
  //                                RegisterClass only works with TPersistent


interface
{$I ERP.inc}
uses
  Classes, MyAccess,ERPdbComponents, Contnrs;

type
  TAccessRec = class(TObject)
  private
    fFormID: integer;
    fFormName: string;
    fDescription: string;
  public
    constructor Create;
    property FormID: integer read fFormID write fFormID;
    property FormName: string read fFormName write fFormName;
    property Description: string read fDescription write fDescription;
  end;

type
  TAccessLevelObj = class(TObject)
  private
    flstAccessLevels: TObjectList;
    procedure PopulateList(Const qry: TERPQuery);
    function VS1AdminemployeeId: Integer;
  public
    RightsAliasList: TStringList;
    constructor Create;
    destructor Destroy; override;
    function GetFormDescription(const FormName: string): string;Overload;
    function GetFormDescription(const FormID: Integer): string;Overload;
    function GetFormID(const FormName: string): integer;
    function GetAccessLevelsFormID(const FormName: string): integer;
    function GetFormTabGroupID(const FormName: string): integer;
    function GetEmployeeAccessLevel(const FormName: string; const EmployeeID: integer = 0): integer;
    function GetBusobjAccessLevel(const BusObjName: string; const EmployeeID: integer = 0): integer;
    function GetAccessLevelDescription(const AccessLevel: integer): string;

  end;

implementation

uses
  Forms, CommonDbLib, SYSUtils, CommonLib, AppEnvironment, tcConst, WebApiConst,
  utVS1Const,utCloudconst, tcDataUtils, LogLib;

constructor TAccessLevelObj.Create;
var
  qryAccessLevels: TERPQuery;
begin
  inherited;
  RightsAliasList:= TStringList.Create;
  flstAccessLevels := TObjectList.Create(true);

  qryAccessLevels := TERPQuery.Create(nil);
  try
    qryAccessLevels.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryAccessLevels.Sql.Add('SELECT FormID, FormName, Description FROM tblForms;');
    qryAccessLevels.Open;
    PopulateList(qryAccessLevels);
    qryAccessLevels.Close;
  finally
    qryAccessLevels.Free;
  end;

end;

destructor TAccessLevelObj.Destroy;
begin
  FreeandNil(flstAccessLevels);
  RightsAliasList.Free;
  inherited Destroy;
end;

procedure TAccessLevelObj.PopulateList(Const qry: TERPQuery);
Var
  ItemRec: TAccessRec;
begin
  if not qry.IsEmpty then begin
    qry.First;
    while not qry.Eof do begin
      ItemRec := TAccessRec.Create;
      ItemRec.FormID := qry.FieldByName('FormID').AsInteger;
      ItemRec.FormName := qry.FieldByName('FormName').AsString;
      ItemRec.Description := ReplaceStr(qry.FieldByName('Description').AsString,'&','&&');
      flstAccessLevels.Add(ItemRec);
      qry.Next;
    end;
  end;
end;

function TAccessLevelObj.GetFormDescription(const FormName: string): string;
var
  Rec: TAccessRec;
  iIndex: integer;
begin
  Result := 'N/A';
  for iIndex := 0 to flstAccessLevels.Count - 1 do begin
    Rec := TAccessRec(flstAccessLevels.Items[iIndex]);
    if uppercase(Rec.FormName) = uppercase(FormName) then begin
      Result := replaceStr(Rec.Description , '&&' , '&');
      Break;
    end;
  end;
end;
function TAccessLevelObj.GetFormDescription(const formID: Integer): string;
var
  Rec: TAccessRec;
  iIndex: integer;
begin
  Result := 'N/A';
  for iIndex := 0 to flstAccessLevels.Count - 1 do begin
    Rec := TAccessRec(flstAccessLevels.Items[iIndex]);
    if Rec.FormID = formID then begin
      Result := replaceStr(Rec.Description , '&&' , '&');
      Break;
    end;
  end;
end;

function TAccessLevelObj.GetFormID(const FormName: string): integer;
var
  Rec: TAccessRec;
  iIndex: integer;
begin
  Result := 0;
  for iIndex := 0 to flstAccessLevels.Count - 1 do begin
    Rec := TAccessRec(flstAccessLevels.Items[iIndex]);
    if uppercase(Rec.FormName) = uppercase(FormName) then begin
      Result := Rec.FormID;
      Break;
    end;
  end;
end;

function TAccessLevelObj.GetBusobjAccessLevel(const BusObjName: string; const EmployeeID: integer = 0): integer;
begin
  result:= GetEmployeeAccessLevel(BusObjName, EmployeeID);
end;
function TAccessLevelObj.VS1AdminemployeeId :Integer;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.Sql.Add(    'SELECT E.employeeId FROM  tblemployees E  INNER JOIN tblpassword P ON E.EmployeeID = P.EmployeeId and P.Logon_Name =' + quotedstr(  utCloudconst.ERP_CLOUD_ADMIN_USER)+' AND DATABASE() in ('+VS1_Admin_DBs+')');
    qry.open;
    Result := qry.fieldbyname('employeeId').asInteger;
  finally
    Qry.ClosenFree;
  end;
end;
function TAccessLevelObj.GetEmployeeAccessLevel(const FormName: string; const EmployeeID: integer = 0): integer;
var
  iEmpID: integer;
  iFormId :Integer;
  qry: TERPQuery;
  aName: string;

begin
 (*{$IFDEF DevMode}
  Result := 1;
  exit;
 {$ENDIF}*)
  aName:= FormName;
  Result := 6;
  if EmployeeID = 0 then begin
    iEmpID := AppEnv.Employee.EmployeeID;
  end else begin
    iEmpID := EmployeeID;
  end;

  if self.RightsAliasList.Count > 0 then begin
    aName := RightsAliasList.Values[FormName];
    if aName = '' then
      aName := FormName;
  end;

  iFormId:= GetAccessLevelsFormID(aName);
  if iFormId = 0 then begin
    Result := 1; // Full access if not in tblForms
    (*if devmode and (tcdatautils.getformID(aName)=0) then
      logtext(aName +' - Form doesn''t Exists  in tblforms');*)
    Exit;
  end;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.Sql.Add(Format('SELECT tblEmployeeFormsAccess.Access, tblForms.TabGroup, tblForms.FormName, tblForms.IsForm ' +
        'FROM tblEmployeeFormsAccess, tblForms ' +
        'WHERE tblEmployeeFormsAccess.FormId = tblForms.FormId ' +
        'AND tblEmployeeFormsAccess.EmployeeID = %d AND tblEmployeeFormsAccess.FormID = %d', [iEmpID, iFormId]));
    qry.Open;
    if not qry.IsEmpty then begin
      Result := qry.FieldByName('Access').AsInteger;
      (*if AppEnv.CompanyPrefs.RemoteSite and qry.FieldByName('IsForm').AsBoolean then begin
        if qry.FieldByName('TabGroup').AsInteger in [2,3,4,5] then begin {sales,pos,purchasing,inventory}
          if result < 3 then  result:= 3; { create/read }
        end
        else begin
          if not ((qry.FieldByName('FormName').AsString = 'TAccessLevelsGUI') or
                  (qry.FieldByName('FormName').AsString = 'TfmFormGuiPrefsEdit') or
                  (qry.FieldByName('FormName').AsString = 'TPreferencesGUI')) then
            result:= 6; {no access}
        end;
      end;*)
    end;

    {in Vs1_cloud databse , full access to VS! business objects }
    if (REsult <=0) or (REsult =6) then begin
      if qry.active then qry.close;
      qry.sql.text :=  'SELECT FormID FROM `tblforms`  WHERE BusinessObjectName = ' + QuotedStr(aName) + ' AND Database() in ('+VS1_Admin_DBs+') and BusinessObjectName like "TVS1_%";';
      qry.Open;
      If (qry.RecordCount >0) (*and (iEmpID = VS1AdminemployeeId)*) then Result := 1;// full access
    end else begin
      if qry.active then qry.close;
      qry.sql.text :=  'SELECT FormID FROM `tblforms`  WHERE BusinessObjectName = ' + QuotedStr(aName) + ' AND not(Database() in ('+VS1_Admin_DBs+')) and BusinessObjectName like "TVS1_%";';
      qry.Open;
      If (qry.RecordCount >0) (*and (iEmpID <> VS1AdminemployeeId)*) then Result := 6;// full access
    end;

  finally
    qry.Free;
  end;
end;

function TAccessLevelObj.GetAccessLevelDescription(const AccessLevel: integer): string;
begin
  case AccessLevel of
    1: Result := ACC_LVL_MSG_1;
    2: Result := ACC_LVL_MSG_2;
    3: Result := ACC_LVL_MSG_3;
    5: Result := ACC_LVL_MSG_4;
    6: Result := ACC_LVL_MSG_5;
    else Result := ACC_LVL_MSG_6;
  end;
end;

//class function AppEnv.AccessLevels: TAccessLevelObj;
//begin
//  if not Assigned(oAccessLevel) then
//    oAccessLevel := TAccessLevelObj.Create;
//  Result := oAccessLevel;
//end;

function TAccessLevelObj.GetFormTabGroupID(const FormName: string): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.ParamCheck := true;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT FormID, TabGroup FROM tblforms WHERE (FormName = :xFormClass);');
    qry.Params.ParamByName('xFormClass').AsString := FormName;
    qry.Open;

    if qry.RecordCount > 0 then begin
      Result := qry.FieldByName('TabGroup').AsInteger;
    end else begin
      Result := 0;
    end;

    qry.Close;
  finally
    // Release our used objects.
    if Assigned(qry) then FreeAndNil(qry);
  end;
end;

function TAccessLevelObj.GetAccessLevelsFormID( const FormName: string): integer;
var
  qryTemp: TERPQuery;
begin
  qryTemp:= CommonDbLib.TempMyQuery;
  try
    qryTemp.Sql.Add('SELECT FormID FROM `tblforms`  WHERE `AccessLevels` = "T" ');
    qryTemp.Sql.Add('AND (FormName =' + QuotedStr(FormName) + ') ');
    qryTemp.Sql.Add('OR (BusinessObjectName = ' + QuotedStr(FormName) + ');');
    qryTemp.Open;
    If qryTemp.RecordCount >0 then
      Result := qryTemp.fieldByName('FormID').asInteger
    else
      Result := 0;
  finally
    FreeAndNil(qryTemp);
  end;
end;

{ TAccessRec }

constructor TAccessRec.Create;
begin
  inherited;
  fFormID := 0;
  fFormName := '';
  fDescription := '';
end;

end.

