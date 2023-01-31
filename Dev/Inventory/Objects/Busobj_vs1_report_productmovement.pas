unit Busobj_vs1_report_productmovement;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  03/02/21  1.00.00  dm  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  T_VS1_Report_Productmovement = class(TMSBusObj)
  private
    function GetPQAID                          : Integer   ;
    function GetTransactionDate                : TDateTime ;
    function GetTransType                      : string    ;
    function GetStockMovementEntryglobalref    : string    ;
    function GetSAID                           : Integer   ;
    function GetSTID                           : Integer   ;
    function GetProductName                    : string    ;
    function GetFirstColumn                    : string    ;
    function GetSecondColumn                   : string    ;
    function GetThirdColumn                    : string    ;
    function GetQty                            : Double    ;
    function GetTotalCost                      : Double    ;
    function GetProductID                      : Integer   ;
    function GetClassID                        : Integer   ;
    function GetTransactionNo                  : Integer   ;
    function GetInvID                          : Integer   ;
    function GetSoID                           : Integer   ;
    function GetConverted                      : Boolean   ;
    function GetTransLineID                    : Integer   ;
    function GetPQATranstype                   : string    ;
    function GetAverageCost                    : Double    ;
    function GetCost                           : Double    ;
    function GetAvailable                      : Double    ;
    function GetInStock                        : Double    ;
    function Getso                             : Double    ;
    function Getinvbo                          : Double    ;
    function Getpobo                           : Double    ;
    function Getonbuild                        : Double    ;
    function Getbuilding                       : Double    ;
    function GetAlloctype                      : string    ;
    function GetPrice                          : Double    ;
    function GetTotalPrice                     : Double    ;
    function GetStSID                          : Integer   ;
    function GetExtraDesc                      : string    ;
    function GetcTranstype                     : string    ;
    function getDeptName: String;
    (*procedure SetPQAID                          (const Value: Integer   );
    procedure SetTransactionDate                (const Value: TDateTime );
    procedure SetTransType                      (const Value: string    );
    procedure SetStockMovementEntryglobalref    (const Value: string    );
    procedure SetSAID                           (const Value: Integer   );
    procedure SetSTID                           (const Value: Integer   );
    procedure SetProductName                    (const Value: string    );
    procedure SetFirstColumn                    (const Value: string    );
    procedure SetSecondColumn                   (const Value: string    );
    procedure SetThirdColumn                    (const Value: string    );
    procedure SetQty                            (const Value: Double    );
    procedure SetTotalCost                      (const Value: Double    );
    procedure SetProductID                      (const Value: Integer   );
    procedure SetClassID                        (const Value: Integer   );
    procedure SetTransactionNo                  (const Value: Integer   );
    procedure SetInvID                          (const Value: Integer   );
    procedure SetSoID                           (const Value: Integer   );
    procedure SetConverted                      (const Value: Boolean   );
    procedure SetTransLineID                    (const Value: Integer   );
    procedure SetPQATranstype                   (const Value: string    );
    procedure SetAverageCost                    (const Value: Double    );
    procedure SetCost                           (const Value: Double    );
    procedure SetAvailable                      (const Value: Double    );
    procedure SetInStock                        (const Value: Double    );
    procedure Setso                             (const Value: Double    );
    procedure Setinvbo                          (const Value: Double    );
    procedure Setpobo                           (const Value: Double    );
    procedure Setonbuild                        (const Value: Double    );
    procedure Setbuilding                       (const Value: Double    );
    procedure SetAlloctype                      (const Value: string    );
    procedure SetPrice                          (const Value: Double    );
    procedure SetTotalPrice                     (const Value: Double    );
    procedure SetStSID                          (const Value: Integer   );
    procedure SetExtraDesc                      (const Value: string    );
    procedure SetcTranstype                     (const Value: string    );*)
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    //procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property PQAID                           :Integer     read GetPQAID                         ;//write SetPQAID                      ;
    property TransType                       :string      read GetTransType                     ;//write SetTransType                  ;
    property StockMovementEntryglobalref     :string      read GetStockMovementEntryglobalref   ;//write SetStockMovementEntryglobalref;
    property SAID                            :Integer     read GetSAID                          ;//write SetSAID                       ;
    property STID                            :Integer     read GetSTID                          ;//write SetSTID                       ;
    property InvID                           :Integer     read GetInvID                         ;//write SetInvID                      ;
    property SoID                            :Integer     read GetSoID                          ;//write SetSoID                       ;
    property Converted                       :Boolean     read GetConverted                     ;//write SetConverted                  ;
    property TransLineID                     :Integer     read GetTransLineID                   ;//write SetTransLineID                ;
    property PQATranstype                    :string      read GetPQATranstype                  ;//write SetPQATranstype               ;
    property Alloctype                       :string      read GetAlloctype                     ;//write SetAlloctype                  ;
    property StSID                           :Integer     read GetStSID                         ;//write SetStSID                      ;
  published
    property TransactionDate                 :TDateTime   read GetTransactionDate               ;//write SetTransactionDate            ;
    property ProductName                     :string      read GetProductName                   ;//write SetProductName                ;
    property FirstColumn                     :string      read GetFirstColumn                   ;//write SetFirstColumn                ;
    property SecondColumn                    :string      read GetSecondColumn                  ;//write SetSecondColumn               ;
    property ThirdColumn                     :string      read GetThirdColumn                   ;//write SetThirdColumn                ;
    property Qty                             :Double      read GetQty                           ;//write SetQty                        ;
    property TotalCost                       :Double      read GetTotalCost                     ;//write SetTotalCost                  ;
    property ProductID                       :Integer     read GetProductID                     ;//write SetProductID                  ;
    property ClassID                         :Integer     read GetClassID                       ;//write SetClassID                    ;
    property TransactionNo                   :Integer     read GetTransactionNo                 ;//write SetTransactionNo              ;
    property AverageCost                     :Double      read GetAverageCost                   ;//write SetAverageCost                ;
    property Cost                            :Double      read GetCost                          ;//write SetCost                       ;
    property Available                       :Double      read GetAvailable                     ;//write SetAvailable                  ;
    property InStock                         :Double      read GetInStock                       ;//write SetInStock                    ;
    property so                              :Double      read Getso                            ;//write Setso                         ;
    property invbo                           :Double      read Getinvbo                         ;//write Setinvbo                      ;
    property pobo                            :Double      read Getpobo                          ;//write Setpobo                       ;
    property onbuild                         :Double      read Getonbuild                       ;//write Setonbuild                    ;
    property building                        :Double      read Getbuilding                      ;//write Setbuilding                   ;
    property Price                           :Double      read GetPrice                         ;//write SetPrice                      ;
    property TotalPrice                      :Double      read GetTotalPrice                    ;//write SetTotalPrice                 ;
    property ExtraDesc                       :string      read GetExtraDesc                     ;//write SetExtraDesc                  ;
    property TranstypeDesc                   :string      read GetcTranstype                    ;//write SetcTranstype                 ;
    property Deptname                        :String      read getDeptName;
  end;


implementation


uses tcDataUtils, CommonLib, BusObjClass;



  {T_VS1_Report_Productmovement}

constructor T_VS1_Report_Productmovement.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= '_VS1_Report_Productmovement';
  fSQL := 'SELECT * FROM tmp_vs1_report_productmovement';
  isReadonly := True;
end;


destructor T_VS1_Report_Productmovement.Destroy;
begin
  inherited;
end;


(*procedure T_VS1_Report_Productmovement.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PQAID');
  SetDateTimePropertyFromNode(node,'TransactionDate');
  SetPropertyFromNode(node,'TransType');
  SetPropertyFromNode(node,'StockMovementEntryglobalref');
  SetPropertyFromNode(node,'SAID');
  SetPropertyFromNode(node,'STID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'FirstColumn');
  SetPropertyFromNode(node,'SecondColumn');
  SetPropertyFromNode(node,'ThirdColumn');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'TotalCost');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'TransactionNo');
  SetPropertyFromNode(node,'InvID');
  SetPropertyFromNode(node,'SoID');
  SetBooleanPropertyFromNode(node,'Converted');
  SetPropertyFromNode(node,'TransLineID');
  SetPropertyFromNode(node,'PQATranstype');
  SetPropertyFromNode(node,'AverageCost');
  SetPropertyFromNode(node,'Cost');
  SetPropertyFromNode(node,'Available');
  SetPropertyFromNode(node,'InStock');
  SetPropertyFromNode(node,'so');
  SetPropertyFromNode(node,'invbo');
  SetPropertyFromNode(node,'pobo');
  SetPropertyFromNode(node,'onbuild');
  SetPropertyFromNode(node,'building');
  SetPropertyFromNode(node,'Alloctype');
  SetPropertyFromNode(node,'Price');
  SetPropertyFromNode(node,'TotalPrice');
  SetPropertyFromNode(node,'StSID');
  SetPropertyFromNode(node,'ExtraDesc');
  SetPropertyFromNode(node,'cTranstype');
end;*)


procedure T_VS1_Report_Productmovement.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PQAID' ,PQAID);
  AddXMLNode(node,'TransactionDate' ,TransactionDate);
  AddXMLNode(node,'TransType' ,TransType);
  AddXMLNode(node,'StockMovementEntryglobalref' ,StockMovementEntryglobalref);
  AddXMLNode(node,'SAID' ,SAID);
  AddXMLNode(node,'STID' ,STID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'FirstColumn' ,FirstColumn);
  AddXMLNode(node,'SecondColumn' ,SecondColumn);
  AddXMLNode(node,'ThirdColumn' ,ThirdColumn);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'TotalCost' ,TotalCost);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ClassID' ,ClassID);
  AddXMLNode(node,'TransactionNo' ,TransactionNo);
  AddXMLNode(node,'InvID' ,InvID);
  AddXMLNode(node,'SoID' ,SoID);
  AddXMLNode(node,'Converted' ,Converted);
  AddXMLNode(node,'TransLineID' ,TransLineID);
  AddXMLNode(node,'PQATranstype' ,PQATranstype);
  AddXMLNode(node,'AverageCost' ,AverageCost);
  AddXMLNode(node,'Cost' ,Cost);
  AddXMLNode(node,'Available' ,Available);
  AddXMLNode(node,'InStock' ,InStock);
  AddXMLNode(node,'so' ,so);
  AddXMLNode(node,'invbo' ,invbo);
  AddXMLNode(node,'pobo' ,pobo);
  AddXMLNode(node,'onbuild' ,onbuild);
  AddXMLNode(node,'building' ,building);
  AddXMLNode(node,'Alloctype' ,Alloctype);
  AddXMLNode(node,'Price' ,Price);
  AddXMLNode(node,'TotalPrice' ,TotalPrice);
  AddXMLNode(node,'StSID' ,StSID);
  AddXMLNode(node,'ExtraDesc' ,ExtraDesc);
  AddXMLNode(node,'TranstypeDesc' ,TranstypeDesc);
end;


function T_VS1_Report_Productmovement.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function T_VS1_Report_Productmovement.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure T_VS1_Report_Productmovement.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure T_VS1_Report_Productmovement.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function T_VS1_Report_Productmovement.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function T_VS1_Report_Productmovement.GetIDField: string;
begin
  Result := 'ID'
end;


class function T_VS1_Report_Productmovement.GetBusObjectTablename: string;
begin
  Result:= 'tmp_vs1_report_productmovement';
end;


function T_VS1_Report_Productmovement.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  T_VS1_Report_Productmovement.GetPQAID                      : Integer   ; begin Result := GetIntegerField('PQAID');end;
function  T_VS1_Report_Productmovement.GetTransactionDate            : TDateTime ; begin Result := GetDateTimeField('TransactionDate');end;
function  T_VS1_Report_Productmovement.GetTransType                  : string    ; begin Result := GetStringField('TransType');end;
function  T_VS1_Report_Productmovement.GetStockMovementEntryglobalref: string    ; begin Result := GetStringField('StockMovementEntryglobalref');end;
function  T_VS1_Report_Productmovement.GetSAID                       : Integer   ; begin Result := GetIntegerField('SAID');end;
function  T_VS1_Report_Productmovement.GetSTID                       : Integer   ; begin Result := GetIntegerField('STID');end;
function  T_VS1_Report_Productmovement.GetProductName                : string    ; begin Result := GetStringField('ProductName');end;
function  T_VS1_Report_Productmovement.GetFirstColumn                : string    ; begin Result := GetStringField('FirstColumn');end;
function  T_VS1_Report_Productmovement.GetSecondColumn               : string    ; begin Result := GetStringField('SecondColumn');end;
function  T_VS1_Report_Productmovement.GetThirdColumn                : string    ; begin Result := GetStringField('ThirdColumn');end;
function  T_VS1_Report_Productmovement.GetQty                        : Double    ; begin Result := GetFloatField('Qty');end;
function  T_VS1_Report_Productmovement.GetTotalCost                  : Double    ; begin Result := GetFloatField('TotalCost');end;
function  T_VS1_Report_Productmovement.GetProductID                  : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  T_VS1_Report_Productmovement.GetClassID                    : Integer   ; begin Result := GetIntegerField('ClassID');end;
function  T_VS1_Report_Productmovement.GetTransactionNo              : Integer   ; begin Result := GetIntegerField('TransactionNo');end;
function  T_VS1_Report_Productmovement.GetInvID                      : Integer   ; begin Result := GetIntegerField('InvID');end;
function  T_VS1_Report_Productmovement.GetSoID                       : Integer   ; begin Result := GetIntegerField('SoID');end;
function  T_VS1_Report_Productmovement.GetConverted                  : Boolean   ; begin Result := GetBooleanField('Converted');end;
function  T_VS1_Report_Productmovement.GetTransLineID                : Integer   ; begin Result := GetIntegerField('TransLineID');end;
function  T_VS1_Report_Productmovement.GetPQATranstype               : string    ; begin Result := GetStringField('PQATranstype');end;
function  T_VS1_Report_Productmovement.GetAverageCost                : Double    ; begin Result := GetFloatField('AverageCost');end;
function  T_VS1_Report_Productmovement.GetCost                       : Double    ; begin Result := GetFloatField('Cost');end;
function  T_VS1_Report_Productmovement.GetAvailable                  : Double    ; begin Result := GetFloatField('Available');end;
function  T_VS1_Report_Productmovement.GetInStock                    : Double    ; begin Result := GetFloatField('InStock');end;
function  T_VS1_Report_Productmovement.Getso                         : Double    ; begin Result := GetFloatField('so');end;
function  T_VS1_Report_Productmovement.Getinvbo                      : Double    ; begin Result := GetFloatField('invbo');end;
function  T_VS1_Report_Productmovement.Getpobo                       : Double    ; begin Result := GetFloatField('pobo');end;
function  T_VS1_Report_Productmovement.Getonbuild                    : Double    ; begin Result := GetFloatField('onbuild');end;
function  T_VS1_Report_Productmovement.Getbuilding                   : Double    ; begin Result := GetFloatField('building');end;
function  T_VS1_Report_Productmovement.GetAlloctype                  : string    ; begin Result := GetStringField('Alloctype');end;
function  T_VS1_Report_Productmovement.GetPrice                      : Double    ; begin Result := GetFloatField('Price');end;
function  T_VS1_Report_Productmovement.GetTotalPrice                 : Double    ; begin Result := GetFloatField('TotalPrice');end;
function  T_VS1_Report_Productmovement.GetStSID                      : Integer   ; begin Result := GetIntegerField('StSID');end;
function  T_VS1_Report_Productmovement.GetExtraDesc                  : string    ; begin Result := GetStringField('ExtraDesc');end;
function  T_VS1_Report_Productmovement.GetcTranstype                 : string    ; begin Result := GetStringField('cTranstype');end;
function  T_VS1_Report_Productmovement.getDeptName                   : String    ; begin REsult := TDeptClass.idtoggle(ClassID);end;
(*procedure T_VS1_Report_Productmovement.SetPQAID                      (const Value: Integer   ); begin SetIntegerField('PQAID'                       , Value);end;
procedure T_VS1_Report_Productmovement.SetTransactionDate            (const Value: TDateTime ); begin SetDateTimeField('TransactionDate'             , Value);end;
procedure T_VS1_Report_Productmovement.SetTransType                  (const Value: string    ); begin SetStringField('TransType'                   , Value);end;
procedure T_VS1_Report_Productmovement.SetStockMovementEntryglobalref(const Value: string    ); begin SetStringField('StockMovementEntryglobalref' , Value);end;
procedure T_VS1_Report_Productmovement.SetSAID                       (const Value: Integer   ); begin SetIntegerField('SAID'                        , Value);end;
procedure T_VS1_Report_Productmovement.SetSTID                       (const Value: Integer   ); begin SetIntegerField('STID'                        , Value);end;
procedure T_VS1_Report_Productmovement.SetProductName                (const Value: string    ); begin SetStringField('ProductName'                 , Value);end;
procedure T_VS1_Report_Productmovement.SetFirstColumn                (const Value: string    ); begin SetStringField('FirstColumn'                 , Value);end;
procedure T_VS1_Report_Productmovement.SetSecondColumn               (const Value: string    ); begin SetStringField('SecondColumn'                , Value);end;
procedure T_VS1_Report_Productmovement.SetThirdColumn                (const Value: string    ); begin SetStringField('ThirdColumn'                 , Value);end;
procedure T_VS1_Report_Productmovement.SetQty                        (const Value: Double    ); begin SetFloatField('Qty'                         , Value);end;
procedure T_VS1_Report_Productmovement.SetTotalCost                  (const Value: Double    ); begin SetFloatField('TotalCost'                   , Value);end;
procedure T_VS1_Report_Productmovement.SetProductID                  (const Value: Integer   ); begin SetIntegerField('ProductID'                   , Value);end;
procedure T_VS1_Report_Productmovement.SetClassID                    (const Value: Integer   ); begin SetIntegerField('ClassID'                     , Value);end;
procedure T_VS1_Report_Productmovement.SetTransactionNo              (const Value: Integer   ); begin SetIntegerField('TransactionNo'               , Value);end;
procedure T_VS1_Report_Productmovement.SetInvID                      (const Value: Integer   ); begin SetIntegerField('InvID'                       , Value);end;
procedure T_VS1_Report_Productmovement.SetSoID                       (const Value: Integer   ); begin SetIntegerField('SoID'                        , Value);end;
procedure T_VS1_Report_Productmovement.SetConverted                  (const Value: Boolean   ); begin SetBooleanField('Converted'                   , Value);end;
procedure T_VS1_Report_Productmovement.SetTransLineID                (const Value: Integer   ); begin SetIntegerField('TransLineID'                 , Value);end;
procedure T_VS1_Report_Productmovement.SetPQATranstype               (const Value: string    ); begin SetStringField('PQATranstype'                , Value);end;
procedure T_VS1_Report_Productmovement.SetAverageCost                (const Value: Double    ); begin SetFloatField('AverageCost'                 , Value);end;
procedure T_VS1_Report_Productmovement.SetCost                       (const Value: Double    ); begin SetFloatField('Cost'                        , Value);end;
procedure T_VS1_Report_Productmovement.SetAvailable                  (const Value: Double    ); begin SetFloatField('Available'                   , Value);end;
procedure T_VS1_Report_Productmovement.SetInStock                    (const Value: Double    ); begin SetFloatField('InStock'                     , Value);end;
procedure T_VS1_Report_Productmovement.Setso                         (const Value: Double    ); begin SetFloatField('so'                          , Value);end;
procedure T_VS1_Report_Productmovement.Setinvbo                      (const Value: Double    ); begin SetFloatField('invbo'                       , Value);end;
procedure T_VS1_Report_Productmovement.Setpobo                       (const Value: Double    ); begin SetFloatField('pobo'                        , Value);end;
procedure T_VS1_Report_Productmovement.Setonbuild                    (const Value: Double    ); begin SetFloatField('onbuild'                     , Value);end;
procedure T_VS1_Report_Productmovement.Setbuilding                   (const Value: Double    ); begin SetFloatField('building'                    , Value);end;
procedure T_VS1_Report_Productmovement.SetAlloctype                  (const Value: string    ); begin SetStringField('Alloctype'                   , Value);end;
procedure T_VS1_Report_Productmovement.SetPrice                      (const Value: Double    ); begin SetFloatField('Price'                       , Value);end;
procedure T_VS1_Report_Productmovement.SetTotalPrice                 (const Value: Double    ); begin SetFloatField('TotalPrice'                  , Value);end;
procedure T_VS1_Report_Productmovement.SetStSID                      (const Value: Integer   ); begin SetIntegerField('StSID'                       , Value);end;
procedure T_VS1_Report_Productmovement.SetExtraDesc                  (const Value: string    ); begin SetStringField('ExtraDesc'                   , Value);end;
procedure T_VS1_Report_Productmovement.SetcTranstype                 (const Value: string    ); begin SetStringField('cTranstype'                  , Value);end;
*)

initialization
  RegisterClass(T_VS1_Report_Productmovement);


end.

