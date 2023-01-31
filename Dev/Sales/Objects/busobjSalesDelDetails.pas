unit busobjSalesDelDetails;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  30/12/11  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLIntf;


type
  TSalesDeliveryDetails = class(TMSBusObj)
  private
    function GetSaleID                : Integer   ;
    function GetSalesglobalref        : String;
    function GetPlannedDelfromDt      : TDateTime ;
    function GetPlannedDelfromTime    : string    ;
    function GetPlannedDelToDt        : TDateTime ;
    function GetPlannedDeltotime      : string    ;
    function GetPlannedDelFrom        : TDateTime ;
    function GetPlannedDelto          : TDateTime ;
    function GetPromisedDelDt         : TDateTime ;
    function GetPromisedDel         : TDateTime ;
    function GetPromisedDeltime       : string    ;
    function GetCauseofDelayID        : Integer   ;
    function GetCauseofDelay          : string    ;
    function GetActualDelDt           : TDateTime ;
    function GetActualDeltime         : string    ;
    function GetActualDel             : TDateTime ;
    function GetFeedBack              : string    ;
    procedure SetSaleID                (const Value: Integer   );
    procedure SetSalesglobalref        (const Value: String );
    procedure SetPlannedDelfromDt      (const Value: TDateTime );
    procedure SetPlannedDelfromTime    (const Value: string    );
    procedure SetPlannedDelToDt        (const Value: TDateTime );
    procedure SetPlannedDeltotime      (const Value: string    );
    procedure SetPlannedDelFrom        (const Value: TDateTime );
    procedure SetPlannedDelto          (const Value: TDateTime );
    procedure SetPromisedDelDt         (const Value: TDateTime );
    procedure SetPromisedDel         (const Value: TDateTime );
    procedure SetPromisedDeltime       (const Value: string    );
    procedure SetCauseofDelayID        (const Value: Integer   );
    procedure SetCauseofDelay          (const Value: string    );
    procedure SetActualDelDt           (const Value: TDateTime );
    procedure SetActualDeltime         (const Value: string    );
    procedure SetActualDel             (const Value: TDateTime );
    procedure SetFeedBack              (const Value: string    );
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
    property SaleID                 :Integer     read GetSaleID               write SetSaleID            ;
    property Salesglobalref         :String    read GetSalesglobalref       write SetSalesglobalref    ;
    property PlannedDelfromDt       :TDateTime   read GetPlannedDelfromDt     write SetPlannedDelfromDt  ;
    property PlannedDelfromTime     :string      read GetPlannedDelfromTime   write SetPlannedDelfromTime;
    property PlannedDelToDt         :TDateTime   read GetPlannedDelToDt       write SetPlannedDelToDt    ;
    property PlannedDeltotime       :string      read GetPlannedDeltotime     write SetPlannedDeltotime  ;
    property PlannedDelFrom         :TDateTime   read GetPlannedDelFrom       write SetPlannedDelFrom    ;
    property PlannedDelto           :TDateTime   read GetPlannedDelto         write SetPlannedDelto      ;
    property PromisedDelDt          :TDateTime   read GetPromisedDelDt        write SetPromisedDelDt     ;
    property PromisedDel          :TDateTime   read GetPromisedDel        write SetPromisedDel     ;
    property PromisedDeltime        :string      read GetPromisedDeltime      write SetPromisedDeltime   ;
    property CauseofDelayID         :Integer     read GetCauseofDelayID       write SetCauseofDelayID    ;
    property CauseofDelay           :string      read GetCauseofDelay         write SetCauseofDelay      ;
    property ActualDelDt            :TDateTime   read GetActualDelDt          write SetActualDelDt       ;
    property ActualDeltime          :string      read GetActualDeltime        write SetActualDeltime     ;
    property ActualDel              :TDateTime   read GetActualDel            write SetActualDel         ;
    property FeedBack               :string      read GetFeedBack             write SetFeedBack          ;
  end;


implementation


uses tcDataUtils, CommonLib, BusObjSales, sysutils, timelib, dateutils, MySQLConst,
  AppEnvironment;



  {TSalesDeliveryDetails}

constructor TSalesDeliveryDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesDeliveryDetails';
  fSQL := 'SELECT * FROM tblsalesdeliverydetails';
end;


destructor TSalesDeliveryDetails.Destroy;
begin
  inherited;
end;


procedure TSalesDeliveryDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SaleID');
  SetPropertyFromNode(node,'Salesglobalref');
  SetDateTimePropertyFromNode(node,'PlannedDelfromDt');
  SetPropertyFromNode(node,'PlannedDelfromTime');
  SetDateTimePropertyFromNode(node,'PlannedDelToDt');
  SetPropertyFromNode(node,'PlannedDeltotime');
  SetDateTimePropertyFromNode(node,'PlannedDelFrom');
  SetDateTimePropertyFromNode(node,'PlannedDelto');
  SetDateTimePropertyFromNode(node,'PromisedDelDt');
  SetDateTimePropertyFromNode(node,'PromisedDel');
  SetPropertyFromNode(node,'PromisedDeltime');
  SetPropertyFromNode(node,'CauseofDelayID');
  SetPropertyFromNode(node,'CauseofDelay');
  SetDateTimePropertyFromNode(node,'ActualDelDt');
  SetPropertyFromNode(node,'ActualDeltime');
  SetDateTimePropertyFromNode(node,'ActualDel');
  SetPropertyFromNode(node,'FeedBack');
end;


procedure TSalesDeliveryDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'Salesglobalref' ,Salesglobalref);
  AddXMLNode(node,'PlannedDelfromDt' ,PlannedDelfromDt);
  AddXMLNode(node,'PlannedDelfromTime' ,PlannedDelfromTime);
  AddXMLNode(node,'PlannedDelToDt' ,PlannedDelToDt);
  AddXMLNode(node,'PlannedDeltotime' ,PlannedDeltotime);
  AddXMLNode(node,'PlannedDelFrom' ,PlannedDelFrom);
  AddXMLNode(node,'PlannedDelto' ,PlannedDelto);
  AddXMLNode(node,'PromisedDelDt' ,PromisedDelDt);
  AddXMLNode(node,'PromisedDel' ,PromisedDel);
  AddXMLNode(node,'PromisedDeltime' ,PromisedDeltime);
  AddXMLNode(node,'CauseofDelayID' ,CauseofDelayID);
  AddXMLNode(node,'CauseofDelay' ,CauseofDelay);
  AddXMLNode(node,'ActualDelDt' ,ActualDelDt);
  AddXMLNode(node,'ActualDeltime' ,ActualDeltime);
  AddXMLNode(node,'ActualDel' ,ActualDel);
  AddXMLNode(node,'FeedBack' ,FeedBack);
end;


function TSalesDeliveryDetails.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SaleID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SaleID should not be 0' , False );
    Exit;
  end;
  if Salesglobalref = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'Salesglobalref should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TSalesDeliveryDetails.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesDeliveryDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesDeliveryDetails.DoFieldOnChange(Sender: TField);

begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = False then Exit;
  inherited;


  if Sametext(Sender.fieldname ,'PlannedDelfromDt')   then if  PlannedDelfromTime = '' then  PlannedDelfromTime := FormatDateTime(MysqlTimeFormat12hr, appenv.companyPrefs.StartOfDay);
  if Sametext(Sender.fieldname ,'PlannedDelToDt')     then if  PlannedDeltotime   = '' then  PlannedDeltotime   := FormatDateTime(MysqlTimeFormat12hr, appenv.companyPrefs.StartOfDay);
  if Sametext(Sender.fieldname ,'PromisedDelDt')      then if  PromisedDeltime    = '' then  PromisedDeltime    := FormatDateTime(MysqlTimeFormat12hr, appenv.companyPrefs.StartOfDay);
  if Sametext(Sender.fieldname ,'ActualDelDt')        then if  ActualDeltime      = '' then  ActualDeltime      := FormatDateTime(MysqlTimeFormat12hr, appenv.companyPrefs.StartOfDay);

  if Sametext(Sender.fieldname ,'PlannedDelfromDt')        or Sametext(Sender.fieldname ,'PlannedDelfromTime') then begin
      PlannedDelFrom  := DateOf(PlannedDelfromDt) +ValidStrToTime(PlannedDelfromTime);
      if (PlannedDelto =0) or (PlannedDelto<PlannedDelFrom) then begin
        PlannedDelto := incHour(PlannedDelFrom  , 2);
        PlannedDelToDt := DateOf(PlannedDelto);
        PlannedDeltotime := FormatDateTime(MysqlTimeFormat12hr, timeof(PlannedDelto));
      end;
      PostDB;
  end else if Sametext(Sender.fieldname ,'PlannedDelToDt') or Sametext(Sender.fieldname ,'PlannedDeltotime') then begin
      PlannedDelto    := DateOf(PlannedDelToDt) +ValidStrToTime(PlannedDeltotime);
      if (PlannedDelFrom =0) or (PlannedDelto<PlannedDelFrom) then begin
        PlannedDelfrom := incHour(PlannedDelTo  , -2);
        PlannedDelFromDt := DateOf(PlannedDelFrom);
        PlannedDelFromtime := FormatDateTime(MysqlTimeFormat12hr, timeof(PlannedDelFrom));
      end;
      PostDB;
  end else if Sametext(Sender.fieldname ,'PromisedDelDt')  or Sametext(Sender.fieldname ,'PromisedDeltime') then begin
      PromisedDel     := DateOf(PromisedDelDt) +ValidStrToTime(PromisedDeltime);
      PostDB;
  end else if Sametext(Sender.fieldname ,'ActualDelDt')    or Sametext(Sender.fieldname ,'ActualDeltime') then begin
      ActualDel       := DateOf(ActualDelDt) +ValidStrToTime(ActualDeltime);
      PostDB;
  end;
end;
function TSalesDeliveryDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesDeliveryDetails.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSalesDeliveryDetails.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesdeliverydetails';
end;


function TSalesDeliveryDetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is Tsales then begin
        SaleID := TSales(Owner).Id;
        SalesGlobalref :=TSales(Owner).GlobalRef;
    end;
end;

function TSalesDeliveryDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSalesDeliveryDetails.GetSaleID            : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  TSalesDeliveryDetails.GetSalesglobalref    : String    ; begin Result := GetStringField('Salesglobalref');end;
function  TSalesDeliveryDetails.GetPlannedDelfromDt  : TDateTime ; begin Result := GetDateTimeField('PlannedDelfromDt');end;
function  TSalesDeliveryDetails.GetPlannedDelfromTime: string    ; begin Result := GetStringField('PlannedDelfromTime');end;
function  TSalesDeliveryDetails.GetPlannedDelToDt    : TDateTime ; begin Result := GetDateTimeField('PlannedDelToDt');end;
function  TSalesDeliveryDetails.GetPlannedDeltotime  : string    ; begin Result := GetStringField('PlannedDeltotime');end;
function  TSalesDeliveryDetails.GetPlannedDelFrom    : TDateTime ; begin Result := GetDateTimeField('PlannedDelFrom');end;
function  TSalesDeliveryDetails.GetPlannedDelto      : TDateTime ; begin Result := GetDateTimeField('PlannedDelto');end;
function  TSalesDeliveryDetails.GetPromisedDelDt     : TDateTime ; begin Result := GetDateTimeField('PromisedDelDt');end;
function  TSalesDeliveryDetails.GetPromisedDel     : TDateTime ; begin Result := GetDateTimeField('PromisedDel');end;
function  TSalesDeliveryDetails.GetPromisedDeltime   : string    ; begin Result := GetStringField('PromisedDeltime');end;
function  TSalesDeliveryDetails.GetCauseofDelayID    : Integer   ; begin Result := GetIntegerField('CauseofDelayID');end;
function  TSalesDeliveryDetails.GetCauseofDelay      : string    ; begin Result := GetStringField('CauseofDelay');end;
function  TSalesDeliveryDetails.GetActualDelDt       : TDateTime ; begin Result := GetDateTimeField('ActualDelDt');end;
function  TSalesDeliveryDetails.GetActualDeltime     : string    ; begin Result := GetStringField('ActualDeltime');end;
function  TSalesDeliveryDetails.GetActualDel         : TDateTime ; begin Result := GetDateTimeField('ActualDel');end;
function  TSalesDeliveryDetails.GetFeedBack          : string    ; begin Result := GetStringField('FeedBack');end;
procedure TSalesDeliveryDetails.SetSaleID            (const Value: Integer   ); begin SetIntegerField('SaleID'             , Value);end;
procedure TSalesDeliveryDetails.SetSalesglobalref    (const Value: String    ); begin SetStringField('Salesglobalref'     , Value);end;
procedure TSalesDeliveryDetails.SetPlannedDelfromDt  (const Value: TDateTime ); begin SetDateTimeField('PlannedDelfromDt'   , Value);end;
procedure TSalesDeliveryDetails.SetPlannedDelfromTime(const Value: string    ); begin SetStringField('PlannedDelfromTime' , Value);end;
procedure TSalesDeliveryDetails.SetPlannedDelToDt    (const Value: TDateTime ); begin SetDateTimeField('PlannedDelToDt'     , Value);end;
procedure TSalesDeliveryDetails.SetPlannedDeltotime  (const Value: string    ); begin SetStringField('PlannedDeltotime'   , Value);end;
procedure TSalesDeliveryDetails.SetPlannedDelFrom    (const Value: TDateTime ); begin SetDateTimeField('PlannedDelFrom'     , Value);end;
procedure TSalesDeliveryDetails.SetPlannedDelto      (const Value: TDateTime ); begin SetDateTimeField('PlannedDelto'       , Value);end;
procedure TSalesDeliveryDetails.SetPromisedDelDt     (const Value: TDateTime ); begin SetDateTimeField('PromisedDelDt'      , Value);end;
procedure TSalesDeliveryDetails.SetPromisedDel     (const Value: TDateTime ); begin SetDateTimeField('PromisedDel'      , Value);end;
procedure TSalesDeliveryDetails.SetPromisedDeltime   (const Value: string    ); begin SetStringField('PromisedDeltime'    , Value);end;
procedure TSalesDeliveryDetails.SetCauseofDelayID    (const Value: Integer   ); begin SetIntegerField('CauseofDelayID'     , Value);end;
procedure TSalesDeliveryDetails.SetCauseofDelay      (const Value: string    ); begin SetStringField('CauseofDelay'       , Value);end;
procedure TSalesDeliveryDetails.SetActualDelDt       (const Value: TDateTime ); begin SetDateTimeField('ActualDelDt'        , Value);end;
procedure TSalesDeliveryDetails.SetActualDeltime     (const Value: string    ); begin SetStringField('ActualDeltime'      , Value);end;
procedure TSalesDeliveryDetails.SetActualDel         (const Value: TDateTime ); begin SetDateTimeField('ActualDel'          , Value);end;
procedure TSalesDeliveryDetails.SetFeedBack          (const Value: string    ); begin SetStringField('FeedBack'           , Value);end;


initialization
  RegisterClass(TSalesDeliveryDetails);


end.
