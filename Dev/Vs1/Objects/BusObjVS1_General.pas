unit BusObjVS1_General;

interface

uses BusObjStock, BusObjClient,  BusObjGLAccount,   BusObjTaxCodes ,  BusObjCommon , BusobjPaymethods , BusObjBase , classes;

Type

  TProductVS1 = class(TProduct)
  Protected
    Function DoAfterInsert(Sender :TDatasetBusObj ): Boolean; override;
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TCustomerVS1 = class(TCustomer)
  Protected
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TJobVS1 = class(TJob)
  Protected
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TSupplierVS1 = class(TSupplier)
  Protected
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TOtherContactVS1 = class(TOtherContact)
  Protected
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TProspectVS1 = class(TProspect)
  Protected
    Function  DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TAccountVS1 = class(TAccount)
  Protected
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TTaxcodeVS1 = class(TTaxcode)
  Protected
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TTermsVS1 = class(TTerms)
  Protected
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TPaymentMethodVS1 = class(TPaymentMethod)
  Protected
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
  Public
    constructor Create(AOwner: TComponent); override;
  end;

  TSupplierEx = class(TSupplierVS1)
  Published
    property Attachments;
  Public
  end;

  TCustomerEx = class(TCustomerVS1)
  Published
    property Attachments;
  Public
  end;

  TJobEx = class(TJobVS1)
  Published
    property Attachments;
  Public
  end;

  TProspectEx = class(TProspectVS1)
  Published
    property Attachments;
  Public
  end;

Procedure AddPublishOnVS1condition(var fSQL:String);

implementation

uses CommonLib , SysUtils;

Procedure AddPublishOnVS1condition(var fSQL:String);
begin
  if POS(uppercase('WHERE'), uppercase(fSQL)) <> 0 then
    fSQL := fSQL + ' AND '
  else
    fSQL := fSQL + ' WHERE ';

  fSQL := fSQL + ' PublishOnVS1="T" ';
end;

{ TProductVS1 }
constructor TProductVS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddPublishOnVS1condition(fSQL);
end;

function TProductVS1.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  PublishOnVS1 := True;
end;

{ TCustomerVS1 }
constructor TCustomerVS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddPublishOnVS1condition(fSQL);
end;

function TCustomerVS1.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  PublishOnVS1 := True;
end;

{ TJobVS1 }
constructor TJobVS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddPublishOnVS1condition(fSQL);
end;

function TJobVS1.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  PublishOnVS1 := True;
end;

{ TSupplierVS1 }
constructor TSupplierVS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddPublishOnVS1condition(fSQL);
end;

function TSupplierVS1.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  PublishOnVS1 := True;
end;

{ TOtherContactVS1 }
constructor TOtherContactVS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddPublishOnVS1condition(fSQL);
end;

function TOtherContactVS1.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  PublishOnVS1 := True;
end;

{ TProspectVS1 }
constructor TProspectVS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddPublishOnVS1condition(fSQL);
end;

function TProspectVS1.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  PublishOnVS1 := True;
end;

{ TAccountVS1 }
constructor TAccountVS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddPublishOnVS1condition(fSQL);
end;

function TAccountVS1.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  PublishOnVS1 := True;
end;
{ TTaxcodeVS1 }
constructor TTaxcodeVS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddPublishOnVS1condition(fSQL);
end;

function TTaxcodeVS1.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  PublishOnVS1 := True;
end;
{ TTermsVS1 }
constructor TTermsVS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddPublishOnVS1condition(fSQL);
end;

function TTermsVS1.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  PublishOnVS1 := True;
end;
{ TPaymentMethodVS1 }
constructor TPaymentMethodVS1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AddPublishOnVS1condition(fSQL);
end;

function TPaymentMethodVS1.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  PublishOnVS1 := True;
end;


initialization
  RegisterClassOnce(TProductVS1);
  RegisterClassOnce(TCustomerVS1);
  RegisterClassOnce(TJobVS1);
  RegisterClassOnce(TSupplierVS1);
  RegisterClassOnce(TOtherContactVS1);
  RegisterClassOnce(TProspectVS1);

  RegisterClassOnce(TCustomerEx);
  RegisterClassOnce(TJobEx);
  RegisterClassOnce(TSupplierEx);
  RegisterClassOnce(TProspectEx);
  RegisterClassOnce(TProspectEx);

  RegisterClassOnce(TAccountVS1);
  RegisterClassOnce(TTaxcodeVS1);
  RegisterClassOnce(TTermsVS1);
  RegisterClassOnce(TPaymentMethodVS1);

end.
