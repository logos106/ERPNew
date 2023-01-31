unit busobjPOSOrders;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   23/05/07   1.00.01   A.   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
   TPOSOrderlines = class(TMSBusObj)
   private
      Function GetLastupdated             :TDatetime ;
      Function GetOrderid                 :Integer   ;
      Function GetSaleslineid             :Integer   ;
      Function GetPartid                  :Integer   ;
      Function GetDescription             :String    ;
      Function GetQty                     :Double    ;
      Function GetRequiresprocessing      :Boolean   ;
      Function GetStatus                  :Integer   ;
      Function GetCurrentprocstep         :Integer   ;
      Function GetComplete                :Boolean   ;
      Procedure SetLastupdated             (Const Value :TDatetime );
      Procedure SetOrderid                 (Const Value :Integer   );
      Procedure SetSaleslineid             (Const Value :Integer   );
      Procedure SetPartid                  (Const Value :Integer   );
      Procedure SetDescription             (Const Value :String    );
      Procedure SetQty                     (Const Value :Double    );
      Procedure SetRequiresprocessing      (Const Value :Boolean   );
      Procedure SetStatus                  (Const Value :Integer   );
      Procedure SetCurrentprocstep         (Const Value :Integer   );
      Procedure SetComplete                (Const Value :Boolean   );
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;


      Property Lastupdated              :TDatetime    Read getLastupdated           Write SetLastupdated       ;
      Property Orderid                  :Integer      Read getOrderid               Write SetOrderid           ;
      Property Saleslineid              :Integer      Read getSaleslineid           Write SetSaleslineid       ;
      Property Partid                   :Integer      Read getPartid                Write SetPartid            ;
      Property Description              :String       Read getDescription           Write SetDescription       ;
      Property Qty                      :Double       Read GetQty                   Write SetQty               ;
      Property Requiresprocessing       :Boolean      Read getRequiresprocessing    Write SetRequiresprocessing;
      Property Status                   :Integer      Read getStatus                Write SetStatus            ;
      Property Currentprocstep          :Integer      Read getCurrentprocstep       Write SetCurrentprocstep   ;
      Property Complete                 :Boolean      Read getComplete              Write SetComplete          ;
   End;

   TPOSOrder = class(TMSBusObj)
   private
      //fLines :TPOSOrderlines;
      Function GetLastupdated        :TDatetime ;
      Function GetSaleid             :Integer   ;
      Function GetCreatetime         :TDatetime ;
      Function GetCustdocketref      :String    ;
      Function GetStarttime          :TDatetime ;
      Function GetEndtime            :TDatetime ;
      Function GetComplete           :Boolean   ;
      function GetLines              :TPOSOrderlines;
      Procedure SetLastupdated        (Const Value :TDatetime );
      Procedure SetSaleid             (Const Value :Integer   );
      Procedure SetCreatetime         (Const Value :TDatetime );
      Procedure SetCustdocketref      (Const Value :String    );
      Procedure SetStarttime          (Const Value :TDatetime );
      Procedure SetEndtime            (Const Value :TDatetime );
      Procedure SetComplete           (Const Value :Boolean   );
      //Procedure SetLines              (Const value :TPOSOrderlines);
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;


      Property Lastupdated         :TDatetime    Read getLastupdated      Write SetLastupdated  ;
      Property Saleid              :Integer      Read getSaleid           Write SetSaleid       ;
      Property Createtime          :TDatetime    Read getCreatetime       Write SetCreatetime   ;
      Property Custdocketref       :String       Read getCustdocketref    Write SetCustdocketref;
      Property Starttime           :TDatetime    Read getStarttime        Write SetStarttime    ;
      Property Endtime             :TDatetime    Read getEndtime          Write SetEndtime      ;
      Property Complete            :Boolean      Read getComplete         Write SetComplete     ;
      Property Lines               :TPOSOrderlines  Read GetLines         ;//Write SetLines; 
   End;


implementation


uses CommonLib, sysutils;


{========================================================
         TPOSOrder
========================================================}
constructor TPOSOrder.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblorder';
end;


destructor TPOSOrder.Destroy;
begin
   inherited;
end;


procedure   TPOSOrder.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
      Lastupdated         :=GetXMLNodeDatetimeValue(Node,'Lastupdated');
      Saleid              :=GetXMLNodeIntegerValue(Node,'Saleid');
      Createtime          :=GetXMLNodeDatetimeValue(Node,'Createtime');
      Custdocketref       :=GetXMLNodeStringValue(Node,'Custdocketref');
      Starttime           :=GetXMLNodeDatetimeValue(Node,'Starttime');
      Endtime             :=GetXMLNodeDatetimeValue(Node,'Endtime');
      Complete            :=GetXMLNodeBooleanValue(Node,'Complete');
end;


procedure   TPOSOrder.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Lastupdated' ,Lastupdated);
      AddXMLNode(node,'Saleid' ,Saleid);
      AddXMLNode(node,'Createtime' ,Createtime);
      AddXMLNode(node,'Custdocketref' ,Custdocketref);
      AddXMLNode(node,'Starttime' ,Starttime);
      AddXMLNode(node,'Endtime' ,Endtime);
      AddXMLNode(node,'Complete' ,Complete);
end;


function    TPOSOrder.ValidateData :Boolean ;
begin
   Resultstatus.Clear;
   Result := true;
end;


function    TPOSOrder.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TPOSOrder.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TPOSOrder.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TPOSOrder.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TPOSOrder.GetIDField : String;
begin
   Result := 'Id'
end;

class function TPOSOrder.GetBusObjectTablename: string;
begin
  Result := 'tblorder';
end;

Function  TPOSOrder.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

function TPOSOrder.GetLines :TPOSOrderlines;
begin
    Result := TPOSOrderlines(getContainerComponent(TPOSOrderlines, 'OrderID = '+ IntToStr(Self.Id)));
end;

{Property functions}
Function  TPOSOrder.GetLastupdated  :TDatetime ; begin Result := GetDatetimeField('Lastupdated');End;
Function  TPOSOrder.GetSaleid       :Integer   ; begin Result := GetIntegerField('Saleid');End;
Function  TPOSOrder.GetCreatetime   :TDatetime ; begin Result := GetDatetimeField('Createtime');End;
Function  TPOSOrder.GetCustdocketref:String    ; begin Result := GetStringField('Custdocketref');End;
Function  TPOSOrder.GetStarttime    :TDatetime ; begin Result := GetDatetimeField('Starttime');End;
Function  TPOSOrder.GetEndtime      :TDatetime ; begin Result := GetDatetimeField('Endtime');End;
Function  TPOSOrder.GetComplete     :Boolean   ; begin Result := GetBooleanField('Complete');End;
Procedure TPOSOrder.SetLastupdated  (Const Value :TDatetime ); begin SetDatetimeField('Lastupdated'   , Value);End;
Procedure TPOSOrder.SetSaleid       (Const Value :Integer   ); begin SetIntegerField('Saleid'        , Value);End;
Procedure TPOSOrder.SetCreatetime   (Const Value :TDatetime ); begin SetDatetimeField('Createtime'    , Value);End;
Procedure TPOSOrder.SetCustdocketref(Const Value :String    ); begin SetStringField('Custdocketref' , Value);End;
Procedure TPOSOrder.SetStarttime    (Const Value :TDatetime ); begin SetDatetimeField('Starttime'     , Value);End;
Procedure TPOSOrder.SetEndtime      (Const Value :TDatetime ); begin SetDatetimeField('Endtime'       , Value);End;
Procedure TPOSOrder.SetComplete     (Const Value :Boolean   ); begin SetBooleanField('Complete'      , Value);End;


{========================================================
         TPOSOrderlines
========================================================}
constructor TPOSOrderlines.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fSQL := 'SELECT * FROM tblorderlines';
end;


destructor TPOSOrderlines.Destroy;
begin
   inherited;
end;


procedure   TPOSOrderlines.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
      Lastupdated              :=GetXMLNodeDatetimeValue(Node,'Lastupdated');
      Orderid                  :=GetXMLNodeIntegerValue(Node,'Orderid');
      Saleslineid              :=GetXMLNodeIntegerValue(Node,'Saleslineid');
      Partid                   :=GetXMLNodeIntegerValue(Node,'Partid');
      Description              :=GetXMLNodeStringValue(Node,'Description');
      Qty                      :=GetXMLNodeFloatValue(Node,'Qty');
      Requiresprocessing       :=GetXMLNodeBooleanValue(Node,'Requiresprocessing');
      Status                   :=GetXMLNodeIntegerValue(Node,'Status');
      Currentprocstep          :=GetXMLNodeIntegerValue(Node,'Currentprocstep');
      Complete                 :=GetXMLNodeBooleanValue(Node,'Complete');
end;


procedure   TPOSOrderlines.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Lastupdated' ,Lastupdated);
      AddXMLNode(node,'Orderid' ,Orderid);
      AddXMLNode(node,'Saleslineid' ,Saleslineid);
      AddXMLNode(node,'Partid' ,Partid);
      AddXMLNode(node,'Description' ,Description);
      AddXMLNode(node,'Qty' ,Qty);
      AddXMLNode(node,'Requiresprocessing' ,Requiresprocessing);
      AddXMLNode(node,'Status' ,Status);
      AddXMLNode(node,'Currentprocstep' ,Currentprocstep);
      AddXMLNode(node,'Complete' ,Complete);
end;


function    TPOSOrderlines.ValidateData :Boolean ;
begin
   Resultstatus.Clear;
   Result := true;
end;


function    TPOSOrderlines.Save :Boolean ;
begin
   Result := False;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TPOSOrderlines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TPOSOrderlines.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TPOSOrderlines.GetSQL: String ;
begin
   Result := Inherited GetSQL;
end;


class function  TPOSOrderlines.GetIDField : String;
begin
   Result := 'Id'
end;

class function TPOSOrderlines.GetBusObjectTablename: string;
begin
  Result := 'tblorderlines';
end;

Function  TPOSOrderlines.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited DoAfterPost(sender);
    if not result then Exit;
    if Assigned(Self.Owner) then
        if Self.Owner is  TPOSOrder then
            OrderID := TPOSOrder(Self.Owner).ID;
end;
Function  TPOSOrderlines.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TPOSOrderlines.GetLastupdated       :TDatetime ; begin Result := GetDatetimeField('Lastupdated');End;
Function  TPOSOrderlines.GetOrderid           :Integer   ; begin Result := GetIntegerField('Orderid');End;
Function  TPOSOrderlines.GetSaleslineid       :Integer   ; begin Result := GetIntegerField('Saleslineid');End;
Function  TPOSOrderlines.GetPartid            :Integer   ; begin Result := GetIntegerField('Partid');End;
Function  TPOSOrderlines.GetDescription       :String    ; begin Result := GetStringField('Description');End;
Function  TPOSOrderlines.GetQty               :Double    ; begin Result := GetFloatField('Qty');End;
Function  TPOSOrderlines.GetRequiresprocessing:Boolean   ; begin Result := GetBooleanField('Requiresprocessing');End;
Function  TPOSOrderlines.GetStatus            :Integer   ; begin Result := GetIntegerField('Status');End;
Function  TPOSOrderlines.GetCurrentprocstep   :Integer   ; begin Result := GetIntegerField('Currentprocstep');End;
Function  TPOSOrderlines.GetComplete          :Boolean   ; begin Result := GetBooleanField('Complete');End;
Procedure TPOSOrderlines.SetLastupdated       (Const Value :TDatetime ); begin SetDatetimeField('Lastupdated'        , Value);End;
Procedure TPOSOrderlines.SetOrderid           (Const Value :Integer   ); begin SetIntegerField('Orderid'            , Value);End;
Procedure TPOSOrderlines.SetSaleslineid       (Const Value :Integer   ); begin SetIntegerField('Saleslineid'        , Value);End;
Procedure TPOSOrderlines.SetPartid            (Const Value :Integer   ); begin SetIntegerField('Partid'             , Value);End;
Procedure TPOSOrderlines.SetDescription       (Const Value :String    ); begin SetStringField('Description'        , Value);End;
Procedure TPOSOrderlines.SetQty               (Const Value :Double    ); begin SetFloatField('Qty'                , Value);End;
Procedure TPOSOrderlines.SetRequiresprocessing(Const Value :Boolean   ); begin SetBooleanField('Requiresprocessing' , Value);End;
Procedure TPOSOrderlines.SetStatus            (Const Value :Integer   ); begin SetIntegerField('Status'             , Value);End;
Procedure TPOSOrderlines.SetCurrentprocstep   (Const Value :Integer   ); begin SetIntegerField('Currentprocstep'    , Value);End;
Procedure TPOSOrderlines.SetComplete          (Const Value :Boolean   ); begin SetBooleanField('Complete'           , Value);End;


initialization
    RegisterClassOnce(TPOSOrderlines);
    RegisterClassOnce(TPOSOrder);


end.
