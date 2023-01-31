unit BusObjProcTreePart;

interface

uses
  Classes, BusObjPQA, DB, BusObjBase,  DNMAccessManager, XMLDoc, XMLIntf , busobjProcProgress;

type
  TSubNodeManufcaturePQA = class(TPQA)

  end;

  TProcTreePart = class(TProdQty)
  private
    function GetProcTreeId: integer;
    function GetProcTreePartId: integer;
    procedure SetProcTreeId(const Value: integer);
    procedure SetProcTreePartId(const Value: integer);
    function GetDateRequired: TDateTime;
    procedure SetDateRequired(const Value: TDateTime);
    procedure GetProductDetails;
    function GetSaleId: integer;
    function GetSaleLineId: integer;
    procedure SetSaleId(const Value: integer);
    procedure SetSaleLineId(const Value: integer);
//    function GetUOMQtyOriginal: double;
//    function GetUOMQtyUsed: double;
//    procedure SetUOMQtyOriginal(const Value: double);
//    procedure SetUOMQtyUsed(const Value: double);
    procedure setClassID(const Value: integer);
    function getSubNodeManufcaturePQA: TSubNodeManufcaturePQA;
(*    function getManufacturedPQA: TPQA;
    function getManufacturingPQA: TPQA;*)

    function GetFromStockUOMQty	:double;
    function GetManufactureUOMQty	:double;
    function GetManufacturedUOMQty	:double;
    function GetManufacturingUOMQty	:double;
    function GetOnOrderUOMQty	:double;
    function GetFromStockQty	:double;
    function GetManufactureQty	:double;
    function GetManufacturedQty	:double;
    function GetManufacturingQty	:double;
    function GetOnOrderQty	:double;

    Procedure SetFromStockUOMQty	(const Value :double);
    Procedure SetManufactureUOMQty	(const Value :double);
    Procedure SetManufacturedUOMQty	(const Value :double);
    Procedure SetManufacturingUOMQty	(const Value :double);
    Procedure SetOnOrderUOMQty	(const Value :double);
    Procedure SetFromStockQty	(const Value :double);
    Procedure SetManufactureQty	(const Value :double);
    Procedure SetManufacturedQty	(const Value :double);
    Procedure SetManufacturingQty	(const Value :double);
    Procedure SetOnOrderQty	(const Value :double);
    function getBOMGroupedLine: Boolean;
    procedure setBOMGroupedLine(const Value: Boolean);
    function getBOMProductionLine: boolean;
    procedure setBOMProductionLine(const Value: boolean);
    function getToBeManufacturedQty : Double;
    function getToBeManufacturingQty : Double;
    function getManufacturedProgress: TProcProgressIn;
    function getManufacturingProgress: TProcProgressOUT;
    function getConvertCurrent: boolean;
    procedure CompleteallProcprogressCallback(const Sender: TBusObj; var Abort: Boolean);
    function getCaption: String;
    function hasProgressbuild:Boolean;
  protected
    function GetClassID         : Integer;  override;
    function GetSerialnos       : String;   override;
    function GetQty             : Double;   override;
    function GetUOMQty          : Double;   override;
    function GetCleanClassID   : Integer;  override;
    function GetcleanProductId  : Integer;  override;
    function GetHeaderID       : Integer;  override;
    function GetUnitOfMeasure   : String;   override;
    function GetUnitOfMeasureID: Integer;  override;
    function GetUOMMultiplier   : Double;   override;
    function GetId              : Integer;  override;
    function GetTransDate       : TDatetime; override;
    procedure SetQty(const Value: Double);              override;
    procedure SetUOMQty(const Value: Double);           override;
    procedure SetSerialNos(const Value: String);        override;
    procedure SetUnitOfMeasure(const Value: String);    override;
    procedure SetUnitOfMeasureID(const Value: Integer); override;
    procedure SetUOMMultiplier(const Value: Double);    override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetAccessManager :TDNMAccessManager; override;
    Function GetAllocType        :String; override;
    Function  GetIsPQAItem       :Boolean;   override;
    function GetActive: boolean; override;
    procedure SetActive(const Value: Boolean); override;
    function GetProductID :Integer; override;
    function GetProductName :String; override;
    procedure SetProductID(const Value: Integer); override;
    procedure SetProductName(const Value: String); override;
    function GetBOQty: double; override;
    function GetBOUOMQty: double; override;
    procedure SetBOQty(const Value: Double); override;
    procedure SetBOUOMQty(const Value: Double); override;
    function GetEnableAllocation :Boolean; override;
    function GetOrderQty         :Double; override;
    function GetUOMOrderQty      :Double; override;
    procedure SetOrderQty(const Value: Double); override;
    procedure SetUOMOrderQty(const Value: Double); override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
    Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;  Override;
    Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean;  Override;
    Function  DoBeforeDelete(Sender :TDatasetBusObj ):Boolean;  Override;
    Function  ExportsubClasses(Const node: IXMLNode):Boolean;Override;
    function GetProductType: string;override;
    procedure SetProductType(const Value: string);override;
    procedure SetTransDate(const Value: TDatetime); override;
    procedure SetMatrixRef(const Value: String);Override;
    function GetMatrixRef: String;Override;
    function GetMatrixDesc: String;Override;
    function GetMatrixPrice:Double;Override;
    procedure SetMatrixDesc(const Value: String);Override;
    procedure SetMatrixPrice(const Value: Double);Override;



  public
    function SubNodeManufcaturePQAcount: Integer;
(*    function ManufacturedPQAcount: Integer;
    function ManufacturingPQAcount: Integer;*)
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    function ValidateData       : Boolean;  override;
    function Save               : Boolean;  override;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    Procedure LoadFromXMLNode(const node: IXMLNode); override;
    function IsSubNodeParent: Boolean;
    function isRootNode:Boolean;
    Property ToBeManufacturedQty :Double read getToBeManufacturedQty;
    Property ToBeManufacturingQty :Double read getToBeManufacturingQty;
    Procedure MoveAllocation(fdQuantity: Double; ToPQA: TPQA);
    Function IsSerialNumberAllocated(aSerialnumber:String):boolean;
    Property ConvertCurrent :boolean read getConvertCurrent;
    Procedure CompleteallProcprogress;
    Property Caption :String read getCaption;

  published
    property ProcTreePartId: integer read GetProcTreePartId write SetProcTreePartId;
    property ProcTreeId: integer read GetProcTreeId write SetProcTreeId;
    property DateRequired: TDateTime read GetDateRequired write SetDateRequired;
    property SaleId: integer read GetSaleId write SetSaleId;
    property SaleLineId: integer read GetSaleLineId write SetSaleLineId;
    property ClassId: integer read GetClassID write setClassID;
    Property FromStockUOMQty: double read getFromStockUOMQty Write SetFromStockUOMQty	;
    Property ManufactureUOMQty: double read getManufactureUOMQty Write SetManufactureUOMQty	;
    Property ManufacturedUOMQty: double read getManufacturedUOMQty Write SetManufacturedUOMQty	;
    Property ManufacturingUOMQty: double read getManufacturingUOMQty Write SetManufacturingUOMQty	;
    Property OnOrderUOMQty: double read getOnOrderUOMQty Write SetOnOrderUOMQty	;
    Property FromStockQty: double read getFromStockQty Write SetFromStockQty	;
    Property ManufactureQty: double read getManufactureQty Write SetManufactureQty	;
    Property ManufacturedQty: double read getManufacturedQty Write SetManufacturedQty	;
    Property ManufacturingQty: double read getManufacturingQty Write SetManufacturingQty	;
    Property OnOrderQty: double read getOnOrderQty Write SetOnOrderQty	;
    Property SubNodeManufcaturePQA: TSubNodeManufcaturePQA read getSubNodeManufcaturePQA;
(*    Property ManufacturedPQA: TPQA read getManufacturedPQA;
    Property ManufacturingPQA: TPQA read getManufacturingPQA;*)
    Property  BOMGroupedLine :Boolean read getBOMGroupedLine Write setBOMGroupedLine;
    Property  BOMProductionLine :boolean read getBOMProductionLine Write setBOMProductionLine;
    Procedure Logit(ProductnameToLog:String ='');
    Property  ManufacturedProgress  :TProcProgressIn read getManufacturedProgress;
    Property  ManufacturingProgress :TProcProgressOUT read getManufacturingProgress;


  end;
  TProcTreePartClean = class(TProcTreePart)
    Private
    Protected
      Function  GetIsPQAItem       :Boolean;   override;
    Public
      constructor Create(AOwner: TComponent); override;
  end;
implementation

uses
  SysUtils, tcConst, BusobjProductProperties,
  CommonLib, BusObjStock, BusObjNDSBase, BusObjProcess, BusObjConst,
  ERPdbComponents,AppEnvironment, LogLib, BusobjProctree, DbSharedObjectsObj,
  BusObjSales, tcDataUtils, ProgressDialog, CommonDbLib;

{ TProcTreePart }


procedure TProcTreePart.CompleteallProcprogress;
begin
    DoStepProgressbar('Checking for Progress Builds of '+ Productname);
    if hasProgressbuild then begin
      ManufacturedProgress.iteraterecords(CompleteallProcprogressCallback);
      ManufacturingProgress.iteraterecords(CompleteallProcprogressCallback);
      Container.FreeAndDelete(ManufacturedProgress); // Binny : deleting from the container to release the memory - steel mains having issues with big sales orders
      Container.FreeAndDelete(ManufacturingProgress);
    end;
    //DoHideProgressbar;
end;
procedure TProcTreePart.CompleteallProcprogressCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if sender is TProcProgress then begin
    DoStepProgressbar(caption +' : '  + inttostr(TProcProgress(Sender).recno)+' of ' + inttostr(TProcProgress(Sender).count));
    if TProcProgress(Sender).IsPQAItem then begin
      TProcProgress(Sender).PQA.active := true;
      TProcProgress(Sender).PQA.PostDB;
    end;
  end;
end;

constructor TProcTreePart.Create(AOwner: TComponent);
begin
  inherited;
  fSQL:= 'SELECT * FROM tblProcTreePart';
  fBusObjectTypeDescription:= 'Process Tree Product Object';
  LogChangesOnSave := False;
end;

destructor TProcTreePart.Destroy;
begin

  inherited;
end;

procedure TProcTreePart.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'ProductId') then begin
    self.ProductName:= '';
    //Product.Load(ProductId);
    self.ProductName:= Product.ProductName;
    ProductType          := Product.ProductType;
    GetProductDetails;
  end  else if Sysutils.SameText(Sender.FieldName, 'ProductName') then begin
    self.ProductID:= 0;
    //Product.LoadSelect('PARTNAME = ' + QuotedStr(ProductName));
    self.ProductID:= Product.Id;
    GetProductDetails;
  end  else if Sysutils.SameText(Sender.FieldName, 'ManufacturedUOMQty')  then begin ManufacturedQty:= ManufacturedUOMQty * UOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'ManufacturedQty')     then begin ManufacturedUOMQty:= ManufacturedQty / UOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'ManufacturingUOMQty') then begin ManufacturingQty:= ManufacturingUOMQty * UOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'ManufacturingQty')    then begin ManufacturingUOMQty:= ManufacturingQty / UOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'UOMQty')              then begin Qty:= UOMQty * UOMMultiplier;
  end  else if Sysutils.SameText(Sender.FieldName, 'Qty')                 then begin UOMQty:= Qty / UOMMultiplier;
(*  end  else if Sysutils.SameText(Sender.FieldName, 'UOMQtyUsed') then begin
    UOMQty:= Sender.AsFloat;
    Qty:= UOMQty * UOMMultiplier;*)
  end  else if Sysutils.SameText(Sender.FieldName, 'UnitOfMeasureMultiplier') then begin

  end
end;
function TProcTreePart.getHeaderID: Integer;
begin
  Result:= 0;
  if Owner is TSalesLineProcTree then
    result:= TSalesLineProcTree(Owner).SalesLine.SaleId
  else if owner is Tproctree then
    result:= Tproctree(Owner).SaleID;
end;
procedure TProcTreePart.GetProductDetails;
begin
  UnitOfMeasureID:= Product.UOMIDforManufacture;
  With Product.GetNewDataset('SELECT `Multiplier`, `UnitName`  FROM `tblunitsofmeasure` where  `UnitID` = ' +intToStr(UnitOfMeasureID)) do try
    UOMMultiplier:= FieldByname('Multiplier').asFloat;
    UnitOfMeasure:= FieldByname('UnitName').asString;
  finally
      close;free;
  end;
  if UOMMultiplier = 0 then
    UOMMultiplier:= 1;
  if UnitOfMeasure = '' then
    UnitOfMeasure:= AppEnv.DefaultClass.DefaultUOM;
end;

procedure TProcTreePart.OnDataIdChange(  const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TProcTreePart.Save: Boolean;
var
  fPQA:TPQA;
  fbFlag :Boolean;
begin

  if owner is TSalesLineProcTree then begin
    if IsPQAItem then begin

        PQA.Active:= self.Active and
           (not TSalesLineProcTree(Owner).Deleted) and
           TSalesLineProcTree(Owner).Complete and
           (not (TSalesLineProcTree(Owner).IsOptionItem and (not TSalesLineProcTree(Owner).Selected)));
      (*if isRootNode then Logtext(TSalesLineProcTree(Owner).caption );
      Logtext(TSalesLineProcTree(Owner).CaptionIntended +',' +
              inttostr(TSalesLineProcTree(Owner).ID)+','+
              inttostr(PQA.ID)+','+
              PQA.TransType+','+
              PQA.Alloctype+','+
              BooleanToString(PQA.Active)+','+
              BooleanToString(self.Active)+','+
              BooleanToString(not TSalesLineProcTree(Owner).Deleted)+','+
              BooleanToString(TSalesLineProcTree(Owner).Complete)+','+
              BooleanToString(not (TSalesLineProcTree(Owner).IsOptionItem and (not TSalesLineProcTree(Owner).Selected))));*)

      if ConvertCurrent then begin
        if isRootNode then begin
          if Assigned(Owner) and (owner is TSalesLineProcTree) then
            if Assigned(TSalesLineProcTree(owner).owner) and (TSalesLineProcTree(owner).owner is TSalesOrderLine) then begin
              if TSalesOrderLine(TSalesLineProcTree(owner).owner).UOMQtyshipped <> ManufactureduomQty then begin
                fbFlag := TSalesOrderLine(TSalesLineProcTree(owner).owner).DoFieldChangewhenDisabled;
                TSalesOrderLine(TSalesLineProcTree(owner).owner).DoFieldChangewhenDisabled := TRue;
                try
                  TSalesOrderLine(TSalesLineProcTree(owner).owner).BOMComments := trim(TSalesOrderLine(TSalesLineProcTree(owner).owner).BOMComments +NL+'Partially Built and Converted. Planned Build was ' + Floattostrf(TSalesOrderLine(TSalesLineProcTree(owner).owner).UOMQtyshipped , ffGeneral, 15,2));
                  TSalesOrderLine(TSalesLineProcTree(owner).owner).UOMQtysold := TSalesOrderLine(TSalesLineProcTree(owner).owner).UOMQtysold - (TSalesOrderLine(TSalesLineProcTree(owner).owner).UOMQtyshipped- ManufactureduomQty);
                  TSalesOrderLine(TSalesLineProcTree(owner).owner).UOMQtyshipped :=ManufactureduomQty ;
                  TSalesOrderLine(TSalesLineProcTree(owner).owner).Postdb;
                finally
                  TSalesOrderLine(TSalesLineProcTree(owner).owner).DoFieldChangewhenDisabled := fbFlag;
                end;
              end;
            end;
          PQA.delete;
        end else if TProcTreeNode(Owner).Children.count  =0 then begin
          PQA.delete;
        end else begin
          PQA.delete;
          SubNodeManufcaturePQA.delete;
        end;
      end else begin
        if IsSubNodeParent and (ManufactureUOMQty <>0) then begin
          SubNodeManufcaturePQA.Active := PQA.Active;
          SubNodeManufcaturePQA.PostDB;
        end else begin
          fPQA := SubNodeManufcaturePQA;
          if fPQA.count>0 then fPQA.DeleteAll;
        end;
        if TSalesLineProcTree(owner).ConvertCurrent then begin
          if (manufacturingqty <> 0) and (pqa.transtype = self.classname) then begin
            pqa.Deleteall;
          end;

          if (manufacturedqty <> 0) and (pqa.transtype = self.classname+'IN') then begin
            pqa.deleteall;
          end;
        end;
        (*fPQA := ManufacturedPQA;
        if IsSubNodeParent or isRootnode then begin
          if (ManufacturedUOMQty <>0) then begin
            if fpqa.Active <>True then fpqa.Active := True;
            if fpqa.Qty <> ManufacturedUOMQty then fpqa.Qty := ManufacturedUOMQty;
          end else begin
            if not fpqa.Active then fpqa.Active := True;
            if fPQA.count>0 then if fPQA.Qty <> 0 then fPQA.Qty :=0;
          end;
          fpqa.PostDB;
        end else begin
            if fPQA.count>0 then fPQA.DeleteAll;
        end;

        fPQA := ManufacturingPQA;
        if not(isRootnode) then begin
          if (ManufacturingUOMQty <>0) then begin
            if fpqa.Active <>True then fpqa.Active := True;
            if fpqa.Qty <> ManufacturingUOMQty then fpqa.Qty := ManufacturingUOMQty;
          end else begin
            if not fpqa.Active then fpqa.Active := True;
            if fPQA.count>0 then if fPQA.Qty <> 0 then fPQA.Qty :=0;
          end;
          fpqa.PostDB;
        end else begin
            if fPQA.count>0 then fPQA.DeleteAll;
        end;*)
      end;
    end;
  end;
  result:= inherited Save;
    Logit('Main Tree');
end;


class function TProcTreePart.GetIdField: String;begin  result:= 'ProcTreePartId';end;
class function TProcTreePart.GetBusObjectTablename: string;begin  Result := 'tblProcTreePart';end;

function TProcTreePart.getCaption: String;
begin
  result := Productname;
  if result = '' then
  if Owner is TSalesLineProcTree then result:= TSalesLineProcTree(Owner).caption
  else if owner is Tproctree then     result:= Tproctree(Owner).caption
  else result := '';

end;

//function TProcTreePart.GetUOMQtyOriginal: double;begin  Result:= GetFloatField('UOMQtyOriginal');end;
//function TProcTreePart.GetUOMQtyUsed: double;begin  Result:= GetFloatField('UOMQtyUsed');end;
function TProcTreePart.GetTransDate: TDatetime;
begin
  result:= DateRequired;
  if result = 0 then
    if assigned(Owner) and (Owner is TSalesLineProcTree) then
      result := TSalesLineProcTree(Owner).Sales.Saledatetime(*.SalesLine.Shipdate*)
    else result := now;  // its the building time which is now
end;
function TProcTreePart.getConvertCurrent: boolean;
begin
  result := False;
  if Assigned(Owner) then
    if (Owner is TProctree) then
      REsult := TProctree(owner).ConvertCurrent
    else if owner is TSalesLineProcTree then
      REsult := TSalesLineProcTree(owner).ConvertCurrent;
end;

//function TProcTreePart.GetTransDate: TDatetime;begin  result:= DateRequired;  if result = 0 then    result := TSalesLineProcTree(Owner).Sales.Saledatetime;end;
function TProcTreePart.GetClassID: Integer;begin  Result:= GetIntegerField('ClassId');end;
function TProcTreePart.GetCleanClassID: Integer;begin  result:= GetXMLNodeIntegerValue(CleanXMLNode, 'ClassId');end;
function TProcTreePart.GetcleanProductId: Integer;begin  result:= GetXMLNodeIntegerValue(CleanXMLNode, 'ProductId');end;
function TProcTreePart.GetDateRequired: TDateTime;begin  result:= GetDateTimeField('DateRequired');end;
function TProcTreePart.GetId: Integer;begin  result:= ProcTreePartId;end;
function TProcTreePart.GetProcTreeId: integer;begin  Result:= GetIntegerField('ProcTreeId');end;
function TProcTreePart.GetProcTreePartId: integer;begin  Result:= GetIntegerField('ProcTreePartId');end;
function TProcTreePart.GetQty: Double;begin  Result:= GetFloatField('Qty');end;
function TProcTreePart.GetSaleId: integer;begin  result:= GetIntegerField('SaleId');end;
function TProcTreePart.GetSaleLineId: integer;begin  result:= GetIntegerField('SaleLineId');end;
function TProcTreePart.GetSerialnos: String;begin  Result:= GetStringField('SerialNumbers');end;
function TProcTreePart.GetUnitOfMeasure: String;begin  Result:= GetStringField('UnitOfMeasure');end;
function TProcTreePart.GetUnitOfMeasureID: Integer;begin  Result:= GetIntegerField('UnitOfMeasureId');end;
function TProcTreePart.GetUOMMultiplier: Double;begin  Result:= GetFloatField('UnitOfMeasureMultiplier');end;
function TProcTreePart.GetUOMQty: Double;begin  Result:= GetFloatField('UOMQty');end;
function TProcTreePart.getMatrixDesc          : String; begin  Result := GetStringfield('MatrixDesc')           ;end;
function TProcTreePart.getMatrixPrice         : Double; begin  REsult := getFloatfield('MatrixPrice')           ;end;
function TProcTreePart.getMatrixRef           : String; begin  Result := GetStringfield('MatrixRef')            ;end;
function TprocTreePart.GetFromStockUOMQty	    : double; begin  result := getfloatField('FromStockUOMQty')       ;end;
function TprocTreePart.GetManufactureUOMQty	  : double; begin  result := getfloatField('ManufactureUOMQty')     ;end;
function TprocTreePart.GetManufacturedUOMQty	: double; begin  result := getfloatField('ManufacturedUOMQty')    ;end;
function TprocTreePart.GetManufacturingUOMQty	: double; begin  result := getfloatField('ManufacturingUOMQty')   ;end;
function TprocTreePart.GetOnOrderUOMQty	      : double; begin  result := getfloatField('OnOrderUOMQty')         ;end;
function TprocTreePart.GetFromStockQty	      : double; begin  result := getfloatField('FromStockQty')          ;end;
function TprocTreePart.GetManufactureQty	    : double; begin  result := getfloatField('ManufactureQty')        ;end;
function TprocTreePart.GetManufacturedQty	    : double; begin  result := getfloatField('ManufacturedQty')       ;end;
function TprocTreePart.GetManufacturingQty	  : double; begin  result := getfloatField('ManufacturingQty')      ;end;
function TprocTreePart.GetOnOrderQty	        : double; begin  result := getfloatField('OnOrderQty')            ;end;
function TProcTreePart.ValidateData: Boolean;begin  result:= inherited ValidateData;end;

//procedure TProcTreePart.SetUOMQtyOriginal(const Value: double);begin  SetFloatField('UOMQtyOriginal', Value);end;
//procedure TProcTreePart.SetUOMQtyUsed(const Value: double);begin  SetFloatField('UOMQtyUsed', Value);end;
procedure TProcTreePart.setClassID            (const Value: integer);begin  SetIntegerField('ClassId', Value);end;
procedure TProcTreePart.SetDateRequired       (const Value: TDateTime);begin  SetDateTimeField('DateRequired', Value);end;
procedure TProcTreePart.SetProcTreeId         (const Value: integer);begin  SetIntegerField('ProcTreeId', Value);end;
procedure TProcTreePart.SetProcTreePartId     (const Value: integer);begin  SetIntegerField('ProcTreePartId', Value);end;
procedure TProcTreePart.SetQty                (const Value: Double);begin  SetFloatField('Qty', Value);end;
procedure TProcTreePart.SetSaleId             (const Value: integer);begin  SetIntegerField('SaleId', Value);end;
procedure TProcTreePart.SetSaleLineId         (const Value: integer);begin  SetIntegerField('SaleLineId', Value);end;
procedure TProcTreePart.SetSerialNos          (const Value: String);begin  SetStringField('SerialNumbers', Value);end;
procedure TProcTreePart.SetTransDate          (const Value: TDatetime);begin  inherited;end;
procedure TProcTreePart.SetUnitOfMeasure      (const Value: String);begin  SetStringField('UnitOfMeasure', Value);end;
procedure TProcTreePart.SetUnitOfMeasureID    (const Value: Integer);begin  SetIntegerField('UnitOfMeasureId', Value);end;
procedure TProcTreePart.SetUOMMultiplier      (const Value: Double);begin  SetFloatField('UnitOfMeasureMultiplier', Value);end;
procedure TProcTreePart.SetUOMQty             (const Value: Double);begin  SetFloatField('UOMQty', Value);end;
procedure TProcTreePart.SetMatrixDesc         (const Value: String);begin SetStringField('MatrixDesc'        , Value);end;
procedure TProcTreePart.SetMatrixPrice        (const Value: Double);begin SetFloatfield('MatrixPrice'        , Value);end;
procedure TProcTreePart.SetMatrixRef          (const Value: String);begin SetStringField('MatrixRef'         , Value);end;
Procedure TprocTreePart.SetFromStockUOMQty    (const Value :double);begin SetFloatfield('FromStockUOMQty'    , Value);end;
Procedure TprocTreePart.SetManufactureUOMQty  (const Value :double);begin SetFloatfield('ManufactureUOMQty'  , Value);end;
Procedure TprocTreePart.SetManufacturedUOMQty (const Value :double);begin SetFloatfield('ManufacturedUOMQty' , Value);end;
Procedure TprocTreePart.SetManufacturingUOMQty(const Value :double);begin SetFloatfield('ManufacturingUOMQty', Value);end;
Procedure TprocTreePart.SetOnOrderUOMQty      (const Value :double);begin SetFloatfield('OnOrderUOMQty'      , Value);end;
Procedure TprocTreePart.SetFromStockQty       (const Value :double);begin SetFloatfield('FromStockQty'       , Value);end;
Procedure TprocTreePart.SetManufactureQty     (const Value :double);begin SetFloatfield('ManufactureQty'     , Value);end;
Procedure TprocTreePart.SetManufacturedQty    (const Value :double);begin SetFloatfield('ManufacturedQty'    , round(Value , RoundPlacesGeneral ));end;
Procedure TprocTreePart.SetManufacturingQty   (const Value :double);begin SetFloatfield('ManufacturingQty'   , round(Value , RoundPlacesGeneral ));end;
Procedure TprocTreePart.SetOnOrderQty         (const Value :double);begin SetFloatfield('OnOrderQty'         , Value);end;
procedure TProcTreePart.LoadFromXMLNode(const node: IXMLNode);begin  inherited;end;
function TProcTreePart.hasProgressbuild: Boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.connection.connection);
  try
    commondblib.closedb(qry);
    qry.sql.text := 'SELECT count(*) as ctr FROM tblprocprogress where ProcTreePartID = '+ IntToStr(Self.Id);
    commondblib.opendb(qry);
    result := Qry.fieldbyname('ctr').asInteger >0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TProcTreePart.getManufacturingProgress: TProcProgressOUT;
begin
  result := TProcProgressOUT(getContainerComponent(TProcProgressOUT, 'ProcTreePartID = '+ IntToStr(Self.Id)+ ' and ifnull(Alloctype,"") = '+QuotedStr('OUT')));
end;
function TProcTreePart.getManufacturedProgress: TProcProgressIn;
begin
  result := TProcProgressIn(getContainerComponent(TProcProgressIn, 'ProcTreePartID = '+ IntToStr(Self.Id)+ ' and ifnull(Alloctype,"") = '+QuotedStr('IN')));
end;

procedure TProcTreePart.Logit(ProductnameToLog:String ='');
var
  s:String;
begin
  if (ProductnameToLog = '') or (Sametext(ProductnameToLog , productname)) then begin
    s:= inttostr(ID) +#9 +ProductName +#9 +floatTostr(Qty) ;
    if IsPQAItem then
      s:= s +#9 +inttostr(PQA.ID) +#9 +PQA.ProductName +#9 +floatTostr(PQA.Qty) ;
  end;
end;

procedure TProcTreePart.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ProductID',ProductID);
  AddXMLNode(node,'ProductName',ProductName);
  AddXMLNode(node,'SerialNumbers',SerialNumbers);
  AddXMLNode(node,'Qty',Qty);
  AddXMLNode(node,'UOMQty',UOMQty);
  AddXMLNode(node,'UnitOfMeasure',UnitOfMeasure);
  AddXMLNode(node,'UOMMultiplier',UOMMultiplier);
  AddXMLNode(node,'UnitOfMeasureID',UnitOfMeasureID);
  AddXMLNode(node,'ProcTreePartId',ProcTreePartId);
  AddXMLNode(node,'ProcTreeId',ProcTreeId);
  AddXMLNode(node,'DateRequired',DateRequired);
  AddXMLNode(node,'SaleId',SaleId);
  AddXMLNode(node,'SaleLineId',SaleLineId);
//  AddXMLNode(node,'UOMQtyOriginal',UOMQtyOriginal);
//  AddXMLNode(node,'UOMQtyUsed',UOMQtyUsed);
  AddXMLNode(node,'ClassId',ClassId);
end;

function TProcTreePart.GetAccessManager: TDNMAccessManager;
begin
  result:= inherited GetAccessManager;
  if not Assigned(fAccessManager) then begin
    if Assigned(Owner) and (Owner is TBusObjNDS) then begin
      fAccessManager:= TDNMAccessManager.Create(Self);
      fAccessManager.AccessLevel:= TBusObjNDS(Owner).AccessLevel;
      result:= fAccessManager;
    end;
  end;
end;

function TProcTreePart.Getalloctype: String;
begin
  if Assigned(Owner) and (Owner is TProcTreeNode) then begin
    if TProcTreeNode(Owner).IsRoot then result:= 'IN'
    else result:= 'OUT';
  end else if Assigned(Owner) and (Owner is TProcTree) then begin
    if TProcTree(Owner).ParentId =0 then result:= 'IN'
    else result:= 'OUT';
  end  else
    raise Exception.Create('TProcTreePart.Getalloctype - unassigned or wrong owner type');
end;
function TProcTreePart.getBOMGroupedLine: Boolean;
begin
  REsult := GetbooleanField('BOMGroupedLine');
end;

function TProcTreePart.getBOMProductionLine: boolean;
begin
  Result := getbooleanfield('BOMProductionLine');
end;
function TProcTreePart.isRootNode:Boolean;
begin
  result:= False;
  if Assigned(Owner) and (Owner is TProcTreeNode) then begin
    if TProcTreeNode(Owner).IsRoot then REsult:= True;
  end else if Assigned(Owner) and (Owner is Tproctree) then begin
    result := Tproctree(Owner).parentId =0;
  end;
end;

function TProcTreePart.IsSerialNumberAllocated(aSerialnumber: String): boolean;
var
  Qry:TERPQuery;
begin
  REsult := False;
  if PQA.PQASN.Locate('Value' , aSerialnumber , [])  then begin
    REsult := True;
    Exit;
  end;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.connection);
  try
    qry.SQL.text :='SELECT SN.* ' +
                    ' FROM tblprocprogress  PP ' +
                    ' inner join tblpqa pqa on pqa.TRansLineID = pp.Procprogressid and ifnull(TransType,"") = "TProcProgressIn" ' +
                    ' inner join tblpqadetails sn on  sn.PQAType = "SN" AND sn.PQAID = pqa.pqaid and ifnull(sn.ParentRef,"") = "" ' +
                    ' WHERE pp.ProcTreePartID = ' + inttostr(ID)+' and ifnull(pp.Alloctype,"") = "IN" ' +
                    ' and SN.Value = '+ quotedstr(aSerialnumber);
    qry.open;
    if qry.recordcount >0 then begin
      result := True;
      Exit;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
  (*if ManufacturedProgress.count >0 then begin
    ManufacturedProgress.first;
    While ManufacturedProgress.Eof = False do begin
      if ManufacturedProgress.PQA.PQASN.Locate('Value' , aSerialnumber , [])  then begin
        REsult := TRue; logtext('6->'+ ManufacturedProgress.PQA.Productname +',' + aSerialnumber );
        Exit;
      end;
      ManufacturedProgress.next;
    end;
  end;*)
end;

function TProcTreePart.IsSubNodeParent: Boolean;
begin
  REsult := False;
  if Assigned(Owner) and (Owner is TProcTreeNode) then begin
    if TProcTreeNode(Owner).IsRoot then
    else result := (TProcTreeNode(Owner).Children.count >0) and (TProcTreeNode(Owner).ManufactureQty >0);
  end else if Assigned(Owner) and (Owner is TProcTree) then begin
    Result := TProcTree(Owner).children.count > 0;
  end  else
    raise Exception.Create('TProcTreePart.IsSubNodeParent - unassigned or wrong owner type');
end;


function TProcTreePart.GetIsPQAItem: Boolean;
begin
  if getContainerComponentifExists(TProduct)<> nil then result:= Commonlib.IsInvProduct(Product.ProductType)
  else if ProductID   <> 0  then result:= tcDataUtils.Is_Inv_Product(ProductID)
  else if ProductName <> '' then result:= tcDataUtils.Is_Inv_Product(ProductName)
  else result := False;

  if result then
    if Assigned(Self.Owner) then
      if self.owner is TSalesLineProcTree then
        result := TSalesLineProcTree(Self.Owner).Quantity <> 0;
  if result then
    if BOMGroupedLine then
      Result := False;
end;


function TProcTreePart.GetActive: boolean;
begin
  result:= GetBooleanField('Active');
end;

procedure TProcTreePart.SetActive(const Value: Boolean);
begin
//  if not Value then
//    PQA.Active:= false;
  SetBooleanField('Active', Value);
end;

procedure TProcTreePart.setBOMGroupedLine(const Value: Boolean);
begin
  SetBooleanfield('BOMGroupedLine' , Value);
end;

procedure TProcTreePart.setBOMProductionLine(const Value: boolean);
begin
  SetbooleanField('BOMProductionLine' , value);
end;

function TProcTreePart.GetProductID: Integer;
begin
  result:= GetIntegerField('ProductId');
end;

function TProcTreePart.GetProductName: String;
begin
  result:= GetStringField('ProductName');
end;

procedure TProcTreePart.SetProductID(const Value: Integer);
begin
  SetIntegerField('ProductId', Value);
end;

procedure TProcTreePart.SetProductName(const Value: String);
begin
  SetStringField('ProductName', Value);
end;

function TProcTreePart.GetBOQty: Double;
begin
  result:= 0;
end;
function TProcTreePart.GetBOUOMQty: Double;
begin
  result:= 0;
end;

procedure TProcTreePart.SetBOQty(const Value: Double);
begin

end;
procedure TProcTreePart.SetBOUOMQty(const Value: Double);
begin

end;

function TProcTreePart.GetEnableAllocation: Boolean;
begin
  { NOTE: This will prevent all batch, bin and serial no processing for items in
          the tree as this has not been implemented in manufacturing yet! }
  result:= false;
end;

function TProcTreePart.GetOrderQty: Double;
begin
  result:= self.Qty;
end;

function TProcTreePart.GetUOMOrderQty: Double;
begin
  result:= self.UOMqty;
end;

procedure TProcTreePart.SetOrderQty(const Value: Double);
begin
  self.Qty:= Value;
end;

procedure TProcTreePart.SetUOMOrderQty(const Value: Double);
begin
  self.UOMQty:= Value;
end;


function TProcTreePart.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

function TProcTreePart.DoAfterPost(Sender: TDatasetBusObj): Boolean;
var
    fPQA:TPQA;
    function Quantity:Double;
    begin
        if Qty <> 0 then Result := Qty
        else if BOQty <> 0 then Result := BOQty
        else Result := 0;
    end;
begin
    Result := inherited DoAfterPost(Sender);
    if (not (Result)) or (not(active)) or (ID = 0) then exit;{id is 0 if the record is filtered out}

    if not(IsPQAItem) then begin
        if SubNodeManufcaturePQAcount >0 then begin
          fPQA := SubNodeManufcaturePQA;
          if IsSubNodeParent then begin
            if fPQA.count = 0 then exit;//for a deleted record
            fPQA.delete;
          end;
        end;
(*        ManufacturedProgress.Delete;
        ManufacturingProgress.Delete;*)

        (*if ManufacturedPQAcount >0 then begin
          fPQA := ManufacturedPQA;
          //if IsSubNodeParent then begin
            if fPQA.count = 0 then exit;//for a deleted record
            fPQA.delete;
          //end;
        end;

        if ManufacturingPQAcount >0 then begin
          fPQA := ManufacturingPQA;
          //if IsSubNodeParent then begin
            if fPQA.count = 0 then exit;//for a deleted record
            fPQA.delete;
          //end;
        end;*)
        Exit;
    end;

    if IsRootnode then begin
      if not ConvertCurrent then begin
        if PQA.Qty <> ToBeManufacturedQty then begin
          PQA.DoFieldChange := False;
          try
            PQA.Qty := ToBeManufacturedQty;
            if PQA.uommultiplier  <> 0                    then PQA.UOMQty          := PQA.Qty/PQA.uommultiplier;
            PQA.PostDb;
          finally
            PQA.DoFieldChange := true;
          end;
        end;
      end else begin
        if PQA.Qty <> (qty - ManufacturedQty) then begin
          PQA.DoFieldChange := False;
          try
            PQA.Qty := qty - ManufacturedQty;
            if PQA.uommultiplier  <> 0                    then PQA.UOMQty          := PQA.Qty/PQA.uommultiplier;
            PQA.PostDb;
          finally
            PQA.DoFieldChange := true;
          end;
        end;
      end;
    end else begin
      if not ConvertCurrent then begin
        PQA.DoFieldChange := False;
        try
          if pqa.Qty <> ToBeManufacturingQty then pqa.qty := ToBeManufacturingQty;
          if PQA.uommultiplier  <> 0                    then PQA.UOMQty          := PQA.Qty/PQA.uommultiplier;
          pqa.postdb;
        finally
          PQA.DoFieldChange := true;
        end;
      end;

    fPQA := SubNodeManufcaturePQA;   {TProcTreePartIN-IN}
    if IsSubNodeParent then begin
      if fPQA.count = 0 then exit;//for a deleted record
      fPQA.DoFieldChange := False;
      try
          fPQA.alloctype         := 'IN';
          fPQA.transType         := Self.Classname+'IN';
          if fPQA.TransDate      <> TransDate            then fPQA.TransDate       := TransDate;
          if fPQA.DepartmentID   <> Classid              then fPQA.DepartmentID    := Classid;
          if fPQA.ProductID      <> ProductID            then fPQA.ProductID       := ProductID;
          if fPQA.ProductName    <> ProductName          then fPQA.ProductName     := ProductName;
          if fPQA.UnitOfMeasure  <> UnitOfMeasure        then fPQA.UnitOfMeasure   := UnitOfMeasure;
          if fPQA.UnitOfMeasureID<> UnitOfMeasureID      then fPQA.UnitOfMeasureID := UnitOfMeasureID;
          if fPQA.uommultiplier  <> UOMMultiplier        then fPQA.uommultiplier   := UOMMultiplier;
          if fPQA.Qty            <> ToBeManufacturedQty then fPQA.Qty              := ToBeManufacturedQty;//Quantity;
          if fPQA.uommultiplier  <> 0                    then fPQA.UOMQty          := fPQA.Qty/fPQA.uommultiplier;
          fPQA.IsBO := False;
          fPQA.PostDB;
      finally
          fPQA.DoFieldChange := true;
      end;
    end else begin
      if fPQA.count > 0 then begin
          fPQA.Qty := 0;
          fPQA.UOMQty := 0;
          fPQA.Active := false;
          fPQA.PostDB;
          fPQA.getnewDataset('delete from tblPQADetails where pqaID = ' + inttostr(fPQA.ID), true);
      end;
    end;
    end;

   (* {Don't delete as the wastage }
    if ManufacturedQty =0 then
      if ManufacturedProgress.count >0 then ManufacturedProgress.deleteall;

    if ManufacturingQty =0 then
      if ManufacturingProgress.count >0 then ManufacturingProgress.deleteall;*)


    (*fPQA := ManufacturedPQA;  {TProcTreePartINDONE-IN}
    if IsSubNodeParent or IsRootNode then begin
      if fPQA.count = 0 then exit;//for a deleted record
      fPQA.DoFieldChange := False;
      try
          fPQA.alloctype         := 'IN';
          fPQA.transType         := Self.Classname+'INDONE';
          if fPQA.TransDate      <> TransDate         then fPQA.TransDate       := TransDate;
          if fPQA.DepartmentID   <> Classid           then fPQA.DepartmentID    := Classid;
          if fPQA.ProductID      <> ProductID         then fPQA.ProductID       := ProductID;
          if fPQA.ProductName    <> ProductName       then fPQA.ProductName     := ProductName;
          if fPQA.UnitOfMeasure  <> UnitOfMeasure     then fPQA.UnitOfMeasure   := UnitOfMeasure;
          if fPQA.UnitOfMeasureID<> UnitOfMeasureID   then fPQA.UnitOfMeasureID := UnitOfMeasureID;
          if fPQA.uommultiplier  <> UOMMultiplier     then fPQA.uommultiplier   := UOMMultiplier;
          if fPQA.Qty            <> ManufacturedQty   then fPQA.Qty             := ManufacturedQty;//Quantity;
          if fPQA.uommultiplier  <> 0                 then fPQA.UOMQty          := fPQA.Qty/fPQA.uommultiplier;
          fPQA.IsBO := False;
          fPQA.PostDB;
      finally
          fPQA.DoFieldChange := true;
      end;
    end else begin
      if fPQA.count > 0 then begin
          fPQA.Qty := 0;
          fPQA.UOMQty := 0;
          fPQA.Active := false;
          fPQA.PostDB;
          fPQA.getnewDataset('delete from tblPQADetails where pqaID = ' + inttostr(fPQA.ID), true);
      end;
    end;

    fPQA := ManufacturingPQA;  {TProcTreePartOUTDONE-OUT}
    if not(IsRootNode) then begin
      if fPQA.count = 0 then exit;//for a deleted record
      fPQA.DoFieldChange := False;
      try
          fPQA.alloctype         := 'OUT';
          fPQA.transType         := Self.Classname+'OUTDONE';
          if fPQA.TransDate      <> TransDate         then fPQA.TransDate       := TransDate;
          if fPQA.DepartmentID   <> Classid           then fPQA.DepartmentID    := Classid;
          if fPQA.ProductID      <> ProductID         then fPQA.ProductID       := ProductID;
          if fPQA.ProductName    <> ProductName       then fPQA.ProductName     := ProductName;
          if fPQA.UnitOfMeasure  <> UnitOfMeasure     then fPQA.UnitOfMeasure   := UnitOfMeasure;
          if fPQA.UnitOfMeasureID<> UnitOfMeasureID   then fPQA.UnitOfMeasureID := UnitOfMeasureID;
          if fPQA.uommultiplier  <> UOMMultiplier     then fPQA.uommultiplier   := UOMMultiplier;
          if fPQA.Qty            <> ManufacturingQty  then fPQA.Qty             := ManufacturingQty;//Quantity;
          if fPQA.uommultiplier  <> 0                 then fPQA.UOMQty          := fPQA.Qty/fPQA.uommultiplier;
          fPQA.IsBO := False;
          fPQA.PostDB;
      finally
          fPQA.DoFieldChange := true;
      end;
    end else begin
      if fPQA.count > 0 then begin
          fPQA.Qty := 0;
          fPQA.UOMQty := 0;
          fPQA.Active := false;
          fPQA.PostDB;
          fPQA.getnewDataset('delete from tblPQADetails where pqaID = ' + inttostr(fPQA.ID), true);
      end;
    end;*)

end;
function TProcTreePart.SubNodeManufcaturePQAcount: Integer;
var
  PQAobj:TComponent;
begin
  REsult :=0;
  if Id = 0 then exit;
  PQAobj:= getContainerComponent(TSubNodeManufcaturePQA, 'TRansLineID = '+ IntToStr(Self.Id)+ ' and ifnull(TransType,"") = '+QuotedStr(Self.Classname+'IN'));
  if PQAobj = nil then exit;
  result := TSubNodeManufcaturePQA(PQAobj).count;
end;

(*function TProcTreePart.ManufacturedPQAcount: Integer;
var
  PQAobj:TComponent;
begin
  REsult :=0;
  if Id = 0 then exit;
  PQAobj:= getContainerComponent(TPQA, 'TRansLineID = '+ IntToStr(Self.Id)+ ' and ifnull(TransType,"") = '+QuotedStr(Self.Classname+'INDONE'));
  if PQAobj = nil then exit;
  result := TPQA(PQAobj).count;
end;

function TProcTreePart.ManufacturingPQAcount: Integer;
var
  PQAobj:TComponent;
begin
  REsult :=0;
  if Id = 0 then exit;
  PQAobj:= getContainerComponent(TPQA, 'TRansLineID = '+ IntToStr(Self.Id)+ ' and ifnull(TransType,"") = '+QuotedStr(Self.Classname+'OUTDONE'));
  if PQAobj = nil then exit;
  result := TPQA(PQAobj).count;
end;*)


procedure TProcTreePart.MoveAllocation(fdQuantity: Double; ToPQA: TPQA);
var
//  fdQty :Double;
  fromPQA: TPQA;
  Qry :TERPQuery;
begin
  if fdQuantity <=0 then exit;

  {check in its own progress builds for IN Qty}
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection.Connection);
  try
    qry.SQL.text := 'SELECT * FROM tblprocprogress WHERE proctreepartid = ' + inttostr(ID)+' AND alloctype ="IN"';
    qry.open;
    if qry.recordcount >0 then begin
      qry.First;
      While (qry.EOF = False) and (fdQuantity>0) do begin
        fromPQA := TPQA.Create((*Self*)nil); //dont owned by self - to use diff dataset
        try
            fromPQA.connection := self.connection;
            fromPQA.LoadSelect('TRansLineID = '+ IntToStr(qry.fieldbyname('Procprogressid').asInteger)+ ' and ifnull(TransType,"") = "TProcProgressIn"') ;
            if (frompqa.count =0 ) or (TOPQA.count =0 ) then else
                   if fromPQA.Product.Batch         then fdQuantity:= fromPQA.PQABAtch.MoveAllocation(fdQuantity , ToPQA.PQAbatch , fromPQA.Product.Batch , fromPQA.Product.Multiplebins ,fromPQA.Product.SNTracking,true)
              else if fromPQA.Product.Multiplebins  then fdQuantity:= fromPQA.PQABins.MoveAllocation (fdQuantity , ToPQA.PQABins  , fromPQA.Product.Batch , fromPQA.Product.Multiplebins ,fromPQA.Product.SNTracking,true)
              else if fromPQA.Product.SNTracking    then fdQuantity:= fromPQA.PQASN.MoveAllocation   (fdQuantity , ToPQA.PQASN    , fromPQA.Product.Batch , fromPQA.Product.Multiplebins ,fromPQA.Product.SNTracking,true);
        Finally
            Freeandnil(FromPQA);
        end;
        qry.next;
      end;
    end;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;

  if fdQuantity <=0 then exit;
  fromPQA := TPQA.Create((*Self*)nil); //dont owned by self - to use diff dataset
  try
    fromPQA.connection := self.connection;
    fromPQA.LoadSelect('TRansLineID = '+ IntToStr(Self.Id)+ ' and ifnull(TransType,"") = '+QuotedStr(Self.Classname)) ;

    if (frompqa.count =0 ) or (TOPQA.count =0 ) then exit;
         if fromPQA.Product.Batch         then fdQuantity:= fromPQA.PQABAtch.MoveAllocation(fdQuantity , ToPQA.PQAbatch , fromPQA.Product.Batch , fromPQA.Product.Multiplebins ,fromPQA.Product.SNTracking)
    else if fromPQA.Product.Multiplebins  then fdQuantity:= fromPQA.PQABins.MoveAllocation (fdQuantity , ToPQA.PQABins  , fromPQA.Product.Batch , fromPQA.Product.Multiplebins ,fromPQA.Product.SNTracking)
    else if fromPQA.Product.SNTracking    then fdQuantity:= fromPQA.PQASN.MoveAllocation   (fdQuantity , ToPQA.PQASN    , fromPQA.Product.Batch , fromPQA.Product.Multiplebins ,fromPQA.Product.SNTracking);
  Finally
    Freeandnil(FromPQA);
  end;


(*  if frompqa.Product.batch then begin

    fdQty := fdQuantity;
    frompqa.PQABatch.First;
    While (fdQty >0) and (frompqa.PQABatch.EOF =False) do begin
      if (frompqa.PQABatch.Qty >0) then begin
        if TOPQa.PQABatch.Locate('Value' , frompqa.PQABatch.Batchno, []) = false then begin
          ToPQA.PQABatch.New;
          ToPQA.PQABatch.Batchno     := FromPQA.PQABatch.BatchNo;
          ToPQA.PQABatch.ExpiryDate  := FromPQA.PQABatch.ExpiryDate;
          ToPQA.PQABatch.truckloadno := FromPQA.PQABatch.truckloadno;
        end;
        if FromPQA.PQABatch.Qty > fdQty then begin
          ToPQA.PQABatch.Qty := ToPQA.PQABatch.Qty + fdQty;
        end;
      end;

    end;
  end;*)


end;

function TProcTreePart.getSubNodeManufcaturePQA: TSubNodeManufcaturePQA;
var
  s:String;
begin
    Self.PostDB;
    s:='TransLineID = '+ IntToStr(Self.Id)+ ' and ifnull(TransType,"") = '+QuotedStr(Self.Classname+'IN') ;
    Result := TSubNodeManufcaturePQA(getContainerComponent(TSubNodeManufcaturePQA, s));
    if pos(s , Result.Sql ) =0 then begin
      clog(s);
      logText(Result.Sql);
    end;
    if (ID<> 0) and (Result.count = 0) and (ISPQAItem) and IsSubNodeParent then begin
        Result.New;
    end;
end;

function TProcTreePart.getToBeManufacturedQty  :Double;begin  Result := ManufactureQty -ManufacturedQty;end;
function TProcTreePart.getToBeManufacturingQty :Double;begin  Result := round(Qty -ManufacturingQty , RoundPlacesGeneral);end;

(*function TProcTreePart.getManufacturedPQA: TPQA;
var
  s:String;
begin
    Self.PostDB;
    s:='TRansLineID = '+ IntToStr(Self.Id)+ ' and ifnull(TransType,"") = '+QuotedStr(Self.Classname+'INDONE') ;
    Result := TPQA(getContainerComponent(TPQA, s));
    if (ID<> 0) and (Result.count = 0) and (ISPQAItem) and (IsSubNodeParent or IsRootnode) then begin
        Result.New;
    end;
end;
function TProcTreePart.getManufacturingPQA: TPQA;
var
  s:String;
begin
    Self.PostDB;
    s:='TRansLineID = '+ IntToStr(Self.Id)+ ' and ifnull(TransType,"") = '+QuotedStr(Self.Classname+'OUTDONE') ;
    Result := TPQA(getContainerComponent(TPQA, s));
    if (ID<> 0) and (Result.count = 0) and (ISPQAItem) and (not(IsRootnode)) then begin
        Result.New;
    end;
end;*)

function TProcTreePart.DoBeforeDelete(Sender: TDatasetBusObj): Boolean;
var
  fPQA:TPQA;
begin
  if IsPQAItem then begin
    if SubNodeManufcaturePQAcount >0 then begin
      fPQA := SubNodeManufcaturePQA;
      if IsSubNodeParent then begin
        if fPQA.count = 0 then exit;//for a deleted record
        fPQA.delete;
      end;
    end;
    with ManufacturedProgress  do if count > 0 then deleteall;
    with ManufacturingProgress do if count > 0 then deleteall;

    (*if ManufacturedPQAcount >0 then begin
      fPQA := ManufacturedPQA;
      if IsSubNodeParent or isRootnode then begin
        if fPQA.count = 0 then exit;//for a deleted record
        fPQA.delete;
      end;
    end;

    if ManufacturingPQAcount >0 then begin
      fPQA := ManufacturingPQA;
      //if IsSubNodeParent or isRootnode then begin
        if fPQA.count = 0 then exit;//for a deleted record
        fPQA.delete;
      //end;
    end;*)
  end;
    Result := inherited DoBeforeDelete(Sender);
    if not Result then exit;

end;

function TProcTreePart.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoBeforePost(Sender);
  if not result then exit;
end;

function TProcTreePart.ExportsubClasses(const node: IXMLNode): Boolean;
var
  fPQA:TPQA;
begin
    Result := inherited ExportsubClasses(node);
    if not Result then exit;
    if not IsPQAItem then exit;
    fPQA := SubNodeManufcaturePQA;
    if IsSubNodeParent then begin
      if fPQA.count > 0 then begin
          fPQA.XMLPropertyNode := node.AddChild(TPQA.XMLBranchName);
          fPQA.XMLPropertyName := TPQA.XMLNodeName;
          fPQA.IterateRecords(GetPropertyXMLCallback);
      End;

    end;

    (*fPQA := ManufacturedPQA;
    if IsSubNodeParent or isrootnode then begin
      if fPQA.count > 0 then begin
          fPQA.XMLPropertyNode := node.AddChild(TPQA.XMLBranchName);
          fPQA.XMLPropertyName := TPQA.XMLNodeName;
          fPQA.IterateRecords(GetPropertyXMLCallback);
      End;

    end;

    fPQA := ManufacturingPQA;
    if IsSubNodeParent or isrootnode then begin
      if fPQA.count > 0 then begin
          fPQA.XMLPropertyNode := node.AddChild(TPQA.XMLBranchName);
          fPQA.XMLPropertyName := TPQA.XMLNodeName;
          fPQA.IterateRecords(GetPropertyXMLCallback);
      End;

    end;*)

end;

function TProcTreePart.GetProductType: string;
begin
    Result := GetStringField('PartType');
end;

procedure TProcTreePart.SetProductType(const Value: string);
begin
  inherited;
  SetStringField('PartType', Value);
end;

{ TProcTreePartClean }

constructor TProcTreePartClean.Create(AOwner: TComponent);
begin
  inherited;
  fSQL:= 'SELECT * FROM tblProcTreePartClean';
  fBusObjectTypeDescription:= 'Process Tree Product Object';
  LogChangesOnSave := False;
end;

function TProcTreePartClean.GetIsPQAItem: Boolean;
begin
  Result := False;
end;

end.
