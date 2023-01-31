unit BusObjUtils;

interface

uses
  Busobjbase, XMLDoc, MyAccess, ERPdbComponents, XMLIntf;

{Product Object related}
function OwnerProductname(BusObj :TBusObj):String;
Function IsOwnerProduct(BusObj :TBusObj):Boolean;
function CheckProduct(BuObj :TBusObj; Node :IXMLNode; const tagname :String):Integer;
function getXMLProductName(BuObj :TBusObj; Node :IXMLNode; const tagname :String):String;
function getXMLDeptName(BuObj :TBusObj; Node :IXMLNode; const tagname :String):String;

{client object related}
function OwnerClientname(const BusObj :TBusObj):String;
Function IsOwnerClient(const BusObj :TBusObj):Boolean;
function CheckClient(const BuObj :TBusObj; const Node :IXMLNode; const tagname :String):Integer;
function GetXMLClientNAme(const BuObj :TBusObj; const Node :IXMLNode; const tagname :String):String;

procedure CopyAttachments(const SourceTableName: string; SourceTableID: integer;
                          const DestTableName: string; DestTableID: integer; DbConn: TCustomMyConnection);

procedure SetBusObjNextIdNo(const nextId: integer; BusObjClass: TBusObjClass; Conn: TMyConnection);
procedure SetBusObjAutoIncrement(const nextId: integer; BusObjClass: TBusObjClass; Conn: TMyConnection);

function IsComboSpecialVal(aValue: string): boolean;
function ComboLinkedPropBlank(aValue: string): boolean;

implementation

uses
  BusObjStock, CommonLib, BusObjClass, tcDataUtils, BusObjClient, SysUtils,
  dialogs, controls, PreferancesLib;

function getXMLProductName(BuObj :TBusObj; Node :IXMLNode; const tagname :String):String;
var XMLFieldNodeExists :boolean;
begin
    Result := '';
    if IsOwnerProduct(BuObj) then begin
        Result := TProduct(BuObj.Owner).ProductName;
    end else Result := GetXMLNodeStringValue(Node, tagname, XMLFieldNodeExists);
end;
function getXMLDeptName(BuObj :TBusObj; Node :IXMLNode; const tagname :String):String;
var XMLFieldNodeExists :boolean;
begin
    Result := '';
    if (Assigned(BuObj.Owner)) and (BuObj.Owner is TDeptClass) then begin
        Result := TDeptClass(BuObj.Owner).DeptClassName;
    end else
        Result := GetXMLNodeStringValue(Node, tagname, XMLFieldNodeExists);

end;

function CheckProduct(BuObj :TBusObj; Node :IXMLNode; const tagname :String):Integer;
var XMLFieldNodeExists :Boolean;
begin
    Result := 0;
    if IsOwnerProduct(BuObj) then begin
        if  (GetXMLNodeStringValue(Node, tagname, XMLFieldNodeExists) = '' ) or  (OwnerProductname(BuObj) = GetXMLNodeStringValue(Node, tagname, XMLFieldNodeExists)) then
            Result := TProduct(BuObj.Owner).ID;
    end else Result := tcDatautils.getproduct(GetXMLNodeStringValue(Node, tagname, XMLFieldNodeExists));
end;

Function IsOwnerProduct(BusObj :TBusObj):Boolean;
begin
    Result := False;
    if not Assigned(BusObj.Owner) then exit;
    Result := (BusObj.Owner is TProduct);
end;
function OwnerProductname(BusObj :TBusObj):String;
begin
    Result := '';
    if not IsOwnerProduct(BusObj) then Exit;
    Result := TProduct(BusObj.Owner).ProductName;
end;
{client object related}

function GetXMLClientNAme(Const BuObj :TBusObj; Const Node :IXMLNode; Const tagname :String):String;
var XMLFieldNodeExists :Boolean;
begin
    XMLFieldNodeExists:= False;
    Result := '';
    if IsOwnerClient(BuObj) then begin
        Result := TClient(BuObj.Owner).ClientName;
    end else Result := GetXMLNodeStringValue(Node, tagname, XMLFieldNodeExists);
end;

function CheckClient(Const BuObj :TBusObj; Const Node :IXMLNode; Const tagname :String):Integer;
var XMLFieldNodeExists:Boolean;
begin
    XMLFieldNodeExists:= False;
    Result := 0;
    if IsOwnerClient(BuObj) then begin
        if  (GetXMLNodeStringValue(Node, tagname, XMLFieldNodeExists) = '' ) or  (OwnerClientname(BuObj) = GetXMLNodeStringValue(Node, tagname, XMLFieldNodeExists)) then begin
                     if (tagName = 'Supplier')      and (BuObj.Owner is TSupplier)     then Result := TSupplier(BuObj.Owner).ID
                else if (tagName = 'Customer')      and (BuObj.Owner is TCustomer)     then Result := TCustomer(BuObj.Owner).ID
                else if (tagName = 'Othercontacts') and (BuObj.Owner is TOthercontact) then Result := TOthercontact(BuObj.Owner).ID
                else if (tagname = 'MasterCompany')                                    then Result := TClient(BuObj.Owner).ID
                else if (tagname = 'ClientName')                                       then Result := TClient(BuObj.Owner).ID;
            End;
    end else Result := TClient.IDToggle(GetXMLNodeStringValue(Node, tagname, XMLFieldNodeExists));
end;

Function IsOwnerClient(Const BusObj :TBusObj):Boolean;
begin
    Result := False;
    if not Assigned(BusObj.Owner) then exit;
    Result := (BusObj.Owner is TClient);
end;
function OwnerClientname(Const BusObj :TBusObj):String;
begin
    Result := '';
    if not IsOwnerClient(BusObj) then Exit;
    Result := TClient(BusObj.Owner).ClientName;
end;

procedure CopyAttachments(const SourceTableName: string; SourceTableID: integer;
                          const DestTableName: string; DestTableID: integer; DbConn: TCustomMyConnection);
var
  cmd: TERPCommand;
begin
  cmd:= TERPCommand.Create(nil);
  try
    cmd.Connection:= DbConn;
    cmd.SQL.Add('insert into tblAttachments (TableName,TableId,Attachment,AttachmentName)');
    cmd.SQL.Add('select ' + QuotedStr(DestTableName) + ' as TableName,' + IntToStr(DestTableId)+  ' as TableId,Attachment,AttachmentName');
    cmd.SQL.Add('from tblAttachments');
    cmd.SQL.Add('where TableName = ' + QuotedStr(SourceTableName));
    cmd.SQL.Add('and TableId = ' + IntToStr(SourceTableId));
    cmd.Execute;
  finally
    cmd.Free;
  end;
end;

procedure SetBusObjNextIdNo(const nextId: integer; BusObjClass: TBusObjClass; Conn: TMyConnection);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you wish to change the next ID that ' +
      BusObjClass.XMLNodeName + ' will use to: ' + IntToStr(nextId) + '?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
    if not BusObjClass.SetNextIdNumber(nextId,Conn) then begin
      CommonLib.MessageDlgXP_Vista('Unable to set ID to ' + IntToStr(nextId) +
      ', there are already ID''s in the table that are the same or greater than this value.',
      mtInformation, [mbOk], 0);
    end;
  end;
end;

procedure SetBusObjAutoIncrement(const nextId: integer; BusObjClass: TBusObjClass; Conn: TMyConnection);
var
  lId : integer;
begin
  lId := BusObjClass.GetMaxIdNumber(Conn);
  if nextId < lId then
  begin
    CommonLib.MessageDlgXP_Vista('Unable to set ID to ' + IntToStr(nextId) +
      ', there are already ID''s in the table that are the same or greater than this value.',
      mtInformation, [mbOk], 0);
  end
  else
  begin
    BusObjClass.SetNextIdNumber(nextId,Conn);
    PreferancesLib.DoPrefAuditTrail;
  end;

end;

function ComboLinkedPropBlank(aValue: string): boolean;
begin
  result :=
    (aValue = '') or SameText(aValue, '[Open List]') or SameText(aValue, '[Create New]');
end;

function IsComboSpecialVal(aValue: string): boolean;
begin
  result := SameText(aValue, '[Open List]') or SameText(aValue, '[Create New]');
end;

end.
