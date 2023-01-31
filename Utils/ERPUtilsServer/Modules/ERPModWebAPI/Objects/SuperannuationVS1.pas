unit SuperannuationVS1;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tsuperannuation_vs1 = class(TMSBusObj)
  private
    function GetSuperannuationType                 : string    ;
    function GetSuperannuationName                 : string    ;
    function GetSuperannuationSpin                 : string    ;
    function GetSuperannuationsUsi                 : string    ;
    function GetSuperannuationsAutoMigratedFund    : Boolean   ;
    function GetSuperannuationActive               : Boolean   ;
    procedure SetSuperannuationType                 (const Value: string    );
    procedure SetSuperannuationName                 (const Value: string    );
    procedure SetSuperannuationSpin                 (const Value: string    );
    procedure SetSuperannuationsUsi                 (const Value: string    );
    procedure SetSuperannuationsAutoMigratedFund    (const Value: Boolean   );
    procedure SetSuperannuationActive               (const Value: Boolean   );
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
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
  published
    property SuperannuationType                  :string      read GetSuperannuationType                write SetSuperannuationType             ;
    property SuperannuationName                  :string      read GetSuperannuationName                write SetSuperannuationName             ;
    property SuperannuationSpin                  :string      read GetSuperannuationSpin                write SetSuperannuationSpin             ;
    property SuperannuationsUsi                  :string      read GetSuperannuationsUsi                write SetSuperannuationsUsi             ;
    property SuperannuationsAutoMigratedFund     :Boolean     read GetSuperannuationsAutoMigratedFund   write SetSuperannuationsAutoMigratedFund;
    property SuperannuationActive                :Boolean     read GetSuperannuationActive              write SetSuperannuationActive           ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tsuperannuation_vs1}

constructor Tsuperannuation_vs1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'superannuation_vs1';
  fSQL := 'SELECT * FROM tblsuperannuation_vs1';
end;


destructor Tsuperannuation_vs1.Destroy;
begin
  inherited;
end;


procedure Tsuperannuation_vs1.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'SuperannuationType');
  SetPropertyFromNode(node,'SuperannuationName');
  SetPropertyFromNode(node,'SuperannuationSpin');
  SetPropertyFromNode(node,'SuperannuationsUsi');
  SetBooleanPropertyFromNode(node,'SuperannuationsAutoMigratedFund');
  SetBooleanPropertyFromNode(node,'SuperannuationActive');
end;


procedure Tsuperannuation_vs1.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'SuperannuationType' ,SuperannuationType);
  AddXMLNode(node,'SuperannuationName' ,SuperannuationName);
  AddXMLNode(node,'SuperannuationSpin' ,SuperannuationSpin);
  AddXMLNode(node,'SuperannuationsUsi' ,SuperannuationsUsi);
  AddXMLNode(node,'SuperannuationsAutoMigratedFund' ,SuperannuationsAutoMigratedFund);
  AddXMLNode(node,'SuperannuationActive' ,SuperannuationActive);
end;


function Tsuperannuation_vs1.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tsuperannuation_vs1.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tsuperannuation_vs1.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tsuperannuation_vs1.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tsuperannuation_vs1.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tsuperannuation_vs1.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tsuperannuation_vs1.GetBusObjectTablename: string;
begin
  Result:= 'tblsuperannuation_vs1';
end;


function Tsuperannuation_vs1.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tsuperannuation_vs1.GetSuperannuationType             : string    ; begin Result := GetStringField('SuperannuationType');end;
function  Tsuperannuation_vs1.GetSuperannuationName             : string    ; begin Result := GetStringField('SuperannuationName');end;
function  Tsuperannuation_vs1.GetSuperannuationSpin             : string    ; begin Result := GetStringField('SuperannuationSpin');end;
function  Tsuperannuation_vs1.GetSuperannuationsUsi             : string    ; begin Result := GetStringField('SuperannuationsUsi');end;
function  Tsuperannuation_vs1.GetSuperannuationsAutoMigratedFund: Boolean   ; begin Result := GetBooleanField('SuperannuationsAutoMigratedFund');end;
function  Tsuperannuation_vs1.GetSuperannuationActive           : Boolean   ; begin Result := GetBooleanField('SuperannuationActive');end;
procedure Tsuperannuation_vs1.SetSuperannuationType             (const Value: string    ); begin SetStringField('SuperannuationType'              , Value);end;
procedure Tsuperannuation_vs1.SetSuperannuationName             (const Value: string    ); begin SetStringField('SuperannuationName'              , Value);end;
procedure Tsuperannuation_vs1.SetSuperannuationSpin             (const Value: string    ); begin SetStringField('SuperannuationSpin'              , Value);end;
procedure Tsuperannuation_vs1.SetSuperannuationsUsi             (const Value: string    ); begin SetStringField('SuperannuationsUsi'              , Value);end;
procedure Tsuperannuation_vs1.SetSuperannuationsAutoMigratedFund(const Value: Boolean   ); begin SetBooleanField('SuperannuationsAutoMigratedFund' , Value);end;
procedure Tsuperannuation_vs1.SetSuperannuationActive           (const Value: Boolean   ); begin SetBooleanField('SuperannuationActive'            , Value);end;


initialization
  RegisterClass(Tsuperannuation_vs1);


end.
