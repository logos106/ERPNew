unit BusobjTemplateOptions;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  11/10/16  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;


type
  TTemplateOptions = class;

  TPrintTemplateEvent = Procedure (TemplateOptions: TTemplateOptions) of Object ;

  TTemplateType = class(TMSBusObj)
  private
    function GetTypeName            : string    ;
    function GetReportOnFC          : Boolean   ;
    procedure SetTypeName            (const Value: string    );
    procedure SetReportOnFC          (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    Class function   GetKeyStringField       : string;                   override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;

    Class Function 	Appointment	:Integer;
    Class Function 	Appointment_Listing	:Integer;
    Class Function 	Balance_Sheet	:Integer;
    Class Function 	Bank_Deposit	:Integer;
    Class Function 	Barcode	:Integer;
    Class Function 	Barcode_Pick_Assembly	:Integer;
    Class Function 	BarcodePicking	:Integer;
    Class Function 	Barcodes_Manufacturing	:Integer;
    Class Function 	Batch_Barcode	:Integer;
    Class Function 	Batch_Barcode_PO	:Integer;
    Class Function 	Best_Practices	:Integer;
    Class Function 	Bill	:Integer;
    Class Function 	BOM	:Integer;
    Class Function 	BOM_Picking_Slip	:Integer;
    Class Function 	BOM_Tree	:Integer;
    Class Function 	BOM_Work_Order	:Integer;
    Class Function 	Bulk_Pay_Suppliers	:Integer;
    Class Function 	Cash_Sale	:Integer;
    Class Function 	CashDropReceipt	:Integer;
    Class Function 	CashDrops	:Integer;
    Class Function 	Cheque	:Integer;
    Class Function 	Client_Details	:Integer;
    Class Function 	Client_Ship_Address	:Integer;
    Class Function 	Contractor_Payment	:Integer;
    Class Function 	Corrective_Action_Reports	:Integer;
    Class Function 	Credit	:Integer;
    Class Function 	Custom_Account_Report	:Integer;
    Class Function 	Customer_Costs	:Integer;
    Class Function 	Customer_Payment	:Integer;
    Class Function 	Customer_Prepayment	:Integer;
    Class Function 	Customer_Returns	:Integer;
    Class Function 	Customer_Weekly_Report	:Integer;
    Class Function 	Customers_Mail_Merge	:Integer;
    Class Function 	Daily_Sales_Statistics	:Integer;
    Class Function 	Delivery_Docket	:Integer;
    Class Function 	Email_Schedule	:Integer;
    Class Function 	Employee	:Integer;
    Class Function 	Employees_Mail_Merge	:Integer;
    Class Function 	Equipment	:Integer;
    Class Function 	ERP_Changes	:Integer;
    Class Function 	VS1_Changes	:Integer;
    Class Function 	ERP_Web_Changes	:Integer;
    Class Function 	Expense_Claim	:Integer;
    Class Function 	Fax	:Integer;
    Class Function 	Finished_Good_Label	:Integer;
    Class Function 	Fixed_Asset_Label	:Integer;
    Class Function 	Fixed_Assets	:Integer;
    Class Function 	GoLive	:Integer;
    Class Function 	Goods_Receipt	:Integer;
    Class Function 	Hire_Statement	:Integer;
    Class Function 	Hourly_Sales_Report	:Integer;
    Class Function 	HR_Forms_Customer	:Integer;
    Class Function 	HR_Forms_Employee	:Integer;
    Class Function 	Intrastat	:Integer;
    Class Function 	Inventory	:Integer;
    Class Function 	Invoice	:Integer;
    Class Function 	Job_Sales_Detail	:Integer;
    Class Function 	Job_Sales_Summary	:Integer;
    Class Function 	Journal_Entry	:Integer;
    Class Function 	Leave_Accruals	:Integer;
    Class Function 	Loyalty_Mail_Merge	:Integer;
    Class Function 	Mail_Merge	:Integer;
    Class Function 	Manifest	:Integer;
    Class Function 	Manufacture_Summary	:Integer;
    Class Function 	Marketing	:Integer;
    Class Function 	Marketing_Mail_Merge	:Integer;
    Class Function 	Other	:Integer;
    Class Function 	Other_Contacts	:Integer;
    Class Function 	Other_Contacts_Mail_Merge	:Integer;
    Class Function 	Pay	:Integer;
    Class Function 	Pay_Cheque	:Integer;
    Class Function 	PAYG	:Integer;
    Class Function 	PaySlip	:Integer;
    Class Function 	PayslipUK	:Integer;
    Class Function 	Phone	:Integer;
    Class Function 	Pick_Slip	:Integer;
    Class Function 	Pick_Slip_By_Col_1	:Integer;
    Class Function 	Pick_Slip_By_Col_2	:Integer;
    Class Function 	Pick_Slip_By_Col_3	:Integer;
    Class Function 	Pick_Slip_List	:Integer;
    Class Function 	Picking_Dispatch_Labels	:Integer;
    Class Function 	POS_Cash	:Integer;
    Class Function 	POS_Product_Sales	:Integer;
    Class Function 	POS_Receipt_Printer	:Integer;
    Class Function 	POS_Summary	:Integer;
    Class Function 	POS_Till_Summary	:Integer;
    Class Function 	PQA_Allocation	:Integer;
    Class Function 	Process_Progress_Report	:Integer;
    Class Function 	Progress_Build	:Integer;
    Class Function 	Progress_Build_Waste	:Integer;
    Class Function 	Product_Attribute	:Integer;
    Class Function 	Product_BOA_List	:Integer;
    Class Function 	Product_BOM_List	:Integer;
    Class Function 	Product_Negative_Stock	:Integer;
    Class Function 	Product_Price_List	:Integer;
    Class Function 	Product_PriceMatrix_Qtys	:Integer;
    Class Function 	Product_Received_Label	:Integer;
    Class Function 	Production_Pick_Slip	:Integer;
    Class Function 	Production_Work_Sheet	:Integer;
    Class Function 	Production_Work_Sheet_with_allocation	:Integer;
    Class Function 	ProductionProgressBuild	:Integer;
    Class Function 	Profit_Loss	:Integer;
    Class Function 	Profit_Loss_Period	:Integer;
    Class Function 	Profit_Loss_Summary	:Integer;
    Class Function 	Purchase_Order	:Integer;
    Class Function 	Quote	:Integer;
    Class Function 	Receive_Bulk_Customer_Payments	:Integer;
    Class Function 	Recipient_Created_Statements	:Integer;
    Class Function 	Reconciliation	:Integer;
    Class Function 	Referral	:Integer;
    Class Function 	Refund	:Integer;
    Class Function 	Repairs	:Integer;
    Class Function 	Return_Authority	:Integer;
    Class Function 	Roster_Report_Details	:Integer;
    Class Function 	Roster_Report_Summary	:Integer;
    Class Function 	Sales_Analysis	:Integer;
    Class Function 	Sales_Collated_by_Item	:Integer;
    Class Function 	Sales_Dispatch_Barcode	:Integer;
    Class Function 	Sales_Dispatch_Delivery_Docket	:Integer;
    Class Function 	Sales_Order	:Integer;
    Class Function 	Sales_Report_Details	:Integer;
    Class Function 	Sales_Tax_Report	:Integer;
    Class Function 	Serial_Number_Barcode	:Integer;
    Class Function 	Service_Pad	:Integer;
    Class Function 	Shipping	:Integer;
    Class Function 	Shipping_Container	:Integer;
    Class Function 	Shipping_Container_Mail_Merge	:Integer;
    Class Function 	Shipping_Picking	:Integer;
    Class Function 	Smart_Order	:Integer;
    Class Function 	Statements	:Integer;
    Class Function 	Stock_Adjustment	:Integer;
    Class Function 	Stock_Transfer	:Integer;
    Class Function 	Stock_Transfer_Del_Docket	:Integer;
    Class Function 	Stock_Transfer_Picking_Slip	:Integer;
    Class Function 	Store_Away_Slip	:Integer;
    Class Function 	Stow_Away	:Integer;
    Class Function 	Summary_Sheet	:Integer;
    Class Function 	Summary_Sheets	:Integer;
    Class Function 	Super_By_Fund	:Integer;
    Class Function 	Supplier_Payment	:Integer;
    Class Function 	Supplier_Payment_Cheque	:Integer;
    Class Function 	Supplier_Prepayment	:Integer;
    Class Function 	Supplier_Prepayment_Cheque	:Integer;
    Class Function 	Suppliers_Mail_Merge	:Integer;
    Class Function 	Tax	:Integer;
    Class Function 	TaxNZ	:Integer;
    Class Function 	TaxUK	:Integer;
    Class Function 	ToDo	:Integer;
    Class Function 	Training	:Integer;
    Class Function 	Trial_Balance	:Integer;
    Class Function 	UnallocatedSalesAllocation	:Integer;
    Class Function 	UnAllocatedSalesPallet	:Integer;
    Class Function 	Unit_Booking	:Integer;
    Class Function 	Unit_Hire_Booking	:Integer;
    Class Function 	USA_Payroll_Forms	:Integer;
    Class Function 	USAPAYG	:Integer;
    Class Function 	Voucher	:Integer;
    Class Function 	Wages_Journal	:Integer;
    Class Function 	WorkOrder_Barcode	:Integer;


  published
    property TypeName             :string      read GetTypeName           write SetTypeName        ;
    property ReportOnFC           :Boolean     read GetReportOnFC         write SetReportOnFC      ;
  end;


  TTemplateOptions = class(TMSBusObj)
  private
    fonprint: TPrintTemplateEvent;
    allLinesValid:Boolean;
    function GetTemplateID          : Integer   ;
    function GetTemplateName        : string    ;
    function GetFormID              : Integer   ;
    function GettypeID              : Integer   ;
    function GetUserId              : Integer   ;
    function GetPrinterName         : string    ;
    function GetEmployeeName        : string    ;
    function GetActive              : Boolean   ;
    function GetEmail               : Boolean   ;
    function GetPreview             : Boolean   ;
    function GetPrint               : Boolean   ;
    procedure SetTemplateID          (const Value: Integer   );
    procedure SetTemplateName        (const Value: string    );
    procedure SetFormID              (const Value: Integer   );
    procedure SettypeID              (const Value: Integer   );
    procedure SetUserId              (const Value: Integer   );
    procedure SetPrinterName         (const Value: string    );
    procedure SetEmployeeName        (const Value: string    );
    procedure SetActive              (const Value: Boolean   );
    procedure SetEmail               (const Value: Boolean   );
    procedure SetPreview             (const Value: Boolean   );
    procedure SetPrint               (const Value: Boolean   );
    procedure ValidateDataCallback(const Sender: TBusObj; var Abort: Boolean);
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
    Property onprint :TPrintTemplateEvent read fonprint write fonprint;
    Procedure OnPrintCallback(const Sender: TBusObj; var Abort: Boolean);
    class Function  DoPrintreports(AOwner:Tcomponent;aTemplatetype, aformname :string; aOnPrint:TPrintTemplateEvent; EmployeeId:Integer=0) :Boolean;
  published
    property TemplateID           :Integer     read GetTemplateID         write SetTemplateID      ;
    property TemplateName         :string      read GetTemplateName       write SetTemplateName    ;
    property FormID               :Integer     read GetFormID             write SetFormID          ;
    property TypeID               :Integer     read GettypeID             write SettypeID          ;
    property UserId               :Integer     read GetUserId             write SetUserId          ;
    property PrinterName          :string      read GetPrinterName        write SetPrinterName     ;
    property EmployeeName         :string      read GetEmployeeName       write SetEmployeeName    ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    property Email                :Boolean     read GetEmail              write SetEmail           ;
    property Preview              :Boolean     read GetPreview            write SetPreview         ;
    property Print                :Boolean     read GetPrint              write SetPrint          ;
  end;


implementation


uses tcDataUtils, CommonLib , SysUtils, BusObjForms, AppEnvironment,
  BusObjEmployee;



  {TTemplateOptions}

constructor TTemplateOptions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'templateoptions';
  fSQL := 'SELECT * FROM tbltemplateoptions';
  fonprint := nil;
end;


destructor TTemplateOptions.Destroy;
begin
  inherited;
end;


procedure TTemplateOptions.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TemplateID');
  SetPropertyFromNode(node,'TemplateName');
  SetPropertyFromNode(node,'FormID');
  SetPropertyFromNode(node,'typeID');
  SetPropertyFromNode(node,'UserId');
  SetPropertyFromNode(node,'PrinterName');
  SetPropertyFromNode(node,'EmployeeName');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'Email');
  SetBooleanPropertyFromNode(node,'Preview');
  SetBooleanPropertyFromNode(node,'Print');
end;


procedure TTemplateOptions.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TemplateID' ,TemplateID);
  AddXMLNode(node,'TemplateName' ,TemplateName);
  AddXMLNode(node,'FormID' ,FormID);
  AddXMLNode(node,'typeID' ,typeID);
  AddXMLNode(node,'UserId' ,UserId);
  AddXMLNode(node,'PrinterName' ,PrinterName);
  AddXMLNode(node,'EmployeeName' ,EmployeeName);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Email' ,Email);
  AddXMLNode(node,'Preview' ,Preview);
  AddXMLNode(node,'Print' ,Print);
end;


function TTemplateOptions.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  allLinesValid:=true;
  Iteraterecords(ValidateDataCallback);
  result :=allLinesValid;
end;
Procedure TTemplateOptions.ValidateDataCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(sender is TTemplateOptions) then exit;
  if TTemplateOptions(Sender).TemplateID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'TemplateID should not be 0' , true );
    allLinesValid:=False;
    Abort := True;
    Exit;
  end;

end;


function TTemplateOptions.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTemplateOptions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TTemplateOptions.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if SameText(Sender.fieldname, 'TemplateID') then begin
    TypeId := GetTemplateTypeId(TemplateID);
  end else if SameText(Sender.fieldname, 'UserId') then begin
    EmployeeName := TEmployee.idtoggle(USerID);
  end else if SameText(Sender.fieldname, 'EmployeeName') then begin
     UserId := TEmployee.idtoggle(EmployeeName);
  end;

end;


class Function  TTemplateOptions.DoPrintreports(AOwner: Tcomponent;aTemplatetype, aformname: string; aOnPrint: TPrintTemplateEvent; EmployeeId:Integer=0):Boolean ;
var
  TemplateOptions : TTemplateOptions;
  s:String;
  iTypeId :Integer;
  iFormId :Integer;
begin
  REsult := False;
  if not(Assigned(aOnPrint)) then exit;

  if EmployeeId = 0 then EmployeeId := Appenv.Employee.employeeId;

  TemplateOptions := TTemplateOptions.CreateWithNewConn(AOwner);
  try
    s:= ' Active ="T"';
    if aTemplatetype <> '' then begin
        iTypeId := TTemplateType.IDToggle(aTemplatetype);
        s:= s+' and TypeId = ' + inttostr(iTypeId);
    end;
    if aformname <> '' then begin
      iformid := TERPForm.IDToggle(aformname);
      s := s + '  and FormID = ' + inttostr(iformid );
    end;

    s := s + '  and (ifnull(UserID,0)=0 or ifnull(UserID,0) = ' + inttostr(EmployeeID) +')';

   if s<> '' then TemplateOptions.Loadselect(s) else TemplateOptions.load;
   TemplateOptions.onprint := aOnPrint;
   if TemplateOptions.count =0 then begin
    result := False;
    Exit;
   end;
   TemplateOptions.IterateRecords(TemplateOptions.OnPrintCallback);
   Result := true;
  finally
    Freeandnil(TemplateOptions);
  end;
end;
Procedure TTemplateOptions.OnPrintCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is TTemplateOptions) then exit;
  if not(Assigned(fonprint)) then exit;
  TTemplateOptions(Sender).fonprint(TTemplateOptions(Sender));
end;
function TTemplateOptions.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTemplateOptions.GetIDField: string;
begin
  Result := 'ID'
end;


class function TTemplateOptions.GetBusObjectTablename: string;
begin
  Result:= 'tbltemplateoptions';
end;


function TTemplateOptions.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not(result) then exit;
  if (TemplateId =0) and (userID=0) and (PrinterName ='') then delete;
end;


{Property Functions}
function  TTemplateOptions.GetTemplateID      : Integer   ; begin Result := GetIntegerField('TemplateID');end;
function  TTemplateOptions.GetTemplateName    : string    ; begin Result := GetStringField('TemplateName');end;
function  TTemplateOptions.GetFormID          : Integer   ; begin Result := GetIntegerField('FormID');end;
function  TTemplateOptions.GettypeID          : Integer   ; begin Result := GetIntegerField('typeID');end;
function  TTemplateOptions.GetUserId          : Integer   ; begin Result := GetIntegerField('UserId');end;
function  TTemplateOptions.GetPrinterName     : string    ; begin Result := GetStringField('PrinterName');end;
function  TTemplateOptions.GetEmployeeName    : string    ; begin Result := GetStringField('EmployeeName');end;
function  TTemplateOptions.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TTemplateOptions.GetEmail           : Boolean   ; begin Result := GetBooleanField('Email');end;
function  TTemplateOptions.GetPreview         : Boolean   ; begin Result := GetBooleanField('Preview');end;
function  TTemplateOptions.GetPrint           : Boolean   ; begin Result := GetBooleanField('Print');end;
procedure TTemplateOptions.SetTemplateID      (const Value: Integer   ); begin SetIntegerField('TemplateID'       , Value);end;
procedure TTemplateOptions.SetTemplateName    (const Value: string    ); begin SetStringField('TemplateName'     , Value);end;
procedure TTemplateOptions.SetFormID          (const Value: Integer   ); begin SetIntegerField('FormID'           , Value);end;
procedure TTemplateOptions.SettypeID          (const Value: Integer   ); begin SetIntegerField('typeID'           , Value);end;
procedure TTemplateOptions.SetUserId          (const Value: Integer   ); begin SetIntegerField('UserId'           , Value);end;
procedure TTemplateOptions.SetPrinterName     (const Value: string    ); begin SetStringField('PrinterName'      , Value);end;
procedure TTemplateOptions.SetEmployeeName    (const Value: string    ); begin SetStringField('EmployeeName'     , Value);end;
procedure TTemplateOptions.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
procedure TTemplateOptions.SetEmail           (const Value: Boolean   ); begin SetBooleanField('Email'           , Value);end;
procedure TTemplateOptions.SetPreview         (const Value: Boolean   ); begin SetBooleanField('Preview'          , Value);end;
procedure TTemplateOptions.SetPrint           (const Value: Boolean   ); begin SetBooleanField('Print'           , Value);end;


  {TTemplateType}

constructor TTemplateType.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'TemplateType';
  fSQL := 'SELECT * FROM tbltemplatetype';
end;


destructor TTemplateType.Destroy;
begin
  inherited;
end;


procedure TTemplateType.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'TypeName');
  SetBooleanPropertyFromNode(node,'ReportOnFC');
end;


procedure TTemplateType.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'TypeName' ,TypeName);
  AddXMLNode(node,'ReportOnFC' ,ReportOnFC);
end;


function TTemplateType.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TTemplateType.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TTemplateType.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TTemplateType.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TTemplateType.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TTemplateType.GetIDField: string;
begin
  Result := 'TypeID'
end;


class function TTemplateType.GetKeyStringField: string;
begin
  REsult := 'TypeName';
end;

class function TTemplateType.GetBusObjectTablename: string;
begin
  Result:= 'tbltemplatetype';
end;


function TTemplateType.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;
{template TypeIDs}
Class Function TtemplateType.Appointment	            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Appointment'));	            	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Appointment_Listing		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Appointment Listing'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Balance_Sheet		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Balance Sheet'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Bank_Deposit		            	        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Bank Deposit'));	              	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Barcode		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Barcode'));	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Barcode_Pick_Assembly		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Barcode Pick Assembly'));	            	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.BarcodePicking		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('BarcodePicking'));	             	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Barcodes_Manufacturing		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Barcodes(Manufacturing)'));	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Batch_Barcode		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Batch Barcode'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Batch_Barcode_PO		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Batch Barcode(PO)'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Best_Practices		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Best Practices'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Bill		            	            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Bill')); 	            	           	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.BOM		            	            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('BOM'));	            	           	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.BOM_Picking_Slip		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('BOM Picking Slip')); 	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.BOM_Tree		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('BOM Tree')); 	            	           	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.BOM_Work_Order		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('BOM Work Order')); 	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Bulk_Pay_Suppliers		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Bulk Pay Suppliers')); 	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Cash_Sale		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Cash Sale')); 	            	           	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.CashDropReceipt		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('CashDropReceipt'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.CashDrops		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('CashDrops'));	            	           	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Cheque		            	            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Cheque')); 	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Client_Details		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Client Details')); 	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Client_Ship_Address		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Client Ship Address')); 	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Contractor_Payment		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Contractor Payment')); 	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Corrective_Action_Reports		        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Corrective Action Reports'));	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Credit		            	            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Credit')); 	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Custom_Account_Report		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Custom Account Report'));	            	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Customer_Costs		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Customer Costs'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Customer_Payment		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Customer Payment'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Customer_Prepayment		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Customer Prepayment'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Customer_Returns		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Customer Returns'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Customer_Weekly_Report		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Customer Weekly Report'));	               if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Customers_Mail_Merge		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Customers Mail Merge'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Daily_Sales_Statistics		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Daily Sales Statistics'));	               if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Delivery_Docket		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Delivery Docket'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Email_Schedule		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Email Schedule'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Employee		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Employee'));	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Employees_Mail_Merge		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Employees Mail Merge'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Equipment		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Equipment'));	            	           	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.ERP_Changes		            	        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('ERP Changes'));	            	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.VS1_Changes      		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Tablet Changes'));	            	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.ERP_Web_Changes		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('ERP Web Changes'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Expense_Claim		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Expense Claim'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Fax		            	            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Fax'));	            	           	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Finished_Good_Label		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Finished Good Label'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Fixed_Asset_Label		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Fixed Asset Label'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Fixed_Assets		            	        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Fixed Assets'));	            	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.GoLive		            	            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('GoLive'));	            	           	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Goods_Receipt		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Goods Receipt'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Hire_Statement		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Hire Statement'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Hourly_Sales_Report		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Hourly Sales Report'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.HR_Forms_Customer		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('HR Forms - Customer'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.HR_Forms_Employee		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('HR Forms - Employee'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Intrastat		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Intrastat'));	            	           	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Inventory		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Inventory'));	            	           	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Invoice		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Invoice'));	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Job_Sales_Detail		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Job Sales Detail'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Job_Sales_Summary		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Job Sales Summary'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Journal_Entry		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Journal Entry'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Leave_Accruals		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Leave Accruals'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Loyalty_Mail_Merge		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Loyalty Mail Merge'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Mail_Merge		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Mail Merge'));	            	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Manifest		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Manifest'));	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Manufacture_Summary		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Manufacture Summary'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Marketing		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Marketing'));	            	           	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Marketing_Mail_Merge		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Marketing Mail Merge'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Other		            	            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Other'));	            	           	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Other_Contacts		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Other Contacts'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Other_Contacts_Mail_Merge		        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Other Contacts Mail Merge'));	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Pay		            	            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Pay'));	            	           	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Pay_Cheque		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Pay Cheque'));	            	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.PAYG		            	            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('PAYG'));	            	           	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.PaySlip		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('PaySlip'));	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.PayslipUK		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('PayslipUK'));	            	           	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Phone		            	            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Phone'));	            	           	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Pick_Slip		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Pick Slip'));	            	           	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Pick_Slip_By_Col_1		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Pick Slip By Col 1'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Pick_Slip_By_Col_2		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Pick Slip By Col 2'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Pick_Slip_By_Col_3		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Pick Slip By Col 3'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Pick_Slip_List		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Pick Slip List'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Picking_Dispatch_Labels		          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Picking Dispatch Labels'));	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.POS_Cash		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('POS - Cash'));	            	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.POS_Product_Sales		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('POS - Product Sales'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.POS_Receipt_Printer		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('POS - Receipt Printer'));	            	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.POS_Summary		            	        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('POS - Summary'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.POS_Till_Summary		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('POS - Till Summary'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.PQA_Allocation		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('PQA Allocation'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Process_Progress_Report		          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Process Progress Report'));	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Progress_Build		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Progress Build'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Progress_Build_Waste		              : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Progress Build Waste'));	                 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Product_Attribute		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Product Attribute'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Product_BOA_List		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Product BOA List'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Product_BOM_List		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Product BOM List'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Product_Negative_Stock		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Product Negative Stock'));	               if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Product_Price_List		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Product Price List'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Product_PriceMatrix_Qtys		          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Product PriceMatrix Qtys'));	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Product_Received_Label		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Product Received Label'));	               if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Production_Pick_Slip		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Production Pick Slip'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Production_Work_Sheet		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Production Work Sheet'));	            	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Production_Work_Sheet_with_allocation: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Production Work Sheet with allocation')); if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.ProductionProgressBuild		          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('ProductionProgressBuild'));	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Profit_Loss		            	        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Profit & Loss'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Profit_Loss_Period		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Profit & Loss -Period'));	            	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Profit_Loss_Summary		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Profit & Loss -Summary'));	               if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Purchase_Order		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Purchase Order'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Quote		            	            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Quote'));	            	           	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Receive_Bulk_Customer_Payments		    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Receive Bulk Customer Payments'));	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Recipient_Created_Statements		      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Recipient Created Statements'));	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Reconciliation		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Reconciliation'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Referral		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Referral'));	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Refund		            	            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Refund'));	            	           	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Repairs		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Repairs'));	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Return_Authority		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Return Authority'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Roster_Report_Details		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Roster Report (Details)'));	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Roster_Report_Summary		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Roster Report (Summary)'));	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Sales_Analysis		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Sales Analysis'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Sales_Collated_by_Item		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Sales Collated by Item'));	               if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Sales_Dispatch_Barcode		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Sales Dispatch Barcode'));	               if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Sales_Dispatch_Delivery_Docket		    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Sales Dispatch Delivery Docket'));	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Sales_Order		            	        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Sales Order'));	            	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Sales_Report_Details		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Sales Report Details'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Sales_Tax_Report		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Sales Tax Report'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Serial_Number_Barcode		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Serial Number Barcode'));	            	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Service_Pad		            	        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Service Pad'));	            	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Shipping		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Shipping'));	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Shipping_Container		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Shipping Container'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Shipping_Container_Mail_Merge		    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Shipping Container Mail Merge'));	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Shipping_Picking		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Shipping Picking'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Smart_Order		            	        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Smart Order'));	            	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Statements		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Statements'));	            	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Stock_Adjustment		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Stock Adjustment'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Stock_Transfer		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Stock Transfer'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Stock_Transfer_Del_Docket		        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Stock Transfer Del Docket'));	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Stock_Transfer_Picking_Slip		      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Stock Transfer Picking Slip'));	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Store_Away_Slip		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Store Away Slip'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Stow_Away		            	          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Stow Away'));	            	           	 if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Summary_Sheet		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Summary Sheet'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Summary_Sheets		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Summary Sheets'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Super_By_Fund		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Super By Fund'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Supplier_Payment		            	    : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Supplier Payment'));	            	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Supplier_Payment_Cheque		          : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Supplier Payment Cheque'));	             if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Supplier_Prepayment		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Supplier Prepayment'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Supplier_Prepayment_Cheque		        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Supplier Prepayment Cheque'));	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Suppliers_Mail_Merge		            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Suppliers Mail Merge'));	            	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Tax		            	            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Tax'));	            	           	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.TaxNZ		            	            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('TaxNZ'));	            	           	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.TaxUK		            	            	: Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('TaxUK'));	            	           	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.ToDo		            	            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('ToDo'));	            	           	       if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Training		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Training'));	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Trial_Balance		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Trial Balance'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.UnallocatedSalesAllocation		        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('UnallocatedSalesAllocation'));	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.UnAllocatedSalesPallet		            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('UnAllocatedSalesPallet'));	               if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Unit_Booking		            	        : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Unit Booking'));	            	           if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Unit_Hire_Booking		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Unit Hire Booking'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.USA_Payroll_Forms		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('USA Payroll Forms'));	            	     if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.USAPAYG                          	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('USAPAYG'));	            	               if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Voucher		            	            : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Voucher'));	            	           	   if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.Wages_Journal		            	      : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('Wages Journal'));	            	         if count =0 then exit; Result := ID;finally free; end; end;
Class Function TtemplateType.WorkOrder_Barcode		            	  : Integer; begin Result := 0; with TtemplateType.CreateWithNewConn(nil) do try LoadSelect('typename =' +quotedstr('WorkOrder Barcode'));	            	     if count =0 then exit; Result := ID;finally free; end; end;


{Property Functions}
function  TTemplateType.GetTypeName        : string    ; begin Result := GetStringField('TypeName');end;
function  TTemplateType.GetReportOnFC      : Boolean   ; begin Result := GetBooleanField('ReportOnFC');end;
procedure TTemplateType.SetTypeName        (const Value: string    ); begin SetStringField('TypeName'         , Value);end;
procedure TTemplateType.SetReportOnFC      (const Value: Boolean   ); begin SetBooleanField('ReportOnFC'       , Value);end;


initialization
  RegisterClass(TTemplateType);
  RegisterClass(TTemplateOptions);


end.
