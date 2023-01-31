unit BusObjRap;
   {
    Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   11/12/06   1.00.01 BJ   Initial Version.
   }


interface


uses BusObjBase, DB, Classes, XMLIntf, BusObjStock,
  BusObjSales;


type

   TObjRapProc = Procedure(Const Value :Boolean) of Object;

   TRAPDeliveryCode = class(TMSBusObj)
   private
      Function GetDeliverycode        :String    ;
      Function GetDescription         :String    ;
      Function GetActive              :Boolean   ;
      Procedure SetDeliverycode        (Const Value :String    );
      Procedure SetDescription         (Const Value :String    );
      Procedure SetActive              (Const Value :Boolean   );
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;

   Published
      Property Deliverycode         :String       Read getDeliverycode      Write SetDeliverycode  ;
      Property Description          :String       Read getDescription       Write SetDescription   ;
      Property Active               :Boolean      Read getActive            Write SetActive        ;
   End;

   TRAPSubmissionLines = class(TMSBusObj)
   private
      fRapXMLTag    : IXMLNode;
      Function GetSubmissionid          :Integer   ;
      Function GetSaleid                :Integer   ;
      Function GetSalelineid            :Integer   ;
      Procedure SetSubmissionid          (Const Value :Integer   );
      Procedure SetSaleid                (Const Value :Integer   );
      Procedure SetSalelineid            (Const Value :Integer   );
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
   Published
      Property Submissionid           :Integer      Read getSubmissionid        Write SetSubmissionid    ;
      Property Saleid                 :Integer      Read getSaleid              Write SetSaleid          ;
      Property Salelineid             :Integer      Read getSalelineid          Write SetSalelineid      ;
      Property RapXMLTag              :IXMLNode     Read fRAPXMLTag             Write fRAPXMLTag;
    End;

   TRAPSubmission = class(TMSBusObj)
   private
      //fLines            : TRAPSubmissionLines;
      fsRAPXMLFileName  : String;
      invoiceObj        : TInvoice;
      fInvoceNode       : IXMLNode;
      fFormProc         : TGeneralProc;
      AllValid          : Boolean;
      Function GetSubmissiondate                :TDatetime ;
      Function GetTotalinvoices                 :Integer   ;
      Function GetSubmitted                     :Boolean   ;
      Function GetXmlfilename                   :String    ;
      Function GetReceivedsubmissionreport      :Boolean   ;
      Function GetFounderrors                   :Boolean   ;
      Function GetSubmissionerrormessage        :String    ;
      Function GetParentsubmissionid            :Integer   ;
      Function GetRequestedamount               :Double    ;
      Function GetPaymentreceived               :Boolean   ;
      Function GetAmountreceived                :Double    ;
      Function GetActive                        :Boolean   ;
      Function getLines                         :TRAPSubmissionLines;
      Function GetResubmittedid                 :Integer   ;
      Function GetDepositID                     :Integer   ;
      Function getRAPXMLFileName                :String;
      Function getcleanPaymentReceived          :Boolean;
      Procedure SetSubmissiondate                (Const Value :TDatetime );
      Procedure SetTotalinvoices                 (Const Value :Integer   );
      Procedure SetSubmitted                     (Const Value :Boolean   );
      Procedure SetXmlfilename                   (Const Value :String    );
      Procedure SetReceivedsubmissionreport      (Const Value :Boolean   );
      Procedure SetFounderrors                   (Const Value :Boolean   );
      Procedure SetSubmissionerrormessage        (Const Value :String    );
      Procedure SetParentsubmissionid            (Const Value :Integer   );
      Procedure SetRequestedamount               (Const Value :Double    );
      Procedure SetPaymentreceived               (Const Value :Boolean   );
      Procedure SetAmountreceived                (Const Value :Double    );
      Procedure SetActive                        (Const Value :Boolean   );
      Procedure SetResubmittedid                 (Const Value :Integer   );
      Procedure SetDepositID                     (Const Value :Integer   );
      procedure CreateRAPInvoiceXML              (Const Sender: TBusObj; var Abort: boolean);
      procedure CloneLines(const Sender: TBusObj; var Abort: boolean);
      Function  ValidateHeaderFieldRange :Boolean;
      function  ValidateLineFieldRange:Boolean;
      Function  ValidateFieldRange :Boolean;
      Function  CheckLength(const sValue :STring ; const MinLength, Maxlength :Integer;  const isMandatory :Boolean;
                            const MsgfieldName , modulename :STring):String;
      function  checkRange(const value:Variant ; const MaxDigits,Maxfraction:Integer; const Ismandatory:Boolean;
                           const MsgfieldName , modulename :STring):String;
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Procedure ClonePropertyObjects;                                      Override;

   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      Function     DoAfterInsert(Sender :TDatasetBusObj ):Boolean;         Override;
      function     CreateRAPXML: IXMLDocument;
      procedure LockSalesRecord(Const Sender: TBusObj; var Abort: boolean);
      function Resubmit:boolean;

   Published
      Property Submissiondate                 :TDatetime    Read getSubmissiondate              Write SetSubmissiondate          ;
      Property Totalinvoices                  :Integer      Read getTotalinvoices               Write SetTotalinvoices           ;
      Property Submitted                      :Boolean      Read getSubmitted                   Write SetSubmitted               ;
      Property Xmlfilename                    :String       Read getXmlfilename                 Write SetXmlfilename             ;
      Property Receivedsubmissionreport       :Boolean      Read getReceivedsubmissionreport    Write SetReceivedsubmissionreport;
      Property Founderrors                    :Boolean      Read getFounderrors                 Write SetFounderrors             ;
      Property Submissionerrormessage         :String       Read getSubmissionerrormessage      Write SetSubmissionerrormessage  ;
      Property Parentsubmissionid             :Integer      Read getParentsubmissionid          Write SetParentsubmissionid      ;
      Property Requestedamount                :Double       Read getRequestedamount             Write SetRequestedamount         ;
      Property Paymentreceived                :Boolean      Read getPaymentreceived             Write SetPaymentreceived         ;
      Property Amountreceived                 :Double       Read getAmountreceived              Write SetAmountreceived          ;
      Property Active                         :Boolean      Read getActive                      Write SetActive                  ;
      Property Resubmittedid                  :Integer      Read getResubmittedid               Write SetResubmittedid           ;
      Property DepositID                      :Integer      Read getDepositID                   Write SetDepositID               ;
      Property Lines                          :TRAPSubmissionLines Read getLines                ;//Write fLines;
      Property RAPXMLFileName                 :String       read getRAPXMLFileName              Write fsRAPXMLFileName;
      Property InvoceNode                     :IXMLNode     Read fInvoceNode                    Write fInvoceNode;
      Property CleanPaymentReceived           :Boolean      Read getcleanPaymentReceived;
      Property FormProc                       :TGeneralProc Read fFormProc                      Write fFormProc;
   End;

   TRAPCategory = class(TMSBusObj)
   private
      Function  GetItemcode             :String    ;
      Function  GetItemno               :String    ;
      Function  GetItemname             :String    ;
      Function  GetSeealsocategory      :String    ;
      Function  GetNote                 :String    ;
      Function  GetActive               :Boolean   ;
      Procedure SetItemcode             (Const Value :String    );
      Procedure SetItemno               (Const Value :String    );
      Procedure SetItemname             (Const Value :String    );
      Procedure SetSeealsocategory      (Const Value :String    );
      Procedure SetNote                 (Const Value :String    );
      Procedure SetActive               (Const Value :Boolean   );
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;

   Published
      Property Itemcode              :String       Read getItemcode           Write SetItemcode       ;
      Property Itemno                :String       Read getItemno             Write SetItemno         ;
      Property Itemname              :String       Read getItemname           Write SetItemname       ;
      Property Seealsocategory       :String       Read getSeealsocategory    Write SetSeealsocategory;
      Property Note                  :String       Read getNote               Write SetNote           ;
      Property Active                :Boolean      Read getActive             Write SetActive         ;
   End;

   TRAPproducts = class(TMSBusObj)
   private
      fProduct                                :TProduct;
      fRapCategory                            :TRAPCategory;
      fShowApprovalLimitFields                :TObjRapProc;
      Function  GetRapcategoryid              :Integer   ;
      Function  GetRapcategorycode            :String    ;
      Function  GetProductcode                :String    ;
      Function  GetDescription                :String    ;
      Function  GetPriorapprovalrequired      :Boolean   ;
      Function  GetPriorapprovalqtylimit      :Double    ;
      Function  GetPriorapprovalamtlimit      :Double    ;
      Function  GetGst                        :Boolean   ;
      Function  GetSpecialconsitions          :String    ;
      Function  GetActive                     :Boolean   ;
      Function  GetRAPCategory                :TRAPCategory;
      Procedure SetRapcategoryid              (Const Value :Integer   );
      Procedure SetRapcategorycode            (Const Value :String    );
      Procedure SetProductcode                (Const Value :String    );
      Procedure SetDescription                (Const Value :String    );
      Procedure SetPriorapprovalrequired      (Const Value :Boolean   );
      Procedure SetPriorapprovalqtylimit      (Const Value :Double    );
      Procedure SetPriorapprovalamtlimit      (Const Value :Double    );
      Procedure SetGst                        (Const Value :Boolean   );
      Procedure SetSpecialconsitions          (Const Value :String    );
      Procedure SetActive                     (Const Value :Boolean   );
      Procedure SetRAPCategory                (Const Value :TRAPCategory);
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      Function     DoAfterInsert(Sender :TDatasetBusObj ):Boolean;         Override;
   Published
      Property Rapcategoryid               :Integer      Read getRapcategoryid            Write SetRapcategoryid        ;
      Property Rapcategorycode             :String       Read getRapcategorycode          Write SetRapcategorycode      ;
      Property Productcode                 :String       Read getProductcode              Write SetProductcode          ;
      Property Description                 :String       Read getDescription              Write SetDescription          ;
      Property Priorapprovalrequired       :Boolean      Read getPriorapprovalrequired    Write SetPriorapprovalrequired;
      Property Priorapprovalqtylimit       :Double       Read getPriorapprovalqtylimit    Write SetPriorapprovalqtylimit;
      Property Priorapprovalamtlimit       :Double       Read getPriorapprovalamtlimit    Write SetPriorapprovalamtlimit;
      Property Gst                         :Boolean      Read getGst                      Write SetGst                  ;
      Property Specialconsitions           :String       Read getSpecialconsitions        Write SetSpecialconsitions    ;
      Property Active                      :Boolean      Read getActive                   Write SetActive               ;
      Property RAPCategory                 :TRAPCategory Read getRAPCategory              Write SetRAPCategory          ;
      Property ShowApprovalLimitFields     :TObjRapProc  Read fShowApprovalLimitFields    Write fShowApprovalLimitFields;
   End;
   
   TRAPprescriberTypeitems = class(TMSBusObj)
   private
      Function  GetPrescriberid      :Integer   ;
      Function  GetRapproductid      :Integer   ;
      Function  GetActive            :Boolean   ;
      Procedure SetPrescriberid      (Const Value :Integer   );
      Procedure SetRapproductid      (Const Value :Integer   );
      Procedure SetActive            (Const Value :Boolean   );
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean;             Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
   Published
      Property Prescriberid       :Integer      Read getPrescriberid    Write SetPrescriberid;
      Property Rapproductid       :Integer      Read getRapproductid    Write SetRapproductid;
      Property Active             :Boolean      Read getActive          Write SetActive      ;
   End;

   TRAPprescriberType = class(TMSBusObj)
   private
      //fLines                          :TRAPprescriberTypeitems;
      function  getPrescriberID        :Integer;
      Function  GetPrescribercode      :String    ;
      Function  GetproviderNum         :String    ;
      Function  GetPrescribername      :String    ;
      Function  GetActive              :Boolean   ;
      Function  GetLines               :TRAPprescriberTypeitems;
      Procedure SetPrescriberID        (Const Value :Integer);
      Procedure SetPrescribercode      (Const Value :String    );
      Procedure SetproviderNum         (Const Value :String    );
      Procedure SetPrescribername      (Const Value :String    );
      Procedure SetActive              (Const Value :Boolean   );
      //Procedure SetLines               (Const Value :TRAPprescriberTypeitems);
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;            Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
    Published
      Property PrescriberID         :Integer             Read getPrescriberID      Write SetPrescriberID;
      Property Prescribercode       :String              Read getPrescribercode    Write SetPrescribercode;
      Property providerNum          :String              Read getproviderNum       Write SetproviderNum;
      Property Prescribername       :String              Read getPrescribername    Write SetPrescribername;
      Property Active               :Boolean             Read getActive            Write SetActive        ;
      Property Lines                :TRAPprescriberTypeitems Read getlines         ;//Write SetLines;
   End;

   TRapPrescriberTypes = class(TMSBusObj)
   private
      Function GetPrescriberid          :Integer   ;
      Function GetPrescribertypeid      :Integer   ;
      Procedure SetPrescriberid          (Const Value :Integer   );
      Procedure SetPrescribertypeid      (Const Value :Integer   );
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
      Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
   Published
      Property Prescriberid           :Integer      Read getPrescriberid        Write SetPrescriberid    ;
      Property Prescribertypeid       :Integer      Read getPrescribertypeid    Write SetPrescribertypeid;
   End;

   TRapPrescriber = class(TMSBusObj)
   private
      //fLines            : TRapPrescriberTypes;
      Function GetPrescribername      :String    ;
      Procedure SetPrescribername      (Const Value :String    );
      Function getLines                         :TRapPrescriberTypes;
   Protected
      procedure OnDataIDChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  getSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTableName: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
   Published
      Property Lines                          :TRapPrescriberTypes Read getLines                ;//Write fLines;
      Property Prescribername       :String       Read getPrescribername    Write SetPrescribername;
   End;


implementation


uses FastFuncs,CommonLib, Sysutils, forms, XMLDoc,
  BusObjConst, DateUtils, AppEnvironment;


{========================================================
         TRAPCategory
========================================================}
constructor TRAPCategory.Create(AOwner: TComponent);
begin
   inherited Create(AOwner)
end;


destructor TRAPCategory.Destroy;
begin
   inherited;
end;


procedure   TRAPCategory.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'Itemcode');
    SetPropertyFromNode(Node,'Itemno');
    SetPropertyFromNode(Node,'Itemname');
    SetPropertyFromNode(Node,'Seealsocategory');
    SetPropertyFromNode(Node,'Note');
    SetBooleanPropertyFromNode(Node,'Active');
end;


procedure   TRAPCategory.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Itemcode' ,Itemcode);
      AddXMLNode(node,'Itemno' ,Itemno);
      AddXMLNode(node,'Itemname' ,Itemname);
      AddXMLNode(node,'Seealsocategory' ,Seealsocategory);
      AddXMLNode(node,'Note' ,Note);
      AddXMLNode(node,'Active' ,Active);
end;


function    TRAPCategory.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Itemcode = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Item Code should not be blank' , False );
      Exit;
   end;
   if Itemno = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Item No should not be blank' , False );
      Exit;
   end;
   if Itemname = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Item Name should not be blank' , False );
      Exit;
   end;
   if FastFuncs.StrLength(Itemno) <4 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Item No should be 2 alphabets followed by 00' , False );
      Exit;
   end;
   if not IsUnique(ID , 'Itemno = ' + quotedstr(Itemno)) then begin
      Resultstatus.AddItem(False , rssError , 0,  'Item No already exists' , False );
      Exit;
   end;
   if not IsUnique(ID , 'Itemname = ' + quotedstr(Itemname)) then begin
      Resultstatus.AddItem(False , rssError , 0,  'Item Name already exists' , False );
      Exit;
   end;
   Result := true;
end;


function    TRAPCategory.Save :Boolean ;
begin
   Result := False;
   PostDB;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TRAPCategory.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TRAPCategory.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if FastFuncs.SameText(Sender.FieldName , 'ItemNo') then begin
        if FastFuncs.StrLength(Itemno)>2 then Itemcode := copy(Itemno,1,2);
    end;


end;


Function TRAPCategory.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblRAPCategories';
   Result := Inherited getSQL;
end;


class function  TRAPCategory.GetIDField : String;
begin
   Result := 'Categoryid'
end;

class function TRAPCategory.GetBusObjectTableName: string;
begin
  Result := 'tblRAPCategories';
end;

Function  TRAPCategory.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   REsult := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TRAPCategory.GetItemcode       :String    ; begin Result := GetStringField('Itemcode');End;
Function  TRAPCategory.GetItemno         :String    ; begin Result := GetStringField('Itemno');End;
Function  TRAPCategory.GetItemname       :String    ; begin Result := GetStringField('Itemname');End;
Function  TRAPCategory.GetSeealsocategory:String    ; begin Result := GetStringField('Seealsocategory');End;
Function  TRAPCategory.GetNote           :String    ; begin Result := GetStringField('Note');End;
Function  TRAPCategory.GetActive         :Boolean   ; begin Result := GetBooleanField('Active');End;
Procedure TRAPCategory.SetItemcode       (Const Value :String    ); begin SetStringField('Itemcode'        , Value);End;
Procedure TRAPCategory.SetItemno         (Const Value :String    ); begin SetStringField('Itemno'          , Value);End;
Procedure TRAPCategory.SetItemname       (Const Value :String    ); begin SetStringField('Itemname'        , Value);End;
Procedure TRAPCategory.SetSeealsocategory(Const Value :String    ); begin SetStringField('Itemname'        , Value);End;
Procedure TRAPCategory.SetNote           (Const Value :String    ); begin SetStringField('Note'            , Value);End;
Procedure TRAPCategory.SetActive         (Const Value :Boolean   ); begin SetBooleanField('Active'          , Value);End;

{========================================================
         TRAPprescriberType
========================================================}
constructor TRAPprescriberType.Create(AOwner: TComponent);
begin
   inherited Create(AOwner)
end;


destructor TRAPprescriberType.Destroy;
begin
   inherited;
end;


procedure   TRAPprescriberType.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'Prescribercode');
    SetPropertyFromNode(Node,'providerNum');
    SetPropertyFromNode(Node,'Prescribername');
    SetBooleanPropertyFromNode(Node,'Active');
end;


procedure   TRAPprescriberType.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Prescribercode' ,Prescribercode);
      AddXMLNode(node,'providerNum' ,providerNum);
      AddXMLNode(node,'Prescribername' ,Prescribername);
      AddXMLNode(node,'Active' ,Active);
end;


function    TRAPprescriberType.ValidateData :Boolean ;
begin
   Resultstatus.Clear;
   Result := true;
end;


function    TRAPprescriberType.Save :Boolean ;
begin
   Result := False;
   PostDB;
   lines.postDB;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TRAPprescriberType.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
(*   if Assigned(fLines) then
        if (not fLines.ExternalDatasetAssigned) then FreeAndNil(fLines)
        else fLines.Dataset.Close;*)
end;


procedure TRAPprescriberType.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TRAPprescriberType.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblRAPPrescriberType';
   Result := Inherited getSQL;
end;


class function  TRAPprescriberType.GetIDField : String;
begin
   Result := 'Prescriberid'
end;

class function TRAPprescriberType.GetBusObjectTableName: string;
begin
  Result := 'tblRAPPrescriberType';
end;

Function  TRAPprescriberType.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
       Result := inherited DoAfterInsert(sender);
       if not result then Exit;
       if Assigned(Self.Owner) then
        if self.Owner is  TRAPprescriber then
            PrescriberId :=TRAPprescriber(Self.Owner).ID;
end;
Function  TRAPprescriberType.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

Function TRAPprescriberType.getLines:TRAPprescriberTypeitems;
begin
(*    if not Assigned(fLines) then begin
        fLines := TRAPprescriberTypeitems.Create(self);
        if Assigned(Self.connection) then flines.Connection := Self.Connection;
        flines.LoadSelect('PrescriberId = ' + FastFuncs.IntToStr(Self.ID));
    end else if (not Assigned(fLines.Dataset)) or (fLines.Dataset.Active = False) or (fLines.PrescriberId <> Self.ID) then begin
        flines.LoadSelect('PrescriberId = ' + FastFuncs.IntToStr(Self.ID));
    end;
    Result := fLines;*)
    Result := TRAPprescriberTypeitems(getContainerComponent(TRAPprescriberTypeitems, 'PrescriberId = ' + FastFuncs.IntToStr(Self.ID)));
end;
(*Procedure TRAPprescriberType.SetLines(Const Value:TRAPprescriberTypeitems);  begin fLines := Value; End;*)
{Property functions}

Function  TRAPprescriberType.GetPrescriberID:Integer    ; begin Result := GetIntegerField('PrescriberID');End;
Function  TRAPprescriberType.GetPrescribercode:String    ; begin Result := GetStringField('Prescribercode');End;
Function  TRAPprescriberType.GetproviderNum:String    ; begin Result := GetStringField('providerNum');End;
Function  TRAPprescriberType.GetPrescribername:String    ; begin Result := GetStringField('Prescribername');End;
Function  TRAPprescriberType.GetActive        :Boolean   ; begin Result := GetBooleanField('Active');End;
Procedure TRAPprescriberType.SetPrescriberID(Const Value :Integer    ); begin SetIntegerField('PrescriberID', Value);End;
Procedure TRAPprescriberType.SetPrescribercode(Const Value :String    ); begin SetStringField('Prescribercode', Value);End;
Procedure TRAPprescriberType.SetproviderNum(Const Value :String    ); begin SetStringField('providerNum', Value);End;
Procedure TRAPprescriberType.SetPrescribername(Const Value :String    ); begin SetStringField('Prescribername', Value);End;
Procedure TRAPprescriberType.SetActive        (Const Value :Boolean   ); begin SetBooleanField('Active'         , Value);End;


{========================================================
         TRAPprescriberTypeitems
========================================================}
constructor TRAPprescriberTypeitems.Create(AOwner: TComponent);
begin
   inherited Create(AOwner)
end;


destructor TRAPprescriberTypeitems.Destroy;
begin
   inherited;
end;


procedure   TRAPprescriberTypeitems.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'Prescriberid');
    SetPropertyFromNode(Node,'Rapproductid');
    SetBooleanPropertyFromNode(Node,'Active');
end;


procedure   TRAPprescriberTypeitems.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Prescriberid' ,Prescriberid);
      AddXMLNode(node,'Rapproductid' ,Rapproductid);
      AddXMLNode(node,'Active' ,Active);
end;


function    TRAPprescriberTypeitems.ValidateData :Boolean ;
begin
   Resultstatus.Clear;
   Result := true;
end;


function    TRAPprescriberTypeitems.Save :Boolean ;
begin
   Result := False;
   postDb;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TRAPprescriberTypeitems.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TRAPprescriberTypeitems.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TRAPprescriberTypeitems.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblRAPPrescriberTypeitems';
   Result := Inherited getSQL;
end;

class function  TRAPprescriberTypeitems.GetIDField : String;
begin
   Result := 'Id'
end;

class function TRAPprescriberTypeitems.GetBusObjectTableName: string;
begin
  Result := 'tblRAPPrescriberTypeitems';
end;

Function  TRAPprescriberTypeitems.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
   if Rapproductid = 0 then Dataset.Delete;
End;
Function  TRAPprescriberTypeitems.DoBeforePost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoBeforePost(sender);
End;
Function  TRAPprescriberTypeitems.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited DoAfterInsert(sender);
    if not result then Exit;
    if Assigned(Self.Owner) then
        if Self.Owner is    TRAPprescriberType then
            Prescriberid := TRAPprescriberType(Self.Owner).ID;
    Active := true;
end;


{Property functions}
Function  TRAPprescriberTypeitems.GetPrescriberid:Integer   ; begin Result := GetIntegerField('Prescriberid');End;
Function  TRAPprescriberTypeitems.GetRapproductid:Integer   ; begin Result := GetIntegerField('Rapproductid');End;
Function  TRAPprescriberTypeitems.GetActive      :Boolean   ; begin Result := GetBooleanField('Active');End;
Procedure TRAPprescriberTypeitems.SetPrescriberid(Const Value :Integer   ); begin SetIntegerField( 'Prescriberid', Value);End;
Procedure TRAPprescriberTypeitems.SetRapproductid(Const Value :Integer   ); begin SetIntegerField( 'Rapproductid', Value);End;
Procedure TRAPprescriberTypeitems.SetActive      (Const Value :Boolean   ); begin SetBooleanField('Active'       , Value);End;


{========================================================
         TRAPproducts
========================================================}
constructor TRAPproducts.Create(AOwner: TComponent);
begin
   inherited Create(AOwner) ;
   fProduct                 :=Nil;
   fRapCategory             :=Nil;
   fShowApprovalLimitFields :=Nil;
end;


destructor TRAPproducts.Destroy;
begin
   inherited;
end;


procedure   TRAPproducts.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'Rapcategoryid');
    SetPropertyFromNode(Node,'Rapcategorycode');
    SetPropertyFromNode(Node,'Productcode');
    SetPropertyFromNode(Node,'Description');
    SetBooleanPropertyFromNode(Node,'Priorapprovalrequired');
    SetPropertyFromNode(Node,'Priorapprovalqtylimit');
    SetPropertyFromNode(Node,'Priorapprovalamtlimit');
    SetBooleanPropertyFromNode(Node,'Gst');
    SetPropertyFromNode(Node,'Specialconsitions');
    SetBooleanPropertyFromNode(Node,'Active');
end;


procedure   TRAPproducts.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      //AddXMLNode(node,'Productid' ,Productid);
      AddXMLNode(node,'Rapcategoryid' ,Rapcategoryid);
      AddXMLNode(node,'Rapcategorycode' ,Rapcategorycode);
      AddXMLNode(node,'Productcode' ,Productcode);
      AddXMLNode(node,'Description' ,Description);
      AddXMLNode(node,'Priorapprovalrequired' ,Priorapprovalrequired);
      AddXMLNode(node,'Priorapprovalqtylimit' ,Priorapprovalqtylimit);
      AddXMLNode(node,'Priorapprovalamtlimit' ,Priorapprovalamtlimit);
      AddXMLNode(node,'Gst' ,Gst);
      AddXMLNode(node,'Specialconsitions' ,Specialconsitions);
      AddXMLNode(node,'Active' ,Active);
end;


function    TRAPproducts.ValidateData :Boolean ;
begin
    Resultstatus.Clear;
    if (RapCategoryCode = '') or (length(RapCategoryCode) <> 4 ) then begin
        ResultStatus.AddItem(False , rssWarning, 0 , 'Invalid Category Code' );
        Result := false;
        Exit;
    end;
    If not isunique(Id ,'ProductCode = ' + QuotedStr(ProductCode)) then begin
        ResultStatus.AddItem(False , rssWarning, 0 , 'This Product code already exits' );
        Result := false;
        Exit;
    end;
    if  (ProductCode = '') or
        (Length(ProductCode)<2)  or
        (Copy(ProductCode , 1, 2) <>   Copy(RapCategoryCode , 1, 2)) then begin
        ResultStatus.AddItem(False , rssWarning, 0 , 'Product Code should match the RAP category - should be ' + Copy(RapCategoryCode , 1, 2) + ' followed by 2 digits' );
        Result := false;
        Exit;
    End;

   Result := true;
end;

Function     TRAPproducts.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited DoAfterInsert(sender);
    if not result then Exit;
    Active := true;
end;
function    TRAPproducts.Save :Boolean ;
begin
   Result := False;
   postDb;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TRAPproducts.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
   if Assigned(fProduct) then
        if (not fProduct.ExternalDatasetAssigned) then FreeAndNil(fProduct)
        else fProduct.Dataset.Close;

  if Assigned(fRAPCategory) then
        if (not fRAPCategory.ExternalDatasetAssigned) then FreeAndNil(fRAPCategory)
        else fRAPCategory.Dataset.Close;
  if Assigned(fShowApprovalLimitFields) then fShowApprovalLimitFields(Priorapprovalrequired);
end;


procedure TRAPproducts.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if FastFuncs.SameText(Sender.FieldName , 'PriorApprovalRequired') then begin
        if Assigned(fShowApprovalLimitFields) then fShowApprovalLimitFields(PriorApprovalRequired);
    end else if FastFuncs.SameText(Sender.Fieldname , 'RapCategoryCode') then begin
        if (ProductCode <> '') or
            (Length(ProductCode)<2)  or
            (Copy(ProductCode , 1, 2) <>   Copy(RapCategoryCode , 1, 2)) then
            ProductCode := Copy(RapCategoryCode , 1, 2);
    end;
end;


Function TRAPproducts.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblRAPProducts';
   Result := Inherited getSQL;
end;


class function  TRAPproducts.GetIDField : String;
begin
   Result := 'Rapproductid'
end;
class function TRAPproducts.GetBusObjectTableName: string;
begin
  Result := 'tblRAPProducts';
end;

Function  TRAPproducts.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

Function  TRAPproducts.GetRAPCAtegory :TRAPCategory;
begin
    if not Assigned(fRAPCategory) then begin
        fRAPCategory := TRAPCategory.Create(Self);
        if Assigned(Self.Connection) then
            fRAPCategory.Connection := Self.Connection;
        fRAPCategory.LoadSelect('ID = ' + FastFuncs.IntToStr(Rapcategoryid));
    end else if (not assigned(fRAPCategory.Dataset) or (fRAPCategory.DAtaset.Active = False) or (fRAPCategory.ID <> Self.Rapcategoryid)) then begin
        fRAPCategory.LoadSelect('ID = ' + FastFuncs.IntToStr(Rapcategoryid));
    end;
    Result := fRAPCategory;
end;
(*Function  TRAPproducts.GetProduct :TProduct;
begin
    if not Assigned(fProduct) then begin
        fProduct := TProduct.Create(Self);
        fProduct.Connection := TMyDacDataConnection.Create(fProduct);
        // product object should be outside transaction to avaoid locking
        TMyDacDataConnection(fproduct.connection).MyDacConnection := GetSharedMyDacConnection;
        fProduct.LoadSelect('PartsID = ' + FastFuncs.IntToStr(ProductID));
    end else if (not assigned(fProduct.Dataset) or (fproduct.DAtaset.Active = False) or (fProduct.ProductId <> Self.ProductId)) then begin
        fProduct.LoadSelect('PartsID = ' + FastFuncs.IntToStr(ProductID));
    end;
    Result := fProduct;
end;*)
//Procedure TRAPproducts.SetProduct    (Const Value :TProduct);     begin fProduct     := Value; end;
Procedure TRAPproducts.SetRapCategory(Const Value :TRAPCategory); begin fRAPCategory := Value; end;

{Property functions}
//Function  TRAPproducts.GetProductid            :Integer   ; begin Result := GetIntegerField('Productid');End;
Function  TRAPproducts.GetRapcategoryid        :Integer   ; begin Result := GetIntegerField('Rapcategoryid');End;
Function  TRAPproducts.GetRapcategorycode      :String    ; begin Result := GetStringField('Rapcategorycode');End;
Function  TRAPproducts.GetProductcode          :String    ; begin Result := GetStringField('Productcode');End;
Function  TRAPproducts.GetDescription          :String    ; begin Result := GetStringField('Description');End;
Function  TRAPproducts.GetPriorapprovalrequired:Boolean   ; begin Result := GetBooleanField('Priorapprovalrequired');End;
Function  TRAPproducts.GetPriorapprovalqtylimit:Double    ; begin Result := GetFloatField('Priorapprovalqtylimit');End;
Function  TRAPproducts.GetPriorapprovalamtlimit:Double    ; begin Result := GetFloatField('Priorapprovalamtlimit');End;
Function  TRAPproducts.GetGst                  :Boolean   ; begin Result := GetBooleanField('Gst');End;
Function  TRAPproducts.GetSpecialconsitions    :String    ; begin Result := GetStringField('Specialconsitions');End;
Function  TRAPproducts.GetActive               :Boolean   ; begin Result := GetBooleanField('Active');End;
//Procedure TRAPproducts.SetProductid            (Const Value :Integer   ); begin SetIntegerField('Productid'             , Value);End;
Procedure TRAPproducts.SetRapcategoryid        (Const Value :Integer   ); begin SetIntegerField('Rapcategoryid'         , Value);End;
Procedure TRAPproducts.SetRapcategorycode      (Const Value :String    ); begin SetStringField('Rapcategorycode'       , Value);End;
Procedure TRAPproducts.SetProductcode          (Const Value :String    ); begin SetStringField('Productcode'           , Value);End;
Procedure TRAPproducts.SetDescription          (Const Value :String    ); begin SetStringField('Description'           , Value);End;
Procedure TRAPproducts.SetPriorapprovalrequired(Const Value :Boolean   ); begin SetBooleanField('Description'           , Value);End;
Procedure TRAPproducts.SetPriorapprovalqtylimit(Const Value :Double    ); begin SetFloatField('Description'           , Value);End;
Procedure TRAPproducts.SetPriorapprovalamtlimit(Const Value :Double    ); begin SetFloatField('Description'           , Value);End;
Procedure TRAPproducts.SetGst                  (Const Value :Boolean   ); begin SetBooleanField('Gst'                   , Value);End;
Procedure TRAPproducts.SetSpecialconsitions    (Const Value :String    ); begin SetStringField('Specialconsitions'     , Value);End;
Procedure TRAPproducts.SetActive               (Const Value :Boolean   ); begin SetBooleanField('Active'                , Value);End;


{========================================================
         TRAPSubmission
========================================================}
constructor TRAPSubmission.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   invoiceObj := nil;
   fFormProc := nil;
end;


destructor TRAPSubmission.Destroy;
begin
   inherited;
end;


procedure   TRAPSubmission.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetDateTimePropertyFromNode(Node,'Submissiondate');
    SetPropertyFromNode(Node,'Totalinvoices');
    SetBooleanPropertyFromNode(Node,'Submitted');
    SetPropertyFromNode(Node,'Xmlfilename');
    SetBooleanPropertyFromNode(Node,'Receivedsubmissionreport');
    SetBooleanPropertyFromNode(Node,'Founderrors');
    SetPropertyFromNode(Node,'Submissionerrormessage');
    SetPropertyFromNode(Node,'Parentsubmissionid');
    SetPropertyFromNode(Node,'Requestedamount');
    SetBooleanPropertyFromNode(Node,'Paymentreceived');
    SetPropertyFromNode(Node,'Amountreceived');
    SetBooleanPropertyFromNode(Node,'Active');
    SetPropertyFromNode(Node,'Resubmittedid');
    SetPropertyFromNode(Node,'DepositID');
end;


procedure   TRAPSubmission.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Submissiondate' ,Submissiondate);
      AddXMLNode(node,'Totalinvoices' ,Totalinvoices);
      AddXMLNode(node,'Submitted' ,Submitted);
      AddXMLNode(node,'Xmlfilename' ,Xmlfilename);
      AddXMLNode(node,'Receivedsubmissionreport' ,Receivedsubmissionreport);
      AddXMLNode(node,'Founderrors' ,Founderrors);
      AddXMLNode(node,'Submissionerrormessage' ,Submissionerrormessage);
      AddXMLNode(node,'Parentsubmissionid' ,Parentsubmissionid);
      AddXMLNode(node,'Requestedamount' ,Requestedamount);
      AddXMLNode(node,'Paymentreceived' ,Paymentreceived);
      AddXMLNode(node,'Amountreceived' ,Amountreceived);
      AddXMLNode(node,'Active' ,Active);
      AddXMLNode(node,'Resubmittedid' ,Resubmittedid);
      AddXMLNode(node,'DepositID' ,DepositID    );
end;


function    TRAPSubmission.ValidateData :Boolean ;
begin
   Resultstatus.Clear;
   Result := inherited ValidateData;
   if not result then Exit;

   if Submissiondate = 0 then begin
       Resultstatus.AddItem(False, rssWarning, 0 , 'Submission date should not be blank');
       REsult := False;
       Exit;
   end;


end;
Function     TRAPSubmission.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited DoAfterInsert(sender);
    if not result then Exit;
    Active := true;
end;
function    TRAPSubmission.Save :Boolean ;
var
    strSQL :String;
begin
    Result := False;
    postDb;
    lines.PostDb;
    if (submitted) or (foundErrors) then begin
      AllValid := True;
      Lines.IterateREcords(LockSalesRecord);
      if  not AllValid then Exit;
      if foundErrors then
        strSQL := 'update tblSales, tblRAPSubmissionLines ' +
                          ' set tblSales.RapSubmitstatus = "F" ' +
                          ' Where tblSales.SaleId =tblRAPSubmissionLines.SaleId'+
                          ' and tblRAPSubmissionLines.SubmissionId = ' + FastFuncs.IntToStr(ID)
      else  if  submitted then
        strSQL := 'update tblSales, tblRAPSubmissionLines ' +
                          ' set tblSales.RapSubmitstatus = "T" ' +
                          ' Where tblSales.SaleId =tblRAPSubmissionLines.SaleId'+
                          ' and tblRAPSubmissionLines.SubmissionId = ' + FastFuncs.IntToStr(ID);
      getNewDataset(strSQL, True);
    end;


   if not ValidateData then Exit;
   Result := Inherited Save;
   {lock invoices}
(*   if CleanPaymentReceived <> PaymentReceived then begin
        if PaymentReceived then begin
            strSQL := 'update tblSales, tblRAPSubmissionLines ' +
                        ' set tblSales.Paid = "T" , tblSales.Balance = 0 , '+
                        ' tblSales.Payment = tblSales.TotalAmountInc ' +
                        ' where  tblRAPSubmissionLines.SaleId = tblSales.SaleID  ' +
                        ' and tblRAPSubmissionLines.SubmissionID = ' + FastFuncs.IntToStr(ID);
            GetNewDataset(strSQL , True);
        end else begin
            AmountReceived :=0;
            strSQL := 'update tblSales, tblRAPSubmissionLines ' +
                        ' set tblSales.Paid = "F" , tblSales.Balance = tblSales.TotalAmountInc , '+
                        ' tblSales.Payment = 0 ' +
                        ' where  tblRAPSubmissionLines.SaleId = tblSales.SaleID  ' +
                        ' and tblRAPSubmissionLines.SubmissionID = ' + FastFuncs.IntToStr(ID);
            GetNewDataset(strSQL , True);
        end;
   end;*)
end;
Function     TRAPSubmission.ValidateFieldRange :Boolean;
var
    s :String;
begin
    REsult := False;
    s:= '';
    s :=                checkLength(AppEnv.Companyinfo.Supplierid           , 0 , 15 , true, 'DVA Supplier ID'     ,'Utilities->Company Information[DVA Related tab]');
    if s = '' then s := CheckLength(FastFuncs.IntToStr(ID)                     , 0 , 15 , true, 'Submission Id'       , '');
    if s = '' then s := checkRange (Totalinvoices                    , 5 , 0  , true, 'Total Invoices'      , '');
    if s = '' then s := checkLength(AppEnv.Companyinfo.Abn                  , 1 , 11 , true, 'DVA ABN'             ,'Utilities->Company Information[DVA Related tab]');
    if s = '' then s := checkLength(AppEnv.Companyinfo.CompanyName          , 1 , 40 , true, 'Company Name'        ,'Utilities->Company Information[DVA Related tab]');
    if s = '' then s := checkLength(AppEnv.Companyinfo.RAPProgramName       , 1 , 20 , true, 'Program Name'        ,'Utilities->Company Information[DVA Related tab]');
    if s = '' then s := checkLength(AppEnv.Companyinfo.RAPInvoiceDescription, 1 , 11 , true, 'Invoice Description' ,'Utilities->Company Information[DVA Related tab]');
    if s = '' then s := checkLength(AppEnv.Companyinfo.RAPProductGroup      , 1 , 6  , True, 'Product Group'       ,'Utilities->Company Information[DVA Related tab]');
    if s = '' then s := checkLength(AppEnv.Companyinfo.RAPContractNumber    , 1 , 12 , True, 'DVA Contract number ','Utilities->Company Information[DVA Related tab]');
    if s <> '' then begin
        Resultstatus.AddItem(False, rssWarning, 0 , s);
    end else Result := True;
    if not result then AllValid := false;
end;

function TRAPSubmission.checkRange(const value:VAriant ; const MaxDigits,Maxfraction:Integer; const Ismandatory:Boolean;  const MsgfieldName , modulename :STring):String;
var
    maxvalue : double;
    s:String;
begin
    MaxValue := 0;
    if Maxdigits > 0 then MaxValue := StrToFloat(ReplicateStr('9' , Maxdigits));
    if Maxfraction > 0 then MaxValue := StrToFloat(ReplicateStr('9' , Maxdigits) +'.' +  ReplicateStr('9' , MaxFraction));
    if (Value = 0) and (IsMandatory) then begin
        s:=MsgfieldName + ' should not be blank.' ;
    end else if (value <> 0) and    (Value > MaxValue)  then begin
        s:=MsgfieldName + ' must be less than  ' + FloatToStr(MaxValue) ;
    end;
    if s <> '' then
        if modulename <> '' then
            s := s + '  Please change it in ' + modulename;
    Result := s;
end;
Function TRAPSubmission.CheckLength(const sValue :STring ; const MinLength, Maxlength :Integer;  const isMandatory :Boolean;  const MsgfieldName , modulename :STring):String;
var
    value,s :String;
begin
    value := FastFuncs.Trim(sValue);
    if (Value = '') and ((MinLength > 0) or (IsMandatory)) then begin
        s:=MsgfieldName + ' should not be blank.' ;
    end else if (value <> '') and ((minLength<> 0) or (MaxLength <> 0) ) and   ((Length(Value) > MaxLength) or (Length(Value)< MinLength)) then begin
        if (minLength <> 0) and (MaxLength<>0) then
            s:=MsgfieldName + ' must be between ' + FastFuncs.IntToStr(minLength) + ' and ' + FastFuncs.IntToStr(MaxLength) + ' characters'
        else if (minLength = 0) and (MaxLength <> 0) then
            s:=MsgfieldName + ' must be maximum ' + FastFuncs.IntToStr(MaxLength) + ' characters'
        else if (MinLength <> 0) and (maxLength = 0) then
            s:=MsgfieldName + ' must be minimum ' + FastFuncs.IntToStr(MaxLength) + ' characters'
    end;
    if s <> '' then
        if modulename <> '' then
            s := s + '  Please change it in ' + modulename;
    Result := s;
end;
function  TRAPSubmission.ValidateLineFieldRange:Boolean;
var
    s:String;
begin
    REsult := False;
    s:= '';
    s:= Checkrange(InvoiceObj.Lines.Dataset.Recno , 3,0 , True , 'Invoice Line number' , '');
    if s = '' then s :=CheckLength(InvoiceObj.Lines.RAPProductCode , 1,6 , true , 'RAP Product code' ,InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s := CheckLength(InvoiceObj.Lines.ProductName , 1 , 20 , True , 'Catalog Item Num[Part name]',InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
(*    if s = '' then s :=checkLength(InvoiceObj.Lines.ProviderNum,1,15,TRue , 'Provider number' , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s :=checkLength(InvoiceObj.Lines.PrescriberTypecode,1,6,TRue , 'Prescriber Type' , '');*)
    if s = '' then s :=checkLength(DatetoStr(InvoiceObj.SaleDate),0,0,TRue , 'Sale Date' , '');
    if s = '' then s :=checkLength(InvoiceObj.Lines.ProductDescription,1,40,TRue , 'Product Description' , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s :=checkLength(InvoiceObj.DVADeliveryCode,1,4,TRue , 'Delivery Code' , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s :=checkRange(InvoiceObj.Lines.QtyShipped,4,0,TRue , 'Quantity' , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s :=checkRange(InvoiceObj.Lines.LinePrice,9,2,TRue , 'Unit Price[Ex]' , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s :=checkRange(Round(InvoiceObj.Lines.LineTaxRate * InvoiceObj.Lines.LinePrice,2),9,2,TRue , 'GST' , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s :=checkLength(InvoiceObj.Lines.SoldSerials,0,16,False , 'Serial number' , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s<> '' then begin
        Resultstatus.AddItem(False, rssWarning, 0 , s);
    end else Result := True;
    if not result then AllValid := false;
end;
Function  TRAPSubmission.ValidateHeaderFieldRange :Boolean;
var
    s:String;
begin
    REsult := False;
    s := '';
    s :=                checkRange (InvoiceObj.ID                , 12 , 0  , true , 'Invocie number'        , '');
    if s = '' then s := CheckLength(InvoiceObj.DVAFilenum        , 0  , 12 , true , 'DVA file number'       , 'Sales->Customers[General Tab]');
    if s = '' then s := checkRange (InvoiceObj.Lines.Count       , 3  , 0  , true , 'Invoice line records ' , '') ;
    if s = '' then s := checkRange (Invoiceobj.TotalAmount       , 9  , 2  ,True  , 'Invoice Amount[Ex]'    , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']') ;
    if s = '' then s := checkRange (Invoiceobj.TotalAmountInc    , 9  , 2  ,True  ,'Invoice Amount[Inc]'    , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']') ;
    if s = '' then s := CheckLength(FastFuncs.Trim(InvoiceObj.ShipToDesc) + ' ' + Invoiceobj.VeteranPhoneNo , 0, 160  ,True,  'Delivery address (Veteran''s address) ' , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s := checkLength(InvoiceObj.VeteranPostcode   , 0  , 10 , True , 'Delivery post code (Vetran''s Post code)' ,InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s := checkLength(InvoiceObj.VeteranSurname    , 0  , 40 , True , 'Veteran''s name '      , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']') ;
    if s = '' then s := checkLength(InvoiceObj.VeteranInitial    , 0  , 1  , True , 'Veteran''s Initial '   , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']') ;
    if s = '' then s := checkLength(InvoiceObj.VeteranGender     , 0  , 1  , True , 'Veteran''s Initial '   , '') ;
    if s = '' then s := checkLength(InvoiceObj.VeteranShipPOCode , 0  , 10 , True , 'Veteran''s Initial '   , '') ;
    if s = '' then s := checkLength(InvoiceObj.PriorApprovalRefNo, 0  , 15 , False, 'Prior Approval Reference Number ' ,InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s := checkLength(InvoiceObj.ProviderNum       , 1  , 15 , TRue , 'Provider number' , InvoiceObj.XMLNodeName+'[' + FastFuncs.IntToStr(InvoiceObj.ID) +']');
    if s = '' then s := checkLength(InvoiceObj.PrescriberTypecode, 1  , 6  , TRue , 'Prescriber Type' , '');

    if s<> '' then begin
        Resultstatus.AddItem(False, rssWarning, 0 , s);
    end else Result := True;
    if not result then AllValid := false;
end;
procedure TRAPSubmission.CreateRAPInvoiceXML(Const Sender: TBusObj; var Abort: boolean);
var
    CurrentNode:IXMLNode;
begin
    if not AllValid then exit;
    if not (sender is TRAPSubmissionLines) then exit;
    if not Assigned(TRAPSubmissionLines(Sender).RapXMLTag) then exit;
    if Assigned(InvoiceObj) and (InvoiceObj.ID =TRAPSubmissionLines(Sender).SaleID) then begin
        InvoiceObj.Lines.dataset.Locate('SaleLineID' ,TRAPSubmissionLines(Sender).Salelineid , []);
    end else begin{header changed}
        InvoceNode :=TRAPSubmissionLines(Sender).RapXMLTag.Addchild('invoice');
        CurrentNode := InvoceNode.Addchild('invoiceHeader');
        if not (Assigned(InvoiceObj)) then begin
            invoiceObj := TInvoice.Create(Self);
            InvoiceObj.connection := Self.connection;
            InvoiceObj.Load(TRAPSubmissionLines(Sender).SaleID);
            if not ValidateHeaderFieldRange then begin
                Abort := True;
                Exit;
            End;
        End else if InvoiceObj.Id <> TRAPSubmissionLines(Sender).SaleID then begin
            InvoiceObj.Load(TRAPSubmissionLines(Sender).SaleID);
            if not ValidateHeaderFieldRange then begin
                Abort := true;
                Exit;
            End;
        end;
        InvoiceObj.Lines.Dataset.filter := '[IsRapProduct] = '+Quotedstr('T');
        InvoiceObj.Lines.Dataset.Filtered := True;
        InvoiceObj.Lines.dataset.Locate('SaleLineID' ,TRAPSubmissionLines(Sender).Salelineid , []);
        AddXMLNode(CurrentNode , 'invoiceNum'       ,InToStrWith0(InvoiceObj.ID,10), False);
        AddXMLNode(CurrentNode , 'abn'              ,AppEnv.Companyinfo.Abn, False);
        AddXMLNode(CurrentNode , 'supplierName'     ,AppEnv.Companyinfo.CompanyName, False);
        AddXMLNode(CurrentNode , 'programName'      ,AppEnv.Companyinfo.RAPProgramName, false);
        AddXMLNode(CurrentNode , 'dvaFileNum'       ,InvoiceObj.DVAFilenum,False);
        AddXMLNode(CurrentNode , 'dvaABN'           ,AppEnv.Companyinfo.Dvaabn, False);
        AddXMLNode(CurrentNode , 'invDesc'          ,AppEnv.Companyinfo.RAPInvoiceDescription, False);
        AddXMLNode(CurrentNode , 'invDate'          ,Invoiceobj.ShipDate,False);
        AddXMLNode(CurrentNode , 'invNumLines'      ,InvoiceObj.Lines.Count,False);
        AddXMLNode(CurrentNode , 'totalExcGST'      ,Invoiceobj.TotalAmount,False);
        AddXMLNode(CurrentNode , 'totalIncGST'      ,Invoiceobj.TotalAmountInc,False);
        AddXMLNode(CurrentNode , 'dateDispatched'   ,Invoiceobj.ShipDate,False);
        AddXMLNode(CurrentNode , 'dateDelivered'    ,'',False);
        AddXMLNode(CurrentNode , 'delivNoteNum'     ,InToStrWith0(InvoiceObj.ID, 10),False);
        AddXMLNode(CurrentNode , 'chargedDelivCode' ,'',False);
        AddXMLNode(CurrentNode , 'delivAddress'     ,Trim(InvoiceObj.ShipToDesc )+ ' ' + Invoiceobj.VeteranPhoneNo,False);
        AddXMLNode(CurrentNode , 'delivPostcode'    ,TRim(InvoiceObj.VeteranPostcode),False);
        AddXMLNode(CurrentNode , 'clientSurname'    ,TRim(InvoiceObj.VeteranSurname),False);
        AddXMLNode(CurrentNode , 'clientInitial'    ,TRim(InvoiceObj.VeteranInitial),False);
        AddXMLNode(CurrentNode , 'clientGender'     ,TRim(InvoiceObj.VeteranGender),False);
        AddXMLNode(CurrentNode , 'clientPostcode'   ,TRim(InvoiceObj.VeteranShipPOCode),False);
        AddXMLNode(CurrentNode , 'priorApprNum'     ,TRim(InvoiceObj.PriorApprovalRefNo),False);
        AddXMLNode(CurrentNode , 'invoiceComments' ,TruncateStr(Invoiceobj.Comments ,250),False);
        AddXMLNode(CurrentNode , 'productGroup'     ,AppEnv.Companyinfo.RAPProductGroup,False);
        InvoceNode := InvoceNode.Addchild('invoiceLines');
    End;
    if not Assigned(InvoceNode) then exit;
    if not ValidateLineFieldRange then begin
        Abort := True;
        Exit;
    end;
    CurrentNode := InvoceNode.Addchild('invoiceLine');
    AddXMLNode(CurrentNode , 'lineNum',InToStrWith0(InvoiceObj.Lines.Dataset.Recno,3),False);
    AddXMLNode(CurrentNode , 'contractNum',AppEnv.Companyinfo.RAPContractNumber,False);
    AddXMLNode(CurrentNode , 'scheduleItemID',InvoiceObj.Lines.RAPProductCode,False);
    AddXMLNode(CurrentNode , 'catlgItemNum',InvoiceObj.Lines.ProductName,False);
    AddXMLNode(CurrentNode , 'ean','',False);
(*    AddXMLNode(CurrentNode , 'providerNum',InvoiceObj.Lines.ProviderNum,False);
    AddXMLNode(CurrentNode , 'prescriberType',InvoiceObj.Lines.PrescriberTypecode,False);*)
    AddXMLNode(CurrentNode , 'providerNum',InvoiceObj.ProviderNum,False);
    AddXMLNode(CurrentNode , 'prescriberType',InvoiceObj.PrescriberTypecode,False);
    AddXMLNode(CurrentNode , 'dateLastPresc',InvoiceObj.SaleDate,False);
    AddXMLNode(CurrentNode , 'linePriorApprNum','',False);
    AddXMLNode(CurrentNode , 'orderRecDate',InvoiceObj.SaleDate,False);
    AddXMLNode(CurrentNode , 'hireBuyInd','B',False); // for the time being is B, R is not implemented
    AddXMLNode(CurrentNode , 'hireStartDate','',False);
    AddXMLNode(CurrentNode , 'hireReturnDate','',False);
    AddXMLNode(CurrentNode , 'hirePeriodStart','',False);
    AddXMLNode(CurrentNode , 'hirePeriodEnd','',False);
    AddXMLNode(CurrentNode , 'itemDesc',InvoiceObj.Lines.ProductDescription,False);
    AddXMLNode(CurrentNode , 'orderedDelivCode',InvoiceObj.DVADeliveryCode,False);
    AddXMLNode(CurrentNode , 'quantity',InvoiceObj.Lines.QtyShipped,False);
    AddXMLNode(CurrentNode , 'unitPrice',Round(InvoiceObj.Lines.LinePrice,2),False);
    AddXMLNode(CurrentNode , 'unitGST',Round(InvoiceObj.Lines.LineTaxRate * InvoiceObj.Lines.LinePrice,2),False);
    AddXMLNode(CurrentNode , 'serialNum',InvoiceObj.Lines.SoldSerials,False);
end;
function TRAPSubmission.REsubmit:boolean;
var
    strSQL:String;
begin
  Result := False;
  if not Save then Exit;
  if (Receivedsubmissionreport) and (Founderrors) and (Resubmittedid = 0) then begin
    if CloneBusObj('Parentsubmissionid' , ID , False ) <> nil then begin
        TRAPSubmission(ObjInstanceToClone).Submissiondate    := dateof(now);
        TRAPSubmission(ObjInstanceToClone).Submitted         := False;
        TRAPSubmission(ObjInstanceToClone).Receivedsubmissionreport := False;
        TRAPSubmission(ObjInstanceToClone).Founderrors       := False;
        TRAPSubmission(ObjInstanceToClone).Submissionerrormessage := '';
        TRAPSubmission(ObjInstanceToClone).Paymentreceived   := False;
        TRAPSubmission(ObjInstanceToClone).Amountreceived    := 0;
        TRAPSubmission(ObjInstanceToClone).Resubmittedid     := 0;
        TRAPSubmission(ObjInstanceToClone).PostDB;
        strSQL :=TRAPSubmission(ObjInstanceToClone).Xmlfilename;
        TRAPSubmission(ObjInstanceToClone).XMLFileName := '';
        TRAPSubmission(ObjInstanceToClone).Save;
        {resubmitting should unlock the invoices, so that the errors can be corrected}
        strSQL := 'update tblSales, tblRAPSubmissionLines ' +
                ' set tblSales.RapSubmitstatus = "" ' +
                ' Where tblSales.SaleId =tblRAPSubmissionLines.SaleId'+
                ' and tblRAPSubmissionLines.SubmissionId = ' + FastFuncs.IntToStr(TRAPSubmission(ObjInstanceToClone).ID);
        TRAPSubmission(ObjInstanceToClone).getNewDataset(strSQL, True);
        ResubmittedID := TRAPSubmission(ObjInstanceToClone).ID;
        Save;
        REsult := True;
    End;
  end;
end;
procedure TRAPSubmission.LockSalesRecord(Const Sender: TBusObj; var Abort: boolean);
begin
    if not UserLock.Lock('tblSales' , TRapSubmissionlines(Sender).saleID , LockGroupName) then
        allvalid := False;
end;
Function TRAPSubmission.CreateRAPXML: IXMLDocument;
var
  RapXMLDoc: IXMLDocument;
  node: IXMLNode;
  Currentnode: IXMLNode;
begin
  Result := nil;
  if not ValidateFieldRange then Exit;
  AllValid := True;
  RapXMLDoc:= TXMLDocument.Create('');
 { NOTE: Do not use doNodeAutoIndent option as this stuffs up XML
        comparison in business objects (indents are returned as Text nodes) }
  //RapXMLDoc.Options := RapXMLDoc.Options + [doNodeAutoIndent];

  try
    RapXMLDoc.Active := true;
    RapXMLDoc.Version := XMLDocVersion;
    RapXMLDoc.Encoding := XMLDOCANSIEncoding;
    node:= RapXMLDoc.AddChild('dvaBatch');
    Currentnode:= node.AddChild('batchHeader');
    AddXMLNode(Currentnode , 'dateFormat' , 'YYYY-MM-DD',False);
    AddXMLNode(Currentnode , 'currency' , '$A',False);
    AddXMLNode(Currentnode , 'dvaFileType' , 'RAPInvoice',False);
    AddXMLNode(Currentnode , 'supplierID' , AppEnv.Companyinfo.Supplierid,False);
    AddXMLNode(Currentnode , 'dateFileCreated' , Now,False);
    AddXMLNode(Currentnode , 'suppSubmID' , ID,False);
    AddXMLNode(Currentnode , 'totalInvoices' , Totalinvoices,False);
    Currentnode:= node.AddChild('invoices');
    Lines.RapXMLTag :=Currentnode;
    Lines.IterateRecords(CreateRAPInvoiceXML);
    if not AllValid then Exit;
    if Assigned(InvoiceObj) then FreeandNil(InvoiceObj);
    result := RapXMLDoc;
  finally
    RapXMLDoc:= nil;
  end;


end;

procedure TRAPSubmission.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TRAPSubmission.DoFieldOnChange(Sender: TField);
begin
    if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
        if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
    inherited;
    if FastFuncs.SameText(Sender.FieldName , 'PaymentReceived') then begin
        if Assigned(FormProc) then FormProc;
        if PaymentReceived then begin
            AmountReceived := RequestedAmount; // the amount is always paid in full, no partial payment allowed
        end else begin
            AmountReceived :=0;
            DepositId := 0;
        end;
    end else if FastFuncs.SameText(Sender.FieldName , 'ReceivedSubmissionReport') then begin
        if Assigned(FormProc) then FormProc;
        if not ReceivedSubmissionReport then begin
            foundErrors := False;
        end;
    end else if FastFuncs.SameText(Sender.FieldName , 'foundErrors') then begin
        if Assigned(FormProc) then FormProc;
    end else if FastFuncs.SameText(Sender.FieldName , 'Submitted') then begin
        if Assigned(FormProc) then FormProc;
        if not Submitted then begin
            ReceivedSubmissionReport := False;
            foundErrors := False;
        end;
    end;
end;

Function TRAPSubmission.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblrapsubmission';
   Result := Inherited getSQL;
end;

class function  TRAPSubmission.GetIDField : String;
begin
   Result := 'Submissionid'
end;
class function TRAPSubmission.GetBusObjectTableName: string;
begin
  Result := 'tblrapsubmission';
end;

Function  TRAPSubmission.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;
Procedure TRAPSubmission.ClonePropertyObjects;
begin
    (*if not assigned(fLines) then Lines;
    if not assigned(fLines) then Exit;*)
    Lines.IterateRecords(CloneLines);
end;
procedure TRAPSubmission.CloneLines(const Sender: TBusObj; var Abort: boolean);
begin
    Sender.CloneBusObj(IDFieldNAme , ObjInstanceToClone.ID, False);
end;
Function TRAPSubmission.getLines:TRAPSubmissionLines;
begin
    (*if not Assigned(fLines) then begin
        fLines := TRAPSubmissionLines.Create(self);
        if Assigned(Self.connection) then flines.Connection := Self.Connection;
        flines.LoadSelect('Submissionid = ' + FastFuncs.IntToStr(Self.ID));
    end else if (not Assigned(fLines.Dataset)) or (fLines.Dataset.Active = False) or (fLines.Submissionid <> Self.ID) then begin
        flines.LoadSelect('Submissionid = ' + FastFuncs.IntToStr(Self.ID));
    end;
    Result := fLines;*)
    Result := TRAPSubmissionLines(getContainerComponent(TRAPSubmissionLines, 'Submissionid = ' + FastFuncs.IntToStr(Self.ID)));
end;
Function TRAPSubmission.getcleanPaymentReceived          :Boolean;
begin
      result:= GetXMLNodeBooleanValue(CleanXMLNode, 'PaymentReceived');
end;
Function TRAPSubmission.getRAPXMLFileName :String;
begin
    if fsRAPXMLFileName = '' then
        fsRAPXMLFileName:= ExtractFilePath(Application.ExeName)+ FastFuncs.IntToStr(ID)+'.XML';
    Result := fsRAPXMLFileName;
end;
{Property functions}
Function  TRAPSubmission.GetSubmissiondate          :TDatetime ; begin Result := GetDatetimeField('Submissiondate');End;
Function  TRAPSubmission.GetTotalinvoices           :Integer   ; begin Result := GetIntegerField('Totalinvoices');End;
Function  TRAPSubmission.GetSubmitted               :Boolean   ; begin Result := GetBooleanField('Submitted');End;
Function  TRAPSubmission.GetXmlfilename             :String    ; begin Result := GetStringField('Xmlfilename');End;
Function  TRAPSubmission.GetReceivedsubmissionreport:Boolean   ; begin Result := GetBooleanField('Receivedsubmissionreport');End;
Function  TRAPSubmission.GetFounderrors             :Boolean   ; begin Result := GetBooleanField('Founderrors');End;
Function  TRAPSubmission.GetSubmissionerrormessage  :String    ; begin Result := GetStringField('Submissionerrormessage');End;
Function  TRAPSubmission.GetParentsubmissionid      :Integer   ; begin Result := GetIntegerField('Parentsubmissionid');End;
Function  TRAPSubmission.GetRequestedamount         :Double    ; begin Result := GetFloatField('Requestedamount');End;
Function  TRAPSubmission.GetPaymentreceived         :Boolean   ; begin Result := GetBooleanField('Paymentreceived');End;
Function  TRAPSubmission.GetAmountreceived          :Double    ; begin Result := GetFloatField('Amountreceived');End;
Function  TRAPSubmission.GetActive                  :Boolean   ; begin Result := GetBooleanField('Active');End;
Function  TRAPSubmission.GetResubmittedid           :Integer   ; begin Result := GetIntegerField('Resubmittedid');End;
Function  TRAPSubmission.GetDepositID               :Integer   ; begin Result := GetIntegerField('DepositID');End;
Procedure TRAPSubmission.SetSubmissiondate          (Const Value :TDatetime ); begin SetDatetimeField('Submissiondate'           , Value);End;
Procedure TRAPSubmission.SetTotalinvoices           (Const Value :Integer   ); begin SetIntegerField('Totalinvoices'            , Value);End;
Procedure TRAPSubmission.SetSubmitted               (Const Value :Boolean   ); begin SetBooleanField('Submitted'                , Value);End;
Procedure TRAPSubmission.SetXmlfilename             (Const Value :String    ); begin SetStringField('Xmlfilename'              , Value);End;
Procedure TRAPSubmission.SetReceivedsubmissionreport(Const Value :Boolean   ); begin SetBooleanField('Receivedsubmissionreport'              , Value);End;
Procedure TRAPSubmission.SetFounderrors             (Const Value :Boolean   ); begin SetBooleanField('Founderrors'              , Value);End;
Procedure TRAPSubmission.SetSubmissionerrormessage  (Const Value :String    ); begin SetStringField('Submissionerrormessage'   , Value);End;
Procedure TRAPSubmission.SetParentsubmissionid      (Const Value :Integer   ); begin SetIntegerField('Parentsubmissionid'       , Value);End;
Procedure TRAPSubmission.SetRequestedamount         (Const Value :Double    ); begin SetFloatField('Requestedamount'          , Value);End;
Procedure TRAPSubmission.SetPaymentreceived         (Const Value :Boolean   ); begin SetBooleanField('Paymentreceived'          , Value);End;
Procedure TRAPSubmission.SetAmountreceived          (Const Value :Double    ); begin SetFloatField('Amountreceived'           , Value);End;
Procedure TRAPSubmission.SetActive                  (Const Value :Boolean   ); begin SetBooleanField('Active'                   , Value);End;
Procedure TRAPSubmission.SetResubmittedid           (Const Value :Integer   ); begin SetIntegerField('Resubmittedid'            , Value);End;
Procedure TRAPSubmission.SetDepositID               (Const Value :Integer   ); begin SetIntegerField('DepositID'            , Value);End;


{========================================================
         TRAPSubmissionLines
========================================================}
constructor TRAPSubmissionLines.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   RapXMLTag := nil;
end;


destructor TRAPSubmissionLines.Destroy;
begin
   inherited;
end;


procedure   TRAPSubmissionLines.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'Submissionid');
    SetPropertyFromNode(Node,'Saleid');
    SetPropertyFromNode(Node,'Salelineid');
end;


procedure   TRAPSubmissionLines.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Submissionid' ,Submissionid);
      AddXMLNode(node,'Saleid' ,Saleid);
      AddXMLNode(node,'Salelineid' ,Salelineid);
end;


function    TRAPSubmissionLines.ValidateData :Boolean ;
begin
   Resultstatus.Clear;
   Result := true;
end;


function    TRAPSubmissionLines.Save :Boolean ;
begin
   Result := False;
   postDb;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TRAPSubmissionLines.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TRAPSubmissionLines.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TRAPSubmissionLines.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblrapsubmissionlines';
   Result := Inherited getSQL;
end;


class function TRAPSubmissionLines.GetIDField : String;
begin
   Result := 'Submissionlineid'
end;
class function TRAPSubmissionLines.GetBusObjectTableName: string;
begin
  Result := 'tblrapsubmissionlines';
end;

Function  TRAPSubmissionLines.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
   if Assigned(self.Owner) and (Self.Owner is TRAPSubmission) then
    TRAPSubmission(Self.Owner).Totalinvoices := Self.Count;
End;


{Property functions}
Function  TRAPSubmissionLines.GetSubmissionid    :Integer   ; begin Result := GetIntegerField('Submissionid');End;
Function  TRAPSubmissionLines.GetSaleid          :Integer   ; begin Result := GetIntegerField('Saleid');End;
Function  TRAPSubmissionLines.GetSalelineid      :Integer   ; begin Result := GetIntegerField('Salelineid');End;
Procedure TRAPSubmissionLines.SetSubmissionid    (Const Value :Integer   ); begin SetIntegerField('Submissionid'     , Value);End;
Procedure TRAPSubmissionLines.SetSaleid          (Const Value :Integer   ); begin SetIntegerField('Saleid'           , Value);End;
Procedure TRAPSubmissionLines.SetSalelineid      (Const Value :Integer   ); begin SetIntegerField('Salelineid'       , Value);End;


{========================================================
         TRAPDeliveryCode
========================================================}
constructor TRAPDeliveryCode.Create(AOwner: TComponent);
begin
   inherited Create(AOwner)
end;


destructor TRAPDeliveryCode.Destroy;
begin
   inherited;
end;


procedure   TRAPDeliveryCode.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'Deliverycode');
    SetPropertyFromNode(Node,'Description');
    SetBooleanPropertyFromNode(Node,'Active');
end;


procedure   TRAPDeliveryCode.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Deliverycode' ,Deliverycode);
      AddXMLNode(node,'Description' ,Description);
      AddXMLNode(node,'Active' ,Active);
end;


function    TRAPDeliveryCode.ValidateData :Boolean ;
begin
   Resultstatus.Clear;
   Result := true;
end;


function    TRAPDeliveryCode.Save :Boolean ;
begin
   Result := False;
   postDb;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TRAPDeliveryCode.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TRAPDeliveryCode.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TRAPDeliveryCode.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblrapdeliverycodes';
   Result := Inherited getSQL;
end;

class function  TRAPDeliveryCode.GetIDField : String;
begin
   Result := 'Deliverycodeid'
end;
class function TRAPDeliveryCode.GetBusObjectTableName: string;
begin
   Result := 'tblrapdeliverycodes';
end;

Function  TRAPDeliveryCode.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;

{Property functions}
Function  TRAPDeliveryCode.GetDeliverycode  :String    ; begin Result := GetStringField('Deliverycode');End;
Function  TRAPDeliveryCode.GetDescription   :String    ; begin Result := GetStringField('Description');End;
Function  TRAPDeliveryCode.GetActive        :Boolean   ; begin Result := GetBooleanField('Active');End;
Procedure TRAPDeliveryCode.SetDeliverycode  (Const Value :String    ); begin SetStringField('Deliverycode'   , Value);End;
Procedure TRAPDeliveryCode.SetDescription   (Const Value :String    ); begin SetStringField('Description'    , Value);End;
Procedure TRAPDeliveryCode.SetActive        (Const Value :Boolean   ); begin SetBooleanField('Active'         , Value);End;


{========================================================
         TRapPrescriber
========================================================}
constructor TRapPrescriber.Create(AOwner: TComponent);
begin
   inherited Create(AOwner)
end;


destructor TRapPrescriber.Destroy;
begin
   inherited;
end;


procedure   TRapPrescriber.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'Prescribername');
end;


procedure   TRapPrescriber.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
      AddXMLNode(node,'Prescribername' ,Prescribername);
end;


function    TRapPrescriber.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Prescribername = '' then begin
      Resultstatus.AddItem(False , rssError , 0,  'Prescribername should not be blank' , False );
      Exit;
   end;
   Result := true;
end;


function    TRapPrescriber.Save :Boolean ;
begin
   Result := False;
   postDb;
   lines.PostDb;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TRapPrescriber.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TRapPrescriber.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TRapPrescriber.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblrapprescriber';
   Result := Inherited getSQL;
end;

class function  TRapPrescriber.GetIDField : String;
begin
   Result := 'Prescriberid'
end;

class function TRapPrescriber.GetBusObjectTableName: string;
begin
  Result := 'tblrapprescriber';
end;

Function  TRapPrescriber.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
End;


{Property functions}
Function  TRapPrescriber.GetPrescribername:String    ; begin Result := GetStringField('Prescribername');End;
Procedure TRapPrescriber.SetPrescribername(Const Value :String    ); begin SetStringField('Prescribername' , Value);End;
Function TRapPrescriber.getLines:TRapPrescriberTypes;
begin
    //if ID = 0 then PostDB;
    (*if not Assigned(fLines) then begin
        fLines := TRapPrescriberTypes.Create(self);
        if Assigned(Self.connection) then flines.Connection := Self.Connection;
        flines.LoadSelect('PrescriberID = ' + FastFuncs.IntToStr(Self.ID));
    end else if (not Assigned(fLines.Dataset)) or (fLines.Dataset.Active = False) or (fLines.PrescriberID <> Self.ID) then begin
        flines.LoadSelect('PrescriberID = ' + FastFuncs.IntToStr(Self.ID));
    end;
    Result := fLines;*)
    Result := TRapPrescriberTypes(getContainerComponent(TRapPrescriberTypes,'PrescriberID = ' + FastFuncs.IntToStr(Self.ID)));
end;


{========================================================
         TRapPrescriberTypes
========================================================}
constructor TRapPrescriberTypes.Create(AOwner: TComponent);
begin
   inherited Create(AOwner)
end;


destructor TRapPrescriberTypes.Destroy;
begin
   inherited;
end;


procedure   TRapPrescriberTypes.LoadFromXMLNode(Const node: IXMLNode);
begin
   inherited;
    SetPropertyFromNode(Node,'Prescriberid');
    SetPropertyFromNode(Node,'Prescribertypeid');
end;


procedure   TRapPrescriberTypes.SaveToXMLNode(Const node: IXMLNode);
begin
   inherited;
   AddXMLNode(node,'Prescriberid' ,Prescriberid);
   AddXMLNode(node,'Prescribertypeid' ,Prescribertypeid);
end;


function    TRapPrescriberTypes.ValidateData :Boolean ;
begin
   Result := False;
   Resultstatus.Clear;
   if Prescriberid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Prescriberid should not be 0' , False );
      Exit;
   end;
   if Prescribertypeid = 0 then begin
      Resultstatus.AddItem(False , rssError , 0,  'Prescribertypeid should not be 0' , False );
      Exit;
   end;
   Result := true;
end;


function    TRapPrescriberTypes.Save :Boolean ;
begin
   Result := False;
   postDb;
   if not ValidateData then Exit;
   Result := Inherited Save;
end;


procedure TRapPrescriberTypes.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
   inherited;
end;


procedure TRapPrescriberTypes.DoFieldOnChange(Sender: TField);
begin
   inherited;
end;


Function TRapPrescriberTypes.GetSQL: String ;
begin
   fSQL := 'SELECT * FROM tblrapprescribertypes';
   Result := Inherited getSQL;
end;


class function  TRapPrescriberTypes.GetIDField : String;
begin
   Result := 'Id'
end;

class function TRapPrescriberTypes.GetBusObjectTableName: string;
begin
  Result := 'tblrapprescribertypes';
end;

Function  TRapPrescriberTypes.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
   Result := inherited DoAfterPost(sender);
   if not result then Exit;
   if PrescriberTypeId = 0 then Dataset.Delete;
End;
Function  TRapPrescriberTypes.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
    Result := inherited DoAfterPost(sender);
    if not result then Exit;
    if Assigned(Sender.owner) then
        if Sender.Owner is    TRapPrescriber then
            Prescriberid := TRapPrescriber(Sender.Owner).Id;
end;

{Property functions}
Function  TRapPrescriberTypes.GetPrescriberid    :Integer   ; begin Result := GetIntegerField('Prescriberid');End;
Function  TRapPrescriberTypes.GetPrescribertypeid:Integer   ; begin Result := GetIntegerField('Prescribertypeid');End;
Procedure TRapPrescriberTypes.SetPrescriberid    (Const Value :Integer   ); begin SetIntegerField('Prescriberid'     , Value);End;
Procedure TRapPrescriberTypes.SetPrescribertypeid(Const Value :Integer   ); begin SetIntegerField('Prescriberid'     , Value);End;


initialization
    RegisterClassOnce(TRapPrescriberTypes);
    RegisterClassOnce(TRapPrescriber);
    RegisterClassOnce(TRAPDeliveryCode);
    RegisterClassOnce(TRAPSubmissionLines);
    RegisterClassOnce(TRAPSubmission);
    RegisterClassOnce(TRAPproducts);
    RegisterClassOnce(TRAPprescriberTypeitems);
    RegisterClassOnce(TRAPprescriberType);
    RegisterClassOnce(TRAPCategory);


end.
