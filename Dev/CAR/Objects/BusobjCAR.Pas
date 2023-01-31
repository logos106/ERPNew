unit BusobjCAR;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  19/11/13  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, busobjorders, BusobjSaleBase,Busobjcustomfields;


type
  TCARPropeties= class(TMSBusObj)
    Private
      function GetSeqno               : Integer   ;
      procedure SetSeqno               (const Value: Integer   );
      function GetCARID               : Integer   ;
      procedure SetCARID               (const Value: Integer   );
    Protected
      fiLastSeqno:Integer;
      function  DoBeforeInsert(Sender:TDatasetBusObj): Boolean;           override;
      function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
      function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;           override;
      function EmptyRecord:Boolean;virtual;
    public
      procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
      procedure    SaveToXMLNode(const node: IXMLNode);                   override;
      function     ValidateData: Boolean ;                                override;
    Published
      property Seqno                :Integer     read GetSeqno              write SetSeqno           ;
      property CARID                :Integer     read GetCARID              write SetCARID           ;
  end;

  TCARReview = Class(TCARPropeties)
  private


    function GetReviewComments      : string    ;
    function GetRepID               : Integer   ;
    function GetRep                 : string    ;
    function GetReviewdon           : TDateTime ;

    procedure SetReviewComments      (const Value: string    );
    procedure SetRepID               (const Value: Integer   );
    procedure SetRep                 (const Value: string    );
    procedure SetReviewdon           (const Value: TDateTime );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function EmptyRecord:Boolean;Override;
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
    property ReviewComments       :string      read GetReviewComments     write SetReviewComments  ;
    property RepID                :Integer     read GetRepID              write SetRepID           ;
    property Rep                  :string      read GetRep                write SetRep             ;
    property Reviewdon            :TDateTime   read GetReviewdon          write SetReviewdon       ;
  end;
  TCARPrevMeasures = Class(TCARPropeties)
  private
    function GetPreventiveActioncomments    : string    ;
    function GetPreventiveDetails           : string    ;
    function GetRepID                       : Integer   ;
    function GetRep                         : string    ;
    function GetActionDate                  : TDateTime ;
    procedure SetPreventiveActioncomments    (const Value: string    );
    procedure SetPreventiveDetails           (const Value: string    );
    procedure SetRepID                       (const Value: Integer   );
    procedure SetRep                         (const Value: string    );
    procedure SetActionDate                  (const Value: TDateTime );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function EmptyRecord:Boolean;Override;
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
    property PreventiveActioncomments     :string      read GetPreventiveActioncomments   write SetPreventiveActioncomments;
    property PreventiveDetails            :string      read GetPreventiveDetails          write SetPreventiveDetails       ;
    property RepID                        :Integer     read GetRepID                      write SetRepID                   ;
    property Rep                          :string      read GetRep                        write SetRep                     ;
    property ActionDate                   :TDateTime   read GetActionDate                 write SetActionDate              ;
  end;

  TCAROutComeReview = Class(TCARPropeties)
  private
    function GetActionorOutCome     : string    ;
    function GetRepID               : Integer   ;
    function GetRep                 : string    ;
    function GetClosedouton         : TDateTime ;
    procedure SetActionorOutCome     (const Value: string    );
    procedure SetRepID               (const Value: Integer   );
    procedure SetRep                 (const Value: string    );
    procedure SetClosedouton         (const Value: TDateTime );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function EmptyRecord:Boolean;Override;
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
    property ActionorOutCome      :string      read GetActionorOutCome    write SetActionorOutCome ;
    property RepID                :Integer     read GetRepID              write SetRepID           ;
    property Rep                  :string      read GetRep                write SetRep             ;
    property Closedouton          :TDateTime   read GetClosedouton        write SetClosedouton     ;
  end;
  TCARAction = Class(TCARPropeties)
  private
    function GetActionRequired      : string    ;
    function GetImmediateDetails    : string    ;
    function GetRepID               : Integer   ;
    function GetRep                 : string    ;
    function GetActionDate          : TDateTime ;
    procedure SetActionRequired      (const Value: string    );
    procedure SetImmediateDetails    (const Value: string    );
    procedure SetRepID               (const Value: Integer   );
    procedure SetRep                 (const Value: string    );
    procedure SetActionDate          (const Value: TDateTime );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function EmptyRecord:Boolean;Override;
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
    property ActionRequired       :string      read GetActionRequired     write SetActionRequired  ;
    property ImmediateDetails     :string      read GetImmediateDetails   write SetImmediateDetails;
    property RepID                :Integer     read GetRepID              write SetRepID           ;
    property Rep                  :string      read GetRep                write SetRep             ;
    property ActionDate           :TDateTime   read GetActionDate         write SetActionDate      ;
  end;

  TCorrectiveActionReports = class(TMSBusObj)
  private
    fbAllLinesValid: Boolean;
    function GetComplaintfromID          : Integer   ;
    function GetComplaintFrom            : string    ;
    function GetContactID                : Integer   ;
    function GetSupContactID             : Integer   ;
    function GetcontactName              : string    ;
    function GetSupContactname           : string    ;
    function GetComplaintType            : string    ;
    function GetProductID                : Integer   ;
    function GetProductName              : string    ;
    function GetEnteredByID              : Integer   ;
    function GetEnteredBy                : string    ;
    function GetReportedDate             : TDateTime ;
    function GetSalesID                  : Integer   ;
    function GetSalesLineID              : Integer   ;
    function GetProductionBuild          : string    ;
    function GetProductionBuildDesc      : string    ;
    function GetSupplierID               : Integer   ;
    function GetSupplierName             : string    ;
    function GetPOID                     : Integer   ;
    function GetPOLineID                 : Integer   ;
    function GetDescriptionofProblem     : string    ;
    function GetImprovementSuggestion    : string    ;
    function GetRepID                    : Integer   ;
    function GetRep                      : string    ;
    procedure SetComplaintfromID          (const Value: Integer   );
    procedure SetComplaintFrom            (const Value: string    );
    procedure SetContactID                (const Value: Integer   );
    procedure SetSupContactID             (const Value: Integer   );
    procedure SetcontactName              (const Value: string    );
    procedure SetSupContactName           (const Value: string    );
    procedure SetComplaintType            (const Value: string    );
    procedure SetProductID                (const Value: Integer   );
    procedure SetProductName              (const Value: string    );
    procedure SetEnteredByID              (const Value: Integer   );
    procedure SetEnteredBy                (const Value: string    );
    procedure SetReportedDate             (const Value: TDateTime );
    procedure SetSalesID                  (const Value: Integer   );
    procedure SetSalesLineID              (const Value: Integer   );
    procedure SetProductionBuild          (const Value: string    );
    procedure SetProductionBuildDesc      (const Value: string    );
    procedure SetSupplierID               (const Value: Integer   );
    procedure SetSupplierName             (const Value: string    );
    procedure SetPOID                     (const Value: Integer   );
    procedure SetPOLineID                 (const Value: Integer   );
    procedure SetDescriptionofProblem     (const Value: string    );
    procedure SetImprovementSuggestion    (const Value: string    );
    procedure SetRepID                    (const Value: Integer   );
    procedure SetRep                      (const Value: string    );
    function getCARAction: TCARAction;
    function getCAROutComeReview: TCAROutComeReview;
    function getCARPrevMeasures: TCARPrevMeasures;
    function getCARReview: TCARReview;
    function getPOLine: TPurchaseOrderLine;
    function getSaleLine: TSaleslineBase;
    function getCAROutComeReviewOptions: TCAROutComeReviewOptions;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Procedure ValdiateDataCallback(const Sender: TBusObj; var Abort: Boolean);
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    function ValidateSales(const MakeBlankwheninvalid:Boolean):Boolean;
    function ValidatePO(const MakeBlankwheninvalid:Boolean):Boolean;
  published
    property ComplaintfromID           :Integer     read GetComplaintfromID         write SetComplaintfromID      ;
    property ComplaintFrom             :string      read GetComplaintFrom           write SetComplaintFrom        ;
    property ContactID                 :Integer     read GetContactID               write SetContactID            ;
    property SupContactID              :Integer     read GetSupContactID            write SetSupContactID         ;
    property contactName               :string      read GetcontactName             write SetcontactName          ;
    property SupContactName            :string      read GetSupContactName          write SetSupContactName       ;
    property ComplaintType             :string      read GetComplaintType           write SetComplaintType        ;
    property ProductID                 :Integer     read GetProductID               write SetProductID            ;
    property ProductName               :string      read GetProductName             write SetProductName          ;
    property EnteredByID               :Integer     read GetEnteredByID             write SetEnteredByID          ;
    property EnteredBy                 :string      read GetEnteredBy               write SetEnteredBy            ;
    property ReportedDate              :TDateTime   read GetReportedDate            write SetReportedDate         ;
    property SalesID                   :Integer     read GetSalesID                 write SetSalesID              ;
    property SalesLineID               :Integer     read GetSalesLineID             write SetSalesLineID          ;
    property ProductionBuild           :string      read GetProductionBuild         write SetProductionBuild      ;
    property ProductionBuildDesc       :string      read GetProductionBuildDesc     write SetProductionBuildDesc  ;
    property SupplierID                :Integer     read GetSupplierID              write SetSupplierID           ;
    property SupplierName              :string      read GetSupplierName            write SetSupplierName         ;
    property POID                      :Integer     read GetPOID                    write SetPOID                 ;
    property POLineID                  :Integer     read GetPOLineID                write SetPOLineID             ;
    property DescriptionofProblem      :string      read GetDescriptionofProblem    write SetDescriptionofProblem ;
    property ImprovementSuggestion     :string      read GetImprovementSuggestion   write SetImprovementSuggestion;
    property RepID                     :Integer     read GetRepID                   write SetRepID                ;
    property Rep                       :string      read GetRep                     write SetRep                  ;
    Property CARReview                : TCARReview                read getCARReview;
    Property CARPrevMeasures          : TCARPrevMeasures          read getCARPrevMeasures;
    Property CAROutComeReview         : TCAROutComeReview         read getCAROutComeReview;
    Property CARAction                : TCARAction                read getCARAction;
    Property POLine                   : TPurchaseOrderLine        read getPOLine;
    Property SaleLine                 : TSaleslineBase            Read getSaleLine;
    Property CAROutComeReviewOptions  : TCAROutComeReviewOptions  read getCAROutComeReviewOptions;


  end;


implementation


uses tcDataUtils, CommonLib, BusObjClient, BusObjStock, BusObjEmployee, sysutils, BusObjContact, AppEnvironment, BusObjConst;



  {TCorrectiveActionReports}

constructor TCorrectiveActionReports.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CorrectiveActionReports';
  fSQL := 'SELECT * FROM tblcar';
end;


destructor TCorrectiveActionReports.Destroy;
begin
  inherited;
end;


procedure TCorrectiveActionReports.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ComplaintfromID');
  SetPropertyFromNode(node,'ComplaintFrom');
  SetPropertyFromNode(node,'ContactID');
  SetPropertyFromNode(node,'SupContactID');
  SetPropertyFromNode(node,'contactName');
  SetPropertyFromNode(node,'SupContactName');
  SetPropertyFromNode(node,'ComplaintType');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'EnteredByID');
  SetPropertyFromNode(node,'EnteredBy');
  SetDateTimePropertyFromNode(node,'ReportedDate');
  SetPropertyFromNode(node,'SalesID');
  SetPropertyFromNode(node,'SalesLineID');
  SetPropertyFromNode(node,'ProductionBuild');
  SetPropertyFromNode(node,'ProductionBuildDesc');
  SetPropertyFromNode(node,'SupplierID');
  SetPropertyFromNode(node,'SupplierName');
  SetPropertyFromNode(node,'POID');
  SetPropertyFromNode(node,'POLineID');
  SetPropertyFromNode(node,'DescriptionofProblem');
  SetPropertyFromNode(node,'ImprovementSuggestion');
  SetPropertyFromNode(node,'RepID');
  SetPropertyFromNode(node,'Rep');
end;


procedure TCorrectiveActionReports.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ComplaintfromID' ,ComplaintfromID);
  AddXMLNode(node,'ComplaintFrom' ,ComplaintFrom);
  AddXMLNode(node,'ContactID' ,ContactID);
  AddXMLNode(node,'SupContactID' ,SupContactID);
  AddXMLNode(node,'contactName' ,contactName);
  AddXMLNode(node,'SupContactName' ,SupContactName);
  AddXMLNode(node,'ComplaintType' ,ComplaintType);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'EnteredByID' ,EnteredByID);
  AddXMLNode(node,'EnteredBy' ,EnteredBy);
  AddXMLNode(node,'ReportedDate' ,ReportedDate);
  AddXMLNode(node,'SalesID' ,SalesID);
  AddXMLNode(node,'SalesLineID' ,SalesLineID);
  AddXMLNode(node,'ProductionBuild' ,ProductionBuild);
  AddXMLNode(node,'ProductionBuildDesc' ,ProductionBuildDesc);
  AddXMLNode(node,'SupplierID' ,SupplierID);
  AddXMLNode(node,'SupplierName' ,SupplierName);
  AddXMLNode(node,'POID' ,POID);
  AddXMLNode(node,'POLineID' ,POLineID);
  AddXMLNode(node,'DescriptionofProblem' ,DescriptionofProblem);
  AddXMLNode(node,'ImprovementSuggestion' ,ImprovementSuggestion);
  AddXMLNode(node,'RepID' ,RepID);
  AddXMLNode(node,'Rep' ,Rep);
end;


procedure TCorrectiveActionReports.ValdiateDataCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not Sender.ValidateData then begin
    fbAllLinesValid:= False;
    Abort := True;
  end;
end;

function TCorrectiveActionReports.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if (ComplaintfromID = 0) or (ComplaintFrom ='') then begin
    Resultstatus.AddItem(False , rssError , 0,  'Customer should not be blank - Please Select the Sale' , True);
    Exit;
  end;
  if (ProductID = 0) or (ProductName = '') then begin
    Resultstatus.AddItem(False , rssError , 0,  'Product should not be blank - Please Select the Sale Or Purchase Order ' , True);
    Exit;
  end;
  if (EnteredByID = 0) or (EnteredBy = '') then begin
    Resultstatus.AddItem(False , rssError , 0,  'Entered By should not be blank' , True);
    Exit;
  end;
  fbAllLinesValid:= True;
  CARReview.iterateREcords(ValdiateDataCallback);
  if not fbAllLinesValid then begin
    Result:= False;
    Exit;
  end;

  fbAllLinesValid:= True;
  CARPrevMeasures.iterateREcords(ValdiateDataCallback);
  if not fbAllLinesValid then begin
    Result:= False;
    Exit;
  end;

  fbAllLinesValid:= True;
  CAROutComeReview.iterateREcords(ValdiateDataCallback);
  if not fbAllLinesValid then begin
    Result:= False;
    Exit;
  end;

  fbAllLinesValid:= True;
  CARAction.iterateREcords(ValdiateDataCallback);
  if not fbAllLinesValid then begin
    Result:= False;
    Exit;
  end;


  Result := True;
end;


function TCorrectiveActionReports.ValidatePO(const MakeBlankwheninvalid: Boolean): Boolean;
var
  S:String;
begin
  result:= True;
  if productID =0 then exit;
  s:= 'Select PL.PurchaseLineID  from tblpurchaselines PL inner join tblpurchaseorders PO using (PurchaseOrderID) where PL.productId = ' + inttostr(ProductID);
  if POLineID<> 0 then s:= s +' and  PL.PurchaseLineID= ' + inttostr(POLineID)
  else if POID <> 0 then s:= s +' and PO.PurchaseOrderID= ' + inttostr(POID)
  else if SupplierID <> 0 then  s:= s +' and  PO.SupplierID =' + inttostr(POID)
  else exit;
  With getNewDataset(s, true) do try
    if recordcount =0  then begin
      if MakeBlankwheninvalid then begin
        POLineID:=0;
        POID :=0;
        SupplierID:=0;
      end else begin
        Resultstatus.AddItem(False , rssError , 0,  'Purchase Order / Supplier Selcted doesn''t have the selected Product ' +Quotedstr(ProductName) , TRue );
      end;
      REsult:= False;
    end;
  finally
    if active then close;
    Free;
  end;
end;

function TCorrectiveActionReports.ValidateSales(const MakeBlankwheninvalid: Boolean): Boolean;
var
  S:String;
begin
  result:= True;
  if productID =0 then exit;
  s:= 'Select SL.SaleLineID from tblsaleslines SL inner join tblsales S using (SaleID) where SL.productId = ' + inttostr(ProductID);
  if SalesLineID <> 0 then s:= s +' and  SL.SaleLineID  = ' + inttostr(SalesLineID)
  else if SalesID <> 0 then s:= s +' and s.sAleId = ' + inttostr(SalesID)
  else if ComplaintfromID <> 0 then  s:= s +' and  S.ClientID =' + inttostr(ComplaintfromID)
  else exit;

  With getNewDataset(s, true) do try
    if recordcount =0  then begin
      if MakeBlankwheninvalid then begin
        SalesLineID:=0;
        SalesID :=0;
        ComplaintfromID:=0;
      end else begin
        Resultstatus.AddItem(False , rssError , 0,  'Complaint From / Sales Selcted doesn''t have the selected Product ' +Quotedstr(ProductName) , TRue );
      end;
      REsult:= False;
    end;
  finally
    if active then close;
    Free;
  end;
end;

function TCorrectiveActionReports.Save: Boolean ;
begin
  Result := False;
  CARReview.postDB;
  CARPrevMeasures.postDB;
  CAROutComeReview.postDB;
  CARAction.postDB;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCorrectiveActionReports.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCorrectiveActionReports.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sametext(Sender.FieldName , 'ComplaintfromID') then begin
    ComplaintFrom   := TClient.IDToggle(ComplaintfromID, Connection.Connection);
    ContactID :=0;
    DoFieldOnChange(Dataset.FindField('ContactID'));
    SendEvent(BusObjEvent_Change , BusObjEventVal_CustomerChanged , self);
  end else if Sametext(Sender.FieldName , 'ComplaintFrom') then begin
    ComplaintfromID := TClient.IDToggle(ComplaintFrom, Connection.Connection);
    SendEvent(BusObjEvent_Change , BusObjEventVal_CustomerChanged , self);
  end else if Sametext(Sender.FieldName , 'ContactID') then begin
    contactName     := tcdatautils.getContactName(contactID);
  end else if Sametext(Sender.FieldName , 'contactName') then begin
    contactID     := tcdatautils.getContactID(contactName);
  end else if Sametext(Sender.FieldName , 'SupContactID') then begin
    SupContactName     := tcdatautils.getContactName(SupContactID);
  end else if Sametext(Sender.FieldName , 'SupContactName') then begin
    SupContactID     := tcdatautils.getContactID(SupContactName);
  end else if Sametext(Sender.FieldName , 'ProductID') then begin
    ProductName     := TProduct.IDToggle(ProductID, Connection.Connection);
    SendEvent(BusObjEvent_Change, BusObjEventVal_ProductChanged);
  end else if Sametext(Sender.FieldName , 'ProductName') then begin
    ProductID       := TProduct.IDToggle(ProductName, Connection.Connection);
    SendEvent(BusObjEvent_Change, BusObjEventVal_ProductChanged);
  end else if Sametext(Sender.FieldName , 'EnteredByID') then begin
    EnteredBy       := TEmployee.IDToggle(EnteredByID, Connection.Connection);
  end else if Sametext(Sender.FieldName , 'EnteredBy') then begin
    EnteredByID     := TEmployee.IDToggle(EnteredBy, Connection.Connection);
  end else if Sametext(Sender.FieldName , 'SupplierID') then begin
    SupplierName    := TClient.IDToggle(SupplierID, Connection.Connection);
    SupContactID :=0;
    DoFieldOnChange(Dataset.FindField('SupContactID'));
    SendEvent(BusObjEvent_Change , BusObjEventVal_SupplierChanged , self);
  end else if Sametext(Sender.FieldName , 'SupplierName') then begin
    SupplierID      := TClient.IDToggle(SupplierName, Connection.Connection);
    SupContactID :=0;
    DoFieldOnChange(Dataset.FindField('SupContactID'));
    SendEvent(BusObjEvent_Change , BusObjEventVal_SupplierChanged , self);
  end else if Sametext(Sender.FieldName , 'RepID') then begin
    Rep             := TEmployee.IDToggle(RepID, Connection.Connection);
  end else if Sametext(Sender.FieldName , 'Rep') then begin
    RepID           := TEmployee.IDToggle(Rep, Connection.Connection);
  end;
end;


function TCorrectiveActionReports.GetSQL: string;
begin
  Result := inherited GetSQL;
end;
class function TCorrectiveActionReports.GetIDField: string;
begin
  Result := 'ID'
end;
class function TCorrectiveActionReports.GetBusObjectTablename: string;
begin
  Result:= 'tblcar';
end;
function TCorrectiveActionReports.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  EnteredbyID := Appenv.Employee.EmployeeID;
  ReportedDate := Date;
end;

function TCorrectiveActionReports.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function TCorrectiveActionReports.getCARAction        : TCARAction        ;begin  Result := TCARAction(getcontainercomponent        (TCARAction         , 'CARID= ' + IntToStr(ID) , true , true));end;
function TCorrectiveActionReports.getCAROutComeReview : TCAROutComeReview ;begin  Result := TCAROutComeReview(getcontainercomponent (TCAROutComeReview  , 'CARID= ' + IntToStr(ID) , true , true));end;
function TCorrectiveActionReports.getCAROutComeReviewOptions: TCAROutComeReviewOptions;
begin
    result := TCAROutComeReviewOptions(GetContainerComponent(TCAROutComeReviewOptions ,'MasterId = ' + IntToStr(Self.ID) ));
end;

function TCorrectiveActionReports.getCARPrevMeasures  : TCARPrevMeasures  ;begin  Result := TCARPrevMeasures(getcontainercomponent  (TCARPrevMeasures   , 'CARID= ' + IntToStr(ID) , true , true));end;
function TCorrectiveActionReports.getCARReview        : TCARReview        ;begin  Result := TCARReview(getcontainercomponent        (TCARReview         , 'CARID= ' + IntToStr(ID) , true , true));end;
function TCorrectiveActionReports.getSaleLine         : TSaleslineBase    ;begin  Result := TSaleslineBase(getcontainercomponent    (TSaleslineBase     , 'SaleLineID    = ' + IntToStr(SalesLineID) , true , true));end;
function TCorrectiveActionReports.getPOLine           : TPurchaseOrderLine;begin  Result := TPurchaseOrderLine(getcontainercomponent(TPurchaseOrderLine , 'PurchaseLineID= ' + IntToStr(POLineID)    , true , true));end;
{Property Functions}
function  TCorrectiveActionReports.GetComplaintfromID      : Integer   ; begin Result := GetIntegerField('ComplaintfromID');end;
function  TCorrectiveActionReports.GetComplaintFrom        : string    ; begin Result := GetStringField('ComplaintFrom');end;
function  TCorrectiveActionReports.GetContactID            : Integer   ; begin Result := GetIntegerField('ContactID');end;
function  TCorrectiveActionReports.GetSupContactID         : Integer   ; begin Result := GetIntegerField('SupContactID');end;
function  TCorrectiveActionReports.GetcontactName          : string    ; begin Result := GetStringField('contactName');end;
function  TCorrectiveActionReports.GetSupContactName       : string    ; begin Result := GetStringField('SupContactName');end;
function  TCorrectiveActionReports.GetComplaintType        : string    ; begin Result := GetStringField('ComplaintType');end;
function  TCorrectiveActionReports.GetProductID            : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TCorrectiveActionReports.GetProductName          : string    ; begin Result := GetStringField('ProductName');end;
function  TCorrectiveActionReports.GetEnteredByID          : Integer   ; begin Result := GetIntegerField('EnteredByID');end;
function  TCorrectiveActionReports.GetEnteredBy            : string    ; begin Result := GetStringField('EnteredBy');end;
function  TCorrectiveActionReports.GetReportedDate         : TDateTime ; begin Result := GetDateTimeField('ReportedDate');end;
function  TCorrectiveActionReports.GetSalesID              : Integer   ; begin Result := GetIntegerField('SalesID');end;
function  TCorrectiveActionReports.GetSalesLineID          : Integer   ; begin Result := GetIntegerField('SalesLineID');end;
function  TCorrectiveActionReports.GetProductionBuild      : string    ; begin Result := GetStringField('ProductionBuild');end;
function  TCorrectiveActionReports.GetProductionBuildDesc  : string    ; begin Result := GetStringField('ProductionBuildDesc');end;
function  TCorrectiveActionReports.GetSupplierID           : Integer   ; begin Result := GetIntegerField('SupplierID');end;
function  TCorrectiveActionReports.GetSupplierName         : string    ; begin Result := GetStringField('SupplierName');end;
function  TCorrectiveActionReports.GetPOID                 : Integer   ; begin Result := GetIntegerField('POID');end;
function  TCorrectiveActionReports.GetPOLineID             : Integer   ; begin Result := GetIntegerField('POLineID');end;
function  TCorrectiveActionReports.GetDescriptionofProblem : string    ; begin Result := GetStringField('DescriptionofProblem');end;
function  TCorrectiveActionReports.GetImprovementSuggestion: string    ; begin Result := GetStringField('ImprovementSuggestion');end;
function  TCorrectiveActionReports.GetRepID                : Integer   ; begin Result := GetIntegerField('RepID');end;
function  TCorrectiveActionReports.GetRep                  : string    ; begin Result := GetStringField('Rep');end;
procedure TCorrectiveActionReports.SetComplaintfromID      (const Value: Integer   ); begin SetIntegerField('ComplaintfromID'       , Value);end;
procedure TCorrectiveActionReports.SetComplaintFrom        (const Value: string    ); begin SetStringField('ComplaintFrom'         , Value);end;
procedure TCorrectiveActionReports.SetContactID            (const Value: Integer   ); begin SetIntegerField('ContactID'             , Value);end;
procedure TCorrectiveActionReports.SetSupContactID         (const Value: Integer   ); begin SetIntegerField('SupContactID'          , Value);end;
procedure TCorrectiveActionReports.SetcontactName          (const Value: string    ); begin SetStringField('contactName'           , Value);end;
procedure TCorrectiveActionReports.SetSupContactName       (const Value: string    ); begin SetStringField('SupContactName'        , Value);end;
procedure TCorrectiveActionReports.SetComplaintType        (const Value: string    ); begin SetStringField('ComplaintType'         , Value);end;
procedure TCorrectiveActionReports.SetProductID            (const Value: Integer   ); begin SetIntegerField('ProductID'             , Value);end;
procedure TCorrectiveActionReports.SetProductName          (const Value: string    ); begin SetStringField('ProductName'           , Value);end;
procedure TCorrectiveActionReports.SetEnteredByID          (const Value: Integer   ); begin SetIntegerField('EnteredByID'           , Value);end;
procedure TCorrectiveActionReports.SetEnteredBy            (const Value: string    ); begin SetStringField('EnteredBy'             , Value);end;
procedure TCorrectiveActionReports.SetReportedDate         (const Value: TDateTime ); begin SetDateTimeField('ReportedDate'          , Value);end;
procedure TCorrectiveActionReports.SetSalesID              (const Value: Integer   ); begin SetIntegerField('SalesID'               , Value);end;
procedure TCorrectiveActionReports.SetSalesLineID          (const Value: Integer   ); begin SetIntegerField('SalesLineID'           , Value);end;
procedure TCorrectiveActionReports.SetProductionBuild      (const Value: string    ); begin SetStringField('ProductionBuild'       , Value);end;
procedure TCorrectiveActionReports.SetProductionBuildDesc  (const Value: string    ); begin SetStringField('ProductionBuildDesc'   , Value);end;
procedure TCorrectiveActionReports.SetSupplierID           (const Value: Integer   ); begin SetIntegerField('SupplierID'            , Value);end;
procedure TCorrectiveActionReports.SetSupplierName         (const Value: string    ); begin SetStringField('SupplierName'          , Value);end;
procedure TCorrectiveActionReports.SetPOID                 (const Value: Integer   ); begin SetIntegerField('POID'                  , Value);end;
procedure TCorrectiveActionReports.SetPOLineID             (const Value: Integer   ); begin SetIntegerField('POLineID'              , Value);end;
procedure TCorrectiveActionReports.SetDescriptionofProblem (const Value: string    ); begin SetStringField('DescriptionofProblem' , Value);end;
procedure TCorrectiveActionReports.SetImprovementSuggestion(const Value: string    ); begin SetStringField('ImprovementSuggestion' , Value);end;
procedure TCorrectiveActionReports.SetRepID                (const Value: Integer   ); begin SetIntegerField('RepID'                 , Value);end;
procedure TCorrectiveActionReports.SetRep                  (const Value: string    ); begin SetStringField('Rep'                   , Value);end;


  {TCARAction}

constructor TCARAction.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CARAction';
  fSQL := 'SELECT * FROM tblcaraction';
end;


destructor TCARAction.Destroy;
begin
  inherited;
end;


procedure TCARAction.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ActionRequired');
  SetPropertyFromNode(node,'ImmediateDetails');
  SetPropertyFromNode(node,'RepID');
  SetPropertyFromNode(node,'Rep');
  SetDateTimePropertyFromNode(node,'ActionDate');
end;


procedure TCARAction.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ActionRequired' ,ActionRequired);
  AddXMLNode(node,'ImmediateDetails' ,ImmediateDetails);
  AddXMLNode(node,'RepID' ,RepID);
  AddXMLNode(node,'Rep' ,Rep);
  AddXMLNode(node,'ActionDate' ,ActionDate);
end;


function TCARAction.ValidateData: Boolean ;
begin
  Result := inherited ValidateData;
  if not result then exit;

  Resultstatus.Clear;
  if ActionDate = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ActionDate should not be blank' , TRue );
    Exit;
  end;
  Result := True;
end;


function TCARAction.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCARAction.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCARAction.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sametext(Sender.FieldName , 'RepID') then begin
    Rep := TEmployee.IDToggle(RepID, Connection.Connection);
  end else if Sametext(Sender.FieldName , 'Rep') then begin
    RepID := TEmployee.IDToggle(Rep, Connection.Connection);
  end;
end;


function TCARAction.EmptyRecord: Boolean;
begin
    REsult:= (ActionRequired='') and (ImmediateDetails='') and (RepID=0) and (Rep='') and ((ActionDate =date) or (ActionDate=0));

end;

function TCARAction.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCARAction.GetIDField: string;
begin
  Result := 'ID'
end;


class function TCARAction.GetBusObjectTablename: string;
begin
  Result:= 'tblcaraction';
end;


function TCARAction.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  ActionDate := Date;

end;

function TCARAction.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TCARAction.GetActionRequired  : string    ; begin Result := GetStringField('ActionRequired');end;
function  TCARAction.GetImmediateDetails: string    ; begin Result := GetStringField('ImmediateDetails');end;
function  TCARAction.GetRepID           : Integer   ; begin Result := GetIntegerField('RepID');end;
function  TCARAction.GetRep             : string    ; begin Result := GetStringField('Rep');end;
function  TCARAction.GetActionDate      : TDateTime ; begin Result := GetDateTimeField('ActionDate');end;
procedure TCARAction.SetActionRequired  (const Value: string    ); begin SetStringField('ActionRequired'   , Value);end;
procedure TCARAction.SetImmediateDetails(const Value: string    ); begin SetStringField('ImmediateDetails' , Value);end;
procedure TCARAction.SetRepID           (const Value: Integer   ); begin SetIntegerField('RepID'            , Value);end;
procedure TCARAction.SetRep             (const Value: string    ); begin SetStringField('Rep'              , Value);end;
procedure TCARAction.SetActionDate      (const Value: TDateTime ); begin SetDateTimeField('ActionDate'       , Value);end;


  {TCAROutComeReview}

constructor TCAROutComeReview.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CAROutComeReview';
  fSQL := 'SELECT * FROM tblcaroutcomereview';
end;


destructor TCAROutComeReview.Destroy;
begin
  inherited;
end;


procedure TCAROutComeReview.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ActionorOutCome');
  SetPropertyFromNode(node,'RepID');
  SetPropertyFromNode(node,'Rep');
  SetDateTimePropertyFromNode(node,'Closedouton');
end;


procedure TCAROutComeReview.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ActionorOutCome' ,ActionorOutCome);
  AddXMLNode(node,'RepID' ,RepID);
  AddXMLNode(node,'Rep' ,Rep);
  AddXMLNode(node,'Closedouton' ,Closedouton);
end;


function TCAROutComeReview.ValidateData: Boolean ;
begin
  Result := inherited ValidateData;
end;


function TCAROutComeReview.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCAROutComeReview.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCAROutComeReview.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sametext(Sender.FieldName , 'RepID') then begin
    Rep := TEmployee.IDToggle(RepID, Connection.Connection);
  end else if Sametext(Sender.FieldName , 'Rep') then begin
    RepID := TEmployee.IDToggle(Rep, Connection.Connection);
  end;
end;


function TCAROutComeReview.EmptyRecord: Boolean;
begin
    result:= (ActionorOutCome='') and (RepID =0) and (Rep = '') and ((Closedouton =Date) or (Closedouton=0));
end;

function TCAROutComeReview.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCAROutComeReview.GetIDField: string;
begin
  Result := 'ID'
end;


class function TCAROutComeReview.GetBusObjectTablename: string;
begin
  Result:= 'tblcaroutcomereview';
end;



function TCAROutComeReview.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Closedouton := Date;

end;

function TCAROutComeReview.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TCAROutComeReview.GetActionorOutCome : string    ; begin Result := GetStringField('ActionorOutCome');end;
function  TCAROutComeReview.GetRepID           : Integer   ; begin Result := GetIntegerField('RepID');end;
function  TCAROutComeReview.GetRep             : string    ; begin Result := GetStringField('Rep');end;
function  TCAROutComeReview.GetClosedouton     : TDateTime ; begin Result := GetDateTimeField('Closedouton');end;
procedure TCAROutComeReview.SetActionorOutCome (const Value: string    ); begin SetStringField('ActionorOutCome' , Value);end;
procedure TCAROutComeReview.SetRepID           (const Value: Integer   ); begin SetIntegerField('RepID'            , Value);end;
procedure TCAROutComeReview.SetRep             (const Value: string    ); begin SetStringField('Rep'              , Value);end;
procedure TCAROutComeReview.SetClosedouton     (const Value: TDateTime ); begin SetDateTimeField('Closedouton'      , Value);end;


  {TCARPrevMeasures}

constructor TCARPrevMeasures.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CARPrevMeasures';
  fSQL := 'SELECT * FROM tblcarprevmeasures';
end;


destructor TCARPrevMeasures.Destroy;
begin
  inherited;
end;


procedure TCARPrevMeasures.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PreventiveActioncomments');
  SetPropertyFromNode(node,'PreventiveDetails');
  SetPropertyFromNode(node,'RepID');
  SetPropertyFromNode(node,'Rep');
  SetDateTimePropertyFromNode(node,'ActionDate');
end;


procedure TCARPrevMeasures.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PreventiveActioncomments' ,PreventiveActioncomments);
  AddXMLNode(node,'PreventiveDetails' ,PreventiveDetails);
  AddXMLNode(node,'RepID' ,RepID);
  AddXMLNode(node,'Rep' ,Rep);
  AddXMLNode(node,'ActionDate' ,ActionDate);
end;


function TCARPrevMeasures.ValidateData: Boolean ;
begin
  Result := inherited ValidateData;
end;


function TCARPrevMeasures.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCARPrevMeasures.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCARPrevMeasures.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sametext(Sender.FieldName , 'RepID') then begin
    Rep := TEmployee.IDToggle(RepID, Connection.Connection);
  end else if Sametext(Sender.FieldName , 'Rep') then begin
    RepID := TEmployee.IDToggle(Rep, Connection.Connection);
  end;
end;


function TCARPrevMeasures.EmptyRecord: Boolean;
begin
    REsult:= (PreventiveActioncomments ='') and (PreventiveDetails ='') and (RepID=0) and (Rep='') and ((ActionDate= Date) or (ActionDate= 0));

end;

function TCARPrevMeasures.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCARPrevMeasures.GetIDField: string;
begin
  Result := 'ID'
end;


class function TCARPrevMeasures.GetBusObjectTablename: string;
begin
  Result:= 'tblcarprevmeasures';
end;

function TCARPrevMeasures.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  ActionDate := Date;
end;

function TCARPrevMeasures.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TCARPrevMeasures.GetPreventiveActioncomments: string    ; begin Result := GetStringField('PreventiveActioncomments');end;
function  TCARPrevMeasures.GetPreventiveDetails       : string    ; begin Result := GetStringField('PreventiveDetails');end;
function  TCARPrevMeasures.GetRepID                   : Integer   ; begin Result := GetIntegerField('RepID');end;
function  TCARPrevMeasures.GetRep                     : string    ; begin Result := GetStringField('Rep');end;
function  TCARPrevMeasures.GetActionDate              : TDateTime ; begin Result := GetDateTimeField('ActionDate');end;
procedure TCARPrevMeasures.SetPreventiveActioncomments(const Value: string    ); begin SetStringField('PreventiveActioncomments' , Value);end;
procedure TCARPrevMeasures.SetPreventiveDetails       (const Value: string    ); begin SetStringField('PreventiveDetails'        , Value);end;
procedure TCARPrevMeasures.SetRepID                   (const Value: Integer   ); begin SetIntegerField('RepID'                    , Value);end;
procedure TCARPrevMeasures.SetRep                     (const Value: string    ); begin SetStringField('Rep'                      , Value);end;
procedure TCARPrevMeasures.SetActionDate              (const Value: TDateTime ); begin SetDateTimeField('ActionDate'               , Value);end;


  {TCARReview}

constructor TCARReview.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CARReview';
  fSQL := 'SELECT * FROM tblcarreview';
end;


destructor TCARReview.Destroy;
begin
  inherited;
end;


procedure TCARReview.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ReviewComments');
  SetPropertyFromNode(node,'RepID');
  SetPropertyFromNode(node,'Rep');
  SetDateTimePropertyFromNode(node,'Reviewdon');
end;


procedure TCARReview.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ReviewComments' ,ReviewComments);
  AddXMLNode(node,'RepID' ,RepID);
  AddXMLNode(node,'Rep' ,Rep);
  AddXMLNode(node,'Reviewdon' ,Reviewdon);
end;


function TCARReview.ValidateData: Boolean ;
begin
  Result := inherited ValidateData;
end;


function TCARReview.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCARReview.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCARReview.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sametext(Sender.FieldName , 'RepID') then begin
    Rep := TEmployee.IDToggle(RepID, Connection.Connection);
  end else if Sametext(Sender.FieldName , 'Rep') then begin
    RepID := TEmployee.IDToggle(Rep, Connection.Connection);
  end;
end;


function TCARReview.EmptyRecord: Boolean;
begin
    result:=  (ReviewComments = '') and (RepID =0) and (Rep = '') and ((Reviewdon = Date) or (Reviewdon = 0)) ;
end;

function TCARReview.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCARReview.GetIDField: string;
begin
  Result := 'ID'
end;


class function TCARReview.GetBusObjectTablename: string;
begin
  Result:= 'tblcarreview';
end;



function TCARReview.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  Reviewdon := Date;
end;

function TCARReview.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;

end;


{Property Functions}
function  TCARReview.GetReviewComments  : string    ; begin Result := GetStringField('ReviewComments');end;
function  TCARReview.GetRepID           : Integer   ; begin Result := GetIntegerField('RepID');end;
function  TCARReview.GetRep             : string    ; begin Result := GetStringField('Rep');end;
function  TCARReview.GetReviewdon       : TDateTime ; begin Result := GetDateTimeField('Reviewdon');end;
procedure TCARReview.SetReviewComments  (const Value: string    ); begin SetStringField('ReviewComments'   , Value);end;
procedure TCARReview.SetRepID           (const Value: Integer   ); begin SetIntegerField('RepID'            , Value);end;
procedure TCARReview.SetRep             (const Value: string    ); begin SetStringField('Rep'              , Value);end;
procedure TCARReview.SetReviewdon       (const Value: TDateTime ); begin SetDateTimeField('Reviewdon'        , Value);end;


{ TCARPropeties }

function TCARPropeties.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not(result) then exit;
  if Assigned(Owner) then
    if owner is TCorrectiveActionReports then begin
      TCorrectiveActionReports(owner).PostDB;
      CARID := TCorrectiveActionReports(owner).ID;
    end;
  seqno := fiLastSeqno +1;
end;

function TCARPropeties.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
  if not result  then exit;
  if EmptyRecord then delete;

end;

function TCARPropeties.DoBeforeInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoBeforeInsert(Sender);
  if not(result) then exit;
  Last;
  fiLastSeqno := Seqno;
end;

function TCARPropeties.EmptyRecord: Boolean;
begin
  Result := False;
end;

function TCARPropeties.GetCARID           : Integer   ; begin Result := GetIntegerField('CARID');end;
function TCARPropeties.GetSeqno: Integer;begin result := getIntegerField('Seqno');end;
procedure TCARPropeties.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'CARID');
end;

procedure TCARPropeties.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Seqno' ,Seqno);
  AddXMLNode(node,'CARID' ,CARID);
end;

procedure TCARPropeties.SetCARID           (const Value: Integer   ); begin SetIntegerField('CARID'            , Value);end;
procedure TCARPropeties.SetSeqno(const Value: Integer);begin SetIntegerField('Seqno'            , Value); end;

function TCARPropeties.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if Seqno = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Seqno should not be 0' , TRue );
    Exit;
  end;
  if CARID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'Header ID should not be 0' , TRue );
    Exit;
  end;
  if EmptyRecord then begin
    Resultstatus.AddItem(False , rssError , 0,  'This record is empty' , TRue );
    Exit;
  end;
  REsult:= true;
end;

initialization
  RegisterClass(TCorrectiveActionReports);
  RegisterClass(TCARReview);
  RegisterClass(TCARPrevMeasures);
  RegisterClass(TCAROutComeReview);
  RegisterClass(TCARAction);
end.
