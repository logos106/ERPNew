unit daBase;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/11/05 1.00.00  MV   Initial version.
 02/12/05 1.00.01  MV   Added Date and Description to daBase and renamed ClassName
                        field of tblda to ObjectClass to prevent issues with any
                        reference to ClassName.
 07/12/05 1.00.02  MV   Added dynamic database creation of tmp tables for UDD Data.
 08/12/05 1.00.03  MV   Added Selection property to TdaCustPropList class for printing
                        purpose.
 24/03/06 1.00.04  AL   Now xml nodes named not just "Property", but "Property1" 2,3 ....
                        Detail object now have fID
                        Added CompareXMLDocs, CompareXMLNodes functions
                       ALXMLDoc, CleanXMLDoc properties
                        All above changes needed to determine changes made by user
                        when saving data and to put record to AuditTrail about changes
}

interface

uses
  Classes, Contnrs, MyAccess, SysUtils, DB, ALXmlDoc;

type

  TdaXMLBase = class(TComponent)
  private
    function GetXML: string;
    procedure SetXML(const Value: string);
    function GetCleanXMLDoc: TALXMLDocument;
    function GetXMLDoc: TALXMLDocument;
    function GetCleanXMLNode: TALXMLNode;
  protected
    fCleanXMLDoc: TALXMLDocument;
    procedure SaveToXMLNode(const node: TALXMLNode); virtual;
    procedure LoadFromXMLNode(const node: TALXMLNode); virtual;
    function CompareXMLDocs(const d1, d2: TALXMLDocument): boolean;
    function CompareXMLNodes(const n1, n2: TALXMLNode; var DiffList: TStringList): boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property XML: string read GetXML write SetXML;
    property XMLDoc: TALXMLDocument read GetXMLDoc;
    property CleanXMLDoc: TALXMLDocument read GetCleanXMLDoc;
    property CleanXMLNode: TALXMLNode read GetCleanXMLNode;
  end;

  TdaBase = class(TdaXMLBase)
  private
    fID: integer;
    fDate: TDateTime;
    fDescription: string;
    fParentID: integer;
    fDirty: boolean;
    fActive: boolean;
    fTypeName: string;
    fMyConnection :TMyConnection;
    procedure SetID(const Value: integer); virtual;
    procedure SetParentID(const Value: integer);
    procedure SetXML(const Value: string);
    function GetID: integer;
    function GetParentID: integer;
    function GetXML: string;
    function GetDirty: boolean;
    procedure SetDirty(const Value: boolean);
    function GetDate: TDateTime;
    function GetDescription: string;
    procedure SetDate(const Value: TDateTime);
    procedure SetDescription(const Value: string);
  protected
    procedure SaveToXMLNode(const node: TALXMLNode); override;
    procedure LoadFromXMLNode(const node: TALXMLNode); override;
    function GetTypeName: string; 
    procedure SetTypeName(const Value: string); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Validate(var Msg: string): boolean; 
    property ID: integer read GetID write SetID;
    Property connection : TMyConnection read fMyConnection write fMyConnection;
    property Date: TDateTime read GetDate write SetDate;
    property Description: string read GetDescription write SetDescription;
    property ParentID: integer read GetParentID write SetParentID;
    property TypeName: string read GetTypeName write SetTypeName;
    property XML: string read GetXML write SetXML;
    property Dirty: boolean read GetDirty write SetDirty;
    property Active: boolean read fActive write fActive;
    procedure Load; virtual;
    procedure Save;
    procedure New; virtual;
  end;

  TdaStorer = class(TComponent)
  private
    Connection: TMyConnection;
    Qry: TMyQuery;
  protected
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Save(const da: TdaBase);
    procedure Load(const da: TdaBase);
  end;

  TdaCustPropDataType = (cdtString, cdtInteger, cdtDouble, cdtBoolen, cdtDateTime, cdtList);

  TdaCustPropParams = class;

  TdaCustPropDef = class(TdaBase)
  private
    fPropName: string;
    fCaption: string;
    fDataType: TdaCustPropDataType;
    fIsRequired: boolean;
    fIsActive: boolean;
    fDefaultValue: string;
    fIsNew: boolean;
    fParams: TdaCustPropParams;
    procedure SetPropName(const Value: string);
    procedure SetCaption(const Value: string);
    procedure SetDataType(const Value: TdaCustPropDataType);
    procedure SetDefaultValue(const Value: string);
    function GetPropName: string;
    function GetCaption: string;
    function GetDataType: TdaCustPropDataType;
    function GetDefaultValue: string;
  protected
    procedure SaveToXMLNode(const node: TALXMLNode); override;
    procedure LoadFromXMLNode(const node: TALXMLNode); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property PropName: string read GetPropName write SetPropName;
    property Caption: string read GetCaption write SetCaption;
    property DataType: TdaCustPropDataType read GetDataType write SetDataType;
    property IsRequired: boolean read fIsRequired write fIsRequired;
    property IsActive: boolean read fIsActive write fIsActive;
    property DefaultValue: string read GetDefaultValue write SetDefaultValue;
    property IsNew: boolean read fIsNew write fIsNew;
    property Params: TdaCustPropParams read fParams write fParams;
  end;

  TdaCustPropParams = class(TdaXMLBase)
  private
    fListValues: string;
    fUserCanEditList: boolean;
  protected
    procedure SaveToXMLNode(const node: TALXMLNode); override;
    procedure LoadFromXMLNode(const node: TALXMLNode); override;
  public
    property ListValues: string read fListValues write fListValues;
    property UserCanEditList: boolean read fUserCanEditList write fUserCanEditList;
  end;

  TdaCustPropDefList = class(TdaBase)
  private
    fList: TObjectList;
    function GetItem(const index: integer): TdaCustPropDef;
    function GetCount: integer;
  protected
    procedure SaveToXMLNode(const node: TALXMLNode); override;
    procedure LoadFromXMLNode(const node: TALXMLNode); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Delete(const index: integer);
    function Add: TdaCustPropDef;
    property Item[const index: integer]: TdaCustPropDef read GetItem;
    property Count: integer read GetCount;
  end;

  TdaCustProp = class(TdaBase)
  private
    fPropName: string;
    fValue: string;
    function GetAsBoolean: boolean;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: double;
    function GetAsInteger: integer;
    function GetPropName: string;
    function GetValue: string;
    procedure SetAsBoolean(const Value: boolean);
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsFloat(const Value: double);
    procedure SetAsInteger(const Value: integer);
    procedure SetPropName(const Value: string);
    procedure SetValue(const Value: string);
  protected
    procedure SaveToXMLNode(const node: TALXMLNode); override;
    procedure LoadFromXMLNode(const node: TALXMLNode); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property PropName: string read GetPropName write SetPropName;
    property Value: string read GetValue write SetValue;
    property AsInteger: integer read GetAsInteger write SetAsInteger;
    property AsFloat: double read GetAsFloat write SetAsFloat;
    property AsBoolean: boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
  end;

  TdaCustPropList = class(TdaBase)
  private
    fList: TObjectList;
    fSelected: boolean;
    fCustPropDefs: TdaCustPropDefList;
    function GetByName(const aPropName: string): TdaCustProp;
    function GetItem(const index: integer): TdaCustProp;
    procedure InitiliseProperties;
    function GetCount: integer;
  protected
    fID : integer;
    procedure SaveToXMLNode(const node: TALXMLNode); override;
    procedure LoadFromXMLNode(const node: TALXMLNode); override;
    procedure Delete(const index: integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Item[const index: integer]: TdaCustProp read GetItem; default;
    property ByName[const aPropName: string]: TdaCustProp read GetByName;
    property CustPropDefs: TdaCustPropDefList read fCustPropDefs write fCustPropDefs;
    function Add: TdaCustProp;
    property Selected: boolean read fSelected write fSelected;
    property Count : integer read GetCount;
  end;

  TdaMDCustPropDefList = class;
  TdaMDCustBaseList    = class;

  TdaMDCustBase = class(TdaBase)
  private
    fDetail: TdaMDCustBaseList;
    fMaster: TdaCustPropList;
    fMDCustPropDefs: TdaMDCustPropDefList;
    fda :TMyQuery;
    function GetMDCustPropDefs: TdaMDCustPropDefList;
    function GetDetail: TdaMDCustBaseList;
    procedure SetID(const Value: integer); Override;
  protected
    procedure SaveToXMLNode(const node: TALXMLNode); override;
    procedure LoadFromXMLNode(const node: TALXMLNode); override;
    procedure SetTypeName(const Value: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Load; override;
    procedure New; override;
    property MDCustPropDefs: TdaMDCustPropDefList read GetMDCustPropDefs;
    property Detail: TdaMDCustBaseList read GetDetail;
    property Master: TdaCustPropList read fMaster;

  end;

  TdaMDCustPropDefList = class(TdaBase)
  private
    fMasterDefs: TdaCustPropDefList;
    fDetailDefs: TdaCustPropDefList;
    //fCustPropDefs: TdaCustPropDefList;
    function GetDetailDefs: TdaCustPropDefList;
    function GetMasterDefs: TdaCustPropDefList;
  protected
    procedure SaveToXMLNode(const node: TALXMLNode); override;
    procedure LoadFromXMLNode(const node: TALXMLNode); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property MasterDefs: TdaCustPropDefList read GetMasterDefs;
    property DetailDefs: TdaCustPropDefList read GetDetailDefs;
  end;

  TdaMDCustBaseList = class(TdaXMLBase)
  private
    fList: TObjectList;
    fItemDefs: TdaCustPropDefList;
    fLastID : integer;
    function GetItem(const index: integer): TdaCustPropList;
    function GetCount: integer;
  protected
    procedure SaveToXMLNode(const node: TALXMLNode); override;
    procedure LoadFromXMLNode(const node: TALXMLNode); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Add: TdaCustPropList;
    function Insert(const Index : integer) : TdaCustPropList;
    procedure Delete(const index: integer);
    property Item[const index: integer]: TdaCustPropList read GetItem; default;
    procedure Clear;
    property Count: integer read GetCount;
    property ItemDefs: TdaCustPropDefList read fItemDefs write fItemDefs;
  end;

function CreateUDDTemporaryTable(const CategoryName: string; const TempTable: boolean; var ErrMsg :String ): string;
function FieldToSQL(const Def: TdaCustPropDef): string;

implementation

uses
  CommonDbLib, CommonLib,Variants, BusObjAudit, FastFuncs;

function FieldToSQL(const Def: TdaCustPropDef): string;
begin
  Result := '`' + Def.PropName + '`';
  if Def.PropName = '' then Exit;
  case Def.DataType of
    cdtString: Result := Result + ' VARCHAR(255)';
    cdtInteger: Result := Result + ' INT';
    cdtDouble: Result := Result + ' DOUBLE';
    cdtBoolen: Result := Result + ' ENUM("True","False")';
    cdtDateTime: Result := Result + ' DATETIME';
    cdtList: Result := Result + ' VARCHAR(255)';
  end;
  if Result = '`' + Def.PropName + '`' then REsult := ''
  else begin
    if Def.fIsRequired then Result := Result + ' NOT NULL';
    if Def.DefaultValue <> '' then Result := Result + ' DEFAULT ' + QuotedStr(Def.DefaultValue);
  end;
end;

function CreateUDDTemporaryTable(const CategoryName: string; const TempTable: boolean; var ErrMsg :String ): string;
var
  MDDef: TdaMDCustPropDefList;
  qryTemp: TMyQuery;
  LoopDefs: integer;
  TempTableName: string;
  NewField: string;
begin
  if not TempTable then TempTableName := 'tmp_' + CategoryName +''
  else TempTableName := GetUserTemporaryTableName('tbl' + CategoryName+'');

  // Return tblname for destruction if required.
  Result := TempTableName;

  // Initialise MasterDetail Object
  MDDef := TdaMDCustPropDefList.Create(nil);
  MDDef.TypeName := CategoryName;
  MDDef.Load;

  Try
      // Initialise query
      qryTemp := TMyQuery.Create(nil);
      qryTemp.Options.FlatBuffers := True;
      qryTemp.Connection := CommonDbLib.GetSharedMyDacConnection;

      // Delete old table and replace with new table
      qryTemp.SQL.Add('DROP TABLE IF EXISTS `' + TempTableName + '`;');
      qryTemp.Execute;

      qryTemp.SQL.Clear;
      try
        qryTemp.SQL.Add('CREATE TABLE `' + TempTableName + '` (');

        // Get master fields
        for LoopDefs := 0 to MDDef.fMasterDefs.Count - 1 do begin
          NewField := FieldToSQL(MDDef.fMasterDefs.Item[LoopDefs]);
          NewField := NewField + ',';
          qryTemp.SQL.Add(NewField);
        end;

        // Get detail fields
        for LoopDefs := 0 to MDDef.DetailDefs.Count - 1 do begin
          NewField := FieldToSQL(MDDef.DetailDefs.Item[LoopDefs]);
            if newfield = '``' then begin
                ErrMsg := 'The property name should not be blank.';
                Result := '';
                exit;
            end else if newfield = '' then begin
                    ErrMsg := 'The Data Type should not be blank';
                    Result := '';
                    exit;
            end else begin
               if LoopDefs <> MDDef.DetailDefs.Count - 1 then NewField := NewField + ',';
                qryTemp.SQL.Add(NewField);
            end;
        end;
        qryTemp.SQL.Add(') TYPE=MyISAM;');
        qryTemp.Execute;

      finally
        FreeAndNil(qryTemp);
        FreeandNil(MDDef);
      end;
  Except
      on E:Exception do begin
           Result := '';
           ErrMsg := e.Message;
           ErrMsg := ReplaceStr(ErrMsg , 'column name' , 'Property Name');
           Exit;
      end ;
  End;
end;

{ TdaXMLBase }

function TdaXMLBase.CompareXMLDocs(const d1, d2: TALXMLDocument): boolean;
var
  sl: TStringList;
  Audit:  TAudit;
  n1, n2, IDNode: TALXMLNode;
  ID: integer;
  TransType: string;

begin
  n1 := nil;
  n2 := nil;
  result:= true;
  sl:= TStringList.Create;
  try

    if d1.ChildNodes.Count > 0 then
      n1:= d1.ChildNodes[0];
    if d2.ChildNodes.Count > 0 then
      n2:= d2.ChildNodes[0];


    if not CompareXMLNodes(n1,n2, sl) then
    begin
      result:= false;
      ID:= 0;
      if Assigned(n1) then
      begin
        TransType:= n1.NodeName;
        IDNode:= n1.ChildNodes.FindNode('id');
        if Assigned(IDNode) then
          ID:= IDNode.NodeValue;
      end
      else if Assigned(n2) then
      begin
        TransType:= n2.NodeName;
        IDNode:= n2.ChildNodes.FindNode('id');
        if Assigned(IDNode) then
          ID:= IDNode.NodeValue;
      end;

      Audit:= TAudit.Create(nil);
      try
        Audit.Load(0);      
        Audit.New;
        Audit.TransType:= TransType;
        Audit.TransID:= ID;;
        Audit.DataDescription:= 'Main';
        Audit.AuditDate:= now;
        Audit.ChangeDescription:= sl.Text;
        Audit.Save;
      finally
        FreeandNil(Audit);
      end;
    end;

  finally
    FreeandNil(sl);
  end;

end;

function TdaXMLBase.CompareXMLNodes(const n1, n2: TALXMLNode; var DiffList: TStringList): boolean;
var
  nl1, nl2: TList;
  node, IDNode: TALXMLNode;
  s: string;
  x, NodeIndex: integer;
  TransType: string;

  function FindNodeIndex(node: TALXMLNode; list: TList): integer;
  var
    x: integer;
    IDNode1, IDNode2: TALXMLNode;
  begin
    result:= -1;
    IDNode1:= node.ChildNodes.FindNode('id');
    if Assigned(IDNode1) then
    begin
      for x:= 0 to list.Count -1 do
      begin
        IDNode2:= TALXMLNode(list[x]).ChildNodes.FindNode('id');
        if Assigned(IDNode2) and (IDNode2.NodeValue = IDNode1.NodeValue) then
        begin
          result:= x;
          Break;
        end;
      end;
    end;
  end;

begin
  result:= true;
  nl1:= TList.Create;
  nl2:= TList.Create;
  try
    TransType:= '';
    if Assigned(n1) then
    begin
      if not Assigned(n2) then
      begin
        s:= n1.NodeName + ' - Deleted';
        DiffList.Add(s);
        result:= false;
      end
      else
      begin
        { build lists of nodes that represent business objects }
        for x:= 0 to n1.ChildNodes.Count -1 do
        begin
          if (not n1.ChildNodes[x].IsTextElement) and
             (n1.ChildNodes[x].HasChildNodes) then
          begin
//            IDNode:= n1.ChildNodes[x];
            IDNode:= n1.ChildNodes[x].ChildNodes.FindNode('id'); //lowercase Please
            if Assigned(IDNode) then
              nl1.Add(Pointer(n1.ChildNodes[x]));
          end;
        end;
        for x:= 0 to n2.ChildNodes.Count -1 do
        begin
          if (not n2.ChildNodes[x].IsTextElement) and
             (n2.ChildNodes[x].HasChildNodes) then
          begin
            IDNode:= n2.ChildNodes[x].ChildNodes.FindNode('id'); //lowercase Please
            if Assigned(IDNode) then
              nl2.Add(Pointer(n2.ChildNodes[x]));
          end;
        end;

        for x:= 0 to n1.ChildNodes.Count -1 do
        begin
          node:= n2.ChildNodes.FindNode(n1.ChildNodes[x].NodeName);
          if not Assigned(node) then
          begin
            { same child node not found in n2 }
            if TransType = '' then
            begin
              TransType:= n1.NodeName;
              DiffList.Add(TransType);
            end;
            s:= '  ' + n1.ChildNodes[x].NodeName + ' - Deleted';
            DiffList.Add(s);
            result:= false;
          end
          else
          begin
            { found node with same name in n2 }
            if n1.ChildNodes[x].IsTextElement or
              (not n1.ChildNodes[x].HasChildNodes) then
            begin
              { text element, so compare text element values }
              try
                if (not VarIsNull(n1.ChildNodes[x].NodeValue)) and (n1.ChildNodes[x].NodeValue <> node.NodeValue) then
                begin
                  if TransType = '' then
                  begin
                    TransType:= n1.NodeName;
                    DiffList.Add(TransType);
                  end;
                  s:= '  ' + n1.ChildNodes[x].NodeName + ' - Old Value = "'+
                    n1.ChildNodes[x].NodeValue + '" New Value = "' +
                    node.NodeValue + '"';
                  DiffList.Add(s);
                  result:= false;
                end;
              except
                // This is here to trap child nodes that dont have any children
                //   eg Invoice Lines node without any lines
              end;
            end
            else
            begin
              { not a text element }
              if nl1.IndexOf(Pointer(n1.ChildNodes[x])) < 0 then
              begin
                { a non business object node (no ID) so compare }
                if not CompareXMLNodes(n1.ChildNodes[x], node, DiffList) then
                  result:= false;
              end;
            end;
          end;
        end;

        { compare bus obj objects between lists }
        for x:= 0 to nl1.Count -1 do
        begin
          NodeIndex:= FindNodeIndex(TALXMLNode(nl1[x]), nl2);
          if NodeIndex > -1 then
          begin
            if not CompareXMLNodes(TALXMLNode(nl1[x]), TALXMLNode(nl2[NodeIndex]),DiffList) then
              result:= false;
          end
          else
          begin
            { not found }
            s:= TALXMLNode(nl1[x]).NodeName + ' - Deleted';
            DiffList.Add(s);
            result:= false;
          end;
        end;
        for x:= 0 to nl2.Count -1 do
        begin
          if FindNodeIndex(TALXMLNode(nl2[x]), nl1) < 0 then
          begin
            s:= TALXMLNode(nl2[x]).NodeName + ' - Added';
            DiffList.Add(s);
            result:= false;
          end;
        end;
      end;
    end
    else if Assigned(n2) then
    begin
      { n2 has been added }
      s:= n2.NodeName + ' - Added';
      DiffList.Add(s);
      result:= false;
    end;
  finally
    FreeandNil(nl1);
    FreeandNil(nl2);
  end;

end;

constructor TdaXMLBase.Create(AOwner: TComponent);
begin
  inherited;
  fCleanXMLDoc:= TALXMLDocument.Create(nil);
  fCleanXMLDoc.Active := true;
end;

destructor TdaXMLBase.Destroy;
begin
  fCleanXMLDoc.Free;
  inherited;
end;

function TdaXMLBase.GetCleanXMLDoc: TALXMLDocument;
begin
  result:= fCleanXMLDoc;
end;

function TdaXMLBase.GetCleanXMLNode: TALXMLNode;
var
  node: TALXMLNode;
begin
  result:= nil;
  if Assigned(fCleanXMLDoc) then
  begin
    node:= fCleanXMLDoc.ChildNodes.FindNode(FastFuncs.LowerCase(Copy(Self.ClassName,2,FastFuncs.StrLength(Self.ClassName))));
    if Assigned(node) then
      result:= node;
  end;
end;

function TdaXMLBase.GetXML: string;
var
  XMLDoc: TALXMLDocument;
  node: TALXMLNode;
begin
  XMLDoc := TALXMLDocument.Create(nil);
  try
    XMLDoc.Active := true;
    node          := XMLDoc.AddChild(FastFuncs.LowerCase(Self.ClassName));
    SaveToXMLNode(node);
    Result := XMLDoc.XML.Text;
  finally
    XMLDoc.Free;
  end;
end;

function TdaXMLBase.GetXMLDoc: TALXMLDocument;
var
  Doc: TALXMLDocument;
  node: TALXMLNode;
begin
  doc:= TALXMLDocument.Create('');
  try
    doc.Active := true;
    node:= doc.AddChild(FastFuncs.LowerCase(Copy(Self.ClassName,2,FastFuncs.StrLength(ClassName))));
    SaveToXMLNode(node);

    result:= Doc;

  finally
    Doc.Free;
  end;
end;

procedure TdaXMLBase.LoadFromXMLNode(const node: TALXMLNode);
begin
end;

procedure TdaXMLBase.SaveToXMLNode(const node: TALXMLNode);
begin
end;

procedure TdaXMLBase.SetXML(const Value: string);
var
  XMLDoc: TALXMLDocument;
  node: TALXMLNode;
begin
  XMLDoc := TALXMLDocument.Create(nil);
  try
    XMLDoc.XML.Text := Value;
    XMLDoc.Active := true;
    node := XMLDoc.ChildNodes.FindNode(FastFuncs.LowerCase(Self.ClassName));
    if Assigned(node) then LoadFromXMLNode(node);
  finally
    XMLDoc.Free;
  end;
end;


{
--------------------------------------------------------------------------------
  TdaBase class
--------------------------------------------------------------------------------
}
constructor TdaBase.Create(AOwner: TComponent);
begin
  inherited;
  fMyConnection := nil;
end;

destructor TdaBase.Destroy;
begin
  inherited;
end;

procedure TdaBase.SetID(const Value: integer);
begin
  if fID <> Value then fID := Value;
end;

function TdaBase.GetID: integer;
begin
  Result := fID;
end;

procedure TdaBase.SetParentID(const Value: integer);
begin
  if fParentID <> Value then fParentID := Value;
end;

function TdaBase.GetParentID: integer;
begin
  Result := fParentID;
end;

procedure TdaBase.SetXML(const Value: string);
begin
  inherited;
end;

function TdaBase.GetXML: string;
begin
  Result := inherited GetXML;
end;

procedure TdaBase.SaveToXMLNode(const node: TALXMLNode);
begin
  // implement in descentant classes
end;

procedure TdaBase.LoadFromXMLNode(const node: TALXMLNode);
begin
  // implement in descendant classes
end;

function TdaBase.Validate(var Msg: string): boolean;
begin
  Result := true; // Set True case validation not used
end;

procedure TdaBase.Load;
var
  storer: TdaStorer;
begin
  storer := TdaStorer.Create(nil);
  try
    storer.Load(self);

    Try
      fCleanXMLDoc.ChildNodes.Clear;
      fCleanXMLDoc.XML.Text:= XMLDoc.XML.Text;
      fCleanXMLDoc.Active:= true;
    Except
        // Creates an exception if the object doesn;t have an Id
        // eg: object of TBusObj directly.
    end;

  finally
    FreeandNil(storer);
  end;
end;

procedure TdaBase.Save;
var
  storer: TdaStorer;
begin
  storer := TdaStorer.Create(nil);
  try
    storer.Save(self);
    CompareXMLDocs(CleanXMLDoc,XMLDoc);
  finally
    FreeandNil(storer);
  end;
end;

function TdaBase.GetTypeName: string;
begin
  Result := fTypeName;
end;

procedure TdaBase.SetTypeName(const Value: string);
begin
  fTypeName := Value;
end;

function TdaBase.GetDirty: boolean;
var
  x: integer;
begin
  if not fDirty then begin
    for x := 0 to Self.ComponentCount - 1 do begin
      if (Self.Components[x] is TdaBase) and (TdaBase(Self.Components[x]).Dirty) then begin
        fDirty := true;
        Break;
      end;
    end;
  end;
  Result := fDirty;
end;

procedure TdaBase.SetDirty(const Value: boolean);
var
  x: integer;
begin
  fDirty := Value;
  if fDirty = false then begin
    for x := 0 to Self.ComponentCount - 1 do begin
      if (Self.Components[x] is TdaBase) and (TdaBase(Self.Components[x]).Dirty) then begin
        TdaBase(Self.Components[x]).Dirty := false;
      end;
    end;
  end;
end;

procedure TdaBase.New;
begin
  // implement in descendant classes
end;

function TdaBase.GetDate: TDateTime;
begin
  Result := fDate;
end;

function TdaBase.GetDescription: string;
begin
  Result := fDescription;
end;

procedure TdaBase.SetDate(const Value: TDateTime);
begin
  if fDate <> Value then fDate := Value;
end;

procedure TdaBase.SetDescription(const Value: string);
begin
  if fDescription <> Value then fDescription := Value;
end;

{
--------------------------------------------------------------------------------
  TdaCustPropDef class
--------------------------------------------------------------------------------
}
constructor TdaCustPropDef.Create(AOwner: TComponent);
begin
  inherited;
  fParams := TdaCustPropParams.Create(self);
end;

destructor TdaCustPropDef.Destroy;
begin
  inherited;
end;

procedure TdaCustPropDef.SetPropName(const Value: string);
begin
  if fPropName <> Value then fPropName := Value;
end;

function TdaCustPropDef.GetPropName: string;
begin
  Result := fPropName;
end;

procedure TdaCustPropDef.SetCaption(const Value: string);
begin
  if fCaption <> Value then fCaption := Value;
end;

function TdaCustPropDef.GetCaption: string;
begin
  Result := fCaption;
end;

procedure TdaCustPropDef.SetDataType(const Value: TdaCustPropDataType);
begin
  if (fDataType <> Value) then fDataType := Value;
end;

function TdaCustPropDef.GetDataType: TdaCustPropDataType;
begin
  Result := fDataType;
end;

procedure TdaCustPropDef.SetDefaultValue(const Value: string);
begin
  if (fDefaultValue <> Value) then fDefaultValue := Value;
end;

function TdaCustPropDef.GetDefaultValue: string;
begin
  Result := fDefaultValue;
end;

procedure TdaCustPropDef.SaveToXMLNode(const node: TALXMLNode);
var
  SubNode: TALXMLNode;
  ParamsNode: TALXMLNode;
begin
  inherited;                // ALL NODE NAMES LOWERCASE PLEASE !!!!!!!!!!
  SubNode := node.AddChild(FastFuncs.LowerCase(Self.ClassName));
  SubNode.AddChild('propname').NodeValue := PropName;
  SubNode.AddChild('caption').NodeValue := Caption;
  SubNode.AddChild('datatype').NodeValue := DataType;
  SubNode.AddChild('isrequired').NodeValue := IsRequired;
  SubNode.AddChild('isactive').NodeValue := IsActive;
  SubNode.AddChild('defaultvalue').NodeValue := DefaultValue;
  SubNode.AddChild('isnew').NodeValue := false;

  ParamsNode := SubNode.AddChild('params');
  if Assigned(fParams) then fParams.SaveToXMLNode(ParamsNode);
end;

procedure TdaCustPropDef.LoadFromXMLNode(const node: TALXMLNode);
var
  ValNode: TALXMLNode;
begin
  inherited;
  ValNode := node.ChildNodes.FindNode('propname');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then PropName := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('caption');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then Caption := ValNode.NodeValue;
  if FastFuncs.Trim(Caption) = '' then Caption:=PropName; // caption defualted to field name when caption of the property is blank

  ValNode := node.ChildNodes.FindNode('datatype');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then DataType := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('isrequired');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then IsRequired := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('isactive');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then IsActive := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('defaultvalue');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then DefaultValue := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('isnew');
  if Assigned(ValNode) and (not VarIsNull(ValNode.NodeValue)) then IsNew := ValNode.NodeValue;

  ValNode := node.ChildNodes.FindNode('params');
  if Assigned(ValNode) then Params.LoadFromXMLNode(ValNode);
end;

{
--------------------------------------------------------------------------------
  TdaCustPropDefList class
--------------------------------------------------------------------------------
}

constructor TdaCustPropDefList.Create(AOwner: TComponent);
begin
  inherited;
  fList := TObjectList.Create;
end;

procedure TdaCustPropDefList.Delete(const index: integer);
begin
  fList.Delete(index);
end;

destructor TdaCustPropDefList.Destroy;
begin
  FreeandNil(fList);
  inherited;
end;

function TdaCustPropDefList.Add: TdaCustPropDef;
begin
  Result := TdaCustPropDef.Create(Self);
  fList.Add(Result);
end;

function TdaCustPropDefList.GetCount: integer;
begin
  Result := fList.Count;
end;

function TdaCustPropDefList.GetItem(const index: integer): TdaCustPropDef;
begin
  Result := TdaCustPropDef(fList[index]);
end;

procedure TdaCustPropDefList.SaveToXMLNode(const node: TALXMLNode);
var
  x: integer;
  ListNode: TALXMLNode;
begin
  inherited;
  ListNode := node.AddChild('items');
  for x := 0 to fList.Count - 1 do begin
    Item[x].SaveToXMLNode(ListNode);
  end;
end;

procedure TdaCustPropDefList.LoadFromXMLNode(const node: TALXMLNode);
var
  NodeIdx, x: integer;
  ListNode: TALXMLNode;
begin
  inherited;
  fList.Clear;
  ListNode := node.ChildNodes.FindNode('items');
  if Assigned(ListNode) then begin
    for NodeIdx := 0 to ListNode.ChildNodes.Count - 1 do begin
      x := flist.Add(TdaCustPropDef.Create(nil));
      TdaCustPropDef(fList[x]).LoadFromXMLNode(ListNode.ChildNodes[NodeIdx]);
    end;
  end;
end;

{
--------------------------------------------------------------------------------
  TdaCustProp class
--------------------------------------------------------------------------------
}
constructor TdaCustProp.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TdaCustProp.Destroy;
begin
  inherited;
end;

procedure TdaCustProp.SetPropName(const Value: string);
begin
  if fPropName <> Value then fPropName := Value;
end;

function TdaCustProp.GetPropName: string;
begin
  Result := fPropName;
end;

procedure TdaCustProp.SetValue(const Value: string);
begin
  if fValue <> Value then begin
    fValue := Value;
    Dirty  := true;
  end;
end;

function TdaCustProp.GetAsBoolean: boolean;
begin
  if Self = nil then REsult := False else
  Result := StrToBoolDef(fValue,False);
end;

function TdaCustProp.GetValue: string;
begin
  if Self = nil then Result := '' else
  Result := fValue;
end;

function TdaCustProp.GetAsDateTime: TDateTime;
begin
  if Self = nil then Result := 0 else
  Result := StrToDateTimeDef(fValue,0.0);
end;

function TdaCustProp.GetAsFloat: double;
begin
  if Self = nil then Result := 0 else
  Result := StrToFloatDef(fValue,0.0);
end;

function TdaCustProp.GetAsInteger: integer;
begin
  if Self = nil then Result := 0 else
  Result := StrToIntDef(fValue,0);
end;

procedure TdaCustProp.SetAsBoolean(const Value: boolean);
begin
  fValue := BoolToStr(Value);
end;

procedure TdaCustProp.SetAsDateTime(const Value: TDateTime);
begin
  fValue := DateTimeToStr(Value);
end;

procedure TdaCustProp.SetAsFloat(const Value: double);
begin
  fValue := FloatToStr(Value);
end;

procedure TdaCustProp.SetAsInteger(const Value: integer);
begin
  fValue := FastFuncs.IntToStr(Value);
end;

procedure TdaCustProp.LoadFromXMLNode(const node: TALXMLNode);
var
  Exists: boolean;
begin
  self.fPropName := GetXMLNodeStringValue(node, 'propname', Exists);
  self.fValue := GetXMLNodeStringValue(node, 'value', Exists);
end;

procedure TdaCustProp.SaveToXMLNode(const node: TALXMLNode);
begin
  inherited;
  node.AddChild('propname').NodeValue := fPropName;
  node.AddChild('value').NodeValue := fValue;
end;

{
--------------------------------------------------------------------------------
  TdaCustPropList class
--------------------------------------------------------------------------------
}

function TdaCustPropList.Add: TdaCustProp;
begin
  Result := TdaCustProp.Create(Self);
  fList.Add(Result);
end;

constructor TdaCustPropList.Create(AOwner: TComponent);
begin
  inherited;
  fList := TObjectList.Create(true);
end;

procedure TdaCustPropList.Delete(const index: integer);
begin
  fList.Delete(index);
end;

destructor TdaCustPropList.Destroy;
begin
  FreeandNil(fList);
  inherited;
end;

function TdaCustPropList.GetByName(const aPropName: string): TdaCustProp;
var
  Found: boolean;
  LoopItems: integer;
  tmpObj: TdaCustProp;
begin
  InitiliseProperties;
  Result := nil;

  Found := false;
  LoopItems := 0;
  while (not Found) and (LoopItems < fList.Count) do begin
    tmpObj := TdaCustProp(fList[LoopItems]);
    if tmpObj.fPropName = aPropName then begin
      Result := tmpObj;
      Found := true;
    end;
    Inc(LoopItems);
  end;
end;

function TdaCustPropList.GetCount: integer;
begin
  Result := fList.Count;
end;

function TdaCustPropList.GetItem(const index: integer): TdaCustProp;
begin
  InitiliseProperties;
  Result := TdaCustProp(fList[index]);
end;

procedure TdaCustPropList.InitiliseProperties;
var
  x: integer;
begin
  if fList.Count = 0 then begin
    for x := 0 to Self.fCustPropDefs.Count - 1 do begin
      with self.Add do begin
        PropName := fCustPropDefs.Item[x].PropName;
        Value := fCustPropDefs.Item[x].DefaultValue;
      end;
    end;
  end;
end;

procedure TdaCustPropList.LoadFromXMLNode(const node: TALXMLNode);
var
  x: integer;
  PropNameNode: TALXMLNode;
  CustProp: TdaCustProp;
  Exists: boolean;
begin
  inherited;
  fList.Clear;
  InitiliseProperties;
  for x := 0 to node.ChildNodes.Count - 1 do begin
    PropNameNode := node.ChildNodes[x].ChildNodes.FindNode('propname');
    CustProp     := self.GetByName(PropNameNode.NodeValue);
    if Assigned(CustProp) then CustProp.Value := GetXMLNodeStringValue(node.ChildNodes[x], 'value', Exists);
  end;
end;

procedure TdaCustPropList.SaveToXMLNode(const node: TALXMLNode);
var
  x: integer;
  SubNode: TALXMLNode;
begin
  inherited;
  for x := 0 to fList.Count - 1 do begin
    SubNode := node.AddChild('property' + FastFuncs.IntToStr(x));
    Item[x].SaveToXMLNode(SubNode);
  end;
end;

{ tdaStorer }

constructor TdaStorer.Create(aOwner: TComponent);
begin
  inherited;
  if aowner is TdaBase then
    if Assigned(TdaBase(aOwner).connection) then
        Connection := TdaBase(aOwner).connection;
  if not Assigned(connection) then Connection := CommonDbLib.GetSharedMyDacConnection;
  Qry := TMyQuery.Create(self);
  Qry.Options.FlatBuffers := True;
  Qry.Connection := Connection;
end;

destructor TdaStorer.Destroy;
begin
  inherited;
end;

procedure tdaStorer.Load(const da: TdaBase);
begin
  // Define Class Query
  Qry.SQL.Text :=
    ' SELECT * FROM tblda';
  if da.ID > 0 then Qry.SQL.Add('WHERE daID = ' + FastFuncs.IntToStr(da.ID))
  else Qry.SQL.Add('WHERE ObjectClass = ' + QuotedStr(da.ClassName) +
      'AND TypeName = ' + QuotedStr(da.TypeName));

  Qry.Open;

  // Update object properties with stored values
  if not Qry.IsEmpty then begin
    da.ID          := Qry.FieldByName('DAID').AsInteger;
    da.Date        := Qry.FieldByName('Date').AsDateTime;
    da.Description := Qry.FieldByName('Description').AsString;
    da.XML         := Qry.FieldByName('XML').AsString;
    da.ParentID    := Qry.FieldByName('ParentID').AsInteger;
    da.TypeName    := Qry.FieldByName('TypeName').AsString;
    da.Active      := Qry.FieldByName('Active').AsBoolean;
  end;

  Qry.Close;
end;

procedure tdaStorer.Save(const da: TdaBase);
begin
  // Define Class Query
  Qry.SQL.Text :=
    ' SELECT * FROM tblda';
  if da.ID > 0 then Qry.SQL.Add('WHERE daID = ' + FastFuncs.IntToStr(da.ID))
  else Qry.SQL.Add('WHERE ObjectClass = ' + QuotedStr(da.ClassName) +
      'AND TypeName = ' + QuotedStr(da.TypeName));
  Qry.Open;

  if Qry.IsEmpty then begin
    Qry.Insert;
  end else begin
    if da.ID = 0 then Qry.Append
    else Qry.Edit;
  end;

  // Update or insert record with object properties
  Qry.FieldByName('DAID').AsInteger := da.ID;
  Qry.FieldByName('ObjectClass').AsString := da.ClassName;
  Qry.FieldByName('Date').AsDateTime := da.Date;
  Qry.FieldByName('Description').AsString := da.Description;
  Qry.FieldByName('XML').AsString := da.XML;
  Qry.FieldByName('ParentID').AsInteger := da.ParentID;
  Qry.FieldByName('TypeName').AsString := da.TypeName;
  Qry.FieldByName('Active').AsBoolean := da.Active;

  Qry.Post;
  da.ID := Qry.FieldByName('daID').AsInteger;
  Qry.Close;
end;

{ TdaMDCustPropDefList }

constructor TdaMDCustPropDefList.Create(AOwner: TComponent);
begin
  inherited;
  if not Assigned(fDetailDefs) then fDetailDefs := TdaCustPropDefList.Create(self);
  if not Assigned(fMasterDefs) then fMasterDefs := TdaCustPropDefList.Create(self);
end;

destructor TdaMDCustPropDefList.Destroy;
begin
  inherited;
end;

function TdaMDCustPropDefList.GetDetailDefs: TdaCustPropDefList;
begin
  Result := fDetailDefs;
end;

function TdaMDCustPropDefList.GetMasterDefs: TdaCustPropDefList;
begin
  Result := fMasterDefs;
end;

procedure TdaMDCustPropDefList.LoadFromXMLNode(const node: TALXMLNode);
var
  MasterDefsNode, DetailDefsNode: TALXMLNode;
begin
  inherited;
  MasterDefsNode := node.ChildNodes.FindNode('masterdefs');
  if Assigned(MasterDefsNode) then fMasterDefs.LoadFromXMLNode(MasterDefsNode);
  DetailDefsNode := node.ChildNodes.FindNode('detaildefs');
  if Assigned(DetailDefsNode) then fDetailDefs.LoadFromXMLNode(DetailDefsNode);
end;

procedure TdaMDCustPropDefList.SaveToXMLNode(const node: TALXMLNode);
var
  MasterDefsNode, DetailDefsNode: TALXMLNode;
begin
  inherited;
  MasterDefsNode := node.AddChild('masterdefs');
  self.fMasterDefs.SaveToXMLNode(MasterDefsNode);
  DetailDefsNode := node.AddChild('detaildefs');
  self.fDetailDefs.SaveToXMLNode(DetailDefsNode);
end;

{ TdaMDCustBase }

constructor TdaMDCustBase.Create(AOwner: TComponent);
begin
  inherited;
  fDetail := TdaMDCustBaseList.Create(Self);
  fMaster := TdaCustPropList.Create(self);
  fMDCustPropDefs := TdaMDCustPropDefList.Create(Self);
  fDetail.ItemDefs := fMDCustPropDefs.DetailDefs;
  fMaster.CustPropDefs := fMDCustPropDefs.MasterDefs;
end;

destructor TdaMDCustBase.Destroy;
begin
  if assigned(fda) then begin
        if fda.active then fda.close;
        FreeandNil(fda);
  end;
  inherited;

end;

function TdaMDCustBase.GetDetail: TdaMDCustBaseList;
begin
  Result := fDetail;
end;

function TdaMDCustBase.GetMDCustPropDefs: TdaMDCustPropDefList;
begin
  Result := fMDCustPropDefs;
end;
procedure TdaMDCustBase.SetID(const Value: integer);
begin
    inherited;
    if assigned(fda) then begin
        if fda.Active then fda.Close;
        fda.SQL.clear;
    end else begin
        fda := TMyQuery.Create(nil);
        fda.Options.FlatBuffers := True;
        fda.connection := GetSharedMyDacConnection;
    end;
    fda.SQL.add('Select * from tblDA where DAID = ' + FastFuncs.IntToStr(Value));
    fda.Open;
end;
procedure TdaMDCustBase.Load;
begin
    if assigned(fda) then begin
        if Self.ParentId > 0 then fMDCustPropDefs.Id := fda.FieldByname('ParentID').asInteger
        else  fMDCustPropDefs.TypeName := fda.FieldByname('TypeName').asString;

        fMDCustPropDefs.Load;
        if fMDCustPropDefs.typename <> '' then typename := fMDCustPropDefs.typename;
        fDetail.ItemDefs := fMDCustPropDefs.fDetailDefs;
    end;
    inherited;

    {if Self.ParentId > 0 then fMDCustPropDefs.Id := Self.ParentID
    else    fMDCustPropDefs.TypeName := self.TypeName;

    fMDCustPropDefs.Load;
    if fMDCustPropDefs.typename <> '' then typename := fMDCustPropDefs.typename;
    fDetail.ItemDefs := fMDCustPropDefs.fDetailDefs;}


end;

procedure TdaMDCustBase.LoadFromXMLNode(const node: TALXMLNode);
var
  DetailNode: TALXMLNode;
  MasterNode: TALXMLNode;
begin
  inherited;
  // Load Details here ...
  MasterNode := node.ChildNodes.FindNode('master');
  if Assigned(MasterNode) then fMaster.LoadFromXMLNode(MasterNode);

  DetailNode := node.ChildNodes.FindNode('detail');
  if Assigned(DetailNode) then fDetail.LoadFromXMLNode(DetailNode);
end;

procedure TdaMDCustBase.New;
begin
  inherited;
  self.fDetail.Clear;
  self.fMDCustPropDefs.Load;
end;

procedure TdaMDCustBase.SaveToXMLNode(const node: TALXMLNode);
var
  DetailNode: TALXMLNode;
  MasterNode: TALXMLNode;
begin
  inherited;
  MasterNode := node.AddChild('master');
  fMaster.SaveToXMLNode(MasterNode);
  DetailNode := node.AddChild('detail');
  fDetail.SaveToXMLNode(DetailNode);
end;

procedure TdaMDCustBase.SetTypeName(const Value: string);
begin
  inherited;
  self.fMDCustPropDefs.TypeName := Value;
end;

{ TdaMDCustBaseList }

function TdaMDCustBaseList.Add: TdaCustPropList;
var
  x: integer;
begin
  x := fList.Add(TdaCustPropList.Create(Self));
  TdaCustPropList(fList[x]).CustPropDefs := self.ItemDefs;
  Inc(fLastID);
  TdaCustPropList(fList[x]).fID := fLastID;
  Result := TdaCustPropList(fList[x]);
end;

procedure TdaMDCustBaseList.Clear;
begin
  self.fList.Clear;
end;

constructor TdaMDCustBaseList.Create(AOwner: TComponent);
begin
  inherited;
  fList := TObjectList.Create(true);
  fLastID := 0;
end;

procedure TdaMDCustBaseList.Delete(const index: integer);
begin
  fList.Delete(index);
end;

destructor TdaMDCustBaseList.Destroy;
begin
  FreeandNil(fLIst);
  inherited;
end;

function TdaMDCustBaseList.GetCount: integer;
begin
  Result := fList.Count;
end;

function TdaMDCustBaseList.GetItem(const index: integer): TdaCustPropList;
begin
  Result := TdaCustPropList(fList[index]);
end;

function TdaMDCustBaseList.Insert(const Index : integer): TdaCustPropList;
var
  x: integer;
begin
  fList.Insert(Index, TdaCustPropList.Create(Self));
  TdaCustPropList(fList[Index]).CustPropDefs := self.ItemDefs;
  Inc(fLastID);
  Result := TdaCustPropList(fList[Index]);
  for x := 0 to fList.Count - 1 do begin
    TdaCustPropList(fList[x]).fID := x+1;
  end;
end;

procedure TdaMDCustBaseList.LoadFromXMLNode(const node: TALXMLNode);
var
  x: integer;
  newLine: TdaCustPropList;
begin
  inherited;
  fList.Clear;
  for x := 0 to node.ChildNodes.Count - 1 do begin
    newLine := self.Add;
    newLine.CustPropDefs := self.fItemDefs;
    newLine.LoadFromXMLNode(node.ChildNodes[x]);
  end;
end;

procedure TdaMDCustBaseList.SaveToXMLNode(const node: TALXMLNode);
var
  x: integer;
  SubNode: TALXMLNode;
begin
  inherited;
  for x := 0 to self.Count - 1 do begin
    SubNode := node.AddChild('propertylist' + FastFuncs.IntToStr(Item[x].fID));
    Item[x].SaveToXMLNode(SubNode);
  end;
end;

{ TdaCustPropParams }

procedure TdaCustPropParams.LoadFromXMLNode(const node: TALXMLNode);
var
  Exists: boolean;
begin
  inherited;
  fListValues := GetXMLNodeStringValue(node, 'listvalues', Exists);
  fUserCanEditList := GetXMLNodeBooleanValue(node, 'usercaneditlist', Exists);
end;

procedure TdaCustPropParams.SaveToXMLNode(const node: TALXMLNode);
begin
  inherited;
  node.AddChild('listvalues').NodeValue := fListValues;
  node.AddChild('usercaneditlist').NodeValue := fUserCanEditList;
end;

end.





