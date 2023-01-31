unit BusobjSalesShippingDetails;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  19/04/10  1.00.00  BJ  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TSalesShippingDetails = class(TMSBusObj)
  private
    function GetSalesId                   : Integer   ;
    function GetFlightNo                  : string    ;
    function GetETD                       : TDateTime ;
    function GetETA                       : TDateTime ;
    function GetDescription               : string    ;
    function GetWeightUOMID               : Integer   ;
    function GetWeightUOM                 : string    ;
    function GetWeightUOMMultiplier       : Double    ;
    function GetNetWeight                 : Double    ;
    function GetGrossWeight               : Double    ;
    function GetSizeUOM                   : string    ;
    function GetSizeUOMID                 : Integer   ;
    function GetSizeUOMMultiplier         : Double    ;
    function GetTotalCubicsize            : Double    ;
    function GetAdditionalOrderCost       : Double    ;
    procedure SetSalesId                   (const Value: Integer   );
    procedure SetFlightNo                  (const Value: string    );
    procedure SetETD                       (const Value: TDateTime );
    procedure SetETA                       (const Value: TDateTime );
    procedure SetDescription               (const Value: string    );
    procedure SetWeightUOMID               (const Value: Integer   );
    procedure SetWeightUOM                 (const Value: string    );
    procedure SetWeightUOMMultiplier       (const Value: Double    );
    procedure SetNetWeight                 (const Value: Double    );
    procedure SetGrossWeight               (const Value: Double    );
    procedure SetSizeUOM                   (const Value: string    );
    procedure SetSizeUOMID                 (const Value: Integer   );
    procedure SetSizeUOMMultiplier         (const Value: Double    );
    procedure SetTotalCubicsize            (const Value: Double    );
    procedure SetAdditionalOrderCost       (const Value: Double    );
    function GetExFactoryDate: TDateTime;
    procedure SetExFactoryDate(const Value: TDateTime);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Procedure CreateInstance;Override;
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
    property SalesId                    :Integer     read GetSalesId                  write SetSalesId               ;
    property FlightNo                   :string      read GetFlightNo                 write SetFlightNo              ;
    property ETD                        :TDateTime   read GetETD                      write SetETD                   ;
    property ETA                        :TDateTime   read GetETA                      write SetETA                   ;
    property ExFactoryDate: TDateTime read GetExFactoryDate write SetExFactoryDate;
    property Description                :string      read GetDescription              write SetDescription           ;
    property WeightUOMID                :Integer     read GetWeightUOMID              write SetWeightUOMID           ;
    property WeightUOM                  :string      read GetWeightUOM                write SetWeightUOM             ;
    property WeightUOMMultiplier        :Double      read GetWeightUOMMultiplier      write SetWeightUOMMultiplier   ;
    property NetWeight                  :Double      read GetNetWeight                write SetNetWeight             ;
    property GrossWeight                :Double      read GetGrossWeight              write SetGrossWeight           ;
    property SizeUOM                    :string      read GetSizeUOM                  write SetSizeUOM               ;
    property SizeUOMID                  :Integer     read GetSizeUOMID                write SetSizeUOMID             ;
    property SizeUOMMultiplier          :Double      read GetSizeUOMMultiplier        write SetSizeUOMMultiplier     ;
    property TotalCubicsize             :Double      read GetTotalCubicsize           write SetTotalCubicsize        ;
    property AdditionalOrderCost        :Double      read GetAdditionalOrderCost      write SetAdditionalOrderCost   ;
  end;


implementation


uses Sysutils,tcDataUtils, CommonLib, BusObjSales;



  {TSalesShippingDetails}

constructor TSalesShippingDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesShippingDetails';
  fSQL := 'SELECT * FROM tblsalesshippingdetails';
end;


destructor TSalesShippingDetails.Destroy;
begin
  inherited;
end;


procedure TSalesShippingDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SalesId');
  SetPropertyFromNode(node,'FlightNo');
  SetDateTimePropertyFromNode(node,'ETD');
  SetDateTimePropertyFromNode(node,'ETA');
  SetDateTimePropertyFromNode(node,'ExFactoryDAte');
  SetPropertyFromNode(node,'Description');
  SetPropertyFromNode(node,'WeightUOMID');
  SetPropertyFromNode(node,'WeightUOM');
  SetPropertyFromNode(node,'WeightUOMMultiplier');
  SetPropertyFromNode(node,'NetWeight');
  SetPropertyFromNode(node,'GrossWeight');
  SetPropertyFromNode(node,'SizeUOM');
  SetPropertyFromNode(node,'SizeUOMID');
  SetPropertyFromNode(node,'SizeUOMMultiplier');
  SetPropertyFromNode(node,'TotalCubicsize');
  SetPropertyFromNode(node,'AdditionalOrderCost');
end;


procedure TSalesShippingDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SalesId' ,SalesId);
  AddXMLNode(node,'FlightNo' ,FlightNo);
  AddXMLNode(node,'ETD' ,ETD);
  AddXMLNode(node,'ETA' ,ETA);
  AddXMLNode(node,'ExFactoryDate' ,ExFactoryDate);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'WeightUOMID' ,WeightUOMID);
  AddXMLNode(node,'WeightUOM' ,WeightUOM);
  AddXMLNode(node,'WeightUOMMultiplier' ,WeightUOMMultiplier);
  AddXMLNode(node,'NetWeight' ,NetWeight);
  AddXMLNode(node,'GrossWeight' ,GrossWeight);
  AddXMLNode(node,'SizeUOM' ,SizeUOM);
  AddXMLNode(node,'SizeUOMID' ,SizeUOMID);
  AddXMLNode(node,'SizeUOMMultiplier' ,SizeUOMMultiplier);
  AddXMLNode(node,'TotalCubicsize' ,TotalCubicsize);
  AddXMLNode(node,'AdditionalOrderCost' ,AdditionalOrderCost);
end;


function TSalesShippingDetails.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SalesId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SalesId should not be 0' , False );
    Exit;
  end;
  if ETD = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ETD should not be blank' , False );
    Exit;
  end;
  if ETA = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ETA should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TSalesShippingDetails.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesShippingDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesShippingDetails.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
    inherited;
    if (Sysutils.SameText(Sender.fieldName ,  'WeightUOMID')) then begin
      WeightUOM := GetUOMName(WeightUOMID);
      WeightUOMMultiplier := getUnitMultiplier(WeightUOMID);
    end else if (Sysutils.SameText(Sender.fieldName ,  'SizeUOMID')) then begin
      SizeUOM := GetUOMName(SizeUOMID);
      SizeUOMMultiplier := getUnitMultiplier(SizeUOMID);
    end;
end;


function TSalesShippingDetails.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesShippingDetails.GetIDField: string;
begin
  Result := 'SalesShippingDetailsID'
end;


class function TSalesShippingDetails.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesshippingdetails';
end;


function TSalesShippingDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TSalesShippingDetails.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
end;

{Property Functions}
function  TSalesShippingDetails.GetSalesId               : Integer   ; begin Result := GetIntegerField('SalesId');end;
function  TSalesShippingDetails.GetFlightNo              : string    ; begin Result := GetStringField('FlightNo');end;
function  TSalesShippingDetails.GetETD                   : TDateTime ; begin Result := GetDateTimeField('ETD');end;
function  TSalesShippingDetails.GetETA                   : TDateTime ; begin Result := GetDateTimeField('ETA');end;
function  TSalesShippingDetails.GetDescription           : string    ; begin Result := GetStringField('Description');end;
function  TSalesShippingDetails.GetWeightUOMID           : Integer   ; begin Result := GetIntegerField('WeightUOMID');end;
function  TSalesShippingDetails.GetWeightUOM             : string    ; begin Result := GetStringField('WeightUOM');end;
function  TSalesShippingDetails.GetWeightUOMMultiplier   : Double    ; begin Result := GetFloatField('WeightUOMMultiplier');end;
function  TSalesShippingDetails.GetNetWeight             : Double    ; begin Result := GetFloatField('NetWeight');end;
function  TSalesShippingDetails.GetGrossWeight           : Double    ; begin Result := GetFloatField('GrossWeight');end;
function  TSalesShippingDetails.GetSizeUOM               : string    ; begin Result := GetStringField('SizeUOM');end;
function  TSalesShippingDetails.GetSizeUOMID             : Integer   ; begin Result := GetIntegerField('SizeUOMID');end;
function  TSalesShippingDetails.GetSizeUOMMultiplier     : Double    ; begin Result := GetFloatField('SizeUOMMultiplier');end;
function  TSalesShippingDetails.GetTotalCubicsize        : Double    ; begin Result := GetFloatField('TotalCubicsize');end;
function  TSalesShippingDetails.GetAdditionalOrderCost   : Double    ; begin Result := GetFloatField('AdditionalOrderCost');end;
procedure TSalesShippingDetails.SetSalesId               (const Value: Integer   ); begin SetIntegerField('SalesId'               , Value);end;
procedure TSalesShippingDetails.SetFlightNo              (const Value: string    ); begin SetStringField('FlightNo'               , Value);end;
procedure TSalesShippingDetails.SetETD                   (const Value: TDateTime ); begin SetDateTimeField('ETD'                  , Value);end;
procedure TSalesShippingDetails.SetETA                   (const Value: TDateTime ); begin SetDateTimeField('ETA'                  , Value);end;
procedure TSalesShippingDetails.SetDescription           (const Value: string    ); begin SetStringField('Description'            , Value);end;
procedure TSalesShippingDetails.SetWeightUOMID           (const Value: Integer   ); begin SetIntegerField('WeightUOMID'           , Value);end;
procedure TSalesShippingDetails.SetWeightUOM             (const Value: string    ); begin SetStringField('WeightUOM'              , Value);end;
procedure TSalesShippingDetails.SetWeightUOMMultiplier   (const Value: Double    ); begin SetFloatField('WeightUOMMultiplier'     , Value);end;
procedure TSalesShippingDetails.SetNetWeight             (const Value: Double    ); begin SetFloatField('NetWeight'               , Value);end;
procedure TSalesShippingDetails.SetGrossWeight           (const Value: Double    ); begin SetFloatField('GrossWeight'             , Value);end;
procedure TSalesShippingDetails.SetSizeUOM               (const Value: string    ); begin SetStringField('SizeUOM'                , Value);end;
procedure TSalesShippingDetails.SetSizeUOMID             (const Value: Integer   ); begin SetIntegerField('SizeUOMID'             , Value);end;
procedure TSalesShippingDetails.SetSizeUOMMultiplier     (const Value: Double    ); begin SetFloatField('SizeUOMMultiplier'       , Value);end;
procedure TSalesShippingDetails.SetTotalCubicsize        (const Value: Double    ); begin SetFloatField('TotalCubicsize'          , Value);end;
procedure TSalesShippingDetails.SetAdditionalOrderCost   (const Value: Double    ); begin SetFloatField('AdditionalOrderCost'     , Value);end;
function TSalesShippingDetails.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Self.Owner) then
    if self.Owner is Tsales then begin
      SalesId := TSales(Self.Owner).Id;
    end;
end;

procedure TSalesShippingDetails.CreateInstance;
begin
  inherited;
    if Owner is TSales then
        if Assigned(TSales(Owner).ObjInstanceToClone) then
          if TSales(Owner).ObjInstanceToClone is TSales then
            ObjInstanceToClone :=TSales(TSales(Owner).ObjInstanceToClone).SalesShippingDetails;
end;

function TSalesShippingDetails.GetExFactoryDate: TDateTime;
begin
  result:= GetDateTimeField('ExFactoryDate');
end;

procedure TSalesShippingDetails.SetExFactoryDate(const Value: TDateTime);
begin
  SetDateTimeField('ExFactoryDate',Value);
end;

initialization
  RegisterClass(TSalesShippingDetails);


end.
