unit BusObjSalesLinesPoints;

interface

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type

  TSalesLinesPoints = class(TMSBusObj)
  private
    function GetSaleID                : Integer   ;
    function GetSaleLineID            : Integer   ;
    function GetLinePoints            : Double    ;
    function GetLineValue             : Double    ;
    function GetPointExpiresOn        : TDateTime ;
    function GetActive                : Boolean   ;
    function GetclientID              : Integer   ;
    procedure SetSaleID                (const Value: Integer   );
    procedure SetSaleLineID            (const Value: Integer   );
    procedure SetLinePoints            (const Value: Double    );
    procedure SetLineValue             (const Value: Double    );
    procedure SetPointExpiresOn        (const Value: TDateTime );
    procedure SetActive                (const Value: Boolean   );
    procedure SetclientID              (const Value: Integer   );
    function getRewardPointID: Integer;
    procedure setRewardPointID(const Value: Integer);
    function getPointsUOMID: Integer;
    function getPointsUOMMultiplier: double;
    procedure setPointsUOMID(const Value: Integer);
    procedure setPointsUOMMultiplier(const Value: double);
    function GetProductID: Integer;
    function getProductName: String;
    procedure SetProductID(const Value: Integer);
    procedure setProductName(const Value: String);
    function getValueforRewardPoint: Double;
    procedure setValueforRewardPoint(const Value: Double);
    function getExpiresOnNoOfMonthsAfterPurchase: Integer;
    procedure setExpiresOnNoOfMonthsAfterPurchase(const Value: Integer);
    function getIsOpeningBalance: boolean;
    procedure setIsOpeningBalance(const Value: boolean);
    function getOpeningBalanceAsOn: TDateTime;
    procedure setOpeningBalanceAsOn(const Value: TDateTime);
    function getDeptId: Integer;
    function getDeptName: String;
    procedure SetDeptId(const Value: Integer);
    procedure setDeptName(const Value: String);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    procedure DoFieldOnChange(Sender: TField);                          override;
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function Delete: boolean; overload; override;
  published
    property SaleID                 :Integer     read GetSaleID               write SetSaleID            ;
    property SaleLineID             :Integer     read GetSaleLineID           write SetSaleLineID        ;
    property LinePoints             :Double      read GetLinePoints           write SetLinePoints        ;
    property LineValue              :Double      read GetLineValue            write SetLineValue         ;
    property PointExpiresOn         :TDateTime   read GetPointExpiresOn       write SetPointExpiresOn    ;
    Property ExpiresOnNoOfMonthsAfterPurchase :Integer read getExpiresOnNoOfMonthsAfterPurchase Write setExpiresOnNoOfMonthsAfterPurchase;
    property Active                 :Boolean     read GetActive               write SetActive            ;
    property ClientID               :Integer     read GetclientID             write SetclientID          ;
    Property RewardPointID          :Integer     Read getRewardPointID        Write setRewardPointID;
    Property PointsUOMID            :Integer     Read getPointsUOMID          Write setPointsUOMID;
    Property PointsUOMMultiplier    :double      read getPointsUOMMultiplier  Write setPointsUOMMultiplier;
    Property ValueforRewardPoint    :Double      read getValueforRewardPoint  Write setValueforRewardPoint;
    Property ProductId              :Integer     Read GetProductID            Write SetProductID;
    Property ProductName            :String      Read getProductName          Write setProductName;
    Property IsOpeningBalance       :boolean     Read getIsOpeningBalance     Write setIsOpeningBalance;
    Property OpeningBalanceAsOn     :TDateTime   Read getOpeningBalanceAsOn   Write setOpeningBalanceAsOn;
    Property DeptId                 :Integer     Read getDeptId               Write SetDeptId;
    Property DeptName               :String      Read getDeptName             Write setDeptName; 
  end;


implementation

uses
  BusObjSalesRedeemPoints, sysutils, AppEnvironment, BusObjClass,
  BusObjSaleBase, BusObjClient;

{TSalesLinesPoints}

constructor TSalesLinesPoints.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SalesLinesPoints';
  fSQL := 'SELECT * FROM tblsaleslinespoints';
end;


destructor TSalesLinesPoints.Destroy;
begin
  inherited;
end;


procedure TSalesLinesPoints.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SaleID');
  SetPropertyFromNode(node,'DeptID');
  SetPropertyFromNode(node,'DeptName');
  SetPropertyFromNode(node,'SaleLineID');
  SetPropertyFromNode(node,'LinePoints');
  SetPropertyFromNode(node,'LineValue');
  SetDateTimePropertyFromNode(node,'PointExpiresOn');
  SetDateTimePropertyFromNode(node,'OpeningBalanceAsOn');
  SetPropertyFromNode(node, 'ExpiresOnNoOfMonthsAfterPurchase');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'IsOpeningBalance');
  SetPropertyFromNode(node,'clientID');
  SetPropertyFromNode(node,'PointsUOMID');
  SetPropertyFromNode(node,'PointsUOMMultiplier');
  SetPropertyfromnode(node, 'ValueforRewardPoint');
  SetPropertyFromNode(node, 'RewardPointID');
end;


procedure TSalesLinesPoints.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SaleID' ,SaleID);
  AddXMLNode(node,'deptID' ,DeptId);
  AddXMLNode(node,'DeptName' ,DeptName);
  AddXMLNode(node,'SaleLineID' ,SaleLineID);
  AddXMLNode(node,'LinePoints' ,LinePoints);
  AddXMLNode(node,'PointsUOMMultiplier' ,PointsUOMMultiplier);
  AddXMLNode(node, 'ValueforRewardPoint' , ValueforRewardPoint);
  AddXMLNode(node,'LineValue' ,LineValue);
  AddXMLNode(node,'PointExpiresOn' ,PointExpiresOn);
  AddXMLNode(node,'OpeningBalanceAsOn' ,OpeningBalanceAsOn);
  AddXMLNode(node, 'ExpiresOnNoOfMonthsAfterPurchase' , ExpiresOnNoOfMonthsAfterPurchase);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'IsOpeningBalance' ,IsOpeningBalance);
  AddXMLNode(node,'clientID' ,clientID);
  AddXMLNode(node,'PointsUOMID' ,PointsUOMID);
  AddXMLNode(node, 'RewardPointID' , RewardPointID);
end;


function TSalesLinesPoints.ValidateData: Boolean ;
var
  RedeemendPoints: double;
begin
  Result := False;
//  Resultstatus.Clear;
  if clientID = 0 then begin
    AddResult(False , rssError , 0,  'Client should not be 0' , False );
    Exit;
  end;
  if IsOpeningBalance then begin
    if OpeningBalanceAsOn = 0 then begin
      AddResult(False , rssError , 0,  'Opening balance should have a date' , False );
      Exit;
    end;
    RedeemendPoints:= TSalesRedeemPoints.OpeneningBalanceRedeemedPoints(ClientID,Connection.Connection);
    if (LinePoints < RedeemendPoints) then begin
      AddResult(False , rssError , 0,
        'Opening balance points of ' + FloatToStr(LinePoints) +
        ' can not be less than the opening balance points already redeemed of ' +
        FloatToStr(RedeemendPoints), False );
      Exit;
    end;
  end else begin
    if SaleID = 0 then begin
      AddResult(False , rssError , 0,  'SaleID should not be 0' , False );
      Exit;
    end;
    if SaleLineID = 0 then begin
      AddResult(False , rssError , 0,  'SaleLineID should not be 0' , False );
      Exit;
    end;
    if LineValue = 0 then begin
      AddResult(False , rssError , 0,  'LineValue should not be 0' , False );
      Exit;
    end;
    if LinePoints = 0 then begin
      AddResult(False , rssError , 0,  'LinePoints should not be 0' , False );
      Exit;
    end;
  end;
  if DeptId = 0 then begin
      AddResult(False , rssError , 0,  appenv.DefaultClass.ClassHeading+  ' should not be blank' , False );
      Exit;
  end;
  Result := True;
end;


function TSalesLinesPoints.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSalesLinesPoints.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSalesLinesPoints.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if Sysutils.SameText(Sender.fieldname , 'IsOpeningBalance' ) then begin
        if OpeningBalanceAsOn = 0 then OpeningBalanceAsOn := Date;
        if DeptId = 0 then begin
            DeptId := appenv.DefaultClass.ClassID;
            DoFieldOnChange(dataset.findfield('deptID'));
        end;
    end else if Sysutils.SameText(Sender.Fieldname , 'DeptId') then begin
      deptName := TDeptClass.IDToggle(DeptID);
    end else if Sysutils.SameText(Sender.Fieldname , 'DeptName') then begin
      DeptId := TDeptClass.IDToggle(DeptName);
    end;
end;


function TSalesLinesPoints.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TSalesLinesPoints.GetIDField: string;
begin
  Result := 'SalesLinesPointsId'
end;


class function TSalesLinesPoints.GetBusObjectTablename: string;
begin
  Result:= 'tblsaleslinespoints';
end;


function TSalesLinesPoints.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TSalesLinesPoints.GetSaleID             : Integer   ; begin Result := GetIntegerField('SaleID');end;
function  TSalesLinesPoints.GetSaleLineID         : Integer   ; begin Result := GetIntegerField('SaleLineID');end;
function  TSalesLinesPoints.GetLinePoints         : Double    ; begin Result := GetFloatField('LinePoints');end;
function  TSalesLinesPoints.GetLineValue          : Double    ; begin Result := GetFloatField('LineValue');end;
function  TSalesLinesPoints.GetPointExpiresOn     : TDateTime ; begin Result := GetDateTimeField('PointExpiresOn');end;
function  TSalesLinesPoints.GetActive             : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TSalesLinesPoints.GetclientID           : Integer   ; begin Result := GetIntegerField('clientID');end;
function  TSalesLinesPoints.getPointsUOMID        : Integer   ; begin   REsult := GetIntegerField('PointsUOMID');end;
function  TSalesLinesPoints.getPointsUOMMultiplier: double    ; begin   Result := GetFloatField('PointsUOMMultiplier');end;
function  TSalesLinesPoints.getRewardPointID      : Integer   ; begin result := GetIntegerField('RewardPointID');end;

procedure TSalesLinesPoints.SetSaleID             (const Value: Integer   ); begin SetIntegerField('SaleID'             , Value);end;
procedure TSalesLinesPoints.SetSaleLineID         (const Value: Integer   ); begin SetIntegerField('SaleLineID'         , Value);end;
procedure TSalesLinesPoints.SetLinePoints         (const Value: Double    ); begin SetFloatField('LinePoints'         , Value);end;
procedure TSalesLinesPoints.SetLineValue          (const Value: Double    ); begin SetFloatField('LineValue'          , Value);end;
procedure TSalesLinesPoints.SetPointExpiresOn     (const Value: TDateTime ); begin SetDateTimeField('PointExpiresOn'     , Value);end;
procedure TSalesLinesPoints.SetActive             (const Value: Boolean   ); begin SetBooleanField('Active'             , Value);end;
procedure TSalesLinesPoints.SetclientID           (const Value: Integer   ); begin SetIntegerField('clientID'           , Value);end;
procedure TSalesLinesPoints.setRewardPointID      (const Value: Integer   ); begin SetIntegerField('RewardPointID' , Value);end;
procedure TSalesLinesPoints.setPointsUOMID        (const Value: Integer   ); begin   SetIntegerField('PointsUOMID' , Value);end;
procedure TSalesLinesPoints.setPointsUOMMultiplier(const Value: double    ); begin   setFloatField('PointsUOMMultiplier' , value);end;


function TSalesLinesPoints.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;

  if assigned(Owner) then begin
    if Self.Owner is TSalesBase then begin
      ClientID :=TSalesBase(Owner).CustomerID;
      SaleID := TSalesBase(Owner).ID;
    end
    else if Self.Owner is TClient then begin
      IsOpeningBalance:= true;
      ClientID:= TClient(Owner).ID;
      DeptId:= TClient(Owner).DefaultClass.ID;
      DeptName:= TClient(Owner).DefaultClass.DeptClassName;
      Active:= true;
      ValueforRewardPoint:= appenv.CompanyPrefs.ValueforRewardPoints;
    end;
  end;
  Active := True;
end;


function TSalesLinesPoints.GetProductID: Integer;begin  result := GetIntegerField('ProductId');end;
function TSalesLinesPoints.getProductName: String;begin   Result := GetStringField('ProductName');end;
procedure TSalesLinesPoints.SetProductID(const Value: Integer);begin  SetIntegerField('ProductId' , value);end;
procedure TSalesLinesPoints.setProductName(const Value: String);begin  SetStringField('Productname' , Value);end;

function TSalesLinesPoints.getValueforRewardPoint: Double;
begin
  result := getfloatfield('ValueforRewardPoint');
end;

procedure TSalesLinesPoints.setValueforRewardPoint(const Value: Double);
begin
  SetFloatfield('ValueforRewardPoint' , Value);
end;


function TSalesLinesPoints.getExpiresOnNoOfMonthsAfterPurchase: Integer;
begin
  REsult := GetIntegerField('ExpiresOnNoOfMonthsAfterPurchase');
end;

procedure TSalesLinesPoints.setExpiresOnNoOfMonthsAfterPurchase(
  const Value: Integer);
begin
  SetIntegerField('ExpiresOnNoOfMonthsAfterPurchase' , Value);
end;

function TSalesLinesPoints.getIsOpeningBalance: boolean;
begin
  Result := GetBooleanField('IsOpeningBalance');
end;

procedure TSalesLinesPoints.setIsOpeningBalance(const Value: boolean);
begin
  SetBooleanField('IsOpeningBalance' , Value);
end;

function TSalesLinesPoints.getOpeningBalanceAsOn: TDateTime;
begin
  Result := GetDateTimeField('OpeningBalanceAsOn');
end;

procedure TSalesLinesPoints.setOpeningBalanceAsOn(const Value: TDateTime);
begin
  SetDateTimeField('OpeningBalanceAsOn' , Value);
end;

function TSalesLinesPoints.getDeptId: Integer;
begin
  REsult := GetIntegerField('DeptID');
end;

function TSalesLinesPoints.getDeptName: String;
begin
  Result := getStringfield('DeptName');
end;

procedure TSalesLinesPoints.SetDeptId(const Value: Integer);
begin
  SetIntegerField('deptID', value);
end;

procedure TSalesLinesPoints.setDeptName(const Value: String);
begin
  SetStringfield('DeptName' , Value);
end;

function TSalesLinesPoints.Delete: boolean;
var
  RedeemendPoints: double;
begin
  if Count > 0 then begin
    if IsOpeningBalance then begin
      RedeemendPoints:= TSalesRedeemPoints.OpeneningBalanceRedeemedPoints(ClientID,Connection.Connection);
      if (RedeemendPoints > 0) then begin
        result:= false;
        AddResult(False , rssError , 0,
          'Can not delete this Reward Points Opening Balance recored as some points have already been redeemed (' +
          FloatToStr(RedeemendPoints) + ')', False );
        Exit;
      end;
    end;
  end;
  result:= inherited delete;
end;

initialization
  RegisterClass(TSalesLinesPoints);

end.
