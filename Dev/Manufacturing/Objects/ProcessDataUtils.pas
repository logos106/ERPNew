unit ProcessDataUtils;

interface

uses
 BusObjBase, BusObjSales, {wwDbGrid,} BusObjStock, BusObjProcess, ConTnrs, IntegerListObj,
  Classes,ProcessUtils,MyAccess,ERPdbComponents;


  function TreeRootIdForProductTemplate(const ProductId: integer; Connection: TERPConnection = nil): integer; overload;
  function TreeRootIdForProductTemplate(const ProductName: string; Connection: TERPConnection = nil): integer; overload;
  function TreeRootIdForSaleLineId(const SaleLineId: integer; Connection: TERPConnection = nil): integer;

  function ProcessTimeAllocatedForDate(const ProcessStepId: integer;
                                        const ProcResourceId: integer;
                                        const aDate: TDateTime;
                                        Connection: TERPConnection = nil): double;

  function ProcessTimeAllocatedForDatenDetail(const ProcessStepId: integer;
                                        const ProcResourceId: integer;
                                        const ProcResourceDetailId: integer;
                                        const aDate: TDateTime;
                                        Connection: TERPConnection = nil): double;
  Function ProcessResourceAvailable(const ProcResourceId: integer;Connection: TERPConnection = nil):Boolean;
(*  function ResourceProcessCapacityForDate(const ProcResourceId: integer;
                               const aDate: TDateTime;
                               Var StartAt:TTime;
                               ProcessStepId: integer = 0;
                               Connection: TERPConnection = nil): double;*)
  procedure UpdateTreeProductsCostAndPrice(TreeNode: TProcTreeNode);

//  function CreateSmartOrder(List: TObjectList; var msg: string): boolean;

  procedure BuildProductionRequirementsList(const aTableName: string; const ProcessStepId: integer = 0; ProcTreeIds:String='');
  function ProcessPartStatusToUserStr(const ProcessPartStatus: TProcessPartStatus): string;
  procedure BuildProductionJobList(Const aTableName: string; Const Incomplete, Complete: boolean; Const DateFrom, DateTo: TDateTime);

  { Returns true if any node in tree is a custom input type }
  function ProcTreeIsCustom(Tree: TProcTreeNode): boolean;

  { Returns true if any node in tree has process steps }
  function ProcTreeHasProcesses(Tree: TProcTreeNode): boolean;

  { Returns true if node or any sub node is a product }
  function ProductNodeHasProducts(Node: TProcTreeNode): boolean;

  { Scan through tree and return true if there are any nodes that are inventory
    parts but do not have associated process steps (above them).
    msg will contain captions of nodes without associated processes.  }
  function ProcTreePartsWithoutProcess(Tree: TProcTreeNode; var list: string): boolean;
  function HasProcessSteps(Tree: TProcTreeNode):Boolean;

  {  Scan through tree and return true if there are any option nodes that do not
     have default values (ie selected child).
     list contains captions of nodes without defauls.  }
  function ProcTreeOptionsWithotDefaults(Tree: TProcTreeNode; var list: string): boolean;

  {  Scan through tree and return true if there are any option nodes }
  function ProcTreeHasOptions(Node: TProcTreeNode): boolean;
  function ProcTreeHasCustoms(Node: TProcTreeNode): boolean;

    {  Scan through tree and return true if there are any nodes with processes
     and a quantity of zero.
     list contains captions of nodes without quantity.  }
  function ProcTreeProcessesWithotQuantity(ParentNode, Tree: TProcTreeNode; var list: string): boolean;

  procedure PopulateProductionWorkSheetTable(var TempTableName: string;
                                           ProcessStepIdList: TIntegerList;
                                           aDateFrom, aDateTo: TDateTime;
                                           SaleLineIDList: TIntegerList;
                                           const SubTreeOnly: boolean = true; includeallocation :Boolean =False; IncludeUnScheduled:Boolean = False);

  { Returns true if this ProcessStepId is linked to a ProcTree that is not Complete }
  function ProcessStepInUse(aProcessStepId: integer): boolean;

  function ProductionSchedOrStarted(Tree: TProcTreeNode): boolean;

  function TreeHasAddToSaleNodes(Tree: TProcTreeNode): boolean;
  procedure ClearAllAddToSale(Tree: TProcTreeNode);
  procedure SetTreeDateRequired(Tree: TProcTreeNode; aDateRequired: TDateTime);

  function DoTreeAccountPosting(Tree: TProcTreeNode; Conn: TCustomMyConnection; var msg: string; Description: string  ; PostingDate:TDateTime = 0): boolean;

  function DoJobComplete(ConfirmQtysOnfinaliseProc: TBusObjProc; SOList: TIntegerList; ConvertIncomplete: boolean; var msg: string): boolean;
  function DoconvertSO(SOList: TIntegerList): boolean;
  Function ConvertSo(SO:TSalesOrder):Integer;
  function SaleContainsManufacturing(const aSaleId: integer; Conn: TCustomMyConnection): boolean;
  function DoCompletenconvert(ConfirmQtysOnfinaliseProc: TBusObjProc; SO:TSalesORder;CompleteConverted:Boolean;msg: TStringList;var invID:Integer; ConvertIncomplete: boolean = false; ConvertCurrent:Boolean = False):Boolean;
  function CompleteAndConvertOrders(ConfirmQtysOnfinaliseProc : TBusObjProc; SOList: TIntegerList; Conn: TERPConnection; var msgStr: string; ConvertIncomplete: boolean = false; ConvertCurrent:Boolean = False): boolean;

implementation

uses
  {BaseListingForm,} CommonLib, Controls, {Forms,} CommonDbLib,
   SysUtils, BusObjProcPrefs,

  //BusObjProcPartSched,
  BusObjPublicHolidays, MySQLConst, tcConst,
  ProgressDialog, ProductQtyLib,
  BusObjAccountPosting,
  AppEnvironment, TypInfo, Dialogs, Math,  StoredProcedures, ManufactureLib, dateutils,Forms(*,
  LogLib*), LogLib, DbSharedObjectsObj, BusobjProctree, SystemLib;


function TreeRootIdForProductTemplate(const ProductId: integer; Connection: TERPConnection = nil): integer;
var
  qry: TERPQuery;
begin
  result:= 0;
  if Connection = nil then Connection := CommonDbLib.GetSharedMyDacConnection;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
  try
    qry.SQL.Text:=
      'SELECT `TreeRootId` FROM `tblProcTree` WHERE Mastertype ="mtProduct" AND ' +
      '`ParentId` = 0 AND ' +
      '`MasterID` = ' +IntToStr(ProductId);
    qry.Open;
    if qry.RecordCount > 0 then
      result:= qry.Fields[0].AsInteger;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TreeRootIdForProductTemplate(const ProductName: string; Connection: TERPConnection = nil): integer;
var
  qry: TERPQuery;
begin
  result:= 0;
  if Connection = nil then Connection := CommonDbLib.GetSharedMyDacConnection;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Connection);
  try
    qry.SQL.Text:=
      'SELECT `TreeRootId` FROM `tblProcTree` PT '+
      ' inner join `tblParts` P on  PT.MasterID = P.`PartsId`  AND P.`PartName` = ' + QuotedStr(ProductName) +
      ' WHERE ifnull(PT.parentId,0)=0 '+
      ' AND  PT.mastertype = "mtProduct" ';
    qry.Open;
    if qry.RecordCount > 0 then
      result:= qry.Fields[0].AsInteger;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

function TreeRootIdForSaleLineId(const SaleLineId: integer; Connection: TERPConnection = nil): integer;
var
  qry: TERPQuery;
begin
  result:= 0;
  qry:= TERPQuery.Create(nil);
  if Assigned(Connection) then
    qry.Connection:= Connection
  else
    qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Text:=
      (*'SELECT `TreeRootId` FROM `tblProcTree` WHERE `IsTemplate` = "F" AND ' +
      '`SaleLineId` = ' +IntToStr(SaleLineId);*)
      'SELECT `TreeRootId` FROM `tblProcTree` WHERE Mastertype <> "mtProduct" AND ifnull(ParentID,0)=0' +
      ' and `MasterID` = ' +IntToStr(SaleLineId);
    qry.Open;
    if qry.RecordCount > 0 then
      result:= qry.Fields[0].AsInteger;
  finally
    FreeAndNil(qry);
  end;
end;


//function ProcessTimeAllocatedForDate(const ProcessStepId: integer;
//                                     const ProcResourceId: integer;
//                                     const aDate: TDateTime): double;
//var
//  qry: TERPQuery;
//begin
//  result:= 0;
//  qry:= CommonDbLib.TempMyQuery;
//  try
//    if ProcResourceId > 1 then begin
//      { we know the resource }
//      qry.SQL.Text:=
//        'SELECT PP.Duration, PP.SetupDuration, PP.BreakdownDuration,'+
//        ' PT.TotalQty' +
//        ' FROM tblProcessPart PP, tblProcTree PT, tblProcResourceProcess RP' +
//        ' WHERE PP.ProcTreeId = PT.ProcTreeId' +
//        ' AND PP.ProcessStepId = RP.ProcessStepId' +
//        ' AND PT.MasterType = "mtSalesOrder"' +
//        ' AND PP.IsTemplate = "F"' +
//        ' AND PP.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) +
//        ' AND PP.TimeStart < ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate + 1)) +
//        ' AND RP.ProcResourceId = ' +IntToStr(ProcResourceId);
//      if ProcessStepId > 0 then
//        qry.SQL.Add(' AND PP.ProcessStepId = ' +IntToStr(ProcessStepId));
//    end
//    else begin
//      qry.SQL.Text:=
//        'SELECT PP.Duration, PP.SetupDuration, PP.BreakdownDuration,'+
//        ' PT.Quantity' +
//        ' FROM tblProcessPart PP, tblProcTree PT' +
//        ' WHERE PP.ProcTreeId = PT.ProcTreeId' +
//        ' AND PT.MasterType = "mtSalesOrder"' +
//        ' AND PP.IsTemplate = "F"' +
//        ' AND PP.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) +
//        ' AND PP.TimeStart < ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate + 1));
//
//      if ProcessStepId > 0 then
//        qry.SQL.Add(' AND PP.ProcessStepId = ' +IntToStr(ProcessStepId));
//    end;
//    qry.Open;
//    while not qry.Eof do begin
//      result:=
//        result + (qry.Fields[0].AsFloat + qry.Fields[1].AsFloat + qry.Fields[2].AsFloat) *
//          (qry.Fields[3].AsFloat);
//      qry.Next;
//    end;
//  finally
//    FreeAndNil(qry);
//  end;
//end;

function ProcessTimeAllocatedForDatenDetail(const ProcessStepId: integer;
                                     const ProcResourceId: integer;
                                     const ProcResourceDetailId: integer;
                                     const aDate: TDateTime;
                                     Connection: TERPConnection = nil): double;
var
  qry: TERPQuery;
begin
  result:= 0;
  if Assigned(Connection) then begin
    qry:= TERPQuery.Create(nil);
    qry.Connection:= Connection;
  end
  else
    qry:= CommonDbLib.TempMyQuery;
  try

    qry.SQL.Text:=
        'SELECT SUM(PPT.Duration)'+
        ' FROM tblProcessTime PPT, tblProcessPart PP, tblProcTree PT, tblProcResourceProcess RP' +
        ' WHERE PPT.ProcessPartId = PP.ID' +
        ' AND PP.ProcTreeId = PT.ProcTreeId' +
        ' AND PP.ProcessStepId = RP.ProcessStepId' +
        ' AND PT.MasterType = "mtSalesOrder"' +
        ' AND PP.IsTemplate = "F"' +
        ' AND PPT.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) +
        ' AND PPT.TimeStart < ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate + 1)) ;
      if ProcResourceId       > 0 then qry.SQL.Add(' AND RP.ProcResourceId    = ' +IntToStr(ProcResourceId));
      if ProcessStepId        > 0 then qry.SQL.Add(' AND PP.ProcessStepId     = ' +IntToStr(ProcessStepId));
      if ProcResourceDetailId > 0 then qry.SQL.Add(' AND PPT.ResourcedetailsID= ' +IntToStr(ProcResourceDetailId));


    (*if ProcResourceId > 0 then begin
      { we know the resource }
      qry.SQL.Text:=
        'SELECT SUM(PPT.Duration)'+
        ' FROM tblProcessTime PPT, tblProcessPart PP, tblProcTree PT, tblProcResourceProcess RP' +
        ' WHERE PPT.ProcessPartId = PP.ID' +
        ' AND PP.ProcTreeId = PT.ProcTreeId' +
        ' AND PP.ProcessStepId = RP.ProcessStepId' +
        ' AND PT.MasterType = "mtSalesOrder"' +
        ' AND PP.IsTemplate = "F"' +
        ' AND PPT.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) +
        ' AND PPT.TimeStart < ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate + 1)) +
        ' AND RP.ProcResourceId = ' +IntToStr(ProcResourceId);
      if ProcessStepId > 0 then
        qry.SQL.Add(' AND PP.ProcessStepId = ' +IntToStr(ProcessStepId));
      if ProcResourceDetailId > 0 then
        qry.SQL.Add(' AND PPT.ResourcedetailsID = ' +IntToStr(ProcResourceDetailId));

    end else begin
      qry.SQL.Text:=
        'SELECT SUM(PPT.Duration)'+
        ' FROM tblProcessTime PPT, tblProcessPart PP, tblProcTree PT, tblProcResourceProcess RP' +
        ' WHERE PPT.ProcessPartId = PP.ID' +
        ' AND PP.ProcTreeId = PT.ProcTreeId' +
        ' AND PP.ProcessStepId = RP.ProcessStepId' +
        ' AND PT.MasterType = "mtSalesOrder"' +
        ' AND PP.IsTemplate = "F"' +
        ' AND PPT.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) +
        ' AND PPT.TimeStart < ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate + 1));

      if ProcessStepId > 0 then
        qry.SQL.Add(' AND PP.ProcessStepId = ' +IntToStr(ProcessStepId));

      if ProcResourceDetailId > 0 then
        qry.SQL.Add(' AND PPT.ResourcedetailsID = ' +IntToStr(ProcResourceDetailId));

    end;*)
    qry.Open;
    if qry.RecordCount > 0 then
      result:= qry.Fields[0].AsFloat;
  finally
    FreeAndNil(qry);
  end;
end;

function ProcessTimeAllocatedForDate(const ProcessStepId: integer;
                                     const ProcResourceId: integer;
                                     const aDate: TDateTime;
                                     Connection: TERPConnection = nil): double;
var
  qry: TERPQuery;
begin
  result:= 0;
  if Assigned(Connection) then begin
    qry:= TERPQuery.Create(nil);
    qry.Connection:= Connection;
  end
  else
    qry:= CommonDbLib.TempMyQuery;
  try
    if ProcResourceId > 0 then begin
      { we know the resource }
      qry.SQL.Text:=
        'SELECT SUM(PPT.Duration)'+
        ' FROM tblProcessTime PPT, tblProcessPart PP, tblProcTree PT, tblProcResourceProcess RP' +
        ' WHERE PPT.ProcessPartId = PP.ID' +
        ' AND PP.ProcTreeId = PT.ProcTreeId' +
        ' AND PP.ProcessStepId = RP.ProcessStepId' +
        ' AND PT.MasterType = "mtSalesOrder"' +
        ' AND PP.IsTemplate = "F"' +
        ' AND PPT.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) +
        ' AND PPT.TimeStart < ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate + 1)) +
        ' AND RP.ProcResourceId = ' +IntToStr(ProcResourceId);
      if ProcessStepId > 0 then
        qry.SQL.Add(' AND PP.ProcessStepId = ' +IntToStr(ProcessStepId));
    end
    else begin
      qry.SQL.Text:=
        'SELECT SUM(PPT.Duration)'+
        ' FROM tblProcessTime PPT, tblProcessPart PP, tblProcTree PT, tblProcResourceProcess RP' +
        ' WHERE PPT.ProcessPartId = PP.ID' +
        ' AND PP.ProcTreeId = PT.ProcTreeId' +
        ' AND PP.ProcessStepId = RP.ProcessStepId' +
        ' AND PT.MasterType = "mtSalesOrder"' +
        ' AND PP.IsTemplate = "F"' +
        ' AND PPT.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) +
        ' AND PPT.TimeStart < ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate + 1));

      if ProcessStepId > 0 then
        qry.SQL.Add(' AND PP.ProcessStepId = ' +IntToStr(ProcessStepId));
    end;
    qry.Open;
    if qry.RecordCount > 0 then
      result:= qry.Fields[0].AsFloat;
  finally
    FreeAndNil(qry);
  end;
end;

Function ProcessResourceAvailable(const ProcResourceId: integer;Connection: TERPConnection = nil):Boolean;
var
  qry: TERPQuery;
begin
  qry:=CommonDbLib.TempMyQuery(Connection);
  try
(*    qry.SQL.Text:='Select ResourceAvailable from ' +
                    iif(Appenv.companyPRefs.AutoScheduleBasedonBOMEmpRoster , 'tblprocresourcedetails' ,  ' tblProcResource ') +
                    ' where ProcResourceId = ' +IntToStr(ProcResourceId)+' and ResourceAvailable ="T"';*)
  if Appenv.companyPRefs.AutoScheduleBasedonBOMEmpRoster  then begin
      qry.SQL.Text:='Select PRD.ResourceAvailable  ' +
                    ' from tblProcResource PR inner join tblprocresourcedetails PRD on PR.ProcResourceId = PRD.ProcResourceId' +
                    ' where PR.UsedWithProductsInSeq ="F" AND PRD.ProcResourceId = ' + IntToStr(ProcResourceId)+' AND PRD.ResourceAvailable ="T"';
  end else begin
      qry.SQL.Text:='Select PR.ResourceAvailable ' +
                     ' from tblProcResource PR ' +
                    ' where PR.UsedWithProductsInSeq ="F" AND PR.ProcResourceId = '  + IntToStr(ProcResourceId)+' AND PR.ResourceAvailable ="T"';
  end;

    qry.Open;
    Result :=qry.Recordcount>0;
  finally
    FreeAndNil(qry);
  end;
end;
(*function ResourceProcessCapacityForDate(const ProcResourceId: integer;
                               const aDate: TDateTime;
                               Var StartAt:TTime;
                               ProcessStepId: integer = 0;
                               Connection: TERPConnection = nil): double;
var
  qry: TERPQuery;
begin

  Result:= 0;

  if not(IsWorkingday( aDate)) then begin
    exit;
  end;

  if Assigned(Connection) then begin
    qry:= TERPQuery.Create(nil);
    qry.Connection:= Connection;
  end
  else
    qry:= CommonDbLib.TempMyQuery;
  try
    if ProcPrefs.ResourceNotAvailableForHolidays then begin
      { is this date a holiday }
      qry.SQL.Text:= 'SELECT `Day` FROM `tblPublicHolidays` WHERE `Day` = ' +
        QuotedStr(FormatDateTime(MysqlDateFormat,aDate));
      qry.Open;
      if qry.RecordCount > 0 then
        exit { its a holiday }
      else
        qry.Close;
    end;

    {check for the days} {*AutoScheduleBasedonBOMEmpRoster*1}
    qry.SQL.Text:='Select ' +
                ' if(DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=1 and sunday="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=2 and Monday="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=3 and Tuesday="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=4 and Wednesday="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=5 and Thursday="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=6 and Friday="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=7 and Saturday="F" , "F" ,"T"))))))) Availability ' +
                ' from tblprocresourcedays PRD where PRD.ProcResourceID = ' +inttostr(ProcResourceId);
     qry.Open;
      if qry.RecordCount = 0 then
        exit
      else if Qry.fieldbyname('Availability').asString = 'F' then
        Exit
      else Qry.close;
      {*AutoScheduleBasedonBOMEmpRoster*1}

    {*AutoScheduleBasedonBOMEmpRoster*2}
    qry.SQL.Text:=
      'SELECT ' +
      '/*PR.CapacityHoursDay,*/'+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =1 and PRD.Sunday   = "T" , PRD.SundayCapacityHoursDay , '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =2 and PRD.Monday   = "T" , PRD.MondayCapacityHoursDay ,  '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =3 and PRD.TuesDay  = "T" , PRD.TuesdayCapacityHoursDay ,  '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =4 and PRD.Wednesday= "T" , PRD.WednesdayCapacityHoursDay ,  '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =5 and PRD.Thursday = "T" , PRD.ThursdayCapacityHoursDay ,  '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =6 and PRD.Friday   = "T" , PRD.FridayCapacityHoursDay ,  '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =7 and PRD.Saturday = "T" , PRD.SaturdayCapacityHoursDay , 0))))))) CapacityHoursDay , '+
      ' PR.SetupHoursDay, PR.BreakdownHoursDay,' +
      ' convert(if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =1 and PRD.Sunday   = "T" , PRD.SundayStartAt , '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =2 and PRD.Monday   = "T" , PRD.MondayStartAt ,  '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =3 and PRD.TuesDay  = "T" , PRD.TuesdayStartAt ,  '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =4 and PRD.Wednesday= "T" , PRD.WednesdayStartAt ,  '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =5 and PRD.Thursday = "T" , PRD.ThursdayStartAt ,  '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =6 and PRD.Friday   = "T" , PRD.FridayStartAt ,  '+
      ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =7 and PRD.Saturday = "T" , PRD.SaturdayStartAt , 0))))))), Time) StartAt  '+
      ' FROM tblProcResource PR inner join tblProcResourceDays PRD on PRD.ProcResourceID = PR.ProcResourceId ';
    if ProcessStepId > 0 then
      qry.SQL.Add('JOIN tblProcResourceProcess PRP ON PRP.ProcResourceId = PR.ProcResourceId' +
      ' AND PRP.ProcessStepId = ' +IntToStr(ProcessStepId));
    qry.SQL.Add(
      ' LEFT JOIN tblProcResourceAvailability RA ON RA.ProcResourceId = PR.ProcResourceId' +
      ' WHERE PR.ResourceAvailable = "T"');
    if ProcResourceId > 0 then
      qry.SQL.Add(' AND PR.ProcResourceId = ' +IntToStr(ProcResourceId));
    qry.SQL.Add(' AND ISNULL( RA.TimeStart) OR ' +
      ' NOT ((' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ' >=  RA.TimeStart)' +
      ' AND (' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ' <=  RA.TimeEnd))'); {*AutoScheduleBasedonBOMEmpRoster*2}
    qry.Open;
    while not qry.Eof do begin
      result:= result + qry.Fields[0].AsFloat - qry.Fields[1].AsFloat - qry.Fields[2].AsFloat;
      StartAt := Qry.FieldByName('StartAt').asDatetime;
      qry.Next;
    end;
  finally
    FreeAndNil(qry);
  end;
end;*)

procedure UpdateTreeProductsCostAndPrice(TreeNode: TProcTreeNode);
var
  x: integer;
  Product: TProduct;
begin
  if TreeNode.PartsId > 0 then begin
    if TreeNode.Quantity <> 0 then begin
      Product:= TProduct.Create(nil);
      try
        Product.Load(TreeNode.PartsId);
        TreeNode.Cost:= Product.GetCostForQty(TreeNode.Quantity);
        TreeNode.Price:= Product.GetPriceForQty(TreeNode.Quantity);
      finally
        FreeAndNil(Product);
      end;
    end
    else begin
      TreeNode.Cost:= 0;
      TreeNode.Price:= 0;
    end;
  end;
  { child nodes ... }
  for x:= 0 to TreeNode.Children.Count -1 do
    UpdateTreeProductsCostAndPrice(TProcTreeNode(TreeNode.Children[x]));
end;


function ProcessPartStatusToUserStr(const ProcessPartStatus: TProcessPartStatus): string;
begin
  case ProcessPartStatus of
    psNotScheduled: result:= PS_STR_NOTSCHEDULED;
    psScheduled: result:= PS_STR_SCHEDULED;
    psStarted: result:= PS_STR_STARTED;
    psComplete: result:= PS_STR_COMPLETE;
    psQualityAssurance: result :=PS_STR_QualityAssurance;
    else
      raise Exception.Create('ProcessPartStatusToUserStr - Invalid ProcessPartStatus');
  end;
end;

procedure BuildProductionRequirementsList(const aTableName: string; const ProcessStepId: integer = 0; ProcTreeIds:String='');
var
  sl: TStringList;
  cmd: TERPCommand;
  qry: TERPQuery;
  Tree: TProcTreeNode;
  Product: TProduct;
  Holidays: TPublicHolidays;
  StepFirstTime: TDateTime;
  StepDesc: string;
  StepStatus: string;
  StepNodeId: integer;
  LastProcessStepId: integer;
  ProgDlg: TProgressDialog;

  procedure NodeProcessStepInfo(const aNode: TProcTreeNode);
  var
    stepIdx: integer;
    node: TProcTreeNode;
  begin
    node:= aNode;
    { look back up tree to find node that has process steps }
    while (node.ProcessStepList.Count = 0) and (not node.IsRoot) do begin
      if Assigned(node.ParentNode) then
        node:= node.ParentNode;
    end;
    if ((node.ProcessStepList.Count > 0) or node.IsRoot) and (StepNodeId <> node.Id) then begin
      StepDesc:= '';
      StepStatus:= '';
      StepFirstTime:= 0;
      LastProcessStepId:= 0;
      for stepIdx:= 0 to node.ProcessStepList.Count -1 do begin
        if (ProcessStepId = 0) or (node.ProcessStepList[stepIdx].ProcessStepID = ProcessStepId) then begin
          if StepDesc <> '' then StepDesc:= StepDesc + ', ';
          StepDesc:= StepDesc + node.ProcessStepList[stepIdx].ProcessStepDescription;
          if (node.ProcessStepList[stepIdx].TimeStart > 0) and
            ((node.ProcessStepList[stepIdx].TimeStart < StepFirstTime) or (StepFirstTime = 0)) then
            StepFirstTime:= node.ProcessStepList[stepIdx].TimeStart;
          if StepStatus <> '' then StepStatus:= StepStatus + ', ';
          StepStatus:= StepStatus + ProcessPartStatusToUserStr(node.ProcessStepList[stepIdx].Status);
          LastProcessStepId:= node.ProcessStepList[stepIdx].ProcessStepID;
        end;
      end;
      StepNodeId:= node.Id;
    end;
  end;

  procedure ProcessNode(const node: TProcTreeNode);
  var
    x: integer;
    dt: TDateTime;
    qty: double;
  begin
    if node.IsRoot or node.Selected or (Assigned(node.ParentNode) and (node.ParentNode.InputType <> itOption)) then begin

      NodeProcessStepInfo(node);
      if (ProcessStepId > 0) and (ProcessStepId <> LastProcessStepId) then
        exit;

      if node.PartsId <> Product.Id then
        Product.Load(node.PartsId);

      cmd.SQL.Clear;
      cmd.SQL.Add('INSERT INTO ' + aTableName + ' SET ');
      cmd.SQL.Add('SaleId = ' + qry.FieldByName('SaleId').AsString + ', ');
      cmd.SQL.Add('SaleDocNumber = ' + QuotedStr(qry.FieldByName('SaleDocNumber').AsString) + ', ');
      cmd.SQL.Add('CustomerName = ' + QuotedStr(qry.FieldByName('SaleCustomerName').AsString) + ', ');
      cmd.SQL.Add('SaleShipDate = ' + QuotedStr(DateTimeToMysqlDateStr(qry.FieldByName('SaleShipDate').AsDateTime)) + ', ');
      cmd.SQL.Add('SaleClassId = ' + qry.FieldByName('SaleClassId').AsString + ', ');
      cmd.SQL.Add('SaleLineId = ' + qry.FieldByName('SaleLineId').AsString + ', ');
      cmd.SQL.Add('LineProductId = ' + qry.FieldByName('ProductId').AsString + ', ');
      cmd.SQL.Add('LineProductName = ' + QuotedStr(qry.FieldByName('LineProductName').AsString) + ', ');
      cmd.SQL.Add('LineProductDescription = ' + QuotedStr(qry.FieldByName('LineProductDescription').AsString) + ', ');
      cmd.SQL.Add('LineQuantity = ' + qry.FieldByName('LineQty').AsString + ', ');
      cmd.SQL.Add('LineShipDate = ' + QuotedStr(DateTimeToMysqlDateStr(qry.FieldByName('LineShipDate').AsDateTime)) + ', ');

      cmd.SQL.Add('StepDescription = ' + QuotedStr(StepDesc) +', ');
      if StepFirstTime > 0 then begin
        dt:= StepFirstTime;
        cmd.SQL.Add('StepTimeStart = ' + QuotedStr(DateTimeToMysqlDateStr(StepFirstTime)) + ', ');
      end
      else
        dt:= Date;
      { if we have gone past scheduled date use todays date instead }
      if dt < Date then
        dt:= Date;
      cmd.SQL.Add('StepStatus = ' + QuotedStr(StepStatus) + ', ');

      //qty:= Product.AvailableQty('','','','','',dt);
      with Product.getNewDataset(ProductQtyLib.SQL4ProductAvailableQty(dt, '', tsummary, Product.ID)) do try
        Qty := FieldByname('Qty').asFloat;
      finally
          if active then Close;
          Free;
      end;

      cmd.SQL.Add('ProcTreeId = ' + IntToStr(node.Id) + ', ');

      if node.IsRoot then
        cmd.SQL.Add('ProcItemRoot = "T", ');
      cmd.SQL.Add('ProcItem = ' + QuotedStr(node.Caption) + ', ');
      cmd.SQL.Add('ProcItemDescription = ' + QuotedStr(node.Description) + ', ');
      cmd.SQL.Add('ProcItemDetails = ' + QuotedStr(node.Details) + ', ');

      if node.IsOptionItem then begin
        cmd.SQL.Add('ProcItemQuantity = ' + FloatToStr(node.ParentNode.Quantity) + ', ');
        cmd.SQL.Add('ProcItemTotalQty = ' + FloatToStr(node.ParentNode.TotalQty) + ', ');
      end
      else begin
        cmd.SQL.Add('ProcItemQuantity = ' + FloatToStr(node.Quantity) + ', ');
        cmd.SQL.Add('ProcItemTotalQty = ' + FloatToStr(node.TotalQty) + ', ');
      end;

      cmd.SQL.Add('ProcItemPartsId = ' + IntToStr(node.PartsId) + ', ');
      cmd.SQL.Add('ProcItemPartType = ' + QuotedStr(Product.ProductType) + ', ');

      if Assigned(node.ProcTreePart) then begin
        cmd.SQL.Add('ProcItemPartUOMId = ' + IntToStr(Node.ProcTreePart.UnitOfMeasureID) + ', ');
        cmd.SQL.Add('ProcItemPartUOM = ' + QuotedStr(Node.ProcTreePart.UnitOfMeasure) + ', ');
        cmd.SQL.Add('ProcItemPartUOMMultiplier = ' + FloatToStr(Node.ProcTreePart.UOMMultiplier) + ', ');
      end
      else begin
        cmd.SQL.Add('ProcItemPartUOMMultiplier = 1, ');
      end;

      cmd.SQL.Add('ProjectedQty = ' + FloatToStr(qty) + ', ');
      cmd.SQL.Add('ProcItemPartLeadTime = ' + FloatToStr(Product.NormalDeliveryTime) + '');
      if node.PartsId = Product.Id then begin
        if StepFirstTime > 0 then begin
          dt:= StepFirstTime - Product.NormalDeliveryTime - ProcPrefs.AllocationWarningDays;
          while (DayOfWeek(dt) in [1,7]) or Holidays.IsHoliday(dt) do
            dt:= dt -1;
          cmd.SQL.Add(', LastOrderDate = ' + QuotedStr(DateTimeToMysqlDateStr(dt)));
        end;
      end;
      cmd.Execute;

    end;
    for x:= 0 to node.Children.Count -1 do
      ProcessNode(TProcTreeNode(node.Children[x]));
  end;

begin
  DestroyUserTemporaryTable(aTableName);
  sl:= TStringList.Create;
  cmd:= TERPCommand.Create(nil);
  try
    cmd.Connection:= GetSharedMyDacConnection;
    if not TableExists(aTableName)  then begin
      sl.Add('CREATE TABLE ' + aTableName + ' (');
      sl.Add('ID INT(11) AUTO_INCREMENT,');
      sl.Add('SaleId Int(11) NOT NULL,');
      sl.Add('SaleDocNumber Varchar(255) default NULL,');
      sl.Add('CustomerName Varchar(255) NOT NULL,');
      sl.Add('SaleShipDate Date default NULL,');
      sl.Add('SaleClassId Int(11) default NULL,');
      sl.Add('SaleLineId Int(11) NOT NULL,');
      sl.Add('LineProductId Int(11) default NULL,');
      sl.Add('LineProductName Varchar(255) NOT NULL,');
      sl.Add('LineProductDescription Varchar(255) default NULL,');
      sl.Add('LineQuantity Double NOT NULL,');
      sl.Add('LineShipDate Date default NULL,');
      sl.Add('StepDescription Varchar(255) default NULL,');
      sl.Add('StepTimeStart Date default NULL,');
      sl.Add('StepStatus Varchar(255) default NULL,');
      sl.Add('ProcTreeId Int(11) NOT NULL,');
      sl.Add('ProcItemRoot ENUM("T","F") default "F",');
      sl.Add('ProcItem Varchar(255) NOT NULL,');
      sl.Add('ProcItemDescription Varchar(255) default NULL,');
      sl.Add('ProcItemDetails Text default NULL,');
      sl.Add('ProcItemQuantity Double default NULL,');
      sl.Add('ProcItemTotalQty Double default NULL,');
      sl.Add('ProcItemPartsId Int(11) default 0,');
      sl.Add('ProcItemPartType Varchar(255) default NULL,');
      sl.Add('ProcItemPartLeadTime Double default NULL,');
      sl.Add('ProcItemPartUomId Int(11) default NULL,');
      sl.Add('ProcItemPartUom Varchar(255) default NULL,');
      sl.Add('ProcItemPartUomMultiplier Double default NULL,');
      sl.Add('ProjectedQty Double default NULL,');
      sl.Add('LastOrderDate Date default NULL,');
      sl.Add('PRIMARY KEY (`ID`)) ENGINE=MyISAM;');
      CreateUserTemporaryTable(sl);
    end
    else begin
      cmd.SQL.Text:= 'DELETE FROM ' + aTableName;
      cmd.Execute;
    end;

    sl.Clear;
    sl.Add('SELECT DISTINCT s.SaleId, s.InvoiceDocNumber as SaleDocNumber, ');
    sl.Add('s.CustomerName as SaleCustomerName, s.ClassId as SaleClassId, ');
    sl.Add('s.ShipDate as SaleShipDate,');
    sl.Add('sl.SaleLineId, sl.ProductId, sl.ProductName as LineProductName, ');
    sl.Add('sl.Product_Description as LineProductDescription, ');
    sl.Add('sl.UnitOfMeasureShipped as LineQty, sl.ShipDate as LineShipDate,');
    sl.Add('pt.ProcTreeId');
    sl.Add('FROM tblSales s, tblSalesLines sl, tblProcTree pt');
    sl.Add('LEFT JOIN tblProcessPart PP on PP.ProcTreeId = PT.ProcTreeId and PP.Status not in ("psComplete")');
    sl.Add('WHERE pt.MasterId = sl.SaleLineId');
    sl.Add('AND s.IsSalesOrder = "T"');
    sl.Add('AND sl.SaleId = s.SaleId');
    sl.Add('AND PT.ParentId = 0');
    sl.Add('AND PT.Complete = "F"');
    if ProcTreeIds <> '' then
      sl.Add('AND pt.ProcTreeId in ('+ProcTreeIds+')');
    sl.Add('ORDER BY s.SaleId, sl.saleLineId');


    qry:= TERPQuery.Create(nil);
    Tree:= TProcTreeNode.Create(nil);
    Product:= TProduct.Create(nil);
    Holidays:= TPublicHolidays.Create(nil);
    ProgDlg:= TProgressDialog.Create(nil);
    try
      Holidays.Load;
      qry.Connection:= GetSharedMyDacConnection;
      qry.SQL.Assign(sl);
      qry.Open;

      StepNodeId:= 0;
      StepFirstTime:= 0;
      StepDesc:= '';
      LastProcessStepId:= 0;
      ProgDlg.Caption:= 'Populating List ...';
      ProgDlg.MinValue:= 0;
      ProgDlg.Step:= 1;
      ProgDlg.MaxValue:= qry.RecordCount;
      ProgDlg.Execute;
      while not qry.Eof do begin
        Tree.New;
        Tree.Load(qry.FieldByName('ProcTreeId').AsInteger);
        ProcessNode(Tree);

        qry.Next;
        ProgDlg.StepIt;
      end;
    finally
      FreeAndNil(Tree);
      FreeAndNil(Product);
      FreeAndNil(Holidays);
      FreeAndNil(qry);
      FreeAndNil(ProgDlg);
    end;
  finally
    FreeAndNil(sl);
    FreeAndNil(cmd);
  end;

end;

procedure BuildProductionJobList(Const aTableName: string; Const Incomplete, Complete: boolean; Const DateFrom, DateTo: TDateTime);
var
  sl: TStringList;
  cmd: TERPCommand;
  qry: TERPQuery;
  Tree: TProcTreeNode;
  ProgDlg: TProgressDialog;

  procedure ProcessNode(const node: TProcTreeNode);
  begin
    cmd.SQL.Clear;

    cmd.SQL.Add('INSERT INTO ' + aTableName + ' SET ');
    cmd.SQL.Add('SaleId = ' + qry.FieldByName('SaleId').AsString + ', ');
    cmd.SQL.Add('SaleDocNumber = ' + QuotedStr(qry.FieldByName('SaleDocNumber').AsString) + ', ');
    cmd.SQL.Add('CustomerName = ' + QuotedStr(qry.FieldByName('SaleCustomerName').AsString) + ', ');
    cmd.SQL.Add('SaleShipDate = ' + QuotedStr(DateTimeToMysqlDateStr(qry.FieldByName('SaleShipDate').AsDateTime)) + ', ');
    cmd.SQL.Add('SaleDate = ' + QuotedStr(DateTimeToMysqlDateStr(qry.FieldByName('SaleDate').AsDateTime)) + ', ');
//    cmd.SQL.Add('SaleClassId = ' + qry.FieldByName('SaleClassId').AsString + ', ');
    cmd.SQL.Add('SaleLineId = ' + qry.FieldByName('SaleLineId').AsString + ', ');
    cmd.SQL.Add('LineProductName = ' + QuotedStr(qry.FieldByName('LineProductName').AsString) + ', ');
    cmd.SQL.Add('LineProductDescription = ' + QuotedStr(qry.FieldByName('LineProductDescription').AsString) + ', ');
    cmd.SQL.Add('LineQty = ' + qry.FieldByName('LineQty').AsString + ', ');
    cmd.SQL.Add('LineShipDate = ' + QuotedStr(DateTimeToMysqlDateStr(qry.FieldByName('LineShipDate').AsDateTime)) + ', ');
    cmd.SQL.Add('ProcTreeId = ' + IntToStr(node.Id) + ', ');
    if Node.StatusList = [] then
      cmd.SQL.Add('StepStatus = "None"')
    else
      cmd.SQL.Add('StepStatus = ' + QuotedStr(ProcessPartStatusToUserStr(ProcessPartStatusListToStatus(Node.StatusList))));
    if node.complete then
      cmd.SQL.Add(', Finalized = "T"');

    cmd.Execute;
  end;

begin
  DestroyUserTemporaryTable(aTableName);
  sl:= TStringList.Create;
  cmd:= TERPCommand.Create(nil);
  try
    cmd.Connection:= GetSharedMyDacConnection;
    if not TableExists(aTableName) then begin
      sl.Add('CREATE TABLE ' + aTableName + ' (');
      sl.Add('ID INT(11) AUTO_INCREMENT,');
      sl.Add('SaleId Int(11) NOT NULL,');
      sl.Add('SaleDocNumber Varchar(255) default NULL,');
      sl.Add('CustomerName Varchar(255) NOT NULL,');
      sl.Add('SaleDate Date default NULL,');
      sl.Add('SaleShipDate Date default NULL,');
      sl.Add('SaleLineId Int(11) NOT NULL,');
      sl.Add('LineProductName Varchar(255) NOT NULL,');
      sl.Add('LineProductDescription Varchar(255) default NULL,');
      sl.Add('LineQty Double NOT NULL,');
      sl.Add('LineShipDate Date default NULL,');
      sl.Add('StepStatus Varchar(255) default NULL,');
      sl.Add('Finalized ENUM("T","F") default "F",');
      sl.Add('ProcTreeId Int(11) NOT NULL,');
      sl.Add('PRIMARY KEY (`ID`)) ENGINE=MyISAM;');
      CreateUserTemporaryTable(sl);
    end
    else begin
      cmd.SQL.Text:= 'DELETE FROM ' + aTableName;
      cmd.Execute;
    end;

    sl.Clear;
    sl.Add('SELECT DISTINCT s.SaleId, s.InvoiceDocNumber as SaleDocNumber, s.CustomerName as SaleCustomerName, s.ClassId as SaleClassId, s.ShipDate as SaleShipDate, s.SaleDate,');
    sl.Add('sl.SaleLineId, sl.ProductName as LineProductName, sl.Product_Description as LineProductDescription, sl.UnitOfMeasureShipped as LineQty, sl.ShipDate as LineShipDate,');
    sl.Add('pt.ProcTreeId');
//    sl.Add('FROM tblSales s, tblSalesLines sl, tblProcTree pt, tblProcessPart PP');
    sl.Add('FROM tblSales s, tblSalesLines sl, tblProcTree pt');
    sl.Add('LEFT JOIN tblProcessPart PP on PP.ProcTreeId = PT.ProcTreeId');
    sl.Add('WHERE pt.MasterType = "mtSalesOrder"');
    sl.Add('AND pt.MasterId = sl.SaleLineId');
    sl.Add('AND sl.SaleId = s.SaleId');
//    sl.Add('AND PP.ProcTreeId = PT.ProcTreeId');
    sl.Add('AND PT.ParentId = 0');
//    sl.Add('AND PP.IsTemplate = "F"');

    if Incomplete and (not Complete) then
      sl.Add('AND PT.Complete = "F"')
    else if Complete and (not Incomplete) then
      sl.Add('AND PT.Complete = "T"');

    sl.Add('AND s.SaleDate >= ' + QuotedStr(DateTimeToMysqlDateStr(DateFrom)));
    sl.Add('AND s.SaleDate <= ' + QuotedStr(DateTimeToMysqlDateStr(DateTo)));


    sl.Add('ORDER BY s.SaleId, sl.saleLineId');


    qry:= TERPQuery.Create(nil);
    Tree:= TProcTreeNode.Create(nil);
    ProgDlg:= TProgressDialog.Create(nil);
    try
      qry.Connection:= GetSharedMyDacConnection;
      qry.SQL.Assign(sl);
      qry.Open;
      ProgDlg.Caption:= 'Building List ...';
      ProgDlg.Step:= 1;
      ProgDlg.MaxValue:= qry.RecordCount;
      ProgDlg.MinValue:= 0;
      ProgDlg.Execute;
      while not qry.Eof do begin
        Tree.New;
        Tree.Load(qry.FieldByName('ProcTreeId').AsInteger);
        ProcessNode(Tree);

        qry.Next;
        ProgDlg.StepIt;
      end;
    finally
      FreeAndNil(Tree);
      FreeAndNil(qry);
      ProgDlg.Free;
    end;
  finally
    FreeAndNil(sl);
    FreeAndNil(cmd);
  end;
end;


{ Returns true if any node in tree is a custom input type }
function ProcTreeIsCustom(Tree: TProcTreeNode): boolean;
var x: integer;
begin
  result:= Tree.InputType = itCustom;
  if not result then begin
    for x:= 0 to Tree.Children.Count-1 do begin
      result:= ProcTreeIsCustom(TProcTreeNode(Tree.Children[x]));
      if result then
        break;
    end;
  end;
end;

{ Returns true if any node in tree has process steps }
function ProcTreeHasProcesses(Tree: TProcTreeNode): boolean;
var x: integer;
begin
  result:= Tree.ProcessStepList.Count > 0;
  if not result then begin
    for x:= 0 to Tree.Children.Count -1 do begin
      if ProcTreeHasProcesses(TProcTreeNode(Tree.Children[x])) then begin
        result:= true;
        Break;
      end;
    end;
  end;
end;

function ProductNodeHasProducts(Node: TProcTreeNode): boolean;
var
  x: integer;
begin
  result:= false;
  if Node.IsRoot then
    exit;
  if Node.PartsId > 0 then begin
    result:= true;
  end
  else begin
    for x:= 0 to Node.Children.Count -1 do begin
      result:= ProductNodeHasProducts(TProcTreeNode(Node.Children[x]));
      if result then
        break;
    end;
  end;
end;

{ Scan through tree and return true if there are any nodes that are inventory
  parts but do not have associated process steps (parent above them).
  msg will contain captions of nodes without associated processes.  }
function HasProcessSteps(Tree: TProcTreeNode):Boolean;
begin
     result := Tree.HasProcessSteps;
end;

function ProcTreePartsWithoutProcess(Tree: TProcTreeNode; var list: string): boolean;
var x: integer;
begin
  result:= false;
  if (Tree.PartsId > 0) and (not Tree.IsRoot) and
//    (not Tree.HasProcessSteps) then begin
    (not Tree.ParentNode.HasProcessSteps) then begin
    result:= true;
    if list <> '' then list:= list + ', ';
    list:= list + Tree.ParentNode.Caption;
  end;

  if (not result) and (Tree.ProcessStepList.Count = 0) then begin
//    no process steps so check children
    for x:= 0 to Tree.Children.Count -1 do begin
      if ProcTreePartsWithoutProcess(TProcTreeNode(Tree.Children[x]), list) then begin
        result:= true;
        Break;
      end;
    end;
  end;
end;

{  Scan through tree and return true if there are any option nodes that do not
   have default values (ie selected child).
   list contains captions of nodes without defauls.  }
function ProcTreeOptionsWithotDefaults(Tree: TProcTreeNode; var list: string): boolean;
var x: integer;
begin
  result:= false;
  if (Tree.InputType = itOption) and (not Assigned(Tree.SelectedChild)) then begin
    if list <> '' then list:= list + ', ';
    list:= list + Tree.Caption;
    result:= true;
  end;
  for x:= 0 to Tree.Children.Count -1 do begin
    if ProcTreeOptionsWithotDefaults(TProcTreeNode(Tree.Children[x]), list) then begin
      result:= true;
    end;
  end;
end;

{  Scan through tree and return true if there are any nodes with processes
   and a quantity of zero.
   list contains captions of nodes without quantity.  }
function ProcTreeProcessesWithotQuantity(ParentNode,Tree: TProcTreeNode; var list: string): boolean;
var x: integer;
begin
  result:= false;
  if (Parentnode=nil) or (ParentNode.inputtype<> itOption) or (Tree.Selected) then begin
    if (Tree.PartsId > 0) and (Tree.HasProcessSteps) and (Tree.Quantity = 0) then begin
      if list <> '' then list:= list + ', ';
      list:= list + Tree.Caption;
      result:= true;
    end;
  end;
  for x:= 0 to Tree.Children.Count -1 do begin
    if ProcTreeProcessesWithotQuantity(Tree, TProcTreeNode(Tree.Children[x]), list) then begin
      result:= true;
    end;
  end;
end;

{  Scan through tree and return true if there are any option nodes }
function ProcTreeHasOptions(Node: TProcTreeNode): boolean;
var x: integer;
begin
  result:= false;
  if (Node.InputType = itOption) then begin
    result:= true;
  end
  else begin
    for x:= 0 to Node.Children.Count -1 do begin
      if ProcTreeHasOptions(TProcTreeNode(Node.Children[x])) then begin
        result:= true;
        break;
      end;
    end;
  end;
end;
function ProcTreeHasCustoms(Node: TProcTreeNode): boolean;
var x: integer;
begin
  result:= false;
  if (Node.InputType = itcustom) then begin
    result:= true;
  end
  else begin
    for x:= 0 to Node.Children.Count -1 do begin
      if ProcTreeHasCustoms(TProcTreeNode(Node.Children[x])) then begin
        result:= true;
        break;
      end;
    end;
  end;
end;

function CreateProductionPickingSlip(ProcessStepIdList: TIntegerList;
                                     const ProcResourceId: integer;
                                     const DateFrom, DateTo: TDateTime;
                                     Conn: TERPConnection): integer;
var
  qry: TERPQuery;
begin
  result:= 0;
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= Conn;
    qry.SQL.Add('SELECT sl.SaleId, sl.SaleLineId, pt.ProcTreeId, pp.Id as ProcessPartId');
    qry.SQL.Add('FROM tblSalesLines sl, tbpProcTree pt, tblProcessPart pp, tblProcResourceProcess rp');
    qry.SQL.Add('WHERE rp.ProcessStepId = pp.ProcessStepId');
    qry.SQL.Add('WHERE pp.ProcTreeId = pt.ProcTreeId');
    qry.SQL.Add('AND pt.MasterIdId = sl.SaleLineId');
    qry.SQL.Add('AND pp.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,DateFrom)));
    qry.SQL.Add('AND pp.TimeStart <= ' + QuotedStr(FormatDateTime(MysqlDateFormat,DateTo)));
    if ProcessStepIdList.Count > 0 then
      qry.SQL.Add('AND rp.ProcessStepId IN (' + ProcessStepIdList.CommaText + ')')
    else
      qry.SQL.Add('AND rp.ProcResourceId = ' + IntToStr(ProcResourceId));


    qry.Open;
    while not qry.Eof do begin


    end;
  finally
    qry.Free;
  end;
end;

procedure PopulateProductionWorkSheetTable(var TempTableName: string;
                                           ProcessStepIdList: TIntegerList;
                                           aDateFrom, aDateTo: TDateTime;
                                           SaleLineIDList: TIntegerList;
                                           const SubTreeOnly: boolean = true; includeallocation :Boolean =False; IncludeUnScheduled:Boolean = False);
var
  qry: TERPQuery;
  PriorProcessStepId: integer;
  PriorProcTreeId: integer;
  PriorParentId: integer;
  PriorProcess: string;
  PriorProcessextraInfo: string;
  PriorResource: string;
  PriorStartTime: TDateTime;
  PriorStatus: string;
  Indent: integer;
  x: integer;
  tempTablename_Total:String;
  (*tblExists: boolean;*)

  function IndentStr(const Ident: integer; const aStr: string): string;
  var cnt: integer;
  begin
    result:= aStr;
    for cnt:= 0 to Ident do
      result:= '  ' + result;
  end;

begin

  qry:= CommonDbLib.TempMyQuery;
  try
//    if TableExists(TempTableName) then begin
//      qry.SQL.Add('DELETE FROM ' + TempTableName + ';');
//      tblExists:= true;
//    end
//    else
//      tblExists:= false;

    if TempTableName = '' then
        TempTableName:= CreateUserTemporaryTable('tmp_productionworksheet');

    qry.SQL.Text:= 'truncate ' + TempTableName;
    qry.Execute;


    qry.SQL.Clear;
    for x:= 0 to ProcessStepIdList.Count -1 do begin

      qry.SQL.Add('INSERT INTO ' + TempTableName);
      qry.SQL.Add('(PSId,');
      qry.SQL.Add('Indent,');
      qry.SQL.Add('ProctreeID,');
      qry.SQL.Add('RootProctreeId,');
      qry.SQL.Add('Sequencedown,');
      qry.SQL.Add('ResourceName,');
      qry.SQL.Add('ProcessDescription,processstepseq,');
      qry.SQL.Add('ProcessStepExtraInfo,');
      qry.SQL.Add('IsProcess,');
      qry.SQL.Add('ProcessStepId,');
      qry.SQL.Add('ProcessTimeStart,');
      qry.SQL.Add('ProcessTimeEnd,');
      qry.SQL.Add('ProcessDate,');
      qry.SQL.Add('ProcessStatus,');
      qry.SQL.Add('Duration,');
      qry.SQL.Add('SetupDuration,');
      qry.SQL.Add('BreakdownDuration,');
      qry.SQL.Add('ItemCaption,');
      qry.SQL.Add('ItemIndentCaption,');
      qry.SQL.Add('ItemDescription,');
      qry.SQL.Add('ItemInfo,');
      qry.SQL.Add('ItemDetails,');
      qry.SQL.Add('ItemQty,');
      qry.SQL.Add('ItemTotalQty,');
      qry.SQL.Add('ItemId,');
      qry.SQL.Add('ProcessPartId,');
      qry.SQL.Add('ItemParentId,');
      qry.SQL.Add('SaleLineId,');
      qry.SQL.Add('SaleLineProductName,');
      qry.SQL.Add('SaleLineProductFirstcolumn,');
      qry.SQL.Add('SaleLineProductSecondcolumn,');
      qry.SQL.Add('SaleLineProductThirdcolumn,');
      qry.SQL.Add('PRODUCTCOMMENT,');
      qry.SQL.Add('SaleLineProductDescription,');
      qry.SQL.Add('SaleLineProductCustFld1,');
      qry.SQL.Add('SaleLineProductCustFld2,');
      qry.SQL.Add('SaleLineProductCustFld3,');
      qry.SQL.Add('SaleLineProductCustFld4,');
      qry.SQL.Add('SaleLineProductCustFld5,');
      qry.SQL.Add('SaleLineProductCustFld6,');
      qry.SQL.Add('SaleLineProductCustFld7,');
      qry.SQL.Add('SaleLineProductCustFld8,');
      qry.SQL.Add('SaleLineProductCustFld9,');
      qry.SQL.Add('SaleLineProductCustFld10,');
      qry.SQL.Add('SaleLineProductCustFld11,');
      qry.SQL.Add('SaleLineProductCustFld12,');
      qry.SQL.Add('SaleLineProductCustFld13,');
      qry.SQL.Add('SaleLineProductCustFld14,');
      qry.SQL.Add('SaleLineProductCustFld15,');
      qry.SQL.Add('SaleLineProductCustDate1,');
      qry.SQL.Add('SaleLineProductCustDate2,');
      qry.SQL.Add('SaleLineProductCustDate3,');
      qry.SQL.Add('SaleLineQuantity,');
      qry.SQL.Add('SaleLineShippedQuantity,');
      qry.SQL.Add('SaleLineShipDate,');
      qry.SQL.Add('SaleLineUOM,');
      qry.SQL.Add('SaleId,');
      qry.SQL.Add('SaleDocNumber,');
      qry.SQL.Add('SaleCustomerName,');
      qry.SQL.Add('Street,');
      qry.SQL.Add('Street2,');
      qry.SQL.Add('Suburb,');
      qry.SQL.Add('State,');
      qry.SQL.Add('Country,');
      qry.SQL.Add('Postcode,');
      qry.SQL.Add('ShipTo,');
      qry.SQL.Add('InvoiceTo,');
      qry.SQL.Add('SaleDate,');
      qry.SQL.Add('SaleShipDate,');
      qry.SQL.Add('DurationFmt,');
      qry.SQL.Add('SetupDurationFmt,');
      qry.SQL.Add('BreakdownDurationFmt,');
      qry.SQL.Add('TotalScheduledduration,');
      qry.SQL.Add('Scheduledduration,');
      qry.SQL.Add('ItemTotalUOMQty,');
      qry.SQL.Add('UOM ,');
      qry.SQL.Add('EmployeeId,ResDetID,EmployeeName,ResDetName');
      //if includeallocation  then qry.SQL.Add(', Batchno , expirydate , batchqty , binlocation , binnumber , binQty , Serialnumber');
      qry.SQL.Add(')');
      qry.SQL.Add('SELECT ');
      qry.SQL.Add(IntToStr(ProcessStepIdList[x]) + ' as PSId, ');
      qry.SQL.Add('0 as Indent,');
      qry.SQL.Add('pt.ProcTreeId,');
      qry.SQL.Add('pt.TreeRootId,');
      qry.SQL.Add('pt.SequenceDown, ');
      qry.SQL.Add('pr.ResourceName, ');
      qry.SQL.Add('ps.Description as ProcessDescription,pp.processstepseq,');
      qry.SQL.Add('PP.ProcessStepExtraInfo as ProcessStepExtraInfo,');
      qry.SQL.Add('IF(IsNull(pp.Id),"F","T") as IsProcess, ');
      qry.SQL.Add('pp.ProcessStepId, ');
      (*qry.SQL.Add('pp.TimeStart as ProcessTimeStart,');*)
      qry.SQL.Add('PPT.timestart as ProcessTimeStart,  ');
      qry.SQL.Add('DATE_ADD(ppt.TimeStart ,INTERVAL ifnull(PPt.Duration,0)  second) as ProcessTimeEnd, ');
      qry.SQL.Add('Date(PPT.timestart) as ProcessDate,  ');
      qry.SQL.Add('pp.Status as ProcessStatus,');
      qry.SQL.Add('pp.Duration, ');
      qry.SQL.Add('pp.SetupDuration, ');
      qry.SQL.Add('pp.BreakdownDuration,');
      qry.SQL.Add('PT.`Caption` as ItemCaption, ');
      qry.SQL.Add('pt.Caption as ItemIndentCaption, ');
      qry.SQL.Add('pt.Description ItemDescription, ');
      qry.SQL.Add('pt.Info ItemInfo, ');
      qry.SQL.Add('pt.Details as ItemDetails, ');
      qry.SQL.Add('pt.Quantity as ItemQty,  ');
      qry.SQL.Add('pt.TotalQty as ItemTotalQty, ');
      qry.SQL.Add('pt.ProcTreeId as ItemId, ');
      qry.SQL.Add('PPT.ProcessPartId as ProcessPartId, ');
      qry.SQL.Add('pt.ParentId as ItemParentId,');
      qry.SQL.Add('sl.SaleLineId, ');
      qry.SQL.Add('sl.ProductName as SaleLineProductName, ');
      qry.SQL.Add(Firstcolumn +  ' as SaleLineProductFirstcolumn, ');
      qry.SQL.Add(Secondcolumn+  ' as SaleLineProductSecondcolumn, ');
      qry.SQL.Add(Thirdcolumn +  ' as SaleLineProductThirdcolumn, ');
      qry.SQL.Add('P.PRODUCTCOMMENT as PRODUCTCOMMENT,');
      qry.SQL.Add('sl.Product_Description as SaleLineProductDescription, ');
      qry.SQL.Add('P.CUSTFLD1,');
      qry.SQL.Add('P.CUSTFLD2,');
      qry.SQL.Add('P.CUSTFLD3,');
      qry.SQL.Add('P.CUSTFLD4,');
      qry.SQL.Add('P.CUSTFLD5,');
      qry.SQL.Add('P.CUSTFLD6,');
      qry.SQL.Add('P.CUSTFLD7,');
      qry.SQL.Add('P.CUSTFLD8,');
      qry.SQL.Add('P.CUSTFLD9,');
      qry.SQL.Add('P.CUSTFLD10,');
      qry.SQL.Add('P.CUSTFLD11,');
      qry.SQL.Add('P.CUSTFLD12,');
      qry.SQL.Add('P.CUSTFLD13,');
      qry.SQL.Add('P.CUSTFLD14,');
      qry.SQL.Add('P.CUSTFLD15,');
      qry.SQL.Add('P.CUSTDATE1,');
      qry.SQL.Add('P.CUSTDATE2,');
      qry.SQL.Add('P.CUSTDATE3,');

      qry.SQL.Add('sl.UnitOfMeasureQtySold as SaleLineQuantity, ');
      qry.SQL.Add('sl.UnitofMeasureShipped as SaleLineShippedQuantity, ');

      qry.SQL.Add('sl.ShipDate as SaleLineShipDate,');
      qry.SQL.Add('concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier, ")"),');
      qry.SQL.Add('s.SaleId, ');
      qry.SQL.Add('s.InvoiceDocNumber as SaleDocNumber, ');
      qry.SQL.Add('s.CustomerName as SaleCustomerName, ');
      qry.SQL.Add('C.Street, ');
      qry.SQL.Add('C.Street2, ');
      qry.SQL.Add('C.Suburb, ');
      qry.SQL.Add('C.State, ');
      qry.SQL.Add('C.Country, ');
      qry.SQL.Add('C.Postcode, ');
      qry.SQL.Add('S.ShipTo, ');
      qry.SQL.Add('S.InvoiceTo, ');
      qry.SQL.Add('s.SaleDate, ');
      qry.SQL.Add('s.ShipDate as SaleShipDate,');

      qry.SQL.Add('FormatSecondsTotime(Round(pp.Duration, 0)) as   DurationFmt,');
      qry.SQL.Add('FormatSecondsTotime(Round(pp.SetupDuration,0)) as SetupDurationFmt,');
      qry.SQL.Add('FormatSecondsTotime(Round(pp.BreakdownDuration, 0)) as BreakdownDurationFmt,');

      qry.SQL.Add('(Select round(Sum(PPT.Duration),0)  From   tblProcessTime PPT  Where  PPT.ProcessPartId = PP.ID ) as TotalScheduledduration,');
      Qry.SQL.add('round((PPT.Duration),0)  as Scheduledduration,');
      qry.SQL.Add('PT.TreePartUOMTotalQty  , ');
      qry.SQL.Add('concat(PT.TreePartUOM , "(" , PT.TreePartUOMMultiplier , ")"),');
      qry.SQL.Add('PPT.EmployeeId, PPT.ResourceDetailsID, E.employeename , PRD.Description');

      qry.SQL.Add('FROM tblProcTree pt');
      qry.SQL.Add('JOIN tblSalesLines sl ON pt.MasterId = sl.SaleLineId AND pt.MasterType <> "mtProduct"');
      qry.SQL.Add('JOIN tblSales s ON sl.SaleId = s.SaleId');
      qry.SQL.Add('JOIN tblClients C on C.ClientId = S.clientID');
      qry.SQL.Add('JOIN tblPArts P on P.PARTNAME = sl.ProductName');
      if not SubTreeOnly then qry.SQL.Add('LEFT');
      qry.SQL.Add('JOIN tblProcessPart pp ON pp.ProcTreeId = pt.ProcTreeId');
      qry.SQL.Add(' Left join (tblProcessTime PPT  Left join tblEmployees E on PPT.employeeId = E.EmployeeId inner join tblprocresourcedetails PRD on PRD.ID = PPT.ResourceDetailsID) ');
      qry.SQL.Add(' on PPT.ProcessPartId = PP.ID and PPT.duration <> 0 and PPT.active ="T" and PPT.timestart > "1900-01-01 00:00:00"');
      qry.SQL.Add('LEFT JOIN tblProcessStep ps ON ps.Id = pp.ProcessStepId');
      qry.SQL.Add('LEFT JOIN tblProcResourceProcess rp ON rp.ProcessStepId = ps.Id');
      qry.SQL.Add('LEFT JOIN tblProcResource pr ON pr.ProcResourceId = rp.ProcResourceId');
      qry.SQL.Add('LEFT JOIN tblProcTree pt2 ON pt.ParentId = pt2.ProcTreeId');

      qry.SQL.Add('WHERE (((pt2.InputType IS NULL OR pt2.InputType <> "itOption")) OR (pt2.InputType = "itOption" AND pt.Selected = "T"))');
      qry.SQL.Add(' and pp.ProcessStepId = ' + IntToStr(ProcessStepIdList[x]));
      qry.SQL.Add('AND (('+ quotedstr(SystemLib.BooleanToStr(IncludeUnScheduled))+' = "T" AND  PP.status ="psNotScheduled") or (PP.status ="psScheduled" ') ;
      if (aDateFrom <> 0) and (aDateTo   <> 0) then begin
        qry.SQL.Add('AND ((  PPT.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDateFrom))+' AND DATE_ADD(ppt.TimeStart ,INTERVAL ifnull(PPt.Duration,0)  second)   < ' + QuotedStr(FormatDateTime(MysqlDateFormat,incday(aDateTo,1)))+')  ' );
        qry.SQL.Add('  OR (PPT.TimeStart < ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDateFrom))+' AND DATE_ADD(ppt.TimeStart ,INTERVAL ifnull(PPt.Duration,0)  second)   > ' + QuotedStr(FormatDateTime(MysqlDateFormat,incday(aDateTo,1)))+') ' );
        qry.SQL.Add('  OR (PPT.TimeStart >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDateFrom))+' AND PPT.TimeStart < ' + QuotedStr(FormatDateTime(MysqlDateFormat,incday(aDateTo,1)))+') ' );
        qry.SQL.Add('  OR (DATE_ADD(ppt.TimeStart ,INTERVAL ifnull(PPt.Duration,0)  second)   >= ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDateFrom))+' AND DATE_ADD(ppt.TimeStart ,INTERVAL ifnull(PPt.Duration,0)  second)   < ' + QuotedStr(FormatDateTime(MysqlDateFormat,incday(aDateTo,1)))+')) ' );
      end;
      qry.SQL.Add('))');

      if SaleLineIDList.count <> 0 then qry.SQL.Add('AND SL.saleLineId in (' +SaleLineIDList.Commatext +')' );

      qry.SQL.Add('ORDER BY sl.SaleLineId, pt.TreeRootId, pt.SequenceDown, PP.ProcessStepSeq');
      qry.SQL.Add(';');
    end;
    Qry.SQL.add('update '+tempTablename+' Set   TotalScheduleddurationfmt = FormatSecondsTotime(TotalScheduledduration);');
    Qry.SQL.add('update '+tempTablename+' Set   Scheduleddurationfmt = FormatSecondsTotime(Scheduledduration);');

    try
      clog(Qry.SQL.Text);
      qry.Execute;
    except
      on E:EXception do begin
        Logtext(e.Message);
      end;
    end;
    PriorProcessStepId:= 0;
    PriorProcess:= '';
    PriorProcessextraInfo:= '';
    PriorResource:= '';
    PriorStartTime:= 0;
    PriorParentId:= 0;
    PriorProcTreeId:= 0;
    Indent:= 0;
    qry.SQL.Text:= 'SELECT * FROM ' + TempTableName+' order by SaleLineId, RootProctreeId, SequenceDown, processstepseq';

    { scan through table and update }
    qry.Open;
    while not qry.Eof do begin
      if (not qry.FieldByName('ProcessStepId').IsNull) then begin
        if (PriorProcessStepId <> qry.FieldByName('ProcessStepId').AsInteger) then begin
          PriorProcessStepId:= qry.FieldByName('ProcessStepId').AsInteger;
          PriorProcess:= qry.FieldByName('ProcessDescription').AsString;
          PriorProcessextraInfo:= qry.FieldByName('ProcessStepExtraInfo').AsString;
          PriorResource:= qry.FieldByName('ResourceName').AsString;
          PriorStartTime:= qry.FieldByName('ProcessTimeStart').AsDateTime;
          PriorStatus:= qry.FieldByName('ProcessStatus').AsString;
          Indent:= 0;
        end;
      end
      else begin
        { null ProcessStepId so update from prior record }
        if (qry.FieldByName('ItemParentId').AsInteger = PriorProcTreeId) and
           (qry.FieldByName('ItemParentId').AsInteger <> PriorParentId) then
          Inc(Indent)
        else if (qry.FieldByName('ItemParentId').AsInteger <> PriorProcTreeId) and
           (qry.FieldByName('ItemParentId').AsInteger <> PriorParentId) then
          Dec(Indent);
        qry.Edit;
        qry.FieldByName('ProcessStepId').AsInteger:= PriorProcessStepId;
        qry.FieldByName('ProcessDescription').AsString:= PriorProcess;
        qry.FieldByName('ProcessStepExtraInfo').AsString:= PriorProcessextraInfo;
        qry.FieldByName('ResourceName').AsString:= PriorResource;
        qry.FieldByName('ProcessTimeStart').AsDateTime:= PriorStartTime;
        qry.FieldByName('ProcessStatus').AsString:= PriorStatus;
        qry.FieldByName('Indent').AsInteger:= Indent;
        qry.FieldByName('ItemIndentCaption').AsString:=
          IndentStr(Indent, qry.FieldByName('ItemCaption').AsString);
        qry.Post;
      end;
      PriorProcTreeId:= qry.FieldByName('ItemId').AsInteger;
      PriorParentId:= qry.FieldByName('ItemParentId').AsInteger;
      qry.Next;
    end;
    qry.Close;
    qry.SQL.clear;

    if SubTreeOnly then qry.SQL.add('DELETE FROM ' + TempTableName + ' WHERE ifnull(PSId,0)=0;');

    { now delete records that are not part of structure for required process steps }
    qry.SQL.add('DELETE FROM ' + TempTableName + ' WHERE PSId <> ProcessStepId;');

    Qry.SQL.add('Drop table if exists '+tempTablename+'1;');
    Qry.SQL.add('Create table '+tempTablename+'1 Select ProcessDescription ,ProcessStepExtraInfo, ProcessDate ProcessTimeStartdt, Sum(TotalScheduledduration) ProcessTotalofTotalScheduledduration from '+tempTablename+' group by ProcessDate , ProcessDescription;');
    Qry.SQL.add('update '+tempTablename+' T inner join '+tempTablename+'1 T1 on ProcessDate = T1.ProcessTimeStartdt and T.ProcessDescription = T1.ProcessDescription Set   T.ProcessTotalofTotalScheduledduration = T1.ProcessTotalofTotalScheduledduration;');
    Qry.SQL.add('update '+tempTablename+' Set ProcessTotalofTotalScheduleddurationFMT = FormatSecondsTotime(ProcessTotalofTotalScheduledduration);');
    Qry.SQL.add('Drop table if exists '+tempTablename+'1;');

    Qry.SQL.add('Create table '+tempTablename+'1 Select ProcessDescription, ProcessStepExtraInfo, ProcessDate ProcessTimeStartdt, Sum(Scheduledduration) ProcessScheduleddurationForDay from '+tempTablename+' group by ProcessDate, ProcessDescription;');
    Qry.SQL.add('update '+tempTablename+' T inner join '+tempTablename+'1 T1 on ProcessDate = T1.ProcessTimeStartdt and T.ProcessDescription = T1.ProcessDescription Set   T.ProcessScheduleddurationForDay = T1.ProcessScheduleddurationForDay;');
    Qry.SQL.add('update '+tempTablename+' Set ProcessScheduleddurationForDayFMT = FormatSecondsTotime(ProcessScheduleddurationForDay);');
    Qry.SQL.add('Drop table if exists '+tempTablename+'1;');

    {Date level totla}
    Qry.SQL.add('Drop table if exists '+tempTablename+'1;');
    Qry.SQL.add('Create table '+tempTablename+'1 Select  ProcessDate ProcessTimeStartdt, Sum(TotalScheduledduration) TotalofTotalScheduledduration from '+tempTablename+' group by ProcessDate ;');
    Qry.SQL.add('update '+tempTablename+' T inner join '+tempTablename+'1 T1 on ProcessDate = T1.ProcessTimeStartdt Set   T.TotalofTotalScheduledduration = T1.TotalofTotalScheduledduration;');
    Qry.SQL.add('update '+tempTablename+' Set TotalofTotalScheduleddurationFMT = FormatSecondsTotime(TotalofTotalScheduledduration);');
    Qry.SQL.add('Drop table if exists '+tempTablename+'1;');

    Qry.SQL.add('Create table '+tempTablename+'1 Select  ProcessDate ProcessTimeStartdt, Sum(Scheduledduration) ScheduleddurationForDay from '+tempTablename+' group by ProcessDate;');
    Qry.SQL.add('update '+tempTablename+' T inner join '+tempTablename+'1 T1 on ProcessDate = T1.ProcessTimeStartdt Set   T.ScheduleddurationForDay = T1.ScheduleddurationForDay;');
    Qry.SQL.add('update '+tempTablename+' Set ScheduleddurationForDayFMT = FormatSecondsTotime(ScheduleddurationForDay);');
    Qry.SQL.add('Drop table if exists '+tempTablename+'1;');

    Qry.SQL.add('update '+tempTablename+' T Set TotalonDatenDescCaption = concat(' +quotedStr('Total of   ''') +',ResourceName,'+quotedstr('/')+',ProcessDescription,' +Quotedstr('''  :')+');');
    {grand total in a different table}
    tempTablename_Total := tempTablename+'_Total';
    Qry.SQL.add(CreateUserTemporaryTableSQL(tempTablename_Total , 'tmp_productionworksheet_total' ));
    Qry.SQL.add('insert into  '+tempTablename_Total+' (TotalScheduledduration , TotalScheduleddurationFMt) Select Sum(Scheduledduration) TotalScheduledduration , FormatSecondsTotime(Sum(Scheduledduration))  TotalScheduleddurationFMt from '+tempTablename+' ;');
    qry.Execute;

  finally
    qry.Free;
  end;
end;

function ProcessStepInUse(aProcessStepId: integer): boolean;
var
  qry: TERPQuery;
begin
  result:= false;
  qry:= CommonDbLib.TempMyQuery;
  try
    qry.SQL.Add('SELECT pp.Id FROM tblProcessPart pp inner join tblProcTree pt on pp.ProcTreeId = pt.ProcTreeId ');
    qry.SQL.Add('WHERE pp.ProcessStepId =' + IntToStr(aProcessStepId));
    qry.SQL.Add('AND pt.Complete = "F"');
    qry.SQL.Add('AND pt.MasterType <> "mtProduct"');
    qry.Open;
    if not qry.IsEmpty then
      result:= true;
  finally
    qry.Free;
  end;
end;

function ProductionSchedOrStarted(Tree: TProcTreeNode): boolean;
var
  x: integer;
begin
  result:= false;
  if not(Assigned(Tree)) then exit;
  if Assigned(Tree.ProcessStepList) then begin
    for x:= 0 to Tree.ProcessStepList.Count -1 do begin
      if Tree.ProcessStepList[x].Status <> psNotScheduled then begin
        result:= true;
        break;
      end;
    end
  end;

  (*{check if the smart order is converted to PO}
   if not result then begin
    if Tree is TSalesLineProcTree then begin
      With TempMyquery do try
        connection := TSalesLineProcTree(Tree).Storer.connection;
        SQL.add('Select  SOL.SmartOrderLinesID , SOL.converted ' +
                ' from tblsmartOrder SO inner join tblsmartorderlines SOL on SO.SmartOrderID = SOL.SmartOrderID ' +
                ' where SO.SaleOrderID = ' + inttoStr(TSalesLineProcTree(Tree).Sales.ID) +
                ' and SO.SalesGlobalref = ' +quotedstr(TSalesLineProcTree(Tree).Sales.Globalref) +
                // ' and SO.SaleLineRef = ' +Quotedstr(TSalesLineProcTree(Tree).SalesLine.globalref)  +
                ' and SOL.converted = "T"');
        open;
        REsult := Recordcount >0;
      finally
        ClosenFree;
      end;
    end;
  end; *)

  if not result then begin
    for x:= 0 to Tree.Children.Count -1 do begin
      if ProductionSchedOrStarted(TProcTreeNode(Tree.Children[x])) then begin
        result:= true;
        break;
      end;
    end;
  end;
end;

function TreeHasAddToSaleNodes(Tree: TProcTreeNode): boolean;
var
  x: integer;
begin
  result:= Tree.AddToSale;
  if not result then begin
    for x:= 0 to Tree.Children.Count -1 do begin
      if TreeHasAddToSaleNodes(TProcTreeNode(Tree.Children[x])) then begin
        result:= true;
        break;
      end;
    end;
  end;
end;

procedure ClearAllAddToSale(Tree: TProcTreeNode);
var x: integer;
begin
  Tree.AddToSale:= false;
  for x:= 0 to Tree.Children.Count -1 do
    ClearAllAddToSale(TProcTreeNode(Tree.Children[x]));
end;


procedure SetTreeDateRequired(Tree: TProcTreeNode; aDateRequired: TDateTime);
var
  x: integer;
begin
  if Assigned(Tree.ProcTreePart) then
    Tree.ProcTreePart.DateRequired:= aDateRequired;
  for x:= 0 to Tree.Children.Count-1 do
    SetTreeDateRequired(TProcTreeNode(Tree.Children[x]), aDateRequired);
end;

function DoTreeAccountPosting(Tree: TProcTreeNode; Conn: TCustomMyConnection; var msg: string; Description: string; PostingDate:TDateTime = 0): boolean;
var
  Posting: TAccountPosting;
  DeptClassName: string;
  Cost: double;
  Qty: double;
  Desc: string;
  DebitTotal, CreditTotal: double;
  DebitLineId: integer;
  Diff: double;

  function ScanNodes(Node: TProcTreeNode): boolean;
  var
    x: integer;
    s:String;
  function SalesLineInfo:String;
  begin
    With TempMyQuery do try
      SQL.add('Select SaleId, ProductName ,UnitofMeasureQtySold , UnitofMeasureShipped , UnitofMeasureBackorder , concat(UnitofMeasureSaleLines , ''('' , UnitofMeasureMultiplier , '')'') as UOM from tblsaleslines where saleLineId = ' + inttostr(node.saleLineID));
      open;
      if (fieldbyname('unitofmeasureShipped').asFloat =0) and (node.totalQty>0) then
        result := 'The top level tree item in the tree has a ''Non 0 Quantity'' where the Sales Order''s shipped Qty is 0 (Back ordered).'
      else
        result := 'No Process Step assigned to top level tree item ';

      result := result + NL +
                 '                  Sale  : ' + inttostr(fieldByname('SaleID').asInteger )+ NL+
                 '            Product  : ' +FieldByname('Productname').asString +NL +
                 '                 UOM  : ' + FieldByname('UOM').asString +NL +
                 '        Order Qty  : ' + floatTostrf(fieldbyname('UnitofMeasureQtySold').asfloat, fffixed, 15,2) + NL +
                 '     Shipped Qty  : ' + floatTostrf(fieldbyname('UnitofMeasureShipped').asfloat, fffixed, 15,2) + NL +
                 'Back Order Qty  : ' + floatTostrf(fieldbyname('UnitofMeasureBackorder').asfloat, fffixed, 15,2) +NL+NL+
                 'Please Delete and Reselect this product in the Sales Order';
    finally
      if Active then close;
      Free;
    end;
  end;
  begin
    result:= true;
    s:= ReplicateStr('   ' , node.Level) + node.Caption ;
    if Node.IsRoot then begin
      if Assigned(node.ProcTreePart) then begin
        { add value of top level product to inventory asset }
        (*Cost:= Node.Cost;*)Cost:= Node.productunitcost;s:= s+','+  FloatToStr(cost);
        {Binny
        Balancesheet.inventoryAsset was not matching with the Productlist.total of Stock Value as the posting was done on the wrong cost.
        cost of the building product should be calculated from the avg cost of the individual product - not the cost for Quantity}
        (*Cost := Node.ProcTreePart.Product.AverageCost;*)
        qty:= Node.TotalQty - node.ManufacturedQty;
        s:= s +',' +FloatToStr(Qty);
        Desc:= FloatToStr(Qty) + ' x ' + Node.Caption;
        Posting.AddPosting('D',DeptClassName,Node.ProcTreePart.Product.AssetAccount,Round(Cost*Qty,GeneralRoundPlaces),0,Desc , node.partsId, (*Node.ProcTreePart.Product.ProductName , *)node.id (*Node.ProcTreePart.Id*));
        s:= s+ ',0,' + FloatToStr(Round(Cost*Qty,GeneralRoundPlaces));
        DebitLineId:= Posting.Lines.ID;
        DebitTotal:= DebitTotal + Round(Cost*Qty,GeneralRoundPlaces);
          s:= s+ ',' + FloatToStr(CreditTotal) +',' + FloatToStr(DebitTotal);
          //Logtext(s);
      end else if node.totalQty=0 then begin
        //ignore if Qty is 0
        Exit;
      end else begin
        result:= false;
        msg:= NL+NL+ SalesLineInfo ;
        exit;
      end;
    end else begin
      { not root item }
      if ((not Node.IsOption) and (not Node.IsOptionItem)) or (Node.IsOptionItem and Node.Selected) then begin
        if Assigned(node.ProcTreePart) then begin
          {Product's unit cost is used to calculate the total cost as the cost is multiplied by the total Qty to get total cost
          Problem : Betacraft -> Product : M7016-NVY-s, manufacuting 10 was posting cost ofr single finished product's cost}
          (*Cost:= Node.Cost; *)Cost:= Node.ProductUnitCost; s:= s+','+  FloatToStr(cost);
          {Binny
          Balancesheet.inventoryAsset was not matching with the Productlist.total of Stock Value as the posting was done on the wrong cost.
          cost of the building product should eb calculated from the avg cost of the individual product - not the cost for Quantity}
          (*Cost := Node.ProcTreePart.Product.AverageCost;*)
          qty:= Node.TotalQty - Node.ManufacturingQty; s:= s +',' +FloatToStr(Qty);

          (*if Node.IsOptionItem then begin
            Qty:= Node.ParentNode.TotalQty;
          end;*)

          Desc:= FloatToStr(Qty) + ' x ' + Node.Caption;


          if Node.ProcTreePart.ProductID > 0 then begin
            if Qty <> 0 then begin
                    if Node.ProcTreePart.Product.AssetAccount = '' then begin
                      result:= false;
                      msg:= 'Asset Account is missing for product: ' + Node.caption(*Node.ProcTreePart.Product.ProductName*);
                      exit;
                    end else if Node.ProcTreePart.Product.CogsAccount = '' then begin
                      result:= false;
                      msg:= 'COGS Account is missing for product: ' + Node.ProcTreePart.Product.ProductName;
                      exit;
                    end;
                    if Node.ProcTreePart.Product.ProductType = 'INV' then begin
                      Posting.AddPosting('C',DeptClassName,Node.ProcTreePart.Product.AssetAccount,0,Round(Cost*Qty,GeneralRoundPlaces),Desc , node.partsId, (*Node.ProcTreePart.Product.ProductName , *)node.id(*Node.ProcTreePart.ID*));
                    end else begin
                      Posting.AddPosting('C',DeptClassName,Node.ProcTreePart.Product.CogsAccount,0,Round(Cost*Qty,GeneralRoundPlaces),Desc , node.partsId, (*Node.ProcTreePart.Product.ProductName , *)node.id(*Node.ProcTreePart.ID*));
                    end;
                    s:= s+ ',' + FloatToStr(Round(Cost*Qty,GeneralRoundPlaces));
                    CreditTotal:= CreditTotal + Round(Cost*Qty,GeneralRoundPlaces);
            end;

            if (Node.Children.Count >0) and (Node.ManufactureQty>0) then begin
                    //qty:= Node.TotalQty - Node.ManufacturedQty;
                    qty:= Node.ManufactureQty - Node.ManufacturedQty;
                    if qty <> 0 then begin
                      if Node.ProcTreePart.Product.ProductType = 'INV' then begin
                        Posting.AddPosting('D',DeptClassName,Node.ProcTreePart.Product.AssetAccount,Round(Cost*Qty,GeneralRoundPlaces),0,Desc , node.partsId, (*Node.ProcTreePart.Product.ProductName , *)node.id(*Node.ProcTreePart.Id*));
                      end else begin
                        Posting.AddPosting('D',DeptClassName,Node.ProcTreePart.Product.CogsAccount,Round(Cost*Qty,GeneralRoundPlaces),0,Desc , node.partsId, (*Node.ProcTreePart.Product.ProductName , *)node.id(*Node.ProcTreePart.ID*));

                      end;
                      s:= s+ ',' + FloatToStr(Round(Cost*Qty,GeneralRoundPlaces));
                      DebitTotal:= DebitTotal + Round(Cost*Qty,GeneralRoundPlaces);
                    end;
            end else begin
              s:= s+ ',0' ;
            end;

            s:= s+ ',' + FloatToStr(CreditTotal) +',' + FloatToStr(DebitTotal);
          end;
          //Logtext(s);
        end;
      end;

    end;
    for x:= 0 to Node.Children.Count -1 do begin
      if not ScanNodes(TProcTreeNode(Node.Children[x])) then begin
        result:= false;
        break;
      end;
    end;
  end;

begin
  //clog('Caption,cost,Qty,Credit,Debit,credittotal,debittotal');

  result:= false;

  Try
    TAccountPosting.DeletePosting(AccountPostingSource_Manufacturing,Tree.Id, Conn);
    Posting:= TAccountPosting.Create(nil);
    try
      if Assigned(tree.Owner) and Assigned(Tree.Owner.Owner)  and IsClassByString(Tree.Owner.Owner, 'TSalesBase') then
        DeptClassName:= TypInfo.GetWideStrProp(Tree.Owner.Owner,'SaleClassName')
      else
        DeptClassName:= AppEnv.DefaultClass.DefaultClassName;

      DebitTotal:=0;
      CreditTotal:= 0;
      Posting.Connection:= TMyDacDataConnection.Create(Posting);
      Posting.Connection.Connection:= Conn;
      Posting.Connection.BeginNestedTransaction;
      Posting.Load(0);
      Posting.LogChangesOnSave := False;
      Posting.LoadXMLinLoad := False;
      Posting.New;
      Posting.SourceName:= AccountPostingSource_Manufacturing;
      Posting.SourceId:= Tree.Id;
      if PostingDate =0 then Posting.Date:= now else Posting.Date:= PostingDate;
      Posting.EmployeeId:= AppEnv.Employee.EmployeeID;
      Posting.EmployeeName:= AppEnv.Employee.EmployeeName;
      if Description <> '' then
        Posting.Description:= Description;
      Posting.PostDB;
      if ScanNodes(Tree) then begin
        Diff:= CreditTotal - DebitTotal;
        if not Math.IsZero(Diff,0.000001) then begin
          if (DebitLineId > 0) and Posting.Lines.LocateId(DebitLineId) then begin
            Posting.Lines.DebitAmount := Posting.Lines.DebitAmount + Diff;
            DebitTotal := DebitTotal + Diff;
            Posting.Lines.PostDB;
          end;
        end;
      end else begin
        Posting.Connection.RollbackNestedTransaction;
        exit;
      end;
      Posting.ResultStatus.Clear;
      if Posting.ValidateData and Posting.Save then begin
        Posting.Connection.CommitNestedTransaction;
        result:= true;
      end
      else begin
        msg:= Posting.ResultStatus.Messages;
        Posting.Connection.RollbackNestedTransaction;
      end;
    finally
      Freeandnil(Posting);
    end;
    finally
      //if MakeJEforManCOGSDiff then TAccountPosting.MakeJEforManCOGSDiff(AccountPostingSource_Manufacturing,Tree.Id, Conn);
    end;

end;

function DoCompletenconvert(ConfirmQtysOnfinaliseProc: TBusObjProc; SO:TSalesORder;CompleteConverted:Boolean;msg: TStringList;var invID:Integer; ConvertIncomplete: boolean = false; ConvertCurrent:Boolean = False):Boolean;
var
  Tree: TProcTreeNode;

  function AllSaleProductionComplete(aSO: TSalesOrder): boolean;
  begin
    result:= true;
    if ConvertIncomplete or ConvertCurrent  then
      exit;
    aSO.Lines.First;
    while not aSO.Lines.EOF do begin
      Tree:= TProcTreeNode(aSO.Lines.Container.ItemByClass(TProcTreeNode,false));
      if Assigned(Tree) and (Tree.Children.Count > 0) then begin
        if not Tree.AllProcessesComplete then begin
          result:= false;
          msg.Add('Sales Order ' + aSO.docnumber + ' for ' + aSO.CustomerName);
          msg.Add('Could not be finialised as production is not complete for ' +
            aSO.Lines.ProductName);
          exit;
        end;
      end;
      aSO.Lines.Next;
    end;
  end;
  function NodeTotalQty(aproctree : TProctree):Double;
  begin
    if aproctree is TproctreeRoot then result := TproctreeRoot(aproctree).ManufactureduomQty
    else if aproctree.children.count =0 then result := aproctree.ProctreePart.ManufacturingQty
    else REsult := aproctree.ProctreePart.ManufacturingQty;
  end;
  Procedure CompletenconvertProcTreePart(aproctree : TProctree);
  begin
    if SO.IsInternalOrder then begin
     if not ConvertCurrent then exit;
          if aproctree is TproctreeRoot then begin
            if aProctree.ProctreePart.ManufactureUOMQty <> aProctree.ProctreePart.ManufacturedUOMQty then begin
              aProctree.ProctreePart.ManufactureUOMQty := aProctree.ProctreePart.ManufacturedUOMQty;
              try aProctree.ProctreePart.ManufactureQty := aProctree.ProctreePart.ManufactureUOMQty/aProctree.ProctreePart.uommultiplier; except end;
              aProctree.ProctreePart.UOMQty :=aProctree.ProctreePart.ManufactureUOMQty;
              aProctree.ProctreePart.PostDB;// this will update the 'TProcTreePart' In PQA

              SO.Comments := SO.Comments + NL + 'Partial Build Finalised of Qty ' + FloatToStr(aProctree.ProctreePart.UOMQty) ;
              SO.Lines.UOMQtyShipped := aProctree.ProctreePart.UOMQty;
              SO.Lines.PostDB;// this will update the 'TSalesOrderLine' In PQA
            end;
          end else if aproctree.children.count =0 then begin

              aProctree.ProctreePart.UOMQty := aProctree.ProctreePart.ManufacturingUOMQty;
              if aProctree.ProctreePart.FromStockUOMQty > aProctree.ProctreePart.UOMQty then
                aProctree.ProctreePart.FromStockUOMQty := aProctree.ProctreePart.UOMQty;

              if aProctree.ProctreePart.OnOrderUOMQty > aProctree.ProctreePart.UOMQty - aProctree.ProctreePart.FromStockUOMQty then
                aProctree.ProctreePart.OnOrderUOMQty :=  aProctree.ProctreePart.UOMQty - aProctree.ProctreePart.FromStockUOMQty;

              aProctree.ProctreePart.UOMQty :=aProctree.ProctreePart.ManufacturedUOMQty +aProctree.ProctreePart.OnOrderUOMQty  + aProctree.ProctreePart.FromStockUOMQty;
              aProctree.ProctreePart.PostDB; // will delete TProcTreePartOut PQA and so the pqadetails
          end else begin

              if aProctree.ProctreePart.FromStockUOMQty > aProctree.ProctreePart.ManufacturingUOMQty - aProctree.ProctreePart.ManufacturedUOMQty then
                aProctree.ProctreePart.FromStockUOMQty := aProctree.ProctreePart.ManufacturingUOMQty - aProctree.ProctreePart.ManufacturedUOMQty;

              if aProctree.ProctreePart.OnOrderUOMQty > aProctree.ProctreePart.ManufacturingUOMQty - (aProctree.ProctreePart.ManufacturedUOMQty+ aProctree.ProctreePart.FromStockUOMQty) then
                aProctree.ProctreePart.OnOrderUOMQty := aProctree.ProctreePart.ManufacturingUOMQty - (aProctree.ProctreePart.ManufacturedUOMQty+ aProctree.ProctreePart.FromStockUOMQty);
              aProctree.ProctreePart.UOMQty :=aProctree.ProctreePart.ManufacturedUOMQty +aProctree.ProctreePart.OnOrderUOMQty  + aProctree.ProctreePart.FromStockUOMQty;
              aProctree.ProctreePart.PostDB; // will delete TProcTreePartin and TProcTreePartOut PQA and so the pqadetails

          end;
           (* aProctree.ProctreePart.ManufactureQty := aProctree.ProctreePart.ManufacturedQty;
            if aProctree.ProctreePart.FromStockuomqty > NodeTotalQty(aProctree) - aProctree.ProctreePart.ManufactureQty then
              aProctree.ProctreePart.FromStockuomqty := NodeTotalQty(aProctree) - aProctree.ProctreePart.ManufactureQty ;
            if aProctree.ProctreePart.onorderuomqty > NodeTotalQty(aProctree) - (aProctree.ProctreePart.ManufactureQty + aProctree.ProctreePart.FromStockuomqty)  then
              aProctree.ProctreePart.onorderuomqty :=  NodeTotalQty(aProctree) - (aProctree.ProctreePart.ManufactureQty + aProctree.ProctreePart.FromStockuomqty);

            aProctree.ProctreePart.Qty :=NodeTotalQty(aProctree) ;
            aProctree.ProctreePart.PostDB;*)

     (*if aProctree.ProctreePart.PQA.active =False then aProctree.ProctreePart.PQA.Delete;
     if aProctree.ProctreePart.SubNodeManufcaturePQA.active =False then aProctree.ProctreePart.SubNodeManufcaturePQA.Delete;*)

     if aProctree.Children.count =0 then exit;
     aProctree.Children.First;
     While aProctree.Children.EOF = False do begin
      CompletenconvertProcTreePart(aProctree.Children);
      aProctree.Children.NExt;
     end;
    end;
  end;
begin
        SO.InstantiateAllTrees;
        Result:= true;

        if (not SO.Converted) or (SO.Converted and CompleteConverted) then begin
          if SO.HasPPG = false then if Assigned(ConfirmQtysOnfinaliseProc) then ConfirmQtysOnfinaliseProc(SO);
          {1 - check that SO is all complete}
          if AllSaleProductionComplete(SO) then begin
            {2 - Complete production}
            So.ConvertCurrent := ConvertCurrent;
            SO.Connection.BeginNestedTransaction;
            SO.Lines.First;
            while not SO.Lines.EOF do begin
              Tree:= TProcTreeNode(SO.Lines.Container.ItemByClass((*TProcTreeNode*)TSalesLineProcTree,false));
              if Assigned(Tree) and (Tree.Children.Count > 0) then begin
                if not Tree.Complete then begin
                  Tree.CompleteAllProcesses;
                  Tree.Complete:= true;
                  Tree.Savenocheck;
                end;
                if assigned(Tree.ProcTreePart) then begin
                  (*Tree.ProcTreePart.Product.UpdateAvgCosts;
                  Tree.ProcTreePart.Product.UpdateManAvgCosts;*)
                  TProduct.UpdateAvgCosts(Tree.ProcTreePart , Tree.ProcTreePart.Connection , Tree.ProcTreePart.Product.ID);
                  TProduct.UpdateManAvgCosts(Tree.ProcTreePart , Tree.ProcTreePart.Connection , Tree.ProcTreePart.Product.ID);
                  if (Tree.Cost <>0) and (Tree.TreePartUOMQuantity<> 0 ) and (Tree.TreePartUOMMultiplier<> 0) then
                    TProduct.UpdateManLatestCosts(Tree.ProcTreePart, round(Tree.Cost /Tree.TreePartUOMQuantity/Tree.TreePartUOMMultiplier,5)  , Tree.ProcTreePart.PQA.TransDate, Tree.ProcTreePart.connection, Tree.ProcTreePart.Product.ID);
                end;
              end;

              if SO.IsInternalOrder then begin
                { flag PQA lines as not active so they dont show up as so quantity }
                SO.Lines.PQA.Active:= false;
                SO.Lines.PQA.PostDb;
                if ConvertCurrent then begin
                  clog('');
                  CompletenconvertProcTreePart(SO.Lines.Rootproctree );
                end;
              end;
              SO.Lines.Next;
            end;

            DoShowProgressbar(100,'Checking Progress Builds') ;
            try
                SO.Lines.First;
                while not SO.Lines.EOF do begin
                  Tree:= TProcTreeNode(SO.Lines.Container.ItemByClass((*TProcTreeNode*)TSalesLineProcTree,false));
                  SO.Lines.Rootproctree.CompleteallProcprogress;
                  SO.Lines.Next;
                end;
            finally
              DoHideProgressbar;
            end;

            { Save the sales order }
            SO.ResultStatus.Clear;

            if SO.Save then begin
              result:= true;
            end
            else begin
              msg.Add('Sales order ' + SO.OrderNumber + ' for ' + SO.CustomerName);
              msg.Add('Error occured during Save with message: ' + SO.ResultStatus.Messages);
              Result:= false;
            end;
            if Result then begin
                invID:= convertSO(SO);
            end;
          end else begin
            REsult:= False;
          end;
            if Result then
              SO.Connection.CommitNestedTransaction
            else
              SO.Connection.RollbackNestedTransaction;
        end;
end;
function CompleteAndConvertOrders(ConfirmQtysOnfinaliseProc : TBusObjProc; SOList: TIntegerList; Conn: TERPConnection; var msgStr: string; ConvertIncomplete: boolean = false; ConvertCurrent:Boolean = False): boolean;
var
  msg: TStringList;
  SO: TSalesOrder;
  x: Integer;
  ConvertedCount: integer;
  FinalisedCount: integer;
  ProgDlg: TProgressDialog;
  CompleteConverted: boolean;
  CompleteConvertedQuestion: boolean;
  InvID:Integer;
begin
  SO:= TSalesOrder.Create(nil);
  SO.Connection := TMyDacDataConnection.Create(SO);
  SO.Connection.Connection:= Conn;
  SO.SilentMode:= true;
  msg:= TStringList.Create;
  ProgDlg:= TProgressDialog.Create(nil);
  clog('');
  try
    ProgDlg.Caption:= 'Completing Sales Orders ...'; logtext('1');
    ProgDlg.MaxValue:= SOList.Count+1;
    if ProgDlg.MaxValue <10 then ProgDlg.MaxValue := 10;
    ProgDlg.MinValue:= 0;
    ProgDlg.Step:= 1;
    ProgDlg.Execute;
    ProgDlg.StepIt;
    SO.ProgressDialogobj := ProgDlg;
    ConvertedCount:= 0;
    FinalisedCount:= 0;
    CompleteConverted:= false;
    CompleteConvertedQuestion:= false;

    for x:= 0 to SOList.Count-1 do begin
      logtext('2-'+ inttostr(x));
      try
        SO.Load(SOList[x]);
        logtext('3-'+ inttostr(x));
        if SO.Converted then begin
          if not CompleteConvertedQuestion then begin
            CompleteConverted:=
              CommonLib.MessageDlgXP_Vista('One or more Sales Orders have already been converted to an Invoice, ' +
              'do you wish to complete production on these anyway?',mtConfirmation,[mbYes,mbNo],0) = mrYes;
            CompleteConvertedQuestion:= true;
          end;
          if not CompleteConverted then begin
            msg.Add('Sales order ' + SO.OrderNumber + ' for ' + SO.CustomerName);
            msg.Add('Order could not be converted as it has already been converted to an invoice.');
          end
        end;
        logtext('4-'+ inttostr(x));
        if not(SO.LockSOnSOInvoices ) then begin
          msgStr := replacestr(SO.userlock.lockmessage , 'Unable to update data.' , 'Unable to convert Sales Order #' + inttostr(SO.Id) +'.');
          REsult:= False;
          Exit;
        end;
        logtext('5-'+ inttostr(x));
        if docompletenconvert(ConfirmQtysOnfinaliseProc , SO,CompleteConverted , Msg , InvID, ConvertIncomplete , ConvertCurrent) then
          Inc(ConvertedCount);
        logtext('6-'+ inttostr(x));
        Inc(FinalisedCount);logtext('7-'+ inttostr(x));
        ProgDlg.StepIt;
        result:= TRue;
        logtext('8-'+ inttostr(x));
      except
        on e: exception do begin
          logtext('9-'+ inttostr(x));
          msgStr:= 'Conversion of orders failed while processing order: ' + #13#10 +
            SO.OrderNumber + ' for ' + SO.CustomerName + ' with error: ' + #13#10 +
            e.Message;
          result:= false;
          exit;
        end;
      end;
    end;
    if msg.Count > 0 then begin
      logtext('10');
      msg.Insert(0,'');
      msg.Insert(0,IntToStr(ConvertedCount) + ' of a total of ' +
        IntToStr(SOList.Count) + ' Sales Orders converted. ' +
        IntToStr(FinalisedCount) + ' completed.');
      msgStr:= msg.Text;
    end
    else begin
      logtext('11');
      msgStr:= IntToStr(ConvertedCount) + ' of a total of ' +
        IntToStr(SOList.Count) + ' Sales Orders converted. ' +
        IntToStr(FinalisedCount) + ' completed.';
    end;
    result:= True;
    logtext('12');

  finally
    ProgDlg.StepIt; logtext('13');
    SO.ProgressDialogobj := nil;logtext('14');
    ProgDlg.StepIt;logtext('15');
    //SO.Free;
    Freeandnil(SO);logtext('16');
    ProgDlg.StepIt;logtext('17');
    msg.Free;logtext('18');
    try
      ProgDlg.CloseDialog;logtext('19');
      Freeandnil(ProgDlg);logtext('20');
    Except
      // kill the exception
    end;
  end;
end;
function DoconvertSO(SOList: TIntegerList): boolean;
var
    SO: TSalesOrder;
    x:Integer;
begin
  REsult := False;
  SO:= TSalesOrder.Create(nil);
  try
    SO.Connection := TMyDacDataConnection.Create(SO);
    SO.Connection.Connection:= CommonDbLib.GetNewMyDacConnection(SO);
    SO.SilentMode:= true;
    SO.Connection.BeginTransaction;
    try
      for x:= 0 to SOList.Count-1 do begin
            SO.Load(SOList[x]);
            if SO is TSales then TSales(SO).InstantiateAllTrees; // load the trees to copy
            SO.Connection.BeginNestedTransaction;
            try
                convertSO(So);
                SO.Connection.CommitNestedTransaction
            Except
              on E:Exception do begin
                SO.Connection.RollbackNestedTransaction;
              end;
            end;
      end;
      so.Connection.CommitTransaction;
      REsult := true;
    except
        so.Connection.RollbackTransaction;
    end;
  finally
    SO.Free;
  end;
end;

function convertSO(SO:TSalesOrder):Integer;
begin
  REsult:= 0;
    if (not SO.Converted) then begin
      {convert sales order}
      if SO.IsInternalOrder then begin
        SO.Converted:= true;
        SO.PostDb;
        SO.DoconvertInternalOrder;
      end
      else begin
        //REsult:= SO.Copytoinvoice(SO.Id);
      end;
      {need to convert both - internal order will convert non bom products to a zero value invoice }
      REsult:= SO.Copytoinvoice(SO.Id);
    end;
end;
function DoJobComplete(ConfirmQtysOnfinaliseProc: TBusObjProc; SOList: TIntegerList; ConvertIncomplete: boolean; var msg: string): boolean;
var
  conn: TERPConnection;
  fbConvertCurrent :Boolean;
  Function hasPPG:Boolean;
  var
    qry: TERPQuery;
  begin
    Result := False;
    if SOlist.count =0 then exit;

    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection);
    try
      Qry.sql.text := 'Select count(SL.saleLineID) as ctr '+
                      ' from tblSaleslines SL  '+
                      ' inner join tblproctree Pt on SL.saleLineId = PT.masterId and PT.mastertype <> "mtProduct"  '+
                      ' inner join tblprocprogress PPG on PT.proctreEId = PPG.ProcTreeId  '+
                      ' Where SL.saleId in (' + SOList.commatext+')';
      Qry.Open;
      result := Qry.fieldbyname('ctr').asInteger >0;
    finally
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
    end;
  end;
begin
  result:= False;
  conn:= CommonDbLib.GetNewMyDacConnection(nil);
  try
    conn.StartTransaction;
    if not hasPPG then
      fbConvertCurrent :=False
    else
    Case MessageDlgXP_Vista('"Finalise and Convert" Will Complete the Order as It is.'+NL+
                            '"Convert Built Stock" Will Finalise What is Being Built Irrelevant of the Order Quantity.'+NL+
                                          'Do You Wish To Finalise and Convert? ', mtConfirmation, [], 0 , nil , '' , '' , False, nil , 'Finalise and Convert,Convert Built Stock,Cancel') of
          100: fbConvertCurrent :=False;
          101: fbConvertCurrent :=true;
          102: exit;
    End;
    result:= CompleteAndConvertOrders(ConfirmQtysOnfinaliseProc , SOList, conn, msg, ConvertIncomplete , fbConvertCurrent);
    if result then begin
      result:= true;
      conn.Commit;
      (*if msg <> '' then
        CommonLib.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);*)
    end
    else begin
      conn.Rollback;
      (*CommonLib.MessageDlgXP_Vista(msg,mtWarning,[mbOk],0);*)
    end;

  finally
    if conn.InTransaction then
      conn.Rollback;
    conn.Free;
  end;
end;


function SaleContainsManufacturing(const aSaleId: integer; Conn: TCustomMyConnection): boolean;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    qry.Connection:= Conn;
    qry.SQL.Add('select distinct Count(sl.SaleLineId) as LineCount from tblProcTree pt, tblSalesLines sl');
    qry.SQL.Add('where MasterType = "mtSalesOrder" ');
    qry.SQL.Add('and pt.ParentId > 0 and pt.manufactureQty >0');
    qry.SQL.Add('and pt.MasterId = sl.SaleLineId and sl.SaleId = ' + IntToStr(aSaleId));
    qry.Open;
    result:= qry.FieldByName('LineCount').AsInteger > 0;
  finally
    qry.Free;
  end;
end;

end.

