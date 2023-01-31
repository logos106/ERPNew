unit BusobjStockAdjustmentExport;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  07/08/14  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, ProductQtyLib , DAScript, BusobjStockAdjustEntry;

const
  Adjustment_on_Quantity_type_Instock ='In-Stock';
  Adjustment_on_Quantity_type_Available ='Available';
type
  TStockAdjustmentImportExport = class(TMSBusObj)
  private
    function GetPartsId             : Integer   ;
    function GetDepartmentID        : Integer   ;
    function GetUOMID               : Integer   ;
    function GetUOM                 : string    ;
    function GetUOMMultiplier       : Double    ;
    function GetgLevel              : Integer   ;
    function GetProductName         : string    ;
    function GetProductColumn1      : string    ;
    function GetProductColumn2      : string    ;
    function GetProductColumn3      : string    ;
    function GetPartsDescription    : string    ;
    function GetAccountName         : string    ;
    function GetAccountGroup        : string    ;
    function GetDeptName            : string    ;
    function GetBatchnumber         : string    ;
    function GetTruckLoadNo         : string    ;
    function GetExpiryDate          : string    ;
    function GetBatchExpiryDate     : TDateTime ;
    function GetBinlocation         : string    ;
    function GetBinnumber           : string    ;
    function GetSerialnumber        : string    ;
    function GetQtyType             : string    ;
    function GetUOMQty              : Double    ;
    function GetFinalcount          : Double    ;
    function GetAllocFinalcount     : Double    ;
    function GetQty                 : Double    ;
    function GetInstockUOMQty       : Double    ;
    function GetInstockQty          : Double    ;
    function GetCost                : Double    ;
    function GetValue               : Double    ;
    function GetActive              : Boolean   ;
    function GetSeqno               : Integer   ;
    function GetProductBarCode      : string    ;
    procedure SetPartsId             (const Value: Integer   );
    procedure SetDepartmentID        (const Value: Integer   );
    procedure SetUOMID               (const Value: Integer   );
    procedure SetUOM                 (const Value: string    );
    procedure SetUOMMultiplier       (const Value: Double    );
    procedure SetgLevel              (const Value: Integer   );
    procedure SetProductName         (const Value: string    );
    procedure SetProductColumn1      (const Value: string    );
    procedure SetProductColumn2      (const Value: string    );
    procedure SetProductColumn3      (const Value: string    );
    procedure SetPartsDescription    (const Value: string    );
    procedure SetAccountName         (const Value: string    );
    procedure SetAccountGroup        (const Value: string    );
    procedure SetDeptName            (const Value: string    );
    procedure SetBatchnumber         (const Value: string    );
    procedure SetTruckLoadNo         (const Value: string    );
    procedure SetExpiryDate          (const Value: string    );
    procedure SetBatchExpiryDate     (const Value: TDateTime );
    procedure SetBinlocation         (const Value: string    );
    procedure SetBinnumber           (const Value: string    );
    procedure SetSerialnumber        (const Value: string    );
    procedure SetQtyType             (const Value: string    );
    procedure SetUOMQty              (const Value: Double    );
    procedure SetFinalcount          (const Value: Double    );
    procedure SetAllocFinalcount     (const Value: Double    );
    procedure SetQty                 (const Value: Double    );
    procedure SetInstockUOMQty       (const Value: Double    );
    procedure SetInstockQty          (const Value: Double    );
    procedure SetCost                (const Value: Double    );
    procedure SetValue               (const Value: Double    );
    procedure SetActive              (const Value: Boolean   );
    procedure SetSeqno               (const Value: Integer   );
    procedure SetProductBarCode      (const Value: string    );
    function getProductDeptIDs: String;
    function getAdjustmentOnInstock: Boolean;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoBeforePost(Sender:TDatasetBusObj) : Boolean;            override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Procedure LoadPropnames;Override;
  public
    class function  GetIDField                   : string;              override;
    class function  GetBusObjectTablename        : string;              override;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property PartsId              :Integer     read GetPartsId            write SetPartsId         ;
    property DepartmentID         :Integer     read GetDepartmentID       write SetDepartmentID    ;
    property UOMID                :Integer     read GetUOMID              write SetUOMID           ;
    property gLevel               :Integer     read GetgLevel             write SetgLevel          ;
    property Qty                  :Double      read GetQty                write SetQty             ;
    property InstockUOMQty        :Double      read GetInstockUOMQty      write SetInstockUOMQty   ;
    property InstockQty           :Double      read GetInstockQty         write SetInstockQty      ;
    property Value                :Double      read GetValue              write SetValue           ;
    property Seqno                :Integer     read GetSeqno              write SetSeqno           ;
    property UOMQty               :Double      read GetUOMQty             write SetUOMQty          ;
    Procedure MakeExportdata(transDate :TDatetime;filtertype :TFiltertype ; includeAllProducts:Boolean;ExcludeInactiveProducts:Boolean; Tablename :String =''; ClassId:Integer =0; sSelectedProducts:String = ''; sProductDeptIDs:String = ''; ExtraSQLToRun:String = ''; StepProgresbarinScriptExec : TBeforeStatementExecuteEvent = nil;QtyType :String =Adjustment_on_Quantity_type_Available);
    Procedure AdjustStockforStockTake(transDate :TDatetime;filtertype :TFiltertype ; includeAllProducts:Boolean; ClassId:Integer =0; sSelectedProducts:String = ''; sProductDeptIDs:String = ''; StepProgresbarinScriptExec : TBeforeStatementExecuteEvent = nil);
    Property ProductDeptIDs :String read getProductDeptIDs;
    Class function HeaderLine(const SeparatorValue:String):String;
    Property AdjustmentOnInstock :Boolean read getAdjustmentOnInstock;
  published
    property ProductColumn1       :string      read GetProductColumn1     write SetProductColumn1  ;
    property ProductColumn2       :string      read GetProductColumn2     write SetProductColumn2  ;
    property ProductColumn3       :string      read GetProductColumn3     write SetProductColumn3  ;
    property ProductName          :string      read GetProductName        write SetProductName     ;
    property PartsDescription     :string      read GetPartsDescription   write SetPartsDescription;
    property AccountName          :string      read GetAccountName        write SetAccountName     ;
    property AccountGroup         :string      read GetAccountGroup       write SetAccountGroup     ;
    property DeptName             :string      read GetDeptName           write SetDeptName        ;
    property UOM                  :string      read GetUOM                write SetUOM             ;
    property Finalcount           :Double      read GetFinalcount         write SetFinalcount      ;
    property UOMMultiplier        :Double      read GetUOMMultiplier      write SetUOMMultiplier   ;
    property Batchnumber          :string      read GetBatchnumber        write SetBatchnumber     ;
    property TruckLoadNo          :string      read GetTruckLoadNo        write SetTruckLoadNo     ;
    property ExpiryDate           :string      read GetExpiryDate         write SetExpiryDate      ;
    property BatchExpiryDate      :TDateTime   read GetBatchExpiryDate    write SetBatchExpiryDate ;
    property Binlocation          :string      read GetBinlocation        write SetBinlocation     ;
    property Binnumber            :string      read GetBinnumber          write SetBinnumber       ;
    property Serialnumber         :string      read GetSerialnumber       write SetSerialnumber    ;
    property QtyType              :string      read GetQtyType            write SetQtyType         ;
    property AllocFinalcount      :Double      read GetAllocFinalcount    write SetAllocFinalcount ;
    property Cost                 :Double      read GetCost               write SetCost            ;
    property Active               :Boolean     read GetActive             write SetActive          ;
    property ProductBarCode       :string      read GetProductBarCode     write SetProductBarCode  ;
  end;
  TMultiStockAdjustExport = class(TSAELinesFlat)
    Private
      Function Getadjaccountname :String ;
      Function GetAdjNotes :String ;
      Function GetAdjustmentdate :Tdatetime ;
      Function GetCreationDate :Tdatetime ;
      Function GetNotes:String ;
      Function GetEmployee:String ;
      Function GetProcessed :Boolean ;
      Function Getadjdeleted :Boolean ;
      Function GetApproved :Boolean ;
    function GetStockAdjustEntryID: Integer;
    procedure SetStockAdjustEntryID(const Value: Integer);
    Protected
    public
      class function  GetIDField: string;override;
      constructor  Create(AOwner: TComponent);                            override;
      procedure Load(Const aId: integer;const fIsReadonly:boolean =False); override;

    Published
      Property adjaccountname :String read getadjaccountname;
      Property AdjNotes :String read getAdjNotes;
      Property Adjustmentdate :Tdatetime read getAdjustmentdate;
      Property CreationDate :Tdatetime read getCreationDate;
      Property Notes:String read getNotes;
      Property Employee:String read getEmployee;
      Property Processed :Boolean read getProcessed;
      Property adjdeleted :Boolean read getadjdeleted;
      Property Approved :Boolean read getApproved;
      property StockAdjustEntryID :Integer read GetStockAdjustEntryID write SetStockAdjustEntryID ;

  end;

implementation


uses tcDataUtils, CommonLib, BusObjectListObj ,SysUtils, ERPdbComponents, CommonDbLib, dateutils,LogLib,
  DbSharedObjectsObj;


{TMultiStockAdjustExport}
constructor TMultiStockAdjustExport.Create(AOwner: TComponent);
begin
  inherited;
  fsql := 'SELECT SAL.* , SA.Accountname adjaccountname ,SA.Adjustmentdate,SA.CreationDate ,SA.Notes AdjNotes, SA.Employee,SA.Processed,SA.Deleted adjdeleted,SA.Approved '+
          ' FROM tblstockadjustentrylines SAL  '+
          ' inner join tblstockadjustentry SA on SAL.StockAdjustEntryID = SA.StockAdjustEntryID';
end;

Function TMultiStockAdjustExport.getadjaccountname  : String    ; begin Result := GetStringfield('adjaccountname')  ;end;
Function TMultiStockAdjustExport.getAdjNotes        : String    ; begin Result := GetStringfield('AdjNotes')        ;end;
Function TMultiStockAdjustExport.getAdjustmentdate  : Tdatetime ; begin Result := GetDatetimefield('Adjustmentdate');end;
Function TMultiStockAdjustExport.getCreationDate    : Tdatetime ; begin Result := GetDatetimefield('CreationDate')  ;end;
Function TMultiStockAdjustExport.getNotes           : String    ; begin Result := GetStringfield('Notes')           ;end;
Function TMultiStockAdjustExport.getEmployee        : String    ; begin Result := GetStringfield('Employee')        ;end;
Function TMultiStockAdjustExport.getadjdeleted      : Boolean   ; begin Result := GetBooleanfield('adjdeleted')     ;end;
Function TMultiStockAdjustExport.getApproved        : Boolean   ; begin Result := GetBooleanfield('Approved')       ;end;

class function TMultiStockAdjustExport.GetIDField: string;
begin
  REsult := 'StockAdjustEntryID';
end;

Function TMultiStockAdjustExport.getProcessed       : Boolean   ; begin Result := GetBooleanfield('Processed')      ;end;

function TMultiStockAdjustExport.GetStockAdjustEntryID: Integer;
begin
   Result := 0;
end;

procedure TMultiStockAdjustExport.Load(const aId: integer;const fIsReadonly: boolean);
begin
  fSQLSelect :=  'SA.StockAdjustEntryID = ' + IntToStr(aid);
  Load(fIsReadonly);

end;

procedure TMultiStockAdjustExport.SetStockAdjustEntryID(const Value: Integer);
begin

end;


  {TStockAdjustmentImportExport}

procedure TStockAdjustmentImportExport.AdjustStockforStockTake(transDate :TDatetime;filtertype :TFiltertype; includeAllProducts: Boolean; ClassId: Integer =0; sSelectedProducts:String = ''; sProductDeptIDs:String = ''; StepProgresbarinScriptExec : TBeforeStatementExecuteEvent = nil);
var
  fsTablename :String;
  sSQL:String;
begin
  fstablename := commondblib.GetUserTemporaryTableName('StockAdjImport');
  try
    (*sSQL:= 'insert ignore into tblstockadjustmentImportExport  '+
            ' ( DepartmentID,UOMID,UOM,UOMMultiplier,PartsId,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription, '+
            ' DeptName,AccountName,AccountGroup,Batchnumber,ExpiryDate , BatchExpiryDate,Binlocation,Binnumber,Serialnumber, '+
            ' UOMQty,Finalcount,AllocFinalcount,Qty,InstockUOMQty,InstockQty,Cost,Value,Active,Seqno,ProductBarCode) '+
            ' Select  T1.DepartmentID, T1.UOMID, T1.UOM, T1.UOMMultiplier, T1.PartsId, T1.gLevel, T1.ProductName, T1.ProductColumn1, T1.ProductColumn2, T1.ProductColumn3, T1.PartsDescription,  '+
            ' T1.DeptName, T1.AccountName, T1.AccountGroup, T1.Batchnumber, T1.ExpiryDate , T1.BatchExpiryDate, T1.Binlocation, T1.Binnumber, T1.Serialnumber,  '+
            ' 0/*-T1.UOMQty*/, 0/*-T1.Finalcount*/, 0/*-T1.AllocFinalcount*/, 0/*-T1.Qty*/, 0/*-T1.InstockUOMQty*/, 0/*-T1.InstockQty*/, T1.Cost, 0/*-T1.Value*/, T1.Active, T1.Seqno, T1.ProductBarCode '+
            ' from ' +fstablename +' T1 '+
            ' Left join tblstockadjustmentimportexport T2 '+
            ' on ifnull(T1.partsId,0) = ifnull(T2.partsID ,0) '+
            ' and ifnull(T1.departmentId,0) = ifnull(T2.DepartmentID ,0) '+
            ' and ifnull(T1.uomid,0) = ifnull(T2.uomid ,0) '+
            ' and ifnull(T2.Batchnumber,"") = ifnull(T1.Batchnumber ,"") '+
            ' and ifnull(T2.BatchExpiryDate,0) = ifnull(T1.BatchExpiryDate ,0) '+
            ' and ifnull(T2.Binlocation,"")  = ifnull(T1.Binlocation ,"") '+
            ' and ifnull(T2.Binnumber,"") = ifnull(T1.Binnumber ,"") '+
            ' and ifnull(T2.Serialnumber,"") = ifnull(T1.Serialnumber ,"") '+
            ' where ifnull(T2.adjID,0)=0;';*)

    sSQL:= 'insert ignore into tblstockadjustmentImportExport  '+
            ' ( DepartmentID,UOMID,UOM,UOMMultiplier,PartsId,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription, '+
            ' DeptName,AccountName,AccountGroup,Batchnumber,TruckLoadNo,ExpiryDate , BatchExpiryDate,Binlocation,Binnumber,Serialnumber, '+
            ' UOMQty,Finalcount,AllocFinalcount,Qty,InstockUOMQty,InstockQty,Cost,Value,Active,Seqno,ProductBarCode) '+
            ' Select T1.DepartmentID, T1.UOMID, T1.UOM, T1.UOMMultiplier, T1.PartsId, T1.gLevel, T1.ProductName, T1.ProductColumn1, T1.ProductColumn2, T1.ProductColumn3, T1.PartsDescription,    '+
            ' T1.DeptName, T1.AccountName, T1.AccountGroup, T1.Batchnumber, T1.TruckLoadNo,T1.ExpiryDate , T1.BatchExpiryDate, T1.Binlocation, T1.Binnumber, T1.Serialnumber,    '+
            ' 0/*-T1.UOMQty*/, 0/*-T1.Finalcount*/, 0/*-T1.AllocFinalcount*/, 0/*-T1.Qty*/, 0/*-T1.InstockUOMQty*/, 0/*-T1.InstockQty*/, T1.Cost, 0/*-T1.Value*/,  '+
            ' T1.Active, T1.Seqno, T1.ProductBarCode '+
            ' from ' +fstablename +' T1 '+
            ' Left join tblstockadjustmentimportexport T2 '+
            ' on ifnull(T1.partsId,0) = ifnull(T2.partsID ,0) '+
            ' and ifnull(T1.departmentId,0) = ifnull(T2.DepartmentID ,0) '+
            ' and ifnull(T1.uomid,0) = ifnull(T2.uomid ,0) '+
            ' and ifnull(T2.Batchnumber,"") = ifnull(T1.Batchnumber ,"") '+
            ' and ifnull(T2.TruckLoadNo,"") = ifnull(T1.TruckLoadNo ,"") '+
            ' and ifnull(T2.BatchExpiryDate,0) = ifnull(T1.BatchExpiryDate ,0) '+
            ' and ifnull(T2.Binlocation,"")  = ifnull(T1.Binlocation ,"") '+
            ' and ifnull(T2.Binnumber,"") = ifnull(T1.Binnumber ,"") '+
            ' and ifnull(T2.Serialnumber,"") = ifnull(T1.Serialnumber ,"") '+
            ' where '+
            ' (ifnull(T1.Batchnumber,"") <> "" or ifnull(T1.TruckLoadNo,"") <> "" or ifnull(T1.Binlocation ,"")  <> "" or ifnull(T1.Serialnumber ,"")  <> "") '+
            ' and ifnull(T2.adjID,0)=0 '+
            ' union all '+
            ' Select T1.DepartmentID, T1.UOMID, T1.UOM, T1.UOMMultiplier, T1.PartsId, T1.gLevel, T1.ProductName, T1.ProductColumn1, T1.ProductColumn2, T1.ProductColumn3, T1.PartsDescription,    '+
            ' T1.DeptName, T1.AccountName, T1.AccountGroup, T1.Batchnumber, T1.TruckLoadNo,T1.ExpiryDate , T1.BatchExpiryDate, T1.Binlocation, T1.Binnumber, T1.Serialnumber,    '+
            ' 0/*-T1.UOMQty*/, 0/*-T1.Finalcount*/, 0/*-T1.AllocFinalcount*/, 0/*-T1.Qty*/, 0/*-T1.InstockUOMQty*/, 0/*-T1.InstockQty*/, T1.Cost, 0/*-T1.Value*/,  '+
            ' T1.Active, T1.Seqno, T1.ProductBarCode '+
            ' from ' +fstablename +' T1 '+
            ' Left join tblstockadjustmentimportexport T2 '+
            ' on ifnull(T1.partsId,0) = ifnull(T2.partsID ,0) '+
            ' and ifnull(T1.departmentId,0) = ifnull(T2.DepartmentID ,0) '+
            ' and ifnull(T1.uomid,0) = ifnull(T2.uomid ,0)  and ifnull(T2.finalcount,0)<> 0 '+
            ' where '+
            ' (ifnull(T1.Batchnumber,"") = "" and ifnull(T1.TruckLoadNo,"") = "" and ifnull(T1.Binlocation ,"")  = "" and ifnull(T1.Serialnumber ,"")  = "") '+
            ' and ifnull(T2.adjID,0)=0;';


    MakeExportdata(transDate , tDetailswithSno , true,true, fsTablename , 0 ,  '' , sProductDeptIDs, sSQL, StepProgresbarinScriptExec);
  finally
    DestroyUserTemporaryTable(fstablename);
  end;
end;

constructor TStockAdjustmentImportExport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NullWhenDateIs0 := True;
  fBusObjectTypeDescription:= 'StockAdjustmentExport';
  fSQL := 'SELECT  *  FROM tblstockadjustmentImportExport';
  fSQLOrder := 'PartsId,departmentID,uomid,abs(finalcount) desc, Batchnumber,TruckLoadNo,BatchExpiryDate,binlocation,binnumber,serialnumber , abs(Allocfinalcount) desc ';
end;


destructor TStockAdjustmentImportExport.Destroy;
begin
  inherited;
end;


procedure TStockAdjustmentImportExport.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'PartsId');
  SetPropertyFromNode(node,'DepartmentID');
  SetPropertyFromNode(node,'UOMID');
  SetPropertyFromNode(node,'UOM');
  SetPropertyFromNode(node,'UOMMultiplier');
  SetPropertyFromNode(node,'gLevel');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'ProductColumn1');
  SetPropertyFromNode(node,'ProductColumn2');
  SetPropertyFromNode(node,'ProductColumn3');
  SetPropertyFromNode(node,'PartsDescription');
  SetPropertyFromNode(node,'AccountName');
  SetPropertyFromNode(node,'AccountGroup');
  SetPropertyFromNode(node,'DeptName');
  SetPropertyFromNode(node,'Batchnumber');
  SetPropertyFromNode(node,'TruckLoadNo');
  SetPropertyFromNode(node,'ExpiryDate');
  SetDateTimePropertyFromNode(node,'BatchExpiryDate');
  SetPropertyFromNode(node,'Binlocation');
  SetPropertyFromNode(node,'Binnumber');
  SetPropertyFromNode(node,'Serialnumber');
  SetPropertyFromNode(node,'QtyType');
  SetPropertyFromNode(node,'UOMQty');
  SetPropertyFromNode(node,'Finalcount');
  SetPropertyFromNode(node,'AllocFinalcount');
  SetPropertyFromNode(node,'Qty');
  SetPropertyFromNode(node,'InstockUOMQty');
  SetPropertyFromNode(node,'InstockQty');
  SetPropertyFromNode(node,'Cost');
  SetPropertyFromNode(node,'Value');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'Seqno');
  SetPropertyFromNode(node,'ProductBarCode');
end;


procedure TStockAdjustmentImportExport.LoadPropnames;
begin
  inherited;
  if fPropnames.count = 20 then exit;
  fPropnames.clear;
  fPropnames.Add('ProductColumn1');
  fPropnames.Add('ProductColumn2');
  fPropnames.Add('ProductColumn3');
  fPropnames.Add('ProductName');
  fPropnames.Add('PartsDescription');
  fPropnames.Add('DeptName');
  fPropnames.Add('UOM');
  fPropnames.Add('UOMMultiplier');
  fPropnames.Add('Finalcount');
  fPropnames.Add('AccountGroup');
  fPropnames.Add('AccountName');
  fPropnames.Add('Batchnumber');
  fPropnames.Add('TruckLoadNo');
  fPropnames.Add('BatchExpiryDate');
  fPropnames.Add('Binlocation');
  fPropnames.Add('Binnumber');
  fPropnames.Add('Serialnumber');
  fPropnames.Add('QtyType');
  fPropnames.Add('AllocFinalcount');
  fPropnames.Add('Cost');
  fPropnames.Add('Active');
  fPropnames.Add('ProductBarCode');

end;

procedure TStockAdjustmentImportExport.MakeExportdata(transDate :TDatetime;filtertype :TFiltertype ; includeAllProducts:Boolean;ExcludeInactiveProducts:Boolean; Tablename :String =''; ClassId:Integer =0; sSelectedProducts:String = ''; sProductDeptIDs:String = ''; ExtraSQLToRun:String = ''; StepProgresbarinScriptExec : TBeforeStatementExecuteEvent = nil;QtyType :String =Adjustment_on_Quantity_type_Available);
var
  scr:TERPScript;
begin
  if Tablename = '' then tablename  := 'tblstockadjustmentImportExport';
  //With SharedScript do Try
  Scr := DbSharedObj.getscript(CommonDBLib.GetSharedMyDacConnection);
  try
      With scr do begin
        BeforeExecute :=StepProgresbarinScriptExec;
        SQL.Clear;
        
        if not SameText(tablename  , 'tblstockadjustmentImportExport') then SQL.Add('Create table if not exists ' + Tablename +' like tblstockadjustmentImportExport;');
        SQL.Add('TRuncate table ' + Tablename +';');

            // list of product list
            SQL.Add('insert ignore into ' + Tablename +' ' +
                        '(PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,' +
                        'PartsDescription,DeptName,Batchnumber,TruckLoadNo, ExpiryDate,BatchExpiryDate,Binlocation,Binnumber,Serialnumber,UOMQty,Qty,CustFld1,InstockUOMQty,InstockQty,Cost,Value) ' +
                        ProductQtyLib.StockQty(False, 0 , ClassId ,filtertype, iif(TransDate=0,incDay(Date),transDate), True)+';');

            SQL.Add('Delete from ' + Tablename +' where ifnull(GLevel,0)>=2  and ifnull(Batchnumber,"")="" and ifnull(Binlocation , "") = "" and ifnull(Serialnumber , "") = "";');
            SQL.Add('Delete from ' + Tablename +' where ifnull(GLevel,0)=4  and  ifnull(Serialnumber , "") <> "" and ifnull(Qty ,0)<=0;');
            SQL.Add('update ' + Tablename +' set seqno = 1;');

            SQL.Add('update ' + Tablename +' as tmp ' +
                        ' inner join tblPArts as P on P.PartsID = tmp.PartsId '+
                        ' Set tmp.Active = P.Active , ProductBarCode= P.Barcode ;');

            SQL.Add('delete from ' + Tablename +' where ifnull(DepartmentId,0) = 0;');
            SQL.Add('insert IGNORE into ' + Tablename +'  '+
                        ' (seqno , PartsId , DepartmentID, GLevel , ProductName,  ' +
                        'ProductColumn1, ProductColumn2, ProductColumn3, '+
                        'PartsDescription,DeptName,ProductBarcode,Active)  '+
                        'Select distinct  2, P.PartsId, PC.ClassId,1 , P.PartName  , '+
                        Firstcolumn+ ','+
                        Secondcolumn+ ','+
                        Thirdcolumn+ ','+
                        'PartsDescription,PC.Classname,P.Barcode,P.Active  '+
                        'from tblParts as P '+
                        'inner join tblProductClasses  as PC on  PC.ProductID = P.PartsID '+
                        'Where P.Parttype = "INV" and PC.active = ''T''   '+
                        'and P.PartsID not in (Select PartsId from ' + Tablename +'  Where DepartmentId = PC.ClassId)'+
                        'and    (PC.classId = ' +IntToStr(classID) +' or ' +IntToStr(classID) +' = 0);');

            SQL.Add(ProductUOMSQL('' + Tablename +'UOM'));

            SQL.Add('update ' + Tablename +' T  '+
                        ' inner join ' + Tablename +'UOM as T1 on T.PartsId = T1.PartsId  '+
                        ' Set T.UOMID = T1.PUOMID , T.UOM = T1.PUOM ,T.UOMMultiplier = T1.PMult   '+
                        ' where ifnull(T.UOMID,0) =0;');

            if includeAllProducts then begin
              SQL.Add('Drop table if exists ' + Tablename +'UOM1;');
              SQL.Add('Create table ' + Tablename +'UOM1 '+
                        'Select distinct '+
                        ' 3, P.PartsId, '+
                        'C.ClassID as DepartmentID,' +
                        'T.PUOMID  as UOMID,' +
                        'T.PUOM as UOM, '+
                        'T.PMult as UOMMultiplier, '+
                        '1 as gLevel, '+
                        'P.Partname as ProductName, '+
                        Firstcolumn + ' as ProductColumn1, '+
                        Secondcolumn+' as ProductColumn2, '+
                        Thirdcolumn +' as ProductColumn3, '+
                        'P.PartsDescription, '+
                        'C.ClassName as Deptname, '+
                        '"" as Batchnumber, '+
                        '"" as TruckLoadNo,' +
                        '0 as ExpiryDate, '+
                        '0 as BatchExpiryDate, '+
                        '"" as Binlocation, '+
                        '"" as  Binnumber, '+
                        '"" as Serialnumber, '+
                        '0 as UOMQty, '+
                        '0 as Qty, '+
                        '0 as InstockUOMQty, '+
                        '0 as InstockQty, '+
                        'AvgCost as Cost, '+
                        '0 as Value, '+
                        'P.Active, '+
                        'P.Barcode '+
                        'from tblclass  C, tblParts as P inner join tblproductClasses PC on P.partsId = PC.productID '+
                        'inner join ' + Tablename +'UOM T on P.partsId = T.PartsID '+
                        'Left join  ' + Tablename +' T1 on ' +
                        ' T.PartsId = T1.partsId  ' +
                        ' and  ifnull(T1.DepartmentID,0)=0  ' +
                        ' and T.PUOM = T1.UOM  ' +
                        ' and T1.gLevel=1  ' +
                        ' and ifnull(T1.Batchnumber,"")=""  ' +
                        ' and ifnull(T1.TruckLoadNo,"")="" '+
                        ' and ifnull(T1.ExpiryDate,"")=""  ' +
                        ' and ifnull(T1.Binlocation,"")=""  ' +
                        ' and ifnull(T1.Binnumber,"")=""  '+
                        'where  P.Parttype = "INV" and ifnull(T1.PartsId,0)=0 and PC.ClassId = C.classID '+
                        'and    (ifnull(C.ClassID,0) = ' +IntToStr(classID) +' or ' +IntToStr(classID) +' = 0);');

              SQL.Add('insert IGNORE into ' + Tablename +' '+
                        '( PartsId,DepartmentID,UOMID,UOM,UOMMultiplier,gLevel,ProductName,ProductColumn1,ProductColumn2,ProductColumn3,PartsDescription,DeptName,Cost,Active,ProductBarCode) '+
                        ' Select distinct  T.PartsId,T.DepartmentID, T.UOMID,T.UOM,T.UOMMultiplier,T.gLevel,T.ProductName,T.ProductColumn1, '+
                        ' T.ProductColumn2,T.ProductColumn3, T.PartsDescription, T.DeptName, T.Cost,T.Active,T.Barcode '+
                        ' from ' + Tablename +'UOM1 T '+
                        ' Left join  ' + Tablename +' T1 on  T.PartsId = T1.partsId    '+
                        ' and  ifnull(T1.DepartmentID,0)= T.DepartmentID   and T.UOM = T1.UOM   and T1.gLevel=1    '+
                        ' and ifnull(T1.Batchnumber,"")=""  and ifnull(T1.TruckLoadNo,"")=""  and ifnull(T1.ExpiryDate,"")=""   and ifnull(T1.Binlocation,"")=""   and ifnull(T1.Binnumber,"")="" '+
                        ' where  ifnull(T1.PartsId,0)=0;');

              SQL.Add('Drop table if exists ' + Tablename +'UOM1;');
              SQL.Add('update ' + Tablename +' Set AllocFinalcount = ' + iif(QtyType =Adjustment_on_Quantity_type_Instock , 'InstockUOMQty' , 'UOMQty')+', '+
                            ' QtyType = '+quotedstr(QtyType) +
                            ' Where ifnull(Batchnumber,"")    <> ""  '+
                            '    Or ifnull(TruckLoadNo,"")    <> ""  '+
                            '    or ifnull(ExpiryDate,0)      <> 0  '+
                            '    or ifnull(BatchExpiryDate,"")<> ""  '+
                            '    or ifnull(Binlocation,"")    <> ""  '+
                            '    or ifnull(Binnumber,"")      <> ""  '+
                            '    or ifnull(Serialnumber,"")   <> "" ;');
              SQL.Add('update ' + Tablename +' Set Finalcount = ' + iif(QtyType =Adjustment_on_Quantity_type_Instock , 'InstockUOMQty' , 'UOMQty')+', '+
                            '  QtyType = '+quotedstr(QtyType) +
                            ' Where ifnull(Batchnumber,"")    = ""  '+
                            '   and ifnull(TruckLoadNo,"")    = ""  '+
                            '   and ifnull(ExpiryDate,0)      = 0  '+
                            '   and ifnull(BatchExpiryDate,"")= ""  '+
                            '   and ifnull(Binlocation,"")    = ""  '+
                            '   and  ifnull(Binnumber,"")     = ""  '+
                            '   and  ifnull(Serialnumber,"")  = "" ;');
            end;
            SQL.Add('Drop table if exists ' + Tablename +'UOM;');
            if sSelectedProducts <> '' then
              SQL.Add('Delete from  ' + Tablename +' where PartsId not in (' + sSelectedProducts +');');
            if sProductDeptIDs <> '' then
              SQL.Add('Delete from  ' + Tablename +' where not (' + sProductDeptIDs +');');
            SQL.Add('update ' + tablename +' T inner join tblparts P on T.PartsId = P.PartsId Set T.Batch = P.batch , T.Bins = P.MultipleBins , T.SN = P.SNTracking;');
            SQL.Add(ExtraSQLToRun);
            if ClassId <> 0 then SQL.Add('Delete from ' + tablename +' where DepartmentID<> ' +inttostr(ClassID)+';');
            if ExcludeInactiveProducts then SQL.Add('Delete from ' + tablename +' where Active ="F";');
            SQL.Add('Delete from ' + tablename +' where (ifnull(Batchnumber,"")<>"" or ifnull(Binlocation , "")<>"" or ifnull(Serialnumber , "")<> "") and ifnull(AllocFinalcount,0) =0 ;');
            clog(SQL.Text);
            Execute;
      end;
    finally
        scr.BeforeExecute := nil;
        DbSharedObj.ReleaseObj(scr);
    end;
end;

procedure TStockAdjustmentImportExport.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'PartsId' ,PartsId);
  AddXMLNode(node,'DepartmentID' ,DepartmentID);
  AddXMLNode(node,'UOMID' ,UOMID);
  AddXMLNode(node,'UOM' ,UOM);
  AddXMLNode(node,'UOMMultiplier' ,UOMMultiplier);
  AddXMLNode(node,'gLevel' ,gLevel);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'ProductColumn1' ,ProductColumn1);
  AddXMLNode(node,'ProductColumn2' ,ProductColumn2);
  AddXMLNode(node,'ProductColumn3' ,ProductColumn3);
  AddXMLNode(node,'PartsDescription' ,PartsDescription);
  AddXMLNode(node,'AccountName' ,AccountName);
  AddXMLNode(node,'AccountGroup' ,AccountGroup);
  AddXMLNode(node,'DeptName' ,DeptName);
  AddXMLNode(node,'Batchnumber' ,Batchnumber);
  AddXMLNode(node,'TruckLoadNo' ,TruckLoadNo);
  AddXMLNode(node,'ExpiryDate' ,ExpiryDate);
  AddXMLNode(node,'BatchExpiryDate' ,BatchExpiryDate);
  AddXMLNode(node,'Binlocation' ,Binlocation);
  AddXMLNode(node,'Binnumber' ,Binnumber);
  AddXMLNode(node,'Serialnumber' ,Serialnumber);
  AddXMLNode(node,'QtyType' ,QtyType);
  AddXMLNode(node,'UOMQty' ,UOMQty);
  AddXMLNode(node,'Finalcount' ,Finalcount);
  AddXMLNode(node,'AllocFinalcount' ,AllocFinalcount);
  AddXMLNode(node,'Qty' ,Qty);
  AddXMLNode(node,'InstockUOMQty' ,InstockUOMQty);
  AddXMLNode(node,'InstockQty' ,InstockQty);
  AddXMLNode(node,'Cost' ,Cost);
  AddXMLNode(node,'Value' ,Value);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Seqno' ,Seqno);
  AddXMLNode(node,'ProductBarCode' ,ProductBarCode);
end;


function TStockAdjustmentImportExport.ValidateData: Boolean ;
begin
  //Result := False;
  Resultstatus.Clear;
  Result := True;
end;


function TStockAdjustmentImportExport.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TStockAdjustmentImportExport.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TStockAdjustmentImportExport.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled  then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sametext(Sender.FieldName , 'ProductName') then begin
    PartsId := GetProduct(ProductName);
    DoFieldOnChange(dataset.Findfield('PartsId'));
  end else if Sametext(Sender.FieldName , 'PartsId') then begin
    UOMID := GetUnitOfMeasureID(UOM, PartsId);
  end else if Sametext(Sender.FieldName , 'DeptName') then begin
    DepartmentId := GetDeptID(DeptName);
  end else if Sametext(Sender.FieldName , 'UOM') then begin
    UOMID := GetUnitOfMeasureID(UOM, PartsId);
  end;
end;


function TStockAdjustmentImportExport.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TStockAdjustmentImportExport.GetIDField: string;
begin
  Result := 'AdjID'
end;


class function TStockAdjustmentImportExport.GetBusObjectTablename: string;
begin
  Result:= 'tblstockadjustmentImportExport';
end;


function TStockAdjustmentImportExport.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TStockAdjustmentImportExport.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
end;

function TStockAdjustmentImportExport.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
  if not result then exit;
end;

{Property Functions}
function  TStockAdjustmentImportExport.GetPartsId         : Integer   ; begin Result := GetIntegerField('PartsId');end;
function  TStockAdjustmentImportExport.GetDepartmentID    : Integer   ; begin Result := GetIntegerField('DepartmentID');end;
function  TStockAdjustmentImportExport.GetUOMID           : Integer   ; begin Result := GetIntegerField('UOMID');end;
function  TStockAdjustmentImportExport.GetUOM             : string    ; begin Result := GetStringField('UOM');end;
function  TStockAdjustmentImportExport.GetUOMMultiplier   : Double    ; begin Result := GetFloatField('UOMMultiplier');end;
function  TStockAdjustmentImportExport.GetgLevel          : Integer   ; begin Result := GetIntegerField('gLevel');end;
function  TStockAdjustmentImportExport.GetProductName     : string    ; begin Result := GetStringField('ProductName');end;
function  TStockAdjustmentImportExport.GetProductColumn1  : string    ; begin Result := GetStringField('ProductColumn1');end;
function  TStockAdjustmentImportExport.GetProductColumn2  : string    ; begin Result := GetStringField('ProductColumn2');end;
function  TStockAdjustmentImportExport.GetProductColumn3  : string    ; begin Result := GetStringField('ProductColumn3');end;
function  TStockAdjustmentImportExport.GetPartsDescription: string    ; begin Result := GetStringField('PartsDescription');end;
function  TStockAdjustmentImportExport.GetAccountName     : string    ; begin Result := GetStringField('AccountName');end;
function  TStockAdjustmentImportExport.GetAccountGroup    : string    ; begin Result := GetStringField('AccountGroup');end;
function  TStockAdjustmentImportExport.GetDeptName        : string    ; begin Result := GetStringField('DeptName');end;
function  TStockAdjustmentImportExport.GetBatchnumber     : string    ; begin Result := GetStringField('Batchnumber');end;
function  TStockAdjustmentImportExport.GetTruckLoadNo     : string    ; begin Result := GetStringField('TruckLoadNo');end;
function  TStockAdjustmentImportExport.GetExpiryDate      : string    ; begin Result := GetStringField('ExpiryDate');end;
function  TStockAdjustmentImportExport.GetBatchExpiryDate : TDateTime ; begin Result := GetDateTimeField('BatchExpiryDate');end;
function  TStockAdjustmentImportExport.GetBinlocation     : string    ; begin Result := GetStringField('Binlocation');end;
function  TStockAdjustmentImportExport.GetBinnumber       : string    ; begin Result := GetStringField('Binnumber');end;
function  TStockAdjustmentImportExport.GetSerialnumber    : string    ; begin Result := GetStringField('Serialnumber');end;
function  TStockAdjustmentImportExport.GetQtyType         : string    ; begin Result := GetStringField('QtyType');end;
function  TStockAdjustmentImportExport.GetUOMQty          : Double    ; begin Result := GetFloatField('UOMQty');end;
function  TStockAdjustmentImportExport.GetFinalcount      : Double    ; begin Result := GetFloatField('Finalcount');end;
function  TStockAdjustmentImportExport.GetAllocFinalcount : Double    ; begin Result := GetFloatField('AllocFinalcount');end;
function  TStockAdjustmentImportExport.GetQty             : Double    ; begin Result := GetFloatField('Qty');end;
function  TStockAdjustmentImportExport.GetInstockUOMQty   : Double    ; begin Result := GetFloatField('InstockUOMQty');end;
function  TStockAdjustmentImportExport.GetInstockQty      : Double    ; begin Result := GetFloatField('InstockQty');end;
function  TStockAdjustmentImportExport.GetCost            : Double    ; begin Result := GetFloatField('Cost');end;
function  TStockAdjustmentImportExport.GetValue           : Double    ; begin Result := GetFloatField('Value');end;
function  TStockAdjustmentImportExport.GetActive          : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TStockAdjustmentImportExport.GetSeqno           : Integer   ; begin Result := GetIntegerField('Seqno');end;
function  TStockAdjustmentImportExport.GetProductBarCode  : string    ; begin Result := GetStringField('ProductBarCode');end;
procedure TStockAdjustmentImportExport.SetPartsId         (const Value: Integer   ); begin SetIntegerField('PartsId'          , Value);end;
procedure TStockAdjustmentImportExport.SetDepartmentID    (const Value: Integer   ); begin SetIntegerField('DepartmentID'     , Value);end;
procedure TStockAdjustmentImportExport.SetUOMID           (const Value: Integer   ); begin SetIntegerField('UOMID'            , Value);end;
procedure TStockAdjustmentImportExport.SetUOM             (const Value: string    ); begin SetStringField('UOM'              , Value);end;
procedure TStockAdjustmentImportExport.SetUOMMultiplier   (const Value: Double    ); begin SetFloatField('UOMMultiplier'    , Value);end;
procedure TStockAdjustmentImportExport.SetgLevel          (const Value: Integer   ); begin SetIntegerField('gLevel'           , Value);end;
procedure TStockAdjustmentImportExport.SetProductName     (const Value: string    ); begin SetStringField('ProductName'      , Value);end;
procedure TStockAdjustmentImportExport.SetProductColumn1  (const Value: string    ); begin SetStringField('ProductColumn1'   , Value);end;
procedure TStockAdjustmentImportExport.SetProductColumn2  (const Value: string    ); begin SetStringField('ProductColumn2'   , Value);end;
procedure TStockAdjustmentImportExport.SetProductColumn3  (const Value: string    ); begin SetStringField('ProductColumn3'   , Value);end;
procedure TStockAdjustmentImportExport.SetPartsDescription(const Value: string    ); begin SetStringField('PartsDescription' , Value);end;
procedure TStockAdjustmentImportExport.SetAccountName     (const Value: string    ); begin SetStringField('AccountName' , Value);end;
procedure TStockAdjustmentImportExport.SetAccountGroup    (const Value: string    ); begin SetStringField('AccountGroup' , Value);end;
procedure TStockAdjustmentImportExport.SetDeptName        (const Value: string    ); begin SetStringField('DeptName'        , Value);end;
procedure TStockAdjustmentImportExport.SetBatchnumber     (const Value: string    ); begin SetStringField('Batchnumber'      , Value);end;
procedure TStockAdjustmentImportExport.SetTruckLoadNo     (const Value: string    ); begin SetStringField('TruckLoadNo'      , Value);end;
procedure TStockAdjustmentImportExport.SetExpiryDate      (const Value: string    ); begin SetStringField('ExpiryDate'       , Value);end;
procedure TStockAdjustmentImportExport.SetBatchExpiryDate (const Value: TDateTime ); begin SetDateTimeField('BatchExpiryDate' , Value);end;
procedure TStockAdjustmentImportExport.SetBinlocation     (const Value: string    ); begin SetStringField('Binlocation'      , Value);end;
procedure TStockAdjustmentImportExport.SetBinnumber       (const Value: string    ); begin SetStringField('Binnumber'        , Value);end;
procedure TStockAdjustmentImportExport.SetSerialnumber    (const Value: string    ); begin SetStringField('Serialnumber'     , Value);end;
procedure TStockAdjustmentImportExport.SetQtyType         (const Value: string    ); begin SetStringField('QtyType'     , Value);end;
procedure TStockAdjustmentImportExport.SetUOMQty          (const Value: Double    ); begin SetFloatField('UOMQty'           , Value);end;
procedure TStockAdjustmentImportExport.SetFinalcount      (const Value: Double    ); begin SetFloatField('Finalcount'        , Value);end;
procedure TStockAdjustmentImportExport.SetAllocFinalcount (const Value: Double    ); begin SetFloatField('AllocFinalcount' , Value);end;
procedure TStockAdjustmentImportExport.SetQty             (const Value: Double    ); begin SetFloatField('Qty'              , Value);end;
procedure TStockAdjustmentImportExport.SetInstockUOMQty   (const Value: Double    ); begin SetFloatField('InstockUOMQty'    , Value);end;
procedure TStockAdjustmentImportExport.SetInstockQty      (const Value: Double    ); begin SetFloatField('InstockQty'       , Value);end;
procedure TStockAdjustmentImportExport.SetCost            (const Value: Double    ); begin SetFloatField('Cost'             , Value);end;
procedure TStockAdjustmentImportExport.SetValue           (const Value: Double    ); begin SetFloatField('Value'            , Value);end;
procedure TStockAdjustmentImportExport.SetActive          (const Value: Boolean   ); begin SetBooleanField('Active'           , Value);end;
procedure TStockAdjustmentImportExport.SetSeqno           (const Value: Integer   ); begin SetIntegerField('Seqno'            , Value);end;
procedure TStockAdjustmentImportExport.SetProductBarCode  (const Value: string    ); begin SetStringField('ProductBarCode'   , Value);end;
function TStockAdjustmentImportExport.getAdjustmentOnInstock: Boolean;
begin
  REsult := Sametext(Qtytype , Adjustment_on_Quantity_type_Instock);
end;
class function TStockAdjustmentImportExport.HeaderLine(const SeparatorValue:String): String;
var
  ctr:Integer;
begin
  With TStockAdjustmentImportExport.Create(nil) do try
    result:= '';
    for ctr:= 0 to Propnames.count-1 do begin
      if result <> '' then result := result + SeparatorValue;
      Result := result + Propnames[ctr];
    end;
    //result := Propnames.CommaText;
  finally
    Free;
  end;
end;
function TStockAdjustmentImportExport.getProductDeptIDs: String;
begin
  With TERPQuery(GetNewdataset('Select concat("(PartsId = "  , PartsId , " and departmentId = " , departmentId, ")") ProductDeptIDs '+
            ' from tblstockadjustmentimportexport ' , true)) do try
    REsult := Groupconcat('ProductDeptIDs' , '' , false, ' OR ');
  finally
    ClosenFree;
  end;
end;

initialization

  RegisterClass(TStockAdjustmentImportExport);
  RegisterClass(TMultiStockAdjustExport);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Stock Adjustment','TStockAdjustmentImportExport','' , []);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Stock Adjustment (Multiple)','TMultiStockAdjustExport','TStockAdjustEntryListGUI' , [boExport]);
end.
