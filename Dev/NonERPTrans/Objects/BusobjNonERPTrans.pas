unit BusobjNonERPTrans;


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, busobjstock;


type
  TNonERPTransLines = class(TMSBusObj)
  private
    function GetProductID                   : Integer   ;
    function GetProductName                 : string    ;
    function GetProduct_Description         : string    ;
    function GetShipped                     : Double    ;
    function GetTotalLineAmountInc          : Double    ;
    procedure SetProductID                   (const Value: Integer   );
    procedure SetProductName                 (const Value: string    );
    procedure SetProduct_Description         (const Value: string    );
    procedure SetShipped                     (const Value: Double    );
    procedure SetTotalLineAmountInc          (const Value: Double    );
    function getProduct: TProduct;

    Function getispo:Boolean;
    Function getisra:Boolean;
    Function getisbill:Boolean;
    Function getiscredit:Boolean;
    Function getisCheque:Boolean;

  protected
    function GetTransID                      : Integer   ;Virtual;Abstract;
    function GetERPTransLineId               : Integer   ;Virtual;Abstract;
    procedure SetTransID                      (const Value: Integer   );Virtual;Abstract;
    procedure SetERPTransLineId               (const Value: Integer   );Virtual;Abstract;

    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property      Product: TProduct read getProduct;
    property TransID                       :Integer     read GetTransID                     write SetTransID                  ;
    property ERPTransLineId                :Integer     read GetERPTransLineId              write SetERPTransLineId           ;
    property ProductID                    :Integer     read GetProductID                  write SetProductID               ;
    Property isPO :Boolean read getispo;
    Property isra :Boolean read getisra;
    Property isbill :Boolean read getisbill;
    Property iscredit :Boolean read getiscredit;
    Property isCheque :Boolean read getisCheque;
  published
    property ProductName                  :string      read GetProductName                write SetProductName             ;
    property Product_Description          :string      read GetProduct_Description        write SetProduct_Description     ;
    property Shipped                      :Double      read GetShipped                    write SetShipped                 ;
    property TotalLineAmountInc           :Double      read GetTotalLineAmountInc         write SetTotalLineAmountInc      ;
  end;

  TNonERPTrans = class(TMSBusObj)
  private

    function GetClientID        : Integer   ;
    function GetTotalAmountInc  : Double    ;
    function GetEmployeeName    : string    ;
    function GetSource          : string    ;
    function GetTerms           : string    ;
    function GetStatus          : string    ;
    function GetComments        : string    ;
    function GetEmployeeID      : Integer   ;
    function GetEnteredBy       : string    ;
    function GetEnteredAt       : Tdatetime ;
    procedure SetClientID       (const Value: Integer   );
    procedure SetTotalAmountInc (const Value: Double    );
    procedure SetEmployeeName   (const Value: string    );
    procedure SetSource         (const Value: string    );
    procedure SetTerms          (const Value: string    );
    procedure SetStatus         (const Value: string    );
    procedure SetComments       (const Value: string    );
    procedure SetEmployeeID     (const Value: Integer   );
    procedure SetEnteredBy      (const Value: string    );
    procedure SetEnteredAt      (const Value: Tdatetime  );
    Procedure CalcOrdertotals;
    procedure CalcTotalsCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure ValidateDataCallback(const Sender: TBusObj; var Abort: Boolean);
    procedure SaveCallback(const Sender: TBusObj; var Abort: Boolean);


  protected
    fTotalAmountInc : Double;
    AllLinesValid : Boolean;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function GetTransDate                : TDateTime ;Virtual;Abstract;
    procedure SetTransDate                (const Value: TDateTime );Virtual;Abstract;
    function getLines: TNonERPTransLines;Virtual;Abstract;
    function GetClientName            : string    ;Virtual;Abstract;
    procedure SetClientName            (const Value: string    );Virtual;Abstract;
    function GetTransId                : Integer   ;Virtual;Abstract;
    procedure SetTransId                (const Value: Integer   );Virtual;Abstract;
    function GetERPTransID               : Integer   ;Virtual;Abstract;
    procedure SetERPTransID               (const Value: Integer   );Virtual;Abstract;

  public
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property TransId       : Integer   read GetTransId        write SetTransId            ;
    property ClientID      : Integer   read GetClientID       write SetClientID            ;
    property ERPTransID    : Integer   read GetERPTransID     write SetERPTransID            ;
    property EmployeeID    : Integer   read GetEmployeeID     write SetEmployeeID          ;
    property EnteredBy     : string    read GetEnteredBy      write SetEnteredBy           ;
    property EnteredAt     : Tdatetime read GetEnteredAt      write SetEnteredAt           ;
    property ClientName    : string    read GetClientName     write SetClientName        ;
  published
    property TransDate     : TDateTime read GetTransDate      write SetTransDate            ;
    property TotalAmountInc: Double    read GetTotalAmountInc write SetTotalAmountInc      ;
    property EmployeeName  : string    read GetEmployeeName   write SetEmployeeName        ;
    property Source        : string    read GetSource         write SetSource        ;
    property Terms         : string    read GetTerms          write SetTerms         ;
    property Status        : string    read GetStatus         write SetStatus         ;
    property Comments      : string    read GetComments       write SetComments        ;
    Property Lines : TNonERPTransLines read getLines;
  end;
 TNonERPTransFlat = class(TMSBusObj)
    private
      fClientName          : string      ;
      fComments            : string      ;
      fTransDate           : TDateTime   ;
      fEmployeeName        : string      ;
      fSource              : string      ;
      fTerms               : string      ;
      fStatus              : string      ;
      {Lines Properties}
      fTransID             : Integer     ;
      fProductName         : string      ;
      fProduct_Description : string      ;
      fShipped             : Double      ;
      fTotalLineAmountInc  : Double      ;
    Protected
      Procedure HeaderSave(NonERPTrans :TNonERPTrans);Virtual;abstract;
      Procedure LinesSave(NonERPTranslines :TNonERPTranslines);Virtual;abstract;
      function getTNonERPTrans: TNonERPTrans;Virtual;abstract;
    Public
      function Save: Boolean ; override;
      Property NonERPTrans : TNonERPTrans read getTNonERPTrans;
      property TransID                       :Integer     Read fTransID                     write fTransID                  ;
      property ClientName   : string      Read fClientName   write fClientName        ;
      property Comments     : string      Read fComments     write fComments          ;
    Published
      {Header Properties}
      property TransDate    : TDateTime   Read fTransDate    write fTransDate            ;
      property EmployeeName : string      Read fEmployeeName write fEmployeeName        ;
      property Source       : string      Read fSource       write fSource        ;
      property Terms        : string      Read fTerms        write fTerms         ;
      property Status       : string      Read fStatus       write fStatus        ;
      {Lines Properties}
      property ProductName         : string Read fProductName         write fProductName             ;
      property Product_Description : string Read fProduct_Description write fProduct_Description     ;
      property Shipped             : Double Read fShipped             write fShipped                 ;
      property TotalLineAmountInc  : Double Read fTotalLineAmountInc  write fTotalLineAmountInc      ;
  end;
implementation


uses tcDataUtils, CommonLib, sysutils, MySQLConst, BusObjClient, BusObjEmployee,
  BusObjClass, BusObjectListObj, AppEnvironment, dialogs, AppEnvironmentVirtual,
  BusObjNonERPPO;



  {TNonERPTransLines}

constructor TNonERPTransLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('ID');
  ExportExcludeList.Add('Gloablref');
  ExportExcludeList.Add('TransID');
  ExportExcludeList.Add('ERPTransLineId');
  ExportExcludeList.Add('ProductID');
end;


destructor TNonERPTransLines.Destroy;
begin
  inherited;
end;


procedure TNonERPTransLines.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TransID');
  SetPropertyFromNode(node,'ERPTransLineId');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'Product_Description');
  SetPropertyFromNode(node,'Shipped');
  SetPropertyFromNode(node,'TotalLineAmountInc');
end;


procedure TNonERPTransLines.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TransID' ,TransID);
  AddXMLNode(node,'ERPTransLineId' ,ERPTransLineId);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'Product_Description' ,Product_Description);
  AddXMLNode(node,'Shipped' ,Shipped);
  AddXMLNode(node,'TotalLineAmountInc' ,TotalLineAmountInc);
end;


function TNonERPTransLines.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;

  if (iscredit or isbill or ischeque) then begin
  end else   if (Productname ='')  then begin
    AddResult(False , rssWarning , 0,  'Product Name should not be blank');
    Exit;
  end;

  if Shipped =0 then Shipped := 1;
  Result := True;
end;


function TNonERPTransLines.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TNonERPTransLines.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TNonERPTransLines.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.Fieldname , 'ProductName') then begin
    ProductId := Product.ID;
  end;
end;



function TNonERPTransLines.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if Assigned(Owner) then
    if owner is TNonERPTrans then
      TransId :=TNonERPTrans(Owner).ID;
end;

function TNonERPTransLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
{Property Functions}
Function TNonERPTransLines.GetisPO :Boolean; begin  result := False; if assigned(Owner) and (Owner is TNonERPPurchase) then result := TNonERPPurchase(Owner).ispo;end;
Function TNonERPTransLines.Getisra :Boolean; begin  result := False; if assigned(Owner) and (Owner is TNonERPPurchase) then result := TNonERPPurchase(Owner).isra;end;
Function TNonERPTransLines.Getisbill :Boolean; begin  result := False; if assigned(Owner) and (Owner is TNonERPPurchase) then result := TNonERPPurchase(Owner).isbill;end;
Function TNonERPTransLines.Getiscredit :Boolean; begin  result := False; if assigned(Owner) and (Owner is TNonERPPurchase) then result := TNonERPPurchase(Owner).iscredit;end;
Function TNonERPTransLines.GetisCheque :Boolean; begin  result := False; if assigned(Owner) and (Owner is TNonERPPurchase) then result := TNonERPPurchase(Owner).isCheque;end;

function  TNonERPTransLines.GetProductID               : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TNonERPTransLines.GetProductName             : string    ; begin Result := GetStringField('ProductName');end;
function  TNonERPTransLines.GetProduct_Description     : string    ; begin Result := GetStringField('Product_Description');end;
function  TNonERPTransLines.GetShipped                 : Double    ; begin Result := GetFloatField('Shipped');end;
function  TNonERPTransLines.GetTotalLineAmountInc      : Double    ; begin Result := GetFloatField('TotalLineAmountInc');end;
procedure TNonERPTransLines.SetProductID               (const Value: Integer   ); begin SetIntegerField('ProductID'         , Value);end;
procedure TNonERPTransLines.SetProductName             (const Value: string    ); begin SetStringField('ProductName'        , Value);end;
procedure TNonERPTransLines.SetProduct_Description     (const Value: string    ); begin SetStringField('Product_Description', Value);end;
procedure TNonERPTransLines.SetShipped                 (const Value: Double    ); begin SetFloatField('Shipped'             , Value);end;
procedure TNonERPTransLines.SetTotalLineAmountInc      (const Value: Double    ); begin SetFloatField('TotalLineAmountInc'  , Value);end;
function TNonERPTransLines.getProduct: TProduct;
var
  s: string;
  s1: string;
begin
  if ID = 0 then PostDb; // BJ: this is to get the id if in insert mode
  if Self.ProductName <> '' then begin
    s := 'PartName = ' + Quotedstr(StringDataForSQL(ProductName));
    s1 := 'PARTSID = ' + inttostr(Self.ProductID);
  end else begin
    s := 'PARTSID = ' + inttostr(Self.ProductID);
    s1 := 'PartName = ' + Quotedstr(StringDataForSQL(ProductName));
  end;
  Result := TProduct(getContainerComponent(TProduct, s, Self.SilentMode, False, True, s1, True));
end;
  {TNonERPTrans}
procedure TNonERPTrans.CalcOrdertotals;
begin
  fTotalAmountInc := 0;
  Lines.IterateREcords(CalcTotalsCallback );
  TotalAmountInc  := fTotalAmountInc ;
end;
procedure TNonERPTrans.CalcTotalsCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  fTotalAmountInc := fTotalAmountInc + TNonERPTransLines(Sender).TotalLineAmountInc;
end;
constructor TNonERPTrans.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('ClientID');
  ExportExcludeList.Add('ERPTransID');
  ExportExcludeList.Add('EmployeeID');
  ExportExcludeList.Add('EnteredBy');
  ExportExcludeList.Add('EnteredAt');
end;
destructor TNonERPTrans.Destroy;
begin
  inherited;
end;

procedure TNonERPTrans.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClientName');
  SetPropertyFromNode(node,'ClientID');
  SetPropertyFromNode(node,'ERPTransID');
  SetDateTimePropertyFromNode(node,'TransDate');
  SetPropertyFromNode(node,'TotalAmountInc');
  SetPropertyFromNode(node,'EmployeeName');
  SetPropertyFromNode(node,'Source');
  SetPropertyFromNode(node,'Terms');
  SetPropertyFromNode(node,'Status');
  SetPropertyFromNode(node,'Comments');
  SetPropertyFromNode(node,'EmployeeID');
  SetPropertyFromNode(node,'EnteredBy');
  SetdatetimePropertyFromNode(node,'EnteredAt');
end;

procedure TNonERPTrans.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientName' ,ClientName);
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'ERPTransID' ,ERPTransID);
  AddXMLNode(node,'TransDate' ,TransDate);
  AddXMLNode(node,'TotalAmountInc' ,TotalAmountInc);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'Source' ,Source);
  AddXMLNode(node,'Terms' ,Terms);
  AddXMLNode(node,'Status' ,Status);
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'EmployeeID' ,EmployeeID);
  AddXMLNode(node,'EnteredBy' ,EnteredBy);
  AddXMLNode(node,'EnteredAt' ,EnteredAt);
end;

function TNonERPTrans.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if Clientname ='' then begin
    AddResult(False , rssWarning , 0,  'Client Name should not be blank');
    Exit;
  end;
  if Transdate =0 then begin
    AddResult(False , rssWarning , 0,  'Transdate  should not be blank');
    Exit;
  end;
  allLinesValid := True;
  Lines.IterateREcords(ValidateDataCallback);
  if not allLinesValid then exit;
  Result := True;
end;
procedure TNonERPTrans.ValidateDataCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not (Sender is TNonERPTransLines) then exit;
  if not TNonERPTransLines(Sender).ValidateData then begin
    AllLinesValid := false;
    Abort := false;
    Exit;
  end;
end;
function TNonERPTrans.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  allLinesValid :=true;
  Lines.IterateRecords(SaveCallback);
  if not allLinesValid then exit;
  CalcOrdertotals;
  Result := inherited Save;
end;

procedure TNonERPTrans.SaveCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not (Sender is TNonERPTransLines) then exit;
  if not TNonERPTransLines(Sender).Save then begin
    AllLinesValid := false;
    Abort := false;
    Exit;
  end;
end;

procedure TNonERPTrans.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TNonERPTrans.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.Fieldname , 'EmployeeName') then begin
    EmployeeId := TEmployee.IDToggle(EmployeeName, Connection.Connection);
  end;

end;


function TNonERPTrans.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  enteredBy := TEmployee.IDToggle(Appenv.Employee.EmployeeID);
  enteredat := now;
end;

function TNonERPTrans.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TNonERPTrans.GetClientID            : Integer   ; begin Result := GetIntegerField('ClientID');end;
function  TNonERPTrans.GetTotalAmountInc      : Double    ; begin Result := GetFloatField('TotalAmountInc');end;
function  TNonERPTrans.GetEmployeeName        : string    ; begin Result := GetStringField('EmployeeName');end;
function  TNonERPTrans.GetSource        : string    ; begin Result := GetStringField('Source');end;
function  TNonERPTrans.GetTerms        : string    ; begin Result := GetStringField('Terms');end;
function  TNonERPTrans.GetStatus        : string    ; begin Result := GetStringField('Status');end;
function  TNonERPTrans.GetComments        : string    ; begin Result := GetStringField('Comments');end;
function  TNonERPTrans.GetEmployeeID          : Integer   ; begin Result := GetIntegerField('EmployeeID');end;
function  TNonERPTrans.GetEnteredBy           : string    ; begin Result := GetStringField('EnteredBy');end;
function  TNonERPTrans.GetEnteredAt           : Tdatetime ; begin Result := GetDatetimeField('EnteredAt');end;
procedure TNonERPTrans.SetClientID            (const Value: Integer   ); begin SetIntegerField('ClientID'             , Value);end;
procedure TNonERPTrans.SetTotalAmountInc      (const Value: Double    ); begin SetFloatField('TotalAmountInc'       , Value);end;
procedure TNonERPTrans.SetEmployeeName        (const Value: string    ); begin SetStringField('EmployeeName'         , Value);end;
procedure TNonERPTrans.SetSource        (const Value: string    ); begin SetStringField('Source'         , Value);end;
procedure TNonERPTrans.SetTerms        (const Value: string    ); begin SetStringField('Terms'         , Value);end;
procedure TNonERPTrans.SetStatus        (const Value: string    ); begin SetStringField('Status'         , Value);end;
procedure TNonERPTrans.SetComments        (const Value: string    ); begin SetStringField('Comments'         , Value);end;
procedure TNonERPTrans.SetEmployeeID          (const Value: Integer   ); begin SetIntegerField('EmployeeID'           , Value);end;
procedure TNonERPTrans.SetEnteredBy           (const Value: string    ); begin SetStringField('EnteredBy'            , Value);end;
procedure TNonERPTrans.SetEnteredAt           (const Value: Tdatetime ); begin SetDateTimeField('EnteredAt'            , Value);end;
function TNonERPTransFlat.Save: Boolean;
begin
    if NonERPTrans.Count =0 then begin
      NonERPTrans.New;
      NonERPTrans.ClientName         := ClientName  ;
      NonERPTrans.Comments           := Comments  ;
      NonERPTrans.TransDate          := TransDate   ;
      NonERPTrans.EmployeeName       := EmployeeName;
      NonERPTrans.Source             := Source      ;
      NonERPTrans.Terms              := Terms      ;
      NonERPTrans.Status              := Status      ;
      HeaderSave(NonERPTrans);
      NonERPTrans.PostDB;
    end;
    NonERPTrans.Lines.New;
    NonERPTrans.Lines.ProductName        := ProductName               ;
    NonERPTrans.Lines.Product_Description:= Product_Description       ;
    NonERPTrans.Lines.Shipped            := Shipped                   ;
    NonERPTrans.Lines.TotalLineAmountInc := TotalLineAmountInc        ;
    LinesSave(NonERPTrans.Lines);
    NonERPTrans.Lines.PostDB;
    Result := NonERPTrans.Save;
end;
end.
