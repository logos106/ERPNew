unit BusobjERPWalmartCommon;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/11/18  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;



type
  TWalmartOrderLineStatus_ERP = class(TMSBusObj)
  private
    function GetWOID                  : Integer   ;
    function GetWOLineID              : Integer   ;
    function GetERPOriginalRef        : string    ;
    function GetERPBaseLineno         : Integer   ;
    function GetERPID                 : Integer   ;
    function GetERPLineID             : Integer   ;
    function GetStatus                : string    ;
    function GetStatusBy              : Integer   ;
    function GetSynched               : Boolean   ;
    procedure SetWOID                 (const Value: Integer   );
    procedure SetWOLineID             (const Value: Integer   );
    procedure SetERPOriginalRef       (const Value: string    );
    procedure SetERPBaseLineno        (const Value: Integer   );
    procedure SetERPID                (const Value: Integer   );
    procedure SetERPLineID            (const Value: Integer   );
    procedure SetStatus               (const Value: string    );
    procedure SetStatusBy             (const Value: Integer   );
    procedure SetSynched              (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure DoEvent(const Sender: TObject; const EventType: integer; const Data: TObject = nil ;  Proc : TProcBusObjBase= nil); override;
    //Class function AcknowledgeOrder(aOrderID:Integer):Boolean;
  published
    property WOID                   :Integer     read GetWOID                   write SetWOID            ;
    property WOLineID               :Integer     read GetWOLineID               write SetWOLineID        ;
    property ERPOriginalRef         :string      read GetERPOriginalRef         write SetERPOriginalRef  ;
    property ERPBaseLineno          :Integer     read GetERPBaseLineno          write SetERPBaseLineno   ;
    property ERPID                  :Integer     read GetERPID                  write SetERPID           ;
    property ERPLineID              :Integer     read GetERPLineID              write SetERPLineID       ;
    property Status                 :string      read GetStatus                 write SetStatus          ;
    property StatusBy               :Integer     read GetStatusBy               write SetStatusBy        ;
    property Synched                :Boolean     read GetSynched                write SetSynched         ;
  end;
(*  Twalmartitemqtyupdatelines = class(TMSBusObj)
  private
    function GetUpdateID            : Integer   ;
    function GetWalmartProductId    : Integer   ;
    function GetERPProductID        : Integer   ;
    function GetCurQty              : Double    ;
    function GetNewQty              : Double    ;
    function GetStatus              : string    ;
    function GetStatusText          : string    ;
    function GetfulfillmentLagTime    : Integer   ;
    function GetMinfulfillmentLagTime : Integer   ;
    procedure SetUpdateID            (const Value: Integer   );
    procedure SetWalmartProductId    (const Value: Integer   );
    procedure SetERPProductID        (const Value: Integer   );
    procedure SetCurQty              (const Value: Double    );
    procedure SetNewQty              (const Value: Double    );
    procedure SetStatus              (const Value: string    );
    procedure SetStatusText          (const Value: string    );
    procedure SetfulfillmentLagTime   (const Value: Integer   );
    procedure SetMinfulfillmentLagTime(const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property UpdateID             :Integer     read GetUpdateID           write SetUpdateID        ;
    property WalmartProductId     :Integer     read GetWalmartProductId   write SetWalmartProductId;
    property ERPProductID         :Integer     read GetERPProductID       write SetERPProductID    ;
    property CurQty               :Double      read GetCurQty             write SetCurQty          ;
    property NewQty               :Double      read GetNewQty             write SetNewQty          ;
    property Status               :string      read GetStatus             write SetStatus          ;
    property StatusText           :string      read GetStatusText         write SetStatusText      ;
    property fulfillmentLagTime     :Integer     read GetfulfillmentLagTime     write SetfulfillmentLagTime ;
    property MinfulfillmentLagTime  :Integer     read GetMinfulfillmentLagTime  write SetMinfulfillmentLagTime ;
  end;
 Twalmartitemqtyupdate = class(TMSBusObj)
  private
    function GetQtyUpdateDate       : TDateTime ;
    function GetEmployeeId          : Integer   ;
    function GetEmployeeName        : string    ;
    procedure SetQtyUpdateDate       (const Value: TDateTime );
    procedure SetEmployeeId          (const Value: Integer   );
    procedure SetEmployeeName        (const Value: string    );
    function getLines: Twalmartitemqtyupdatelines;
    procedure PopulateLinesforNew;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property QtyUpdateDate        :TDateTime   read GetQtyUpdateDate      write SetQtyUpdateDate   ;
    property EmployeeId           :Integer     read GetEmployeeId         write SetEmployeeId      ;
    property EmployeeName         :string      read GetEmployeeName       write SetEmployeeName    ;
    Property Lines : Twalmartitemqtyupdatelines read getLines;
  end;*)

implementation


uses ERPdbComponents, tcDataUtils, CommonLib, AppEnvironment, tcConst , Sysutils, SalesConst,
  BusObjEmployee, DbSharedObjectsObj, CommonDbLib, CK_DLL_WalmartLib,
  CK_DLL_Const;


  {TWalmartOrderLineStatus_ERP}

(*class function TWalmartOrderLineStatus_ERP.AcknowledgeOrder(aOrderID: Integer): Boolean;
begin
  if aOrderID = 0 then exit;
  update wallmart orders as acknowledged
  may be move this to TWalmartorder
end;*)

constructor TWalmartOrderLineStatus_ERP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'WalmartOrderStatus';
  fSQL := 'SELECT * FROM tblwalmartorderstatus_erp';
end;


destructor TWalmartOrderLineStatus_ERP.Destroy;
begin
  inherited;
end;


procedure TWalmartOrderLineStatus_ERP.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'WOID');
  SetPropertyFromNode(node,'WOLineID');
  SetPropertyFromNode(node,'ERPOriginalRef');
  SetPropertyFromNode(node,'ERPBaseLineno');
  SetPropertyFromNode(node,'ERPID');
  SetPropertyFromNode(node,'ERPLineID');
  SetPropertyFromNode(node,'Status');
  SetPropertyFromNode(node,'StatusBy');
  SetBooleanPropertyFromNode(node,'Synched');
end;


procedure TWalmartOrderLineStatus_ERP.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'WOID' ,WOID);
  AddXMLNode(node,'WOLineID' ,WOLineID);
  AddXMLNode(node,'ERPOriginalRef' ,ERPOriginalRef);
  AddXMLNode(node,'ERPBaseLineno' ,ERPBaseLineno);
  AddXMLNode(node,'ERPID' ,ERPID);
  AddXMLNode(node,'ERPLineID' ,ERPLineID);
  AddXMLNode(node,'Status' ,Status);
  AddXMLNode(node,'StatusBy' ,StatusBy);
  AddXMLNode(node,'Synched' ,Synched);
end;


function TWalmartOrderLineStatus_ERP.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TWalmartOrderLineStatus_ERP.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWalmartOrderLineStatus_ERP.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWalmartOrderLineStatus_ERP.DoFieldOnChange(Sender: TField);
begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  inherited;
  if Sysutils.SameText(Sender.FieldName, 'Status') then begin
    StatusBy := Appenv.Employee.EmployeeId;
    Synched := False;
  end;
end;


function TWalmartOrderLineStatus_ERP.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWalmartOrderLineStatus_ERP.GetIDField: string;
begin
  Result := 'ID'
end;


class function TWalmartOrderLineStatus_ERP.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartorderstatus_erp';
end;


function TWalmartOrderLineStatus_ERP.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Status :=WalmartOrderStatus_Created;
  StatusBy :=appenv.Employee.EmployeeID;
  Synched := False;
end;

function TWalmartOrderLineStatus_ERP.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


procedure TWalmartOrderLineStatus_ERP.DoEvent(const Sender: TObject;const EventType: integer; const Data: TObject; Proc: TProcBusObjBase);
begin
  inherited;
  case EventType of
    0:;
    { TODO : Walmart - Backorders }
    (*evSalesBOLineSave: begin
      Status := WalmartOrderStatus_ERPBO;
      PostDB;
    end;*)
  end;
end;
{Property Functions}
function  TWalmartOrderLineStatus_ERP.GetWOID                 : Integer   ; begin Result := GetIntegerField('WOID');end;
function  TWalmartOrderLineStatus_ERP.GetWOLineID             : Integer   ; begin Result := GetIntegerField('WOLineID');end;
function  TWalmartOrderLineStatus_ERP.GetERPOriginalRef       : string    ; begin Result := GetStringField('ERPOriginalRef');end;
function  TWalmartOrderLineStatus_ERP.GetERPBaseLineno        : Integer   ; begin Result := GetIntegerField('ERPBaseLineno');end;
function  TWalmartOrderLineStatus_ERP.GetERPID                : Integer   ; begin Result := GetIntegerField('ERPID');end;
function  TWalmartOrderLineStatus_ERP.GetERPLineID            : Integer   ; begin Result := GetIntegerField('ERPLineID');end;
function  TWalmartOrderLineStatus_ERP.GetStatus               : string    ; begin Result := GetStringField('Status');end;
function  TWalmartOrderLineStatus_ERP.GetStatusBy             : Integer   ; begin Result := GetIntegerField('StatusBy');end;
function  TWalmartOrderLineStatus_ERP.GetSynched              : Boolean   ; begin Result := GetBooleanField('Synched');end;
procedure TWalmartOrderLineStatus_ERP.SetWOID                 (const Value: Integer   ); begin SetIntegerField('WOID'             , Value);end;
procedure TWalmartOrderLineStatus_ERP.SetWOLineID             (const Value: Integer   ); begin SetIntegerField('WOLineID'         , Value);end;
procedure TWalmartOrderLineStatus_ERP.SetERPOriginalRef       (const Value: string    ); begin SetStringField('ERPOriginalRef'   , Value);end;
procedure TWalmartOrderLineStatus_ERP.SetERPBaseLineno        (const Value: Integer   ); begin SetIntegerField('ERPBaseLineno'    , Value);end;
procedure TWalmartOrderLineStatus_ERP.SetERPID                (const Value: Integer   ); begin SetIntegerField('ERPID'            , Value);end;
procedure TWalmartOrderLineStatus_ERP.SetERPLineID            (const Value: Integer   ); begin SetIntegerField('ERPLineID'        , Value);end;
procedure TWalmartOrderLineStatus_ERP.SetStatus               (const Value: string    ); begin SetStringField('Status'           , Value);end;
procedure TWalmartOrderLineStatus_ERP.SetStatusBy             (const Value: Integer   ); begin SetIntegerField('StatusBy'         , Value);end;
procedure TWalmartOrderLineStatus_ERP.SetSynched              (const Value: Boolean   ); begin SetBooleanField('Synched'              , Value);end;


(*  {Twalmartitemqtyupdatelines}

constructor Twalmartitemqtyupdatelines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartitemqtyupdatelines';
  fSQL := 'SELECT * FROM tblwalmartitemqtyupdatelines';
end;


destructor Twalmartitemqtyupdatelines.Destroy;
begin
  inherited;
end;


procedure Twalmartitemqtyupdatelines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'UpdateID');
  SetPropertyFromNode(node,'WalmartProductId');
  SetPropertyFromNode(node,'ERPProductID');
  SetPropertyFromNode(node,'CurQty');
  SetPropertyFromNode(node,'NewQty');
  SetPropertyFromNode(node,'Status');
  SetPropertyFromNode(node,'StatusText');
  SetPropertyFromNode(node,'fulfillmentLagTime');
  SetPropertyFromNode(node,'MinfulfillmentLagTime');
end;


procedure Twalmartitemqtyupdatelines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'UpdateID' ,UpdateID);
  AddXMLNode(node,'WalmartProductId' ,WalmartProductId);
  AddXMLNode(node,'ERPProductID' ,ERPProductID);
  AddXMLNode(node,'CurQty' ,CurQty);
  AddXMLNode(node,'NewQty' ,NewQty);
  AddXMLNode(node,'Status' ,Status);
  AddXMLNode(node,'StatusText' ,StatusText);
  AddXMLNode(node,'fulfillmentLagTime' ,fulfillmentLagTime);
  AddXMLNode(node,'MinfulfillmentLagTime' ,MinfulfillmentLagTime);
end;


function Twalmartitemqtyupdatelines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartitemqtyupdatelines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartitemqtyupdatelines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartitemqtyupdatelines.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Twalmartitemqtyupdatelines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartitemqtyupdatelines.GetIDField: string;
begin
  Result := 'ID'
end;


class function Twalmartitemqtyupdatelines.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartitemqtyupdatelines';
end;


function Twalmartitemqtyupdatelines.DoAfterInsert(
  Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is Twalmartitemqtyupdate then
      UpdateId := Twalmartitemqtyupdate(Owner).id;
  fulfillmentLagTime :=1;
  MinfulfillmentLagTime :=1;
end;

function Twalmartitemqtyupdatelines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Twalmartitemqtyupdatelines.GetUpdateID        : Integer   ; begin Result := GetIntegerField('UpdateID');end;
function  Twalmartitemqtyupdatelines.GetWalmartProductId: Integer   ; begin Result := GetIntegerField('WalmartProductId');end;
function  Twalmartitemqtyupdatelines.GetERPProductID    : Integer   ; begin Result := GetIntegerField('ERPProductID');end;
function  Twalmartitemqtyupdatelines.GetCurQty          : Double    ; begin Result := GetFloatField('CurQty');end;
function  Twalmartitemqtyupdatelines.GetNewQty          : Double    ; begin Result := GetFloatField('NewQty');end;
function  Twalmartitemqtyupdatelines.GetStatus          : string    ; begin Result := GetStringField('Status');end;
function  Twalmartitemqtyupdatelines.GetStatusText      : string    ; begin Result := GetStringField('StatusText');end;
function  Twalmartitemqtyupdatelines.GetfulfillmentLagTime   : Integer   ; begin Result := GetIntegerField('fulfillmentLagTime');end;
function  Twalmartitemqtyupdatelines.GetMinfulfillmentLagTime: Integer   ; begin Result := GetIntegerField('MinfulfillmentLagTime');end;
procedure Twalmartitemqtyupdatelines.SetUpdateID        (const Value: Integer   ); begin SetIntegerField('UpdateID'         , Value);end;
procedure Twalmartitemqtyupdatelines.SetWalmartProductId(const Value: Integer   ); begin SetIntegerField('WalmartProductId' , Value);end;
procedure Twalmartitemqtyupdatelines.SetERPProductID    (const Value: Integer   ); begin SetIntegerField('ERPProductID'     , Value);end;
procedure Twalmartitemqtyupdatelines.SetCurQty          (const Value: Double    ); begin SetFloatField('CurQty'           , Value);end;
procedure Twalmartitemqtyupdatelines.SetNewQty          (const Value: Double    ); begin SetFloatField('NewQty'           , Value);end;
procedure Twalmartitemqtyupdatelines.SetStatus          (const Value: string    ); begin SetStringField('Status'           , Value);end;
procedure Twalmartitemqtyupdatelines.SetStatusText      (const Value: string    ); begin SetStringField('StatusText'       , Value);end;
procedure Twalmartitemqtyupdatelines.SetfulfillmentLagTime   (const Value: Integer   ); begin SetIntegerField('fulfillmentLagTime'   , Value);end;
procedure Twalmartitemqtyupdatelines.SetMinfulfillmentLagTime(const Value: Integer   ); begin SetIntegerField('MinfulfillmentLagTime', Value);end;


{Twalmartitemqtyupdate}

constructor Twalmartitemqtyupdate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'walmartitemqtyupdate';
  fSQL := 'SELECT * FROM tblwalmartitemqtyupdate';
end;


destructor Twalmartitemqtyupdate.Destroy;
begin
  inherited;
end;


procedure Twalmartitemqtyupdate.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetDateTimePropertyFromNode(node,'QtyUpdateDate');
  SetPropertyFromNode(node,'EmployeeId');
  SetPropertyFromNode(node,'EmployeeName');
end;


procedure Twalmartitemqtyupdate.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'QtyUpdateDate' ,QtyUpdateDate);
  AddXMLNode(node,'EmployeeId' ,EmployeeId);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
end;


function Twalmartitemqtyupdate.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Twalmartitemqtyupdate.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Twalmartitemqtyupdate.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Twalmartitemqtyupdate.DoFieldOnChange(Sender: TField);
begin
  If (Sender.FieldKind <> FkData) Or Dataset.ControlsDisabled Then
    If Not DoFieldChangewhenDisabled Then Exit; // we are only interested in data fields.

  inherited;
  if Sysutils.SameText(Sender.FieldName, 'Employeename') then begin
    EmployeeID:= Temployee.IDToggle(Employeename);
  end else if Sysutils.SameText(Sender.FieldName, 'EmployeeID') then begin
    Employeename:= Temployee.IDToggle(EmployeeID);
  end;
end;


function Twalmartitemqtyupdate.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Twalmartitemqtyupdate.GetIDField: string;
begin
  Result := 'ID'
end;


function Twalmartitemqtyupdate.getLines: Twalmartitemqtyupdatelines;
begin
  Result := Twalmartitemqtyupdatelines(Getcontainercomponent(Twalmartitemqtyupdatelines , 'UpdateID = '+ inttostr(ID)));
end;
class function Twalmartitemqtyupdate.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartitemqtyupdate';
end;
function Twalmartitemqtyupdate.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  EmployeeName := appenv.Employee.EmployeeName;
  QtyUpdateDate := now;
  PostDB;
  PopulateLinesforNew;
end;
Procedure Twalmartitemqtyupdate.PopulateLinesforNew;
var
  qry: TERPQuery;
  errMsg:String;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
  try
    Commondblib.Closedb(qry);
    qry.SQL.text := 'select WI.ID as WIID, WI.ProductName WIProductName, P.PARTSID erpPARTSID, P.PARTNAME ERPProductname ,  '+
                    '  ifnull(WI.UOM , '+ Quotedstr(DefaultWalmartUOM)+') as UOM , ' +
                    '  ifnull(WI.UOMMult ,1) as UOMMult , ' +
                    ' WI.Sku, WI.fulfillmentLagTime,WI.MinfulfillmentLagTime ,WI.UOMQty'+
                    ' from tblwalmartitems WI '+
                    ' left join tblparts P on WI.ERPProductId = P.partsId '+
                    ' Order by WIProductName';
    Commondblib.OpenDB(qry);
    self.showProgressbar(Qry.RecordCount,'Check For Available Qty on Walmart');
    try
      if qry.recordcount > 0 then begin
        qry.first;
        while qry.eof = False do begin
          if not Lines.Locate('WalmartProductId' ,qry.Fieldbyname('WIID').asInteger , [] ) then begin
            Lines.New;
            Lines.WalmartProductId := qry.Fieldbyname('WIID').asInteger;
          end;
          if Lines.ERPProductID <> qry.Fieldbyname('erpPARTSID').asInteger then Lines.ERPProductID := qry.Fieldbyname('erpPARTSID').asInteger;
          Lines.CurQty := ItemStockQty(qry.Fieldbyname('Sku').asString, errMsg, nil);
          Lines.NewQty := divZer(ProductAvailableQty(qry.Fieldbyname('erpPARTSID').asInteger , ''{qry.FieldByname('uom').asString}) ,
                                                           qry.FieldByname('UOMMult').asFloat);
{          if Lines.NewQty =0 then Lines.NewQty := Lines.CurQty;
          if Lines.NewQty =0 then Lines.NewQty := qry.Fieldbyname('UOMQty').asFloat;}
          Lines.fulfillmentLagTime := qry.Fieldbyname('fulfillmentLagTime').asInteger;
          Lines.MinfulfillmentLagTime := qry.Fieldbyname('MinfulfillmentLagTime').asInteger;
          Lines.PostDB;
          stepProgressbar(qry.Fieldbyname('WIProductName').asString);
          qry.Next;
        end;
      end;
    finally
      HideProgressbar;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
function Twalmartitemqtyupdate.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;
{Property Functions}
function  Twalmartitemqtyupdate.GetQtyUpdateDate   : TDateTime ; begin Result := GetDateTimeField('QtyUpdateDate');end;
function  Twalmartitemqtyupdate.GetEmployeeId      : Integer   ; begin Result := GetIntegerField('EmployeeId');end;
function  Twalmartitemqtyupdate.GetEmployeeName    : string    ; begin Result := GetStringField('EmployeeName');end;
procedure Twalmartitemqtyupdate.SetQtyUpdateDate   (const Value: TDateTime ); begin SetDateTimeField('QtyUpdateDate'    , Value);end;
procedure Twalmartitemqtyupdate.SetEmployeeId      (const Value: Integer   ); begin SetIntegerField('EmployeeId'       , Value);end;
procedure Twalmartitemqtyupdate.SetEmployeeName    (const Value: string    ); begin SetStringField('EmployeeName'     , Value);end;
*)

initialization
(*  RegisterClass(Twalmartitemqtyupdate);
  RegisterClass(Twalmartitemqtyupdatelines);*)
  RegisterClass(TWalmartOrderLineStatus_ERP);


end.
