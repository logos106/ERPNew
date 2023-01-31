unit BusobjPaymethods;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/11/07  1.00.01  A.  Initial Version.
  }

interface

uses MyAccess,BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TPaymentMethod = class(TMSBusObj)
  private
    Function GetPaymethod       : string    ;
    Function GetIsCreditCard    : Boolean   ;
    Function GetPublishOnVS1    : Boolean   ;
    Function GetActive    : Boolean   ;
    Procedure SetPaymethod      (const Value: string    );
    Procedure SetIsCreditCard    (const Value: Boolean   );
    Procedure SetPublishOnVS1    (const Value: Boolean   );
    Procedure SetActive    (const Value: Boolean   );
  Protected
    Procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    Procedure DoFieldOnChange(Sender: TField);                          override;
    Function  GetSQL                             : string;              override;
    Function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;             override;
  Public
    Class Function  GetIDField                   : string;              override;
    Class Function  GetBusObjectTablename        : string;              override;
    class function GetKeyStringField: string; override;
    Class Procedure AddNewifnotExsist(const paymentmethodname:String; IsCC:Boolean; conn :TCustomMyconnection = nil; doPublishOnVS1:Boolean = False);
    Constructor  Create(AOwner: TComponent);                            override;
    Destructor   Destroy;                                               override;
    Procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    Procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Function     ValidateData: Boolean ;                                override;
    Function     Save: Boolean ;                                        override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  Published
    property PaymentMethodName       :string      read GetPaymethod      write SetPaymethod   ;
    property IsCreditCard     :Boolean     read GetIsCreditCard   write SetIsCreditCard;
    property PublishOnVS1     :Boolean     read GetPublishOnVS1   write SetPublishOnVS1;
    property Active     :Boolean     read GetActive   write SetActive;
  end;

implementation

uses
  ERPdbComponents,CommonLib, DbSharedObjectsObj, CommonDbLib, sysutils;


      {TPaymentMethod}

class procedure TPaymentMethod.AddNewifnotExsist(const paymentmethodname: String; IsCC:Boolean;  conn :TCustomMyconnection = nil; doPublishOnVS1:Boolean = False);
var
   aPaymentMethod :TPaymentMethod;
begin
 aPaymentMethod := TPaymentMethod.CreateWithNewConn(nil, TERPConnection(conn));
 try
   aPaymentMethod.loadselect('NAME =' + quotedstr(paymentmethodname));
   if aPaymentMethod.count =0 then begin
     aPaymentMethod.New;
     aPaymentMethod.PaymentMethodName := paymentmethodname;
     aPaymentMethod.IsCreditCard      := IsCC;
     aPaymentMethod.Active            := true;
     aPaymentMethod.PublishOnVS1      := doPublishOnVS1;
     aPaymentMethod.PostDB;
   end;
 finally
   Freeandnil(aPaymentMethod)
 end;

(*var
  Script :TERPScript;
begin
  if conn = nil then conn := commondbLib.GetSharedMyDacConnection;
  Script := DbSharedObj.GetScript(conn);
  try
    Script.SQL.Add('insert ignore into tblpaymentmethods '+
                    ' Set NAME        ='  + quotedstr(constpaymentmethodname)+',' +
                    '     IsCreditCard= ' + Quotedstr(iif(IsCC,'T','F'))+','+
                    '     Active      = ' + Quotedstr('T')+','+
                    '     PublishOnVS1= ' + Quotedstr(iif(doPublishOnVS1,'T','F'))+';');
    Script.Execute;
  finally
    FreeandNil(script);
  end;*)
end;

Constructor TPaymentMethod.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Paymethod';
  fSQL := 'SELECT * FROM tblpaymentmethods';
end;

Destructor TPaymentMethod.Destroy;
begin
  inherited;
end;

Procedure TPaymentMethod.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PaymentMethodName');
  SetPropertyFromNode(node,'IsCreditCard');
  SetPropertyFromNode(node,'PublishOnVS1');
  SetPropertyFromNode(node,'Active');
end;

Procedure TPaymentMethod.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PaymentMethodName' ,PaymentMethodName);
  AddXMLNode(node,'IsCreditCard' ,IsCreditCard);
  AddXMLNode(node,'PublishOnVS1' ,PublishOnVS1);
  AddXMLNode(node,'Active' ,Active);
end;

Function TPaymentMethod.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if self.PaymentMethodName = '' then begin
    AddResult(False, rssWarning, 0, 'Method Name should not be blank', False);
    Exit;
  end;
  Result := true;
end;

class function TPaymentMethod._Schema: string;
begin
  result:= inherited;
end;

Function TPaymentMethod.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

Procedure TPaymentMethod.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

Procedure TPaymentMethod.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

Function TPaymentMethod.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

Class Function TPaymentMethod.GetIDField: string;
begin
  Result := 'PayMethodID'
end;

Class Function TPaymentMethod.GetBusObjectTablename: string;
begin
  Result:= 'tblpaymentmethods';
end;

function TPaymentMethod.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  if not result then exit;
  PublishOnVS1 := False;
end;

Function TPaymentMethod.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
Function  TPaymentMethod.GetPaymethod   : string    ; begin Result := GetStringField('NAME');end;
Function  TPaymentMethod.GetIsCreditCard: Boolean   ; begin Result := GetBooleanField('IsCreditCard');end;
Function  TPaymentMethod.GetPublishOnVS1: Boolean   ; begin Result := GetBooleanField('PublishOnVS1');end;
Function  TPaymentMethod.GetActive: Boolean   ; begin Result := GetBooleanField('Active');end;
Procedure TPaymentMethod.SetPaymethod   (const Value: string    ); begin SetStringField('NAME'         , Value);end;
Procedure TPaymentMethod.SetIsCreditCard(const Value: Boolean   ); begin SetBooleanField('IsCreditCard', Value);end;
Procedure TPaymentMethod.SetPublishOnVS1(const Value: Boolean   ); begin SetBooleanField('PublishOnVS1', Value);end;
Procedure TPaymentMethod.SetActive(const Value: Boolean   ); begin SetBooleanField('Active', Value);end;


class function TPaymentMethod.GetKeyStringField: string;
begin
  result:= 'NAME';
end;

class function TPaymentMethod.GetKeyStringProperty: string;
begin
  result:= 'PaymentMethodName';
end;

initialization
  RegisterClassOnce(TPaymentMethod);


end.

