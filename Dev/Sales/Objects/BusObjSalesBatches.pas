unit BusObjSalesBatches;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  20/11/17  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tsalesbatches = class(TMSBusObj)
  private
    function GetSaleLineId                : Integer   ;
    function GetRelatedParentLineRef      : string    ;
    function GetProductId                 : Integer   ;
    function GetManPQADetailsId           : Integer   ;
    function GetProductName               : string    ;
    function GetProductDescription        : string    ;
    function GetUom                       : string    ;
    function GetRelatedProductQty         : Double    ;
    function GetSalesRelatedProductQty    : Double    ;
    Function getDateCreated               : Tdatetime;
    function GetUOMID                     : Integer   ;
    function GetUOMMult                   : Double    ;
    function GetUOMWeight                 : Double    ;
    function GetTotalWeight               : Double    ;
    procedure SetSaleLineId                (const Value: Integer   );
    procedure SetRelatedParentLineRef      (const Value: string    );
    procedure SetProductId                 (const Value: Integer   );
    procedure SetManPQADetailsId           (const Value: Integer   );
    procedure SetProductName               (const Value: string    );
    procedure SetProductDescription        (const Value: string    );
    procedure SetUom                       (const Value: string    );
    procedure SetRelatedProductQty         (const Value: Double    );
    procedure SetSalesRelatedProductQty    (const Value: Double    );
    Procedure SetDateCreated               (const Value: TdateTime);
    procedure SetUOMID                     (const Value: Integer   );
    procedure SetUOMMult                   (const Value: Double    );
    procedure SetUOMWeight                 (const Value: Double    );
    procedure SetTotalWeight               (const Value: Double    );
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
    property SaleLineId                 :Integer     read GetSaleLineId               write SetSaleLineId            ;
    property RelatedParentLineRef       :string      read GetRelatedParentLineRef     write SetRelatedParentLineRef  ;
    property ProductId                  :Integer     read GetProductId                write SetProductId             ;
    property ManPQADetailsId            :Integer     read GetManPQADetailsId          write SetManPQADetailsId       ;
    property ProductName                :string      read GetProductName              write SetProductName           ;
    property ProductDescription         :string      read GetProductDescription       write SetProductDescription    ;
    property Uom                        :string      read GetUom                      write SetUom                   ;
    property RelatedProductQty          :Double      read GetRelatedProductQty        write SetRelatedProductQty     ;
    property SalesRelatedProductQty     :Double      read GetSalesRelatedProductQty   write SetSalesRelatedProductQty;
    Property DateCreated                :Tdatetime   read getDateCreated              write SetDateCreated           ;
    property UOMID                      :Integer     read GetUOMID                    write SetUOMID                 ;
    property UOMMult                    :Double      read GetUOMMult                  write SetUOMMult               ;
    property UOMWeight                  :Double      read GetUOMWeight                write SetUOMWeight             ;
    property TotalWeight                :Double      read GetTotalWeight              write SetTotalWeight           ;
  end;


implementation


uses tcDataUtils, CommonLib , SysUtils, BusObjConst;



  {Tsalesbatches}

constructor Tsalesbatches.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'salesbatches';
  fSQL := 'SELECT * FROM tblsalesbatches';

end;


destructor Tsalesbatches.Destroy;
begin
  inherited;
end;


procedure Tsalesbatches.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SaleLineId');
  SetPropertyFromNode(node,'RelatedParentLineRef');
  SetPropertyFromNode(node,'ProductId');
  SetPropertyFromNode(node,'ManPQADetailsId');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'ProductDescription');
  SetPropertyFromNode(node,'Uom');
  SetPropertyFromNode(node,'RelatedProductQty');
  SetPropertyFromNode(node,'SalesRelatedProductQty');
  SetDAtetimePropertyFromNode(node,'DateCreated');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOMMult');
  SetPropertyFromNode(node,'UOMWeight');
  SetPropertyFromNode(node,'TotalWeight');
end;


procedure Tsalesbatches.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SaleLineId'            ,SaleLineId);
  AddXMLNode(node,'RelatedParentLineRef'  ,RelatedParentLineRef);
  AddXMLNode(node,'ProductId'             ,ProductId);
  AddXMLNode(node,'ManPQADetailsId'       ,ManPQADetailsId);
  AddXMLNode(node,'ProductName'           ,ProductName);
  AddXMLNode(node,'ProductDescription'    ,ProductDescription);
  AddXMLNode(node,'Uom'                   ,Uom);
  AddXMLNode(node,'RelatedProductQty'     ,RelatedProductQty);
  AddXMLNode(node,'SalesRelatedProductQty',SalesRelatedProductQty);
  AddXMLNode(node,'DateCreated'           ,DateCreated);
  AddXMLNode(node,'UOMID'                 ,UOMID);
  AddXMLNode(node,'UOMMult'               ,UOMMult);
  AddXMLNode(node,'UOMWeight'             ,UOMWeight);
  AddXMLNode(node,'TotalWeight'           ,TotalWeight);
end;


function Tsalesbatches.ValidateData: Boolean ;
begin
//  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tsalesbatches.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tsalesbatches.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tsalesbatches.DoFieldOnChange(Sender: TField);
begin
  inherited;
{----}if Sysutils.SameText(Sender.FieldName, 'RelatedProductQty') then begin
        SendEvent(BusObjEvent_Change, BusObjEvent_QtyChanged+'_'+ Sender.FieldName, self);
      end;
end;


function Tsalesbatches.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tsalesbatches.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tsalesbatches.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesbatches';
end;


function Tsalesbatches.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(Result) then exit;
  DateCreated := now;
end;

function Tsalesbatches.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tsalesbatches.GetSaleLineId            : Integer   ; begin Result := GetIntegerField('SaleLineId');end;
function  Tsalesbatches.GetRelatedParentLineRef  : string    ; begin Result := GetStringField('RelatedParentLineRef');end;
function  Tsalesbatches.GetProductId             : Integer   ; begin Result := GetIntegerField('ProductId');end;
function  Tsalesbatches.GetManPQADetailsId       : Integer   ; begin Result := GetIntegerField('ManPQADetailsId');end;
function  Tsalesbatches.GetProductName           : string    ; begin Result := GetStringField('ProductName');end;
function  Tsalesbatches.GetProductDescription    : string    ; begin Result := GetStringField('ProductDescription');end;
function  Tsalesbatches.GetUom                   : string    ; begin Result := GetStringField('Uom');end;
function  Tsalesbatches.GetRelatedProductQty     : Double    ; begin Result := GetFloatField('RelatedProductQty');end;
function  Tsalesbatches.GetSalesRelatedProductQty: Double    ; begin Result := GetFloatField('SalesRelatedProductQty');end;
Function  Tsalesbatches.GetDateCreated           : TdateTime ; begin Result := GetdateTimefield('DateCreated');end;
function  Tsalesbatches.GetUOMID                 : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  Tsalesbatches.GetUOMMult               : Double    ; begin Result := GetFloatField('UOMMult');end;
function  Tsalesbatches.GetUOMWeight             : Double    ; begin Result := GetFloatField('UOMWeight');end;
function  Tsalesbatches.GetTotalWeight           : Double    ; begin Result := GetFloatField('TotalWeight');end;
procedure Tsalesbatches.SetSaleLineId            (const Value: Integer   ); begin SetIntegerField('SaleLineId'            , Value);end;
procedure Tsalesbatches.SetRelatedParentLineRef  (const Value: string    ); begin SetStringField('RelatedParentLineRef'   , Value);end;
procedure Tsalesbatches.SetProductId             (const Value: Integer   ); begin SetIntegerField('ProductId'             , Value);end;
procedure Tsalesbatches.SetManPQADetailsId       (const Value: Integer   ); begin SetIntegerField('ManPQADetailsId'       , Value);end;
procedure Tsalesbatches.SetProductName           (const Value: string    ); begin SetStringField('ProductName'            , Value);end;
procedure Tsalesbatches.SetProductDescription    (const Value: string    ); begin SetStringField('ProductDescription'     , Value);end;
procedure Tsalesbatches.SetUom                   (const Value: string    ); begin SetStringField('Uom'                    , Value);end;
procedure Tsalesbatches.SetRelatedProductQty     (const Value: Double    ); begin SetFloatField('RelatedProductQty'       , Value);end;
procedure Tsalesbatches.SetSalesRelatedProductQty(const Value: Double    ); begin SetFloatField('SalesRelatedProductQty'  , Value);end;
Procedure Tsalesbatches.SetDateCreated           (Const Value: TdateTime ); begin SetDAteTimefield('DateCreated'          , Value);end;
procedure Tsalesbatches.SetUOMID                 (const Value: Integer   ); begin SetIntegerField('UOMID'                 , Value);end;
procedure Tsalesbatches.SetUOMMult               (const Value: Double    ); begin SetFloatField('UOMMult'                 , Value);end;
procedure Tsalesbatches.SetUOMWeight             (const Value: Double    ); begin SetFloatField('UOMWeight'               , Value);end;
procedure Tsalesbatches.SetTotalWeight           (const Value: Double    ); begin SetFloatField('TotalWeight'             , Value);end;

initialization
  RegisterClass(Tsalesbatches);


end.
