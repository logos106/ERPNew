unit WorkplaceGiving;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tworkplacegiving = class(TMSBusObj)
  private
    function GetDeductionsWorkplaceGivingName                                  : string    ;
    function GetDeductionsWorkplaceGivingAccount                               : string    ;
    function GetDeductionsWorkplaceGivingReducesPaygWithholding                : Boolean   ;
    function GetDeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont    : Boolean   ;
    function GetDeductionsWorkplaceGivingExcludedW1onActivityStatement         : Boolean   ;
    function GetDeductionsWorkplaceGivingActive                                : Boolean   ;
    procedure SetDeductionsWorkplaceGivingName                                  (const Value: string    );
    procedure SetDeductionsWorkplaceGivingAccount                               (const Value: string    );
    procedure SetDeductionsWorkplaceGivingReducesPaygWithholding                (const Value: Boolean   );
    procedure SetDeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont    (const Value: Boolean   );
    procedure SetDeductionsWorkplaceGivingExcludedW1onActivityStatement         (const Value: Boolean   );
    procedure SetDeductionsWorkplaceGivingActive                                (const Value: Boolean   );
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
    property DeductionsWorkplaceGivingName                                   :string      read GetDeductionsWorkplaceGivingName                                 write SetDeductionsWorkplaceGivingName                              ;
    property DeductionsWorkplaceGivingAccount                                :string      read GetDeductionsWorkplaceGivingAccount                              write SetDeductionsWorkplaceGivingAccount                           ;
    property DeductionsWorkplaceGivingReducesPaygWithholding                 :Boolean     read GetDeductionsWorkplaceGivingReducesPaygWithholding               write SetDeductionsWorkplaceGivingReducesPaygWithholding            ;
    property DeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont     :Boolean     read GetDeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont   write SetDeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont;
    property DeductionsWorkplaceGivingExcludedW1onActivityStatement          :Boolean     read GetDeductionsWorkplaceGivingExcludedW1onActivityStatement        write SetDeductionsWorkplaceGivingExcludedW1onActivityStatement     ;
    property DeductionsWorkplaceGivingActive                                 :Boolean     read GetDeductionsWorkplaceGivingActive                               write SetDeductionsWorkplaceGivingActive                            ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tworkplacegiving}

constructor Tworkplacegiving.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'workplacegiving';
  fSQL := 'SELECT * FROM tblworkplacegiving';
end;


destructor Tworkplacegiving.Destroy;
begin
  inherited;
end;


procedure Tworkplacegiving.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'DeductionsWorkplaceGivingName');
  SetPropertyFromNode(node,'DeductionsWorkplaceGivingAccount');
  SetBooleanPropertyFromNode(node,'DeductionsWorkplaceGivingReducesPaygWithholding');
  SetBooleanPropertyFromNode(node,'DeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont');
  SetBooleanPropertyFromNode(node,'DeductionsWorkplaceGivingExcludedW1onActivityStatement');
  SetBooleanPropertyFromNode(node,'DeductionsWorkplaceGivingActive');
end;


procedure Tworkplacegiving.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'DeductionsWorkplaceGivingName' ,DeductionsWorkplaceGivingName);
  AddXMLNode(node,'DeductionsWorkplaceGivingAccount' ,DeductionsWorkplaceGivingAccount);
  AddXMLNode(node,'DeductionsWorkplaceGivingReducesPaygWithholding' ,DeductionsWorkplaceGivingReducesPaygWithholding);
  AddXMLNode(node,'DeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont' ,DeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont);
  AddXMLNode(node,'DeductionsWorkplaceGivingExcludedW1onActivityStatement' ,DeductionsWorkplaceGivingExcludedW1onActivityStatement);
  AddXMLNode(node,'DeductionsWorkplaceGivingActive' ,DeductionsWorkplaceGivingActive);
end;


function Tworkplacegiving.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tworkplacegiving.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tworkplacegiving.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tworkplacegiving.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tworkplacegiving.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tworkplacegiving.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tworkplacegiving.GetBusObjectTablename: string;
begin
  Result:= 'tblworkplacegiving';
end;


function Tworkplacegiving.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tworkplacegiving.GetDeductionsWorkplaceGivingName                              : string    ; begin Result := GetStringField('DeductionsWorkplaceGivingName');end;
function  Tworkplacegiving.GetDeductionsWorkplaceGivingAccount                           : string    ; begin Result := GetStringField('DeductionsWorkplaceGivingAccount');end;
function  Tworkplacegiving.GetDeductionsWorkplaceGivingReducesPaygWithholding            : Boolean   ; begin Result := GetBooleanField('DeductionsWorkplaceGivingReducesPaygWithholding');end;
function  Tworkplacegiving.GetDeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont: Boolean   ; begin Result := GetBooleanField('DeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont');end;
function  Tworkplacegiving.GetDeductionsWorkplaceGivingExcludedW1onActivityStatement     : Boolean   ; begin Result := GetBooleanField('DeductionsWorkplaceGivingExcludedW1onActivityStatement');end;
function  Tworkplacegiving.GetDeductionsWorkplaceGivingActive                            : Boolean   ; begin Result := GetBooleanField('DeductionsWorkplaceGivingActive');end;
procedure Tworkplacegiving.SetDeductionsWorkplaceGivingName                              (const Value: string    ); begin SetStringField('DeductionsWorkplaceGivingName'                               , Value);end;
procedure Tworkplacegiving.SetDeductionsWorkplaceGivingAccount                           (const Value: string    ); begin SetStringField('DeductionsWorkplaceGivingAccount'                            , Value);end;
procedure Tworkplacegiving.SetDeductionsWorkplaceGivingReducesPaygWithholding            (const Value: Boolean   ); begin SetBooleanField('DeductionsWorkplaceGivingReducesPaygWithholding'             , Value);end;
procedure Tworkplacegiving.SetDeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont(const Value: Boolean   ); begin SetBooleanField('DeductionsWorkplaceGivingReducesSuperannuationGuaranteeCont' , Value);end;
procedure Tworkplacegiving.SetDeductionsWorkplaceGivingExcludedW1onActivityStatement     (const Value: Boolean   ); begin SetBooleanField('DeductionsWorkplaceGivingExcludedW1onActivityStatement'      , Value);end;
procedure Tworkplacegiving.SetDeductionsWorkplaceGivingActive                            (const Value: Boolean   ); begin SetBooleanField('DeductionsWorkplaceGivingActive'                             , Value);end;


initialization
  RegisterClass(Tworkplacegiving);


end.
