unit UnionAssociationFee;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  02/04/22  1.00.00  AT  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  Tunionassociationfee = class(TMSBusObj)
  private
    function GetUnionAssociationFeeName                                  : string    ;
    function GetUnionAssociationFeeAccount                               : string    ;
    function GetUnionAssociationFeeReducesPaygWithholding                : Boolean   ;
    function GetUnionAssociationFeeReducesSuperannuationGuaranteeCont    : Boolean   ;
    function GetUnionAssociationFeeExcludedW1onActivityStatement         : Boolean   ;
    function GetUnionAssociationFeeActive                                : Boolean   ;
    procedure SetUnionAssociationFeeName                                  (const Value: string    );
    procedure SetUnionAssociationFeeAccount                               (const Value: string    );
    procedure SetUnionAssociationFeeReducesPaygWithholding                (const Value: Boolean   );
    procedure SetUnionAssociationFeeReducesSuperannuationGuaranteeCont    (const Value: Boolean   );
    procedure SetUnionAssociationFeeExcludedW1onActivityStatement         (const Value: Boolean   );
    procedure SetUnionAssociationFeeActive                                (const Value: Boolean   );
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
    property UnionAssociationFeeName                                   :string      read GetUnionAssociationFeeName                                 write SetUnionAssociationFeeName                              ;
    property UnionAssociationFeeAccount                                :string      read GetUnionAssociationFeeAccount                              write SetUnionAssociationFeeAccount                           ;
    property UnionAssociationFeeReducesPaygWithholding                 :Boolean     read GetUnionAssociationFeeReducesPaygWithholding               write SetUnionAssociationFeeReducesPaygWithholding            ;
    property UnionAssociationFeeReducesSuperannuationGuaranteeCont     :Boolean     read GetUnionAssociationFeeReducesSuperannuationGuaranteeCont   write SetUnionAssociationFeeReducesSuperannuationGuaranteeCont;
    property UnionAssociationFeeExcludedW1onActivityStatement          :Boolean     read GetUnionAssociationFeeExcludedW1onActivityStatement        write SetUnionAssociationFeeExcludedW1onActivityStatement     ;
    property UnionAssociationFeeActive                                 :Boolean     read GetUnionAssociationFeeActive                               write SetUnionAssociationFeeActive                            ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {Tunionassociationfee}

constructor Tunionassociationfee.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'unionassociationfee';
  fSQL := 'SELECT * FROM tblunionassociationfee';
end;


destructor Tunionassociationfee.Destroy;
begin
  inherited;
end;


procedure Tunionassociationfee.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'UnionAssociationFeeName');
  SetPropertyFromNode(node,'UnionAssociationFeeAccount');
  SetBooleanPropertyFromNode(node,'UnionAssociationFeeReducesPaygWithholding');
  SetBooleanPropertyFromNode(node,'UnionAssociationFeeReducesSuperannuationGuaranteeCont');
  SetBooleanPropertyFromNode(node,'UnionAssociationFeeExcludedW1onActivityStatement');
  SetBooleanPropertyFromNode(node,'UnionAssociationFeeActive');
end;


procedure Tunionassociationfee.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'UnionAssociationFeeName' ,UnionAssociationFeeName);
  AddXMLNode(node,'UnionAssociationFeeAccount' ,UnionAssociationFeeAccount);
  AddXMLNode(node,'UnionAssociationFeeReducesPaygWithholding' ,UnionAssociationFeeReducesPaygWithholding);
  AddXMLNode(node,'UnionAssociationFeeReducesSuperannuationGuaranteeCont' ,UnionAssociationFeeReducesSuperannuationGuaranteeCont);
  AddXMLNode(node,'UnionAssociationFeeExcludedW1onActivityStatement' ,UnionAssociationFeeExcludedW1onActivityStatement);
  AddXMLNode(node,'UnionAssociationFeeActive' ,UnionAssociationFeeActive);
end;


function Tunionassociationfee.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function Tunionassociationfee.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tunionassociationfee.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tunionassociationfee.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tunionassociationfee.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tunionassociationfee.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tunionassociationfee.GetBusObjectTablename: string;
begin
  Result:= 'tblunionassociationfee';
end;


function Tunionassociationfee.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  Tunionassociationfee.GetUnionAssociationFeeName                              : string    ; begin Result := GetStringField('UnionAssociationFeeName');end;
function  Tunionassociationfee.GetUnionAssociationFeeAccount                           : string    ; begin Result := GetStringField('UnionAssociationFeeAccount');end;
function  Tunionassociationfee.GetUnionAssociationFeeReducesPaygWithholding            : Boolean   ; begin Result := GetBooleanField('UnionAssociationFeeReducesPaygWithholding');end;
function  Tunionassociationfee.GetUnionAssociationFeeReducesSuperannuationGuaranteeCont: Boolean   ; begin Result := GetBooleanField('UnionAssociationFeeReducesSuperannuationGuaranteeCont');end;
function  Tunionassociationfee.GetUnionAssociationFeeExcludedW1onActivityStatement     : Boolean   ; begin Result := GetBooleanField('UnionAssociationFeeExcludedW1onActivityStatement');end;
function  Tunionassociationfee.GetUnionAssociationFeeActive                            : Boolean   ; begin Result := GetBooleanField('UnionAssociationFeeActive');end;
procedure Tunionassociationfee.SetUnionAssociationFeeName                              (const Value: string    ); begin SetStringField('UnionAssociationFeeName'                               , Value);end;
procedure Tunionassociationfee.SetUnionAssociationFeeAccount                           (const Value: string    ); begin SetStringField('UnionAssociationFeeAccount'                            , Value);end;
procedure Tunionassociationfee.SetUnionAssociationFeeReducesPaygWithholding            (const Value: Boolean   ); begin SetBooleanField('UnionAssociationFeeReducesPaygWithholding'             , Value);end;
procedure Tunionassociationfee.SetUnionAssociationFeeReducesSuperannuationGuaranteeCont(const Value: Boolean   ); begin SetBooleanField('UnionAssociationFeeReducesSuperannuationGuaranteeCont' , Value);end;
procedure Tunionassociationfee.SetUnionAssociationFeeExcludedW1onActivityStatement     (const Value: Boolean   ); begin SetBooleanField('UnionAssociationFeeExcludedW1onActivityStatement'      , Value);end;
procedure Tunionassociationfee.SetUnionAssociationFeeActive                            (const Value: Boolean   ); begin SetBooleanField('UnionAssociationFeeActive'                             , Value);end;


initialization
  RegisterClass(Tunionassociationfee);


end.
