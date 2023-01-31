unit DataTreeReader;

interface

uses ERPdbComponents, DataTreeBaseObj, myaccess;

Type

  TDataTreeDbStorerbase = class;

  TDataTreeReader = class(TDataTreeNodeBase)
  private
    fStorer: TDataTreeDbStorerbase;
    function GetStorer: TDataTreeDbStorerbase;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Storer: TDataTreeDbStorerbase read GetStorer;
  end;


  TDataTreeDbStorerbase = class(TObject)
  private
    fLastUpdated: TDateTime;
    qry: TERPQuery;
    fAutoUpdate: boolean;
    procedure SetTreeNode(const Value: TDataTreeReader);
    function GetConnection: TCustomMyConnection;
    procedure SetConnection(const Value: TCustomMyConnection);
  protected
    fPackageID: integer;
    fPrefGroup:String;
    fUserID: integer;
    fPrefName: string;
    fIndustryId : integer;
    fTreeNode: TDataTreeReader;
  public
      property TreeNode: TDataTreeReader read fTreeNode write SetTreeNode;
      property Connection: TCustomMyConnection read GetConnection write SetConnection;
    constructor Create; overload;
    constructor Create(const DataTree: TDataTreeReader; const PackageID, UserID: integer; const PrefGroup, PrefName: string; IndustryId : integer);
      overload;
    destructor Destroy; override;

    property UserId: integer read fUserId write fUserId;

    procedure DoBeforeNodeGetData(Sender: TDataTreeNodeBase);
    property AutoUpdate: boolean read fAutoUpdate write fAutoUpdate;

    function Load: boolean; overload;
    function Load(const PackageID, UserID: integer; const PrefGroup, PrefName: string; industryid : integer): boolean; overload;
    procedure Refresh;
(*    procedure Save; overload;
    procedure Save(const PackageID, UserID: integer; const PrefGroup, PrefName: string); overload;*)
  end;


implementation

uses Sysutils, AppEnvironmentVirtual;



{ TDataTreeDbStorerbase }

constructor TDataTreeDbStorerbase.Create;
begin
  inherited;
  fLastUpdated := 0;
  fAutoUpdate := false;
  qry := TERPQuery.Create(nil);

end;

constructor TDataTreeDbStorerbase.Create(const DataTree: TDataTreeReader; const PackageID, UserID: integer; const PrefGroup, PrefName: string; industryId : integer);
begin
  Create;
  fTreeNode := TreeNode;
  fTreeNode.OnBeforeNodeGetValue := DoBeforeNodeGetData;
  fPackageID := PackageID;
  fUserID := UserID;
  fPrefGroup := PrefGroup;
  fPrefName := PrefName;
  fIndustryId := IndustryId;
//@@@???  inherited Create;
end;

destructor TDataTreeDbStorerbase.Destroy;
begin
  fTreeNode.OnBeforeNodeGetValue := nil;
  FreeAndNil(qry);
  inherited;
end;

procedure TDataTreeDbStorerbase.DoBeforeNodeGetData(Sender: TDataTreeNodeBase);
begin
  if AutoUpdate then Refresh;
end;

function TDataTreeDbStorerbase.GetConnection: TCustomMyConnection;
begin
  Result := qry.Connection;
end;

function TDataTreeDbStorerbase.Load(const PackageID, UserID: integer; const PrefGroup, PrefName: string; IndustryId : integer): boolean;
begin
  fPackageID := PackageID;
  fUserID := UserID;
  fPrefGroup := PrefGroup;
  fPrefName := PrefName;
  fIndustryId := IndustryId;
  Result := Load;
end;

procedure TDataTreeDbStorerbase.Refresh;
var
  NeedsLoading: boolean;
begin
  if (not Assigned(fTreeNode)) or (fPrefName = '') then Exit;
  if not Assigned(qry.Connection) then qry.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  NeedsLoading := false;
  qry.SQL.Text := 'SELECT msTimeStamp FROM tblPreferences WHERE' + ' PackageId = ' + IntToStr(fPackageID)
    + ' AND UserId = ' + IntToStr(fUserID) + ' AND PrefGroup = ' + QuotedStr(fPrefGroup) +
    ' AND PrefName = ' + QuotedStr(fPrefName) + ' AND IndustryId=' + IntToStr(fIndustryId);
//    ' AND PrefName = ' + QuotedStr(fPrefName) + ' AND IndustryId = ' + IntToStr(AppEnv.CompanyInfo.IndustryId));
  qry.Open;
  if (not qry.IsEmpty) and
    (qry.FieldByName('msTimeStamp').AsDateTime > fLastUpdated) then NeedsLoading := true;
  qry.Close;
  if NeedsLoading then Load;
end;

function TDataTreeDbStorerbase.Load: boolean;
begin
  if not Assigned(qry.Connection) then qry.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  fTreeNode.Clear;
  Result := false;
  if (not Assigned(fTreeNode)) or (fPrefName = '') then Exit;
  qry.SQL.Text := 'SELECT * FROM tblPreferences WHERE' + ' PackageId = ' + IntToStr(fPackageID) +
    ' AND UserId = ' + IntToStr(fUserID) + ' AND PrefGroup = ' + QuotedStr(fPrefGroup) + ' AND PrefName = ' +
    QuotedStr(fPrefName) + ' AND IndustryId=' + IntToStr(fIndustryId);
  qry.Open;
  if not qry.IsEmpty then begin
    fTreeNode.XML   := qry.FieldByName('PrefValue').AsString;
    fTreeNode.Dirty := false;
    fLastUpdated    := qry.FieldByName('msTimeStamp').AsDateTime;
    Result          := true;
  end;
  qry.Close;

end;

procedure TDataTreeDbStorerbase.SetConnection(const Value: TCustomMyConnection);
begin
  qry.Connection := Value;
end;

procedure TDataTreeDbStorerbase.SetTreeNode(const Value: TDataTreeReader);
begin
  fTreeNode := Value;
  fTreeNode.OnBeforeNodeGetValue := DoBeforeNodeGetData;
end;

{ TDataTreeReader }

constructor TDataTreeReader.Create;
begin
  inherited;
  fStorer := nil;
end;

destructor TDataTreeReader.Destroy;
begin
  if Assigned(fStorer) then
    FreeandNil(fStorer);
  inherited;
end;

function TDataTreeReader.GetStorer: TDataTreeDbStorerbase;
begin
  if not Assigned(fStorer) then begin
    fStorer          := TDataTreeDbStorerbase.Create;
    fStorer.TreeNode := self;
  end;
  Result := fStorer;
end;

end.

