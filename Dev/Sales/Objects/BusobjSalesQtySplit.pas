unit BusobjSalesQtySplit;

interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusobjUOM;


type

  TSalesAutoSplitQtyLines = class(TMSBusObj)
  private
    function GetHeaderID            : Integer   ;
    function GetUOMID               : Integer   ;
    function GetUOMMultiplier       : Double    ;
    function GetUOM                 : string    ;
    function GetQty                 : Double    ;
    procedure SetHeaderID            (const Value: Integer   );
    procedure SetUOMID               (const Value: Integer   );
    procedure SetUOMMultiplier       (const Value: Double    );
    procedure SetUOM                 (const Value: string    );
    procedure SetQty                 (const Value: Double    );
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
    property HeaderID             :Integer     read GetHeaderID           write SetHeaderID        ;
    property UOMID                :Integer     read GetUOMID              write SetUOMID           ;
    property UOMMultiplier        :Double      read GetUOMMultiplier      write SetUOMMultiplier   ;
    property UOM                  :string      read GetUOM                write SetUOM             ;
    property Qty                  :Double      read GetQty                write SetQty             ;
  end;

  TSalesLinesAutoSplitQty = class(TSalesAutoSplitQtyLines)
    Private
      function GetsaleLineRef          : String   ;
      procedure SetsaleLineRef          (const Value: String   );
    Protected
    Public
      procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
      procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Published
      property saleLineRef           :String     read GetsaleLineRef         write SetsaleLineRef        ;
  end;

  TSalesAutoSplitQty = class(TMSBusObj)
  private
    fdQuantity :Double;
    LastIDUpdated:Integer;
    fdQtyAllocated :Double;

    function GetSaleRef              : String   ;
    function GetsaleLineRef          : String   ;
    function GetProductID           : Integer   ;
    function GetProductname         : string    ;
    function GetUOMID               : Integer   ;
    function GetUOMMultiplier       : Double    ;
    function GetTotalAllocated       : Double    ;
    function GetTotalUnAllocated       : Double    ;
    function GetUOM                 : string    ;
    function GetQty                 : Double    ;
    procedure SetSaleRef              (const Value: String );
    procedure SetsaleLineRef          (const Value: String   );
    procedure SetProductID           (const Value: Integer   );
    procedure SetProductname         (const Value: string    );
    procedure SetUOMID               (const Value: Integer   );
    procedure SetUOMMultiplier       (const Value: Double    );
    procedure SetTotalAllocated       (const Value: Double    );
    procedure SetTotalUnAllocated       (const Value: Double    );
    procedure SetUOM                 (const Value: string    );
    procedure SetQty                 (const Value: Double    );
    function getLines: TSalesAutoSplitQtyLines;
    function getProductUOMs: TUnitOfMeasure;
    Procedure Calctotals;
    function getSLLines: TSalesLinesAutoSplitQty;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Procedure MakeLineRecordsCallback(const Sender: TBusObj; var Abort: Boolean);
    Procedure AllocateQtyCallback(const Sender: TBusObj; var Abort: Boolean);
    Procedure CalctotalsCallback(const Sender: TBusObj; var Abort: Boolean);
    Function  DoCalcFields(Sender :TDatasetBusObj):Boolean;override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    Procedure AutoSplitQty;
    Property ProductUOMs :TUnitOfMeasure read getProductUOMs;
    Property SLLines   :TSalesLinesAutoSplitQty read getSLLines;

  published
    property SaleRef               :String     read GetSaleRef             write SetSaleRef          ;
    property saleLineRef           :String     read GetsaleLineRef         write SetsaleLineRef          ;
    property ProductID            :Integer     read GetProductID          write SetProductID       ;
    property Productname          :string      read GetProductname        write SetProductname     ;
    property UOMID                :Integer     read GetUOMID              write SetUOMID           ;
    property UOMMultiplier        :Double      read GetUOMMultiplier      write SetUOMMultiplier   ;
    property TotalAllocated        :Double      read GetTotalAllocated      write SetTotalAllocated   ;
    property TotalUnAllocated        :Double      read GetTotalUnAllocated      write SetTotalUnAllocated   ;
    property UOM                  :string      read GetUOM                write SetUOM             ;
    property Qty                  :Double      read GetQty                write SetQty             ;
    Property Lines   :TSalesAutoSplitQtyLines read getLines;

  end;


implementation


uses tcDataUtils, CommonLib, DNMLib, sysutils;



  {TSalesAutoSplitQtyLines}

constructor TSalesAutoSplitQtyLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesAutoSplitQtyLines';
  fSQL := 'SELECT * FROM tblsalesautosplitqtylines';
  fSQLOrder := 'UOMMultiplier desc'
end;


destructor TSalesAutoSplitQtyLines.Destroy;
begin
  inherited;
end;


procedure TSalesAutoSplitQtyLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'HeaderID');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'Qty');
end;


procedure TSalesAutoSplitQtyLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'HeaderID' ,HeaderID);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'Qty' ,Qty);
end;


function TSalesAutoSplitQtyLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if HeaderID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'HeaderID should not be 0' , False );
    Exit;
  end;
  if UOMID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOM should not be blank' , False );
    Exit;
  end;
  if UOMMultiplier = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Multiplier should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TSalesAutoSplitQtyLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesAutoSplitQtyLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesAutoSplitQtyLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sametext(sender.FieldName , 'UOMID') then begin
    UOM := tcdatautils.GetUOMName(UOMID);
    UOMMultiplier := tcdatautils.getUnitMultiplier(UOMID);
  end;
end;


function TSalesAutoSplitQtyLines.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesAutoSplitQtyLines.GetIDField: string;
begin
  Result := 'ID'
end;


class function TSalesAutoSplitQtyLines.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesautosplitqtylines';
end;


function TSalesAutoSplitQtyLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Owner) then
    if owner is TSalesAutoSplitQty then
      headerId := TSalesAutoSplitQty(Owner).ID;

end;

function TSalesAutoSplitQtyLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
    if assigned(Owner) then
    if owner is TSalesAutoSplitQty then
      TSalesAutoSplitQty(Owner).Calctotals;

end;


{Property Functions}
function  TSalesAutoSplitQtyLines.GetHeaderID        : Integer   ; begin Result := GetIntegerField('HeaderID');end;
function  TSalesAutoSplitQtyLines.GetUOMID           : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TSalesAutoSplitQtyLines.GetUOMMultiplier   : Double    ; begin Result := GetFloatField('UOMMultiplier');end;
function  TSalesAutoSplitQtyLines.GetUOM             : string    ; begin Result := GetStringField('UOM');end;
function  TSalesAutoSplitQtyLines.GetQty             : Double    ; begin Result := GetFloatField('Qty');end;
procedure TSalesAutoSplitQtyLines.SetHeaderID        (const Value: Integer   ); begin SetIntegerField('HeaderID'         , Value);end;
procedure TSalesAutoSplitQtyLines.SetUOMID           (const Value: Integer   ); begin SetIntegerField('UOMID'            , Value);end;
procedure TSalesAutoSplitQtyLines.SetUOMMultiplier   (const Value: Double    ); begin SetFloatField('UOMMultiplier'    , Value);end;
procedure TSalesAutoSplitQtyLines.SetUOM             (const Value: string    ); begin SetStringField('UOM'              , Value);end;
procedure TSalesAutoSplitQtyLines.SetQty             (const Value: Double    ); begin SetFloatField('Qty'              , Value);end;


  {TSalesAutoSplitQty}

procedure TSalesAutoSplitQty.AllocateQtyCallback(const Sender: TBusObj; var Abort: Boolean);
var
  fdQty:Integer;
begin
  if not(Sender is TSalesAutoSplitQtyLines) then exit;

  if  fdQuantity = 0 then begin
    abort := true;
    exit;
  end;
  fdQuantity := fdQuantity + TSalesAutoSplitQtyLines(Sender).Qty * TSalesAutoSplitQtyLines(Sender).UOMMultiplier;
  if fdQuantity < TSalesAutoSplitQtyLines(Sender).UOMMultiplier then exit;
  fdQty:= trunc( divzer(fdQuantity ,TSalesAutoSplitQtyLines(Sender).UOMMultiplier));
  if fdQty >0 then begin
    TSalesAutoSplitQtyLines(Sender).Qty := fdQty;
    TSalesAutoSplitQtyLines(Sender).PostDB;
    LastIDUpdated :=  TSalesAutoSplitQtyLines(Sender).ID;
    fdQuantity := fdQuantity - fdQty*TSalesAutoSplitQtyLines(Sender).UOMMultiplier;
  end;
  if fdQuantity = 0 then abort := true;
end;

procedure TSalesAutoSplitQty.AutoSplitQty;
var
  flag:Boolean;
  Id1:Integer;
  fQty1,fQty2 ,fMult:double;
begin
  Lines.DeleteAll;
  ProductUOMs.IterateRecords(MakeLineRecordsCallback);
  fdQuantity :=Qty * UOMMultiplier;
  lines.closedb;
  lines.Opendb;
  lines.IterateRecords(AllocateQtyCallback);
  if fdQuantity <> 0 then begin
    (*if lines.Locate(lines.IDFieldName , LastIDUpdated , []) then begin
      lines.Qty := lines.Qty + trunc(fdQuantity/ Lines.UOMMultiplier )+1;
      lines.PostDB;
    end;*)
    Lines.Last;
    While Lines.BOF = False do begin
      if Lines.UOMMultiplier >fdQuantity then begin
          lines.Qty := lines.Qty + trunc(fdQuantity/ Lines.UOMMultiplier )+1;
          lines.PostDB;
          break;
      end;
      Lines.Prior;
    end;
  end;

  flag:=True;
  while flag do begin
    Id1:=0;    fQty1:=0; fMult :=0;
    Lines.Last;
    Flag := False;
    While Lines.BOF = False do begin
      if (Lines.Qty <> 0) and (id1=0) then begin
          id1 := Lines.ID;
          fQty1 :=Lines.Qty;
          fMult :=Lines.UOMMultiplier;
      end else if fQty1 <>0 then begin
          if Lines.UOMMultiplier <= fQty1 * fMult then begin
            fQty2:= trunc(fQty1 * fMult/Lines.UOMMultiplier);
            fQty1 := divzer(fQty1 * fMult - fQty2*Lines.UOMMultiplier , fmult);
            Lines.Qty := Lines.Qty+fQty2;
            Lines.PostDb;
            //if fQty1 <> 0 then begin
              Lines.Locate(Lines.IDFieldName , id1, []);
              if fQty1 <> trunc(fQty1)  then fQty1 := trunc(fQty1) +1;
              Lines.Qty := fQty1;
              Lines.PostDb;
              Flag:= True;
              Break;
            //end;
          end;
      end;
      Lines.Prior;
    end;
  end;
end;

procedure TSalesAutoSplitQty.Calctotals;
begin
  fdQtyAllocated:= 0;
  Lines.IterateRecords(CalctotalsCallback );
  TotalAllocated := round(divzer(fdQtyAllocated, UOMMultiplier), RoundPlacesGeneral);
  TotalUnAllocated := round(divzer((Qty * UOMMultiplier) - fdQtyAllocated, UOMMultiplier), RoundPlacesGeneral);
  PostDB;
end;

procedure TSalesAutoSplitQty.CalctotalsCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not (Sender is TSalesAutoSplitQtyLines) then exit;
  fdQtyAllocated := fdQtyAllocated +TSalesAutoSplitQtyLines(Sender).qty* TSalesAutoSplitQtyLines(Sender).UOMMultiplier;
end;

constructor TSalesAutoSplitQty.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesAutoSplitQty';
  fSQL := 'SELECT * FROM tblsalesautosplitqty';
  LastIDUpdated:= 0;
end;


destructor TSalesAutoSplitQty.Destroy;
begin
  inherited;
end;


procedure TSalesAutoSplitQty.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SaleRef');
  SetPropertyFromNode(node,'saleLineRef');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'Productname');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetPropertyFromNode(node,'TotalAllocated');
  SetPropertyFromNode(node,'TotalUnAllocated');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'Qty');
end;


procedure TSalesAutoSplitQty.MakeLineRecordsCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TUnitOfMeasure) then exit;
  if TUnitOfMeasure(Sender).UseforAutoSplitQtyinSales =False then exit;
  if not lines.Locate('UOMID' , TUnitOfMeasure(Sender).ID , []) then begin
    Lines.New;
    Lines.UOMID := TUnitOfMeasure(Sender).ID;
    Lines.Qty :=0;
    Lines.PostDB;
  end;
end;

procedure TSalesAutoSplitQty.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SaleRef' ,SaleRef);
  AddXMLNode(node,'saleLineRef' ,saleLineRef);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'Productname' ,Productname);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'TotalAllocated' ,TotalAllocated);
  AddXMLNode(node,'TotalUnAllocated' ,TotalUnAllocated);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'Qty' ,Qty);
end;


function TSalesAutoSplitQty.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SaleRef = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'SaleRef should not be blank' , False );
    Exit;
  end;
  if saleLineRef = '' then begin
    Resultstatus.AddItem(False , rssError , 0,  'saleLineRef should not be blank' , False );
    Exit;
  end;
  if (ProductID = 0) or (Productname = '') then begin
    Resultstatus.AddItem(False , rssError , 0,  'Product should not be blank' , False );
    Exit;
  end;
  if (UOMID = 0) or (UOM = '') or (UOMMultiplier =0) then begin
    Resultstatus.AddItem(False , rssError , 0,  'UOM should not be blank' , False );
    Exit;
  end;
  if Qty = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Qty should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TSalesAutoSplitQty.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesAutoSplitQty.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesAutoSplitQty.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if sametext(sender.FieldName , 'UOMID') then begin
    UOM := tcdatautils.GetUOMName(UOMID);
    UOMMultiplier := tcdatautils.getUnitMultiplier(UOMID);
  end;
end;


function TSalesAutoSplitQty.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesAutoSplitQty.GetIDField: string;
begin
  Result := 'ID'
end;


function TSalesAutoSplitQty.getLines: TSalesAutoSplitQtyLines;
begin
  Result := TSalesAutoSplitQtyLines(getcontainercomponent(TSalesAutoSplitQtyLines , 'HeaderID = ' +  IntToStr(Id)));
end;

class function TSalesAutoSplitQty.GetBusObjectTablename: string;
begin
  Result:= 'tblsalesautosplitqty';
end;


function TSalesAutoSplitQty.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TSalesAutoSplitQty.DoCalcFields(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoCalcFields(Sender);
  if not result then exit;
  TotalAllocated    := divzer(fdQtyAllocated, UOMMultiplier);
  TotalUnAllocated  := divzer((Qty * UOMMultiplier) - fdQtyAllocated, UOMMultiplier);
end;

{Property Functions}
function  TSalesAutoSplitQty.GetSaleRef          : String   ; begin Result := GetStringField('SaleRef');end;
function TSalesAutoSplitQty.getSLLines: TSalesLinesAutoSplitQty;
begin
  Result := TSalesLinesAutoSplitQty(getcontainercomponent(TSalesLinesAutoSplitQty , 'HeaderID = ' +  IntToStr(Id)));
end;

function  TSalesAutoSplitQty.GetsaleLineRef      : String   ; begin Result := GetStringField('saleLineRef');end;
function  TSalesAutoSplitQty.GetProductID       : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TSalesAutoSplitQty.GetProductname     : string    ; begin Result := GetStringField('Productname');end;
function TSalesAutoSplitQty.getProductUOMs: TUnitOfMeasure;
begin
  Result := TUnitOfMeasure(getcontainercomponent(TUnitOfMeasure , 'partId = ' +  IntToStr(ProductId)));
end;

function  TSalesAutoSplitQty.GetUOMID           : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TSalesAutoSplitQty.GetUOMMultiplier   : Double    ; begin Result := GetFloatField('UOMMultiplier');end;
function  TSalesAutoSplitQty.GetTotalAllocated   : Double    ; begin Result := GetFloatField('TotalAllocated');end;
function  TSalesAutoSplitQty.GetTotalUnAllocated   : Double    ; begin Result := GetFloatField('TotalUnAllocated');end;
function  TSalesAutoSplitQty.GetUOM             : string    ; begin Result := GetStringField('UOM');end;
function  TSalesAutoSplitQty.GetQty             : Double    ; begin Result := GetFloatField('Qty');end;
procedure TSalesAutoSplitQty.SetSaleRef          (const Value: String   ); begin SetStringField('SaleRef'           , Value);end;
procedure TSalesAutoSplitQty.SetsaleLineRef      (const Value: String   ); begin SetStringField('saleLineRef'       , Value);end;
procedure TSalesAutoSplitQty.SetProductID       (const Value: Integer   ); begin SetIntegerField('ProductID'        , Value);end;
procedure TSalesAutoSplitQty.SetProductname     (const Value: string    ); begin SetStringField('Productname'      , Value);end;
procedure TSalesAutoSplitQty.SetUOMID           (const Value: Integer   ); begin SetIntegerField('UOMID'            , Value);end;
procedure TSalesAutoSplitQty.SetUOMMultiplier   (const Value: Double    ); begin SetFloatField('UOMMultiplier'    , Value);end;
procedure TSalesAutoSplitQty.SetTotalAllocated   (const Value: Double    ); begin SetFloatField('TotalAllocated'    , Value);end;
procedure TSalesAutoSplitQty.SetTotalUnAllocated   (const Value: Double    ); begin SetFloatField('TotalUnAllocated'    , Value);end;
procedure TSalesAutoSplitQty.SetUOM             (const Value: string    ); begin SetStringField('UOM'              , Value);end;
procedure TSalesAutoSplitQty.SetQty             (const Value: Double    ); begin SetFloatField('Qty'              , Value);end;


{ TSalesLinesAutoSplitQty }

function  TSalesLinesAutoSplitQty.GetsaleLineRef      : String   ; begin Result := GetStringField('saleLineRef');end;
procedure TSalesLinesAutoSplitQty.SetsaleLineRef      (const Value: String   ); begin SetStringField('saleLineRef'         , Value);end;
procedure TSalesLinesAutoSplitQty.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'saleLineRef');
end;

procedure TSalesLinesAutoSplitQty.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'saleLineRef' ,saleLineRef);
end;


initialization
  RegisterClass(TSalesAutoSplitQty);
  RegisterClass(TSalesAutoSplitQtyLines);


end.
