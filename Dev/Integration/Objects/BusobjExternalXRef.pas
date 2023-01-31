unit BusobjExternalXRef;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  25/11/19  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, erpdbcomponents;
const
      ExRef_Objtype_Account	      = 'Account'       ;
      ExRef_Objtype_Bill	        = 'Bill'          ;
      ExRef_Objtype_BillPayment	  = 'BillPayment'   ;
      ExRef_Objtype_Customer	    = 'Customer'      ;
      ExRef_Objtype_Invoice	      = 'Invoice'       ;
      ExRef_Objtype_Payment	      = 'Payment'       ;
      ExRef_Objtype_PaymentMethod	= 'PaymentMethod' ;
      ExRef_Objtype_Product	      = 'Product'       ;
      ExRef_Objtype_PurchaseOrder	= 'PurchaseOrder' ;
      ExRef_Objtype_RefundSale    = 'RefundSale'    ;
      ExRef_Objtype_SalesOrder    = 'SalesOrder'    ;
      ExRef_Objtype_Sales         = 'Sales'         ;
      ExRef_Objtype_SalesLines    = 'SalesLines'    ;
      ExRef_Objtype_Supplier	    = 'Supplier'      ;
      ExRef_Objtype_TaxCode	      = 'TaxCode'       ;
      ExRef_Objtype_TaxRate	      = 'TaxRate'       ;
      ExRef_Objtype_Term	        = 'Term'          ;

      SynchItemType_Orders        = 'Orders'        ;
      SynchItemType_Customers     = 'Customers'     ;
      SynchItemType_Products      = 'Products'      ;
      SynchItemType_ProductUpload = 'ProductUpload' ;
      SynchItemType_Bill          = 'Bill'          ;
      SynchItemType_Invoice       = 'Invoice'       ;
      SynchItemType_PurchaseOrder = 'Purchase Order';
      SynchItemType_Payment       = 'Payment'       ;
      SynchItemType_BillPayment   = 'BillPayment'   ;
      SynchItemType_Sales         = 'Sales'         ;

type
  TExternalXRef = class(TMSBusObj)
  private
    function GetExternalType: string;
    function GetObjectType: string;
    function GetExternalID: string;
    function GetExternalAltID: string;
    function GetExternalVersion: string;
    function GetERPID: Integer;
    function GetERPTimeStamp: TDateTime;
    function GetSynchState: string;
    procedure SetExternalType(const Value: string);
    procedure SetObjectType(const Value: string);
    procedure SetExternalID(const Value: string);
    procedure SetExternalAltID(const Value: string);
    procedure SetExternalVersion(const Value: string);
    procedure SetERPID(const Value: Integer);
    procedure SetERPTimeStamp(const Value: TDateTime);
    procedure SetSynchState(const Value: string);
    function GetExternalTimeStamp: TDateTime;
    procedure SetExternalTimeStamp(const Value: TDateTime);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;

    class function StartNew           (const aExternalType, aObjectType: string; const aERPID: Integer;var msg: string; Conn: TERPConnection = nil): boolean; overload;
    class function StartNew           (const aExternalType, aObjectType, aExternalId: string;      var msg: string; Conn: TERPConnection = nil): boolean; overload;
          function DoStartNew         (const aExternalType, aObjectType, aExternalId: string;      var msg: string; Conn: TERPConnection=nil): boolean;
    class function GetExternalRef     (Const aExternalType, aObjectType: string; const aERPID: Integer;var aExtRef: string; var aDone: Boolean; Conn: TERPConnection = nil; ReturnAltRef:Boolean = False): Boolean;
    class function Complete           (const aExternalType, aObjectType: string; const aERPID: Integer;const aExternalID: string; var msg: string; aExternalTimeStamp: TDateTime = 0; Conn: TERPConnection = nil; aExternalAltID:String = ''): boolean;
    class procedure MakeXRef          (const aExternalType, aObjectType: string; const aERPID: Integer;const aExternalID: string; Conn: TERPConnection = nil);
    class Function RemoveXRef         (const aExternalType, aObjectType: string; const aERPID: Integer;const aExternalID: string; Conn: TERPConnection = nil): Boolean;
    class function IsStarted          (const aExternalType, aObjectType, aExternalId: string;aERPID: integer; Conn: TERPConnection = nil): boolean;
    class function Exists (const aExternalType, aObjectType: string;
      var aExternalId: string; var aERPID: integer; var aSynchState: string;
      Conn: TERPConnection = nil): boolean;
    class function IsDone             (const aExternalType, aObjectType, aExternalId: string;aERPID: integer; Conn: TERPConnection = nil): boolean;
    class function ERPIdForExternalId (const aExternalType, aObjectType, aExternalId: string;Conn: TERPConnection = nil): integer;
    function DoComplete               (const aExternalType, aObjectType: string;  const aERPID: Integer; const aExternalID: string; var msg: string;  aExternalTimeStamp: TDateTime = 0; Conn: TERPConnection = nil; aExternalAltID :String = ''): boolean;
    class Function LastExRefID        (const aExternalType, aObjectType: string;Conn: TERPConnection = nil;IgnoreifNoERPID:Boolean = False):Integer;
    class Function LastExRefDate      (const aExternalType, aObjectType, DateTimefieldname: string;Conn: TERPConnection = nil):TDatetime;

    class function NewInstance(Conn: TERPConnection): TExternalXRef;
    class function EntryExists(const aExternalType, aObjectType, aExternalId: string; Conn: TERPConnection = nil): boolean;
  published
    property ExternalType     : string    read GetExternalType      write SetExternalType;
    property ObjectType       : string    read GetObjectType        write SetObjectType;
    property ExternalID       : string    read GetExternalID        write SetExternalID;
    property ExternalAltID    : string    read GetExternalAltID     write SetExternalAltID;
    property ExternalVersion  : string    read GetExternalVersion   write SetExternalVersion;
    property ExternalTimeStamp: TDateTime read GetExternalTimeStamp write SetExternalTimeStamp;
    property ERPID            : Integer   read GetERPID             write SetERPID;
    property ERPTimeStamp     : TDateTime read GetERPTimeStamp      write SetERPTimeStamp;
    property SynchState       : string    read GetSynchState        write SetSynchState;
  end;

implementation

uses
  tcDataUtils, CommonLib, sysutils, DbSharedObjectsObj, CommonDbLib;

{ TExternalXRef }

constructor TExternalXRef.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'externalxref';
  fSQL := 'SELECT * FROM tblexternalxref';
end;

destructor TExternalXRef.Destroy;
begin
  inherited;
end;
class Function TExternalXRef.LastExRefDate(const aExternalType, aObjectType, DateTimefieldname: string;Conn: TERPConnection = nil):TDatetime;
var
  qry: TERPQuery;
begin
  result := 0;
  if Assigned(Conn) then qry := DbSharedObj.GetQuery(Conn)
  else qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    if qry.active then qry.Close;
    qry.SQL.Text := 'select  Max(' + DateTimefieldname+') ' + DateTimefieldname+'   '+
                    ' from tblexternalxref  '+
                    ' where ExternalType = ' + QuotedStr(aExternalType) +
                    ' and ObjectType = ' + QuotedStr(aObjectType);
    qry.Open;
    try
      Result := qry.fieldbyname(DateTimefieldname).asDatetime;
    Except
      // this function should be used when its certan that the external ID is integer . eg: Magento IDs are all Integers
      // kill exception if the value not integer
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;
class function TExternalXRef.LastExRefID(const aExternalType,aObjectType: string;Conn: TERPConnection = nil;IgnoreifNoERPID:Boolean = False): Integer;
var
  qry: TERPQuery;
begin
  result := 0;
  if Assigned(Conn) then qry := DbSharedObj.GetQuery(Conn)
  else qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select  Max(convert(externalID, UNSIGNED)) maxID   '+
                    ' from tblexternalxref  '+
                    ' where ExternalType = ' + QuotedStr(aExternalType) +
                    ' and ObjectType = ' + QuotedStr(aObjectType);
    if IgnoreifNoERPID then qry.SQL.add(' and ifnull(ERPID,0)<> 0');
    qry.Open;
    try
      Result := qry.fieldbyname('maxID').asInteger;
    Except
      // this function should be used when its certan that the external ID is integer . eg: Magento IDs are all Integers
      // kill exception if the value not integer
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;

end;

procedure TExternalXRef.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'ExternalType');
  SetPropertyFromNode(node, 'ObjectType');
  SetPropertyFromNode(node, 'ExternalID');
  SetPropertyFromNode(node, 'ExternalAltID');
  SetPropertyFromNode(node, 'ExternalVersion');
  SetDateTimePropertyFromNode(node, 'ExternalTimeStamp');
  SetPropertyFromNode(node, 'ERPID');
  SetDateTimePropertyFromNode(node, 'ERPTimeStamp');
  SetPropertyFromNode(node, 'SynchState');
end;

procedure TExternalXRef.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'ExternalType', ExternalType);
  AddXMLNode(node, 'ObjectType', ObjectType);
  AddXMLNode(node, 'ExternalID', ExternalID);
  AddXMLNode(node, 'ExternalAltID', ExternalAltID);
  AddXMLNode(node, 'ExternalVersion', ExternalVersion);
  AddXMLNode(node, 'ExternalTimeStamp', ExternalTimeStamp);
  AddXMLNode(node, 'ERPID', ERPID);
  AddXMLNode(node, 'ERPTimeStamp', ERPTimeStamp);
  AddXMLNode(node, 'SynchState', SynchState);
end;

function TExternalXRef.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if ExternalType = '' then begin
    AddResult(false,rssWarning,0,'External Type is missing from the External Cross Reference Data.');
    exit;
  end;
  if ObjectType = '' then begin
    AddResult(false,rssWarning,0,'Object Type is missing from the External Cross Reference Data.');
    exit;
  end;
  if (ExternalId = '') and (ERPID = 0) then begin
    AddResult(false,rssWarning,0,'Both External Id and ERP Id are missing from the External Cross Reference Data, at least one of these needs to be set.');
    exit;
  end;
  if SynchState = 'Done' then begin
    if (ExternalId = '') then begin
      AddResult(false,rssWarning,0,'External Idis missing from the External Cross Reference Data.');
      exit;
    end;
    if (ERPID = 0) then begin
      AddResult(false,rssWarning,0,'ERP Id is missing from the External Cross Reference Data.');
      exit;
    end;
  end;
  Result := True;
end;

function TExternalXRef.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TExternalXRef.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TExternalXRef.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

class function TExternalXRef.EntryExists(const aExternalType, aObjectType,
  aExternalId: string; Conn: TERPConnection): boolean;
var
  qry: TERPQuery;
begin
  result := false;
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text :=
      'select * from tblexternalxref where ExternalType = ' + QuotedStr(aExternalType) +
      ' and ObjectType = ' + QuotedStr(aObjectType) +
      ' and ExternalID = ' + QuotedStr(aExternalId);
    qry.Open;
    if not qry.IsEmpty then
      result := true;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TExternalXRef.ERPIdForExternalId(const aExternalType,
  aObjectType, aExternalId: string; Conn: TERPConnection=nil): integer;
var
  qry: TERPQuery;
begin
  result := 0;
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text :=
      'select * from tblexternalxref where ExternalType = ' + QuotedStr(aExternalType) +
      ' and ObjectType = ' + QuotedStr(aObjectType) +
      ' and ExternalID = ' + QuotedStr(aExternalId);
    qry.Open;
    if not qry.IsEmpty then
      result := qry.FieldByName('ERPID').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TExternalXRef.Exists(const aExternalType, aObjectType: string;
  var aExternalId: string; var aERPID: integer; var aSynchState: string;
  Conn: TERPConnection): boolean;
var
  qry: TERPQuery;
begin
  result := false;
  if (aExternalID = '') and (aERPID < 1) then
    raise Exception.Create('Error TExternalXRef.Exists - both External ID and ERP Id are blank.');
  if Assigned(Conn) then
    qry := DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select * from tblexternalxref where ExternalType = ' + QuotedStr(aExternalType));
    qry.SQL.Add('and ObjectType = ' + QuotedStr(aObjectType));
    if aExternalID <> '' then
      qry.SQL.Add('and ExternalID = ' + QuotedStr(aExternalId));
    if aERPID > 0 then
      qry.SQL.Add('and ERPID = ' + IntToStr(aERPId));
    qry.Open;
    if not qry.IsEmpty then begin
      result := true;
      aExternalId := qry.FieldByName('ExternalID').AsString;
      aERPId := qry.FieldByName('ERPID').AsInteger;
      aSynchState := qry.FieldByName('SynchState').AsString;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

function TExternalXRef.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TExternalXRef.GetIDField: string;
begin
  Result := 'ID'
end;

class function TExternalXRef.GetBusObjectTablename: string;
begin
  Result := 'tblexternalxref';
end;

function TExternalXRef.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TExternalXRef.GetExternalTimeStamp: TDateTime;
begin
  Result := GetDateTimeField('ExternalTimeStamp');
end;

class function TExternalXRef.IsDone(const aExternalType, aObjectType,
  aExternalId: string; aERPID: integer; Conn: TERPConnection): boolean;
var
  ExternalXRef: TExternalXRef;
begin
  ExternalXRef := TExternalXRef.NewInstance(Conn);
  try
    ExternalXRef.LoadSelect('ExternalType = ' + QuotedStr(aExternalType) + ' AND '+
                            ' ObjectType = '  + QuotedStr(aObjectType) + ' AND  '+
                            ' (ERPID = ' + IntToStr(aERPID) + ' or ExternalID = ' + QuotedStr(aExternalId)+ ')' +
                            ' and SynchState = "Done"');
    Result := ExternalXRef.count > 0;
  finally
    Freeandnil(ExternalXRef);
  end;
end;

class function TExternalXRef.IsStarted(const aExternalType, aObjectType,
  aExternalId: string; aERPID: integer; Conn: TERPConnection): boolean;
var
  ExternalXRef: TExternalXRef;
begin
  ExternalXRef := TExternalXRef.NewInstance(Conn);
  try
    ExternalXRef.LoadSelect('ExternalType = ' + QuotedStr(aExternalType) + ' AND ObjectType = ' +
      QuotedStr(aObjectType) + ' AND (ERPID = ' + IntToStr(aERPID) + ' or ExternalID = ' + QuotedStr(aExternalId)+ ')' +
      ' and SynchState = "Started"');
    Result := ExternalXRef.count > 0;
  finally
    Freeandnil(ExternalXRef);
  end;
end;
function TExternalXRef.GetExternalType    : string    ; begin Result := GetStringField('ExternalType')    ; end;
function TExternalXRef.GetObjectType      : string    ; begin Result := GetStringField('ObjectType')      ; end;
function TExternalXRef.GetExternalID      : string    ; begin Result := GetStringField('ExternalID')      ; end;
function TExternalXRef.GetExternalAltID   : string    ; begin Result := GetStringField('ExternalAltID')   ; end;
function TExternalXRef.GetExternalVersion : string    ; begin Result := GetStringField('ExternalVersion') ; end;
function TExternalXRef.GetERPID           : Integer   ; begin Result := GetIntegerField('ERPID')          ; end;
function TExternalXRef.GetERPTimeStamp    : TDateTime ; begin Result := GetDateTimeField('ERPTimeStamp')  ; end;
function TExternalXRef.GetSynchState      : string    ; begin Result := GetStringField('SynchState')      ; end;
procedure TExternalXRef.SetExternalTimeStamp(const Value: TDateTime ); begin  SetDateTimeField('ExternalTimeStamp', Value); end;
procedure TExternalXRef.SetExternalType     (const Value: string    ); begin  SetStringField('ExternalType'       , Value); end;
procedure TExternalXRef.SetObjectType       (const Value: string    ); begin  SetStringField('ObjectType'         , Value); end;
procedure TExternalXRef.SetExternalID       (const Value: string    ); begin  SetStringField('ExternalID'         , Value); end;
procedure TExternalXRef.SetExternalAltID    (const Value: string    ); begin  SetStringField('ExternalAltID'      , Value); end;
procedure TExternalXRef.SetExternalVersion  (const Value: string    ); begin  SetStringField('ExternalVersion'    , Value); end;
procedure TExternalXRef.SetERPID            (const Value: Integer   ); begin  SetIntegerField('ERPID'             , Value); end;
procedure TExternalXRef.SetERPTimeStamp     (const Value: TDateTime ); begin  SetDateTimeField('ERPTimeStamp'     , Value); end;
procedure TExternalXRef.SetSynchState       (const Value: string    ); begin  SetStringField('SynchState'         , Value); end;

function TExternalXRef.DoStartNew(const aExternalType, aObjectType,  aExternalId: string; var msg: string; Conn: TERPConnection): boolean;
begin
    Result := True;
    SilentMode := true;
    LoadSelect('ExternalType = ' + QuotedStr(aExternalType) + ' and ObjectType = ' + QuotedStr(aObjectType) + ' and ExternalID = ' + QuotedStr(aExternalId));
    if Count = 0 then begin
      New;
      ExternalType := aExternalType;
      ObjectType := aObjectType;
      ExternalID := aExternalId;
      result :=  Save;
      if not result then begin
        msg := ResultStatus.Messages;
        CancelDb;
      end;
    end;
end;
class function TExternalXRef.StartNew(const aExternalType, aObjectType,  aExternalId: string; var msg: string; Conn: TERPConnection): boolean;
var
  ExternalXRef: TExternalXRef;
begin
  result := true;
  ExternalXRef := TExternalXRef.NewInstance(Conn);
  try
    REsult := ExternalXRef.DoStartNew(aExternalType, aObjectType,  aExternalId,msg,Conn);
    (*ExternalXRef.LoadSelect('ExternalType = ' + QuotedStr(aExternalType) + ' and ObjectType = ' + QuotedStr(aObjectType) + ' and ExternalID = ' + QuotedStr(aExternalId));
    if ExternalXRef.Count = 0 then begin
      ExternalXRef.New;
      ExternalXRef.ExternalType := aExternalType;
      ExternalXRef.ObjectType := aObjectType;
      ExternalXRef.ExternalID := aExternalId;
      result :=  ExternalXRef.Save;
      if not result then begin
        msg := ExternalXRef.ResultStatus.Messages;
        ExternalXRef.CancelDb;
      end;
    end;*)
  finally
    Freeandnil(ExternalXRef);
  end;
end;

class function TExternalXRef.StartNew(const aExternalType, aObjectType: string;
  const aERPID: Integer; var msg: string; Conn: TERPConnection = nil): boolean;
var
  ExternalXRef: TExternalXRef;
begin
  result := true;
  ExternalXRef := TExternalXRef.NewInstance(Conn);
  try
    ExternalXRef.SilentMode := true;
    ExternalXRef.LoadSelect('ExternalType = ' + QuotedStr(aExternalType) + ' and ObjectType = ' + QuotedStr(aObjectType) + ' and ERPID = ' + IntToStr(aERPID));
    if ExternalXRef.Count = 0 then begin
      ExternalXRef.New;
      ExternalXRef.ExternalType := aExternalType;
      ExternalXRef.ObjectType := aObjectType;
      ExternalXRef.ERPID := aERPID;
      result := ExternalXRef.Save;
      if not result then begin
        msg := ExternalXRef.ResultStatus.Messages;
        ExternalXRef.CancelDb;
      end;
    end;
  finally
    Freeandnil(ExternalXRef);
  end;
end;

class function TExternalXRef.GetExternalRef(Const aExternalType, aObjectType: string; const aERPID: Integer;
  var aExtRef: string; var aDone: Boolean; Conn: TERPConnection = nil; ReturnAltRef:Boolean = False): Boolean;
var
  ExternalXRef: TExternalXRef;
begin
  ExternalXRef := TExternalXRef.NewInstance(Conn);
  try
    ExternalXRef.LoadSelect('ExternalType = ' + QuotedStr(aExternalType) + ' AND ObjectType = ' +
      QuotedStr(aObjectType) + ' AND ERPID = ' + IntToStr(aERPID));
    Result := ExternalXRef.count > 0;
    if ReturnAltRef then
         aExtRef := ExternalXRef.ExternalAltID
    else aExtRef := ExternalXRef.ExternalID;
    aDone := SameText(ExternalXRef.SynchState, 'Done');
  finally
    Freeandnil(ExternalXRef);
  end;
end;

class function TExternalXRef.Complete(const aExternalType, aObjectType: string;
  const aERPID: Integer; const aExternalID: string; var msg: string;
  aExternalTimeStamp: TDateTime = 0; Conn: TERPConnection = nil; aExternalAltID:String = ''): boolean;
var
  ExternalXRef: TExternalXRef;
begin
  ExternalXRef := TExternalXRef.NewInstance(Conn);
  try
    ExternalXRef.SilentMode := true;
    ExternalXRef.LoadSelect('ExternalType = ' + QuotedStr(aExternalType) + ' AND ObjectType = ' +
      QuotedStr(aObjectType) + ' AND (ERPID = ' + IntToStr(aERPID) + ' or ExternalID = ' + QuotedStr(aExternalID) +')');
    result := ExternalXRef.DoComplete(aExternalType, aObjectType,aERPID,aExternalID,msg,aExternalTimeStamp,Conn , aExternalAltID);
  finally
    Freeandnil(ExternalXRef);
  end;
end;
function TExternalXRef.DoComplete(const aExternalType, aObjectType: string;
  const aERPID: Integer; const aExternalID: string; var msg: string;
  aExternalTimeStamp: TDateTime = 0; Conn: TERPConnection = nil; aExternalAltID :String = ''): boolean;
begin
    if count = 0 then begin
      New;
      ExternalType := aExternalType;
      ObjectType := aObjectType;
    end;
    ERPID := aERPID;
    ExternalID := aExternalID;
    ExternalAltID := aExternalAltID;
    SynchState := 'Done';
    if aExternalTimeStamp > 0 then
      ExternalTimeStamp := aExternalTimeStamp;
    result := Save;
    if not result then begin
      msg := ResultStatus.Messages;
      CancelDb;
    end;
end;

class function TExternalXRef.NewInstance(Conn: TERPConnection): TExternalXRef;
begin
  if Assigned(Conn) then begin
    Result := TExternalXRef.Create(nil);
    Result.Connection := TMyDacDataConnection.Create(Result);
    Result.Connection.Connection := Conn;
  end
  else begin
    Result := TExternalXRef.CreateWithNewConn(nil)
  end;
end;

class procedure TExternalXRef.MakeXRef(const aExternalType, aObjectType: string;
  const aERPID: Integer; const aExternalID: string; Conn: TERPConnection = nil);
var
  ExternalXRef: TExternalXRef;
begin
  { NOTE: this function overwrites the existing Xref }
  ExternalXRef := TExternalXRef.NewInstance(Conn);
  try
    ExternalXRef.LoadSelect('ExternalType = ' + QuotedStr(aExternalType) + ' AND ObjectType = ' +
      QuotedStr(aObjectType) + ' AND (ERPID = ' + IntToStr(aERPID) + ' OR ExternalID = ' +
      QuotedStr(aExternalID) + ')');

    if ExternalXRef.count = 0 then begin
      ExternalXRef.New;
      ExternalXRef.ExternalType := aExternalType;
      ExternalXRef.ObjectType := aObjectType;
    end;
    ExternalXRef.ERPID := aERPID;
    ExternalXRef.ExternalID := aExternalID;
    ExternalXRef.SynchState := 'Done';
    ExternalXRef.Postdb;
  finally
    Freeandnil(ExternalXRef);
  end;

end;

class Function TExternalXRef.RemoveXRef(const aExternalType, aObjectType: string;
  const aERPID: Integer; const aExternalID: string; Conn: TERPConnection = nil): Boolean;
var
  ExternalXRef: TExternalXRef;
begin
  { NOTE: this function overwrites the existing Xref }
  Result := False;
  ExternalXRef := TExternalXRef.NewInstance(Conn);
  try
    ExternalXRef.LoadSelect('ExternalType = ' + QuotedStr(aExternalType) + ' AND ObjectType = ' +
      QuotedStr(aObjectType) + ' AND (ERPID = ' + IntToStr(aERPID) + ' AND ExternalID = ' +
      QuotedStr(aExternalID) + ')');

    if ExternalXRef.count = 0 then
      Exit;
    ExternalXRef.Deleteall;
    Result := True;
  finally
    Freeandnil(ExternalXRef);
  end;

end;

initialization

RegisterClass(TExternalXRef);

end.
