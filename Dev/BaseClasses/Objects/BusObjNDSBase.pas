unit BusObjNDSBase;

{
  This is the base for business objects that are not based on TDataSets.
  NDS = No DataSet

}

interface

uses
  Classes, BusObjBase, XMLDoc, XMLIntf, UserLockObj, DB,
  MyAccess,ERPdbComponents, Contnrs, BusObjGeneral, MultiEventObj;

type
  TBusObjStorer = class;

  TBusObjNDSClass = class of TBusObjNDS;
  TBusObjNDS = class(TBusObjBase, IBusObjXML)
  private
    fUserLock: TUserLock;
    fLimitXMLFieldsOnSave: boolean;
    fPostList :TPostList;
    fAssignedPostList: TPostList;
    fParamList: TStringList;
    fXMLDoc: TXMLDocument;
    function GetCanCreate: boolean;
    function GetCanDelete: boolean;
    function GetCanRead: boolean;
    function GetCanUpdate: boolean;
    function GetSilentMode: boolean;
    function GetUserLock: TUserLock;
    procedure SetSilentMode(const Value: boolean);
    procedure SetStorer(const Value: TBusObjStorer);
    function GetXMLNodeName: string;
    function GetXML: string;
    function GetXMLDoc: TXMLDocument;
    procedure SetXML(const Value: string);
    function GetPostList: TPostList;
    procedure SetPostList(const Value: TPostList);
    function GetLoadParamList: TStringList;
  protected
    fDirty: Boolean;
    fPrivateStorer,
    fAssignedStorer: TBusObjStorer;
    fId: integer;
    fObjInstGlobalRef :string;
    fBusObjectTableName: string; { set this in overriden create }
    fIdFieldName: string;  { set this in overriden create }
    fBusObjectTypeDescription: string; { optionally set this in overriden create }
    fIgnoreAccesslevel: Boolean;
    FAccessLevel: integer;
    function GetId: integer; override;
    procedure SetId(const Value: integer); virtual;
    procedure AddXMLNode(Const Node : IXMLNode; Const sNodeName :String; Const Value : OleVariant; XMLTagsinLowercase :Boolean = True);
    function GetBusObjectTablename: string;
    function GetBusObjectTypeDescription: string;
    function GetIdFieldName: string;
    procedure MakeDirty; virtual;
    function GetAccessLevel: integer; virtual;
    procedure SetAccessLevel(const Value: integer); virtual;
    function GetStorer: TBusObjStorer; virtual;
    function GetDirty: boolean; virtual;
    procedure SetDirty(const Value: boolean); virtual;
    Function RelatedRecordsDeleteSQL:String ; virtual;
  public
    Constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property SilentMode: boolean read GetSilentMode write SetSilentMode;
    property BusObjectTableName: string read GetBusObjectTablename;
    property BusObjectTypeDescription: string read GetBusObjectTypeDescription;
    property CanRead: boolean read GetCanRead;
    property CanUpdate: boolean read GetCanUpdate;
    property CanCreate: boolean read GetCanCreate;
    property CanDelete: boolean read GetCanDelete;
    Property IDFieldName : string read GetIdFieldName write fIdFieldName;
    procedure LoadSelect(Const SelectSql: string = '');
    procedure FilterSelect(FilterNode: IXMLNode);
    procedure Load(const fIsReadonly:boolean =False); overload; override;
    procedure Load(Const aId: integer;const fIsReadonly:boolean =False); overload; override;
    property LoadParamList: TStringList read GetLoadParamList;
    function Save: boolean; override;
    function SaveNoCheck: boolean; virtual;
    procedure New; override;
    function Delete: boolean; override;
    procedure DeleteNoCheck; virtual;
    Property UserLock :TUserLock read GetUserLock write fUserLock;
    function Lock :Boolean ;
    function UnLock :Boolean ;
    function IsLocked: boolean;
    function ValidateData: boolean; override;
    property AccessLevel: integer read GetAccessLevel write SetAccessLevel;
    Property IgnoreAccesslevel :Boolean read fIgnoreAccesslevel write fIgnoreAccesslevel;
    property XML: string read GetXML write SetXML;
    property XMLDoc: TXMLDocument read GetXMLDoc;
    Property XMLNodeName : string read GetXMLNodeName;
    procedure SaveToXMLNode(const node: IXMLNode); virtual;
    Procedure LoadFromXMLNode(const node: IXMLNode); virtual;
    property LimitXMLFieldsOnSave: boolean read fLimitXMLFieldsOnSave write fLimitXMLFieldsOnSave;
    procedure SetPropertyFromNode(Const aNode: IXMLNode; Const aPropertyName, aNodeName: string; Const Obj: TObject = nil); overload;
    procedure SetPropertyFromNode(Const aNode: IXMLNode; Const aPropertyName: string; Const Obj: TObject = nil); overload;
    procedure SetDateTimePropertyFromNode(Const aNode: IXMLNode; Const aPropertyName, aNodeName: string; Const Obj: TObject = nil); overload;
    procedure SetDateTimePropertyFromNode(Const aNode: IXMLNode; Const aPropertyName: string; Const Obj: TObject = nil); overload;
    property Storer: TBusObjStorer read GetStorer write SetStorer;
    property Id: integer read GetId write SetId;
    Property ObjInstGlobalRef :String read fObjInstGlobalRef Write fObjInstGlobalRef;
    property Dirty: boolean read GetDirty write SetDirty;
    procedure Assign(Source: TPersistent); override;
    property PostList: TPostList read GetPostList write SetPostList;
  published
    property IsDirty: boolean read GetDirty;
  end;

  TMSBusObjNDSClass = class of TMSBusObjNDS;
  TMSBusObjNDS = class(TBusObjNDS, IMSBusObj)
  private
    fGlobalRef: string;
    fMsUpdateSiteCode: string;
    fmsTimeStamp: TDateTime;
    function GetGlobalRef: string;
    procedure SetGlobalRef(const Value: string);
    procedure SetmsTimeStamp(const Value: TDateTime);
    function GetMsUpdateSiteCode: string;
    procedure SetMsUpdateSiteCode(const Value: string);
  protected
    procedure AssignGlobalRef;
    procedure DoUpdateSiteCode;
  public
    procedure SaveToXMLNode(const node: IXMLNode); override;
    Procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure FlagAsUpdated(aTimeStamp: TDateTime = 0);
    Constructor Create(AOwner: TComponent); override;
    Procedure logit(Printheader:boolean =False;Lognodename:String =''; Dochildren:Boolean =true);virtual;
  published
    property GlobalRef: string read GetGlobalRef write SetGlobalRef;
    property MsUpdateSiteCode: string read GetMsUpdateSiteCode write SetMsUpdateSiteCode;
    property msTimeStamp: TDateTime read fmsTimeStamp write SetmsTimeStamp;
  end;

  TBusObjNDSList = class(TObject)
  private
    List: TObjectList;
    fOwner: TBusObjNDS;
    fItemClassName: string;
    fLoadSql: string;
    fDirty: boolean;
    function GetDirty: boolean;
    procedure SetDirty(const Value: boolean);
  protected
    function GetItem(Const index: integer): TBusObjNDS;
  public
    constructor Create(AOwner: TBusObjNDS); reintroduce;
    destructor Destroy; override;
    function Count: integer;
    function Add(Const BusObj: TBusObjNDS): integer;
    procedure Delete(Const BusObj: TBusObjNDS);
    procedure Clear(const DeleteFromDb: boolean = false);Overload;
    Procedure Clear(const DeleteFromDB:Boolean;DeleteRow:Integer);Overload;
    property ItemClassName: string read fItemClassName write fItemClassName;
    property LoadSql: string read fLoadSql write fLoadSql;
    property Item[Const index: integer]: TBusObjNDS read GetItem; default;
    property Dirty: boolean read GetDirty write SetDirty;
  end;

  TMSBusObjMasterType = (mtQuote, mtSalesOrder, mtInvoice, mtPurchase, mtProduct);
  TBusObjNDSTree = class;

  TBusObjNDSTreeChildList = class;

  TBusObjNDSTree = class(TMSBusObjNDS)
  private
    FMasterId: integer;
    FSequenceDown: integer;
    FParentId: integer;
    FMasterType: TMSBusObjMasterType;
    fAutoResequence: boolean;
    fChildren: TBusObjNDSTreeChildList;
    fLoading: boolean;
    FSequenceUp: integer;
    fEditVersion: integer;
    FLevel: integer;
    fCleanTree:TBusObjNDSTree;


    procedure SetMasterId(const Value: integer);
    procedure SetMasterType(const Value: TMSBusObjMasterType);
    procedure SetParentId(const Value: integer);
    procedure SetSequenceDown(const Value: integer);
    procedure SetTreeRootId(const Value: integer);
    function GetIsRoot: boolean;
    function GetChiltren: TBusObjNDSTreeChildList;
    function GetTreeRootId: integer;
    function GetLoading: boolean;
    procedure SetLoading(const Value: boolean);
    function GetRootNode: TBusObjNDSTree;
    procedure SetSequenceUp(const Value: integer);
    function GetParentId: integer;
    procedure UpdateEditVersion(const VerNo: integer);
    procedure SetEditVersion(const Value: integer);
    function GetMasterType: TMSBusObjMasterType;
    function GetMasterId: integer;
    function GetIndex: integer;
    procedure SetLevel(const Value: integer);
    function getAnydirty: Boolean;
  protected
    ISCleanTree:Boolean;
    procedure AfterSave; virtual;
    procedure MakeDirty; override;
    Function SourceFromStock:Boolean ; virtual;
    function OptionItem:Boolean; virtual;
    Function CleanTree:TBusObjNDSTree;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure Deletetree; virtual;
    property Loading: boolean read GetLoading write SetLoading;
    procedure ResequenceTree;
    procedure Resequence(var LastSequenceNo: integer);
    procedure LoadTree(Const SubTreeOnly: boolean = false; PartsourceStock :Boolean = False); Virtual;
    procedure Load(const fIsReadonly:boolean =False); overload; override;
    procedure Load(Const aId: integer;const fIsReadonly:boolean =False); overload; override;
    function Save: boolean; override;
    function SaveNoCheck: boolean; override;
    function Delete: boolean; override;
    procedure DeleteNoCheck; override;
    function TreeDirty: Boolean;
    property IsRoot: boolean read GetIsRoot;
    function MakeInstance: TBusObjNDSTree;
    function NodeById(Const aId: integer): TBusObjNDSTree;
    property RootNode: TBusObjNDSTree read GetRootNode;
    procedure ClearIds; virtual;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    Procedure LoadFromXMLNode(const node: IXMLNode); override;
    property Index: integer read GetIndex;
    function LevelStr: string;
    procedure Assign(Source: TPersistent); override;
    procedure New; override;
    Procedure DoAfterLoad;Virtual;
    Property Anydirty :Boolean read getAnydirty;

(*    Procedure StoreTotQty(var totQty:Double); virtual;
    Procedure RestoreTotQty(var totQty:Double);Virtual;*)

  published
    property Children: TBusObjNDSTreeChildList read GetChiltren;
    property ParentId: integer read GetParentId write SetParentId;
    property TreeRootId: integer read GetTreeRootId write SetTreeRootId;
    property SequenceDown: integer read FSequenceDown write SetSequenceDown;
    property SequenceUp: integer read FSequenceUp write SetSequenceUp;
    property EditVersion: integer read fEditVersion write SetEditVersion;
    property Level: integer read FLevel write SetLevel;

    { The following 2 properties are required for multisiting ie when a tree
      item is edited it needs to flag the master record as also edited so
      multi site will send the whole tree. }
    property MasterId: integer read GetMasterId write SetMasterId;
    property MasterType: TMSBusObjMasterType read GetMasterType write SetMasterType;

  end;

  TBusObjNDSTreeChildList = class(TComponent)
  private
    List: TObjectList;
    function GetCount: integer;
    function GetItem(Const index: integer): TBusObjNDSTree;
    procedure SetOwnerValues(Const obj: TBusObjNDSTree);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Count: integer read GetCount;
    property Item[Const index: integer]: TBusObjNDSTree read GetItem; default;
    function Add: TBusObjNDSTree; overload;
    function Add(Const obj: TBusObjNDSTree): integer; overload;
    function Insert(Const Index: integer): TBusObjNDSTree; overload;
    procedure Insert(Const Index: integer; Const obj: TBusObjNDSTree); overload;
    procedure Remove(Const Index: integer); overload;
    procedure Remove(Const obj: TBusObjNDSTree); overload;
    procedure Delete(Const Index: integer);
    procedure Clear;
    function IndexOf(Const obj: TBusObjNDSTree): integer;
  end;

  TBusObjStorer = class(TObject)
  private
    fAssignedConnection: TERPConnection;
    fMultiEventObj :TMultiEventClass;
    function GetConnection: TERPConnection;
    procedure SetConnection(const Value: TERPConnection);
    function getMultiEventObj: TMultiEventClass;
  Protected
  public
    property Connection: TERPConnection read GetConnection write SetConnection;
    procedure Load(Const obj: TBusObjNDS; Const SelectSql: string = ''); virtual;
    procedure LoadTree(Const obj: TBusObjNDSTree; Const SubTreeOnly: boolean = false; PartsourceStock:boolean = False); virtual;
    procedure LoadList(Const List: TBusObjNDSList); virtual;
    procedure Save(Const obj: TBusObjNDS); virtual;
    procedure Delete(Const obj: TBusObjNDS); virtual;
    procedure RunSQLCommand(const SQLStr: string);
    function getNewDataset(const SQLStr:String = ''):TERPQuery;
    Property MultiEventObj :TMultiEventClass read getMultiEventObj;
    constructor Create;
    destructor Destroy;override;
  end;

  function BusObjMasterTypeToStr(const BusObjMasterType: TMSBusObjMasterType): string;
  function StrToBusObjMasterType(const Value: string): TMSBusObjMasterType;

implementation

uses
  SysUtils, BusObjConst, AppEnvironment, Variants, MySQLConst, CommonLib, TypInfo,
  CommonDbLib, SaveExcludeListObj, ClassFuncs, DNMAccessManager,
  DateUtils ;

Type
  TBusObjNDSTreeClass = class of TBusObjNDSTree;

function BusObjMasterTypeToStr(const BusObjMasterType: TMSBusObjMasterType): string;
begin
  case BusObjMasterType of
    mtQuote: result:= 'mtQuote';
    mtSalesOrder: result:= 'mtSalesOrder';
    mtInvoice: result:= 'mtInvoice';
    mtPurchase: result:= 'mtPurchase';
    mtProduct: result:= 'mtProduct';
  end;
end;

function StrToBusObjMasterType(const Value: string): TMSBusObjMasterType;
begin
  if Value = 'mtQuote' then result:= mtQuote
  else if Value = 'mtSalesOrder' then result:= mtSalesOrder
  else if Value = 'mtInvoice' then result:= mtInvoice
  else if Value = 'mtPurchase' then result:= mtPurchase
  else if Value = 'mtProduct' then result:= mtProduct
  else raise Exception.Create('StrToBusObjMasterType - Invalid input value: "' + Value + '"');
end;

procedure AddPublishedPropsToXMLNode(obj: TBusObjNDS; node: IXMLNode; XMLTagsinLowercase: boolean = true);
var
  count, x: integer;
  PropList: PPropList;
  NodeName, ValStr: string;
  Val: Variant;
begin
  Count := GetPropList(obj.ClassInfo, tkProperties, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(obj.ClassInfo, tkProperties, PropList);
    for x := 0 to Count -1 do begin

      NodeName:= String(PropList[x].Name);
      if (NodeName = 'Name') or (NodeName = 'Tag') then
        Continue;
      val:= GetPropValue(obj, String(PropList[x].Name));
      if obj.LimitXMLFieldsOnSave and
        ((not AppEnv.BusObjFieldList.ListEmpty(Obj.ClassName)) and
        (not AppEnv.BusObjFieldList.InList(Obj.ClassName, NodeName))) then continue;
      if XMLTagsinLowercase then NodeName := LowerCase(NodeName);
      if (not VarIsNull(val)) then begin
        if (PropList[x].PropType^ = TypeInfo(TDateTime)) then
          valStr:= FormatDateTime(MysqlDateTimeFormat, val)
        else begin
          if PropList[x].PropType^.Kind = tkEnumeration then begin
            if Val = 'True' then ValStr:= 'T'
            else if Val = 'False' then ValStr:= 'F'
            else ValStr:= val;
          end
          else
            valStr:= val;
          { add node }
          node.Addchild(NodeName).NodeValue := ValStr;

        end;
      end;
    end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
end;

procedure SequenceTree(aNode: TBusObjNDSTree; var LastSeqNo: integer; aLevel: integer);
var x: integer;
begin
  Inc(LastSeqNo);
  aNode.SequenceDown:= LastSeqNo;
  aNode.SequenceUp:= 0;
  aNode.Level:= aLevel;
  if aNode.Children.Count > 0 then begin
    for x:= 0 to aNode.Children.Count -1 do begin
      if aNode.Children[x].Children.Count > 0 then begin
        SequenceTree(aNode.Children[x], LastSeqNo, aLevel +1);
      end
      else begin
        Inc(LastSeqNo);
        aNode.Children[x].SequenceDown:= LastSeqNo;
        aNode.Children[x].SequenceUp:= 0;
        aNode.Children[x].Level:= aLevel + 1;
      end;
    end;
    for x:= aNode.Children.Count -1 downto 0 do begin
      if aNode.Children[x].SequenceUp = 0 then begin
        Inc(LastSeqNo);
        aNode.Children[x].SequenceUp:= LastSeqNo;
      end
    end
  end;
  Inc(LastSeqNo);
  aNode.SequenceUp:= LastSeqNo;
end;

{ TBusObjNDS }

constructor TBusObjNDS.Create(AOwner: TComponent);
begin
  inherited;
  fId:= 0;
  fLimitXMLFieldsOnSave:= false;
  fBusObjectTableName:= '';
  fIdFieldName:= '';
  FAccessLevel:= -1;
  fIgnoreAccesslevel:= false;
end;

destructor TBusObjNDS.Destroy;
begin
  FreeAndNil(fPrivateStorer);
  FreeAndNil(fParamList);
//  FreeAndNil(fXMLDoc);
  inherited;
end;

procedure TBusObjNDS.New;
begin
  fId:= 0;
  ClearPropertyValues(self);
  { override this and insert code to clear/reset object properties }
end;

function TBusObjNDS.Delete: boolean;
begin
  result:= true;
  if (not CanDelete) then begin
    self.ResultStatus.AddItem(false, rssError, 0, 'No rights to delete ' +
      Self.BusObjectTypeDescription);
  end
  else begin
    DeleteNoCheck;
  end;
end;

function TBusObjNDS.RelatedRecordsDeleteSQL: String;
begin
  Result := '';
end;

procedure TBusObjNDS.DeleteNoCheck;
begin
  if Assigned(Container) then
    Container.DoEvent(Self, evDSBeforeDelete);
  Storer.Delete(self);
  Dirty:= false;
end;


function TBusObjNDS.GetBusObjectTablename: string;
begin
  result:= fBusObjectTableName;
end;

function TBusObjNDS.GetBusObjectTypeDescription: string;
begin
  if fBusObjectTypeDescription <> '' then
    result:= fBusObjectTypeDescription
  else
    result:= Copy(Self.ClassName, 2, char_length(Self.ClassName));
end;

function TBusObjNDS.GetCanCreate: boolean;
begin
  Result := AccessLevel in [1..3];
end;

function TBusObjNDS.GetCanDelete: boolean;
begin
  Result := AccessLevel = 1;
end;

function TBusObjNDS.GetCanRead: boolean;
begin
  Result := AccessLevel in [1..5];
end;

function TBusObjNDS.GetCanUpdate: boolean;
begin
  Result := AccessLevel in [1..2];
end;

function TBusObjNDS.GetDirty: boolean;
begin
  result:= fDirty;
end;

function TBusObjNDS.GetSilentMode: boolean;
begin
  if Assigned(Owner) and (Owner is TBusObjNDS) then
    result:= TBusObjNDS(Owner).SilentMode
  else
    result:= self.ResultStatus.SilentMode;
end;

procedure TBusObjNDS.SetSilentMode(const Value: boolean);
begin
  if Assigned(Owner) and (Owner is TBusObjNDS) then
    TBusObjNDS(Owner).SilentMode:= Value
  else
    self.ResultStatus.SilentMode:= Value;
end;

function TBusObjNDS.GetUserLock: TUserLock;
begin
  if Assigned(Owner) and (Owner is TBusObjNDS) then
    result:= TBusObjNDS(Owner).UserLock
  else if owner is TBusobj then
    result := TBusobj(Owner).UserLock
  else begin
    if not Assigned(fUserLock) then
      fUserLock:= TUserLock.Create(self);
    Result := fUserLock;
  end;
end;

function TBusObjNDS.IsLocked: boolean;
begin
  if Assigned(Owner) and (Owner is TBusObjNDS) then
    result:= TBusObjNDS(Owner).IsLocked
  else begin
    result:= UserLock.IsLocked(BusObjectTableName,Id, BusObjectTypeDescription);
  end;
end;

procedure TBusObjNDS.LoadSelect(Const SelectSql: string = '');
begin
  if (not CanRead) then begin
    self.ResultStatus.AddItem(false, rssError, 0, 'No rights to read ' +
      Self.BusObjectTypeDescription);
  end
  else begin
    (*if Id < 1 then begin
      self.ResultStatus.AddItem(false, rssError, 0, 'Cannot load, Missing Id ' +
        Self.BusObjectTypeDescription);
    end
    else begin
      Storer.Load(self, SelectSql);
    end;*)
    Storer.Load(self, SelectSql);
  end;
end;

function TBusObjNDS.Save: boolean;
begin
  if not ValidateData then begin
    result:= false;
    Exit;
  end;
  if fId < 1 then begin
    { creating }
    if (not CanCreate) then begin
      self.ResultStatus.AddItem(false, rssError, 0, 'No rights to create ' +
        Self.BusObjectTypeDescription);
      result:= false;
    end
    else begin
      result:= SaveNoCheck;
    end;
  end
  else begin
    { updating }
    if (not CanUpdate) then begin
      self.ResultStatus.AddItem(false, rssError, 0, 'No rights to update ' +
        Self.BusObjectTypeDescription);
      result:= false;
    end
    else begin
      result:= SaveNoCheck;
    end;
  end;
end;

function TBusObjNDS.SaveNoCheck: boolean;
begin
  result:= true;
  Storer.Save(self);
  if self.Id > 0 then
    self.ContainerList.DoSetId(self.Id);
end;

function TBusObjNDS.Lock: Boolean;
begin
  if Assigned(Owner) and (Owner is TBusObjNDS) then
    result:= TBusObjNDS(Owner).Lock
  else begin
    UserLock.Enabled:= true;
    result:= UserLock.Lock(BusObjectTableName,Id, BusObjectTypeDescription);
  end;
end;

procedure TBusObjNDS.LoadFromXMLNode(const node: IXMLNode);
begin

end;

procedure TBusObjNDS.SaveToXMLNode(const node: IXMLNode);
begin
  AddXMLNode(node,IDTagInXML,ID);
  AddPublishedPropsToXMLNode(self,node);
end;

procedure TBusObjNDS.SetDirty(const Value: boolean);
begin
  fDirty:= Value;
end;

function TBusObjNDS.UnLock: Boolean;
begin
  if Assigned(Owner) and (Owner is TBusObjNDS) then
    result:= TBusObjNDS(Owner).Unlock
  else begin
    result:= true;
    UserLock.UnlockAllCurrentInstance;
  end;
end;

function TBusObjNDS.ValidateData: boolean;
begin
  result:= true;
end;

procedure TBusObjNDS.AddXMLNode(const Node: IXMLNode;
  const sNodeName: String; const Value: OleVariant;
  XMLTagsinLowercase: Boolean);
var
  NodeName :String;
  sValue: OleVariant;
begin
  if node = nil then Exit;
  if snodeName = '' then Exit;
  if XMLTagsinLowercase then NodeName := LowerCase(sNodeName)
  else NodeName :=sNodeName;
  if LimitXMLFieldsOnSave and
    ((not AppEnv.BusObjFieldList.ListEmpty(Self.ClassName)) and
     (not AppEnv.BusObjFieldList.InList(self.ClassName, NodeName))) then exit;
  sValue := Value;
  if vartype(Value) = VarDate then
      if Value = '12:00:00 AM' then Exit{ignore blank date}
          else sValue := FormatDateTime( MysqlDateFormat, sValue); {dateTostr to convert the date into system date format}
  Node.Addchild(NodeName).NodeValue := sValue;
end;

procedure TBusObjNDS.SetDateTimePropertyFromNode(Const aNode: IXMLNode; Const aPropertyName, aNodeName: string; Const Obj: TObject);
var
  ValNode: IXMLNode;
  dt: TDateTime;
  s, saveDateFormat, saveTimeFormat: string;
begin
  ValNode := aNode.ChildNodes.FindNode(LowerCase(aNodeName));
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then begin
    try
      saveDateFormat := FormatSettings.ShortDateformat;
      saveTimeFormat := FormatSettings.LongTimeFormat;
      FormatSettings.LongTimeFormat := MysqlTimeFormat;
      FormatSettings.LongTimeFormat := replaceStr(FormatSettings.LongTimeFormat , ':' , FormatSettings.TimeSeparator);

      FormatSettings.ShortDateformat := MysqlDateFormat;
      FormatSettings.ShortDateformat := replaceStr(FormatSettings.ShortDateformat , '-' , FormatSettings.DateSeparator);

      try
        s :=ValNode.NodeValue;
        s := replaceStr(s , ':' , FormatSettings.TimeSeparator);
        s := replaceStr(s , '-' , FormatSettings.DateSeparator);
        dt := StrToDateTime(s);
        if Assigned(Obj) then
          SetFloatProp(Obj, aPropertyName, dt)
        else
          SetFloatProp(self, aPropertyName, dt);

      finally
        FormatSettings.ShortDateformat := saveDateFormat;
        FormatSettings.LongTimeFormat  := saveTimeFormat;
      end;
    except
      on E: Exception do begin
        raise Exception.Create('Error setting property: ' +
          Self.BusObjectTypeDescription +  ' - ' + aPropertyName + ': ' + E.Message);
      end;
    end;
  end;
end;

procedure TBusObjNDS.SetDateTimePropertyFromNode(Const aNode: IXMLNode; Const aPropertyName: string; Const Obj: TObject);
begin
  SetDateTimePropertyFromNode(aNode, aPropertyName, aPropertyName, Obj);
end;

procedure TBusObjNDS.SetPropertyFromNode(Const aNode: IXMLNode; Const aPropertyName, aNodeName: string; Const Obj: TObject);
var
  ValNode: IXMLNode;
begin
  ValNode := aNode.ChildNodes.FindNode(LowerCase(aNodeName));
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then begin
    try
      if Assigned(Obj) then
        SetPropValue(Obj, aPropertyName, ValNode.NodeValue)
      else
        SetPropValue(self, aPropertyName, ValNode.NodeValue);
    except
      on E: Exception do begin
        raise Exception.Create('Error setting property: ' +
          Self.BusObjectTypeDescription +  ' - ' + aPropertyName + ': ' + E.Message);
      end;
    end;
  end;
end;

procedure TBusObjNDS.SetPropertyFromNode(Const aNode: IXMLNode; Const aPropertyName: string; Const Obj: TObject);
begin
  SetPropertyFromNode(aNode, aPropertyName, aPropertyName, Obj);
end;

function TBusObjNDS.GetIdFieldName: string;
begin
  Result := fIdFieldName;
end;

function TBusObjNDS.GetStorer: TBusObjStorer;
begin
  if Assigned(fAssignedStorer) then
    result:= fAssignedStorer
  else begin
    if Assigned(Owner) and (Owner is TBusObjNDS) then
      result:= TBusObjNDS(Owner).Storer
    else begin
      if not Assigned(fPrivateStorer) then begin
        fPrivateStorer:= TBusObjStorer.Create;
        if Assigned(Owner) and (Owner is TDatasetBusObj) then
          fPrivateStorer.Connection:= TERPConnection(TDatasetBusObj(Owner).Connection.Connection);
      end;
      result:= fPrivateStorer;
    end;
  end;
end;

function TBusObjNDS.GetId: integer;
begin
  result:= fId;
end;

procedure TBusObjNDS.SetId(const Value: integer);
begin
  if fId <> Value then begin
    fId:= Value;
    MakeDirty;
  end;
end;

procedure TBusObjNDS.MakeDirty;
begin
  fDirty:= true;
  if (Owner is TMSBusObj) then
    TMSBusObj(Owner).FlagAsUpdated;
end;

procedure TBusObjNDS.SetAccessLevel(const Value: integer);
begin
  FAccessLevel := Value;
end;

function TBusObjNDS.GetAccessLevel: integer;
begin
  if Assigned(Owner) then begin
    if (Owner is TBusObjNDS) then begin
      if TBusObjNDS(Owner).IgnoreAccesslevel then
        result:= 1
      else
        result:= TBusObjNDS(Owner).AccessLevel;
    end
    else if (Owner is TDatasetBusObj) then
      result:= TDatasetBusObj(Owner).AccessManager.AccessLevel
    else begin
      if fAccesslevel < 0 then begin
        fAccesslevel:= AppEnv.AccessLevels.GetBusobjAccessLevel(Self.ClassName);
      end;
      result:= fAccessLevel;
    end;
  end
  else begin
    if fIgnoreAccesslevel then
      result:= 1
    else begin
      if fAccesslevel < 0 then begin
        fAccesslevel:= AppEnv.AccessLevels.GetBusobjAccessLevel(Self.ClassName);
      end;
      result:= fAccessLevel;
    end;
  end;
end;

procedure TBusObjNDS.SetStorer(const Value: TBusObjStorer);
begin
  fAssignedStorer:= Value;
end;

function TBusObjNDS.GetXMLNodeName: string;
begin
  result :=Copy(ClassName,2,char_length(ClassName));
end;

function TBusObjNDS.GetXML: string;
begin
  result:= XMLDoc.XML.Text;
end;

function TBusObjNDS.GetXMLDoc: TXMLDocument;
var
  node: IXMLNode;
begin
  if not Assigned(fXMLDoc) then Begin
    fXMLDoc := TXMLDocument.Create(self);
  end else Begin
    fXMLDoc.XML.Clear;
  end;

  fXMLDoc.Active := true;
  fXMLDoc.Version := XMLDocVersion;
  fXMLDoc.Encoding := XMLDocEncoding;
  { NOTE: Do not use doNodeAutoIndent option as this stuffs up XML
          comparison in business objects (indents are returned as Text nodes) }
//    doc.Options := doc.Options + [doNodeAutoIndent];
  node:= fXMLDoc.AddChild(XMLDocRoot);
//  node.Attributes['DataVersion'] := getUserVersion;
  node := node.Addchild(XMLDocRequest);
  node.Attributes['OnError'] := XMLDocRequestStopError;
  node.Attributes['DataObject'] := Self.ClassName;
  node:= node.AddChild(XMLNodeName);
  SaveToXMLNode(node);
  result:= fXMLDoc;
end;

procedure TBusObjNDS.SetXML(const Value: string);
var
  Doc: IXMLDocument;
  node: IXMLNode;
begin
  node := nil;
  doc:= TXMLDocument.Create(nil);
  try
    doc.LoadFromXML(Value);
    doc.Active:= true;
    if doc.ChildNodes.FindNode(XMLDocRoot) <> nil then begin
       node:= doc.ChildNodes.FindNode(XMLDocRoot);
//        if node.AttributeNodes.FindNode('DataVersion')<> nil  then
//            fsXMLDataVersion    := node.Attributes['DataVersion'];
    end;
//    fsXMLOnError := 'Stop';
//    if node.ChildNodes.FindNode(XMLDocRequest) <> nil then begin
//        node:= node.ChildNodes.FindNode(XMLDocRequest);
//        if node.AttributeNodes.FindNode('OnError')<> nil  then
//            fsXMLOnError        := node.Attributes['OnError'];
//        if node.AttributeNodes.FindNode('DataObject')<> nil  then
//            fsXMLSourceObject   := node.Attributes['DataObject'];
//    end;
    node:= node.ChildNodes.FindNode(XMLNodeName);
    {XML should have the root , xml request before the actual note. }
    if not Assigned(node) then begin
        Resultstatus.AddItem(False , rssWarning , BOR_XMLImport_ObjectNodeNotfound, XMLNodeName + ': Invalid XML format' , False);
        Exit;
    end;

    LoadFromXMLNode(node);
    //ImportFromXML(node);

  finally
//    Doc.Free;
  end;
end;

procedure TBusObjNDS.Load(const fIsReadonly:boolean =False);
begin
  inherited;
  Storer.Load(self);
  self.Dirty:= false;
end;

procedure TBusObjNDS.Load(const aId: integer;const fIsReadonly:boolean =False);
begin
  inherited;
  self.Id:= aId;
  Storer.Load(self);
  self.Dirty:= false;
end;

procedure TBusObjNDS.Assign(Source: TPersistent);
begin
  //inherited;
  fIgnoreAccesslevel:= TBusObjNDS(Source).IgnoreAccesslevel;
end;


function TBusObjNDS.GetPostList: TPostList;
begin
  if Assigned(fAssignedPostList) then
    result:= fAssignedPostList
  else if Assigned(Owner) and (Owner is TBusObjNDS) then
    result:=  TBusObjNDS(Owner).PostList
  else if Assigned(Owner) and (Owner is TBusObj) then
    result:=  TBusObj(Owner).PostList
  else begin
    if not Assigned(fPostList) then begin
        fPostList := TPostList.Create(self);
        fPostList.DBConnection := Storer.Connection;
    end;
    result := fPostList;
  end;
end;

procedure TBusObjNDS.SetPostList(const Value: TPostList);
begin
  fAssignedPostList:= Value;
end;

procedure TBusObjNDS.FilterSelect(FilterNode: IXMLNode);
var
  sql: string;
begin
  if LoadFilterParamsFromNode(self, FilterNode, self.LoadParamList, sql) then begin
    self.LoadSelect(sql);
  end;
end;

function TBusObjNDS.GetLoadParamList: TStringList;
begin
  if not Assigned(fParamList) then
    fParamList:= TStringList.Create;
  result:= fParamList;
end;

{ TMSBusObjNDS }

procedure TMSBusObjNDS.AssignGlobalRef;
begin
  if (self.Id > 0) and (GlobalRef = '') then begin
    if GlobalRef = AppEnv.Branch.SiteCode + IntToStr(Id) then Exit;
    GlobalRef:= AppEnv.Branch.SiteCode + IntToStr(Id);
  end;
end;

procedure TMSBusObjNDS.FlagAsUpdated(aTimeStamp: TDateTime = 0);
begin
  if aTimeStamp > 0 then
    self.msTimeStamp:= aTimeStamp
  else
    self.msTimeStamp:= now;
end;
Constructor TMSBusObjNDS.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    Self.msTimeStamp := 0;
end;
procedure TMSBusObjNDS.DoUpdateSiteCode;
begin
  MsUpdateSiteCode := AppEnv.Branch.SiteCode;
end;

function TMSBusObjNDS.GetGlobalRef: string;
begin
  result:= fGlobalRef;
end;

function TMSBusObjNDS.GetMsUpdateSiteCode: string;
begin
  result := fMsUpdateSiteCode;
end;

procedure TMSBusObjNDS.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'GlobalRef');

end;

procedure TMSBusObjNDS.logit(Printheader: boolean; Lognodename: String;
  Dochildren: Boolean);
begin

end;

procedure TMSBusObjNDS.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
//  AddXMLNode(node,GlobalRefTagInXML,GlobalRef);

end;

procedure TMSBusObjNDS.SetGlobalRef(const Value: string);
begin
  if value <> fGlobalRef then begin
    fGlobalRef:= value;
    Dirty:= true;
  end;
end;

procedure TMSBusObjNDS.SetmsTimeStamp(const Value: TDateTime);
var
  dt: TDateTime;
  year,month,day: word;
begin
  { NOTE: MySql timestamp fields can not be less than 1970 }
  dt:= value;
  DecodeDate(dt,year,month,day);
  if year < 1970 then begin
    dt:= EncodeDate(1970,month,day) + Frac(dt);
  end;
  if fmsTimeStamp <> dt then begin
    fmsTimeStamp := dt;
    Dirty:= true;
  end;
end;

procedure TMSBusObjNDS.SetMsUpdateSiteCode(const Value: string);
begin
  if fMsUpdateSiteCode <> Value then begin
    fMsUpdateSiteCode := Value;
    Dirty:= true;
  end;
end;

{ TBusObjStorer }

function TBusObjStorer.GetConnection: TERPConnection;
begin
  if Assigned(fAssignedConnection) then
    result:= fAssignedConnection
  else
    result:= CommonDbLib.GetSharedMyDacConnection;
end;

procedure TBusObjStorer.SetConnection(const Value: TERPConnection);
begin
  fAssignedConnection:= Value;
end;

procedure TBusObjStorer.Delete(Const obj: TBusObjNDS);
var
  cmd: TERPCommand;
begin

  if Obj.Id > 0 then begin
    cmd:= TERPCommand.Create(nil);
    try
      cmd.Connection:= Connection;
      cmd.SQL.Text:=
        'DELETE FROM `' + Obj.GetBusObjectTablename + '` WHERE `' + Obj.IDFieldName + '` = ' + IntToStr(Obj.Id)+';';
      cmd.SQL.Add(Obj.RelatedRecordsDeleteSQL);
      cmd.Execute;
      MultiEventObj.FireEvent(Self , Storer_Delete , '');
    finally
      FreeandNil(cmd);
    end;
    Obj.Id:= 0;
  end;
end;

destructor TBusObjStorer.Destroy;
begin
  Freeandnil(fMultiEventObj) ;
end;

procedure TBusObjStorer.Load(Const obj: TBusObjNDS; Const SelectSql: string = '');
var
  qry: TERPQuery;
  x: integer;
begin

  (*if (obj.Id > 0) then begin*)
    qry:= TERPQuery.Create(nil);
    qry.Connection:= Connection;
    try
      if SelectSql <> '' then
        qry.SQL.Text:=
          'SELECT * FROM `' + Obj.BusObjectTableName + '` WHERE ' + SelectSql
      else begin
        if (obj is TMSBusObjNDS) and (TMSBusObjNDS(obj).GlobalRef <> '') then
          qry.SQL.Text:=
            'SELECT * FROM `' + Obj.BusObjectTableName + '` WHERE `GlobalRef` = `' + TMSBusObjNDS(obj).GlobalRef + '`'
        else
          qry.SQL.Text:=
            'SELECT * FROM `' + Obj.BusObjectTableName + '` WHERE `' + Obj.IDFieldName + '` = ' + IntToStr(Obj.Id);
      end;
      if obj.LoadParamList.Count > 0 then begin
        for x:= 0 to obj.LoadParamList.Count-1 do begin
          qry.ParamByName(obj.LoadParamList.Names[x]).AsString:=
            obj.LoadParamList.Values[obj.LoadParamList.Names[x]];

        end;
      end;
      qry.Open;
      if not qry.IsEmpty then begin
        SetObjectPropertiesFromDataSet(obj, qry);
      end;
      qry.Close;
      obj.Dirty:= false;
    finally
      FreeAndNil(qry);
    end;
  (*end;*)
end;

procedure TBusObjStorer.LoadTree(Const obj: TBusObjNDSTree; Const SubTreeOnly: boolean = false; PartsourceStock:boolean = False);
var
  qry: TERPQuery;
  child, parent: TBusObjNDSTree;
  (*totQty:double;*)
  RootCaption:String;
begin
  if (obj.Id > 0) then begin
    qry:= TERPQuery.Create(nil);
    qry.Connection:= Connection;
    obj.Loading:= true;
    try
      qry.SQL.Text:=
        'SELECT * FROM `' + Obj.BusObjectTableName + '` WHERE `TreeRootId` = ' +
        IntToStr(Obj.RootNode.Id);
      if SubTreeOnly then
        qry.SQL.Add('AND `SequenceDown` >= ' + IntToStr(Obj.SequenceDown) +
        ' AND `SequenceUp` <= ' + IntToStr(Obj.SequenceUp));
      qry.SQL.Add('ORDER BY `SequenceDown`');
      if PartsourceStock then
        qry.SQL.Add('Limit 1');

//      qry.SQL.Add('ORDER BY `ProcTreeId`');
      qry.Open;
      if not qry.IsEmpty then begin
        (*Obj.StoreTotQty(totQty);   {modifying the tree for the part source should restore the root qty}*)
        SetObjectPropertiesFromDataSet(obj, qry);
        SetPropValue(Obj, 'Globalref','');
        SetPropValue(Obj, 'MsUpdateSitecode',AppEnv.Branch.SiteCode);
        (*obj.RestoreTotQty(totQty);*)
        if PartsourceStock then begin
          SetPropValue(Obj, 'PartSource','psStock')
        end else begin
          SetPropValue(Obj, 'PartSource','psNone')
        end;
        RootCaption :=  GetPropValue(Obj,'Caption');

        qry.Next;
        while (not qry.Eof) do begin
          child:= obj.MakeInstance;
          child.Loading := Obj.loading;
          SetObjectPropertiesFromDataSet(child, qry);
          SetPropValue(child, 'Globalref','');
          SetPropValue(child, 'MsUpdateSitecode',AppEnv.Branch.SiteCode);
          if PartsourceStock then begin
            SetPropValue(Obj, 'PartSource','psStock')
          end else begin
            SetPropValue(Obj, 'PartSource','psNone')
          end;

          (*obj.RestoreTotQty(totQty);*)
          { find parent node }
          parent:= obj.NodeById(child.ParentId);
          if Assigned(parent) then begin
            parent.Children.Add(child);
            parent.Dirty:= false;
            child.Dirty:= false;
            parent.Dirty:= false;
          end
          else begin
            if child.ParentId = obj.ParentId then begin
              { same parent soat same level ie obj has not sub nodes }
              FreeandNil(child);
              Break;
            end
            else begin
              obj.ResultStatus.AddItem(false, rssError, 0,
              'Error - LoadTree : Could not find parent node for item [' +
              obj.BusObjectTypeDescription+ ']:' + GetPropValue(child, 'Caption')+
              chr(13) + 'Root Node :' + RootCaption);
              FreeandNil(child);
              Break;
            end;
          end;
          Child.DoAfterLoad;
          qry.Next;
        end;
      end;
      qry.Close;
    finally
      FreeAndNil(qry);
      obj.Dirty:= false;
      obj.Loading:= false;
    end;
  end;
end;

procedure TBusObjStorer.LoadList(Const List: TBusObjNDSList);
var
  qry: TERPQuery;
  Cls: TPersistentClass;
  BusObj: TBusObjNDS;
begin
  Cls:= FindClass(List.ItemClassName);
  qry:= TERPQuery.Create(nil);
  qry.Connection:= Connection;
  try
    qry.SQL.Text:= List.LoadSql;
    qry.Open;
    while not qry.Eof do begin
      BusObj:= TBusObjNDS(TComponentClass(Cls).Create(nil));
      SetObjectPropertiesFromDataSet(BusObj, qry);
      List.Add(BusObj);
      BusObj.Dirty:= false;
      qry.Next;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TBusObjStorer.Save(Const obj: TBusObjNDS);
var
  cmd: TERPCommand;
  count, x: integer;
  PropList: PPropList;
  s: string;
  val: Variant;
  valStr: string;
  QuoteValue: boolean;

  function ObjCaption:String;
  var PropInfo: PPropInfo;
  begin
    result := '';
    PropInfo:= GetPropInfo(obj, 'Caption');
    if Assigned(PropInfo) then
      Result := GetPropValue(obj, 'Caption');
  end;

begin
  if (obj.Id > 0) and (not obj.Dirty) then
    exit;
  cmd:= TERPCommand.Create(nil);
  cmd.Connection:= Connection;
  Count := GetPropList(obj.ClassInfo, PropList);
  try
    s:= '';
    for x:= 0 to Count -1 do begin
      QuoteValue:= true;
      if (String(PropList[x].Name) = 'Name') or (String(PropList[x].Name) = 'Tag') or (PropList[x].SetProc = nil) then
        Continue;

      val:= GetPropValue(obj, String(PropList[x].Name));
        if (not VarIsNull(val)) and (not SaveExcludeList.Exists(obj,String(PropList[x].Name)))then begin
          if {VarIsType(val, varDate) or} (PropList[x].PropType^ = TypeInfo(TDateTime)) then
            valStr:= FormatDateTime(MysqlDateTimeFormat, val)
          else begin
            if VarIsType(val, varDouble) then
              QuoteValue:= false;

            if PropList[x].PropType^.Kind = tkEnumeration then begin
              if Val = 'True' then ValStr:= 'T'
              else if Val = 'False' then ValStr:= 'F'
              else ValStr:= val;
            end
            else
              valStr:= val;
          end;

          if s <> '' then s:= s + ', ';
          if PropList[x].PropType^.name= 'string' then valStr := StringReplace(valStr,'\','\\',[rfReplaceAll]);
          if QuoteValue then
            s:= s + '`' + String(PropList[x].Name) + '` = ' + QuotedStr(valStr)
          else
            s:= s + '`' + String(PropList[x].Name) + '` = ' + valStr;
        end;
    end;
    if s <> '' then begin
      if obj.Id > 0 then begin
        { object has id so existing record }
        s:= 'UPDATE `' + obj.BusObjectTableName + '` SET ' + s +
          ' WHERE `' + obj.IDFieldName + '` = ' + IntToStr(obj.Id);
      end
      else begin
        { new record }
        s:= 'INSERT INTO `' + obj.BusObjectTableName + '` SET ' + s;
      end;
      cmd.SQL.Text:= s;
      cmd.Execute;
      MultiEventObj.FireEvent(Self , Storer_Save , ObjCaption);
      if obj.Id < 1 then begin
        obj.Id:= cmd.InsertId;
        if (obj is TBusObjNDSTree) and (TBusObjNDSTree(obj).IsRoot) then begin
          { update the RootNodeId in the table }
          cmd.SQL.Text:=
            'UPDATE `' + obj.BusObjectTableName +
            '` SET `TreeRootId` = `ProcTreeId` WHERE `ProcTreeId` = ' + IntToStr(obj.Id);
          cmd.Execute;
        end;
      end;
    end;
  finally
    FreeandNil(cmd);
    FreeMem(PropList, Count * SizeOf(PPropInfo));
    obj.Dirty:= false;
  end;
end;

procedure TBusObjStorer.RunSQLCommand(const SQLStr: string);
var
  cmd: TERPCommand;
begin
  cmd:= TERPCommand.Create(nil);
  try
    cmd.Connection:= Connection;
    cmd.SQL.Text:= SQLStr;
    cmd.Execute;
  finally
    FreeandNil(cmd);
  end;
end;


function TBusObjStorer.getNewDataset(const SQLStr: String=''): TERPQuery;
var
  REsultQry: TERPQuery;
begin
  REsultQry:= TERPQuery.Create(nil);
  REsultQry.Connection:= Connection;
  if SQLStr <> '' then begin
    REsultQry.SQL.Text:= SQLStr;
    REsultQry.open;
  end;
  result := REsultQry;
end;

function TBusObjStorer.getMultiEventObj: TMultiEventClass;
begin
  if not(Assigned(fMultiEventObj)) then
    fMultiEventObj := TMultiEventClass.Create;
  Result := fMultiEventObj;
end;

constructor TBusObjStorer.Create;
begin
  inherited;
  fMultiEventObj := nil;
end;

{ TBusObjNDSTree }

constructor TBusObjNDSTree.Create(AOwner: TComponent);
begin
  inherited;
  fAutoResequence:= true;
  Loading:= false;
  fCleanTree:=nil;
  ISCleanTree:=False;
end;

destructor TBusObjNDSTree.Destroy;
(*var
  x:Integer;*)
begin
  (*if Children.Count >0  then
    for x:= Children.Count - 1 downto 0 do begin
      Children[x].Free;
    end;
  FreeandNil(fChildren);*)
  if Assigned(fcleantree) then
    FreeandNil(fcleantree);
  try  inherited;  Except end;
end;

procedure TBusObjNDSTree.DoAfterLoad;
begin

end;

function TBusObjNDSTree.getAnydirty: Boolean;
var
  x:Integer;
begin
  result := Dirty;
  if result then begin
    exit;
  end;
  if Children.Count > 0 then begin
    for x:= 0 to Children.Count -1 do begin
      result :=Children[x].Anydirty;
      if result then exit;
    end;
  end;
end;

procedure TBusObjNDSTree.LoadTree(Const SubTreeOnly: boolean = false; PartsourceStock :Boolean = False);
begin
  if (not CanRead) then begin
    self.ResultStatus.AddItem(false, rssError, 0, 'No rights to read ' +
      Self.BusObjectTypeDescription);
  end else begin
    Storer.LoadTree(self, SubTreeOnly , PartsourceStock);
  end;
end;

procedure TBusObjNDSTree.SetMasterId(const Value: integer);
begin
  if FMasterId <> Value then begin
    FMasterId := Value;
    Dirty:= True;
  end;
  if not IsRoot then
    RootNode.MasterId:= Value;
end;

function TBusObjNDSTree.GetMasterId: integer;
begin
  if IsRoot then
    result:= fMasterId
  else
    result:= RootNode.MasterId;
end;


procedure TBusObjNDSTree.SetMasterType(const Value: TMSBusObjMasterType);
begin
  if FMasterType <> Value then begin
    FMasterType := Value;
    Dirty:= true;
  end;
  if (not self.IsRoot) and (not self.Loading) then
    RootNode.MasterType:= Value;
end;

function TBusObjNDSTree.GetMasterType: TMSBusObjMasterType;
begin
  result:= fMasterType;
  if (not self.IsRoot) and Assigned(RootNode) then
    result:= RootNode.MasterType;
end;

procedure TBusObjNDSTree.SetParentId(const Value: integer);
begin
  if FParentId <> Value then begin
    FParentId := Value;
    Dirty:= true;
  end;
end;

procedure TBusObjNDSTree.SetSequenceDown(const Value: integer);
begin
  if FSequenceDown <> Value then begin
    FSequenceDown := Value;
    Dirty:= true;
  end;
end;

procedure TBusObjNDSTree.SetTreeRootId(const Value: integer);
begin

end;

function TBusObjNDSTree.GetIsRoot: boolean;
begin
  //result:= fParentId < 1;
  result:= (fParentId < 1) and ((not Assigned(Owner)) or (not (Owner is TBusObjNDSTree)));

end;

function TBusObjNDSTree.GetChiltren: TBusObjNDSTreeChildList;
begin
  if not Assigned(fChildren) then
    fChildren:= TBusObjNDSTreeChildList.Create(self);
  result:= fChildren;
end;

procedure TBusObjNDSTree.ResequenceTree;
var
  SeqNo: integer;
begin
  SeqNo:= -1;
//  RootNode.Resequence(SeqNo);
  SequenceTree(RootNode, SeqNo, 0);
end;

function TBusObjNDSTree.GetTreeRootId: integer;
begin
  if self.IsRoot then
    result:= ID
  else if Assigned(owner) and (Owner is TBusObjNDSTree) then
    result:= TBusObjNDSTree(owner).TreeRootId
  else
    raise Exception.Create('TBusObjNDSTree.GetTreeRootId: Unabe to find tree root node.');
end;

function TBusObjNDSTree.GetLoading: boolean;
begin
  if Assigned(Owner) and (Owner is TBusObjNDSTree) then
    result:= TBusObjNDSTree(Owner).Loading
  else
    result:= fLoading;
end;

procedure TBusObjNDSTree.SetLoading(const Value: boolean);
begin
  if Assigned(Owner) and (Owner is TBusObjNDSTree) then
    TBusObjNDSTree(Owner).Loading:= Value
  else
    fLoading:= Value;
end;

function TBusObjNDSTree.MakeInstance: TBusObjNDSTree;
var
  NodeClass: TBusObjNDSTreeClass;
begin
//  result:= TBusObjNDSTree(self.ClassType).Create(nil);
  NodeClass:= TBusObjNDSTreeClass(self.ClassType);
  result:= NodeClass.Create(nil);
end;

function TBusObjNDSTree.NodeById(Const aId: integer): TBusObjNDSTree;
var
  x: integer;
begin
  result:= nil;
  if self.Id = aId then
    result:= self
  else begin
    for x:= 0 to Children.Count - 1 do begin
      result:= Children[x].NodeById(aId);
      if Assigned(result) then
        break;
    end;
  end;
end;

function TBusObjNDSTree.OptionItem: Boolean;
begin
  Result := False;
end;

function TBusObjNDSTree.GetRootNode: TBusObjNDSTree;
begin
  result:= self;
  while Assigned(result.Owner) and (result.Owner is TBusObjNDSTree) do
    result:= TBusObjNDSTree(result.Owner);
  if not result.IsRoot then
    result:= nil;
end;

procedure TBusObjNDSTree.Resequence(var LastSequenceNo: integer);
var
  x: integer;
  obj: TBusObjNDSTree;
begin
  Inc(LastSequenceNo);
  self.SequenceDown:= LastSequenceNo;
  for x:= 0 to Children.Count -1 do
    Children[x].Resequence(LastSequenceNo);
  Inc(LastSequenceNo);
  self.SequenceUp:= LastSequenceNo;
  x:= 0;
  obj:= self;
  while Assigned(obj.Owner) and (obj.Owner is TBusObjNDSTree) do begin
    Inc(x);
    Obj:= TBusObjNDSTree(obj.Owner);
  end;
  fLevel:= x;
end;

procedure TBusObjNDSTree.SetSequenceUp(const Value: integer);
begin
  if FSequenceUp <> Value then begin
    FSequenceUp := Value;
    MakeDirty;
  end;
end;

function TBusObjNDSTree.Save: boolean;
begin
  if not self.TreeDirty then
    result:= true
  else begin
    result:= inherited Save;
    if not result then exit;
  end;
end;

function TBusObjNDSTree.SaveNoCheck: boolean;
var
  x: integer;
  s: string;
begin
  { if this is the root node update the current edit version }
  if IsRoot then begin
    Storer.MultiEventObj.FireEvent(Self , Storer_Save , 'Updating Edit Version'); UpdateEditVersion(EditVersion + 1);
    Storer.MultiEventObj.FireEvent(Self , Storer_Save , 'Sequencing the Tree'); ResequenceTree;
  end;
  result:= inherited SaveNoCheck;
  if not result then
    exit;

    if   (SourceFromStock) and (not(OptionItem))  then begin
     Deletetree;
    end else
      for x:= 0 to Children.Count -1 do
          Children[x].SaveNoCheck;


  { now delete any nodes that have been removed from tree }
  if IsRoot and (Id > 0) then begin


    s:= 'Select ' + IDFieldName + ' as ID FROM `' + BusObjectTableName +
    '` WHERE `TreeRootId` = ' + IntToStr(Id) +
    ' AND `EditVersion` <> ' + IntToStr(EditVersion);

    With Storer.getNewDataset(s) do try
      s:= GroupConcat('ID');
      if s <> '' then begin
        s:= 'Delete from `' + BusObjectTableName + '` where ' + IDFieldName + '  in (' + s+')';
        Storer.RunSQLCommand(s);
      end;
    finally
        if active then close;
        free;
    end;
  end;
  AfterSave;
end;

function TBusObjNDSTree.GetParentId: integer;
begin
  if Assigned(Owner) and (Owner is TBusObjNDSTree) then
    result:= TBusObjNDSTree(Owner).Id
  else
    result:= fParentId;
end;

function TBusObjNDSTree.Delete: boolean;
var
  x: integer;
begin
  result:= true;
  if (not CanDelete) then begin
    self.ResultStatus.AddItem(false, rssError, 0, 'No rights to delete ' +
      Self.BusObjectTypeDescription);
  end
  else begin
    for x:= 0 to Children.Count -1 do begin
      Children[x].DeleteNoCheck;
    end;
    DeleteNoCheck;
  end;
end;

procedure TBusObjNDSTree.DeleteNoCheck;
var x: integer;
begin
  for x:= 0 to Children.Count -1 do begin
    Children[x].DeleteNoCheck;
  end;
  inherited;
end;


procedure TBusObjNDSTree.SetEditVersion(const Value: integer);
begin
  if fEditVersion <> Value then begin
    fEditVersion := Value;
    MakeDirty;
  end;
end;

procedure TBusObjNDSTree.UpdateEditVersion(const VerNo: integer);
var
  x: integer;
begin
  EditVersion:= VerNo;
  for x:= 0 to Children.Count -1 do
    Children[x].UpdateEditVersion(VerNo);
end;

procedure TBusObjNDSTree.AfterSave;
begin
//
//  if (not self.Loading) and Assigned(RootNode) and (RootNode.Owner is TMSBusObj) then
  if isroot and (Owner is TMSBusObj) then
    TMSBusObj(RootNode.Owner).FlagAsUpdated;
end;

function TBusObjNDSTree.CleanTree: TBusObjNDSTree;
begin
  if fCleanTree = nil then begin
    fCleanTree:=MakeInstance;
    fCleanTree.ISCleanTree:=True;
    fCleanTree.Assign(Self);
  end;
  result := fCleanTree;
end;

procedure TBusObjNDSTree.ClearIds;
var
  x: integer;
begin
  self.Id:= 0;
  self.ParentId:= 0;
  for x:= 0 to Children.Count -1 do
    Children[x].ClearIds;
  MakeDirty;
end;


procedure TBusObjNDSTree.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

end;

procedure TBusObjNDSTree.SaveToXMLNode(const node: IXMLNode);
var
  ChildListNode: IXMLNode;
  x: integer;
begin
  inherited;
//  AddXMLNode(node,'ParentId',self.ParentId);
//  AddXMLNode(node,'TreeRootId',self.TreeRootId);
//  AddXMLNode(node,'SequenceDown',self.SequenceDown);
//  AddXMLNode(node,'SequenceUp',self.SequenceUp);
//  AddXMLNode(node,'EditVersion',self.EditVersion);
//  AddXMLNode(node,'MasterId',self.MasterId);
//  AddXMLNode(node,'MasterType',BusObjMasterTypeToStr(self.MasterType));

  ChildListNode:= node.AddChild('Children');
  for x:= 0 to self.Children.Count-1 do begin
    Children[x].SaveToXMLNode(ChildListNode.AddChild(Children[x].XMLNodeName));
  end;
end;

procedure TBusObjNDSTree.Load(const fIsReadonly:boolean =False);
begin
  if Assigned(fChildren) then
    fChildren.Clear;
  Isreadonly := fIsReadonly;
  self.LoadTree;
  CleanTree;
end;

procedure TBusObjNDSTree.Load(const aId: integer;const fIsReadonly:boolean =False);
begin
  //IsReadonly := fIsReadonly;
  //self.Id:= aId;
  //self.LoadTree;
  self.Id:= aId;
  Load(fIsReadonly);

end;

function TBusObjNDSTree.GetIndex: integer;
begin
  result:= -1;
  if Assigned(Owner) and (owner is TBusObjNDSTree) then begin
    result:= TBusObjNDSTree(Owner).Children.IndexOf(self);
  end;
end;

function TBusObjNDSTree.LevelStr: string;
begin
  if Assigned(Owner) and (Owner is TBusObjNDSTree) then
    result:= TBusObjNDSTree(Owner).LevelStr + '.' + IntToStr(Index + 1)
  else
    result:= '1';
end;

function TBusObjNDSTree.TreeDirty: Boolean;

  function SearchTree(const Node: TBusObjNDSTree): Boolean;
  var
    Index: Integer;
  begin
    Result := Node.Dirty;
    Index := 0;

    while (Index < Node.Children.Count) and (Result = False) do begin
      if Node.Children[Index].Children.Count > 0 then
        Result := SearchTree(Node.Children[Index])
      else
        Result := TBusObjNDSTree(Node.Children[Index]).Dirty;

      Inc(Index);
    end;
  end;
begin
  Result := SearchTree(Self);
end;

procedure TBusObjNDSTree.MakeDirty;
begin
  fDirty:= true;
(*  if (not self.Loading) and Assigned(RootNode) and (RootNode.Owner is TMSBusObj) then
    TMSBusObj(RootNode.Owner).FlagAsUpdated;*)
end;

procedure TBusObjNDSTree.Assign(Source: TPersistent);
var
  x: integer;
  child: TBusObjNDSTree;
begin
  inherited;
  if self.IsRoot then
    fMasterType:= TBusObjNDSTree(Source).MasterType;
  fSequenceDown:= TBusObjNDSTree(Source).SequenceDown;
  fSequenceUp:= TBusObjNDSTree(Source).SequenceUp;
    for x:= 0 to TBusObjNDSTree(Source).Children.Count -1 do begin
      child:= self.Children.Add;
      child.ISCleanTree:= ISCleanTree;
      child.Assign(TBusObjNDSTree(Source).Children[x]);
    end;
end;


procedure TBusObjNDSTree.New;
begin
  inherited;
  Children.Clear;
end;

procedure TBusObjNDSTree.SetLevel(const Value: integer);
begin
  if FLevel <> Value then begin
    FLevel := Value;
    MakeDirty
  end;
end;

function TBusObjNDSTree.SourceFromStock: Boolean;
begin
  REsult := false;
end;

procedure TBusObjNDSTree.Deletetree;
begin
  //descendants will override if required
end;

(*procedure TBusObjNDSTree.RestoreTotQty(var totQty: Double);
begin
  //descendats will override it
end;

procedure TBusObjNDSTree.StoreTotQty(var totQty: Double);
begin
  //descendats will override it
end;*)

{ TBusObjNDSTreeChildList }

constructor TBusObjNDSTreeChildList.Create(AOwner: TComponent);
begin
  inherited;
  List:= TObjectList.Create(false);
end;

destructor TBusObjNDSTreeChildList.Destroy;
begin
  FreeandNil(List);
  inherited;
end;

function TBusObjNDSTreeChildList.Add(Const obj: TBusObjNDSTree): integer;
begin
  self.Owner.InsertComponent(obj);
  result:= List.Add(obj);
  obj.FreeNotification(Self);
  SetOwnerValues(obj);
end;

function TBusObjNDSTreeChildList.Add: TBusObjNDSTree;
begin
  result:= TBusObjNDSTreeClass(TBusObjNDSTree(Owner).ClassType).Create(nil);
  Add(result);
end;

function TBusObjNDSTreeChildList.GetCount: integer;
begin
  result:= List.Count;
end;

function TBusObjNDSTreeChildList.GetItem(Const index: integer): TBusObjNDSTree;
begin
  result:= TBusObjNDSTree(List[index]);
end;

function TBusObjNDSTreeChildList.Insert(Const Index: integer): TBusObjNDSTree;
begin
  result:= TBusObjNDSTree(TBusObjNDSTree(Owner).ClassType).Create(Owner);
  Insert(Index, result);
end;

procedure TBusObjNDSTreeChildList.Insert(Const Index: integer; Const obj: TBusObjNDSTree);
begin
  self.Owner.InsertComponent(obj);
  List.Insert(Index, Obj);
  obj.FreeNotification(Self);
  SetOwnerValues(obj);
end;

procedure TBusObjNDSTreeChildList.Remove(Const Index: integer);
begin
  Owner.RemoveComponent(Item[Index]);
  List.Delete(index);
  TBusObjNDSTree(Owner).Dirty:= true;
end;

procedure TBusObjNDSTreeChildList.Delete(Const Index: integer);
begin
  self.Item[index].Free;
  TBusObjNDSTree(Owner).Dirty:= true;
end;

procedure TBusObjNDSTreeChildList.Remove(Const obj: TBusObjNDSTree);
begin
  Remove(List.IndexOf(obj));
end;

procedure TBusObjNDSTreeChildList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (not (csDestroying in owner.ComponentState)) and
   (AComponent is TBusObjNDSTree) and (csDestroying in AComponent.ComponentState) and
     (Operation = opRemove) then begin
    List.Remove(AComponent);
  end;
end;

procedure TBusObjNDSTreeChildList.Clear;
begin
//  while Count > 0 do
//    self.Delete(0);
  while count > 0 do begin
    List[0].Free;
  end;
  TBusObjNDSTree(Owner).Dirty:= true;
end;

procedure TBusObjNDSTreeChildList.SetOwnerValues(Const obj: TBusObjNDSTree);
begin
  if not TBusObjNDSTree(Owner).Loading then begin
    obj.ParentId:= TBusObjNDSTree(Owner).Id;
    obj.MasterId:= TBusObjNDSTree(Owner).MasterId;
    obj.MasterType:= TBusObjNDSTree(Owner).MasterType;
    obj.TreeRootId:= TBusObjNDSTree(Owner).TreeRootId;
    TBusObjNDSTree(Owner).Dirty:= true;
  end;
end;

function TBusObjNDSTreeChildList.IndexOf(Const obj: TBusObjNDSTree): integer;
begin
  result:= self.List.IndexOf(obj);
end;

{ TBusObjNDSList }

constructor TBusObjNDSList.Create(AOwner: TBusObjNDS);
begin
  inherited Create;
  fOwner:= AOwner;
  fDirty:= false;
  List:= TObjectList.Create(false);
end;

destructor TBusObjNDSList.Destroy;
begin
  FreeandNil(List);
  inherited;
end;

function TBusObjNDSList.Add(Const BusObj: TBusObjNDS): integer;
begin
  result:= List.Add(BusObj);
  fOwner.InsertComponent(BusObj);
  fDirty:= true;
//  TBusObjNDS(fOwner).Dirty:= true;
end;


function TBusObjNDSList.Count: integer;
begin
  result:= List.Count;
end;

procedure TBusObjNDSList.Delete(Const BusObj: TBusObjNDS);
begin
  List.Delete(List.IndexOf(BusObj));
  fDirty:= true;
//  TBusObjNDS(fOwner).Dirty:= true;
end;

function TBusObjNDSList.GetItem(Const index: integer): TBusObjNDS;
begin
  result:= TBusObjNDS(List[index]);
end;

procedure TBusObjNDSList.Clear(const DeleteFromDb: boolean = false);
begin
  while List.Count > 0 do begin
    Clear(DeleteFromDB, 0);
  end;
  fDirty:= true;
//  TBusObjNDS(fOwner).Dirty:= true;
end;
procedure TBusObjNDSList.Clear(const DeleteFromDB: Boolean; DeleteRow: Integer);
begin
    if DeleteFromDb and (Item[Deleterow].Id > Deleterow) then
      Item[Deleterow].DeleteNoCheck;
    List[Deleterow].Free;
    List.Delete(Deleterow);
end;

function TBusObjNDSList.GetDirty: boolean;
var
  x: integer;
begin
  result:= fDirty;
  if not result then begin
    for x:= 0 to self.Count -1 do begin
      if self.Item[x].Dirty then begin
        result:= true;
        break;
      end;
    end;
  end;
end;

procedure TBusObjNDSList.SetDirty(const Value: boolean);
var
  x: integer;
begin
  fDirty:= Value;
  for x:= 0 to self.Count -1 do
    self.Item[x].Dirty:= Value;
end;

end.





