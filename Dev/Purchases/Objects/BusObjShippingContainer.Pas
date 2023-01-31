unit BusObjShippingContainer;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  30/07/08  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjShipContainerDetails;


type
  TShippingContainer = class(TMSBusObj)
  private
    fTotalAuxilaryCosts:double;
    POToReceivefound:Boolean;
    function GetContainerDetails: TShipContainerDetails;
    //function GetShippingContainerId: integer;

    function GetContainerName              : string    ;
    function GetETDeparture                : TDateTime ;
    function GetShippingContainerStatus    : string    ;
    function GetDeparturePoint             : string    ;
    function GetVesselName                 : string    ;
    function GetETA                        : TDateTime ;
    function GetArrivalPoint               : string    ;
    function GetActive                     : Boolean   ;
    function GetContainerNotes             : string    ;
    procedure SetContainerName              (const Value: string    );
    procedure SetETDeparture                (const Value: TDateTime );
    procedure SetShippingContainerStatus    (const Value: string    );
    procedure SetDeparturePoint             (const Value: string    );
    procedure SetVesselName                 (const Value: string    );
    procedure SetETA                        (const Value: TDateTime );
    procedure SetArrivalPoint               (const Value: string    );
    procedure SetActive                     (const Value: Boolean   );
    procedure SetContainerNotes             (const Value: string    );
    Procedure SearchPOToReceive(Const Sender: TBusObj; var Abort: boolean);
    function getClientEmails: String;
    function getheaderChanged: Boolean;
    function GetCleanETA: TDateTime;
    function GetCleanETDeparture: TDateTime;
    function GetCleanShippingContainerStatus: string;


  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
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
    function     ReceiveAll(var msg:String):Boolean;
    function     HasPOToreceive:Boolean;
    Property HeaderChanged :Boolean read getheaderChanged;
    property CleanETDeparture                 :TDateTime   read GetCleanETDeparture;
    property CleanETA                         :TDateTime   read GetCleanETA;
    property CleanShippingContainerStatus     :string      read GetCleanShippingContainerStatus;
    Procedure UpdatePOLinesETA;
    class function ContainerIdForPurchaseLineId(const aPurchaseLineID: integer): integer;
  published
    property ContainerName               :string      read GetContainerName             write SetContainerName          ;
    property ETDeparture                 :TDateTime   read GetETDeparture               write SetETDeparture            ;
    property ETA                         :TDateTime   read GetETA                       write SetETA                    ;
    property ShippingContainerStatus     :string      read GetShippingContainerStatus   write SetShippingContainerStatus;
    property DeparturePoint              :string      read GetDeparturePoint            write SetDeparturePoint         ;
    property VesselName                  :string      read GetVesselName                write SetVesselName             ;
    property ArrivalPoint                :string      read GetArrivalPoint              write SetArrivalPoint           ;
    property Active                      :Boolean     read GetActive                    write SetActive                 ;
    property ContainerNotes              :String      read GetContainerNotes            write SetContainerNotes         ;
    property ContainerDetails :TShipContainerDetails read GetContainerDetails;
    //property ShippingContainerId: integer read GetShippingContainerId;
    property ClientEmails :String read getClientEmails;

    property TotalAuxilaryCosts :double read fTotalAuxilaryCosts write fTotalAuxilaryCosts;
  end;


implementation


uses tcDataUtils, CommonLib,BusObjConst, busobjOrders,
  ERPdbComponents, BusObjTrans, sysutils, UserLockObj, AppEnvironment,
  MySQLConst, DbSharedObjectsObj, CommonDbLib;

  {TShippingContainer}


class function TShippingContainer.ContainerIdForPurchaseLineId(
  const aPurchaseLineID: integer): integer;
var
  qry: TERPQuery;
begin
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select sd.ShippingContainerID from tblshipcontainerdetails sd');
    qry.SQL.Add('inner join tblshippingcontainer s on s.ShippingContainerID = sd.ShippingContainerID');
    qry.SQL.Add('and s.Active = "T"');
    qry.SQL.Add('where sd.PurchaseLineID = ' + IntToStr(aPurchaseLineID));
    qry.Open;
    result := qry.FieldByName('ShippingContainerID').AsInteger;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

constructor TShippingContainer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ShippingContainer';
  fSQL := 'SELECT * FROM tblshippingcontainer';
end;


destructor TShippingContainer.Destroy;
begin
  inherited;
end;


procedure TShippingContainer.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Globalref');
  SetPropertyFromNode(node,'ContainerName');
  SetDateTimePropertyFromNode(node,'ETDeparture');
  SetPropertyFromNode(node,'ShippingContainerStatus');
  SetPropertyFromNode(node,'DeparturePoint');
  SetPropertyFromNode(node,'VesselName');
  SetDateTimePropertyFromNode(node,'ETA');
  SetPropertyFromNode(node,'ArrivalPoint');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'ContainerNotes');
end;


procedure TShippingContainer.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Globalref' ,Globalref);
  AddXMLNode(node,'ContainerName' ,ContainerName);
  AddXMLNode(node,'ETDeparture' ,ETDeparture);
  AddXMLNode(node,'ShippingContainerStatus' ,ShippingContainerStatus);
  AddXMLNode(node,'DeparturePoint' ,DeparturePoint);
  AddXMLNode(node,'VesselName' ,VesselName);
  AddXMLNode(node,'ETA' ,ETA);
  AddXMLNode(node,'ArrivalPoint' ,ArrivalPoint);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'ContainerNotes' ,ContainerNotes);
end;


function TShippingContainer.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ContainerName = '' then begin
    Resultstatus.AddItem(False , rssError , BOR_No_Ship_ContainerName,  'Enter Container name.'  );
    Exit;
  end;
  if ShippingContainerStatus = '' then begin
    Resultstatus.AddItem(False , rssError , BOR_No_Ship_Container_Status,  'Select a Status.'  );
    Exit;
  end;
  Result := True;
end;


function TShippingContainer.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  if not Self.ContainerDetails.ValidateData then Exit;
  Self.ContainerDetails.PostDb;
  Result := inherited Save;
  if not result then exit;
  //updatePOLinesETA;
end;


procedure TShippingContainer.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TShippingContainer.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TShippingContainer.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TShippingContainer.GetIDField: string;
begin
  Result := 'ShippingContainerID'
end;


class function TShippingContainer.GetBusObjectTablename: string;
begin
  Result:= 'tblshippingcontainer';
end;


function TShippingContainer.GetCleanETA: TDateTime;
begin
  result:= GetXMLNodeDateTimeValue(CleanXMLNode, 'ETA');
end;

function TShippingContainer.GetCleanETDeparture: TDateTime;
begin
  result:= GetXMLNodeDateTimeValue(CleanXMLNode, 'ETDeparture');
end;

function TShippingContainer.GetCleanShippingContainerStatus: string;
begin
  result:= GetXMLNodeStringValue(CleanXMLNode, 'ShippingContainerStatus');
end;

function TShippingContainer.getClientEmails: String;
var
  s:String;
begin
  s:= 'Select distinct  C.Email from ' +
        ' tblshipcontainerdetails SCD ' +
        ' inner join tblpurchaselines PL on PL.PurchaseLineID = SCD.PurchaseLineID ' +
        ' inner join tblclients C on C.ClientID = PL.CustomerJobID ' +
        ' Where ifnull(C.Email,"") <> "" and SCD.ShippingContainerID = ' + inttostr(ID);
  With TERPQuery(getnewDataset(s, true)) do try
    result := GroupConcat('Email','', False, ';');
  finally
    if Active then Close;
    Free;
  end;
end;

function TShippingContainer.DoAfterinsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterinsert(Sender);
end;

function TShippingContainer.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;     

function TShippingContainer.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
end;

{Property Functions}
function  TShippingContainer.GetContainerName          : string    ; begin Result := GetStringField('ContainerName');end;
function  TShippingContainer.GetETDeparture            : TDateTime ; begin Result := GetDateTimeField('ETDeparture');end;

function TShippingContainer.getheaderChanged: Boolean;
begin
    result := (CleanETDeparture <> ETDeparture) or
              (CleanETA<> ETA) or
              (CleanShippingContainerStatus <> ShippingContainerStatus);
end;

function  TShippingContainer.GetShippingContainerStatus: string    ; begin Result := GetStringField('ShippingContainerStatus');end;
function  TShippingContainer.GetDeparturePoint         : string    ; begin Result := GetStringField('DeparturePoint');end;
function  TShippingContainer.GetVesselName             : string    ; begin Result := GetStringField('VesselName');end;
function  TShippingContainer.GetETA                    : TDateTime ; begin Result := GetDateTimeField('ETA');end;
function  TShippingContainer.GetArrivalPoint           : string    ; begin Result := GetStringField('ArrivalPoint');end;
function  TShippingContainer.GetActive                 : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TShippingContainer.GetContainerNotes         : string    ; begin Result := GetStringField('ContainerNotes');end;
procedure TShippingContainer.SetContainerName          (const Value: string    ); begin SetStringField('ContainerName'           , Value);end;
procedure TShippingContainer.SetETDeparture            (const Value: TDateTime ); begin SetDateTimeField('ETDeparture'             , Value);end;
procedure TShippingContainer.SetShippingContainerStatus(const Value: string    ); begin SetStringField('ETDeparture'             , Value);end;
procedure TShippingContainer.SetDeparturePoint         (const Value: string    ); begin SetStringField('DeparturePoint'          , Value);end;
procedure TShippingContainer.SetVesselName             (const Value: string    ); begin SetStringField('VesselName'              , Value);end;

procedure TShippingContainer.updatePOLinesETA;
var
  s:String;
  lockedPOs:String;
  POIds:String;
  function updatePOLinesSQLforPO(Const POID:Integer):String;
  var
    s:String;
  begin
    s:= ' Select POL.PurchaseLineID ' +
        ' from tblshipcontainerdetails SCD inner join tblpurchaselines POL on POL.PurchaseLineID = SCD.PurchaseLineID ' +
        ' Where POL.PurchaseOrderID = ' +inttostr(POID)+' and SCD.ShippingContainerID = ' +inttostr(ID) ;
    with TERPQuery(GetNewDataSet(s , true)) do try
      Result := Groupconcat('PurchaseLineID');
    finally
      if active then close;
      Free;
    end;
  end;
begin
  if not(Appenv.companyprefs.POMatchLineETAToShippingContainerETA) (*and not(Appenv.companyprefs.POMatchHeaderETAToShippingContainerETA)*) then exit;
  if ETA = 0 then exit;

  s:= 'Select distinct POL.PurchaseOrderID from tblshipcontainerdetails SCD inner join tblpurchaselines POL on POL.PurchaseLineID = SCD.PurchaseLineID where SCD.ShippingContainerID=' +inttostr(ID);
  With getNewdataset(s,true) do try
    if recordcount =0 then exit;
    First;
    lockedPOs := '';
    s:= '';
    POIds:='';
    try
      While Eof = False do begin
        if not UserLock.Lock('tblpurchaseorders' , FieldByname('PurchaseOrderID').asInteger , LockGroupName  ) then begin
          if lockedPOs <> '' then lockedPOs := lockedPOs +',';
          lockedPOs := lockedPOs + intToStr(FieldByname('PurchaseOrderID').asInteger);
        end else begin
          if Appenv.companyprefs.POMatchLineETAToShippingContainerETA then begin
           s:= s+ chr(13) +
              ' update tblpurchaselines '+
              ' set ETADate = ' +Quotedstr(formatDateTime(MysqlDateFormat , ETA ))+
              ' where PurchaseLineID in (' + updatePOLinesSQLforPO(FieldByname('PurchaseOrderID').asInteger)+');';
           if POIds <> '' then POIds := POIds +',';
           POIds := POIds + inttostr(FieldByname('PurchaseOrderID').asInteger );
          end;

          (*if Appenv.companyprefs.POMatchHeaderETAToShippingContainerETA then
           s:= s+ chr(13) +
              ' update tblpurchaseorders '+
              ' set ETADate = ' +Quotedstr(formatDateTime(MysqlDateFormat , ETA ))+
              ' where PurchaseOrderID = ' + inttostr(FieldByname('PurchaseOrderID').asInteger)+';';*)
        end;
        Next;
      end;
      if s<>'' then begin
        if   Appenv.companyprefs.POMatchHeaderETAToLineETA  and (trim(POIDs)<> '') then
          s:= s +' Drop table if exists tmp_1; ' +
                  ' create table tmp_1 Select  po.purchaseorderId,  min(pol.ETADate) etadate from ' +
                  ' tblpurchaseorders po inner join tblpurchaselines pol on po.purchaseorderid = pol.purchaseorderid  and ifnull(POL.etadate,0)> 0 ' +
                  ' where po.PurchaseOrderID in ('+POIDS+'); ' +
                  ' update tmp_1 t inner join tblpurchaseorders po on T.purchaseorderId = po.purchaseorderId set PO.etadate = t.etadate; ' +
                  ' Drop table if exists tmp_1; ' ;
        ExecuteSQL(s, true);
      end;
    finally
      //UserLock.Unlock('POUpdateFromShipingContainer');
      if lockedPOs <> '' then
        ResultStatus.AddItem(True , rssInfo , 0 , 'ETA Date is not Updated for the Following Purchase Orders as it is Already Locked.' +chr(13) + lockedPOs , true);
    end;
  finally
    if active then close;
    Free;
  end;
end;

procedure TShippingContainer.SetETA                    (const Value: TDateTime ); begin SetDateTimeField('ETA'                     , Value);end;
procedure TShippingContainer.SetArrivalPoint           (const Value: string    ); begin SetStringField('ArrivalPoint'            , Value);end;
procedure TShippingContainer.SetActive                 (const Value: Boolean   ); begin SetBooleanField('Active'                  , Value);end;
procedure TShippingContainer.SetContainerNotes         (const Value: string    ); begin SetStringField('ContainerNotes'         , Value);end;

function  TShippingContainer.GetContainerDetails:TShipContainerDetails;
begin
  PostDB;
  result :=TShipContainerDetails(getContainerComponent(TShipContainerDetails , 'ShippingContainerID = ' + IntToStr(ID) ));
end;

(*function  TShippingContainer.GetShippingContainerId:integer;
begin
  Result := GetIntegerField('ShippingContainerID');
end;*)



function TShippingContainer.ReceiveAll(var msg:String):Boolean;
var
  strSQL:string;
  POID:Integer;
  PO:TPurchaseOrder;
  inTrans: boolean;
begin
  result := False;
  if count = 0 then begin
      msg:= 'The container is not loaded'  ;
      Exit;
  end;
  if (ContainerDetails.count = 0)  or (HasPOToreceive =False) then begin
      msg :=   'The container is either empty or has partial shipments which cannot be shipped automatically'  ;
      Exit;
  end;
  strSQL:= 'SELECT SCD.PurchaseLineID,PL.PurchaseOrderID' +
            ' FROM tblshipcontainerdetails AS SCD' +
            ' Inner Join tblpurchaselines AS PL ON SCD.PurchaseLineID = PL.PurchaseLineID' +
            ' WHERE ifnull(PL.shipped,0) = 0 ' +
            ' and SCD.ShippingContainerID =  ' + IntToStr(ID) +
            ' order by PurchaseOrderID' ;
  with getNewDataset(strSQL, true) do try
    if Recordcount = 0 then begin
      msg := 'All Products in the container is already received.'  ;
      Exit;
    end;
    Msg := '';
    First;
    POID := fieldByname('PurchaseOrderID').asInteger;
    showProgressbar(Recordcount);
    self.connection.BeginNestedTransaction;
    inTrans := true;
    try
      While Eof = False do begin
        PO:= TPurchaseOrder.create(Self);
        PO.connection := self.connection;
        PO.SilentMode := true;
        try
          PO.Load(POID);
          if USerLock.Lock(PO.GetBusObjectTablename , PO.ID, 'Shipping Container - Receive') = False then begin
              msg := PO.UserLock.LockMessage;
              Exit;
          end;
          While (POID = fieldByname('PurchaseOrderID').asInteger) and (EOF = False) do begin
            if PO.Lines.dataset.Locate('PurchaseLineID' ,fieldByname('PurchaseLineID').asInteger , []) then begin
                PO.Lines.QtyShipped := PO.Lines.QtySold;
                PO.Lines.UOMQtyShipped := PO.Lines.UOMQtySold;
                PO.Lines.ReceivedDate := Now;
                PO.Lines.PostDB;
            end else begin
                if msg <> '' then msg := msg+chr(13);
                msg := msg + 'PO#' + IntToStr(POID) + ':' +fieldByname('PurchaseLineID').AsString;
            end;
            stepProgressbar;
            next;
          end;
          if not PO.ValidateData then
            SendEvent(BusobjEvent_Event, BusobjEventVal_FailedPOValidateData, PO);

          if not PO.Save then begin
              self.Connection.RollbackNestedTransaction;
              inTrans := false;
              msg := PO.ResultStatus.GetLastFatalStatusItem.Message;
              Exit;
          end;
        finally
            FreeandNil(PO);
        end;
        if Eof = False then
          POID := fieldByname('PurchaseOrderID').asInteger;
      end;
    finally
      if inTrans then
        self.Connection.CommitNestedTransaction;
      HideProgressbar
    end;
    Result := true;
    self.Dirty:= true;
  finally
      if Active then close;
      Free;
  end;
end;

function TShippingContainer.HasPOToreceive: Boolean;
begin
   POToReceivefound := False;
   ContainerDetails.IterateRecords(SearchPOToReceive);
   result := POToReceivefound;
end;

procedure TShippingContainer.SearchPOToReceive(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not (Sender is TShipContainerDetails) then exit;
  if  TShipContainerDetails(Sender).Receivedqty = 0 then begin
      POToReceivefound := True;
      Abort := True;
  end;
end;


initialization
  RegisterClass(TShippingContainer);
end.
