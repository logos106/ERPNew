unit BusobjGoogleAnalytic_ERPlink;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  17/08/12  1.00.00  BS.  Initial Version.
  }

interface

uses BusObjBase, Classes, XMLDoc, XMLIntf , MyAccess,db;


type
  TGA_ERP_Posting = class(TMSBusObj)
  private
    function GetgacostId            : Integer   ;
    function GetamountPosted        : Double    ;
    function GetPurchaseOrderId     : Integer   ;
    function GetPurchaseLineID      : Integer   ;
    procedure SetgacostId            (const Value: Integer   );
    procedure SetamountPosted        (const Value: Double    );
    procedure SetPurchaseOrderId     (const Value: Integer   );
    procedure SetPurchaseLineID      (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusobj):Boolean;             override;
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
    property gacostId             :Integer     read GetgacostId           write SetgacostId        ;
    property amountPosted         :Double      read GetamountPosted       write SetamountPosted    ;
    property PurchaseOrderId      :Integer     read GetPurchaseOrderId    write SetPurchaseOrderId ;
    property PurchaseLineID       :Integer     read GetPurchaseLineID     write SetPurchaseLineID  ;
  end;

TGA_ERP_Source = class(TMSBusObj)
  private
    function GetSourceID            : Integer   ;
    function Getga_ProfileId        : Integer   ;
    function GetActive              : Boolean   ;
    procedure SetSourceID            (const Value: Integer   );
    procedure Setga_ProfileId        (const Value: Integer   );
    procedure SetActive              (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoAfterInsert(Sender:TDatasetBusobj):Boolean;             Override;
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
    property SourceID             :Integer     read GetSourceID           write SetSourceID        ;
    property ga_ProfileId         :Integer     read Getga_ProfileId       write Setga_ProfileId    ;
    property Active               :Boolean     read GetActive             write SetActive          ;
  end;

  TGADataForCost = class(TBusObj)
  private
    function GetProfileId             : string    ;
    function GetDateTime              : TDateTime ;
    function GetCampaign              : string    ;
    function GetCampaignID            : string    ;
    function GetAdword                : string    ;
    function GetAdwordID              : string    ;
    function GetCost                  : Double    ;
    function GetCostPerTransaction    : Double    ;
    function GetcostPerconversion     : Double    ;
    procedure SetProfileId             (const Value: string    );
    procedure SetDateTime              (const Value: TDateTime );
    procedure SetCampaign              (const Value: string    );
    procedure SetCampaignID            (const Value: string    );
    procedure SetAdword                (const Value: string    );
    procedure SetAdwordID              (const Value: string    );
    procedure SetCost                  (const Value: Double    );
    procedure SetCostPerTransaction    (const Value: Double    );
    procedure SetcostPerconversion     (const Value: Double    );
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
    property ProfileId              :string      read GetProfileId            write SetProfileId         ;
    property DateTime               :TDateTime   read GetDateTime             write SetDateTime          ;
    property Campaign               :string      read GetCampaign             write SetCampaign          ;
    property CampaignID             :string      read GetCampaignID           write SetCampaignID        ;
    property Adword                 :string      read GetAdword               write SetAdword            ;
    property AdwordID               :string      read GetAdwordID             write SetAdwordID          ;
    property Cost                   :Double      read GetCost                 write SetCost              ;
    property CostPerTransaction     :Double      read GetCostPerTransaction   write SetCostPerTransaction;
    property costPerconversion      :Double      read GetcostPerconversion    write SetcostPerconversion ;
  end;

implementation

uses busobjExpenses;



  {TGA_ERP_Posting}

constructor TGA_ERP_Posting.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'GA_ERP_Postings';
  fSQL := 'SELECT * FROM tbltga_erp_Postings';
end;


destructor TGA_ERP_Posting.Destroy;
begin
  inherited;
end;


procedure TGA_ERP_Posting.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'gacostId');
  SetPropertyFromNode(node,'amountPosted');
  SetPropertyFromNode(node,'PurchaseOrderId');
  SetPropertyFromNode(node,'PurchaseLineID');
end;


procedure TGA_ERP_Posting.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'gacostId' ,gacostId);
  AddXMLNode(node,'amountPosted' ,amountPosted);
  AddXMLNode(node,'PurchaseOrderId' ,PurchaseOrderId);
  AddXMLNode(node,'PurchaseLineID' ,PurchaseLineID);
end;


function TGA_ERP_Posting.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if gacostId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'gacostId should not be 0' , False );
    Exit;
  end;
  if PurchaseOrderId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PurchaseOrderId should not be 0' , False );
    Exit;
  end;
  if PurchaseLineID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'PurchaseLineID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TGA_ERP_Posting.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TGA_ERP_Posting.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TGA_ERP_Posting.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TGA_ERP_Posting.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TGA_ERP_Posting.GetIDField: string;
begin
  Result := 'ID'
end;


class function TGA_ERP_Posting.GetBusObjectTablename: string;
begin
  Result:= 'tbltga_erp_Postings';
end;


function TGA_ERP_Posting.DoAfterInsert(Sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if owner is TBillLines then begin
        PurchaseOrderId := TBillLines(Owner).PurchaseOrderId;
        PurchaseLineID := TBillLines(Owner).ID;
    end;
end;

function TGA_ERP_Posting.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TGA_ERP_Posting.GetgacostId        : Integer   ; begin Result := GetIntegerField('gacostId');end;
function  TGA_ERP_Posting.GetamountPosted    : Double    ; begin Result := GetFloatField('amountPosted');end;
function  TGA_ERP_Posting.GetPurchaseOrderId : Integer   ; begin Result := GetIntegerField('PurchaseOrderId');end;
function  TGA_ERP_Posting.GetPurchaseLineID  : Integer   ; begin Result := GetIntegerField('PurchaseLineID');end;
procedure TGA_ERP_Posting.SetgacostId        (const Value: Integer   ); begin SetIntegerField('gacostId'         , Value);end;
procedure TGA_ERP_Posting.SetamountPosted    (const Value: Double    ); begin SetFloatField('amountPosted'     , Value);end;
procedure TGA_ERP_Posting.SetPurchaseOrderId (const Value: Integer   ); begin SetIntegerField('PurchaseOrderId' , Value);end;
procedure TGA_ERP_Posting.SetPurchaseLineID  (const Value: Integer   ); begin SetIntegerField('PurchaseLineID'   , Value);end;


 {TGA_ERP_Source}

constructor TGA_ERP_Source.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'GA_ERP_Source';
  fSQL := 'SELECT * FROM tbltga_erp_source';
end;


destructor TGA_ERP_Source.Destroy;
begin
  inherited;
end;


procedure TGA_ERP_Source.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ID');
  SetPropertyFromNode(node,'SourceID');
  SetPropertyFromNode(node,'ga_ProfileId');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TGA_ERP_Source.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ID' ,ID);
  AddXMLNode(node,'SourceID' ,SourceID);
  AddXMLNode(node,'ga_ProfileId' ,ga_ProfileId);
  AddXMLNode(node,'Active' ,Active);
end;


function TGA_ERP_Source.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if SourceID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'SourceID should not be 0' , False );
    Exit;
  end;
  if ga_ProfileId = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ga_ProfileId should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TGA_ERP_Source.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TGA_ERP_Source.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TGA_ERP_Source.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TGA_ERP_Source.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TGA_ERP_Source.GetIDField: string;
begin
  Result := 'UId'
end;


class function TGA_ERP_Source.GetBusObjectTablename: string;
begin
  Result:= 'tbltga_erp_source';
end;


function TGA_ERP_Source.DoAfterInsert(Sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

function TGA_ERP_Source.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TGA_ERP_Source.GetSourceID        : Integer   ; begin Result := GetIntegerField('SourceID');end;
function  TGA_ERP_Source.Getga_ProfileId    : Integer   ; begin Result := GetIntegerField('ga_ProfileId');end;
function  TGA_ERP_Source.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TGA_ERP_Source.SetSourceID        (const Value: Integer   ); begin SetIntegerField('SourceID'         , Value);end;
procedure TGA_ERP_Source.Setga_ProfileId    (const Value: Integer   ); begin SetIntegerField('ga_ProfileId'     , Value);end;
procedure TGA_ERP_Source.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;

 {TGADataForCost}

constructor TGADataForCost.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'GADataForCost';
  fSQL := 'SELECT * FROM tbltgadataforcost';
end;


destructor TGADataForCost.Destroy;
begin
  inherited;
end;


procedure TGADataForCost.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ProfileId');
  SetDateTimePropertyFromNode(node,'DateTime');
  SetPropertyFromNode(node,'Campaign');
  SetPropertyFromNode(node,'CampaignID');
  SetPropertyFromNode(node,'Adword');
  SetPropertyFromNode(node,'AdwordID');
  SetPropertyFromNode(node,'Cost');
  SetPropertyFromNode(node,'CostPerTransaction');
  SetPropertyFromNode(node,'costPerconversion');
end;


procedure TGADataForCost.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProfileId' ,ProfileId);
  AddXMLNode(node,'DateTime' ,DateTime);
  AddXMLNode(node,'Campaign' ,Campaign);
  AddXMLNode(node,'CampaignID' ,CampaignID);
  AddXMLNode(node,'Adword' ,Adword);
  AddXMLNode(node,'AdwordID' ,AdwordID);
  AddXMLNode(node,'Cost' ,Cost);
  AddXMLNode(node,'CostPerTransaction' ,CostPerTransaction);
  AddXMLNode(node,'costPerconversion' ,costPerconversion);
end;


function TGADataForCost.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if DateTime = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'DateTime should not be blank' , False );
    Exit;
  end;
  Result := True;
end;


function TGADataForCost.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TGADataForCost.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TGADataForCost.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TGADataForCost.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TGADataForCost.GetIDField: string;
begin
  Result := 'UId'
end;


class function TGADataForCost.GetBusObjectTablename: string;
begin
  Result:= 'tbltgadataforcost';
end;


function TGADataForCost.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

function TGADataForCost.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TGADataForCost.GetProfileId         : string    ; begin Result := GetStringField('ProfileId');end;
function  TGADataForCost.GetDateTime          : TDateTime ; begin Result := GetDateTimeField('DateTime');end;
function  TGADataForCost.GetCampaign          : string    ; begin Result := GetStringField('Campaign');end;
function  TGADataForCost.GetCampaignID        : string    ; begin Result := GetStringField('CampaignID');end;
function  TGADataForCost.GetAdword            : string    ; begin Result := GetStringField('Adword');end;
function  TGADataForCost.GetAdwordID          : string    ; begin Result := GetStringField('AdwordID');end;
function  TGADataForCost.GetCost              : Double    ; begin Result := GetFloatField('Cost');end;
function  TGADataForCost.GetCostPerTransaction: Double    ; begin Result := GetFloatField('CostPerTransaction');end;
function  TGADataForCost.GetcostPerconversion : Double    ; begin Result := GetFloatField('costPerconversion');end;
procedure TGADataForCost.SetProfileId         (const Value: string    ); begin SetStringField('ProfileId'          , Value);end;
procedure TGADataForCost.SetDateTime          (const Value: TDateTime ); begin SetDateTimeField('DateTime'           , Value);end;
procedure TGADataForCost.SetCampaign          (const Value: string    ); begin SetStringField('Campaign'           , Value);end;
procedure TGADataForCost.SetCampaignID        (const Value: string    ); begin SetStringField('CampaignID'         , Value);end;
procedure TGADataForCost.SetAdword            (const Value: string    ); begin SetStringField('Adword'             , Value);end;
procedure TGADataForCost.SetAdwordID          (const Value: string    ); begin SetStringField('AdwordID'           , Value);end;
procedure TGADataForCost.SetCost              (const Value: Double    ); begin SetFloatField('Cost'               , Value);end;
procedure TGADataForCost.SetCostPerTransaction(const Value: Double    ); begin SetFloatField('CostPerTransaction' , Value);end;
procedure TGADataForCost.SetcostPerconversion (const Value: Double    ); begin SetFloatField('costPerconversion' , Value);end;



initialization
  RegisterClass(TGADataForCost);
  RegisterClass(TGA_ERP_Source);
  RegisterClass(TGA_ERP_Posting);

end.
