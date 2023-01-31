unit BusobjWalmartCommon;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  04/01/19  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TWalmartShippingMethods = class(TMSBusObj)
  private
    function GetFedEx                : Boolean   ;
    function GetUPS                  : Boolean   ;
    function GetUSPS                 : Boolean   ;
    function GetCanadaPost           : Boolean   ;
    function GetUSPSEndicia          : Boolean   ;
    function GetWalmartMethodcode    : string    ;
    function GetActive               : Boolean   ;
    function GetmsUpdateStiteCode    : string    ;
    procedure SetFedEx                (const Value: Boolean   );
    procedure SetUPS                  (const Value: Boolean   );
    procedure SetUSPS                 (const Value: Boolean   );
    procedure SetCanadaPost           (const Value: Boolean   );
    procedure SetUSPSEndicia          (const Value: Boolean   );
    procedure SetWalmartMethodcode    (const Value: string    );
    procedure SetActive               (const Value: Boolean   );
    procedure SetmsUpdateStiteCode    (const Value: string    );
  protected
    function GetName                 : TComponentName;
    procedure SetName                 (const Value: TComponentName); override;
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoBeforeOpen(Sender :TDatasetBusObj ):Boolean;            override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    procedure RePopulateit;
    procedure DoFieldOnChange(Sender: TField);                          override;
  published
//    property Name                  :string      read GetName                write SetName             ;
    property FedEx                 :Boolean     read GetFedEx               write SetFedEx            ;
    property UPS                   :Boolean     read GetUPS                 write SetUPS              ;
    property USPS                  :Boolean     read GetUSPS                write SetUSPS             ;
    property CanadaPost            :Boolean     read GetCanadaPost          write SetCanadaPost       ;
    property USPSEndicia           :Boolean     read GetUSPSEndicia         write SetUSPSEndicia      ;
    property WalmartMethodcode     :string      read GetWalmartMethodcode   write SetWalmartMethodcode;
    property Active                :Boolean     read GetActive              write SetActive           ;
    property msUpdateStiteCode     :string      read GetmsUpdateStiteCode   write SetmsUpdateStiteCode;
  end;


implementation


uses sysutils,ERPdbComponents, tcDataUtils, CommonLib, ShipIntegrationTypes, DbSharedObjectsObj,
  CommonDbLib, tcConst;



  {TWalmartShippingMethods}

constructor TWalmartShippingMethods.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'WalmartShippingMethods';
  fSQL := 'SELECT * FROM tblwalmartshippingmethods';
end;


destructor TWalmartShippingMethods.Destroy;
begin
  inherited;
end;


procedure TWalmartShippingMethods.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Name');
  SetBooleanPropertyFromNode(node,'FedEx');
  SetBooleanPropertyFromNode(node,'UPS');
  SetBooleanPropertyFromNode(node,'USPS');
  SetBooleanPropertyFromNode(node,'CanadaPost');
  SetBooleanPropertyFromNode(node,'USPSEndicia');
  SetPropertyFromNode(node,'WalmartMethodcode');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'msUpdateStiteCode');
end;


procedure TWalmartShippingMethods.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Name' ,Name);
  AddXMLNode(node,'FedEx' ,FedEx);
  AddXMLNode(node,'UPS' ,UPS);
  AddXMLNode(node,'USPS' ,USPS);
  AddXMLNode(node,'CanadaPost' ,CanadaPost);
  AddXMLNode(node,'USPSEndicia' ,USPSEndicia);
  AddXMLNode(node,'WalmartMethodcode' ,WalmartMethodcode);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'msUpdateStiteCode' ,msUpdateStiteCode);
end;


function TWalmartShippingMethods.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TWalmartShippingMethods.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TWalmartShippingMethods.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TWalmartShippingMethods.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TWalmartShippingMethods.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TWalmartShippingMethods.GetIDField: string;
begin
  Result := 'ID'
end;


class function TWalmartShippingMethods.GetBusObjectTablename: string;
begin
  Result:= 'tblwalmartshippingmethods';
end;


function TWalmartShippingMethods.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


function TWalmartShippingMethods.DoBeforeOpen(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforeOpen(Sender);
  if not result then exit;
end;
Procedure TWalmartShippingMethods.RePopulateit;
var
  x:Integer;
  scr :TERPScript;
begin
  scr := DbSharedObj.GetScript(commondblib.GetSharedMyDacConnection);
  try
    scr.sql.clear;
    scr.sql.add('update tblwalmartshippingmethods Set Active ="F";');
    showProgress(WAITMSG, High(ShipServiceTypeList) );
    try
      for x := Low(ShipServiceTypeList) to High(ShipServiceTypeList) do begin
        scr.sql.add('insert ignore into tblwalmartshippingmethods  '+
                ' Set Name = '  +Quotedstr(ShipServiceTypeList[x].name)+','+
                ' FedEx ='      + iif( ppFedEx      in ShipServiceTypeList[x].Providers , quotedstr('T') , quotedstr('F')) +',' +
                ' UPS ='        + iif( ppUPS        in ShipServiceTypeList[x].Providers , quotedstr('T') , quotedstr('F')) +',' +
                ' USPS ='       + iif( ppUSPS       in ShipServiceTypeList[x].Providers , quotedstr('T') , quotedstr('F')) +',' +
                ' CanadaPost = '+ iif( ppCanadaPost in ShipServiceTypeList[x].Providers , quotedstr('T') , quotedstr('F')) +',' +
                ' USPSEndicia= '+ quotedstr('F')+',' +
                ' WalmartMethodcode =' + quotedstr('Standard')+',' +
                ' Active = ' + quotedstr('T')+' ON DUPLICATE KEY UPDATE Active = ' + quotedstr('T')+';');
        stepProgress;
      end;
    finally
      HideProgress;
    end;
(*    showProgress(WAITMSG, scr.SQL.count);
    try
      scr.Execute;
    finally
      HideProgress;
    end;*)
    ExecuteWithProgressbar(scr , 'Checking for Walmart Shipping Methods');
  finally
    DbSharedObj.ReleaseObj(scr);
  end;
end;

{Property Functions}
function  TWalmartShippingMethods.GetName             : TComponentName    ; begin Result := GetStringField('Name');end;
function  TWalmartShippingMethods.GetFedEx            : Boolean   ; begin Result := GetBooleanField('FedEx');end;
function  TWalmartShippingMethods.GetUPS              : Boolean   ; begin Result := GetBooleanField('UPS');end;
function  TWalmartShippingMethods.GetUSPS             : Boolean   ; begin Result := GetBooleanField('USPS');end;
function  TWalmartShippingMethods.GetCanadaPost       : Boolean   ; begin Result := GetBooleanField('CanadaPost');end;
function  TWalmartShippingMethods.GetUSPSEndicia      : Boolean   ; begin Result := GetBooleanField('USPSEndicia');end;
function  TWalmartShippingMethods.GetWalmartMethodcode: string    ; begin Result := GetStringField('WalmartMethodcode');end;
function  TWalmartShippingMethods.GetActive           : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TWalmartShippingMethods.GetmsUpdateStiteCode: string    ; begin Result := GetStringField('msUpdateStiteCode');end;
procedure TWalmartShippingMethods.SetName             (const Value: TComponentName    ); begin SetStringField('Name'              , Value);end;
procedure TWalmartShippingMethods.SetFedEx            (const Value: Boolean   ); begin SetBooleanField('FedEx'             , Value);end;
procedure TWalmartShippingMethods.SetUPS              (const Value: Boolean   ); begin SetBooleanField('UPS'               , Value);end;
procedure TWalmartShippingMethods.SetUSPS             (const Value: Boolean   ); begin SetBooleanField('USPS'              , Value);end;
procedure TWalmartShippingMethods.SetCanadaPost       (const Value: Boolean   ); begin SetBooleanField('CanadaPost'        , Value);end;
procedure TWalmartShippingMethods.SetUSPSEndicia      (const Value: Boolean   ); begin SetBooleanField('USPSEndicia'       , Value);end;
procedure TWalmartShippingMethods.SetWalmartMethodcode(const Value: string    ); begin SetStringField('WalmartMethodcode' , Value);end;
procedure TWalmartShippingMethods.SetActive           (const Value: Boolean   ); begin SetBooleanField('Active'            , Value);end;
procedure TWalmartShippingMethods.SetmsUpdateStiteCode(const Value: string    ); begin SetStringField('msUpdateStiteCode' , Value);end;



initialization
  RegisterClass(TWalmartShippingMethods);


end.
