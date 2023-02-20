unit BusObjBankReconciliationRules;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  09/07/22  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TBankReconciliationRules = class(TMSBusObj)
  private
    function GetStatementDesc       : string    ;
    function GetActive              : Boolean   ;
    function GetPayee               : string    ;
    procedure SetStatementDesc       (const Value: string    );
    procedure SetActive              (const Value: Boolean   );
    procedure SetPayee               (const Value: string    );

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
    property StatementDesc        :string      read GetStatementDesc      write SetStatementDesc   ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    property Payee                :string      read GetPayee              write SetPayee           ;
  end;


implementation


uses tcDataUtils, CommonLib;



  {TBankReconciliationRules}

constructor TBankReconciliationRules.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'bankreconciliationrules';
  fSQL := 'SELECT * FROM tblbankreconciliationrules';
end;


destructor TBankReconciliationRules.Destroy;
begin
  inherited;
end;


procedure TBankReconciliationRules.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'StatementDesc');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'Payee');
end;


procedure TBankReconciliationRules.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'StatementDesc' ,StatementDesc);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Payee' ,Payee);
end;


function TBankReconciliationRules.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TBankReconciliationRules.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TBankReconciliationRules.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TBankReconciliationRules.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TBankReconciliationRules.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TBankReconciliationRules.GetIDField: string;
begin
  Result := 'ID'
end;


class function TBankReconciliationRules.GetBusObjectTablename: string;
begin
  Result:= 'tblbankreconciliationrules';
end;


function TBankReconciliationRules.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TBankReconciliationRules.GetStatementDesc   : string    ; begin Result := GetStringField('StatementDesc');end;
function  TBankReconciliationRules.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TBankReconciliationRules.GetPayee           : string    ; begin Result := GetStringField('Payee');end;
procedure TBankReconciliationRules.SetStatementDesc   (const Value: string    ); begin SetStringField('StatementDesc'    , Value);end;
procedure TBankReconciliationRules.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
procedure TBankReconciliationRules.SetPayee           (const Value: string    ); begin SetStringField('Payee'            , Value);end;


initialization
  RegisterClass(TBankReconciliationRules);


end.
