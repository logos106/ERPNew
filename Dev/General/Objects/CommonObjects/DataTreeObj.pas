unit DataTreeObj;

 {
 Date     Version  Who Comment
 -------- -------- --- ---------------------------------------------------------
 08/08/05 _1.00.00 IJB Initial version.
 08/08/05 _1.00.01 Modified SetXML to prevent attempted deletion of temp
                   stringList value if a node end tag is found with no begin tag.
 01/11/05 _1.00.02 Modified SetXML to clear node before adding new nodes via XML
 }

interface

uses Classes, MyAccess,ERPdbComponents, DataTreeBaseObj , DataTreeReader;

type

//  TDataTreeNode         = class;
//  TDataTreeNodeEvent    = procedure(Sender: TDataTreeNode) of object;
//  TOnNodeChange         = TDataTreeNodeEvent;
//  TOnBeforeNodeGetValue = TDataTreeNodeEvent;

  TDataTreeDbStorer = class;

  TDataTreeNode     = class(TDataTreeReader)
  private
    fStorer: TDataTreeDbStorer;
    function GetDbStorer: TDataTreeDbStorer;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    property Storer: TDataTreeDbStorer read GetDbStorer;
  end;

  TDataTree = class(TDataTreeNode)
  private
  protected
  public
  end;

  TDataTreeDbStorer = class(TDataTreeDbStorerbase)
  private
   (* fPackageID,
    fUserID: integer;
    fPrefGroup,
    fPrefName: string;
    fTreeNode: TDataTreeNode;
    fLastUpdated: TDateTime;
    qry: TERPQuery;
    fAutoUpdate: boolean;*)
    //procedure SetTreeNode(const Value: TDataTreeNode);
    //function GetConnection: TCustomMyConnection;
    //procedure SetConnection(const Value: TCustomMyConnection);
  protected
  public
    //constructor Create; overload;
    //constructor Create(const DataTree: TDataTreeNode; const PackageID, UserID: integer; const PrefGroup, PrefName: string);      overload;
    //destructor Destroy; override;
    //property Connection: TCustomMyConnection read GetConnection write SetConnection;
    //property UserId: integer read fUserId write fUserId;
    //property TreeNode: TDataTreeNode read fTreeNode write SetTreeNode;
    //procedure DoBeforeNodeGetData(Sender: TDataTreeNodeBase);
    //property AutoUpdate: boolean read fAutoUpdate write fAutoUpdate;
    //function Load: boolean; overload;
    //function Load(const PackageID, UserID: integer; const PrefGroup, PrefName: string): boolean; overload;
    //procedure Refresh;
    procedure Save; overload;
    procedure Save(const PackageID, UserID: integer; const PrefGroup, PrefName: string; IndustryId : integer); overload;
  end;

implementation

uses
  AppEnvironmentVirtual,SysUtils, LibXmlParser(*, CommonLib*), BusObjPreference, BusObjBase;

{ TDataTreeNode }

constructor TDataTreeNode.Create;
begin
  Inherited;
  //fStorer := nil;
end;

destructor TDataTreeNode.Destroy;
begin
(*  if Assigned(fStorer) then
    FreeandNil(fStorer);*)
  FreeAndNil(fStorer);     //@@@@@@@@@@@@@@@@@@@
  inherited;
end;

function TDataTreeNode.GetDbStorer: TDataTreeDbStorer;
begin
  if not Assigned(fStorer) then begin
    fStorer          := TDataTreeDbStorer.Create;
    fStorer.TreeNode := self;
  end;
  Result := fStorer;
end;

  { TDataTreeDbStorer }

(*constructor TDataTreeDbStorer.Create(const DataTree: TDataTreeNode; const PackageID, UserID: integer;
  const PrefGroup, PrefName: string);
begin
  fTreeNode := TreeNode;
  fTreeNode.OnBeforeNodeGetValue := DoBeforeNodeGetData;
  fPackageID := PackageID;
  fUserID := UserID;
  fPrefGroup := PrefGroup;
  fPrefName := PrefName;
  inherited Create;
end;*)

(*constructor TDataTreeDbStorer.Create;
begin
  inherited;
  fLastUpdated := 0;
  fAutoUpdate := false;
  qry := TERPQuery.Create(nil);
end;*)

(*destructor TDataTreeDbStorer.Destroy;
begin
  fTreeNode.OnBeforeNodeGetValue := nil;
  FreeAndNil(qry);
  inherited;
end;*)

(*procedure TDataTreeDbStorer.DoBeforeNodeGetData(Sender: TDataTreeNodeBase);
begin
  if AutoUpdate then Refresh;
end;*)

(*function TDataTreeDbStorer.Load: boolean;
begin
  if not Assigned(qry.Connection) then qry.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  fTreeNode.Clear;
  Result := false;
  if (not Assigned(fTreeNode)) or (fPrefName = '') then Exit;
  qry.SQL.Text := 'SELECT * FROM tblPreferences WHERE' + ' PackageId = ' + IntToStr(fPackageID) +
    ' AND UserId = ' + IntToStr(fUserID) + ' AND PrefGroup = ' + QuotedStr(fPrefGroup) + ' AND PrefName = ' +
    QuotedStr(fPrefName);
  qry.Open;
  if not qry.IsEmpty then begin
    fTreeNode.XML   := qry.FieldByName('PrefValue').AsString;
    fTreeNode.Dirty := false;
    fLastUpdated    := qry.FieldByName('msTimeStamp').AsDateTime;
    Result          := true;
  end;
  qry.Close;
end;*)

(*function TDataTreeDbStorer.GetConnection: TCustomMyConnection;
begin
  Result := qry.Connection;
end;*)

(*function TDataTreeDbStorer.Load(const PackageID, UserID: integer; const PrefGroup, PrefName: string): boolean;
begin
  fPackageID := PackageID;
  fUserID := UserID;
  fPrefGroup := PrefGroup;
  fPrefName := PrefName;
  Result := Load;
end;*)

(*procedure TDataTreeDbStorer.Refresh;
var
  NeedsLoading: boolean;
begin
  if (not Assigned(fTreeNode)) or (fPrefName = '') then Exit;
  if not Assigned(qry.Connection) then qry.Connection := TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
  NeedsLoading := false;
  qry.SQL.Text := 'SELECT msTimeStamp FROM tblPreferences WHERE' + ' PackageId = ' + IntToStr(fPackageID)
    + ' AND UserId = ' + IntToStr(fUserID) + ' AND PrefGroup = ' + QuotedStr(fPrefGroup) +
    ' AND PrefName = ' + QuotedStr(fPrefName);
  qry.Open;
  if (not qry.IsEmpty) and
    (qry.FieldByName('msTimeStamp').AsDateTime > fLastUpdated) then NeedsLoading := true;
  qry.Close;
  if NeedsLoading then Load;
end;*)

procedure TDataTreeDbStorer.Save;
var
  Pref: TPreference;
begin
  if (not Assigned(fTreeNode)) or (fPrefName = '') then Exit;
  if sametext(fPrefName , 'TBaseListingGUI') then exit;
  Pref:= TPreference.Create(nil);
  try
    Pref.Connection:= TMyDacDataConnection.Create(Pref);
    Pref.Connection.Connection:= TERPConnection(AppEnvVirt.Obj['CommonDbLib.GetSharedMyDacConnection']);
    Pref.Load(fUserID,fPrefGroup,fPrefName,'','',fPackageID, true, fIndustryId);
    Pref.PrefValue:= fTreeNode.XML;
    if not Pref.Save then
      raise Exception.Create('Unable to save Preference for "' +  fPrefName + '": ' + Pref.ResultStatus.Messages);

  finally
    Pref.Free;
  end;
  self.fTreeNode.Dirty := false;
end;

procedure TDataTreeDbStorer.Save(const PackageID, UserID: integer; const PrefGroup, PrefName: string; IndustryId : integer);
begin
  fPackageID := PackageID;
  fUserID := UserID;
  fPrefGroup := PrefGroup;
  fPrefName := PrefName;
  fIndustryId := IndustryId;
  Save;
end;

(*procedure TDataTreeDbStorer.SetConnection(const Value: TCustomMyConnection);
begin
  qry.Connection := Value;
end;*)

(*procedure TDataTreeDbStorer.SetTreeNode(const Value: TDataTreeNode);
begin
  fTreeNode := Value;
  fTreeNode.OnBeforeNodeGetValue := DoBeforeNodeGetData;
end;*)


end.

