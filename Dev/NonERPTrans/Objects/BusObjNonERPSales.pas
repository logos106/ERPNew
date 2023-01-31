unit BusObjNonERPSales;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  23/12/16  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, busobjstock , BusobjNonERPTrans;


type
  TNonERPSalesLines = class(TNonERPTransLines)
  private
  protected
    function GetTransID                      : Integer   ;Override;
    function GetERPTransLineId               : Integer   ;Override;
    procedure SetTransID                      (const Value: Integer   );Override;
    procedure SetERPTransLineId               (const Value: Integer   );Override;

    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
  end;

  TNonERPSales = class(TNonERPTrans)
  private
    function GetInvoiceDocNumber        : string    ;
    function GetClassID                 : Integer   ;
    function GetClass                   : string    ;
    function GetComments                : string    ;
    function GetJobname                 : string    ;
    function GetJobnumber               : Integer    ;
    function GetIsPOS                   : Boolean   ;
    function GetIsRefund                : Boolean   ;
    function GetIsCashSale              : Boolean   ;
    function GetIsInvoice               : Boolean   ;
    function GetIsQuote                 : Boolean   ;
    function GetIsSalesOrder            : Boolean   ;
    function GetIsVoucher               : Boolean   ;
    function GetIsLayby                 : Boolean   ;
    function GetIsCustomerReturn        : Boolean   ;
    procedure SetInvoiceDocNumber        (const Value: string    );
    procedure SetClassID                 (const Value: Integer   );
    procedure SetClass                   (const Value: string    );
    procedure SetComments                (const Value: string    );
    procedure SetJobname                 (const Value: string    );
    procedure SetJobnumber               (const Value: Integer    );
    procedure SetIsPOS                   (const Value: Boolean   );
    procedure SetIsRefund                (const Value: Boolean   );
    procedure SetIsCashSale              (const Value: Boolean   );
    procedure SetIsInvoice               (const Value: Boolean   );
    procedure SetIsQuote                 (const Value: Boolean   );
    procedure SetIsSalesOrder            (const Value: Boolean   );
    procedure SetIsVoucher               (const Value: Boolean   );
    procedure SetIsLayby                 (const Value: Boolean   );
    procedure SetIsCustomerReturn        (const Value: Boolean   );
    procedure SetEnteredBy               (const Value: string    );
    procedure SetEnteredAt               (const Value: Tdatetime  );

  protected
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    function getLines: TNonERPTransLines;Override;

    function GetTransId                : Integer   ;Override;
    procedure SetTransId                (const Value: Integer   );Override;
    function GetERPTransID               : Integer   ;Override;
    procedure SetERPTransID               (const Value: Integer   );Override;
    function GetTransDate                : TDateTime ;Override;
    procedure SetTransDate                (const Value: TDateTime );Override;
    function GetClientName            : string    ;Override;
    procedure SetClientName            (const Value: string    );Override;

  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    Class Function ConvertToERPSales(AOwner:TComponent; aSaleID:Integer):Integer;
    Function ValidERPTrans:Boolean;
  published
    property InvoiceDocNumber         :string      read GetInvoiceDocNumber       write SetInvoiceDocNumber    ;
    Property ClassId                  :Integer     read getClassId                write setclassId;
    property SalesClass               :string      read GetClass                  write SetClass               ;
    property Comments                 :string      read GetComments               write SetComments            ;
    property Jobname                  :string      read GetJobname                write SetJobname             ;
    property Jobnumber                :Integer     read GetJobnumber              write SetJobnumber           ;
    property IsPOS                    :Boolean     read GetIsPOS                  write SetIsPOS               ;
    property IsRefund                 :Boolean     read GetIsRefund               write SetIsRefund            ;
    property IsCashSale               :Boolean     read GetIsCashSale             write SetIsCashSale          ;
    property IsInvoice                :Boolean     read GetIsInvoice              write SetIsInvoice           ;
    property IsQuote                  :Boolean     read GetIsQuote                write SetIsQuote             ;
    property IsSalesOrder             :Boolean     read GetIsSalesOrder           write SetIsSalesOrder        ;
    property IsVoucher                :Boolean     read GetIsVoucher              write SetIsVoucher           ;
    property IsLayby                  :Boolean     read GetIsLayby                write SetIsLayby             ;
    property IsCustomerReturn         :Boolean     read GetIsCustomerReturn       write SetIsCustomerReturn    ;
  end;
 TNonERPSalesFlat = class(TNonERPTransFlat)
    private
      fInvoiceDocNumber             :string      ;
      fCustomerName                 :string      ;
      fJobname                      :string      ;
      fJobnumber                    :Integer     ;
      fSaleDate                     :TDateTime   ;
      fEmployeeName                 :string      ;
      fSalesClass                   :string      ;
      fComments                     :string      ;
      fIsPOS                        :Boolean     ;
      fIsRefund                     :Boolean     ;
      fIsCashSale                   :Boolean     ;
      fIsInvoice                    :Boolean     ;
      fIsQuote                      :Boolean     ;
      fIsSalesOrder                 :Boolean     ;
      fIsVoucher                    :Boolean     ;
      fIsLayby                      :Boolean     ;
      fIsCustomerReturn             :Boolean     ;

    Protected
      function GetSQL: string; override;
      Procedure HeaderSave(NonERPTrans :TNonERPTrans);override;
      Procedure LinesSave(NonERPTranslines :TNonERPTranslines);override;
      function getTNonERPTrans: TNonERPTrans;override;
    Public
      class function  GetIDField                   : string;              override;
      class function  GetBusObjectTablename        : string;              override;
    Published
      {Header Properties}
	    property CustomerName                 :string      Read fCustomerName           write fCustomerName    ;
      property Jobname                      :string      Read fJobname                write fJobname    ;
      property Jobnumber                    :Integer     Read fJobnumber              write fJobnumber  ;
      property InvoiceDocNumber             :string      Read fInvoiceDocNumber       write fInvoiceDocNumber    ;
      property SalesClass                   :string      Read fSalesClass             write fSalesClass          ;
      property Comments                     :string      Read fComments               write fComments            ;
      property IsPOS                        :Boolean     Read fIsPOS                  write fIsPOS               ;
      property IsRefund                     :Boolean     Read fIsRefund               write fIsRefund            ;
      property IsCashSale                   :Boolean     Read fIsCashSale             write fIsCashSale          ;
      property IsInvoice                    :Boolean     Read fIsInvoice              write fIsInvoice           ;
      property IsQuote                      :Boolean     Read fIsQuote                write fIsQuote             ;
      property IsSalesOrder                 :Boolean     Read fIsSalesOrder           write fIsSalesOrder        ;
      property IsVoucher                    :Boolean     Read fIsVoucher              write fIsVoucher           ;
      property IsLayby                      :Boolean     Read fIsLayby                write fIsLayby             ;
      property IsCustomerReturn             :Boolean     Read fIsCustomerReturn       write fIsCustomerReturn    ;
      {Lines Properties}
  end;
implementation


uses tcDataUtils, CommonLib, sysutils, MySQLConst, BusObjClient, BusObjEmployee,
  BusObjClass, BusObjectListObj, AppEnvironment, dialogs, AppEnvironmentVirtual,
  BusObjSaleBase, BusObjPOSSale, BusobjCash, BusObjSales, busobjvouchersale,
  BusobjProduct, BusObjSimpleTypes, tcConst, BusObjCommon;


  {TNonERPSalesLines}

constructor TNonERPSalesLines.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'nonerpsaleslines';
  fSQL := 'SELECT * FROM tblnonerpsaleslines';
end;


destructor TNonERPSalesLines.Destroy;
begin
  inherited;
end;

class function TNonERPSalesLines.GetIDField: string;
begin
  Result := 'SaleLineID'
end;


class function TNonERPSalesLines.GetBusObjectTablename: string;
begin
  Result:= 'tblnonerpsaleslines';
end;

function TNonERPSalesLines.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
{Property Functions}
function TNonERPSalesLines.GetTransID        : Integer                ; begin Result := GetIntegerField('SaleID'); end;
function TNonERPSalesLines.GetERPTransLineId : Integer                ; begin Result := GetIntegerField('ERPSaleLineID'); end;
procedure TNonERPSalesLines.SetTransID       (const Value: Integer   ); begin SetIntegerField('SaleId' , Value); end;
procedure TNonERPSalesLines.SetERPTransLineId(const Value: Integer   ); begin SetIntegerField('ERPSaleLineID', value); end;

  {TNonERPSales}
function TNonERPSales.ValidERPTrans: Boolean;
Function IDNote :String;
begin
  result := 'Non ERP Sale # ' +inttostr(+ ID)+ '->';
end;
begin
  if ClientName ='' then begin
    REsultStatus.AddItem(False, rssWarning, 0,'Customer Name is Blank', true);
    result := False;
    Exit;
  end;
  if (TCustomer.Idtoggle(ClientName) =0) and (not(AppEnv.CompanyPrefs.DisableCusSourceTracking)) and (Source ='') then begin
    REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Customer '+ quotedstr(Clientname) +' Doesn''t Exists and It is Not Able Create a New Customer Without the Source Details.', true);
    result := False;
    Exit;
  end;

  if TCustomer.MakeCustomer(self, ClientName, true, Source)=0 then begin
    REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Customer '+ quotedstr(Clientname) +' Doesn''t Exists', true);
    result := False;
    Exit;
  end;

  if (Terms <> '') and (TTerms.IDToggle(Terms)=0) then begin
    REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Terms '+ quotedstr(TErms) +' Doesn''t Exists', true);
    result := False;
    Exit;
  end;

  if (status<>'') then
    if TSimpleTypes.ChecknMakeSimpleType(SimpleTypes_LeadStatusType     , status) =0  then begin
      REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Status '+ quotedstr(status) +' Doesn''t Exists', true);
      result := False;
      Exit;
    end;

  if Lines.count =0 then begin
    REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Sale #' + inttostr(ID)+' has No Line', true);
    result := False;
    Exit;
  end;
  Lines.First;
  while Lines.EOF = False do begin
    if Lines.Productname = '' then begin
      REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Product name is Blank', true);
      result := False;
      Exit;
    end;
    if TProductSimple.ChecknMakeProduct(Lines.Productname) =0 then begin
      REsultStatus.AddItem(False, rssWarning, 0,IDNote+ 'Product ' + Quotedstr(Lines.Productname)+' Doesn''t Exist', true);
      result := False;
      Exit;
    end;
    Lines.Next;
  end;
end;

class function TNonERPSales.ConvertToERPSales(AOwner:TComponent; aSaleID: Integer): Integer;
var
  NonERPSales :TNonERPSales;
  SaleObj :TSalesBase;
begin
  result :=0;
  NonERPSales :=TNonERPSales.CreateWithNewConn(AOwner);
  try
    NonERPSales.Load(aSaleID);
    if (NonERPSales.count =0) or (NonERPSales.lines.Count=0) or (NonERPSales.ERPtransID <>0) then exit;

    if not NonERPSales.ValidERPTrans then exit;

         if  NonERPSales.IsPOS            then SaleObj := TPOSCashSale.create(Aowner)
    else if  NonERPSales.IsRefund         then SaleObj := TRefundSale.create(Aowner)
    else if  NonERPSales.IsCashSale       then SaleObj := TCashSale.create(Aowner)
    else if  NonERPSales.IsInvoice        then SaleObj := TInvoice.create(Aowner)
    else if  NonERPSales.IsQuote          then SaleObj := TQuote.create(Aowner)
    else if  NonERPSales.IsSalesOrder     then SaleObj := TSalesOrder.create(Aowner)
    else if  NonERPSales.IsVoucher        then SaleObj := TVoucherCashSale.create(Aowner)
    else if  NonERPSales.IsLayby          then SaleObj := TPosLayBy.create(Aowner)
    else if  NonERPSales.IsCustomerReturn then SaleObj := TPosLayBy.create(Aowner)
    else SaleObj := TInvoice.create(Aowner);
    SaleObj.SilentMode := True;
    SaleObj.connection := NonERPSales.Connection;
    SaleObj.Load(0);

    SaleObj.Connection.BeginTransaction;
    try

        SaleObj.New;
             if NonERPSales.SalesClass ='' then SaleObj.SaleClassName :=AppEnv.DefaultClass.DefaultClassName
        else if TDeptClass.IDToggle(NonERPSales.SalesClass) = 0  then SaleObj.SaleClassName :=AppEnv.DefaultClass.DefaultClassName
        else SaleObj.SaleClassName := NonERPSales.SalesClass;

        SaleObj.DocNumber     := NonERPSales.InvoiceDocNumber;

        if NonERPSales.jobname      <> '' then
          SaleObj.CustomerID := TJob.FindJob(SaleObj, NonERPSales.JobName ,NonERPSales.jobnumber);
        if SaleObj.CustomerID =0 then SaleObj.CustomerName  := NonERPSales.ClientName;

        SaleObj.SaleDate      := NonERPSales.TransDate;
        SaleObj.TotalAmountInc:= NonERPSales.TotalAmountInc;
        SaleObj.EmployeeName  := NonERPSales.EmployeeName;
        SaleObj.Comments      := NonERPSales.Comments;
        if NonERPSales.Terms <> '' then SaleObj.Termsname   := NonERPSales.Terms;
        SaleObj.SalesStatus   := NonERPSales.Status;
        SaleObj.PostDB;
        NonERPSales.ERPtransID :=SaleObj.ID;
        NonERPSales.PostDB;

        NonERPSales.Lines.First;
        While NonERPSales.Lines.Eof = False do begin
          if NonERPSales.Lines.ERPtranslineID = 0 then begin
            if (NonERPSales.Lines.ProductName<>'') then begin
                SaleObj.Lines.New;
                SaleObj.Lines.AutoLoadRelatedProducts := False;
                SaleObj.Lines.ProductName         := NonERPSales.Lines.ProductName;
                SaleObj.Lines.Product_Description := NonERPSales.Lines.Product_Description;
                SaleObj.Lines.Qtysold             := NonERPSales.Lines.Shipped;
                if SaleObj.Lines.Qtysold=0 then SaleObj.Lines.Qtysold:= 1;
                SaleObj.Lines.QtyShipped          := SaleObj.Lines.Qtysold;
                SaleObj.Lines.invoiced := True;
                SaleObj.Lines.LinePriceInc  := divzer(NonERPSales.Lines.TotalLineAmountInc,SaleObj.Lines.QtyShipped);
                SaleObj.Lines.TotalLineAmountInc  := NonERPSales.Lines.TotalLineAmountInc;
                SaleObj.Lines.shipdate            :=  NonERPSales.TransDate;
                SaleObj.Lines.PostDB;
                NonERPSales.Lines.ERPtranslineID  :=SaleObj.Lines.ID;
                NonERPSales.Lines.PostDB;
            end;
          end;
          NonERPSales.Lines.next;
        end;
        SaleObj.SaleDate      := NonERPSales.TransDate;
        SaleObj.PostDB;
        if SaleObj.lines.count =0 then begin
          SaleObj.Connection.RollbackTransaction;
          Exit;
        end;
        if not SaleObj.Save then begin
          SaleObj.Connection.RollbackTransaction;
          Exit;
        end;
        SaleObj.Connection.CommitTransaction;
        Result := SaleObj.ID;
    Except
      on E:EXception do begin
        SaleObj.REsultStatus.AddItem(False, rssWarning, 0, 'Convert To ERPSales Failed :' + E.Message, true);
        SaleObj.Connection.RollbackTransaction;
      end;
    end;
  finally
    Freeandnil(SaleObj);
    Freeandnil(NonERPSales);
  end;
end;

constructor TNonERPSales.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'nonerpsales';
  fSQL := 'SELECT * FROM tblnonerpsales';
  ExportExcludeList.Add('ClassID');
end;
destructor TNonERPSales.Destroy;
begin
  inherited;
end;

procedure TNonERPSales.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'InvoiceDocNumber');
  SetPropertyFromNode(node,'ClassID');
  SetPropertyFromNode(node,'SalesClass');
  SetPropertyFromNode(node,'Comments');
  SetPropertyFromNode(node,'Jobname');
  SetPropertyFromNode(node,'Jobnumber');
  SetBooleanPropertyFromNode(node,'IsPOS');

  SetBooleanPropertyFromNode(node,'IsRefund');
  SetBooleanPropertyFromNode(node,'IsCashSale');
  SetBooleanPropertyFromNode(node,'IsInvoice');
  SetBooleanPropertyFromNode(node,'IsQuote');
  SetBooleanPropertyFromNode(node,'IsSalesOrder');
  SetBooleanPropertyFromNode(node,'IsVoucher');
  SetBooleanPropertyFromNode(node,'IsLayby');
  SetBooleanPropertyFromNode(node,'IsCustomerReturn');
end;

procedure TNonERPSales.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'InvoiceDocNumber' ,InvoiceDocNumber);
  AddXMLNode(node,'ClassID' ,ClassID);
  AddXMLNode(node,'SalesClass' ,SalesClass);
  AddXMLNode(node,'Comments' ,Comments);
  AddXMLNode(node,'Jobname' ,Jobname);
  AddXMLNode(node,'Jobnumber' ,Jobnumber);
  AddXMLNode(node,'IsPOS' ,IsPOS);
  AddXMLNode(node,'IsRefund' ,IsRefund);
  AddXMLNode(node,'IsCashSale' ,IsCashSale);
  AddXMLNode(node,'IsInvoice' ,IsInvoice);
  AddXMLNode(node,'IsQuote' ,IsQuote);
  AddXMLNode(node,'IsSalesOrder' ,IsSalesOrder);
  AddXMLNode(node,'IsVoucher' ,IsVoucher);
  AddXMLNode(node,'IsLayby' ,IsLayby);
  AddXMLNode(node,'IsCustomerReturn' ,IsCustomerReturn);
end;

procedure TNonERPSales.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.Fieldname , 'CustomerName') then begin
    ClientId := TClient.IDToggle(clientName, Connection.Connection);
  end else if Sysutils.SameText(Sender.Fieldname , 'Class') then begin
    ClassId := TDeptClass.IDToggle(salesclass, Connection.Connection);

  end else if Sysutils.SameText(Sender.Fieldname , 'IsPOS'            ) then begin    if IsPOS            then begin IsRefund:= False; IsCashSale:= False; IsInvoice:= False;IsQuote := False;IsSalesOrder := False;IsVoucher:= False;IsLayby := False;IsCustomerReturn := False;End;
  end else if Sysutils.SameText(Sender.Fieldname , 'IsRefund'         ) then begin    if IsRefund         then begin IsPOS   := False; IsCashSale:= False; IsInvoice:= False;IsQuote := False;IsSalesOrder := False;IsVoucher:= False;IsLayby := False;IsCustomerReturn := False;End;
  end else if Sysutils.SameText(Sender.Fieldname , 'IsCashSale'       ) then begin    if IsCashSale       then begin IsRefund:= False; IsPOS     := False; IsInvoice:= False;IsQuote := False;IsSalesOrder := False;IsVoucher:= False;IsLayby := False;IsCustomerReturn := False;End;
  end else if Sysutils.SameText(Sender.Fieldname , 'IsInvoice'        ) then begin    if IsInvoice        then begin IsRefund:= False; IsCashSale:= False; IsPOS    := False;IsQuote := False;IsSalesOrder := False;IsVoucher:= False;IsLayby := False;IsCustomerReturn := False;End;
  end else if Sysutils.SameText(Sender.Fieldname , 'IsQuote'          ) then begin    if IsQuote          then begin IsRefund:= False; IsCashSale:= False; ISInvoice:= False;ISPos   := False;IsSalesOrder := False;IsVoucher:= False;IsLayby := False;IsCustomerReturn := False;End;
  end else if Sysutils.SameText(Sender.Fieldname , 'IsSalesOrder'     ) then begin    if IsSalesOrder     then begin IsRefund:= False; IsCashSale:= False; ISInvoice:= False;isQuote := False;ISPos        := False;IsVoucher:= False;IsLayby := False;IsCustomerReturn := False;End;
  end else if Sysutils.SameText(Sender.Fieldname , 'IsVoucher'        ) then begin    if IsVoucher        then begin IsRefund:= False; IsCashSale:= False; ISInvoice:= False;isQuote := False;IsSalesOrder := False;ISPos    := False;IsLayby := False;IsCustomerReturn := False;End;
  end else if Sysutils.SameText(Sender.Fieldname , 'IsLayby'          ) then begin    if IsLayby          then begin IsRefund:= False; IsCashSale:= False; ISInvoice:= False;isQuote := False;IsSalesOrder := False;IsVoucher:= False;ISPos   := False;IsCustomerReturn := False;End;
  end else if Sysutils.SameText(Sender.Fieldname , 'IsCustomerReturn' ) then begin    if IsCustomerReturn then begin IsRefund:= False; IsCashSale:= False; ISInvoice:= False;isQuote := False;IsSalesOrder := False;IsVoucher:= False;IsLayby := False;ISPos            := False;End;
  end;
  if not (IsRefund or IsCashSale or IsInvoice or IsPOS or IsQuote or IsSalesOrder or IsVoucher or IsLayby or IsCustomerReturn) then IsInvoice := true;
end;

class function TNonERPSales.GetIDField: string;
begin
  Result := 'SaleID'
end;


class function TNonERPSales.GetBusObjectTablename: string;
begin
  Result:= 'tblnonerpsales';
end;


function TNonERPSales.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  enteredBy := TEmployee.IDToggle(Appenv.Employee.EmployeeID);
  enteredat := now;
end;

function TNonERPSales.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TNonERPSales.GetInvoiceDocNumber    : string    ; begin Result := GetStringField('InvoiceDocNumber' );end;
function  TNonERPSales.GetClassID             : Integer   ; begin Result := GetIntegerField('ClassID'         );end;
function  TNonERPSales.GetClass               : string    ; begin Result := GetStringField('Class'            );end;
function  TNonERPSales.GetComments            : string    ; begin Result := GetStringField('Comments'         );end;
function  TNonERPSales.GetJobname             : string    ; begin Result := GetStringField('Jobname'          );end;
function  TNonERPSales.GetJobnumber           : Integer   ; begin Result := GetIntegerField('Jobnumber'        );end;
function  TNonERPSales.GetIsPOS               : Boolean   ; begin Result := GetBooleanField('IsPOS'           );end;
function  TNonERPSales.GetIsRefund            : Boolean   ; begin Result := GetBooleanField('IsRefund'        );end;
function  TNonERPSales.GetIsCashSale          : Boolean   ; begin Result := GetBooleanField('IsCashSale'      );end;
function  TNonERPSales.GetIsInvoice           : Boolean   ; begin Result := GetBooleanField('IsInvoice'       );end;
function  TNonERPSales.GetIsQuote             : Boolean   ; begin Result := GetBooleanField('IsQuote'         );end;
function  TNonERPSales.GetIsSalesOrder        : Boolean   ; begin Result := GetBooleanField('IsSalesOrder'    );end;
function  TNonERPSales.GetIsVoucher           : Boolean   ; begin Result := GetBooleanField('IsVoucher'       );end;
function  TNonERPSales.GetIsLayby             : Boolean   ; begin Result := GetBooleanField('IsLayby'         );end;
function  TNonERPSales.GetIsCustomerReturn    : Boolean   ; begin Result := GetBooleanField('IsCustomerReturn');end;
function TNonERPSales.GetTransId              : Integer   ; begin Result := GetIntegerField('SaleID'          );end;
function TNonERPSales.GetERPTransID           : Integer   ; begin Result := GetIntegerField('ERPSaleID'       );end;
function TNonERPSales.GetTransDate            : TDateTime ; begin Result := GetDAtetimeField('SaleDate'       );end;
function TNonERPSales.GetClientName           : string    ; begin Result := GetStringfield('Customername'			);end;


procedure TNonERPSales.SetInvoiceDocNumber    (const Value: string    ); begin SetStringField('InvoiceDocNumber' , Value);end;
procedure TNonERPSales.SetClassID             (const Value: Integer   ); begin SetIntegerField('ClassID'         , Value);end;
procedure TNonERPSales.SetClass               (const Value: string    ); begin SetStringField('Class'            , Value);end;
procedure TNonERPSales.SetComments            (const Value: string    ); begin SetStringField('Comments'         , Value);end;
procedure TNonERPSales.SetJobname             (const Value: string    ); begin SetStringField('Jobname'          , Value);end;
procedure TNonERPSales.SetJobnumber           (const Value: Integer    ); begin SetIntegerField('Jobnumber'        , Value);end;
procedure TNonERPSales.SetIsPOS               (const Value: Boolean   ); begin SetBooleanField('IsPOS'           , Value);end;
procedure TNonERPSales.SetIsRefund            (const Value: Boolean   ); begin SetBooleanField('IsRefund'        , Value);end;
procedure TNonERPSales.SetIsCashSale          (const Value: Boolean   ); begin SetBooleanField('IsCashSale'      , Value);end;
procedure TNonERPSales.SetIsInvoice           (const Value: Boolean   ); begin SetBooleanField('IsInvoice'       , Value);end;
procedure TNonERPSales.SetIsQuote             (const Value: Boolean   ); begin SetBooleanField('IsQuote'         , Value);end;
procedure TNonERPSales.SetIsSalesOrder        (const Value: Boolean   ); begin SetBooleanField('IsSalesOrder'    , Value);end;
procedure TNonERPSales.SetIsVoucher           (const Value: Boolean   ); begin SetBooleanField('IsVoucher'       , Value);end;
procedure TNonERPSales.SetIsLayby             (const Value: Boolean   ); begin SetBooleanField('IsLayby'         , Value);end;
procedure TNonERPSales.SetIsCustomerReturn    (const Value: Boolean   ); begin SetBooleanField('IsCustomerReturn', Value);end;
procedure TNonERPSales.SetEnteredBy           (const Value: string    ); begin SetStringField('EnteredBy'        , Value);end;
procedure TNonERPSales.SetEnteredAt           (const Value: Tdatetime ); begin SetDateTimeField('EnteredAt'      , Value);end;
procedure TNonERPSales.SetTransId             (const Value: Integer   ); begin SetIntegerField('SaleID'          , Value);end;
procedure TNonERPSales.SetERPTransID          (const Value: Integer   ); begin SetIntegerField('ERPSaleID'       , Value);end;
procedure TNonERPSales.SetTransDate           (const Value: TDateTime ); begin SetDatetimeField('SaleDate'       , Value);end;
procedure TNonERPSales.SetClientName          (const Value: string    ); begin SetStringfield('CustomerName'     , Value);end;


function TNonERPSales.getLines: TNonERPTransLines;
begin
  Result := TNonERPTransLines(GetContainerComponent(TNonERPSalesLines, 'SaleID = ' + IntToStr(Self.Id)));
end;

{ TNonERPSalesFlat }
class function TNonERPSalesFlat.GetBusObjectTablename: string;
begin
  Result:= 'tblnonerpsales';
end;
class function TNonERPSalesFlat.GetIDField: string;
begin
  Result := 'SaleID'
end;

function TNonERPSalesFlat.GetSQL: string;
begin
  Result := 'Select S.* , SL.* from tblnonerpsales S  inner join tblnonerpsaleslines SL on S.saleId = Sl.saleId Limit 0';
end;

function TNonERPSalesFlat.getTNonERPTrans: TNonERPTrans;
begin
  Result := nil;
  try
    canceldb;
    result := TNonERPSales(GetContainerComponent(TNonERPSales ,'InvoiceDocNumber = ' + Quotedstr(InvoiceDocNumber)+
                                                               ' and CustomerName = ' + quotedstr(clientName)+
                                                               ' and SaleDate = ' + quotedstr(Formatdatetime(mysqlDatetimeformat , transDate)) ));
  except
    on E:Exception do begin
      if devmode then
        MessageDlgXP_Vista(e.message, mtWarning, [mbOK], 0);
    end;
  end;
end;
Procedure TNonERPSalesFlat.HeaderSave(NonERPTrans :TNonERPTrans);
begin
  if NonERPTrans is TNonERPSales then begin
		  TNonERPSales(NonERPTrans).ClientName        := CustomerName;
      TNonERPSales(NonERPTrans).Jobname           := Jobname;
      TNonERPSales(NonERPTrans).Jobnumber         := Jobnumber;
      TNonERPSales(NonERPTrans).InvoiceDocNumber  := InvoiceDocNumber;
      TNonERPSales(NonERPTrans).SalesClass        := SalesClass      ;
      TNonERPSales(NonERPTrans).Comments          := Comments        ;
      TNonERPSales(NonERPTrans).IsPOS             := IsPOS           ;
      TNonERPSales(NonERPTrans).IsRefund          := IsRefund        ;
      TNonERPSales(NonERPTrans).IsCashSale        := IsCashSale      ;
      TNonERPSales(NonERPTrans).IsInvoice         := IsInvoice       ;
      TNonERPSales(NonERPTrans).IsQuote           := IsQuote         ;
      TNonERPSales(NonERPTrans).IsSalesOrder      := IsSalesOrder    ;
      TNonERPSales(NonERPTrans).IsVoucher         := IsVoucher       ;
      TNonERPSales(NonERPTrans).IsLayby           := IsLayby         ;
      TNonERPSales(NonERPTrans).IsCustomerReturn  := IsCustomerReturn;
  end;
end;
Procedure TNonERPSalesFlat.LinesSave(NonERPTranslines :TNonERPTranslines);
begin
end;

initialization
  RegisterClass(TNonERPSales);
  RegisterClass(TNonERPSalesLines);
  RegisterClass(TNonERPSalesFlat);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Non ERP Sales','TNonERPSalesFlat','TNonERPSalesListGUI');
end.
